#include <iostream>

using namespace std;

double sin(int x, int steps = 10) {
    double y = x;
    double quotient = x;

    for (int k = 2; k <= steps; k++) {
        quotient *= (double) x * x / (2 * (k - 1)) / (2 * k - 1);
        if (k % 2 == 0) {
            y -= quotient;
        } else {
            y += quotient;
        }
    }

    return y;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        throw runtime_error("Sine argument expected");
    }

    int x = atoi(argv[1]);
    cout << sin(x, 700'000'000) << '\n';
}
