#include <iostream>
#include <fstream>

using namespace std;

#define MAX_FILE_SIZE 128'000'000

char content[MAX_FILE_SIZE], c;

int main(int argc, char **args) {
    for (int i = 1; i < argc; i++) {
        const char *fileName = args[i];
        ifstream inFile(fileName, ios::in | ios::binary);
        if (!inFile.is_open()) {
            cout << "Failed to open " << fileName << " ):" << endl;
            continue;
        }
        int x = 0;
        while (inFile >> noskipws >> c && x < MAX_FILE_SIZE) {
            content[x++] = c;
        }
        inFile.close();
        cout << x << " Bytes" << endl;
        ofstream outFile(fileName, ios::out | ios::binary);
        int y = 0;
        while (y < x) {
            outFile << noskipws << (char)(content[y++] ^ 'x');
        }
        outFile.close();
    }
    return 0;
}
