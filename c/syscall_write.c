#include <unistd.h>
#include <fcntl.h> 
#include <errno.h> 
#	define FILE_NAME   "./ez.tmp"

static int _open_file ();
static int _write_byte (int, char);
static int _write_bytes (int, char*, size_t);

static int _open_file () {
	int fd = open (FILE_NAME, O_WRONLY | O_CREAT | O_TRUNC);
	if (-1 == fd) _exit (0);
	return fd;
}

static int _write_byte (int fd, char c) {
	if (-1 == fd) return 0;
	return write (fd, &c, 1);
}

static int _write_bytes (int fd, char* buf, size_t len) {
	if (-1 == fd) return 0;
	return write (fd, buf, len);
}


int main (int argc, char* argv []) {
	const char* string = "Initially intended for use inside the Bell System, AT&T licensed Unix to outside parties from the late 1970s, leading to a variety of both academic and commercial variants of Unix from vendors such as the University of California, Berkeley (BSD), Microsoft (Xenix), IBM (AIX) and Sun Microsystems (Solaris)";

	char* p = string;
	int fd = _open_file ();
	size_t str_len = 0;

	/* Call write() once per byte,
	 * This approach spends more time than 
	 * writing a block data once. */
	do {
		// _write_byte (fd, *p);
		++ str_len;
	} while (*(++ p));

	_write_bytes (fd, string, str_len);

	return 0;
}


