Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119770;
	b=GiE0PH2bwfGnysl+TOmQwugzibDVPpH6ISB5T754yoJbotiMpfoP21n+3LVpLecXfQ14
	 DKRF3Zptc3eToDCo4wkcycn3ZvahdlG2qV0SuzScGNI7+ZM4Tl9A8uvVV+9pjsa8GXvaX
	 wTTh5grVXmUydrdTpnKIg9M5rwuHaJGv2FdSPDFltOR8DIcAx3PzXMrZzbjol/+F0tJi5
	 tklAV4VSx7uE3IMM3y/Aslyvn5pNJUVBsuQ5wpDDKhJpRkPNSkSbJyd2ZlGxRR7/I01IX
	 OIF2AapSf1CG72otzUYEdxX9iCx9IbQRZvGFSimvwRnZqWlATBDefEJ3aZZv3TTyRlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119770;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=fiNi9YOWC3se3NRjXZkZ8C74Hfz/D7btRYlMc5JQx4I=;
	b=fXKNwSE4yK7qtw9Tqg3ZmytWWFMr8gRVKqUgLkgRWO5N6QhvwtPeyIgXadsfxcjurNZ9
	 ly5gktJg0SF3Ff1QXkStOL7XuLqFE61V5wm2zZ6yL6y01bfd1Cbkim/n4Cdryq8aClVAy
	 BalXsC2YZ1QrJatoCUOUG+PfhwL/J0EiEkG7+QFFsFCqvq9QLtqbKcnLHNmYNj1Mu2tHF
	 f976OSXcfI6yGgV0xnJkk8grG8q1IvV4pf/VBEvY+dFSANxaILZKUdKXBf9At/G5MlJap
	 Gb//k4dnz93vqnfooiynydqPoEassdv7cHwZ6MmFy+45YTZDZkCNsxibYjNRSZxHBUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=IXXO+IyH;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033D606A333;
	Thu, 19 Nov 2026 20:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5033D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=IXXO+IyH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=fiNi9YOWC3se3NRjXZkZ8C74Hfz/D7btRYlMc5JQx4I=; t=1795119770; x=2110479770; 
	b=IXXO+IyHtF++mNjTDFa4DC+RRH85Plf8pN6JjHyVNhmxFB/gHzzs7ASraNtz/IoUvsqWxANCEuY
	GuzUfnZYPZjlhiMqHHLvQc/aFE6YHd/NQlMkc8r76jM9CDQKhlyEpxBiziCjZVl8bn0qizmak/G9N
	jrFSt4MVMHWc7ilDxUeQ0YSdsH92fOJ+VeFTAUifrGopfd0ei9Lg1L3rG9vFGEsFro33fGumYvDRw
	gsWsSj5SZOeAGji5xwm9bWNK6a0O2ppxZC1YvlZvby0KuQCPwQRK/4VGV+CmCcVlDwu2bxOuGMP9X
	xgQFgKVZD8bffMIn7GY+8e24ebTyatemivIg==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8ee-00000001cIK-0m83;
	Thu, 19 Nov 2026 21:22:48 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:22:03 -0300
Subject: [PATCH v10 13/16] arm: Reorganize syscall table and separated the
 ABIs
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261119-tonyk-syscall_table-v10-13-a7c9ebd900f6@igalia.com>
References: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
In-Reply-To: <20261119-tonyk-syscall_table-v10-0-a7c9ebd900f6@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
 Magnus Lindholm <linmag7@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

arm has three ABIs: EABI, OABI and OABI with compat (OABIC). Those ABIs
shares almost every syscall, but have a few exceptions: some syscalls only
have an entry point for OABI/C (e.g. sys_alarm), and some syscalls have a
special entry point for OABIC (e.g. sys_oabi_pwrite64).

