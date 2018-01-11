/*
 * Author : ez
 * Date : 2018/1/11
 * Description : Read NONCE device and get random 
 *   integers.
 */
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

#include <errno.h>

#	define BUFF_LEN 1024
#	define NONCE_DEVICE "/dev/urandom"

static int _open_random_dev ();
static int _read_random_dev (int, char*, int);
static int _generate_random (char*, int);

int main (int argc, char* argv []) {
	int rand_num = 0;
	int count = 1000;

	char buff [BUFF_LEN] = {0, };
	int fd = _open_random_dev ();

	while (count --) {
		int read_len = _read_random_dev (fd, buff, BUFF_LEN);
		rand_num = _generate_random (buff, read_len);

		printf ("random num = %d\n", rand_num);
	}

	if (close (fd)) {
		printf ("Error in closing file\n");
		_exit (errno);
	}

	return 0;
}

static int _open_random_dev () {
	int fd = open (NONCE_DEVICE, O_RDONLY);
	if (-1 == fd) _exit (errno);

	return fd;
}

static int _read_random_dev (int fd, char* buff, int len) {
	return read (fd, buff, len);
}

static int _generate_random (char* buff, int len) {
	if (len == -1) return -1;
	
	int x = 0;
	x = *((int*) buff);

	return x;
}

