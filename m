Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119786;
	b=xnZnoJK3O6RzTsd+rcnrqSwYmYw9iVxlw06xJEfN3f2WtqPGbHZ+VsIAL0KXo+qY9fKR
	 FuP2cSLEMPUVkZVtx4Oj36hyAIFqz77La712BQdOVJRgytyj2I9z89xskmkquemw/AdII
	 kyEflgL70ryl/JEkMggInR+pUpTDFRjGlEbQrEHGwdUVRW9kEcupw6KsE6f0x1px4Iodp
	 8CpCZG1eJRP4mR/BSnOOgVHJIvE87SsUlyEljiZDit7Aq+G9lCHiRly5gXPE+Lz2NuQm3
	 Xm4me/OFw+Jh6b0RCDA3I3/1QkWJtzFgIkg05c0Xhe8g7lWfHuXOBe2pjFHxFF7J1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119786;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=gtCmVptxwUbYOErxj0VjRwOhK0Y6ksvPD2hqXQYtTl4=;
	b=c9NKg34DlueyTpXAPSqt4ZeYvrTKrXWuaIZLWbRu0Cyd6J+AEqp9sbcKrwUjXrp8iDg1
	 Fl3AVuhRyKoOqPPGfqz1q2HpIO62/iou2j31hu/Us4h9dsNEpPKlyx0kR6jNOL7tBUiqG
	 AxkmrS7+CCkUUewDFDod71gvzUONGXEfyxi9Pqxc1W7ti8i1y/r0paBNfg8ijo2RqUgUz
	 o5ucd/zDM+r4Xa1WV1n8re5bo6kVpZRRwuxY+wTFJ+mnUrtIkEfl6roUkjD+tLhVowimk
	 1AK6c/oDJYxBHa3ZUsgB+WiSXdS7nPMW0JB+S3GiTs3MwY2g0KyOAKD0pQlGIIDzgtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=SB3LgETI;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053E6072FB0;
	Thu, 19 Nov 2026 20:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B053E6072FB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=SB3LgETI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=gtCmVptxwUbYOErxj0VjRwOhK0Y6ksvPD2hqXQYtTl4=; t=1795119782; x=2110479782; 
	b=SB3LgETIklCxzZzs0z5IEiPnukDH+kTgvlSzBfdUlpDjAwMbQeZcR8bP51jCp00USDoTjiLRCw/
	LGj1P24rUOwISW6KP08qcxHxJWK/VgZLbExdVOG5b+K77RKBngJl3u+htSp+IcUU6/bjoViKl22oy
	VnTAMvWji1xdvmhfSxxWl99/xRg0OrlHb326KkpSduMMHqkfaeOJNNcqBJrGgJHfBdXUdEsH+UKhl
	iMr64a4IIjfn1qaIOQCJ2AeG4v8lVZv2Qy8QDFDMbRCk5OKnX2YHbuo+k3PPRPTDPG4Mb3YzwFlo3
	6fea13XhK7pLYxxRofKYW9uEpzDRWDwrUC4w==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8eq-00000001cIK-2D8j;
	Thu, 19 Nov 2026 21:23:00 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:22:06 -0300
Subject: [PATCH v10 16/16] perf: Synchronize syscall tables with shared
 table
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
Message-Id: <20261119-tonyk-syscall_table-v10-16-a7c9ebd900f6@igalia.com>
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

Synchronize perf syscall tables with the common syscall table
infrastructure. Update the perf copy tables so they match the kernel source
tables.

Add scripts/syscall_common.tbl to the files to be checked with
check-headers.sh.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 153 ++---
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  | 707 ++++++++++-----------
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  49 --
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   |  69 --
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/trace/beauty/syscalltbl.sh              |  22 +-
 tools/scripts/syscall.tbl                          |  69 --
 tools/scripts/syscall_common.tbl                   |  84 +++
 8 files changed, 490 insertions(+), 664 deletions(-)

diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index 55717ed32c27..c92bc7623a7f 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
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
@@ -418,72 +464,3 @@
 400	common	migrate_pages		sys_migrate_pages
 401	common	kexec_file_load		sys_kexec_file_load
 # 402 is unused
-403	common	clock_gettime64			sys_clock_gettime
-404	common	clock_settime64			sys_clock_settime
-405	common	clock_adjtime64			sys_clock_adjtime
-406	common	clock_getres_time64		sys_clock_getres
-407	common	clock_nanosleep_time64		sys_clock_nanosleep
-408	common	timer_gettime64			sys_timer_gettime
-409	common	timer_settime64			sys_timer_settime
-410	common	timerfd_gettime64		sys_timerfd_gettime
-411	common	timerfd_settime64		sys_timerfd_settime
-412	common	utimensat_time64		sys_utimensat
-413	common	pselect6_time64			sys_pselect6
-414	common	ppoll_time64			sys_ppoll
-416	common	io_pgetevents_time64		sys_io_pgetevents
-417	common	recvmmsg_time64			sys_recvmmsg
-418	common	mq_timedsend_time64		sys_mq_timedsend
-419	common	mq_timedreceive_time64		sys_mq_timedreceive
-420	common	semtimedop_time64		sys_semtimedop
-421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
-422	common	futex_time64			sys_futex
-423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
-424	common	pidfd_send_signal		sys_pidfd_send_signal
-425	common	io_uring_setup			sys_io_uring_setup
-426	common	io_uring_enter			sys_io_uring_enter
-427	common	io_uring_register		sys_io_uring_register
-428	common	open_tree			sys_open_tree
-429	common	move_mount			sys_move_mount
-430	common	fsopen				sys_fsopen
-431	common	fsconfig			sys_fsconfig
-432	common	fsmount				sys_fsmount
-433	common	fspick				sys_fspick
-434	common	pidfd_open			sys_pidfd_open
-435	common	clone3				sys_clone3
-436	common	close_range			sys_close_range
-437	common	openat2				sys_openat2
-438	common	pidfd_getfd			sys_pidfd_getfd
-439	common	faccessat2			sys_faccessat2
-440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			sys_epoll_pwait2
-442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_fd			sys_quotactl_fd
-444	common	landlock_create_ruleset		sys_landlock_create_ruleset
-445	common	landlock_add_rule		sys_landlock_add_rule
-446	common	landlock_restrict_self		sys_landlock_restrict_self
-# 447 reserved for memfd_secret
-448	common	process_mrelease		sys_process_mrelease
-449	common	futex_waitv			sys_futex_waitv
-450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	common	cachestat			sys_cachestat
-452	common	fchmodat2			sys_fchmodat2
-453	common	map_shadow_stack		sys_map_shadow_stack
-454	common	futex_wake			sys_futex_wake
-455	common	futex_wait			sys_futex_wait
-456	common	futex_requeue			sys_futex_requeue
-457	common	statmount			sys_statmount
-458	common	listmount			sys_listmount
-459	common	lsm_get_self_attr		sys_lsm_get_self_attr
-460	common	lsm_set_self_attr		sys_lsm_set_self_attr
-461	common	lsm_list_modules		sys_lsm_list_modules
-462	common	mseal				sys_mseal
-463	common	setxattrat			sys_setxattrat
-464	common	getxattrat			sys_getxattrat
-465	common	listxattrat			sys_listxattrat
-466	common	removexattrat			sys_removexattrat
-467	common	open_tree_attr			sys_open_tree_attr
-468	common	file_getattr			sys_file_getattr
-469	common	file_setattr			sys_file_setattr
-470	common	listns				sys_listns
-471	common	rseq_slice_yield		sys_rseq_slice_yield
-472	common	fchroot				sys_fchroot
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 83dc93a0712f..bdec294ba8cd 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -5,385 +5,336 @@
 # The format is:
 # <number> <abi> <name> <entry point>
 #
