/*
 * Author : ez
 * Date : 2018/1/12
 * Description : 
 * 	Using dup() to copy STDOUT fd;
 * 	Using dup2() to redirect STDOUT to an opened file.
 */
#include <unistd.h>

// #include <sys/types.h>
// #include <sys/stat.h>
#include <fcntl.h>

#include <stdio.h>
#include <errno.h>


static void _write2stdout ();
static void _write2file ();

#	define FILE_NAME "./fout.dat"

/* Copy a new file descriptor for 
 * STDOUT and try writing. */
static void _write2stdout () {
	int newfd = dup (STDOUT_FILENO);
	int wt_len = 0;
	if (0 > newfd) {
		puts ("Error in duplicating STDOUT_FILENO.\n");
		_exit (errno);
	}

	wt_len = write (newfd, "->Newfd\n", 8);
	if (wt_len <= 0) puts ("Error in writing files.\n");

	write (STDOUT_FILENO, "->Newfd\n", 8);

	/* Close new file descriptor */
	close (newfd);

	write (STDOUT_FILENO, "->Newfd\n", 8);
}

/* Try to redirect an opened file descriptor
 * to STDOUT_FILENO.
 */
static void _write2file () {
	int newfd = open (FILE_NAME, 
			O_WRONLY | O_CREAT | O_TRUNC,
			S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

	/* Error in opening file. */
	if (0 > newfd) {
		puts ("Error in opening " FILE_NAME ".\n");
		_exit (errno);
	}

	/* Close STDOUT sliently by dup2() */
	int fd = dup2 (newfd, STDOUT_FILENO);
	if (fd < 0 || fd != STDOUT_FILENO) {
		puts ("Error in redirecting " FILE_NAME " to STDOUT_FILENO.\n");
		_exit (errno);
	}

	/* Close original file descriptor. 
	 * We can use STDOUT_FILENO as this
	 * fd blow! */
	close (newfd);

	dprintf (STDOUT_FILENO, "Hello! This is src file %s, line %d\n"
				"Fd %d has been opened correctly.\n",
				__FILE__,
				__LINE__,
				fd
			);
}

int main (int argc, char* argv []) {

	_write2file ();

	return 0;
}

