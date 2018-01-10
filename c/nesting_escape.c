#include <stdio.h>

int main (int argc, char* argv []) {

	char* format = "%s, %s, %s, %s\n";
	char* s1 = "this is %d d\n";
	char* s2 = "this is %s sentense.\n";
	char* s3 = "this is sentense won't construe!\n";
	char* s4 = "ok! you are right!\n";
	char* nesting = "shit! %s %d %d, Look this!%d %s\n";

	/* Ok! */
	printf (format, s1, s2, s3, s4);

	/* Wrong! */
	printf (s1);
	printf (s2);
	printf (s3);
	printf (s4);
	// printf (nesting); /* Segment fault. */

	return 0;
}