-# The <abi> is always "n64" for this file.
+# The <abi> is always "common" for this file.
 #
-0	n64	read				sys_read
-1	n64	write				sys_write
-2	n64	open				sys_open
-3	n64	close				sys_close
-4	n64	stat				sys_newstat
-5	n64	fstat				sys_newfstat
-6	n64	lstat				sys_newlstat
-7	n64	poll				sys_poll
-8	n64	lseek				sys_lseek
-9	n64	mmap				sys_mips_mmap
-10	n64	mprotect			sys_mprotect
-11	n64	munmap				sys_munmap
-12	n64	brk				sys_brk
-13	n64	rt_sigaction			sys_rt_sigaction
-14	n64	rt_sigprocmask			sys_rt_sigprocmask
-15	n64	ioctl				sys_ioctl
-16	n64	pread64				sys_pread64
-17	n64	pwrite64			sys_pwrite64
-18	n64	readv				sys_readv
-19	n64	writev				sys_writev
-20	n64	access				sys_access
-21	n64	pipe				sysm_pipe
-22	n64	_newselect			sys_select
-23	n64	sched_yield			sys_sched_yield
-24	n64	mremap				sys_mremap
-25	n64	msync				sys_msync
-26	n64	mincore				sys_mincore
-27	n64	madvise				sys_madvise
-28	n64	shmget				sys_shmget
-29	n64	shmat				sys_shmat
-30	n64	shmctl				sys_old_shmctl
-31	n64	dup				sys_dup
-32	n64	dup2				sys_dup2
-33	n64	pause				sys_pause
-34	n64	nanosleep			sys_nanosleep
-35	n64	getitimer			sys_getitimer
-36	n64	setitimer			sys_setitimer
-37	n64	alarm				sys_alarm
-38	n64	getpid				sys_getpid
-39	n64	sendfile			sys_sendfile64
-40	n64	socket				sys_socket
-41	n64	connect				sys_connect
-42	n64	accept				sys_accept
-43	n64	sendto				sys_sendto
-44	n64	recvfrom			sys_recvfrom
-45	n64	sendmsg				sys_sendmsg
-46	n64	recvmsg				sys_recvmsg
-47	n64	shutdown			sys_shutdown
-48	n64	bind				sys_bind
-49	n64	listen				sys_listen
-50	n64	getsockname			sys_getsockname
-51	n64	getpeername			sys_getpeername
-52	n64	socketpair			sys_socketpair
-53	n64	setsockopt			sys_setsockopt
-54	n64	getsockopt			sys_getsockopt
-55	n64	clone				__sys_clone
-56	n64	fork				__sys_fork
-57	n64	execve				sys_execve
-58	n64	exit				sys_exit
-59	n64	wait4				sys_wait4
-60	n64	kill				sys_kill
-61	n64	uname				sys_newuname
-62	n64	semget				sys_semget
-63	n64	semop				sys_semop
-64	n64	semctl				sys_old_semctl
-65	n64	shmdt				sys_shmdt
-66	n64	msgget				sys_msgget
-67	n64	msgsnd				sys_msgsnd
-68	n64	msgrcv				sys_msgrcv
-69	n64	msgctl				sys_old_msgctl
-70	n64	fcntl				sys_fcntl
-71	n64	flock				sys_flock
-72	n64	fsync				sys_fsync
-73	n64	fdatasync			sys_fdatasync
-74	n64	truncate			sys_truncate
-75	n64	ftruncate			sys_ftruncate
-76	n64	getdents			sys_getdents
-77	n64	getcwd				sys_getcwd
-78	n64	chdir				sys_chdir
-79	n64	fchdir				sys_fchdir
-80	n64	rename				sys_rename
-81	n64	mkdir				sys_mkdir
-82	n64	rmdir				sys_rmdir
-83	n64	creat				sys_creat
-84	n64	link				sys_link
-85	n64	unlink				sys_unlink
-86	n64	symlink				sys_symlink
-87	n64	readlink			sys_readlink
-88	n64	chmod				sys_chmod
-89	n64	fchmod				sys_fchmod
-90	n64	chown				sys_chown
-91	n64	fchown				sys_fchown
-92	n64	lchown				sys_lchown
-93	n64	umask				sys_umask
-94	n64	gettimeofday			sys_gettimeofday
-95	n64	getrlimit			sys_getrlimit
-96	n64	getrusage			sys_getrusage
-97	n64	sysinfo				sys_sysinfo
-98	n64	times				sys_times
-99	n64	ptrace				sys_ptrace
-100	n64	getuid				sys_getuid
-101	n64	syslog				sys_syslog
-102	n64	getgid				sys_getgid
-103	n64	setuid				sys_setuid
-104	n64	setgid				sys_setgid
-105	n64	geteuid				sys_geteuid
-106	n64	getegid				sys_getegid
-107	n64	setpgid				sys_setpgid
-108	n64	getppid				sys_getppid
-109	n64	getpgrp				sys_getpgrp
-110	n64	setsid				sys_setsid
-111	n64	setreuid			sys_setreuid
-112	n64	setregid			sys_setregid
-113	n64	getgroups			sys_getgroups
-114	n64	setgroups			sys_setgroups
-115	n64	setresuid			sys_setresuid
-116	n64	getresuid			sys_getresuid
-117	n64	setresgid			sys_setresgid
-118	n64	getresgid			sys_getresgid
-119	n64	getpgid				sys_getpgid
-120	n64	setfsuid			sys_setfsuid
-121	n64	setfsgid			sys_setfsgid
-122	n64	getsid				sys_getsid
-123	n64	capget				sys_capget
-124	n64	capset				sys_capset
-125	n64	rt_sigpending			sys_rt_sigpending
-126	n64	rt_sigtimedwait			sys_rt_sigtimedwait
-127	n64	rt_sigqueueinfo			sys_rt_sigqueueinfo
-128	n64	rt_sigsuspend			sys_rt_sigsuspend
-129	n64	sigaltstack			sys_sigaltstack
-130	n64	utime				sys_utime
-131	n64	mknod				sys_mknod
-132	n64	personality			sys_personality
-133	n64	ustat				sys_ustat
-134	n64	statfs				sys_statfs
-135	n64	fstatfs				sys_fstatfs
-136	n64	sysfs				sys_sysfs
-137	n64	getpriority			sys_getpriority
-138	n64	setpriority			sys_setpriority
-139	n64	sched_setparam			sys_sched_setparam
-140	n64	sched_getparam			sys_sched_getparam
-141	n64	sched_setscheduler		sys_sched_setscheduler
-142	n64	sched_getscheduler		sys_sched_getscheduler
-143	n64	sched_get_priority_max		sys_sched_get_priority_max
-144	n64	sched_get_priority_min		sys_sched_get_priority_min
-145	n64	sched_rr_get_interval		sys_sched_rr_get_interval
-146	n64	mlock				sys_mlock
-147	n64	munlock				sys_munlock
-148	n64	mlockall			sys_mlockall
-149	n64	munlockall			sys_munlockall
-150	n64	vhangup				sys_vhangup
-151	n64	pivot_root			sys_pivot_root
-152	n64	_sysctl				sys_ni_syscall
-153	n64	prctl				sys_prctl
-154	n64	adjtimex			sys_adjtimex
-155	n64	setrlimit			sys_setrlimit
-156	n64	chroot				sys_chroot
-157	n64	sync				sys_sync
-158	n64	acct				sys_acct
-159	n64	settimeofday			sys_settimeofday
-160	n64	mount				sys_mount
-161	n64	umount2				sys_umount
-162	n64	swapon				sys_swapon
-163	n64	swapoff				sys_swapoff
-164	n64	reboot				sys_reboot
-165	n64	sethostname			sys_sethostname
-166	n64	setdomainname			sys_setdomainname
-167	n64	create_module			sys_ni_syscall
-168	n64	init_module			sys_init_module
-169	n64	delete_module			sys_delete_module
-170	n64	get_kernel_syms			sys_ni_syscall
-171	n64	query_module			sys_ni_syscall
-172	n64	quotactl			sys_quotactl
-173	n64	nfsservctl			sys_ni_syscall
-174	n64	getpmsg				sys_ni_syscall
-175	n64	putpmsg				sys_ni_syscall
-176	n64	afs_syscall			sys_ni_syscall
+0	common	read				sys_read
+1	common	write				sys_write
+2	common	open				sys_open
+3	common	close				sys_close
+4	common	stat				sys_newstat
+5	common	fstat				sys_newfstat
+6	common	lstat				sys_newlstat
+7	common	poll				sys_poll
+8	common	lseek				sys_lseek
+9	common	mmap				sys_mips_mmap
+10	common	mprotect			sys_mprotect
+11	common	munmap				sys_munmap
+12	common	brk				sys_brk
+13	common	rt_sigaction			sys_rt_sigaction
+14	common	rt_sigprocmask			sys_rt_sigprocmask
+15	common	ioctl				sys_ioctl
+16	common	pread64				sys_pread64
+17	common	pwrite64			sys_pwrite64
+18	common	readv				sys_readv
+19	common	writev				sys_writev
+20	common	access				sys_access
+21	common	pipe				sysm_pipe
+22	common	_newselect			sys_select
+23	common	sched_yield			sys_sched_yield
+24	common	mremap				sys_mremap
+25	common	msync				sys_msync
+26	common	mincore				sys_mincore
+27	common	madvise				sys_madvise
+28	common	shmget				sys_shmget
+29	common	shmat				sys_shmat
+30	common	shmctl				sys_old_shmctl
+31	common	dup				sys_dup
+32	common	dup2				sys_dup2
+33	common	pause				sys_pause
+34	common	nanosleep			sys_nanosleep
+35	common	getitimer			sys_getitimer
+36	common	setitimer			sys_setitimer
+37	common	alarm				sys_alarm
+38	common	getpid				sys_getpid
+39	common	sendfile			sys_sendfile64
+40	common	socket				sys_socket
+41	common	connect				sys_connect
+42	common	accept				sys_accept
+43	common	sendto				sys_sendto
+44	common	recvfrom			sys_recvfrom
+45	common	sendmsg				sys_sendmsg
+46	common	recvmsg				sys_recvmsg
+47	common	shutdown			sys_shutdown
+48	common	bind				sys_bind
+49	common	listen				sys_listen
+50	common	getsockname			sys_getsockname
+51	common	getpeername			sys_getpeername
+52	common	socketpair			sys_socketpair
+53	common	setsockopt			sys_setsockopt
+54	common	getsockopt			sys_getsockopt
+55	common	clone				__sys_clone
+56	common	fork				__sys_fork
+57	common	execve				sys_execve
+58	common	exit				sys_exit
+59	common	wait4				sys_wait4
+60	common	kill				sys_kill
+61	common	uname				sys_newuname
+62	common	semget				sys_semget
+63	common	semop				sys_semop
+64	common	semctl				sys_old_semctl
+65	common	shmdt				sys_shmdt
+66	common	msgget				sys_msgget
+67	common	msgsnd				sys_msgsnd
+68	common	msgrcv				sys_msgrcv
+69	common	msgctl				sys_old_msgctl
+70	common	fcntl				sys_fcntl
+71	common	flock				sys_flock
+72	common	fsync				sys_fsync
+73	common	fdatasync			sys_fdatasync
+74	common	truncate			sys_truncate
+75	common	ftruncate			sys_ftruncate
+76	common	getdents			sys_getdents
+77	common	getcwd				sys_getcwd
+78	common	chdir				sys_chdir
+79	common	fchdir				sys_fchdir
+80	common	rename				sys_rename
+81	common	mkdir				sys_mkdir
+82	common	rmdir				sys_rmdir
+83	common	creat				sys_creat
+84	common	link				sys_link
+85	common	unlink				sys_unlink
+86	common	symlink				sys_symlink
+87	common	readlink			sys_readlink
+88	common	chmod				sys_chmod
+89	common	fchmod				sys_fchmod
+90	common	chown				sys_chown
+91	common	fchown				sys_fchown
+92	common	lchown				sys_lchown
+93	common	umask				sys_umask
+94	common	gettimeofday			sys_gettimeofday
+95	common	getrlimit			sys_getrlimit
+96	common	getrusage			sys_getrusage
+97	common	sysinfo				sys_sysinfo
+98	common	times				sys_times
+99	common	ptrace				sys_ptrace
+100	common	getuid				sys_getuid
+101	common	syslog				sys_syslog
+102	common	getgid				sys_getgid
+103	common	setuid				sys_setuid
+104	common	setgid				sys_setgid
+105	common	geteuid				sys_geteuid
+106	common	getegid				sys_getegid
+107	common	setpgid				sys_setpgid
+108	common	getppid				sys_getppid
+109	common	getpgrp				sys_getpgrp
+110	common	setsid				sys_setsid
+111	common	setreuid			sys_setreuid
+112	common	setregid			sys_setregid
+113	common	getgroups			sys_getgroups
+114	common	setgroups			sys_setgroups
+115	common	setresuid			sys_setresuid
+116	common	getresuid			sys_getresuid
+117	common	setresgid			sys_setresgid
+118	common	getresgid			sys_getresgid
+119	common	getpgid				sys_getpgid
+120	common	setfsuid			sys_setfsuid
+121	common	setfsgid			sys_setfsgid
+122	common	getsid				sys_getsid
+123	common	capget				sys_capget
+124	common	capset				sys_capset
+125	common	rt_sigpending			sys_rt_sigpending
+126	common	rt_sigtimedwait			sys_rt_sigtimedwait
+127	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+128	common	rt_sigsuspend			sys_rt_sigsuspend
+129	common	sigaltstack			sys_sigaltstack
+130	common	utime				sys_utime
+131	common	mknod				sys_mknod
+132	common	personality			sys_personality
+133	common	ustat				sys_ustat
+134	common	statfs				sys_statfs
+135	common	fstatfs				sys_fstatfs
+136	common	sysfs				sys_sysfs
+137	common	getpriority			sys_getpriority
+138	common	setpriority			sys_setpriority
+139	common	sched_setparam			sys_sched_setparam
+140	common	sched_getparam			sys_sched_getparam
+141	common	sched_setscheduler		sys_sched_setscheduler
+142	common	sched_getscheduler		sys_sched_getscheduler
+143	common	sched_get_priority_max		sys_sched_get_priority_max
+144	common	sched_get_priority_min		sys_sched_get_priority_min
+145	common	sched_rr_get_interval		sys_sched_rr_get_interval
+146	common	mlock				sys_mlock
+147	common	munlock				sys_munlock
+148	common	mlockall			sys_mlockall
+149	common	munlockall			sys_munlockall
+150	common	vhangup				sys_vhangup
+151	common	pivot_root			sys_pivot_root
+152	common	_sysctl				sys_ni_syscall
+153	common	prctl				sys_prctl
+154	common	adjtimex			sys_adjtimex
+155	common	setrlimit			sys_setrlimit
+156	common	chroot				sys_chroot
+157	common	sync				sys_sync
+158	common	acct				sys_acct
+159	common	settimeofday			sys_settimeofday
+160	common	mount				sys_mount
+161	common	umount2				sys_umount
+162	common	swapon				sys_swapon
+163	common	swapoff				sys_swapoff
+164	common	reboot				sys_reboot
+165	common	sethostname			sys_sethostname
+166	common	setdomainname			sys_setdomainname
+167	common	create_module			sys_ni_syscall
+168	common	init_module			sys_init_module
+169	common	delete_module			sys_delete_module
+170	common	get_kernel_syms			sys_ni_syscall
+171	common	query_module			sys_ni_syscall
+172	common	quotactl			sys_quotactl
+173	common	nfsservctl			sys_ni_syscall
+174	common	getpmsg				sys_ni_syscall
+175	common	putpmsg				sys_ni_syscall
+176	common	afs_syscall			sys_ni_syscall
 # 177 reserved for security