Currently, the syscall table uses the compat column to specify when such
OABI syscall needs an OABIC entry point. However, this makes tricky to move
arm to use the common syscall table: arm doesn't use the compat entry
points for time64 (e.g. compat_sys_pselect6_time64) and rely on the normal
entry point (e.g. sys_pselect6). Given that the build system will generate
the same __SYSCALL_WITH_COMPAT() macro for the whole table, this would
create inconsistency where some syscalls would point to the wrong entry.

To avoid this problem and prepare the architecture to move to the common
table, separate explicitly the ABIs in the local syscall table and drop all
entries for the compat column. Make sure that __SYSCALL_WITH_COMPAT()
always points to the native option.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
This patch was tested comparing the results of `$ strings
arch/arm/kernel/entry-common.o` before and after this patch.
---
 arch/arm/kernel/entry-common.S |  4 +-
 arch/arm/tools/Makefile        |  1 +
 arch/arm/tools/syscall.tbl     | 84 ++++++++++++++++++++++++++++++++----------
 3 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 88336a1292bb..088317cee039 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -456,8 +456,8 @@ ENDPROC(sys_oabi_readahead)
  */
 	syscall_table_start sys_oabi_call_table
 #undef __SYSCALL_WITH_COMPAT
-#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
-#include <calls-oabi.S>
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#include <calls-oabic.S>
 	syscall_table_end sys_oabi_call_table
 
 #endif
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 28b6da8ac5f6..bc761ef61b76 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -14,6 +14,7 @@ systbl := $(srctree)/scripts/syscalltbl.sh
 syscall := $(src)/syscall.tbl
 
 gen-y := $(gen)/calls-oabi.S
+gen-y += $(gen)/calls-oabic.S
 gen-y += $(gen)/calls-eabi.S
 kapi-hdrs-y := $(kapi)/unistd-nr.h
 kapi-hdrs-y += $(kapi)/mach-types.h
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 55717ed32c27..8e479c445de0 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -26,6 +26,7 @@
 11	common	execve			sys_execve
 12	common	chdir			sys_chdir
 13	oabi	time			sys_time32
+13	oabic	time			sys_time32
 14	common	mknod			sys_mknod
 15	common	chmod			sys_chmod
 16	common	lchown			sys_lchown16
@@ -35,14 +36,18 @@
 20	common	getpid			sys_getpid
 21	common	mount			sys_mount
 22	oabi	umount			sys_oldumount
+22	oabic	umount			sys_oldumount
 23	common	setuid			sys_setuid16
 24	common	getuid			sys_getuid16
 25	oabi	stime			sys_stime32
+25	oabic	stime			sys_stime32
 26	common	ptrace			sys_ptrace
 27	oabi	alarm			sys_alarm
+27	oabic	alarm			sys_alarm
 # 28 was sys_fstat
 29	common	pause			sys_pause
 30	oabi	utime			sys_utime32
+30	oabic	utime			sys_utime32
 # 31 was sys_stty
 # 32 was sys_gtty
 33	common	access			sys_access
@@ -90,12 +95,14 @@
 75	common	setrlimit		sys_setrlimit
 # Back compat 2GB limited rlimit
 76	oabi	getrlimit		sys_old_getrlimit
+76	oabic	getrlimit		sys_old_getrlimit
 77	common	getrusage		sys_getrusage
 78	common	gettimeofday		sys_gettimeofday
 79	common	settimeofday		sys_settimeofday
 80	common	getgroups		sys_getgroups16
 81	common	setgroups		sys_setgroups16
 82	oabi	select			sys_old_select
+82	oabic	select			sys_old_select
 83	common	symlink			sys_symlink
 # 84 was sys_lstat
 85	common	readlink		sys_readlink
@@ -103,7 +110,9 @@
 87	common	swapon			sys_swapon
 88	common	reboot			sys_reboot
 89	oabi	readdir			sys_old_readdir
+89	oabic	readdir			sys_old_readdir
 90	oabi	mmap			sys_old_mmap
+90	oabic	mmap			sys_old_mmap
 91	common	munmap			sys_munmap
 92	common	truncate		sys_truncate
 93	common	ftruncate		sys_ftruncate
