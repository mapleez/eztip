/*
 * Author : ez
 * Date : 2018/1/10
 * Description : Calculate intergration for user-defined function.
 */

#include <stdlib.h>
#include <stdio.h>

typedef double (*function) (double);

static double intergration (double, double, function);
double _intergration (double, double, function, int);

static double intergration (double a, double b, function func) {
	return _intergration (a, b, func, 10000000);
}

double _intergration (double a, double b, function func, int split) {
	double delta = (b - a) / split;
	double sum = 0;
	
	while (split --) {
		sum += func (a) * delta;
		a += delta;
	}

	return sum;
}

/* A simple user-defined math function. */
double _func (double x) {
	return (3 * x + 1);
}

/* Example usage. */
int main (int argc, char* argv []) {
	// range of [2.0, 3.0] for function y=3x+1
	double res = intergration (2, 3, _func);
	printf ("%f\n", res);
	return 0;
}