-177	n64	reserved177			sys_ni_syscall
-178	n64	gettid				sys_gettid
-179	n64	readahead			sys_readahead
-180	n64	setxattr			sys_setxattr
-181	n64	lsetxattr			sys_lsetxattr
-182	n64	fsetxattr			sys_fsetxattr
-183	n64	getxattr			sys_getxattr
-184	n64	lgetxattr			sys_lgetxattr
-185	n64	fgetxattr			sys_fgetxattr
-186	n64	listxattr			sys_listxattr
-187	n64	llistxattr			sys_llistxattr
-188	n64	flistxattr			sys_flistxattr
-189	n64	removexattr			sys_removexattr
-190	n64	lremovexattr			sys_lremovexattr
-191	n64	fremovexattr			sys_fremovexattr
-192	n64	tkill				sys_tkill
-193	n64	reserved193			sys_ni_syscall
-194	n64	futex				sys_futex
-195	n64	sched_setaffinity		sys_sched_setaffinity
-196	n64	sched_getaffinity		sys_sched_getaffinity
-197	n64	cacheflush			sys_cacheflush
-198	n64	cachectl			sys_cachectl
-199	n64	sysmips				__sys_sysmips
-200	n64	io_setup			sys_io_setup
-201	n64	io_destroy			sys_io_destroy
-202	n64	io_getevents			sys_io_getevents
-203	n64	io_submit			sys_io_submit
-204	n64	io_cancel			sys_io_cancel
-205	n64	exit_group			sys_exit_group
-206	n64	lookup_dcookie			sys_ni_syscall
-207	n64	epoll_create			sys_epoll_create
-208	n64	epoll_ctl			sys_epoll_ctl
-209	n64	epoll_wait			sys_epoll_wait
-210	n64	remap_file_pages		sys_remap_file_pages
-211	n64	rt_sigreturn			sys_rt_sigreturn
-212	n64	set_tid_address			sys_set_tid_address
-213	n64	restart_syscall			sys_restart_syscall
-214	n64	semtimedop			sys_semtimedop
-215	n64	fadvise64			sys_fadvise64_64
-216	n64	timer_create			sys_timer_create
-217	n64	timer_settime			sys_timer_settime
-218	n64	timer_gettime			sys_timer_gettime
-219	n64	timer_getoverrun		sys_timer_getoverrun
-220	n64	timer_delete			sys_timer_delete
-221	n64	clock_settime			sys_clock_settime
-222	n64	clock_gettime			sys_clock_gettime
-223	n64	clock_getres			sys_clock_getres
-224	n64	clock_nanosleep			sys_clock_nanosleep
-225	n64	tgkill				sys_tgkill
-226	n64	utimes				sys_utimes
-227	n64	mbind				sys_mbind
-228	n64	get_mempolicy			sys_get_mempolicy
-229	n64	set_mempolicy			sys_set_mempolicy
-230	n64	mq_open				sys_mq_open
-231	n64	mq_unlink			sys_mq_unlink
-232	n64	mq_timedsend			sys_mq_timedsend
-233	n64	mq_timedreceive			sys_mq_timedreceive
-234	n64	mq_notify			sys_mq_notify
-235	n64	mq_getsetattr			sys_mq_getsetattr
-236	n64	vserver				sys_ni_syscall
-237	n64	waitid				sys_waitid
+177	common	reserved177			sys_ni_syscall
+178	common	gettid				sys_gettid
+179	common	readahead			sys_readahead
+180	common	setxattr			sys_setxattr
+181	common	lsetxattr			sys_lsetxattr
+182	common	fsetxattr			sys_fsetxattr
+183	common	getxattr			sys_getxattr
+184	common	lgetxattr			sys_lgetxattr
+185	common	fgetxattr			sys_fgetxattr
+186	common	listxattr			sys_listxattr
+187	common	llistxattr			sys_llistxattr
+188	common	flistxattr			sys_flistxattr
+189	common	removexattr			sys_removexattr
+190	common	lremovexattr			sys_lremovexattr
+191	common	fremovexattr			sys_fremovexattr
+192	common	tkill				sys_tkill
+193	common	reserved193			sys_ni_syscall
+194	common	futex				sys_futex
+195	common	sched_setaffinity		sys_sched_setaffinity
+196	common	sched_getaffinity		sys_sched_getaffinity
+197	common	cacheflush			sys_cacheflush
+198	common	cachectl			sys_cachectl
+199	common	sysmips				__sys_sysmips
+200	common	io_setup			sys_io_setup
+201	common	io_destroy			sys_io_destroy
+202	common	io_getevents			sys_io_getevents
+203	common	io_submit			sys_io_submit
+204	common	io_cancel			sys_io_cancel
+205	common	exit_group			sys_exit_group
+206	common	lookup_dcookie			sys_ni_syscall
+207	common	epoll_create			sys_epoll_create
+208	common	epoll_ctl			sys_epoll_ctl
+209	common	epoll_wait			sys_epoll_wait
+210	common	remap_file_pages		sys_remap_file_pages
+211	common	rt_sigreturn			sys_rt_sigreturn
+212	common	set_tid_address			sys_set_tid_address
+213	common	restart_syscall			sys_restart_syscall
+214	common	semtimedop			sys_semtimedop
+215	common	fadvise64			sys_fadvise64_64
+216	common	timer_create			sys_timer_create
+217	common	timer_settime			sys_timer_settime
+218	common	timer_gettime			sys_timer_gettime
+219	common	timer_getoverrun		sys_timer_getoverrun
+220	common	timer_delete			sys_timer_delete
+221	common	clock_settime			sys_clock_settime
+222	common	clock_gettime			sys_clock_gettime
+223	common	clock_getres			sys_clock_getres
+224	common	clock_nanosleep			sys_clock_nanosleep
+225	common	tgkill				sys_tgkill
+226	common	utimes				sys_utimes
+227	common	mbind				sys_mbind
+228	common	get_mempolicy			sys_get_mempolicy
+229	common	set_mempolicy			sys_set_mempolicy
+230	common	mq_open				sys_mq_open
+231	common	mq_unlink			sys_mq_unlink
+232	common	mq_timedsend			sys_mq_timedsend
+233	common	mq_timedreceive			sys_mq_timedreceive
+234	common	mq_notify			sys_mq_notify
+235	common	mq_getsetattr			sys_mq_getsetattr
+236	common	vserver				sys_ni_syscall
+237	common	waitid				sys_waitid
 # 238 was sys_setaltroot
