#include <iostream>
#include <fstream>
#include <string>

constexpr int MAX_FILE_SIZE = 128'000'000;

char content[MAX_FILE_SIZE], c;

int main(int argc, char **args) {
    for (int i = 1; i < argc; i++) {
        std::string fileName = args[i];
        std::ifstream inFile(fileName, std::ios::in | std::ios::binary);
        if (!inFile.is_open()) {
            std::cout << "Failed to open " << fileName << " ):" << std::endl;
            continue;
        }
        int x = 0;
        while (inFile >> std::noskipws >> c && x < MAX_FILE_SIZE) {
            content[x++] = c;
        }
        inFile.close();
        std::cout << "Processed " << x << " Bytes" << std::endl;
        std::ofstream outFile(fileName, std::ios::out | std::ios::binary);
        int y = 0;
        while (y < x) {
            outFile << std::noskipws << (char)(content[y++] ^ 'x');
        }
        outFile.close();
    }
    return 0;
}
