#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>

void test_vargs (const char* format, ...) {
	va_list args;
	va_start (args, format);
	vprintf (format, args);
	va_end (args);
}

int main (int argc, char* argv []) {
	test_vargs ("nfkeanfkleanklfnewakl");
	return 0;
}
