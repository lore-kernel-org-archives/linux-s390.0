Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909193;
	b=C093Ai/LWtIrn+d+th1L2eSFyAqAqUhhgJfzjQMaEyl8byNtloYdGejqHIK5RbGnHwxp
	 ybjP3skgDG3FmLAOCwGsCWlcC/4HxvaX9hc5tpaTwleQO9SmTaGFRrjNut/NbNTPw4kXO
	 fGKpP07jY0pDr+CIthb2HFLK+u9i7+HQGK81gdwn5Q7369yKsHOoxAFqyN/PLQQWtLvAc
	 qoI00ma3czVe20lYbB89MBf8furGJdJukjMTzmlad+79swNdZP+s8mIdO+ATUIQ90S/0w
	 2vXcwwrgldT9spuJXLeeVruGinCLXNATNbbnnUd7r+qdtQDFKtiX2wSZ4spL529Aqow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909193;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=7qPj8XOSDttIHWPTTEvCNWjLHhwbUUhznaMhy/A8Qjs=;
	b=W41RNqdV1VffccLrQK5w7Fb2q0EVNZxFhE8MFQA8j2mEoL7f+xopzuo9m2CXw4wNz4X5
	 tFxXivaeMNFWiuow1mtVqSjWSreVyZdBLq4lkbPoetPbgJDRUjxUariIO6G5QrMo/f4U1
	 zOFRDd3Z6QslQ6nsMHHuHTtFO0rCNpW6Yu9RrK9lGbLzm67H0BuPIT5BH4G3KAahoITLi
	 6qPJRALP1iJReCIwD8UBGgVg/Vw/YKYjp716kfyOgd910uaiHkd1BZhzlFpPKiw2EIC2E
	 lHYZrQyq6BJcEs+VpsFfyglCIvaeUfS1wqe8qABJ5G4/8J/HMe7yuc/W8YazEDl4+jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WBBLUrqT;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B19606D80D;
	Thu,  5 Nov 2026 20:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89B19606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WBBLUrqT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=7qPj8XOSDttIHWPTTEvCNWjLHhwbUUhznaMhy/A8Qjs=; t=1793909191; x=2109269191; 
	b=WBBLUrqTViWN/BReuWO85WOcFp4Nq3ig3GA6ZldmHqBRG9CojbL5UISqk1fYzKoPRQbtXXz+cbm
	r+ZUQmsJ7LnvzbwWP8mBUJn5Lu8DsxQMJLkiLoBKiD3ds9VS+puUzFKqQgiHwydlN8XUmYC9HWoP3
	cAxjIM+I5B4GhEHasIlDeXajxJHjG/H44my2wpSt+Gh1YL90i0JIE0ijU3kTJPPEyuPmUPVPnmnzM
	EzRTllOfceB61i/WmNBX3g6cBCw/F45Er90B5g8zbr2jEseLlUJTSkCjruHEaCAG0Iux7bPawB8+J
	f1lUlkL5zyjoCewc2hxJArCA3NGXR2hvAd6w==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3jA-003hS1-Jh; Thu, 05 Nov 2026 21:06:29 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:42 -0300
Subject: [PATCH v9 07/15] mips: Get rid of custom mips ABIs for syscall
 tables
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
Message-Id: <20261105-tonyk-syscall_table-v9-7-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Get rid of the mips exclusive ABIs for the syscall tables and replace them
with the common ABI names, replacing n32, o32 and n64 with common. The
common ABI names have no advantage for this files.

No functional change happens, but it simplifies and helps to unify the
tables.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
 - Change everything to "common"
---
 arch/mips/kernel/syscalls/syscall_n32.tbl | 802 +++++++++++++--------------
 arch/mips/kernel/syscalls/syscall_n64.tbl | 752 ++++++++++++-------------
 arch/mips/kernel/syscalls/syscall_o32.tbl | 894 +++++++++++++++---------------
 3 files changed, 1224 insertions(+), 1224 deletions(-)

diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 9ae88e4eac61..29df491b52b7 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -5,409 +5,409 @@
 # The format is:
 # <number> <abi> <name> <entry point> <compat entry point>
 #
-# The <abi> is always "n32" for this file.
+# The <abi> is always "common" for this file.
 #