-239	n64	add_key				sys_add_key
-240	n64	request_key			sys_request_key
-241	n64	keyctl				sys_keyctl
-242	n64	set_thread_area			sys_set_thread_area
-243	n64	inotify_init			sys_inotify_init
-244	n64	inotify_add_watch		sys_inotify_add_watch
-245	n64	inotify_rm_watch		sys_inotify_rm_watch
-246	n64	migrate_pages			sys_migrate_pages
-247	n64	openat				sys_openat
-248	n64	mkdirat				sys_mkdirat
-249	n64	mknodat				sys_mknodat
-250	n64	fchownat			sys_fchownat
-251	n64	futimesat			sys_futimesat
-252	n64	newfstatat			sys_newfstatat
-253	n64	unlinkat			sys_unlinkat
-254	n64	renameat			sys_renameat
-255	n64	linkat				sys_linkat
-256	n64	symlinkat			sys_symlinkat
-257	n64	readlinkat			sys_readlinkat
-258	n64	fchmodat			sys_fchmodat
-259	n64	faccessat			sys_faccessat
-260	n64	pselect6			sys_pselect6
-261	n64	ppoll				sys_ppoll
-262	n64	unshare				sys_unshare
-263	n64	splice				sys_splice
-264	n64	sync_file_range			sys_sync_file_range
-265	n64	tee				sys_tee
-266	n64	vmsplice			sys_vmsplice
-267	n64	move_pages			sys_move_pages
-268	n64	set_robust_list			sys_set_robust_list
-269	n64	get_robust_list			sys_get_robust_list
-270	n64	kexec_load			sys_kexec_load
-271	n64	getcpu				sys_getcpu
-272	n64	epoll_pwait			sys_epoll_pwait
-273	n64	ioprio_set			sys_ioprio_set
-274	n64	ioprio_get			sys_ioprio_get
-275	n64	utimensat			sys_utimensat
-276	n64	signalfd			sys_signalfd
-277	n64	timerfd				sys_ni_syscall
-278	n64	eventfd				sys_eventfd
-279	n64	fallocate			sys_fallocate
-280	n64	timerfd_create			sys_timerfd_create
-281	n64	timerfd_gettime			sys_timerfd_gettime
-282	n64	timerfd_settime			sys_timerfd_settime
-283	n64	signalfd4			sys_signalfd4
-284	n64	eventfd2			sys_eventfd2
-285	n64	epoll_create1			sys_epoll_create1
-286	n64	dup3				sys_dup3
-287	n64	pipe2				sys_pipe2
-288	n64	inotify_init1			sys_inotify_init1
-289	n64	preadv				sys_preadv
-290	n64	pwritev				sys_pwritev
-291	n64	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
-292	n64	perf_event_open			sys_perf_event_open
-293	n64	accept4				sys_accept4
-294	n64	recvmmsg			sys_recvmmsg
-295	n64	fanotify_init			sys_fanotify_init
-296	n64	fanotify_mark			sys_fanotify_mark
-297	n64	prlimit64			sys_prlimit64
-298	n64	name_to_handle_at		sys_name_to_handle_at
-299	n64	open_by_handle_at		sys_open_by_handle_at
-300	n64	clock_adjtime			sys_clock_adjtime
-301	n64	syncfs				sys_syncfs
-302	n64	sendmmsg			sys_sendmmsg
-303	n64	setns				sys_setns
-304	n64	process_vm_readv		sys_process_vm_readv
-305	n64	process_vm_writev		sys_process_vm_writev
-306	n64	kcmp				sys_kcmp
-307	n64	finit_module			sys_finit_module
-308	n64	getdents64			sys_getdents64
-309	n64	sched_setattr			sys_sched_setattr
-310	n64	sched_getattr			sys_sched_getattr
-311	n64	renameat2			sys_renameat2
-312	n64	seccomp				sys_seccomp
-313	n64	getrandom			sys_getrandom
-314	n64	memfd_create			sys_memfd_create
-315	n64	bpf				sys_bpf
-316	n64	execveat			sys_execveat
-317	n64	userfaultfd			sys_userfaultfd
-318	n64	membarrier			sys_membarrier
-319	n64	mlock2				sys_mlock2
-320	n64	copy_file_range			sys_copy_file_range
-321	n64	preadv2				sys_preadv2
-322	n64	pwritev2			sys_pwritev2
-323	n64	pkey_mprotect			sys_pkey_mprotect
-324	n64	pkey_alloc			sys_pkey_alloc
-325	n64	pkey_free			sys_pkey_free
-326	n64	statx				sys_statx
-327	n64	rseq				sys_rseq
-328	n64	io_pgetevents			sys_io_pgetevents
+239	common	add_key				sys_add_key
+240	common	request_key			sys_request_key
+241	common	keyctl				sys_keyctl
+242	common	set_thread_area			sys_set_thread_area
+243	common	inotify_init			sys_inotify_init
+244	common	inotify_add_watch		sys_inotify_add_watch
+245	common	inotify_rm_watch		sys_inotify_rm_watch
+246	common	migrate_pages			sys_migrate_pages
+247	common	openat				sys_openat
+248	common	mkdirat				sys_mkdirat
+249	common	mknodat				sys_mknodat
+250	common	fchownat			sys_fchownat
+251	common	futimesat			sys_futimesat
+252	common	newfstatat			sys_newfstatat
+253	common	unlinkat			sys_unlinkat
+254	common	renameat			sys_renameat
+255	common	linkat				sys_linkat
+256	common	symlinkat			sys_symlinkat
+257	common	readlinkat			sys_readlinkat
+258	common	fchmodat			sys_fchmodat
+259	common	faccessat			sys_faccessat
+260	common	pselect6			sys_pselect6
+261	common	ppoll				sys_ppoll
+262	common	unshare				sys_unshare
+263	common	splice				sys_splice
+264	common	sync_file_range			sys_sync_file_range
+265	common	tee				sys_tee
+266	common	vmsplice			sys_vmsplice
+267	common	move_pages			sys_move_pages
+268	common	set_robust_list			sys_set_robust_list
+269	common	get_robust_list			sys_get_robust_list
+270	common	kexec_load			sys_kexec_load
+271	common	getcpu				sys_getcpu
+272	common	epoll_pwait			sys_epoll_pwait
+273	common	ioprio_set			sys_ioprio_set
+274	common	ioprio_get			sys_ioprio_get
+275	common	utimensat			sys_utimensat
+276	common	signalfd			sys_signalfd
+277	common	timerfd				sys_ni_syscall
+278	common	eventfd				sys_eventfd
+279	common	fallocate			sys_fallocate
+280	common	timerfd_create			sys_timerfd_create
+281	common	timerfd_gettime			sys_timerfd_gettime
+282	common	timerfd_settime			sys_timerfd_settime
+283	common	signalfd4			sys_signalfd4
+284	common	eventfd2			sys_eventfd2
+285	common	epoll_create1			sys_epoll_create1
+286	common	dup3				sys_dup3
+287	common	pipe2				sys_pipe2
+288	common	inotify_init1			sys_inotify_init1
+289	common	preadv				sys_preadv
+290	common	pwritev				sys_pwritev
+291	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+292	common	perf_event_open			sys_perf_event_open
+293	common	accept4				sys_accept4
+294	common	recvmmsg			sys_recvmmsg
+295	common	fanotify_init			sys_fanotify_init
+296	common	fanotify_mark			sys_fanotify_mark
+297	common	prlimit64			sys_prlimit64
+298	common	name_to_handle_at		sys_name_to_handle_at
+299	common	open_by_handle_at		sys_open_by_handle_at
+300	common	clock_adjtime			sys_clock_adjtime
+301	common	syncfs				sys_syncfs
+302	common	sendmmsg			sys_sendmmsg
+303	common	setns				sys_setns
+304	common	process_vm_readv		sys_process_vm_readv
+305	common	process_vm_writev		sys_process_vm_writev
+306	common	kcmp				sys_kcmp
+307	common	finit_module			sys_finit_module
+308	common	getdents64			sys_getdents64
+309	common	sched_setattr			sys_sched_setattr
+310	common	sched_getattr			sys_sched_getattr
+311	common	renameat2			sys_renameat2
+312	common	seccomp				sys_seccomp
+313	common	getrandom			sys_getrandom
+314	common	memfd_create			sys_memfd_create
+315	common	bpf				sys_bpf
+316	common	execveat			sys_execveat
+317	common	userfaultfd			sys_userfaultfd
+318	common	membarrier			sys_membarrier
+319	common	mlock2				sys_mlock2
+320	common	copy_file_range			sys_copy_file_range
+321	common	preadv2				sys_preadv2
+322	common	pwritev2			sys_pwritev2
+323	common	pkey_mprotect			sys_pkey_mprotect
+324	common	pkey_alloc			sys_pkey_alloc
+325	common	pkey_free			sys_pkey_free
+326	common	statx				sys_statx
+327	common	rseq				sys_rseq
+328	common	io_pgetevents			sys_io_pgetevents
 # 329 through 423 are reserved to sync up with other architectures
