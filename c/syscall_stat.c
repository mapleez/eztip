/*
 * Author : ez
 * Date : 2018/1/15
 * Description : 
 * 	Learn to use system call stat().
 */

#include <unistd.h>
// #include <sys/types.h>
#include <sys/stat.h>

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

static void _disp_stat (struct stat*);

int main (int argc, char* argv []) {

	struct stat* statbuf = (struct stat*)
		malloc (sizeof (*statbuf));
	if (! stat) {
		puts (strerror (errno));
		_exit (0);
	}

	int retval = stat (__FILE__, statbuf);
	if (retval < 0) {
		puts (strerror (errno));
		_exit (0);
	}

	_disp_stat (statbuf);

	free (statbuf);
	_exit (0);
}


static void _disp_stat (struct stat* statbuf) {
	printf ("Device ID = %d\n"
			"Inode number = %d\n"
			"mode_t = %d\n"
			"Number of hard links = %d\n"
			"User ID of owner = %d\n"
			"Group ID of owner = %d\n"
			"Device ID = %d\n"
			"Total size (in bytes) = %d\n"
			"Block size of fs I/O = %d\n"
			"Block count allocated (512B) = %d\n",
			statbuf -> st_dev,
			statbuf -> st_ino,
			statbuf -> st_mode,
			statbuf -> st_nlink,
			statbuf -> st_uid,
			statbuf -> st_gid,
			statbuf -> st_rdev,
			statbuf -> st_size,
			statbuf -> st_blksize,
			statbuf -> st_blocks);
}