-0	n32	read				sys_read
-1	n32	write				sys_write
-2	n32	open				sys_open
-3	n32	close				sys_close
-4	n32	stat				sys_newstat
-5	n32	fstat				sys_newfstat
-6	n32	lstat				sys_newlstat
-7	n32	poll				sys_poll
-8	n32	lseek				sys_lseek
-9	n32	mmap				sys_mips_mmap
-10	n32	mprotect			sys_mprotect
-11	n32	munmap				sys_munmap
-12	n32	brk				sys_brk
-13	n32	rt_sigaction			compat_sys_rt_sigaction
-14	n32	rt_sigprocmask			compat_sys_rt_sigprocmask
-15	n32	ioctl				compat_sys_ioctl
-16	n32	pread64				sys_pread64
-17	n32	pwrite64			sys_pwrite64
-18	n32	readv				sys_readv
-19	n32	writev				sys_writev
-20	n32	access				sys_access
-21	n32	pipe				sysm_pipe
-22	n32	_newselect			compat_sys_select
-23	n32	sched_yield			sys_sched_yield
-24	n32	mremap				sys_mremap
-25	n32	msync				sys_msync
-26	n32	mincore				sys_mincore
-27	n32	madvise				sys_madvise
-28	n32	shmget				sys_shmget
-29	n32	shmat				sys_shmat
-30	n32	shmctl				compat_sys_old_shmctl
-31	n32	dup				sys_dup
-32	n32	dup2				sys_dup2
-33	n32	pause				sys_pause
-34	n32	nanosleep			sys_nanosleep_time32
-35	n32	getitimer			compat_sys_getitimer
-36	n32	setitimer			compat_sys_setitimer
-37	n32	alarm				sys_alarm
-38	n32	getpid				sys_getpid
-39	n32	sendfile			compat_sys_sendfile
-40	n32	socket				sys_socket
-41	n32	connect				sys_connect
-42	n32	accept				sys_accept
-43	n32	sendto				sys_sendto
-44	n32	recvfrom			compat_sys_recvfrom
-45	n32	sendmsg				compat_sys_sendmsg
-46	n32	recvmsg				compat_sys_recvmsg
-47	n32	shutdown			sys_shutdown
-48	n32	bind				sys_bind
-49	n32	listen				sys_listen
-50	n32	getsockname			sys_getsockname
-51	n32	getpeername			sys_getpeername
-52	n32	socketpair			sys_socketpair
-53	n32	setsockopt			sys_setsockopt
-54	n32	getsockopt			sys_getsockopt
-55	n32	clone				__sys_clone
-56	n32	fork				__sys_fork
-57	n32	execve				compat_sys_execve
-58	n32	exit				sys_exit
-59	n32	wait4				compat_sys_wait4
-60	n32	kill				sys_kill
-61	n32	uname				sys_newuname
-62	n32	semget				sys_semget
-63	n32	semop				sys_semop
-64	n32	semctl				compat_sys_old_semctl
-65	n32	shmdt				sys_shmdt
-66	n32	msgget				sys_msgget
-67	n32	msgsnd				compat_sys_msgsnd
-68	n32	msgrcv				compat_sys_msgrcv
-69	n32	msgctl				compat_sys_old_msgctl
-70	n32	fcntl				compat_sys_fcntl
-71	n32	flock				sys_flock
-72	n32	fsync				sys_fsync
-73	n32	fdatasync			sys_fdatasync
-74	n32	truncate			sys_truncate
-75	n32	ftruncate			sys_ftruncate
-76	n32	getdents			compat_sys_getdents
-77	n32	getcwd				sys_getcwd
-78	n32	chdir				sys_chdir
-79	n32	fchdir				sys_fchdir
-80	n32	rename				sys_rename
-81	n32	mkdir				sys_mkdir
-82	n32	rmdir				sys_rmdir
-83	n32	creat				sys_creat
-84	n32	link				sys_link
-85	n32	unlink				sys_unlink
-86	n32	symlink				sys_symlink
-87	n32	readlink			sys_readlink
-88	n32	chmod				sys_chmod
-89	n32	fchmod				sys_fchmod
-90	n32	chown				sys_chown
-91	n32	fchown				sys_fchown
-92	n32	lchown				sys_lchown
-93	n32	umask				sys_umask
-94	n32	gettimeofday			compat_sys_gettimeofday
-95	n32	getrlimit			compat_sys_getrlimit
-96	n32	getrusage			compat_sys_getrusage
-97	n32	sysinfo				compat_sys_sysinfo
-98	n32	times				compat_sys_times
-99	n32	ptrace				compat_sys_ptrace
-100	n32	getuid				sys_getuid
-101	n32	syslog				sys_syslog
-102	n32	getgid				sys_getgid
-103	n32	setuid				sys_setuid
-104	n32	setgid				sys_setgid
-105	n32	geteuid				sys_geteuid
-106	n32	getegid				sys_getegid
-107	n32	setpgid				sys_setpgid
-108	n32	getppid				sys_getppid
-109	n32	getpgrp				sys_getpgrp
-110	n32	setsid				sys_setsid
-111	n32	setreuid			sys_setreuid
-112	n32	setregid			sys_setregid
-113	n32	getgroups			sys_getgroups
-114	n32	setgroups			sys_setgroups
-115	n32	setresuid			sys_setresuid
-116	n32	getresuid			sys_getresuid
-117	n32	setresgid			sys_setresgid
-118	n32	getresgid			sys_getresgid
-119	n32	getpgid				sys_getpgid
-120	n32	setfsuid			sys_setfsuid
-121	n32	setfsgid			sys_setfsgid
-122	n32	getsid				sys_getsid
-123	n32	capget				sys_capget
-124	n32	capset				sys_capset
-125	n32	rt_sigpending			compat_sys_rt_sigpending
-126	n32	rt_sigtimedwait			compat_sys_rt_sigtimedwait_time32
-127	n32	rt_sigqueueinfo			compat_sys_rt_sigqueueinfo
-128	n32	rt_sigsuspend			compat_sys_rt_sigsuspend
-129	n32	sigaltstack			compat_sys_sigaltstack
-130	n32	utime				sys_utime32
-131	n32	mknod				sys_mknod
-132	n32	personality			sys_32_personality
-133	n32	ustat				compat_sys_ustat
-134	n32	statfs				compat_sys_statfs
-135	n32	fstatfs				compat_sys_fstatfs
-136	n32	sysfs				sys_sysfs
-137	n32	getpriority			sys_getpriority
-138	n32	setpriority			sys_setpriority
-139	n32	sched_setparam			sys_sched_setparam
-140	n32	sched_getparam			sys_sched_getparam
-141	n32	sched_setscheduler		sys_sched_setscheduler
-142	n32	sched_getscheduler		sys_sched_getscheduler
-143	n32	sched_get_priority_max		sys_sched_get_priority_max
-144	n32	sched_get_priority_min		sys_sched_get_priority_min
-145	n32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
-146	n32	mlock				sys_mlock
-147	n32	munlock				sys_munlock
-148	n32	mlockall			sys_mlockall
-149	n32	munlockall			sys_munlockall
-150	n32	vhangup				sys_vhangup
-151	n32	pivot_root			sys_pivot_root
-152	n32	_sysctl				sys_ni_syscall
-153	n32	prctl				sys_prctl
-154	n32	adjtimex			sys_adjtimex_time32
-155	n32	setrlimit			compat_sys_setrlimit
-156	n32	chroot				sys_chroot
-157	n32	sync				sys_sync
-158	n32	acct				sys_acct
-159	n32	settimeofday			compat_sys_settimeofday
-160	n32	mount				sys_mount
-161	n32	umount2				sys_umount
-162	n32	swapon				sys_swapon
-163	n32	swapoff				sys_swapoff
-164	n32	reboot				sys_reboot
-165	n32	sethostname			sys_sethostname
-166	n32	setdomainname			sys_setdomainname
-167	n32	create_module			sys_ni_syscall
-168	n32	init_module			sys_init_module
-169	n32	delete_module			sys_delete_module
-170	n32	get_kernel_syms			sys_ni_syscall
-171	n32	query_module			sys_ni_syscall
-172	n32	quotactl			sys_quotactl
-173	n32	nfsservctl			sys_ni_syscall
-174	n32	getpmsg				sys_ni_syscall
-175	n32	putpmsg				sys_ni_syscall
-176	n32	afs_syscall			sys_ni_syscall
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
+13	common	rt_sigaction			compat_sys_rt_sigaction
+14	common	rt_sigprocmask			compat_sys_rt_sigprocmask
+15	common	ioctl				compat_sys_ioctl
+16	common	pread64				sys_pread64
+17	common	pwrite64			sys_pwrite64
+18	common	readv				sys_readv
+19	common	writev				sys_writev
+20	common	access				sys_access
+21	common	pipe				sysm_pipe
+22	common	_newselect			compat_sys_select
+23	common	sched_yield			sys_sched_yield
+24	common	mremap				sys_mremap
+25	common	msync				sys_msync
+26	common	mincore				sys_mincore
+27	common	madvise				sys_madvise
+28	common	shmget				sys_shmget
+29	common	shmat				sys_shmat
+30	common	shmctl				compat_sys_old_shmctl
+31	common	dup				sys_dup
+32	common	dup2				sys_dup2
+33	common	pause				sys_pause
+34	common	nanosleep			sys_nanosleep_time32
+35	common	getitimer			compat_sys_getitimer
+36	common	setitimer			compat_sys_setitimer
+37	common	alarm				sys_alarm
+38	common	getpid				sys_getpid
+39	common	sendfile			compat_sys_sendfile
+40	common	socket				sys_socket
+41	common	connect				sys_connect
+42	common	accept				sys_accept
+43	common	sendto				sys_sendto
+44	common	recvfrom			compat_sys_recvfrom
+45	common	sendmsg				compat_sys_sendmsg
+46	common	recvmsg				compat_sys_recvmsg
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
+57	common	execve				compat_sys_execve
+58	common	exit				sys_exit
+59	common	wait4				compat_sys_wait4
+60	common	kill				sys_kill
+61	common	uname				sys_newuname
+62	common	semget				sys_semget
+63	common	semop				sys_semop
+64	common	semctl				compat_sys_old_semctl
+65	common	shmdt				sys_shmdt
+66	common	msgget				sys_msgget
+67	common	msgsnd				compat_sys_msgsnd
+68	common	msgrcv				compat_sys_msgrcv
+69	common	msgctl				compat_sys_old_msgctl
+70	common	fcntl				compat_sys_fcntl
+71	common	flock				sys_flock
+72	common	fsync				sys_fsync
+73	common	fdatasync			sys_fdatasync
+74	common	truncate			sys_truncate
+75	common	ftruncate			sys_ftruncate
+76	common	getdents			compat_sys_getdents
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
+94	common	gettimeofday			compat_sys_gettimeofday
+95	common	getrlimit			compat_sys_getrlimit
+96	common	getrusage			compat_sys_getrusage
+97	common	sysinfo				compat_sys_sysinfo
+98	common	times				compat_sys_times
+99	common	ptrace				compat_sys_ptrace
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
+125	common	rt_sigpending			compat_sys_rt_sigpending
+126	common	rt_sigtimedwait			compat_sys_rt_sigtimedwait_time32
+127	common	rt_sigqueueinfo			compat_sys_rt_sigqueueinfo
+128	common	rt_sigsuspend			compat_sys_rt_sigsuspend
+129	common	sigaltstack			compat_sys_sigaltstack
+130	common	utime				sys_utime32
+131	common	mknod				sys_mknod
+132	common	personality			sys_32_personality
+133	common	ustat				compat_sys_ustat
+134	common	statfs				compat_sys_statfs
+135	common	fstatfs				compat_sys_fstatfs
+136	common	sysfs				sys_sysfs
+137	common	getpriority			sys_getpriority
+138	common	setpriority			sys_setpriority
+139	common	sched_setparam			sys_sched_setparam
+140	common	sched_getparam			sys_sched_getparam
+141	common	sched_setscheduler		sys_sched_setscheduler
+142	common	sched_getscheduler		sys_sched_getscheduler
+143	common	sched_get_priority_max		sys_sched_get_priority_max
+144	common	sched_get_priority_min		sys_sched_get_priority_min
+145	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+146	common	mlock				sys_mlock
+147	common	munlock				sys_munlock
+148	common	mlockall			sys_mlockall
+149	common	munlockall			sys_munlockall
+150	common	vhangup				sys_vhangup
+151	common	pivot_root			sys_pivot_root
+152	common	_sysctl				sys_ni_syscall
+153	common	prctl				sys_prctl
+154	common	adjtimex			sys_adjtimex_time32
+155	common	setrlimit			compat_sys_setrlimit
+156	common	chroot				sys_chroot
+157	common	sync				sys_sync
+158	common	acct				sys_acct
+159	common	settimeofday			compat_sys_settimeofday
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
-177	n32	reserved177			sys_ni_syscall
-178	n32	gettid				sys_gettid
-179	n32	readahead			sys_readahead
-180	n32	setxattr			sys_setxattr
-181	n32	lsetxattr			sys_lsetxattr
-182	n32	fsetxattr			sys_fsetxattr
-183	n32	getxattr			sys_getxattr
-184	n32	lgetxattr			sys_lgetxattr
-185	n32	fgetxattr			sys_fgetxattr
-186	n32	listxattr			sys_listxattr
-187	n32	llistxattr			sys_llistxattr
-188	n32	flistxattr			sys_flistxattr
-189	n32	removexattr			sys_removexattr
-190	n32	lremovexattr			sys_lremovexattr
-191	n32	fremovexattr			sys_fremovexattr
-192	n32	tkill				sys_tkill
-193	n32	reserved193			sys_ni_syscall
-194	n32	futex				sys_futex_time32
-195	n32	sched_setaffinity		compat_sys_sched_setaffinity
-196	n32	sched_getaffinity		compat_sys_sched_getaffinity
-197	n32	cacheflush			sys_cacheflush
-198	n32	cachectl			sys_cachectl
-199	n32	sysmips				__sys_sysmips
-200	n32	io_setup			compat_sys_io_setup
-201	n32	io_destroy			sys_io_destroy
-202	n32	io_getevents			sys_io_getevents_time32
-203	n32	io_submit			compat_sys_io_submit
-204	n32	io_cancel			sys_io_cancel
-205	n32	exit_group			sys_exit_group
-206	n32	lookup_dcookie			sys_ni_syscall
-207	n32	epoll_create			sys_epoll_create
-208	n32	epoll_ctl			sys_epoll_ctl
-209	n32	epoll_wait			sys_epoll_wait
-210	n32	remap_file_pages		sys_remap_file_pages
-211	n32	rt_sigreturn			sysn32_rt_sigreturn
-212	n32	fcntl64				compat_sys_fcntl64
-213	n32	set_tid_address			sys_set_tid_address
-214	n32	restart_syscall			sys_restart_syscall
-215	n32	semtimedop			sys_semtimedop_time32
-216	n32	fadvise64			sys_fadvise64_64
-217	n32	statfs64			compat_sys_statfs64
-218	n32	fstatfs64			compat_sys_fstatfs64
-219	n32	sendfile64			sys_sendfile64
-220	n32	timer_create			compat_sys_timer_create
-221	n32	timer_settime			sys_timer_settime32
-222	n32	timer_gettime			sys_timer_gettime32
-223	n32	timer_getoverrun		sys_timer_getoverrun
-224	n32	timer_delete			sys_timer_delete
-225	n32	clock_settime			sys_clock_settime32
-226	n32	clock_gettime			sys_clock_gettime32
-227	n32	clock_getres			sys_clock_getres_time32
-228	n32	clock_nanosleep			sys_clock_nanosleep_time32
-229	n32	tgkill				sys_tgkill
-230	n32	utimes				sys_utimes_time32
-231	n32	mbind				sys_mbind
-232	n32	get_mempolicy			sys_get_mempolicy
-233	n32	set_mempolicy			sys_set_mempolicy
-234	n32	mq_open				compat_sys_mq_open
-235	n32	mq_unlink			sys_mq_unlink
-236	n32	mq_timedsend			sys_mq_timedsend_time32
-237	n32	mq_timedreceive			sys_mq_timedreceive_time32
-238	n32	mq_notify			compat_sys_mq_notify
-239	n32	mq_getsetattr			compat_sys_mq_getsetattr
-240	n32	vserver				sys_ni_syscall
-241	n32	waitid				compat_sys_waitid
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
+194	common	futex				sys_futex_time32
+195	common	sched_setaffinity		compat_sys_sched_setaffinity
+196	common	sched_getaffinity		compat_sys_sched_getaffinity
+197	common	cacheflush			sys_cacheflush
+198	common	cachectl			sys_cachectl
+199	common	sysmips				__sys_sysmips
+200	common	io_setup			compat_sys_io_setup
+201	common	io_destroy			sys_io_destroy
+202	common	io_getevents			sys_io_getevents_time32
+203	common	io_submit			compat_sys_io_submit
+204	common	io_cancel			sys_io_cancel
+205	common	exit_group			sys_exit_group
+206	common	lookup_dcookie			sys_ni_syscall
+207	common	epoll_create			sys_epoll_create
+208	common	epoll_ctl			sys_epoll_ctl
+209	common	epoll_wait			sys_epoll_wait
+210	common	remap_file_pages		sys_remap_file_pages
+211	common	rt_sigreturn			sysn32_rt_sigreturn
+212	common	fcntl64				compat_sys_fcntl64
+213	common	set_tid_address			sys_set_tid_address
+214	common	restart_syscall			sys_restart_syscall
+215	common	semtimedop			sys_semtimedop_time32
+216	common	fadvise64			sys_fadvise64_64
+217	common	statfs64			compat_sys_statfs64
+218	common	fstatfs64			compat_sys_fstatfs64
+219	common	sendfile64			sys_sendfile64
+220	common	timer_create			compat_sys_timer_create
+221	common	timer_settime			sys_timer_settime32
+222	common	timer_gettime			sys_timer_gettime32
+223	common	timer_getoverrun		sys_timer_getoverrun
+224	common	timer_delete			sys_timer_delete
+225	common	clock_settime			sys_clock_settime32
+226	common	clock_gettime			sys_clock_gettime32
+227	common	clock_getres			sys_clock_getres_time32
+228	common	clock_nanosleep			sys_clock_nanosleep_time32
+229	common	tgkill				sys_tgkill
+230	common	utimes				sys_utimes_time32
+231	common	mbind				sys_mbind
+232	common	get_mempolicy			sys_get_mempolicy
+233	common	set_mempolicy			sys_set_mempolicy
+234	common	mq_open				compat_sys_mq_open
+235	common	mq_unlink			sys_mq_unlink
+236	common	mq_timedsend			sys_mq_timedsend_time32
+237	common	mq_timedreceive			sys_mq_timedreceive_time32
+238	common	mq_notify			compat_sys_mq_notify
+239	common	mq_getsetattr			compat_sys_mq_getsetattr
+240	common	vserver				sys_ni_syscall
+241	common	waitid				compat_sys_waitid
 # 242 was sys_setaltroot
