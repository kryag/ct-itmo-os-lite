#include <iostream>
#include <fstream>

using namespace std;

const int COUNT_NUMBERS = 4'300'000;

int main(int argc, char* argv[]) {
    if (argc != 2) {
        throw runtime_error("File number expected");
    }

    string file = "file" + string(argv[1]);
    ifstream input(file);
    ofstream output(file, fstream::app);

    for (int i = 0; i < COUNT_NUMBERS; i++) {
        int num;
        input >> num;
        output << num * 2 << ' ';
    }
}