@@ -115,7 +124,8 @@
 99	common	statfs			sys_statfs
 100	common	fstatfs			sys_fstatfs
 # 101 was sys_ioperm
-102	oabi	socketcall		sys_socketcall		sys_oabi_socketcall
+102	oabi	socketcall		sys_socketcall
+102	oabic	socketcall		sys_oabi_socketcall
 103	common	syslog			sys_syslog
 104	common	setitimer		sys_setitimer
 105	common	getitimer		sys_getitimer
@@ -128,10 +138,12 @@
 # 112 was sys_idle
 # syscall to call a syscall!
 113	oabi	syscall			sys_syscall
+113	oabic	syscall			sys_syscall
 114	common	wait4			sys_wait4
 115	common	swapoff			sys_swapoff
 116	common	sysinfo			sys_sysinfo
-117	oabi	ipc			sys_ipc			sys_oabi_ipc
+117	oabi	ipc			sys_ipc
+117	oabic	ipc			sys_oabi_ipc
 118	common	fsync			sys_fsync
 119	common	sigreturn		sys_sigreturn_wrapper
 120	common	clone			sys_clone
@@ -194,8 +206,12 @@
 177	common	rt_sigtimedwait		sys_rt_sigtimedwait_time32
 178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo
 179	common	rt_sigsuspend		sys_rt_sigsuspend
-180	common	pread64			sys_pread64		sys_oabi_pread64
-181	common	pwrite64		sys_pwrite64		sys_oabi_pwrite64
+180	eabi	pread64			sys_pread64
+180	oabi	pread64			sys_pread64
+180	oabic	pread64			sys_oabi_pread64
+181	eabi	pwrite64		sys_pwrite64
+181	oabi	pwrite64		sys_pwrite64
+181	oabic	pwrite64		sys_oabi_pwrite64
 182	common	chown			sys_chown16
 183	common	getcwd			sys_getcwd
 184	common	capget			sys_capget
@@ -208,11 +224,21 @@
 # SuS compliant getrlimit
 191	common	ugetrlimit		sys_getrlimit
 192	common	mmap2			sys_mmap2
-193	common	truncate64		sys_truncate64		sys_oabi_truncate64
-194	common	ftruncate64		sys_ftruncate64		sys_oabi_ftruncate64
-195	common	stat64			sys_stat64		sys_oabi_stat64
-196	common	lstat64			sys_lstat64		sys_oabi_lstat64
-197	common	fstat64			sys_fstat64		sys_oabi_fstat64
+193	eabi	truncate64		sys_truncate64
+193	oabi	truncate64		sys_truncate64
+193	oabic	truncate64		sys_oabi_truncate64
+194	eabi	ftruncate64		sys_ftruncate64
+194	oabi	ftruncate64		sys_ftruncate64
+194	oabic	ftruncate64		sys_oabi_ftruncate64
+195	eabi	stat64			sys_stat64
+195	oabi	stat64			sys_stat64
+195	oabic	stat64			sys_oabi_stat64
+196	eabi	lstat64			sys_lstat64
+196	oabi	lstat64			sys_lstat64
+196	oabic	lstat64			sys_oabi_lstat64
+197	eabi	fstat64			sys_fstat64
+197	oabi	fstat64			sys_fstat64
+197	oabic	fstat64			sys_oabi_fstat64
 198	common	lchown32		sys_lchown
 199	common	getuid32		sys_getuid
 200	common	getgid32		sys_getgid
@@ -236,11 +262,15 @@
 218	common	pivot_root		sys_pivot_root
 219	common	mincore			sys_mincore
 220	common	madvise			sys_madvise
-221	common	fcntl64			sys_fcntl64		sys_oabi_fcntl64
+221	oabi	fcntl64			sys_fcntl64
+221	eabi	fcntl64			sys_fcntl64
+221	oabic	fcntl64			sys_oabi_fcntl64
 # 222 for tux
 # 223 is unused
 224	common	gettid			sys_gettid