-424	n64	pidfd_send_signal		sys_pidfd_send_signal
-425	n64	io_uring_setup			sys_io_uring_setup
-426	n64	io_uring_enter			sys_io_uring_enter
-427	n64	io_uring_register		sys_io_uring_register
-428	n64	open_tree			sys_open_tree
-429	n64	move_mount			sys_move_mount
-430	n64	fsopen				sys_fsopen
-431	n64	fsconfig			sys_fsconfig
-432	n64	fsmount				sys_fsmount
-433	n64	fspick				sys_fspick
-434	n64	pidfd_open			sys_pidfd_open
-435	n64	clone3				__sys_clone3
-436	n64	close_range			sys_close_range
-437	n64	openat2				sys_openat2
-438	n64	pidfd_getfd			sys_pidfd_getfd
-439	n64	faccessat2			sys_faccessat2
-440	n64	process_madvise			sys_process_madvise
-441	n64	epoll_pwait2			sys_epoll_pwait2
-442	n64	mount_setattr			sys_mount_setattr
-443	n64	quotactl_fd			sys_quotactl_fd
-444	n64	landlock_create_ruleset		sys_landlock_create_ruleset
-445	n64	landlock_add_rule		sys_landlock_add_rule
-446	n64	landlock_restrict_self		sys_landlock_restrict_self
-# 447 reserved for memfd_secret
-448	n64	process_mrelease		sys_process_mrelease
-449	n64	futex_waitv			sys_futex_waitv
-450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	n64	cachestat			sys_cachestat
-452	n64	fchmodat2			sys_fchmodat2
-453	n64	map_shadow_stack		sys_map_shadow_stack
-454	n64	futex_wake			sys_futex_wake
-455	n64	futex_wait			sys_futex_wait
-456	n64	futex_requeue			sys_futex_requeue
-457	n64	statmount			sys_statmount
-458	n64	listmount			sys_listmount
-459	n64	lsm_get_self_attr		sys_lsm_get_self_attr
-460	n64	lsm_set_self_attr		sys_lsm_set_self_attr
-461	n64	lsm_list_modules		sys_lsm_list_modules
-462	n64	mseal				sys_mseal
-463	n64	setxattrat			sys_setxattrat
-464	n64	getxattrat			sys_getxattrat
-465	n64	listxattrat			sys_listxattrat
-466	n64	removexattrat			sys_removexattrat
-467	n64	open_tree_attr			sys_open_tree_attr
-468	n64	file_getattr			sys_file_getattr
-469	n64	file_setattr			sys_file_setattr
-470	n64	listns				sys_listns
-471	n64	rseq_slice_yield		sys_rseq_slice_yield
-472	n64	fchroot				sys_fchroot
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 1b45e68a217b..ce6d15260dd1 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -350,52 +350,3 @@
 400	common	msgsnd				sys_msgsnd
 401	common	msgrcv				sys_msgrcv
 402	common	msgctl				sys_msgctl
