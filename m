From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 09 Nov 2015 12:15:38 +0000
Subject: [PATCH] libseccomp: update s390/s390x system call tables
Message-Id: <1447071339-36522-1-git-send-email-heiko.carstens@de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Paul,

just a small patch that updates the s390 specific system call tables for
libseccomp, since there were quite some changes for 4.3.
Hopefully I didn't screw up anything :)

'make check' works if new kernel headers are installed on the system.
Otherwise e.g. tests/15-basic-resolver.c will fail because the new
__NR_socket won't match the system call tables on s390:

src/arch-s390x-syscalls.c:
const struct arch_syscall_def s390x_syscall_table[] = {
[...]
	{ "socket", 359 },
[...]

include/seccomp.h.in:
#define __PNR_socket		-101
#ifndef __NR_socket
#define __NR_socket		__PNR_socket
#endif /* __NR_socket */

tests/15-basic-resolver.c:
	if (seccomp_syscall_resolve_name("socket") != __NR_socket)
		goto fail;

However I assume that's just how libseccomp should work, and therefore
it is a requirement to install the latest kernel headers(?)

Thanks,
Heiko

Heiko Carstens (1):
  arch: update s390/s390x system call tables

 include/seccomp.h.in          | 20 +++++++++++++
 src/arch-aarch64-syscalls.c   |  4 +++
 src/arch-arm-syscalls.c       |  4 +++
 src/arch-mips-syscalls.c      |  4 +++
 src/arch-mips64-syscalls.c    |  4 +++
 src/arch-mips64n32-syscalls.c |  4 +++
 src/arch-ppc-syscalls.c       |  4 +++
 src/arch-ppc64-syscalls.c     |  4 +++
 src/arch-s390-syscalls.c      | 68 +++++++++++++++++++++++--------------------
 src/arch-s390x-syscalls.c     | 66 +++++++++++++++++++++--------------------
 src/arch-x32-syscalls.c       |  4 +++
 src/arch-x86-syscalls.c       |  4 +++
 src/arch-x86_64-syscalls.c    |  4 +++
 13 files changed, 131 insertions(+), 63 deletions(-)

-- 
2.3.9
