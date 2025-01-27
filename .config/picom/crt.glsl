#version 430
#define PI 3.1415926538

// General settings
uniform float op; // Opacity
uniform float t; // Time

// Scanline settings
uniform float sf = 0.6; // Scanline frequency
uniform float si = 0.2; // Scanline intensity
uniform bool gd = false; // Grid on x-axis

// Distortion settings
uniform int doff = 2; // Distortion offset
uniform int dsf = 2; // Downscale factor

// Curvature settings
uniform float sdist = 500; // Sphere distance for curvature
uniform float curv = 0.01; // Curvature amount

// Shadow settings
uniform float scut = 0.88; // Shadow cutoff
uniform int sint = 1; // Shadow intensity (1-5)

// Color and effects
vec4 outCol = vec4(0, 0, 0, op); // Outside color
float fspeed = 0; // Flashing speed
float fint = 0.8; // Flashing intensity

in vec2 texcoord; // Texture coordinate
uniform sampler2D tex; // Texture

ivec2 winSize = textureSize(tex, 0);
ivec2 winCenter = ivec2(winSize.x / 2, winSize.y / 2);
float rad = winSize.x / curv;
int flash = int(round(fspeed * t / (10000 / winSize.y))) % winSize.y;

vec4 default_post_processing(vec4 col);

vec4 darken(vec4 col, vec2 coords) {
	if (sint == 0) {
		return col;
	}

	vec2 dist = abs(winCenter - coords);
	float bright = 1;
	bright *= -pow((dist.y / winCenter.y) * scut, (5 / sint) * 2) + 1;
	bright *= -pow((dist.x / winCenter.x) * scut, (5 / sint) * 2) + 1;
	col.xyz *= bright;

	return col;
}

ivec2 curveCoords(vec2 coords) {
	coords -= winCenter;
	vec2 curved;

	vec3 proj = vec3(coords.x, coords.y, sqrt(pow(rad + sdist, 2) - pow(coords.x, 2) - pow(coords.y, 2)));
	proj *= ((rad + sdist) / proj.z);
	curved = proj.xy + winCenter;

	return ivec2(curved);
}

vec4 getPix(vec2 coords) {
	if (coords.x >= winSize.x - 1 || coords.y >= winSize.y - 1 || coords.x <= 0 || coords.y <= 0) {
		return outCol;
	}

	return default_post_processing(texelFetch(tex, ivec2(coords), 0));
}

vec4 getBlockCol(vec2 coords) {
	if (dsf < 2) {
		return getPix(coords);
	}

	ivec2 relPos = ivec2(coords) % dsf;
	vec4 avg = vec4(0);

	for (int i = 0; i < dsf; i++) {
		for (int j = 0; j < dsf; j++) {
			avg += getPix(vec2(coords.x + i - relPos.x, coords.y + j - relPos.y));
		}
	}
	avg /= pow(dsf, 2);

	return avg;
}

vec4 window_shader() {
	vec2 curvedCoords = curveCoords(texcoord);
	vec4 col = getBlockCol(curvedCoords);
	vec4 colR = getBlockCol(vec2(curvedCoords.x + doff, curvedCoords.y));
	vec4 colL = getBlockCol(vec2(curvedCoords.x - doff, curvedCoords.y));
	col = vec4(colL.r, col.g, colR.b, col.a);

	col.rgb *= sin(2 * PI * sf * texcoord.y) / (2 / si) + 1 - si / 2;

	if (gd) {
		col.rgb *= sin(2 * PI * sf * texcoord.x) / (2 / si) + 1 - si / 2;
	}

	if (curvedCoords.y >= flash - (winSize.y / 10) && curvedCoords.y <= flash) {
		col.rgb *= fint * (pow(((flash - curvedCoords.y) / (winSize.y / 10)) - 1, 2) + 1 / fint);
	}

	col = darken(col, curvedCoords);
	return col;
}
