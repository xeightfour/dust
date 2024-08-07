#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

bool streamFromFile(stringstream &strStream, const string &fileName) {
    ifstream file(fileName, ios::binary);
    if (!file.is_open()) {
        file.close(); // Just in case(:
        return false;
    }
    strStream << file.rdbuf();
    file.close();
    return true;
}

void manipulate(stringstream &strStream) {
    string content = strStream.str();
    for (char &c : content) {
        c ^= 'x';
    }
    strStream.str(content);
}

void fileFromStream(const string &fileName, stringstream &strStream) {
    ofstream file(fileName, ios::binary);
    file << strStream.str();
    file.close();
}

void freak(const string fileName) {
    cout << "Cracking " << fileName << endl;
    stringstream strStream;
    if (!streamFromFile(strStream, fileName)) {
        cerr << "[ERROR] File " << __FILE__ << ", line " << __LINE__ << ",\n\tFailed to open " << fileName << endl;
        return;
    }
    manipulate(strStream);
    fileFromStream(fileName, strStream);
    cout << "Processed " << strStream.str().size() << " bytes from " << fileName << endl;
}

int main(int argc, char **args) {
    for (int i = 1; i < argc; i++) {
        freak(args[i]);
    }
    return 0;
}
