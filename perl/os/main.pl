#!/usr/bin/perl

# author : ez
# date : 2015/12/22
# describe : testing for all dispatcher and process model.

use strict;
use warnings;

use Ezdispatcher;
use Ezproc2;

use Ezdispatcher5;
use Ezproc5;

{
	# init all proc
	my $proc1 = Ezproc2 -> new2 ("proc1", "init");
	push @Ezdispatcher::proc_list, $proc1;
	
	my $proc2 = Ezproc2 -> new2 ("proc2", "/bin/kernel");
	push @Ezdispatcher::proc_list, $proc2;
	
	my $proc3 = Ezproc2 -> new2 ("proc3", "/bin/service");
	push @Ezdispatcher::proc_list, $proc3;
	
	my $proc4 = Ezproc2 -> new2 ("proc4", "/usr/bin/perl");
	push @Ezdispatcher::proc_list, $proc4;
	
	my $proc5 = Ezproc2 -> new2 ("proc5", "/usr/bin/javac");
	push @Ezdispatcher::proc_list, $proc5;
	
	# dispatching	
# &Ezdispatcher::dispatching ();
}


{
	&Ezdispatcher5::regist (
		Ezproc5 -> new ("proc1", "init"),
		Ezproc5 -> new ("proc2", "/bin/kernel"),
		Ezproc5 -> new ("proc3", "/bin/service"),
		Ezproc5 -> new ("proc4", "/usr/bin/perl"),
		Ezproc5 -> new ("proc5", "/usr/bin/javac")
	);

	&Ezdispatcher5::dispatching ();
}

__END__