-243	n32	add_key				sys_add_key
-244	n32	request_key			sys_request_key
-245	n32	keyctl				compat_sys_keyctl
-246	n32	set_thread_area			sys_set_thread_area
-247	n32	inotify_init			sys_inotify_init
-248	n32	inotify_add_watch		sys_inotify_add_watch
-249	n32	inotify_rm_watch		sys_inotify_rm_watch
-250	n32	migrate_pages			sys_migrate_pages
-251	n32	openat				sys_openat
-252	n32	mkdirat				sys_mkdirat
-253	n32	mknodat				sys_mknodat
-254	n32	fchownat			sys_fchownat
-255	n32	futimesat			sys_futimesat_time32
-256	n32	newfstatat			sys_newfstatat
-257	n32	unlinkat			sys_unlinkat
-258	n32	renameat			sys_renameat
-259	n32	linkat				sys_linkat
-260	n32	symlinkat			sys_symlinkat
-261	n32	readlinkat			sys_readlinkat
-262	n32	fchmodat			sys_fchmodat
-263	n32	faccessat			sys_faccessat
-264	n32	pselect6			compat_sys_pselect6_time32
-265	n32	ppoll				compat_sys_ppoll_time32
-266	n32	unshare				sys_unshare
-267	n32	splice				sys_splice
-268	n32	sync_file_range			sys_sync_file_range
-269	n32	tee				sys_tee
-270	n32	vmsplice			sys_vmsplice
-271	n32	move_pages			sys_move_pages
-272	n32	set_robust_list			compat_sys_set_robust_list
-273	n32	get_robust_list			compat_sys_get_robust_list
-274	n32	kexec_load			compat_sys_kexec_load
-275	n32	getcpu				sys_getcpu
-276	n32	epoll_pwait			compat_sys_epoll_pwait
-277	n32	ioprio_set			sys_ioprio_set
-278	n32	ioprio_get			sys_ioprio_get
-279	n32	utimensat			sys_utimensat_time32
-280	n32	signalfd			compat_sys_signalfd
-281	n32	timerfd				sys_ni_syscall
-282	n32	eventfd				sys_eventfd
-283	n32	fallocate			sys_fallocate
-284	n32	timerfd_create			sys_timerfd_create
-285	n32	timerfd_gettime			sys_timerfd_gettime32
-286	n32	timerfd_settime			sys_timerfd_settime32
-287	n32	signalfd4			compat_sys_signalfd4
-288	n32	eventfd2			sys_eventfd2
-289	n32	epoll_create1			sys_epoll_create1
-290	n32	dup3				sys_dup3
-291	n32	pipe2				sys_pipe2
-292	n32	inotify_init1			sys_inotify_init1
-293	n32	preadv				compat_sys_preadv
-294	n32	pwritev				compat_sys_pwritev
-295	n32	rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-296	n32	perf_event_open			sys_perf_event_open
-297	n32	accept4				sys_accept4
-298	n32	recvmmsg			compat_sys_recvmmsg_time32
-299	n32	getdents64			sys_getdents64
-300	n32	fanotify_init			sys_fanotify_init
-301	n32	fanotify_mark			sys_fanotify_mark
-302	n32	prlimit64			sys_prlimit64
-303	n32	name_to_handle_at		sys_name_to_handle_at
-304	n32	open_by_handle_at		sys_open_by_handle_at
-305	n32	clock_adjtime			sys_clock_adjtime32
-306	n32	syncfs				sys_syncfs
-307	n32	sendmmsg			compat_sys_sendmmsg
-308	n32	setns				sys_setns
-309	n32	process_vm_readv		sys_process_vm_readv
-310	n32	process_vm_writev		sys_process_vm_writev
-311	n32	kcmp				sys_kcmp
-312	n32	finit_module			sys_finit_module
-313	n32	sched_setattr			sys_sched_setattr
-314	n32	sched_getattr			sys_sched_getattr
-315	n32	renameat2			sys_renameat2
-316	n32	seccomp				sys_seccomp
-317	n32	getrandom			sys_getrandom
-318	n32	memfd_create			sys_memfd_create
-319	n32	bpf				sys_bpf
-320	n32	execveat			compat_sys_execveat
-321	n32	userfaultfd			sys_userfaultfd
-322	n32	membarrier			sys_membarrier
-323	n32	mlock2				sys_mlock2
-324	n32	copy_file_range			sys_copy_file_range
-325	n32	preadv2				compat_sys_preadv2
-326	n32	pwritev2			compat_sys_pwritev2
-327	n32	pkey_mprotect			sys_pkey_mprotect
-328	n32	pkey_alloc			sys_pkey_alloc
-329	n32	pkey_free			sys_pkey_free
-330	n32	statx				sys_statx
-331	n32	rseq				sys_rseq
-332	n32	io_pgetevents			compat_sys_io_pgetevents
+243	common	add_key				sys_add_key
+244	common	request_key			sys_request_key
+245	common	keyctl				compat_sys_keyctl
+246	common	set_thread_area			sys_set_thread_area
+247	common	inotify_init			sys_inotify_init
+248	common	inotify_add_watch		sys_inotify_add_watch
+249	common	inotify_rm_watch		sys_inotify_rm_watch
+250	common	migrate_pages			sys_migrate_pages
+251	common	openat				sys_openat
+252	common	mkdirat				sys_mkdirat
+253	common	mknodat				sys_mknodat
+254	common	fchownat			sys_fchownat
+255	common	futimesat			sys_futimesat_time32
+256	common	newfstatat			sys_newfstatat
+257	common	unlinkat			sys_unlinkat
+258	common	renameat			sys_renameat
+259	common	linkat				sys_linkat
+260	common	symlinkat			sys_symlinkat
+261	common	readlinkat			sys_readlinkat
+262	common	fchmodat			sys_fchmodat
+263	common	faccessat			sys_faccessat
+264	common	pselect6			compat_sys_pselect6_time32
+265	common	ppoll				compat_sys_ppoll_time32
+266	common	unshare				sys_unshare
+267	common	splice				sys_splice
+268	common	sync_file_range			sys_sync_file_range
+269	common	tee				sys_tee
+270	common	vmsplice			sys_vmsplice
+271	common	move_pages			sys_move_pages
+272	common	set_robust_list			compat_sys_set_robust_list
+273	common	get_robust_list			compat_sys_get_robust_list
+274	common	kexec_load			compat_sys_kexec_load
+275	common	getcpu				sys_getcpu
+276	common	epoll_pwait			compat_sys_epoll_pwait
+277	common	ioprio_set			sys_ioprio_set
+278	common	ioprio_get			sys_ioprio_get
+279	common	utimensat			sys_utimensat_time32
+280	common	signalfd			compat_sys_signalfd
+281	common	timerfd				sys_ni_syscall
+282	common	eventfd				sys_eventfd
+283	common	fallocate			sys_fallocate
+284	common	timerfd_create			sys_timerfd_create
+285	common	timerfd_gettime			sys_timerfd_gettime32
+286	common	timerfd_settime			sys_timerfd_settime32
+287	common	signalfd4			compat_sys_signalfd4
+288	common	eventfd2			sys_eventfd2
+289	common	epoll_create1			sys_epoll_create1
+290	common	dup3				sys_dup3
+291	common	pipe2				sys_pipe2
+292	common	inotify_init1			sys_inotify_init1
+293	common	preadv				compat_sys_preadv
+294	common	pwritev				compat_sys_pwritev
+295	common	rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+296	common	perf_event_open			sys_perf_event_open
+297	common	accept4				sys_accept4
+298	common	recvmmsg			compat_sys_recvmmsg_time32
+299	common	getdents64			sys_getdents64
+300	common	fanotify_init			sys_fanotify_init
+301	common	fanotify_mark			sys_fanotify_mark
+302	common	prlimit64			sys_prlimit64
+303	common	name_to_handle_at		sys_name_to_handle_at
+304	common	open_by_handle_at		sys_open_by_handle_at
+305	common	clock_adjtime			sys_clock_adjtime32
+306	common	syncfs				sys_syncfs
+307	common	sendmmsg			compat_sys_sendmmsg
+308	common	setns				sys_setns
+309	common	process_vm_readv		sys_process_vm_readv
+310	common	process_vm_writev		sys_process_vm_writev
+311	common	kcmp				sys_kcmp
+312	common	finit_module			sys_finit_module
+313	common	sched_setattr			sys_sched_setattr
+314	common	sched_getattr			sys_sched_getattr
+315	common	renameat2			sys_renameat2
+316	common	seccomp				sys_seccomp
+317	common	getrandom			sys_getrandom
+318	common	memfd_create			sys_memfd_create
+319	common	bpf				sys_bpf
+320	common	execveat			compat_sys_execveat
+321	common	userfaultfd			sys_userfaultfd
+322	common	membarrier			sys_membarrier
+323	common	mlock2				sys_mlock2
+324	common	copy_file_range			sys_copy_file_range
+325	common	preadv2				compat_sys_preadv2
+326	common	pwritev2			compat_sys_pwritev2
+327	common	pkey_mprotect			sys_pkey_mprotect
+328	common	pkey_alloc			sys_pkey_alloc
+329	common	pkey_free			sys_pkey_free
+330	common	statx				sys_statx
+331	common	rseq				sys_rseq
+332	common	io_pgetevents			compat_sys_io_pgetevents
 # 333 through 402 are unassigned to sync up with generic numbers
