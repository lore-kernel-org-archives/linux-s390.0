From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 28 Feb 2015 21:24:58 +0000
Subject: sigsegv/sigbus not setting si_addr correctly for insn faults
Message-Id: <20150228212458.GV29461@vapier>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--gBii9oQw/U9UOygZ"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--gBii9oQw/U9UOygZ
Content-Type: multipart/mixed; boundary="/T5g/TLNXpBPJeG6"
Content-Disposition: inline


--/T5g/TLNXpBPJeG6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

when running strace tests, we noticed that si_addr appears to be wrong.  th=
e=20
attached test shows the problem -- si_addr isn't set to the faulting addres=
s.

i hacked arch/s390/mm/fault.c:do_sigsegv to load regs->psw.addr (sans mask),
and it worked for insn based crashes.  but obviously that doesn't work for
data based ones.  i'm not familiar with how regs->int_parm_long works thoug=
h,
so maybe it's supposed to be loaded indirectly.  the use of __FAIL_ADDR_MASK
blindly is most certainly incorrect ...

whatever the fix, do_sigbus probably needs it too.

on x86_64, both work:
$ gcc test.c -O3
$ ./a.out=20
data crash
received signal 11
si_addr 0xa0
crasher 0xa0
PASS
$ ./a.out asdf
text crash
received signal 11
si_addr 0xa0
crasher 0xa0
PASS

on s390 both fail:
$ gcc test.c -O3
$ ./a.out=20
data crash
received signal 11
si_addr (nil)
crasher 0xa0
FAIL
$ ./a.out asdf
text crash
received signal 11
si_addr (nil)
crasher 0xa0
FAIL

-mike

--/T5g/TLNXpBPJeG6
Content-Type: text/x-c; charset=utf-8
Content-Disposition: attachment; filename="pc.c"

#include <inttypes.h>
#include <signal.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

static bool text = true;

union {
	void (*fn)(void);
	uintptr_t ptr;
} crasher;
static int *ptr;

__attribute__((__noinline__))
void crashit(void)
{
	if (text) {
		crasher.ptr = 0xA0;
		crasher.fn();
	} else {
		ptr = (void *)0xA0;
		*ptr = 1;
	}
}

void sigcatcher(int signum, siginfo_t *siginfo, void *ucontext)
{
	printf("received signal %i\n", signum);
	if (signum != SIGSEGV) {
		puts("FAIL (not SIGSEGV)");
		exit(2);
	}
	printf("si_addr %p\n", siginfo->si_addr);

	bool passed;
	if (text) {
		printf("crasher %p\n", crasher.fn);
		passed = (crasher.ptr == (uintptr_t)siginfo->si_addr);
	} else {
		printf("crasher %p\n", ptr);
		passed = (ptr == siginfo->si_addr);
	}

	if (passed) {
		puts("PASS");
		exit(0);
	} else {
		puts("FAIL");
		exit(1);
	}
}

int main(int argc, char *argv[])
{
	struct sigaction sa;
	sa.sa_flags = SA_RESTART | SA_SIGINFO;
	sa.sa_sigaction = sigcatcher;
	sigaction(SIGSEGV, &sa, NULL);

	text = argc > 1 ? true : false;
	puts(text ? "text crash" : "data crash");
	crashit();
	return 10;
}

--/T5g/TLNXpBPJeG6--

--gBii9oQw/U9UOygZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU8jIqAAoJEEFjO5/oN/WBKNUQAKiVJyEg9+DWJBhFv0NecahI
OBtD8s+Nobh6o36QYTdN2Gs3bRoSzahvdkelTkuROeuK5vJS6PB5WZdsuJSNIRsv
4rJbKf6HyWLHOYH63fIA7cPPXAsZ2HmusNl5yrGPYAoDxNFREln5wXi4gl17XQdA
36f+LP9sn/3UtQZylKADkdgfgN9op9vBixSTyHtLq+X0bvpzkjTKLPbo7Glf85If
28jsSHy3RMUq7Mbxl2pZDFk4EvtknGFkL4MfKkGm8xEFhMAWYorqlKgypVbHvFWE
ztJ/PlHCdm4boEnU2gq8Z3RKWmQAIBEPXNQPbe2EmyisHYpOlIwGgZbI4GWFv2Zp
BSgx/GzYWtoGsDYc0xAW8rOVMHUntfoAXCYKMjEAi5U0E3R9qG/D0LIzlF6XUsWl
t39X+jYUxEDQSUAxe49oZEZfJKGTh64f6Lbm8X0gP53LuFl20KjZYr0HJ45BoxfJ
A/aEYPP9/g/n04iCRYMxFUr8TRNHmeF0DJOMroNk1647hyqD1aq0ejbO2ajBiXL6
5484PnwSqOJU7D31v3ttFbXbdOrn1Q4zhZOqRnyRNoBoGPB+XbBm1IkDvxzuInM4
CoPNWUcmXAq+JC5wUQ2sOmA1j6A4XUPVMJN3SQRZUjqLf5eF20lCbcI3TVYjXSf5
tx3Zyf4676bQVGH5jZf1
=8R3Q
-----END PGP SIGNATURE-----

--gBii9oQw/U9UOygZ--