-424	common	pidfd_send_signal		sys_pidfd_send_signal
-425	common	io_uring_setup			sys_io_uring_setup
-426	common	io_uring_enter			sys_io_uring_enter
-427	common	io_uring_register		sys_io_uring_register
-428	common	open_tree			sys_open_tree
-429	common	move_mount			sys_move_mount
-430	common	fsopen				sys_fsopen
-431	common	fsconfig			sys_fsconfig
-432	common	fsmount				sys_fsmount
-433	common	fspick				sys_fspick
-434	common	pidfd_open			sys_pidfd_open
-435	common	clone3				sys_clone3
-436	common	close_range			sys_close_range
-437	common	openat2				sys_openat2
-438	common	pidfd_getfd			sys_pidfd_getfd
-439	common	faccessat2			sys_faccessat2
-440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			sys_epoll_pwait2
-442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_fd			sys_quotactl_fd
-444	common	landlock_create_ruleset		sys_landlock_create_ruleset
-445	common	landlock_add_rule		sys_landlock_add_rule
-446	common	landlock_restrict_self		sys_landlock_restrict_self
-447	common	memfd_secret			sys_memfd_secret
-448	common	process_mrelease		sys_process_mrelease
-449	common	futex_waitv			sys_futex_waitv
-450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	common	cachestat			sys_cachestat
-452	common	fchmodat2			sys_fchmodat2
-453	common	map_shadow_stack		sys_map_shadow_stack
-454	common	futex_wake			sys_futex_wake
-455	common	futex_wait			sys_futex_wait
-456	common	futex_requeue			sys_futex_requeue
-457	common	statmount			sys_statmount
-458	common	listmount			sys_listmount
-459	common	lsm_get_self_attr		sys_lsm_get_self_attr
-460	common	lsm_set_self_attr		sys_lsm_set_self_attr
-461	common	lsm_list_modules		sys_lsm_list_modules
-462	common	mseal				sys_mseal
-463	common	setxattrat			sys_setxattrat
-464	common	getxattrat			sys_getxattrat
-465	common	listxattrat			sys_listxattrat
-466	common	removexattrat			sys_removexattrat
-467	common	open_tree_attr			sys_open_tree_attr
-468	common	file_getattr			sys_file_getattr
-469	common	file_setattr			sys_file_setattr
-470	common	listns				sys_listns
-471	common	rseq_slice_yield		sys_rseq_slice_yield
-472	common	fchroot				sys_fchroot
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index 5b9fe0e8140f..5f407da6b9da 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -449,72 +449,3 @@
 400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
 401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
 402	common	msgctl			sys_msgctl			compat_sys_msgctl