-225	common	readahead		sys_readahead		sys_oabi_readahead
+225	oabi	readahead		sys_readahead
+225	eabi	readahead		sys_readahead
+225	oabic	readahead		sys_oabi_readahead
 226	common	setxattr		sys_setxattr
 227	common	lsetxattr		sys_lsetxattr
 228	common	fsetxattr		sys_fsetxattr
@@ -266,7 +296,9 @@
 248	common	exit_group		sys_exit_group
 249	common	lookup_dcookie		sys_ni_syscall
 250	common	epoll_create		sys_epoll_create
-251	common	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
+251	oabi	epoll_ctl		sys_epoll_ctl
+251	eabi	epoll_ctl		sys_epoll_ctl
+251	oabic	epoll_ctl		sys_oabi_epoll_ctl
 252	common	epoll_wait		sys_epoll_wait
 253	common	remap_file_pages	sys_remap_file_pages
 # 254 for set_thread_area
@@ -297,23 +329,33 @@
 279	common	mq_getsetattr		sys_mq_getsetattr
 280	common	waitid			sys_waitid
 281	common	socket			sys_socket
-282	common	bind			sys_bind		sys_oabi_bind
-283	common	connect			sys_connect		sys_oabi_connect
+282	eabi	bind			sys_bind
+282	oabi	bind			sys_bind
+282	oabic	bind			sys_oabi_bind
+283	eabi	connect			sys_connect
+283	oabi	connect			sys_connect
+283	oabic	connect			sys_oabi_connect
 284	common	listen			sys_listen
 285	common	accept			sys_accept
 286	common	getsockname		sys_getsockname
 287	common	getpeername		sys_getpeername
 288	common	socketpair		sys_socketpair
 289	common	send			sys_send
-290	common	sendto			sys_sendto		sys_oabi_sendto
+290	eabi	sendto			sys_sendto
+290	oabi	sendto			sys_sendto
+290	oabic	sendto			sys_oabi_sendto
 291	common	recv			sys_recv
 292	common	recvfrom		sys_recvfrom
 293	common	shutdown		sys_shutdown
 294	common	setsockopt		sys_setsockopt
 295	common	getsockopt		sys_getsockopt
-296	common	sendmsg			sys_sendmsg		sys_oabi_sendmsg
+296	eabi	sendmsg			sys_sendmsg
+296	oabi	sendmsg			sys_sendmsg
+296	oabic	sendmsg			sys_oabi_sendmsg
 297	common	recvmsg			sys_recvmsg
-298	common	semop			sys_semop		sys_oabi_semop
+298	eabi	semop			sys_semop
+298	oabi	semop			sys_semop
+298	oabic	semop			sys_oabi_semop
 299	common	semget			sys_semget
 300	common	semctl			sys_old_semctl
 301	common	msgsnd			sys_msgsnd
@@ -327,7 +369,9 @@
 309	common	add_key			sys_add_key
 310	common	request_key		sys_request_key
 311	common	keyctl			sys_keyctl
-312	common	semtimedop		sys_semtimedop_time32	sys_oabi_semtimedop
+312	eabi	semtimedop		sys_semtimedop_time32
+312	oabi	semtimedop		sys_semtimedop_time32
+312	oabic	semtimedop		sys_oabi_semtimedop
 313	common	vserver
 314	common	ioprio_set		sys_ioprio_set
 315	common	ioprio_get		sys_ioprio_get
@@ -342,7 +386,9 @@
 324	common	mknodat			sys_mknodat
 325	common	fchownat		sys_fchownat
 326	common	futimesat		sys_futimesat_time32
-327	common	fstatat64		sys_fstatat64		sys_oabi_fstatat64
+327	eabi	fstatat64		sys_fstatat64
+327	oabi	fstatat64		sys_fstatat64
+327	oabic	fstatat64		sys_oabi_fstatat64
 328	common	unlinkat		sys_unlinkat
 329	common	renameat		sys_renameat
 330	common	linkat			sys_linkat

-- 
2.56.1

