#!/usr/bin/env perl

use 5.040;

my $key = 'x';

foreach (@ARGV) {
	open my $in, '<:raw', $_ or die "Can't open $_";
	binmode $in;
	my $data = '';
	my $bytes = read $in, $data, 128_000_000;
	close $in;

	$data ^.= $key x $bytes;

	open my $out, '>:raw', $_ or die "Can't write to $_";
	binmode $out;
	print $out $data;
	close $out;

	print "Processed $bytes bytes from $_\n";
}