-403	n32	clock_gettime64			sys_clock_gettime
-404	n32	clock_settime64			sys_clock_settime
-405	n32	clock_adjtime64			sys_clock_adjtime
-406	n32	clock_getres_time64		sys_clock_getres
-407	n32	clock_nanosleep_time64		sys_clock_nanosleep
-408	n32	timer_gettime64			sys_timer_gettime
-409	n32	timer_settime64			sys_timer_settime
-410	n32	timerfd_gettime64		sys_timerfd_gettime
-411	n32	timerfd_settime64		sys_timerfd_settime
-412	n32	utimensat_time64		sys_utimensat
-413	n32	pselect6_time64			compat_sys_pselect6_time64
-414	n32	ppoll_time64			compat_sys_ppoll_time64
-416	n32	io_pgetevents_time64		compat_sys_io_pgetevents_time64
-417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
-418	n32	mq_timedsend_time64		sys_mq_timedsend
-419	n32	mq_timedreceive_time64		sys_mq_timedreceive
-420	n32	semtimedop_time64		sys_semtimedop
-421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
-422	n32	futex_time64			sys_futex
-423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
-424	n32	pidfd_send_signal		sys_pidfd_send_signal
-425	n32	io_uring_setup			sys_io_uring_setup
-426	n32	io_uring_enter			sys_io_uring_enter
-427	n32	io_uring_register		sys_io_uring_register
-428	n32	open_tree			sys_open_tree
-429	n32	move_mount			sys_move_mount
-430	n32	fsopen				sys_fsopen
-431	n32	fsconfig			sys_fsconfig
-432	n32	fsmount				sys_fsmount
-433	n32	fspick				sys_fspick
-434	n32	pidfd_open			sys_pidfd_open
-435	n32	clone3				__sys_clone3
-436	n32	close_range			sys_close_range
-437	n32	openat2				sys_openat2
-438	n32	pidfd_getfd			sys_pidfd_getfd
-439	n32	faccessat2			sys_faccessat2
-440	n32	process_madvise			sys_process_madvise
-441	n32	epoll_pwait2			compat_sys_epoll_pwait2
-442	n32	mount_setattr			sys_mount_setattr
-443	n32	quotactl_fd			sys_quotactl_fd
-444	n32	landlock_create_ruleset		sys_landlock_create_ruleset
-445	n32	landlock_add_rule		sys_landlock_add_rule
-446	n32	landlock_restrict_self		sys_landlock_restrict_self
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			compat_sys_pselect6_time64
+414	common	ppoll_time64			compat_sys_ppoll_time64
+416	common	io_pgetevents_time64		compat_sys_io_pgetevents_time64
+417	common	recvmmsg_time64			compat_sys_recvmmsg_time64
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
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
+435	common	clone3				__sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
-448	n32	process_mrelease		sys_process_mrelease
-449	n32	futex_waitv			sys_futex_waitv
-450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	n32	cachestat			sys_cachestat
-452	n32	fchmodat2			sys_fchmodat2
-453	n32	map_shadow_stack		sys_map_shadow_stack
-454	n32	futex_wake			sys_futex_wake
-455	n32	futex_wait			sys_futex_wait
-456	n32	futex_requeue			sys_futex_requeue
-457	n32	statmount			sys_statmount
-458	n32	listmount			sys_listmount
-459	n32	lsm_get_self_attr		sys_lsm_get_self_attr
-460	n32	lsm_set_self_attr		sys_lsm_set_self_attr
-461	n32	lsm_list_modules		sys_lsm_list_modules
-462	n32	mseal				sys_mseal
-463	n32	setxattrat			sys_setxattrat
-464	n32	getxattrat			sys_getxattrat
-465	n32	listxattrat			sys_listxattrat
-466	n32	removexattrat			sys_removexattrat
-467	n32	open_tree_attr			sys_open_tree_attr
-468	n32	file_getattr			sys_file_getattr
-469	n32	file_setattr			sys_file_setattr
-470	n32	listns				sys_listns
-471	n32	rseq_slice_yield		sys_rseq_slice_yield
-472	n32	fchroot				sys_fchroot
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
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 83dc93a0712f..4341b2fd96da 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -5,385 +5,385 @@
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
+435	common	clone3				__sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
 # 447 reserved for memfd_secret
-448	n64	process_mrelease		sys_process_mrelease
-449	n64	futex_waitv			sys_futex_waitv
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
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
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 9c62429c9b7b..c38417e79db8 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -5,458 +5,458 @@
 # The format is:
 # <number> <abi> <name> <entry point> <compat entry point>
 #
-# The <abi> is always "o32" for this file.
+# The <abi> is always "common" for this file.
 #
-0	o32	syscall				sys_syscall			sys32_syscall
-1	o32	exit				sys_exit
-2	o32	fork				__sys_fork
-3	o32	read				sys_read
-4	o32	write				sys_write
-5	o32	open				sys_open			compat_sys_open
-6	o32	close				sys_close
-7	o32	waitpid				sys_waitpid
-8	o32	creat				sys_creat
-9	o32	link				sys_link
-10	o32	unlink				sys_unlink
-11	o32	execve				sys_execve			compat_sys_execve
-12	o32	chdir				sys_chdir
-13	o32	time				sys_time32
-14	o32	mknod				sys_mknod
-15	o32	chmod				sys_chmod
-16	o32	lchown				sys_lchown
-17	o32	break				sys_ni_syscall
+0	common	syscall				sys_syscall			sys32_syscall
+1	common	exit				sys_exit
+2	common	fork				__sys_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	open				sys_open			compat_sys_open
+6	common	close				sys_close
+7	common	waitpid				sys_waitpid
+8	common	creat				sys_creat
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	common	execve				sys_execve			compat_sys_execve
+12	common	chdir				sys_chdir
+13	common	time				sys_time32
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+16	common	lchown				sys_lchown
+17	common	break				sys_ni_syscall
 # 18 was sys_stat
