#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "colorprintf.h"

#ifdef FILE_NAME
#	undef FILE_NAME
#endif

#	define FILE_NAME  "./syscall_open.c"
#	define BUFF_SIZE  1024

int main (int argc, char* argv []) {

	int fd = -1, read_len = -1;
	char buffer [BUFF_SIZE] = {0, };
 	/* terminated with zero charactor. */
	buffer [BUFF_SIZE - 1] = '\0';

	fd = open (FILE_NAME, O_RDONLY);
	if (-1 == fd) {
	 	printf ("Error string: %s\n", strerror (errno));
		printf ("Error in opening file " FILE_NAME ": %d\n", errno);
		exit (1);
	}

	read_len = read (fd, buffer, BUFF_SIZE - 1);
	if (-1 == read_len) {
		printf ("Error in opening file " FILE_NAME ": %d\n", errno);
	 	printf ("Error in reading file " FILE_NAME ": %d\n", errno);
		exit (1);
	}

	printf ("Reading %d bytes, contents:\n", read_len);
	colorprintf (1, "%s", buffer);

	/* Close file descriptor */
	close (fd);

	return 0;
}