-403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
-404	32	clock_settime64			sys_clock_settime		sys_clock_settime
-405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
-406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
-407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
-408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
-409	32	timer_settime64			sys_timer_settime		sys_timer_settime
-410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
-411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
-412	32	utimensat_time64		sys_utimensat			sys_utimensat
-413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
-414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
-417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
-418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
-419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
-420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
-421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
-422	32	futex_time64			sys_futex			sys_futex
-423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
-424	common	pidfd_send_signal		sys_pidfd_send_signal
-425	common	io_uring_setup			sys_io_uring_setup
-426	common	io_uring_enter			sys_io_uring_enter
-427	common	io_uring_register		sys_io_uring_register
-428	common	open_tree			sys_open_tree
-429	common	move_mount			sys_move_mount
-430	common	fsopen				sys_fsopen
-431	common	fsconfig			sys_fsconfig
-432	common	fsmount				sys_fsmount
-433	common	fspick				sys_fspick
-434	common	pidfd_open			sys_pidfd_open
-435	common	clone3				__sys_clone3
-436	common	close_range			sys_close_range
-437	common	openat2			sys_openat2
-438	common	pidfd_getfd			sys_pidfd_getfd
-439	common	faccessat2			sys_faccessat2
-440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
-442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_fd			sys_quotactl_fd
-444	common	landlock_create_ruleset		sys_landlock_create_ruleset
-445	common	landlock_add_rule		sys_landlock_add_rule
-446	common	landlock_restrict_self		sys_landlock_restrict_self
-# 447 reserved for memfd_secret
-448	common	process_mrelease		sys_process_mrelease
-449	common  futex_waitv                     sys_futex_waitv
-450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	common	cachestat			sys_cachestat
-452	common	fchmodat2			sys_fchmodat2
-453	common	map_shadow_stack		sys_map_shadow_stack
-454	common	futex_wake			sys_futex_wake
-455	common	futex_wait			sys_futex_wait
-456	common	futex_requeue			sys_futex_requeue
-457	common	statmount			sys_statmount
-458	common	listmount			sys_listmount
-459	common	lsm_get_self_attr		sys_lsm_get_self_attr
-460	common	lsm_set_self_attr		sys_lsm_set_self_attr
-461	common	lsm_list_modules		sys_lsm_list_modules
-462	common	mseal 				sys_mseal
-463	common	setxattrat			sys_setxattrat
-464	common	getxattrat			sys_getxattrat
-465	common	listxattrat			sys_listxattrat
-466	common	removexattrat			sys_removexattrat
-467	common	open_tree_attr			sys_open_tree_attr
-468	common	file_getattr			sys_file_getattr
-469	common	file_setattr			sys_file_setattr
-470	common	listns				sys_listns
-471	common	rseq_slice_yield		sys_rseq_slice_yield
-472	common	fchroot				sys_fchroot
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 39d9c7182f9b..9b854b3b0144 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -70,6 +70,7 @@ declare -a FILES=(
   "include/uapi/asm-generic/mman-common.h"
   "include/uapi/asm-generic/unistd.h"
   "scripts/syscall.tbl"
+  "scripts/syscall_common.tbl"
 )
 
 declare -a SYNC_CHECK_FILES=(
diff --git a/tools/perf/trace/beauty/syscalltbl.sh b/tools/perf/trace/beauty/syscalltbl.sh
index adc29af6e891..cda2ea21a6ba 100755
--- a/tools/perf/trace/beauty/syscalltbl.sh
+++ b/tools/perf/trace/beauty/syscalltbl.sh
@@ -104,20 +104,20 @@ cat >> "$outfile" <<EOF
 
 #if defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
 EOF
-build_tables "$tools_dir/perf/arch/arm/entry/syscalls/syscall.tbl" "$outfile" common,32,oabi EM_ARM
-build_tables "$tools_dir/perf/arch/arm64/entry/syscalls/syscall_64.tbl" "$outfile" common,64,renameat,rlimit,memfd_secret EM_AARCH64
+build_tables "$tools_dir/perf/arch/arm/entry/syscalls/syscall.tbl" "$outfile" common,32,oabi,clone3 EM_ARM "$tools_dir/scripts/syscall_common.tbl"
+build_tables "$tools_dir/perf/arch/arm64/entry/syscalls/syscall_64.tbl" "$outfile" common,64,renameat,rlimit,memfd_secret,clone3 EM_AARCH64 "$tools_dir/scripts/syscall_common.tbl"
 cat >> "$outfile" <<EOF
 #endif // defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__)
 
 #if defined(ALL_SYSCALLTBL) || defined(__csky__)
 EOF
-build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,csky,time32,stat64,rlimit EM_CSKY
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,csky,time32,stat64,rlimit,clone3 EM_CSKY "$tools_dir/scripts/syscall_common.tbl"
 cat >> "$outfile" <<EOF
 #endif // defined(ALL_SYSCALLTBL) || defined(__csky__)
 
 #if defined(ALL_SYSCALLTBL) || defined(__mips__)
 EOF
-build_tables "$tools_dir/perf/arch/mips/entry/syscalls/syscall_n64.tbl" "$outfile" common,64,n64 EM_MIPS
+build_tables "$tools_dir/perf/arch/mips/entry/syscalls/syscall_n64.tbl" "$outfile" common,64,n64,clone3 EM_MIPS "$tools_dir/scripts/syscall_common.tbl"
 cat >> "$outfile" <<EOF
 #endif // defined(ALL_SYSCALLTBL) || defined(__mips__)
 
@@ -141,15 +141,15 @@ cat >> "$outfile" <<EOF
 #if defined(ALL_SYSCALLTBL) || defined(__riscv)
 #if __BITS_PER_LONG != 64
 EOF
-build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,riscv,memfd_secret EM_RISCV
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,riscv,memfd_secret,clone3 EM_RISCV "$tools_dir/scripts/syscall_common.tbl"
 echo "#else" >> "$outfile"
-build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64,riscv,rlimit,memfd_secret EM_RISCV
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64,riscv,rlimit,memfd_secret,clone3 EM_RISCV "$tools_dir/scripts/syscall_common.tbl"
 cat >> "$outfile" <<EOF
 #endif //__BITS_PER_LONG != 64
 #endif // defined(ALL_SYSCALLTBL) || defined(__riscv)
 #if defined(ALL_SYSCALLTBL) || defined(__s390x__)
 EOF
-build_tables "$tools_dir/perf/arch/s390/entry/syscalls/syscall.tbl" "$outfile" common,64,renameat,rlimit,memfd_secret EM_S390
+build_tables "$tools_dir/perf/arch/s390/entry/syscalls/syscall.tbl" "$outfile" common,64,renameat,rlimit,memfd_secret,clone3 EM_S390 "$tools_dir/scripts/syscall_common.tbl"
 cat >> "$outfile" <<EOF
 #endif // defined(ALL_SYSCALLTBL) || defined(__s390x__)
 
@@ -162,9 +162,9 @@ cat >> "$outfile" <<EOF
 #if defined(ALL_SYSCALLTBL) || defined(__sparc64__) || defined(__sparc__)
 #if __BITS_PER_LONG != 64
 EOF
-build_tables "$tools_dir/perf/arch/sparc/entry/syscalls/syscall.tbl" "$outfile" common,32 EM_SPARC
+build_tables "$tools_dir/perf/arch/sparc/entry/syscalls/syscall.tbl" "$outfile" common,32,clone3 EM_SPARC "$tools_dir/scripts/syscall_common.tbl"
 echo "#else" >> "$outfile"
-build_tables "$tools_dir/perf/arch/sparc/entry/syscalls/syscall.tbl" "$outfile" common,64 EM_SPARC
+build_tables "$tools_dir/perf/arch/sparc/entry/syscalls/syscall.tbl" "$outfile" common,64,clone3 EM_SPARC "$tools_dir/scripts/syscall_common.tbl"
 cat >> "$outfile" <<EOF
 #endif //__BITS_PER_LONG != 64
 #endif // defined(ALL_SYSCALLTBL) || defined(__sparc64__) || defined(__sparc__)
@@ -184,9 +184,9 @@ cat >> "$outfile" <<EOF
 
 #if __BITS_PER_LONG != 64
 EOF
-build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32 EM_NONE
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,32,clone3 EM_NONE "$tools_dir/scripts/syscall_common.tbl"
 echo "#else" >> "$outfile"
-build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64 EM_NONE
+build_tables "$tools_dir/scripts/syscall.tbl" "$outfile" common,64,clone3 EM_NONE "$tools_dir/scripts/syscall_common.tbl"
 echo "#endif //__BITS_PER_LONG != 64" >> "$outfile"
 
 build_outer_table() {
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index 0ab531605120..ee828d03094e 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -344,72 +344,3 @@
 293	common	rseq				sys_rseq
 294	common	kexec_file_load			sys_kexec_file_load
 # 295 through 402 are unassigned to sync up with generic numbers don't use
-403	32	clock_gettime64			sys_clock_gettime
-404	32	clock_settime64			sys_clock_settime
-405	32	clock_adjtime64			sys_clock_adjtime
-406	32	clock_getres_time64		sys_clock_getres
-407	32	clock_nanosleep_time64		sys_clock_nanosleep
-408	32	timer_gettime64			sys_timer_gettime
-409	32	timer_settime64			sys_timer_settime
-410	32	timerfd_gettime64		sys_timerfd_gettime
-411	32	timerfd_settime64		sys_timerfd_settime
-412	32	utimensat_time64		sys_utimensat
-413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
-414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
-417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
-418	32	mq_timedsend_time64		sys_mq_timedsend
-419	32	mq_timedreceive_time64		sys_mq_timedreceive
-420	32	semtimedop_time64		sys_semtimedop
-421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
-422	32	futex_time64			sys_futex
-423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
-424	common	pidfd_send_signal		sys_pidfd_send_signal
-425	common	io_uring_setup			sys_io_uring_setup
-426	common	io_uring_enter			sys_io_uring_enter
-427	common	io_uring_register		sys_io_uring_register
-428	common	open_tree			sys_open_tree
-429	common	move_mount			sys_move_mount
-430	common	fsopen				sys_fsopen
-431	common	fsconfig			sys_fsconfig
-432	common	fsmount				sys_fsmount
-433	common	fspick				sys_fspick
-434	common	pidfd_open			sys_pidfd_open
-435	common	clone3				sys_clone3
-436	common	close_range			sys_close_range
-437	common	openat2				sys_openat2
-438	common	pidfd_getfd			sys_pidfd_getfd
-439	common	faccessat2			sys_faccessat2
-440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
-442	common	mount_setattr			sys_mount_setattr
-443	common	quotactl_fd			sys_quotactl_fd
-444	common	landlock_create_ruleset		sys_landlock_create_ruleset
-445	common	landlock_add_rule		sys_landlock_add_rule
-446	common	landlock_restrict_self		sys_landlock_restrict_self
-447	memfd_secret	memfd_secret		sys_memfd_secret
-448	common	process_mrelease		sys_process_mrelease
-449	common	futex_waitv			sys_futex_waitv
-450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	common	cachestat			sys_cachestat
-452	common	fchmodat2			sys_fchmodat2
-453	common	map_shadow_stack		sys_map_shadow_stack
-454	common	futex_wake			sys_futex_wake
-455	common	futex_wait			sys_futex_wait
-456	common	futex_requeue			sys_futex_requeue
-457	common	statmount			sys_statmount
-458	common	listmount			sys_listmount
-459	common	lsm_get_self_attr		sys_lsm_get_self_attr
-460	common	lsm_set_self_attr		sys_lsm_set_self_attr
-461	common	lsm_list_modules		sys_lsm_list_modules
-462	common	mseal				sys_mseal
-463	common	setxattrat			sys_setxattrat
-464	common	getxattrat			sys_getxattrat
-465	common	listxattrat			sys_listxattrat
-466	common	removexattrat			sys_removexattrat
-467	common	open_tree_attr			sys_open_tree_attr
-468	common	file_getattr			sys_file_getattr
-469	common	file_setattr			sys_file_setattr
-470	common	listns				sys_listns
-471	common	rseq_slice_yield		sys_rseq_slice_yield
-472	common	fchroot				sys_fchroot
diff --git a/tools/scripts/syscall_common.tbl b/tools/scripts/syscall_common.tbl
new file mode 100644
index 000000000000..8085030eb869
--- /dev/null
+++ b/tools/scripts/syscall_common.tbl
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# syscall numbers shared by all architectures
+#
+# The format is:
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
+#
+# The abi can be "32", "clone3", "__cln3" and "memfd_secret"
+#
+# clone3 stands for the common clone3 entry, used by most archs. Some archs have
+# their special entry and should use "__clone3".
+#
+# "memfd_secret" is not implemented by every architecture
+
+403	32	clock_gettime64			sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	clone3	clone3				sys_clone3
+435	__clone3	clone3			__sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+447	memfd_secret	memfd_secret		sys_memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
+463	common	setxattrat			sys_setxattrat
+464	common	getxattrat			sys_getxattrat
+465	common	listxattrat			sys_listxattrat
+466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
+468	common	file_getattr			sys_file_getattr
+469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	fchroot				sys_fchroot

-- 
2.56.1