-18	o32	unused18			sys_ni_syscall
-19	o32	lseek				sys_lseek			compat_sys_lseek
-20	o32	getpid				sys_getpid
-21	o32	mount				sys_mount
-22	o32	umount				sys_oldumount
-23	o32	setuid				sys_setuid
-24	o32	getuid				sys_getuid
-25	o32	stime				sys_stime32
-26	o32	ptrace				sys_ptrace			compat_sys_ptrace
-27	o32	alarm				sys_alarm
+18	common	unused18			sys_ni_syscall
+19	common	lseek				sys_lseek			compat_sys_lseek
+20	common	getpid				sys_getpid
+21	common	mount				sys_mount
+22	common	umount				sys_oldumount
+23	common	setuid				sys_setuid
+24	common	getuid				sys_getuid
+25	common	stime				sys_stime32
+26	common	ptrace				sys_ptrace			compat_sys_ptrace
+27	common	alarm				sys_alarm
 # 28 was sys_fstat
-28	o32	unused28			sys_ni_syscall
-29	o32	pause				sys_pause
-30	o32	utime				sys_utime32
-31	o32	stty				sys_ni_syscall
-32	o32	gtty				sys_ni_syscall
-33	o32	access				sys_access
-34	o32	nice				sys_nice
-35	o32	ftime				sys_ni_syscall
-36	o32	sync				sys_sync
-37	o32	kill				sys_kill
-38	o32	rename				sys_rename
-39	o32	mkdir				sys_mkdir
-40	o32	rmdir				sys_rmdir
-41	o32	dup				sys_dup
-42	o32	pipe				sysm_pipe
-43	o32	times				sys_times			compat_sys_times
-44	o32	prof				sys_ni_syscall
-45	o32	brk				sys_brk
-46	o32	setgid				sys_setgid
-47	o32	getgid				sys_getgid
-48	o32	signal				sys_ni_syscall
-49	o32	geteuid				sys_geteuid
-50	o32	getegid				sys_getegid
-51	o32	acct				sys_acct
-52	o32	umount2				sys_umount
-53	o32	lock				sys_ni_syscall
-54	o32	ioctl				sys_ioctl			compat_sys_ioctl
-55	o32	fcntl				sys_fcntl			compat_sys_fcntl
-56	o32	mpx				sys_ni_syscall
-57	o32	setpgid				sys_setpgid
-58	o32	ulimit				sys_ni_syscall
-59	o32	unused59			sys_olduname
-60	o32	umask				sys_umask
-61	o32	chroot				sys_chroot
-62	o32	ustat				sys_ustat			compat_sys_ustat
-63	o32	dup2				sys_dup2
-64	o32	getppid				sys_getppid
-65	o32	getpgrp				sys_getpgrp
-66	o32	setsid				sys_setsid
-67	o32	sigaction			sys_sigaction			sys_32_sigaction
-68	o32	sgetmask			sys_sgetmask
-69	o32	ssetmask			sys_ssetmask
-70	o32	setreuid			sys_setreuid
-71	o32	setregid			sys_setregid
-72	o32	sigsuspend			sys_sigsuspend			sys32_sigsuspend
-73	o32	sigpending			sys_sigpending			compat_sys_sigpending
-74	o32	sethostname			sys_sethostname
-75	o32	setrlimit			sys_setrlimit			compat_sys_setrlimit
-76	o32	getrlimit			sys_getrlimit			compat_sys_getrlimit
-77	o32	getrusage			sys_getrusage			compat_sys_getrusage
-78	o32	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
-79	o32	settimeofday			sys_settimeofday		compat_sys_settimeofday
-80	o32	getgroups			sys_getgroups
-81	o32	setgroups			sys_setgroups
+28	common	unused28			sys_ni_syscall
+29	common	pause				sys_pause
+30	common	utime				sys_utime32
+31	common	stty				sys_ni_syscall
+32	common	gtty				sys_ni_syscall
+33	common	access				sys_access
+34	common	nice				sys_nice
+35	common	ftime				sys_ni_syscall
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	rename				sys_rename
+39	common	mkdir				sys_mkdir
+40	common	rmdir				sys_rmdir
+41	common	dup				sys_dup
+42	common	pipe				sysm_pipe
+43	common	times				sys_times			compat_sys_times
+44	common	prof				sys_ni_syscall
+45	common	brk				sys_brk
+46	common	setgid				sys_setgid
+47	common	getgid				sys_getgid
+48	common	signal				sys_ni_syscall
+49	common	geteuid				sys_geteuid
+50	common	getegid				sys_getegid
+51	common	acct				sys_acct
+52	common	umount2				sys_umount
+53	common	lock				sys_ni_syscall
+54	common	ioctl				sys_ioctl			compat_sys_ioctl
+55	common	fcntl				sys_fcntl			compat_sys_fcntl
+56	common	mpx				sys_ni_syscall
+57	common	setpgid				sys_setpgid
+58	common	ulimit				sys_ni_syscall
+59	common	unused59			sys_olduname
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	common	ustat				sys_ustat			compat_sys_ustat
+63	common	dup2				sys_dup2
+64	common	getppid				sys_getppid
+65	common	getpgrp				sys_getpgrp
+66	common	setsid				sys_setsid
+67	common	sigaction			sys_sigaction			sys_32_sigaction
+68	common	sgetmask			sys_sgetmask
+69	common	ssetmask			sys_ssetmask
+70	common	setreuid			sys_setreuid
+71	common	setregid			sys_setregid
+72	common	sigsuspend			sys_sigsuspend			sys32_sigsuspend
+73	common	sigpending			sys_sigpending			compat_sys_sigpending
+74	common	sethostname			sys_sethostname
+75	common	setrlimit			sys_setrlimit			compat_sys_setrlimit
+76	common	getrlimit			sys_getrlimit			compat_sys_getrlimit
+77	common	getrusage			sys_getrusage			compat_sys_getrusage
+78	common	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
+80	common	getgroups			sys_getgroups
+81	common	setgroups			sys_setgroups
 # 82 was old_select
-82	o32	reserved82			sys_ni_syscall
-83	o32	symlink				sys_symlink
+82	common	reserved82			sys_ni_syscall
+83	common	symlink				sys_symlink
 # 84 was sys_lstat
-84	o32	unused84			sys_ni_syscall
-85	o32	readlink			sys_readlink
-86	o32	uselib				sys_uselib
-87	o32	swapon				sys_swapon
-88	o32	reboot				sys_reboot
-89	o32	readdir				sys_old_readdir			compat_sys_old_readdir
-90	o32	mmap				sys_mips_mmap
-91	o32	munmap				sys_munmap
-92	o32	truncate			sys_truncate			compat_sys_truncate
-93	o32	ftruncate			sys_ftruncate			compat_sys_ftruncate
-94	o32	fchmod				sys_fchmod
-95	o32	fchown				sys_fchown
-96	o32	getpriority			sys_getpriority
-97	o32	setpriority			sys_setpriority
-98	o32	profil				sys_ni_syscall
-99	o32	statfs				sys_statfs			compat_sys_statfs
-100	o32	fstatfs				sys_fstatfs			compat_sys_fstatfs
-101	o32	ioperm				sys_ni_syscall
-102	o32	socketcall			sys_socketcall			compat_sys_socketcall
-103	o32	syslog				sys_syslog
-104	o32	setitimer			sys_setitimer			compat_sys_setitimer
-105	o32	getitimer			sys_getitimer			compat_sys_getitimer
-106	o32	stat				sys_newstat			compat_sys_newstat
-107	o32	lstat				sys_newlstat			compat_sys_newlstat
-108	o32	fstat				sys_newfstat			compat_sys_newfstat
-109	o32	unused109			sys_uname
-110	o32	iopl				sys_ni_syscall
-111	o32	vhangup				sys_vhangup
-112	o32	idle				sys_ni_syscall
-113	o32	vm86				sys_ni_syscall
-114	o32	wait4				sys_wait4			compat_sys_wait4
-115	o32	swapoff				sys_swapoff
-116	o32	sysinfo				sys_sysinfo			compat_sys_sysinfo
-117	o32	ipc				sys_ipc				compat_sys_ipc
-118	o32	fsync				sys_fsync
-119	o32	sigreturn			sys_sigreturn			sys32_sigreturn
-120	o32	clone				__sys_clone
-121	o32	setdomainname			sys_setdomainname
-122	o32	uname				sys_newuname
-123	o32	modify_ldt			sys_ni_syscall
-124	o32	adjtimex			sys_adjtimex_time32
-125	o32	mprotect			sys_mprotect
-126	o32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
-127	o32	create_module			sys_ni_syscall
-128	o32	init_module			sys_init_module
-129	o32	delete_module			sys_delete_module
-130	o32	get_kernel_syms			sys_ni_syscall
-131	o32	quotactl			sys_quotactl
-132	o32	getpgid				sys_getpgid
-133	o32	fchdir				sys_fchdir
-134	o32	bdflush				sys_ni_syscall
-135	o32	sysfs				sys_sysfs
-136	o32	personality			sys_personality			sys_32_personality
-137	o32	afs_syscall			sys_ni_syscall
-138	o32	setfsuid			sys_setfsuid
-139	o32	setfsgid			sys_setfsgid
-140	o32	_llseek				sys_llseek			sys_32_llseek
-141	o32	getdents			sys_getdents			compat_sys_getdents
-142	o32	_newselect			sys_select			compat_sys_select
-143	o32	flock				sys_flock
-144	o32	msync				sys_msync
-145	o32	readv				sys_readv
-146	o32	writev				sys_writev
-147	o32	cacheflush			sys_cacheflush
-148	o32	cachectl			sys_cachectl
-149	o32	sysmips				__sys_sysmips
-150	o32	unused150			sys_ni_syscall
-151	o32	getsid				sys_getsid
-152	o32	fdatasync			sys_fdatasync
-153	o32	_sysctl				sys_ni_syscall
-154	o32	mlock				sys_mlock
-155	o32	munlock				sys_munlock
-156	o32	mlockall			sys_mlockall
-157	o32	munlockall			sys_munlockall
-158	o32	sched_setparam			sys_sched_setparam
-159	o32	sched_getparam			sys_sched_getparam
-160	o32	sched_setscheduler		sys_sched_setscheduler
-161	o32	sched_getscheduler		sys_sched_getscheduler
-162	o32	sched_yield			sys_sched_yield
-163	o32	sched_get_priority_max		sys_sched_get_priority_max
-164	o32	sched_get_priority_min		sys_sched_get_priority_min
-165	o32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
-166	o32	nanosleep			sys_nanosleep_time32
-167	o32	mremap				sys_mremap
-168	o32	accept				sys_accept
-169	o32	bind				sys_bind
-170	o32	connect				sys_connect
-171	o32	getpeername			sys_getpeername
-172	o32	getsockname			sys_getsockname
-173	o32	getsockopt			sys_getsockopt			sys_getsockopt
-174	o32	listen				sys_listen
-175	o32	recv				sys_recv			compat_sys_recv
-176	o32	recvfrom			sys_recvfrom			compat_sys_recvfrom
-177	o32	recvmsg				sys_recvmsg			compat_sys_recvmsg
-178	o32	send				sys_send
-179	o32	sendmsg				sys_sendmsg			compat_sys_sendmsg
-180	o32	sendto				sys_sendto
-181	o32	setsockopt			sys_setsockopt			sys_setsockopt
-182	o32	shutdown			sys_shutdown
-183	o32	socket				sys_socket
-184	o32	socketpair			sys_socketpair
-185	o32	setresuid			sys_setresuid
-186	o32	getresuid			sys_getresuid
-187	o32	query_module			sys_ni_syscall
-188	o32	poll				sys_poll
-189	o32	nfsservctl			sys_ni_syscall
-190	o32	setresgid			sys_setresgid
-191	o32	getresgid			sys_getresgid
-192	o32	prctl				sys_prctl
-193	o32	rt_sigreturn			sys_rt_sigreturn		sys32_rt_sigreturn
-194	o32	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
-195	o32	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
-196	o32	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
-197	o32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
-198	o32	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-199	o32	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-200	o32	pread64				sys_pread64			sys_32_pread
-201	o32	pwrite64			sys_pwrite64			sys_32_pwrite
-202	o32	chown				sys_chown
-203	o32	getcwd				sys_getcwd
-204	o32	capget				sys_capget
-205	o32	capset				sys_capset
-206	o32	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
-207	o32	sendfile			sys_sendfile			compat_sys_sendfile
-208	o32	getpmsg				sys_ni_syscall
-209	o32	putpmsg				sys_ni_syscall
-210	o32	mmap2				sys_mips_mmap2
-211	o32	truncate64			sys_truncate64			sys_32_truncate64
-212	o32	ftruncate64			sys_ftruncate64			sys_32_ftruncate64
-213	o32	stat64				sys_stat64			sys_newstat
-214	o32	lstat64				sys_lstat64			sys_newlstat
-215	o32	fstat64				sys_fstat64			sys_newfstat
-216	o32	pivot_root			sys_pivot_root
-217	o32	mincore				sys_mincore
-218	o32	madvise				sys_madvise
-219	o32	getdents64			sys_getdents64
-220	o32	fcntl64				sys_fcntl64			compat_sys_fcntl64
-221	o32	reserved221			sys_ni_syscall
-222	o32	gettid				sys_gettid
-223	o32	readahead			sys_readahead			sys32_readahead
-224	o32	setxattr			sys_setxattr
-225	o32	lsetxattr			sys_lsetxattr
-226	o32	fsetxattr			sys_fsetxattr
-227	o32	getxattr			sys_getxattr
-228	o32	lgetxattr			sys_lgetxattr
-229	o32	fgetxattr			sys_fgetxattr
-230	o32	listxattr			sys_listxattr
-231	o32	llistxattr			sys_llistxattr
-232	o32	flistxattr			sys_flistxattr
-233	o32	removexattr			sys_removexattr
-234	o32	lremovexattr			sys_lremovexattr
-235	o32	fremovexattr			sys_fremovexattr
-236	o32	tkill				sys_tkill
-237	o32	sendfile64			sys_sendfile64
-238	o32	futex				sys_futex_time32
-239	o32	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
-240	o32	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
-241	o32	io_setup			sys_io_setup			compat_sys_io_setup
-242	o32	io_destroy			sys_io_destroy
-243	o32	io_getevents			sys_io_getevents_time32
-244	o32	io_submit			sys_io_submit			compat_sys_io_submit
-245	o32	io_cancel			sys_io_cancel
-246	o32	exit_group			sys_exit_group
-247	o32	lookup_dcookie			sys_ni_syscall
-248	o32	epoll_create			sys_epoll_create
-249	o32	epoll_ctl			sys_epoll_ctl
-250	o32	epoll_wait			sys_epoll_wait
-251	o32	remap_file_pages		sys_remap_file_pages
-252	o32	set_tid_address			sys_set_tid_address
-253	o32	restart_syscall			sys_restart_syscall
-254	o32	fadvise64			sys_fadvise64_64		sys32_fadvise64_64
-255	o32	statfs64			sys_statfs64			compat_sys_statfs64
-256	o32	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
-257	o32	timer_create			sys_timer_create		compat_sys_timer_create
-258	o32	timer_settime			sys_timer_settime32
-259	o32	timer_gettime			sys_timer_gettime32
-260	o32	timer_getoverrun		sys_timer_getoverrun
-261	o32	timer_delete			sys_timer_delete
-262	o32	clock_settime			sys_clock_settime32
-263	o32	clock_gettime			sys_clock_gettime32
-264	o32	clock_getres			sys_clock_getres_time32
-265	o32	clock_nanosleep			sys_clock_nanosleep_time32
-266	o32	tgkill				sys_tgkill
-267	o32	utimes				sys_utimes_time32
-268	o32	mbind				sys_mbind
-269	o32	get_mempolicy			sys_get_mempolicy
-270	o32	set_mempolicy			sys_set_mempolicy
-271	o32	mq_open				sys_mq_open			compat_sys_mq_open
-272	o32	mq_unlink			sys_mq_unlink
-273	o32	mq_timedsend			sys_mq_timedsend_time32
-274	o32	mq_timedreceive			sys_mq_timedreceive_time32
-275	o32	mq_notify			sys_mq_notify			compat_sys_mq_notify
-276	o32	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
-277	o32	vserver				sys_ni_syscall
-278	o32	waitid				sys_waitid			compat_sys_waitid
+84	common	unused84			sys_ni_syscall
+85	common	readlink			sys_readlink
+86	common	uselib				sys_uselib
+87	common	swapon				sys_swapon
+88	common	reboot				sys_reboot
+89	common	readdir				sys_old_readdir			compat_sys_old_readdir
+90	common	mmap				sys_mips_mmap
+91	common	munmap				sys_munmap
+92	common	truncate			sys_truncate			compat_sys_truncate
+93	common	ftruncate			sys_ftruncate			compat_sys_ftruncate
+94	common	fchmod				sys_fchmod
+95	common	fchown				sys_fchown
+96	common	getpriority			sys_getpriority
+97	common	setpriority			sys_setpriority
+98	common	profil				sys_ni_syscall
+99	common	statfs				sys_statfs			compat_sys_statfs
+100	common	fstatfs				sys_fstatfs			compat_sys_fstatfs
+101	common	ioperm				sys_ni_syscall
+102	common	socketcall			sys_socketcall			compat_sys_socketcall
+103	common	syslog				sys_syslog
+104	common	setitimer			sys_setitimer			compat_sys_setitimer
+105	common	getitimer			sys_getitimer			compat_sys_getitimer
+106	common	stat				sys_newstat			compat_sys_newstat
+107	common	lstat				sys_newlstat			compat_sys_newlstat
+108	common	fstat				sys_newfstat			compat_sys_newfstat
+109	common	unused109			sys_uname
+110	common	iopl				sys_ni_syscall
+111	common	vhangup				sys_vhangup
+112	common	idle				sys_ni_syscall
+113	common	vm86				sys_ni_syscall
+114	common	wait4				sys_wait4			compat_sys_wait4
+115	common	swapoff				sys_swapoff
+116	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
+117	common	ipc				sys_ipc				compat_sys_ipc
+118	common	fsync				sys_fsync
+119	common	sigreturn			sys_sigreturn			sys32_sigreturn
+120	common	clone				__sys_clone
+121	common	setdomainname			sys_setdomainname
+122	common	uname				sys_newuname
+123	common	modify_ldt			sys_ni_syscall
+124	common	adjtimex			sys_adjtimex_time32
+125	common	mprotect			sys_mprotect
+126	common	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
+127	common	create_module			sys_ni_syscall
+128	common	init_module			sys_init_module
+129	common	delete_module			sys_delete_module
+130	common	get_kernel_syms			sys_ni_syscall
+131	common	quotactl			sys_quotactl
+132	common	getpgid				sys_getpgid
+133	common	fchdir				sys_fchdir
+134	common	bdflush				sys_ni_syscall
+135	common	sysfs				sys_sysfs
+136	common	personality			sys_personality			sys_32_personality
+137	common	afs_syscall			sys_ni_syscall
+138	common	setfsuid			sys_setfsuid
+139	common	setfsgid			sys_setfsgid
+140	common	_llseek				sys_llseek			sys_32_llseek
+141	common	getdents			sys_getdents			compat_sys_getdents
+142	common	_newselect			sys_select			compat_sys_select
+143	common	flock				sys_flock
+144	common	msync				sys_msync
+145	common	readv				sys_readv
+146	common	writev				sys_writev
+147	common	cacheflush			sys_cacheflush
+148	common	cachectl			sys_cachectl
+149	common	sysmips				__sys_sysmips
+150	common	unused150			sys_ni_syscall
+151	common	getsid				sys_getsid
+152	common	fdatasync			sys_fdatasync
+153	common	_sysctl				sys_ni_syscall
+154	common	mlock				sys_mlock
+155	common	munlock				sys_munlock
+156	common	mlockall			sys_mlockall
+157	common	munlockall			sys_munlockall
+158	common	sched_setparam			sys_sched_setparam
+159	common	sched_getparam			sys_sched_getparam
+160	common	sched_setscheduler		sys_sched_setscheduler
+161	common	sched_getscheduler		sys_sched_getscheduler
+162	common	sched_yield			sys_sched_yield
+163	common	sched_get_priority_max		sys_sched_get_priority_max
+164	common	sched_get_priority_min		sys_sched_get_priority_min
+165	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+166	common	nanosleep			sys_nanosleep_time32
+167	common	mremap				sys_mremap
+168	common	accept				sys_accept
+169	common	bind				sys_bind
+170	common	connect				sys_connect
+171	common	getpeername			sys_getpeername
+172	common	getsockname			sys_getsockname
+173	common	getsockopt			sys_getsockopt			sys_getsockopt
+174	common	listen				sys_listen
+175	common	recv				sys_recv			compat_sys_recv
+176	common	recvfrom			sys_recvfrom			compat_sys_recvfrom
+177	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
+178	common	send				sys_send
+179	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
+180	common	sendto				sys_sendto
+181	common	setsockopt			sys_setsockopt			sys_setsockopt
+182	common	shutdown			sys_shutdown
+183	common	socket				sys_socket
+184	common	socketpair			sys_socketpair
+185	common	setresuid			sys_setresuid
+186	common	getresuid			sys_getresuid
+187	common	query_module			sys_ni_syscall
+188	common	poll				sys_poll
+189	common	nfsservctl			sys_ni_syscall
+190	common	setresgid			sys_setresgid
+191	common	getresgid			sys_getresgid
+192	common	prctl				sys_prctl
+193	common	rt_sigreturn			sys_rt_sigreturn		sys32_rt_sigreturn
+194	common	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+195	common	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+196	common	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+197	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+198	common	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+199	common	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+200	common	pread64				sys_pread64			sys_32_pread
+201	common	pwrite64			sys_pwrite64			sys_32_pwrite
+202	common	chown				sys_chown
+203	common	getcwd				sys_getcwd
+204	common	capget				sys_capget
+205	common	capset				sys_capset
+206	common	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+207	common	sendfile			sys_sendfile			compat_sys_sendfile
+208	common	getpmsg				sys_ni_syscall
+209	common	putpmsg				sys_ni_syscall
+210	common	mmap2				sys_mips_mmap2
+211	common	truncate64			sys_truncate64			sys_32_truncate64
+212	common	ftruncate64			sys_ftruncate64			sys_32_ftruncate64
+213	common	stat64				sys_stat64			sys_newstat
+214	common	lstat64				sys_lstat64			sys_newlstat
+215	common	fstat64				sys_fstat64			sys_newfstat
+216	common	pivot_root			sys_pivot_root
+217	common	mincore				sys_mincore
+218	common	madvise				sys_madvise
+219	common	getdents64			sys_getdents64
+220	common	fcntl64				sys_fcntl64			compat_sys_fcntl64
+221	common	reserved221			sys_ni_syscall
+222	common	gettid				sys_gettid
+223	common	readahead			sys_readahead			sys32_readahead
+224	common	setxattr			sys_setxattr
+225	common	lsetxattr			sys_lsetxattr
+226	common	fsetxattr			sys_fsetxattr
+227	common	getxattr			sys_getxattr
+228	common	lgetxattr			sys_lgetxattr
+229	common	fgetxattr			sys_fgetxattr
+230	common	listxattr			sys_listxattr
+231	common	llistxattr			sys_llistxattr
+232	common	flistxattr			sys_flistxattr
+233	common	removexattr			sys_removexattr
+234	common	lremovexattr			sys_lremovexattr
+235	common	fremovexattr			sys_fremovexattr
+236	common	tkill				sys_tkill
+237	common	sendfile64			sys_sendfile64
+238	common	futex				sys_futex_time32
+239	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+240	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+241	common	io_setup			sys_io_setup			compat_sys_io_setup
+242	common	io_destroy			sys_io_destroy
+243	common	io_getevents			sys_io_getevents_time32
+244	common	io_submit			sys_io_submit			compat_sys_io_submit
+245	common	io_cancel			sys_io_cancel
+246	common	exit_group			sys_exit_group
+247	common	lookup_dcookie			sys_ni_syscall
+248	common	epoll_create			sys_epoll_create
+249	common	epoll_ctl			sys_epoll_ctl
+250	common	epoll_wait			sys_epoll_wait
+251	common	remap_file_pages		sys_remap_file_pages
+252	common	set_tid_address			sys_set_tid_address
+253	common	restart_syscall			sys_restart_syscall
+254	common	fadvise64			sys_fadvise64_64		sys32_fadvise64_64
+255	common	statfs64			sys_statfs64			compat_sys_statfs64
+256	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+257	common	timer_create			sys_timer_create		compat_sys_timer_create
+258	common	timer_settime			sys_timer_settime32
+259	common	timer_gettime			sys_timer_gettime32
+260	common	timer_getoverrun		sys_timer_getoverrun
+261	common	timer_delete			sys_timer_delete
+262	common	clock_settime			sys_clock_settime32
+263	common	clock_gettime			sys_clock_gettime32
+264	common	clock_getres			sys_clock_getres_time32
+265	common	clock_nanosleep			sys_clock_nanosleep_time32
+266	common	tgkill				sys_tgkill
+267	common	utimes				sys_utimes_time32
+268	common	mbind				sys_mbind
+269	common	get_mempolicy			sys_get_mempolicy
+270	common	set_mempolicy			sys_set_mempolicy
+271	common	mq_open				sys_mq_open			compat_sys_mq_open
+272	common	mq_unlink			sys_mq_unlink
+273	common	mq_timedsend			sys_mq_timedsend_time32
+274	common	mq_timedreceive			sys_mq_timedreceive_time32
+275	common	mq_notify			sys_mq_notify			compat_sys_mq_notify
+276	common	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+277	common	vserver				sys_ni_syscall
+278	common	waitid				sys_waitid			compat_sys_waitid
 # 279 was sys_setaltroot
-280	o32	add_key				sys_add_key
-281	o32	request_key			sys_request_key
-282	o32	keyctl				sys_keyctl			compat_sys_keyctl
-283	o32	set_thread_area			sys_set_thread_area
-284	o32	inotify_init			sys_inotify_init
-285	o32	inotify_add_watch		sys_inotify_add_watch
-286	o32	inotify_rm_watch		sys_inotify_rm_watch
-287	o32	migrate_pages			sys_migrate_pages
-288	o32	openat				sys_openat			compat_sys_openat
-289	o32	mkdirat				sys_mkdirat
-290	o32	mknodat				sys_mknodat
-291	o32	fchownat			sys_fchownat
-292	o32	futimesat			sys_futimesat_time32
-293	o32	fstatat64			sys_fstatat64			sys_newfstatat
-294	o32	unlinkat			sys_unlinkat
-295	o32	renameat			sys_renameat
-296	o32	linkat				sys_linkat
-297	o32	symlinkat			sys_symlinkat
-298	o32	readlinkat			sys_readlinkat
-299	o32	fchmodat			sys_fchmodat
-300	o32	faccessat			sys_faccessat
-301	o32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
-302	o32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
-303	o32	unshare				sys_unshare
-304	o32	splice				sys_splice
-305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
-306	o32	tee				sys_tee
-307	o32	vmsplice			sys_vmsplice
-308	o32	move_pages			sys_move_pages
-309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
-310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
-311	o32	kexec_load			sys_kexec_load			compat_sys_kexec_load
-312	o32	getcpu				sys_getcpu
-313	o32	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
-314	o32	ioprio_set			sys_ioprio_set
-315	o32	ioprio_get			sys_ioprio_get
-316	o32	utimensat			sys_utimensat_time32
-317	o32	signalfd			sys_signalfd			compat_sys_signalfd
-318	o32	timerfd				sys_ni_syscall
-319	o32	eventfd				sys_eventfd
-320	o32	fallocate			sys_fallocate			sys32_fallocate
-321	o32	timerfd_create			sys_timerfd_create
-322	o32	timerfd_gettime			sys_timerfd_gettime32
-323	o32	timerfd_settime			sys_timerfd_settime32
-324	o32	signalfd4			sys_signalfd4			compat_sys_signalfd4
-325	o32	eventfd2			sys_eventfd2
-326	o32	epoll_create1			sys_epoll_create1
-327	o32	dup3				sys_dup3
-328	o32	pipe2				sys_pipe2
-329	o32	inotify_init1			sys_inotify_init1
-330	o32	preadv				sys_preadv			compat_sys_preadv
-331	o32	pwritev				sys_pwritev			compat_sys_pwritev
-332	o32	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-333	o32	perf_event_open			sys_perf_event_open
-334	o32	accept4				sys_accept4
-335	o32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
-336	o32	fanotify_init			sys_fanotify_init
-337	o32	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
-338	o32	prlimit64			sys_prlimit64
-339	o32	name_to_handle_at		sys_name_to_handle_at
-340	o32	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
-341	o32	clock_adjtime			sys_clock_adjtime32
-342	o32	syncfs				sys_syncfs
-343	o32	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
-344	o32	setns				sys_setns
-345	o32	process_vm_readv		sys_process_vm_readv
-346	o32	process_vm_writev		sys_process_vm_writev
-347	o32	kcmp				sys_kcmp
-348	o32	finit_module			sys_finit_module
-349	o32	sched_setattr			sys_sched_setattr
-350	o32	sched_getattr			sys_sched_getattr
-351	o32	renameat2			sys_renameat2
-352	o32	seccomp				sys_seccomp
-353	o32	getrandom			sys_getrandom
-354	o32	memfd_create			sys_memfd_create
-355	o32	bpf				sys_bpf
-356	o32	execveat			sys_execveat			compat_sys_execveat
-357	o32	userfaultfd			sys_userfaultfd
-358	o32	membarrier			sys_membarrier
-359	o32	mlock2				sys_mlock2
-360	o32	copy_file_range			sys_copy_file_range
-361	o32	preadv2				sys_preadv2			compat_sys_preadv2
-362	o32	pwritev2			sys_pwritev2			compat_sys_pwritev2
-363	o32	pkey_mprotect			sys_pkey_mprotect
-364	o32	pkey_alloc			sys_pkey_alloc
-365	o32	pkey_free			sys_pkey_free
-366	o32	statx				sys_statx
-367	o32	rseq				sys_rseq
-368	o32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+280	common	add_key				sys_add_key
+281	common	request_key			sys_request_key
+282	common	keyctl				sys_keyctl			compat_sys_keyctl
+283	common	set_thread_area			sys_set_thread_area
+284	common	inotify_init			sys_inotify_init
+285	common	inotify_add_watch		sys_inotify_add_watch
+286	common	inotify_rm_watch		sys_inotify_rm_watch
+287	common	migrate_pages			sys_migrate_pages
+288	common	openat				sys_openat			compat_sys_openat
+289	common	mkdirat				sys_mkdirat
+290	common	mknodat				sys_mknodat
+291	common	fchownat			sys_fchownat
+292	common	futimesat			sys_futimesat_time32
+293	common	fstatat64			sys_fstatat64			sys_newfstatat
+294	common	unlinkat			sys_unlinkat
+295	common	renameat			sys_renameat
+296	common	linkat				sys_linkat
+297	common	symlinkat			sys_symlinkat
+298	common	readlinkat			sys_readlinkat
+299	common	fchmodat			sys_fchmodat
+300	common	faccessat			sys_faccessat
+301	common	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+302	common	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
+303	common	unshare				sys_unshare
+304	common	splice				sys_splice
+305	common	sync_file_range			sys_sync_file_range		sys32_sync_file_range
+306	common	tee				sys_tee
+307	common	vmsplice			sys_vmsplice
+308	common	move_pages			sys_move_pages
+309	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+310	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+311	common	kexec_load			sys_kexec_load			compat_sys_kexec_load
+312	common	getcpu				sys_getcpu
+313	common	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+314	common	ioprio_set			sys_ioprio_set
+315	common	ioprio_get			sys_ioprio_get
+316	common	utimensat			sys_utimensat_time32
+317	common	signalfd			sys_signalfd			compat_sys_signalfd
+318	common	timerfd				sys_ni_syscall
+319	common	eventfd				sys_eventfd
+320	common	fallocate			sys_fallocate			sys32_fallocate
+321	common	timerfd_create			sys_timerfd_create
+322	common	timerfd_gettime			sys_timerfd_gettime32
+323	common	timerfd_settime			sys_timerfd_settime32
+324	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
+325	common	eventfd2			sys_eventfd2
+326	common	epoll_create1			sys_epoll_create1
+327	common	dup3				sys_dup3
+328	common	pipe2				sys_pipe2
+329	common	inotify_init1			sys_inotify_init1
+330	common	preadv				sys_preadv			compat_sys_preadv
+331	common	pwritev				sys_pwritev			compat_sys_pwritev
+332	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+333	common	perf_event_open			sys_perf_event_open
+334	common	accept4				sys_accept4
+335	common	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+336	common	fanotify_init			sys_fanotify_init
+337	common	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
+338	common	prlimit64			sys_prlimit64
+339	common	name_to_handle_at		sys_name_to_handle_at
+340	common	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
+341	common	clock_adjtime			sys_clock_adjtime32
+342	common	syncfs				sys_syncfs
+343	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+344	common	setns				sys_setns
+345	common	process_vm_readv		sys_process_vm_readv
+346	common	process_vm_writev		sys_process_vm_writev
+347	common	kcmp				sys_kcmp
+348	common	finit_module			sys_finit_module
+349	common	sched_setattr			sys_sched_setattr
+350	common	sched_getattr			sys_sched_getattr
+351	common	renameat2			sys_renameat2
+352	common	seccomp				sys_seccomp
+353	common	getrandom			sys_getrandom
+354	common	memfd_create			sys_memfd_create
+355	common	bpf				sys_bpf
+356	common	execveat			sys_execveat			compat_sys_execveat
+357	common	userfaultfd			sys_userfaultfd
+358	common	membarrier			sys_membarrier
+359	common	mlock2				sys_mlock2
+360	common	copy_file_range			sys_copy_file_range
+361	common	preadv2				sys_preadv2			compat_sys_preadv2
+362	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
+363	common	pkey_mprotect			sys_pkey_mprotect
+364	common	pkey_alloc			sys_pkey_alloc
+365	common	pkey_free			sys_pkey_free
+366	common	statx				sys_statx
+367	common	rseq				sys_rseq
+368	common	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
 # room for arch specific calls
-393	o32	semget				sys_semget
-394	o32	semctl				sys_semctl			compat_sys_semctl
-395	o32	shmget				sys_shmget
-396	o32	shmctl				sys_shmctl			compat_sys_shmctl
-397	o32	shmat				sys_shmat			compat_sys_shmat
-398	o32	shmdt				sys_shmdt
-399	o32	msgget				sys_msgget
-400	o32	msgsnd				sys_msgsnd			compat_sys_msgsnd
-401	o32	msgrcv				sys_msgrcv			compat_sys_msgrcv
-402	o32	msgctl				sys_msgctl			compat_sys_msgctl
-403	o32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
-404	o32	clock_settime64			sys_clock_settime		sys_clock_settime
-405	o32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
-406	o32	clock_getres_time64		sys_clock_getres		sys_clock_getres
-407	o32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
-408	o32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
-409	o32	timer_settime64			sys_timer_settime		sys_timer_settime
-410	o32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
-411	o32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
-412	o32	utimensat_time64		sys_utimensat			sys_utimensat
-413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
-414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	o32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
-417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
-418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
-419	o32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
-420	o32	semtimedop_time64		sys_semtimedop			sys_semtimedop
-421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
-422	o32	futex_time64			sys_futex			sys_futex
-423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
-424	o32	pidfd_send_signal		sys_pidfd_send_signal
-425	o32	io_uring_setup			sys_io_uring_setup
-426	o32	io_uring_enter			sys_io_uring_enter
-427	o32	io_uring_register		sys_io_uring_register
-428	o32	open_tree			sys_open_tree
-429	o32	move_mount			sys_move_mount
-430	o32	fsopen				sys_fsopen
-431	o32	fsconfig			sys_fsconfig
-432	o32	fsmount				sys_fsmount
-433	o32	fspick				sys_fspick
-434	o32	pidfd_open			sys_pidfd_open
-435	o32	clone3				__sys_clone3
-436	o32	close_range			sys_close_range
-437	o32	openat2				sys_openat2
-438	o32	pidfd_getfd			sys_pidfd_getfd
-439	o32	faccessat2			sys_faccessat2
-440	o32	process_madvise			sys_process_madvise
-441	o32	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
-442	o32	mount_setattr			sys_mount_setattr
-443	o32	quotactl_fd			sys_quotactl_fd
-444	o32	landlock_create_ruleset		sys_landlock_create_ruleset
-445	o32	landlock_add_rule		sys_landlock_add_rule
-446	o32	landlock_restrict_self		sys_landlock_restrict_self
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl			compat_sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl			compat_sys_shmctl
+397	common	shmat				sys_shmat			compat_sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl				sys_msgctl			compat_sys_msgctl
+403	common	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime		sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime		sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat			sys_utimensat
+413	common	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	common	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	common	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	common	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	common	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	common	futex_time64			sys_futex			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
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
+435	common	clone3				__sys_clone3
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
 # 447 reserved for memfd_secret
-448	o32	process_mrelease		sys_process_mrelease
-449	o32	futex_waitv			sys_futex_waitv
-450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
-451	o32	cachestat			sys_cachestat
-452	o32	fchmodat2			sys_fchmodat2
-453	o32	map_shadow_stack		sys_map_shadow_stack
-454	o32	futex_wake			sys_futex_wake
-455	o32	futex_wait			sys_futex_wait
-456	o32	futex_requeue			sys_futex_requeue
-457	o32	statmount			sys_statmount
-458	o32	listmount			sys_listmount
-459	o32	lsm_get_self_attr		sys_lsm_get_self_attr
-460	o32	lsm_set_self_attr		sys_lsm_set_self_attr
-461	o32	lsm_list_modules		sys_lsm_list_modules
-462	o32	mseal				sys_mseal
-463	o32	setxattrat			sys_setxattrat
-464	o32	getxattrat			sys_getxattrat
-465	o32	listxattrat			sys_listxattrat
-466	o32	removexattrat			sys_removexattrat
-467	o32	open_tree_attr			sys_open_tree_attr
-468	o32	file_getattr			sys_file_getattr
-469	o32	file_setattr			sys_file_setattr
-470	o32	listns				sys_listns
-471	o32	rseq_slice_yield		sys_rseq_slice_yield
-472	o32	fchroot				sys_fchroot
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
2.56.0

