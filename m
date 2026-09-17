Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F644C10D9;
	Thu, 17 Sep 2026 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789688815; cv=none; b=kmN78yJLS/Sgs8D+zo62f7Zm82qQAO64YENcbvd5jPov0Vvoy82m9V2QGPNveFDxOS70ka7EipsNbJQNAyR1C/PP3ukAnGiB9fqpYp3JgZNUaAMvrRMD3OnzgZZe7SSQPEXqkTXHf06AugFluWnca/u70/qgCo6I5OltDT4mUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789688815; c=relaxed/simple;
	bh=4CTikapYEvFJaC+ZNy9MBBUoqBDh+/rqOZntqFlF5UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B18BX+F3QUJAPogmLVbs9hEZOx3z8UM2jNBbGF98OZMC6YsUCKQg+O64u8Dyj0MavlvldWpWzcnmLJ9sROGptrp6bqyTghTUWhL3U6snPdh8xjrplqByd8ZL9GxGez9MZJMVNyfa8O2LRtFht3Xvj1UaWmVoaewgSDFcnrC/wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EKMvZiqY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EKMvZiqY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=TwpdZ+IZPJVxqW2Q3UOfd4IAc7IpUt4VI4P8mRNVIVQ=; b=EKMvZiqYEl7KiOcvGZZWQpeOz4
	ZvkBTp2fKRcPUG//Ae9WCZYAx4N8Q03I5gTXfCkDy5zbo8aOsw0dcjwB2O3J0DbY648tKcSSzYjnd
	kCsyC8oABY1ZJX/FQrL6qsYbpq+EA+qAAV+ItNsr3ECuJJsYdewwfNlX3n2BY+8d3FQ1bW1lgq/cg
	rfIGg+NI5J0rJkPhhOojCUKAYgXsIh51m0ClSH5Lh3XxRvgYVI3NcXJ4vF/cduG6dWNBIcXzp4uZJ
	aw4fT2tKZ0AaKxd8e4Xb+DaKgT2zQ4JhgYPOBKKJxo5omAR8ppiAL1EsBoODanewCBwgT6tGXrWMF
	z23afBxw==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7LoU-003hU7-Uu; Fri, 18 Sep 2026 01:46:46 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Sep 2026 20:46:12 -0300
Subject: [PATCH v7 09/13] mips: Use the common syscall table
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-tonyk-syscall_table-v7-9-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Syscall numbers from 403 are shared with all architectures, so move the
toolchain to use the common syscall table and remove duplicated code.

To help with that, merge n32 and n64 syscall tables in a single one, taking
advantage of the shared numbers.

The generated files are not exactly the same as before, but they have no
functional changes:

 - For O32 ABI, the syscall table would have entries like
 __SYSCALL_WITH_COMPAT(403, sys_clock_gettime, sys_clock_gettime)
 which is equivalent to the new entry __SYSCALL(403, sys_clock_gettime)

 - For N32 ABI, the syscall table would have entries like
 __SYSCALL(413, compat_sys_pselect6_time64), which is equivalent to
 __SYSCALL_WITH_COMPAT(413, sys_pselect6, compat_sys_pselect6_time64)
 given the new __SYSCALL_WITH_COMPAT() definition for N32.

 - The above applies for N64 ABI as well.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v6:
- Add abis to sysnr rule
- Fix syscall typos (sigtimed_wait_time, usta)
- Fix rebuild rules
---
 arch/mips/kernel/scall64-n32.S            |   1 +
 arch/mips/kernel/scall64-n64.S            |   2 +
 arch/mips/kernel/syscalls/Makefile        |  33 ++-
 arch/mips/kernel/syscalls/syscall_n.tbl   | 464 ++++++++++++++++++++++++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl | 413 --------------------------
 arch/mips/kernel/syscalls/syscall_n64.tbl | 389 -------------------------
 arch/mips/kernel/syscalls/syscall_o32.tbl |  69 -----
 7 files changed, 492 insertions(+), 879 deletions(-)

diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index 97788859238c..b35541f0cff9 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -102,6 +102,7 @@ not_n32_scall:
 
 	END(handle_sysn32)
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
 #define __SYSCALL(nr, entry)	PTR_WD entry
 	.type	sysn32_call_table, @object
 EXPORT(sysn32_call_table)
diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall64-n64.S
index be11ea5cc67e..2d5fca6085ff 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -109,6 +109,8 @@ illegal_syscall:
 	j	n64_syscall_exit
 	END(handle_sys64)
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
+
 #define __SYSCALL(nr, entry)	PTR_WD entry
 	.align	3
 	.type	sys_call_table, @object
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index 1bfc2346d100..07c7eb5da1b8 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -7,28 +7,45 @@ $(shell mkdir -p $(uapi) $(kapi))
 syshdr := $(srctree)/scripts/syscallhdr.sh
 sysnr := $(srctree)/scripts/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+systbl_common := $(srctree)/scripts/syscall_common.tbl
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux \
+		   --common-tbl $(systbl_common) \
+		   --abis $(abis_$*) $(src_$*) $@
 
 quiet_cmd_sysnr = SYSNR   $@
-      cmd_sysnr = $(CONFIG_SHELL) $(sysnr) \
+      cmd_sysnr = $(CONFIG_SHELL) $(sysnr) --abis $(abis_$*) \
 		  --prefix $(sysnr_pfx_$(basetarget))_Linux_ $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
-
-$(uapi)/unistd_%.h: $(src)/syscall_%.tbl $(syshdr) FORCE
-	$(call if_changed,syshdr)
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
+		   --common-tbl $(systbl_common) \
+		   --abis $(abis_$*) $(src_$*) $@
 
 sysnr_pfx_unistd_nr_n32 := N32
 sysnr_pfx_unistd_nr_n64 := 64
 sysnr_pfx_unistd_nr_o32 := O32
 
-$(kapi)/unistd_nr_%.h: $(src)/syscall_%.tbl $(sysnr) FORCE
+abis := common,__clone3
+
+abis_n32 := $(abis),32
+abis_o32 := $(abis),32
+abis_n64 := $(abis),64
+
+src_n32 := $(src)/syscall_n.tbl
+src_n64 := $(src)/syscall_n.tbl
+src_o32 := $(src)/syscall_o32.tbl
+
+.SECONDEXPANSION:
+
+$(uapi)/unistd_%.h: $(systbl_common) $$(src_$$*) $(syshdr) FORCE
+	$(call if_changed,syshdr)
+
+$(kapi)/unistd_nr_%.h: $(systbl_common) $$(src_$$*) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) $$(src_$$*) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_n32.h			\
diff --git a/arch/mips/kernel/syscalls/syscall_n.tbl b/arch/mips/kernel/syscalls/syscall_n.tbl
new file mode 100644
index 000000000000..1882527053af
--- /dev/null
+++ b/arch/mips/kernel/syscalls/syscall_n.tbl
@@ -0,0 +1,464 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for mips for common and n64.
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> is "32", "64" or "common" for this file.
+#
+0	common 	read				sys_read
+1	common 	write				sys_write
+2	common 	open				sys_open
+3	common 	close				sys_close
+4	common 	stat				sys_newstat
+5	common 	fstat				sys_newfstat
+6	common 	lstat				sys_newlstat
+7	common 	poll				sys_poll
+8	common 	lseek				sys_lseek
+9	common 	mmap				sys_mips_mmap
+10	common 	mprotect			sys_mprotect
+11	common 	munmap				sys_munmap
+12	common 	brk				sys_brk
+13	common	rt_sigaction			sys_rt_sigaction	compat_sys_rt_sigaction
+14	common	rt_sigprocmask			sys_rt_sigprocmask	compat_sys_rt_sigprocmask
+15	common	ioctl				sys_ioctl		compat_sys_ioctl
+16	common	pread64				sys_pread64
+17	common	pwrite64			sys_pwrite64
+18	common	readv				sys_readv
+19	common	writev				sys_writev
+20	common	access				sys_access
+21	common	pipe				sysm_pipe
+22	common	_newselect			sys_select		compat_sys_select
+23	common	sched_yield			sys_sched_yield
+24	common	mremap				sys_mremap
+25	common	msync				sys_msync
+26	common	mincore				sys_mincore
+27	common	madvise				sys_madvise
+28	common	shmget				sys_shmget
+29	common	shmat				sys_shmat
+30	common	shmctl				sys_old_shmctl		compat_sys_old_shmctl
+31	common	dup				sys_dup
+32	common	dup2				sys_dup2
+33	common	pause				sys_pause
+34	common	nanosleep			sys_nanosleep		sys_nanosleep_time32
+35	common	getitimer			sys_getitimer		compat_sys_getitimer
+36	common	setitimer			sys_setitimer		compat_sys_setitimer
+37	common	alarm				sys_alarm
+38	common	getpid				sys_getpid
+39	common	sendfile			sys_sendfile64		compat_sys_sendfile
+40	common	socket				sys_socket
+41	common	connect				sys_connect
+42	common	accept				sys_accept
+43	common	sendto				sys_sendto
+44	common	recvfrom			sys_recvfrom		compat_sys_recvfrom
+45	common	sendmsg				sys_sendmsg		compat_sys_sendmsg
+46	common	recvmsg				sys_recvmsg		compat_sys_recvmsg
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
+57	common	execve				sys_execve		compat_sys_execve
+58	common	exit				sys_exit
+59	common	wait4				sys_wait4		compat_sys_wait4
+60	common	kill				sys_kill
+61	common	uname				sys_newuname
+62	common	semget				sys_semget
+63	common	semop				sys_semop
+64	common	semctl				sys_old_semctl		compat_sys_old_semctl
+65	common	shmdt				sys_shmdt
+66	common	msgget				sys_msgget
+67	common	msgsnd				sys_msgsnd		compat_sys_msgsnd
+68	common	msgrcv				sys_msgrcv		compat_sys_msgrcv
+69	common	msgctl				sys_old_msgctl		compat_sys_old_msgctl
+70	common	fcntl				sys_fcntl		compat_sys_fcntl
+71	common	flock				sys_flock
+72	common	fsync				sys_fsync
+73	common	fdatasync			sys_fdatasync
+74	common	truncate			sys_truncate
+75	common	ftruncate			sys_ftruncate
+76	common	getdents			sys_getdents		compat_sys_getdents
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
+94	common	gettimeofday			sys_gettimeofday	compat_sys_gettimeofday
+95	common	getrlimit			sys_getrlimit		compat_sys_getrlimit
+96	common	getrusage			sys_getrusage		compat_sys_getrusage
+97	common	sysinfo				sys_sysinfo		compat_sys_sysinfo
+98	common	times				sys_times		compat_sys_times
+99	common	ptrace				sys_ptrace		compat_sys_ptrace
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
+125	common	rt_sigpending			sys_rt_sigpending	compat_sys_rt_sigpending
+126	common	rt_sigtimedwait			sys_rt_sigtimedwait	compat_sys_rt_sigtimedwait_time32
+127	common	rt_sigqueueinfo			sys_rt_sigqueueinfo	compat_sys_rt_sigqueueinfo
+128	common	rt_sigsuspend			sys_rt_sigsuspend	compat_sys_rt_sigsuspend
+129	common	sigaltstack			sys_sigaltstack		compat_sys_sigaltstack
+130	common	utime				sys_utime		sys_utime32
+131	common	mknod				sys_mknod
+132	common	personality			sys_personality		sys_32_personality
+133	common	ustat				sys_ustat		compat_sys_ustat
+134	common	statfs				sys_statfs		compat_sys_statfs
+135	common	fstatfs				sys_fstatfs		compat_sys_fstatfs
+136	common	sysfs				sys_sysfs
+137	common	getpriority			sys_getpriority
+138	common	setpriority			sys_setpriority
+139	common	sched_setparam			sys_sched_setparam
+140	common	sched_getparam			sys_sched_getparam
+141	common	sched_setscheduler		sys_sched_setscheduler
+142	common	sched_getscheduler		sys_sched_getscheduler
+143	common	sched_get_priority_max		sys_sched_get_priority_max
+144	common	sched_get_priority_min		sys_sched_get_priority_min
+145	common	sched_rr_get_interval		sys_sched_rr_get_interval	sys_sched_rr_get_interval_time32
+146	common	mlock				sys_mlock
+147	common	munlock				sys_munlock
+148	common	mlockall			sys_mlockall
+149	common	munlockall			sys_munlockall
+150	common	vhangup				sys_vhangup
+151	common	pivot_root			sys_pivot_root
+152	common	_sysctl				sys_ni_syscall
+153	common	prctl				sys_prctl
+154	common	adjtimex			sys_adjtimex		sys_adjtimex_time32
+155	common	setrlimit			sys_setrlimit		compat_sys_setrlimit
+156	common	chroot				sys_chroot
+157	common	sync				sys_sync
+158	common	acct				sys_acct
+159	common	settimeofday			sys_settimeofday	compat_sys_settimeofday
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
+# 177 reserved for security
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
+194	common	futex				sys_futex		sys_futex_time32
+195	common	sched_setaffinity		sys_sched_setaffinity	compat_sys_sched_setaffinity
+196	common	sched_getaffinity		sys_sched_getaffinity	compat_sys_sched_getaffinity
+197	common	cacheflush			sys_cacheflush
+198	common	cachectl			sys_cachectl
+199	common	sysmips				__sys_sysmips
+200	common	io_setup			sys_io_setup		compat_sys_io_setup
+201	common	io_destroy			sys_io_destroy
+202	common	io_getevents			sys_io_getevents	sys_io_getevents_time32
+203	common	io_submit			sys_io_submit		compat_sys_io_submit
+204	common	io_cancel			sys_io_cancel
+205	common	exit_group			sys_exit_group
+206	common	lookup_dcookie			sys_ni_syscall
+207	common	epoll_create			sys_epoll_create
+208	common	epoll_ctl			sys_epoll_ctl
+209	common	epoll_wait			sys_epoll_wait
+210	common	remap_file_pages		sys_remap_file_pages
+211	common	rt_sigreturn			sys_rt_sigreturn	sysn32_rt_sigreturn
+
+# n32 specific syscalls
+212	32	fcntl64				compat_sys_fcntl64
+213	32	set_tid_address			sys_set_tid_address
+214	32	restart_syscall			sys_restart_syscall
+215	32	semtimedop			sys_semtimedop_time32
+216	32	fadvise64			sys_fadvise64_64
+217	32	statfs64			compat_sys_statfs64
+218	32	fstatfs64			compat_sys_fstatfs64
+219	32	sendfile64			sys_sendfile64
+220	32	timer_create			compat_sys_timer_create
+221	32	timer_settime			sys_timer_settime32
+222	32	timer_gettime			sys_timer_gettime32
+223	32	timer_getoverrun		sys_timer_getoverrun
+224	32	timer_delete			sys_timer_delete
+225	32	clock_settime			sys_clock_settime32
+226	32	clock_gettime			sys_clock_gettime32
+227	32	clock_getres			sys_clock_getres_time32
+228	32	clock_nanosleep			sys_clock_nanosleep_time32
+229	32	tgkill				sys_tgkill
+230	32	utimes				sys_utimes_time32
+231	32	mbind				sys_mbind
+232	32	get_mempolicy			sys_get_mempolicy
+233	32	set_mempolicy			sys_set_mempolicy
+234	32	mq_open				compat_sys_mq_open
+235	32	mq_unlink			sys_mq_unlink
+236	32	mq_timedsend			sys_mq_timedsend_time32
+237	32	mq_timedreceive			sys_mq_timedreceive_time32
+238	32	mq_notify			compat_sys_mq_notify
+239	32	mq_getsetattr			compat_sys_mq_getsetattr
+240	32	vserver				sys_ni_syscall
+241	32	waitid				compat_sys_waitid
+# 242 was sys_setaltroot
+243	32	add_key				sys_add_key
+244	32	request_key			sys_request_key
+245	32	keyctl				compat_sys_keyctl
+246	32	set_thread_area			sys_set_thread_area
+247	32	inotify_init			sys_inotify_init
+248	32	inotify_add_watch		sys_inotify_add_watch
+249	32	inotify_rm_watch		sys_inotify_rm_watch
+250	32	migrate_pages			sys_migrate_pages
+251	32	openat				sys_openat
+252	32	mkdirat				sys_mkdirat
+253	32	mknodat				sys_mknodat
+254	32	fchownat			sys_fchownat
+255	32	futimesat			sys_futimesat_time32
+256	32	newfstatat			sys_newfstatat
+257	32	unlinkat			sys_unlinkat
+258	32	renameat			sys_renameat
+259	32	linkat				sys_linkat
+260	32	symlinkat			sys_symlinkat
+261	32	readlinkat			sys_readlinkat
+262	32	fchmodat			sys_fchmodat
+263	32	faccessat			sys_faccessat
+264	32	pselect6			compat_sys_pselect6_time32
+265	32	ppoll				compat_sys_ppoll_time32
+266	32	unshare				sys_unshare
+267	32	splice				sys_splice
+268	32	sync_file_range			sys_sync_file_range
+269	32	tee				sys_tee
+270	32	vmsplice			sys_vmsplice
+271	32	move_pages			sys_move_pages
+272	32	set_robust_list			compat_sys_set_robust_list
+273	32	get_robust_list			compat_sys_get_robust_list
+274	32	kexec_load			compat_sys_kexec_load
+275	32	getcpu				sys_getcpu
+276	32	epoll_pwait			compat_sys_epoll_pwait
+277	32	ioprio_set			sys_ioprio_set
+278	32	ioprio_get			sys_ioprio_get
+279	32	utimensat			sys_utimensat_time32
+280	32	signalfd			compat_sys_signalfd
+281	32	timerfd				sys_ni_syscall
+282	32	eventfd				sys_eventfd
+283	32	fallocate			sys_fallocate
+284	32	timerfd_create			sys_timerfd_create
+285	32	timerfd_gettime			sys_timerfd_gettime32
+286	32	timerfd_settime			sys_timerfd_settime32
+287	32	signalfd4			compat_sys_signalfd4
+288	32	eventfd2			sys_eventfd2
+289	32	epoll_create1			sys_epoll_create1
+290	32	dup3				sys_dup3
+291	32	pipe2				sys_pipe2
+292	32	inotify_init1			sys_inotify_init1
+293	32	preadv				compat_sys_preadv
+294	32	pwritev				compat_sys_pwritev
+295	32	rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+296	32	perf_event_open			sys_perf_event_open
+297	32	accept4				sys_accept4
+298	32	recvmmsg			compat_sys_recvmmsg_time32
+299	32	getdents64			sys_getdents64
+300	32	fanotify_init			sys_fanotify_init
+301	32	fanotify_mark			sys_fanotify_mark
+302	32	prlimit64			sys_prlimit64
+303	32	name_to_handle_at		sys_name_to_handle_at
+304	32	open_by_handle_at		sys_open_by_handle_at
+305	32	clock_adjtime			sys_clock_adjtime32
+306	32	syncfs				sys_syncfs
+307	32	sendmmsg			compat_sys_sendmmsg
+308	32	setns				sys_setns
+309	32	process_vm_readv		sys_process_vm_readv
+310	32	process_vm_writev		sys_process_vm_writev
+311	32	kcmp				sys_kcmp
+312	32	finit_module			sys_finit_module
+313	32	sched_setattr			sys_sched_setattr
+314	32	sched_getattr			sys_sched_getattr
+315	32	renameat2			sys_renameat2
+316	32	seccomp				sys_seccomp
+317	32	getrandom			sys_getrandom
+318	32	memfd_create			sys_memfd_create
+319	32	bpf				sys_bpf
+320	32	execveat			compat_sys_execveat
+321	32	userfaultfd			sys_userfaultfd
+322	32	membarrier			sys_membarrier
+323	32	mlock2				sys_mlock2
+324	32	copy_file_range			sys_copy_file_range
+325	32	preadv2				compat_sys_preadv2
+326	32	pwritev2			compat_sys_pwritev2
+327	32	pkey_mprotect			sys_pkey_mprotect
+328	32	pkey_alloc			sys_pkey_alloc
+329	32	pkey_free			sys_pkey_free
+330	32	statx				sys_statx
+331	32	rseq				sys_rseq
+332	32	io_pgetevents			compat_sys_io_pgetevents
+
+# n64 specific syscalls
+212	64	set_tid_address			sys_set_tid_address
+213	64	restart_syscall			sys_restart_syscall
+214	64	semtimedop			sys_semtimedop
+215	64	fadvise64			sys_fadvise64_64
+216	64	timer_create			sys_timer_create
+217	64	timer_settime			sys_timer_settime
+218	64	timer_gettime			sys_timer_gettime
+219	64	timer_getoverrun		sys_timer_getoverrun
+220	64	timer_delete			sys_timer_delete
+221	64	clock_settime			sys_clock_settime
+222	64	clock_gettime			sys_clock_gettime
+223	64	clock_getres			sys_clock_getres
+224	64	clock_nanosleep			sys_clock_nanosleep
+225	64	tgkill				sys_tgkill
+226	64	utimes				sys_utimes
+227	64	mbind				sys_mbind
+228	64	get_mempolicy			sys_get_mempolicy
+229	64	set_mempolicy			sys_set_mempolicy
+230	64	mq_open				sys_mq_open
+231	64	mq_unlink			sys_mq_unlink
+232	64	mq_timedsend			sys_mq_timedsend
+233	64	mq_timedreceive			sys_mq_timedreceive
+234	64	mq_notify			sys_mq_notify
+235	64	mq_getsetattr			sys_mq_getsetattr
+236	64	vserver				sys_ni_syscall
+237	64	waitid				sys_waitid
+# 238 was sys_setaltroot
+239	64	add_key				sys_add_key
+240	64	request_key			sys_request_key
+241	64	keyctl				sys_keyctl
+242	64	set_thread_area			sys_set_thread_area
+243	64	inotify_init			sys_inotify_init
+244	64	inotify_add_watch		sys_inotify_add_watch
+245	64	inotify_rm_watch		sys_inotify_rm_watch
+246	64	migrate_pages			sys_migrate_pages
+247	64	openat				sys_openat
+248	64	mkdirat				sys_mkdirat
+249	64	mknodat				sys_mknodat
+250	64	fchownat			sys_fchownat
+251	64	futimesat			sys_futimesat
+252	64	newfstatat			sys_newfstatat
+253	64	unlinkat			sys_unlinkat
+254	64	renameat			sys_renameat
+255	64	linkat				sys_linkat
+256	64	symlinkat			sys_symlinkat
+257	64	readlinkat			sys_readlinkat
+258	64	fchmodat			sys_fchmodat
+259	64	faccessat			sys_faccessat
+260	64	pselect6			sys_pselect6
+261	64	ppoll				sys_ppoll
+262	64	unshare				sys_unshare
+263	64	splice				sys_splice
+264	64	sync_file_range			sys_sync_file_range
+265	64	tee				sys_tee
+266	64	vmsplice			sys_vmsplice
+267	64	move_pages			sys_move_pages
+268	64	set_robust_list			sys_set_robust_list
+269	64	get_robust_list			sys_get_robust_list
+270	64	kexec_load			sys_kexec_load
+271	64	getcpu				sys_getcpu
+272	64	epoll_pwait			sys_epoll_pwait
+273	64	ioprio_set			sys_ioprio_set
+274	64	ioprio_get			sys_ioprio_get
+275	64	utimensat			sys_utimensat
+276	64	signalfd			sys_signalfd
+277	64	timerfd				sys_ni_syscall
+278	64	eventfd				sys_eventfd
+279	64	fallocate			sys_fallocate
+280	64	timerfd_create			sys_timerfd_create
+281	64	timerfd_gettime			sys_timerfd_gettime
+282	64	timerfd_settime			sys_timerfd_settime
+283	64	signalfd4			sys_signalfd4
+284	64	eventfd2			sys_eventfd2
+285	64	epoll_create1			sys_epoll_create1
+286	64	dup3				sys_dup3
+287	64	pipe2				sys_pipe2
+288	64	inotify_init1			sys_inotify_init1
+289	64	preadv				sys_preadv
+290	64	pwritev				sys_pwritev
+291	64	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+292	64	perf_event_open			sys_perf_event_open
+293	64	accept4				sys_accept4
+294	64	recvmmsg			sys_recvmmsg
+295	64	fanotify_init			sys_fanotify_init
+296	64	fanotify_mark			sys_fanotify_mark
+297	64	prlimit64			sys_prlimit64
+298	64	name_to_handle_at		sys_name_to_handle_at
+299	64	open_by_handle_at		sys_open_by_handle_at
+300	64	clock_adjtime			sys_clock_adjtime
+301	64	syncfs				sys_syncfs
+302	64	sendmmsg			sys_sendmmsg
+303	64	setns				sys_setns
+304	64	process_vm_readv		sys_process_vm_readv
+305	64	process_vm_writev		sys_process_vm_writev
+306	64	kcmp				sys_kcmp
+307	64	finit_module			sys_finit_module
+308	64	getdents64			sys_getdents64
+309	64	sched_setattr			sys_sched_setattr
+310	64	sched_getattr			sys_sched_getattr
+311	64	renameat2			sys_renameat2
+312	64	seccomp				sys_seccomp
+313	64	getrandom			sys_getrandom
+314	64	memfd_create			sys_memfd_create
+315	64	bpf				sys_bpf
+316	64	execveat			sys_execveat
+317	64	userfaultfd			sys_userfaultfd
+318	64	membarrier			sys_membarrier
+319	64	mlock2				sys_mlock2
+320	64	copy_file_range			sys_copy_file_range
+321	64	preadv2				sys_preadv2
+322	64	pwritev2			sys_pwritev2
+323	64	pkey_mprotect			sys_pkey_mprotect
+324	64	pkey_alloc			sys_pkey_alloc
+325	64	pkey_free			sys_pkey_free
+326	64	statx				sys_statx
+327	64	rseq				sys_rseq
+328	64	io_pgetevents			sys_io_pgetevents
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
deleted file mode 100644
index 29df491b52b7..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ /dev/null
@@ -1,413 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-#
-# system call numbers and entry vectors for mips
-#
-# The format is:
-# <number> <abi> <name> <entry point> <compat entry point>
-#
-# The <abi> is always "common" for this file.
-#
-0	common	read				sys_read
-1	common	write				sys_write
-2	common	open				sys_open
-3	common	close				sys_close
-4	common	stat				sys_newstat
-5	common	fstat				sys_newfstat
-6	common	lstat				sys_newlstat
-7	common	poll				sys_poll
-8	common	lseek				sys_lseek
-9	common	mmap				sys_mips_mmap
-10	common	mprotect			sys_mprotect
-11	common	munmap				sys_munmap
-12	common	brk				sys_brk
-13	common	rt_sigaction			compat_sys_rt_sigaction
-14	common	rt_sigprocmask			compat_sys_rt_sigprocmask
-15	common	ioctl				compat_sys_ioctl
-16	common	pread64				sys_pread64
-17	common	pwrite64			sys_pwrite64
-18	common	readv				sys_readv
-19	common	writev				sys_writev
-20	common	access				sys_access
-21	common	pipe				sysm_pipe
-22	common	_newselect			compat_sys_select
-23	common	sched_yield			sys_sched_yield
-24	common	mremap				sys_mremap
-25	common	msync				sys_msync
-26	common	mincore				sys_mincore
-27	common	madvise				sys_madvise
-28	common	shmget				sys_shmget
-29	common	shmat				sys_shmat
-30	common	shmctl				compat_sys_old_shmctl
-31	common	dup				sys_dup
-32	common	dup2				sys_dup2
-33	common	pause				sys_pause
-34	common	nanosleep			sys_nanosleep_time32
-35	common	getitimer			compat_sys_getitimer
-36	common	setitimer			compat_sys_setitimer
-37	common	alarm				sys_alarm
-38	common	getpid				sys_getpid
-39	common	sendfile			compat_sys_sendfile
-40	common	socket				sys_socket
-41	common	connect				sys_connect
-42	common	accept				sys_accept
-43	common	sendto				sys_sendto
-44	common	recvfrom			compat_sys_recvfrom
-45	common	sendmsg				compat_sys_sendmsg
-46	common	recvmsg				compat_sys_recvmsg
-47	common	shutdown			sys_shutdown
-48	common	bind				sys_bind
-49	common	listen				sys_listen
-50	common	getsockname			sys_getsockname
-51	common	getpeername			sys_getpeername
-52	common	socketpair			sys_socketpair
-53	common	setsockopt			sys_setsockopt
-54	common	getsockopt			sys_getsockopt
-55	common	clone				__sys_clone
-56	common	fork				__sys_fork
-57	common	execve				compat_sys_execve
-58	common	exit				sys_exit
-59	common	wait4				compat_sys_wait4
-60	common	kill				sys_kill
-61	common	uname				sys_newuname
-62	common	semget				sys_semget
-63	common	semop				sys_semop
-64	common	semctl				compat_sys_old_semctl
-65	common	shmdt				sys_shmdt
-66	common	msgget				sys_msgget
-67	common	msgsnd				compat_sys_msgsnd
-68	common	msgrcv				compat_sys_msgrcv
-69	common	msgctl				compat_sys_old_msgctl
-70	common	fcntl				compat_sys_fcntl
-71	common	flock				sys_flock
-72	common	fsync				sys_fsync
-73	common	fdatasync			sys_fdatasync
-74	common	truncate			sys_truncate
-75	common	ftruncate			sys_ftruncate
-76	common	getdents			compat_sys_getdents
-77	common	getcwd				sys_getcwd
-78	common	chdir				sys_chdir
-79	common	fchdir				sys_fchdir
-80	common	rename				sys_rename
-81	common	mkdir				sys_mkdir
-82	common	rmdir				sys_rmdir
-83	common	creat				sys_creat
-84	common	link				sys_link
-85	common	unlink				sys_unlink
-86	common	symlink				sys_symlink
-87	common	readlink			sys_readlink
-88	common	chmod				sys_chmod
-89	common	fchmod				sys_fchmod
-90	common	chown				sys_chown
-91	common	fchown				sys_fchown
-92	common	lchown				sys_lchown
-93	common	umask				sys_umask
-94	common	gettimeofday			compat_sys_gettimeofday
-95	common	getrlimit			compat_sys_getrlimit
-96	common	getrusage			compat_sys_getrusage
-97	common	sysinfo				compat_sys_sysinfo
-98	common	times				compat_sys_times
-99	common	ptrace				compat_sys_ptrace
-100	common	getuid				sys_getuid
-101	common	syslog				sys_syslog
-102	common	getgid				sys_getgid
-103	common	setuid				sys_setuid
-104	common	setgid				sys_setgid
-105	common	geteuid				sys_geteuid
-106	common	getegid				sys_getegid
-107	common	setpgid				sys_setpgid
-108	common	getppid				sys_getppid
-109	common	getpgrp				sys_getpgrp
-110	common	setsid				sys_setsid
-111	common	setreuid			sys_setreuid
-112	common	setregid			sys_setregid
-113	common	getgroups			sys_getgroups
-114	common	setgroups			sys_setgroups
-115	common	setresuid			sys_setresuid
-116	common	getresuid			sys_getresuid
-117	common	setresgid			sys_setresgid
-118	common	getresgid			sys_getresgid
-119	common	getpgid				sys_getpgid
-120	common	setfsuid			sys_setfsuid
-121	common	setfsgid			sys_setfsgid
-122	common	getsid				sys_getsid
-123	common	capget				sys_capget
-124	common	capset				sys_capset
-125	common	rt_sigpending			compat_sys_rt_sigpending
-126	common	rt_sigtimedwait			compat_sys_rt_sigtimedwait_time32
-127	common	rt_sigqueueinfo			compat_sys_rt_sigqueueinfo
-128	common	rt_sigsuspend			compat_sys_rt_sigsuspend
-129	common	sigaltstack			compat_sys_sigaltstack
-130	common	utime				sys_utime32
-131	common	mknod				sys_mknod
-132	common	personality			sys_32_personality
-133	common	ustat				compat_sys_ustat
-134	common	statfs				compat_sys_statfs
-135	common	fstatfs				compat_sys_fstatfs
-136	common	sysfs				sys_sysfs
-137	common	getpriority			sys_getpriority
-138	common	setpriority			sys_setpriority
-139	common	sched_setparam			sys_sched_setparam
-140	common	sched_getparam			sys_sched_getparam
-141	common	sched_setscheduler		sys_sched_setscheduler
-142	common	sched_getscheduler		sys_sched_getscheduler
-143	common	sched_get_priority_max		sys_sched_get_priority_max
-144	common	sched_get_priority_min		sys_sched_get_priority_min
-145	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
-146	common	mlock				sys_mlock
-147	common	munlock				sys_munlock
-148	common	mlockall			sys_mlockall
-149	common	munlockall			sys_munlockall
-150	common	vhangup				sys_vhangup
-151	common	pivot_root			sys_pivot_root
-152	common	_sysctl				sys_ni_syscall
-153	common	prctl				sys_prctl
-154	common	adjtimex			sys_adjtimex_time32
-155	common	setrlimit			compat_sys_setrlimit
-156	common	chroot				sys_chroot
-157	common	sync				sys_sync
-158	common	acct				sys_acct
-159	common	settimeofday			compat_sys_settimeofday
-160	common	mount				sys_mount
-161	common	umount2				sys_umount
-162	common	swapon				sys_swapon
-163	common	swapoff				sys_swapoff
-164	common	reboot				sys_reboot
-165	common	sethostname			sys_sethostname
-166	common	setdomainname			sys_setdomainname
-167	common	create_module			sys_ni_syscall
-168	common	init_module			sys_init_module
-169	common	delete_module			sys_delete_module
-170	common	get_kernel_syms			sys_ni_syscall
-171	common	query_module			sys_ni_syscall
-172	common	quotactl			sys_quotactl
-173	common	nfsservctl			sys_ni_syscall
-174	common	getpmsg				sys_ni_syscall
-175	common	putpmsg				sys_ni_syscall
-176	common	afs_syscall			sys_ni_syscall
-# 177 reserved for security
-177	common	reserved177			sys_ni_syscall
-178	common	gettid				sys_gettid
-179	common	readahead			sys_readahead
-180	common	setxattr			sys_setxattr
-181	common	lsetxattr			sys_lsetxattr
-182	common	fsetxattr			sys_fsetxattr
-183	common	getxattr			sys_getxattr
-184	common	lgetxattr			sys_lgetxattr
-185	common	fgetxattr			sys_fgetxattr
-186	common	listxattr			sys_listxattr
-187	common	llistxattr			sys_llistxattr
-188	common	flistxattr			sys_flistxattr
-189	common	removexattr			sys_removexattr
-190	common	lremovexattr			sys_lremovexattr
-191	common	fremovexattr			sys_fremovexattr
-192	common	tkill				sys_tkill
-193	common	reserved193			sys_ni_syscall
-194	common	futex				sys_futex_time32
-195	common	sched_setaffinity		compat_sys_sched_setaffinity
-196	common	sched_getaffinity		compat_sys_sched_getaffinity
-197	common	cacheflush			sys_cacheflush
-198	common	cachectl			sys_cachectl
-199	common	sysmips				__sys_sysmips
-200	common	io_setup			compat_sys_io_setup
-201	common	io_destroy			sys_io_destroy
-202	common	io_getevents			sys_io_getevents_time32
-203	common	io_submit			compat_sys_io_submit
-204	common	io_cancel			sys_io_cancel
-205	common	exit_group			sys_exit_group
-206	common	lookup_dcookie			sys_ni_syscall
-207	common	epoll_create			sys_epoll_create
-208	common	epoll_ctl			sys_epoll_ctl
-209	common	epoll_wait			sys_epoll_wait
-210	common	remap_file_pages		sys_remap_file_pages
-211	common	rt_sigreturn			sysn32_rt_sigreturn
-212	common	fcntl64				compat_sys_fcntl64
-213	common	set_tid_address			sys_set_tid_address
-214	common	restart_syscall			sys_restart_syscall
-215	common	semtimedop			sys_semtimedop_time32
-216	common	fadvise64			sys_fadvise64_64
-217	common	statfs64			compat_sys_statfs64
-218	common	fstatfs64			compat_sys_fstatfs64
-219	common	sendfile64			sys_sendfile64
-220	common	timer_create			compat_sys_timer_create
-221	common	timer_settime			sys_timer_settime32
-222	common	timer_gettime			sys_timer_gettime32
-223	common	timer_getoverrun		sys_timer_getoverrun
-224	common	timer_delete			sys_timer_delete
-225	common	clock_settime			sys_clock_settime32
-226	common	clock_gettime			sys_clock_gettime32
-227	common	clock_getres			sys_clock_getres_time32
-228	common	clock_nanosleep			sys_clock_nanosleep_time32
-229	common	tgkill				sys_tgkill
-230	common	utimes				sys_utimes_time32
-231	common	mbind				sys_mbind
-232	common	get_mempolicy			sys_get_mempolicy
-233	common	set_mempolicy			sys_set_mempolicy
-234	common	mq_open				compat_sys_mq_open
-235	common	mq_unlink			sys_mq_unlink
-236	common	mq_timedsend			sys_mq_timedsend_time32
-237	common	mq_timedreceive			sys_mq_timedreceive_time32
-238	common	mq_notify			compat_sys_mq_notify
-239	common	mq_getsetattr			compat_sys_mq_getsetattr
-240	common	vserver				sys_ni_syscall
-241	common	waitid				compat_sys_waitid
-# 242 was sys_setaltroot
-243	common	add_key				sys_add_key
-244	common	request_key			sys_request_key
-245	common	keyctl				compat_sys_keyctl
-246	common	set_thread_area			sys_set_thread_area
-247	common	inotify_init			sys_inotify_init
-248	common	inotify_add_watch		sys_inotify_add_watch
-249	common	inotify_rm_watch		sys_inotify_rm_watch
-250	common	migrate_pages			sys_migrate_pages
-251	common	openat				sys_openat
-252	common	mkdirat				sys_mkdirat
-253	common	mknodat				sys_mknodat
-254	common	fchownat			sys_fchownat
-255	common	futimesat			sys_futimesat_time32
-256	common	newfstatat			sys_newfstatat
-257	common	unlinkat			sys_unlinkat
-258	common	renameat			sys_renameat
-259	common	linkat				sys_linkat
-260	common	symlinkat			sys_symlinkat
-261	common	readlinkat			sys_readlinkat
-262	common	fchmodat			sys_fchmodat
-263	common	faccessat			sys_faccessat
-264	common	pselect6			compat_sys_pselect6_time32
-265	common	ppoll				compat_sys_ppoll_time32
-266	common	unshare				sys_unshare
-267	common	splice				sys_splice
-268	common	sync_file_range			sys_sync_file_range
-269	common	tee				sys_tee
-270	common	vmsplice			sys_vmsplice
-271	common	move_pages			sys_move_pages
-272	common	set_robust_list			compat_sys_set_robust_list
-273	common	get_robust_list			compat_sys_get_robust_list
-274	common	kexec_load			compat_sys_kexec_load
-275	common	getcpu				sys_getcpu
-276	common	epoll_pwait			compat_sys_epoll_pwait
-277	common	ioprio_set			sys_ioprio_set
-278	common	ioprio_get			sys_ioprio_get
-279	common	utimensat			sys_utimensat_time32
-280	common	signalfd			compat_sys_signalfd
-281	common	timerfd				sys_ni_syscall
-282	common	eventfd				sys_eventfd
-283	common	fallocate			sys_fallocate
-284	common	timerfd_create			sys_timerfd_create
-285	common	timerfd_gettime			sys_timerfd_gettime32
-286	common	timerfd_settime			sys_timerfd_settime32
-287	common	signalfd4			compat_sys_signalfd4
-288	common	eventfd2			sys_eventfd2
-289	common	epoll_create1			sys_epoll_create1
-290	common	dup3				sys_dup3
-291	common	pipe2				sys_pipe2
-292	common	inotify_init1			sys_inotify_init1
-293	common	preadv				compat_sys_preadv
-294	common	pwritev				compat_sys_pwritev
-295	common	rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-296	common	perf_event_open			sys_perf_event_open
-297	common	accept4				sys_accept4
-298	common	recvmmsg			compat_sys_recvmmsg_time32
-299	common	getdents64			sys_getdents64
-300	common	fanotify_init			sys_fanotify_init
-301	common	fanotify_mark			sys_fanotify_mark
-302	common	prlimit64			sys_prlimit64
-303	common	name_to_handle_at		sys_name_to_handle_at
-304	common	open_by_handle_at		sys_open_by_handle_at
-305	common	clock_adjtime			sys_clock_adjtime32
-306	common	syncfs				sys_syncfs
-307	common	sendmmsg			compat_sys_sendmmsg
-308	common	setns				sys_setns
-309	common	process_vm_readv		sys_process_vm_readv
-310	common	process_vm_writev		sys_process_vm_writev
-311	common	kcmp				sys_kcmp
-312	common	finit_module			sys_finit_module
-313	common	sched_setattr			sys_sched_setattr
-314	common	sched_getattr			sys_sched_getattr
-315	common	renameat2			sys_renameat2
-316	common	seccomp				sys_seccomp
-317	common	getrandom			sys_getrandom
-318	common	memfd_create			sys_memfd_create
-319	common	bpf				sys_bpf
-320	common	execveat			compat_sys_execveat
-321	common	userfaultfd			sys_userfaultfd
-322	common	membarrier			sys_membarrier
-323	common	mlock2				sys_mlock2
-324	common	copy_file_range			sys_copy_file_range
-325	common	preadv2				compat_sys_preadv2
-326	common	pwritev2			compat_sys_pwritev2
-327	common	pkey_mprotect			sys_pkey_mprotect
-328	common	pkey_alloc			sys_pkey_alloc
-329	common	pkey_free			sys_pkey_free
-330	common	statx				sys_statx
-331	common	rseq				sys_rseq
-332	common	io_pgetevents			compat_sys_io_pgetevents
-# 333 through 402 are unassigned to sync up with generic numbers
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
-413	common	pselect6_time64			compat_sys_pselect6_time64
-414	common	ppoll_time64			compat_sys_ppoll_time64
-416	common	io_pgetevents_time64		compat_sys_io_pgetevents_time64
-417	common	recvmmsg_time64			compat_sys_recvmmsg_time64
-418	common	mq_timedsend_time64		sys_mq_timedsend
-419	common	mq_timedreceive_time64		sys_mq_timedreceive
-420	common	semtimedop_time64		sys_semtimedop
-421	common	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
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
-435	common	clone3				__sys_clone3
-436	common	close_range			sys_close_range
-437	common	openat2				sys_openat2
-438	common	pidfd_getfd			sys_pidfd_getfd
-439	common	faccessat2			sys_faccessat2
-440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			compat_sys_epoll_pwait2
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
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
deleted file mode 100644
index 4341b2fd96da..000000000000
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ /dev/null
@@ -1,389 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-#
-# system call numbers and entry vectors for mips
-#
-# The format is:
-# <number> <abi> <name> <entry point>
-#
-# The <abi> is always "common" for this file.
-#
-0	common	read				sys_read
-1	common	write				sys_write
-2	common	open				sys_open
-3	common	close				sys_close
-4	common	stat				sys_newstat
-5	common	fstat				sys_newfstat
-6	common	lstat				sys_newlstat
-7	common	poll				sys_poll
-8	common	lseek				sys_lseek
-9	common	mmap				sys_mips_mmap
-10	common	mprotect			sys_mprotect
-11	common	munmap				sys_munmap
-12	common	brk				sys_brk
-13	common	rt_sigaction			sys_rt_sigaction
-14	common	rt_sigprocmask			sys_rt_sigprocmask
-15	common	ioctl				sys_ioctl
-16	common	pread64				sys_pread64
-17	common	pwrite64			sys_pwrite64
-18	common	readv				sys_readv
-19	common	writev				sys_writev
-20	common	access				sys_access
-21	common	pipe				sysm_pipe
-22	common	_newselect			sys_select
-23	common	sched_yield			sys_sched_yield
-24	common	mremap				sys_mremap
-25	common	msync				sys_msync
-26	common	mincore				sys_mincore
-27	common	madvise				sys_madvise
-28	common	shmget				sys_shmget
-29	common	shmat				sys_shmat
-30	common	shmctl				sys_old_shmctl
-31	common	dup				sys_dup
-32	common	dup2				sys_dup2
-33	common	pause				sys_pause
-34	common	nanosleep			sys_nanosleep
-35	common	getitimer			sys_getitimer
-36	common	setitimer			sys_setitimer
-37	common	alarm				sys_alarm
-38	common	getpid				sys_getpid
-39	common	sendfile			sys_sendfile64
-40	common	socket				sys_socket
-41	common	connect				sys_connect
-42	common	accept				sys_accept
-43	common	sendto				sys_sendto
-44	common	recvfrom			sys_recvfrom
-45	common	sendmsg				sys_sendmsg
-46	common	recvmsg				sys_recvmsg
-47	common	shutdown			sys_shutdown
-48	common	bind				sys_bind
-49	common	listen				sys_listen
-50	common	getsockname			sys_getsockname
-51	common	getpeername			sys_getpeername
-52	common	socketpair			sys_socketpair
-53	common	setsockopt			sys_setsockopt
-54	common	getsockopt			sys_getsockopt
-55	common	clone				__sys_clone
-56	common	fork				__sys_fork
-57	common	execve				sys_execve
-58	common	exit				sys_exit
-59	common	wait4				sys_wait4
-60	common	kill				sys_kill
-61	common	uname				sys_newuname
-62	common	semget				sys_semget
-63	common	semop				sys_semop
-64	common	semctl				sys_old_semctl
-65	common	shmdt				sys_shmdt
-66	common	msgget				sys_msgget
-67	common	msgsnd				sys_msgsnd
-68	common	msgrcv				sys_msgrcv
-69	common	msgctl				sys_old_msgctl
-70	common	fcntl				sys_fcntl
-71	common	flock				sys_flock
-72	common	fsync				sys_fsync
-73	common	fdatasync			sys_fdatasync
-74	common	truncate			sys_truncate
-75	common	ftruncate			sys_ftruncate
-76	common	getdents			sys_getdents
-77	common	getcwd				sys_getcwd
-78	common	chdir				sys_chdir
-79	common	fchdir				sys_fchdir
-80	common	rename				sys_rename
-81	common	mkdir				sys_mkdir
-82	common	rmdir				sys_rmdir
-83	common	creat				sys_creat
-84	common	link				sys_link
-85	common	unlink				sys_unlink
-86	common	symlink				sys_symlink
-87	common	readlink			sys_readlink
-88	common	chmod				sys_chmod
-89	common	fchmod				sys_fchmod
-90	common	chown				sys_chown
-91	common	fchown				sys_fchown
-92	common	lchown				sys_lchown
-93	common	umask				sys_umask
-94	common	gettimeofday			sys_gettimeofday
-95	common	getrlimit			sys_getrlimit
-96	common	getrusage			sys_getrusage
-97	common	sysinfo				sys_sysinfo
-98	common	times				sys_times
-99	common	ptrace				sys_ptrace
-100	common	getuid				sys_getuid
-101	common	syslog				sys_syslog
-102	common	getgid				sys_getgid
-103	common	setuid				sys_setuid
-104	common	setgid				sys_setgid
-105	common	geteuid				sys_geteuid
-106	common	getegid				sys_getegid
-107	common	setpgid				sys_setpgid
-108	common	getppid				sys_getppid
-109	common	getpgrp				sys_getpgrp
-110	common	setsid				sys_setsid
-111	common	setreuid			sys_setreuid
-112	common	setregid			sys_setregid
-113	common	getgroups			sys_getgroups
-114	common	setgroups			sys_setgroups
-115	common	setresuid			sys_setresuid
-116	common	getresuid			sys_getresuid
-117	common	setresgid			sys_setresgid
-118	common	getresgid			sys_getresgid
-119	common	getpgid				sys_getpgid
-120	common	setfsuid			sys_setfsuid
-121	common	setfsgid			sys_setfsgid
-122	common	getsid				sys_getsid
-123	common	capget				sys_capget
-124	common	capset				sys_capset
-125	common	rt_sigpending			sys_rt_sigpending
-126	common	rt_sigtimedwait			sys_rt_sigtimedwait
-127	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
-128	common	rt_sigsuspend			sys_rt_sigsuspend
-129	common	sigaltstack			sys_sigaltstack
-130	common	utime				sys_utime
-131	common	mknod				sys_mknod
-132	common	personality			sys_personality
-133	common	ustat				sys_ustat
-134	common	statfs				sys_statfs
-135	common	fstatfs				sys_fstatfs
-136	common	sysfs				sys_sysfs
-137	common	getpriority			sys_getpriority
-138	common	setpriority			sys_setpriority
-139	common	sched_setparam			sys_sched_setparam
-140	common	sched_getparam			sys_sched_getparam
-141	common	sched_setscheduler		sys_sched_setscheduler
-142	common	sched_getscheduler		sys_sched_getscheduler
-143	common	sched_get_priority_max		sys_sched_get_priority_max
-144	common	sched_get_priority_min		sys_sched_get_priority_min
-145	common	sched_rr_get_interval		sys_sched_rr_get_interval
-146	common	mlock				sys_mlock
-147	common	munlock				sys_munlock
-148	common	mlockall			sys_mlockall
-149	common	munlockall			sys_munlockall
-150	common	vhangup				sys_vhangup
-151	common	pivot_root			sys_pivot_root
-152	common	_sysctl				sys_ni_syscall
-153	common	prctl				sys_prctl
-154	common	adjtimex			sys_adjtimex
-155	common	setrlimit			sys_setrlimit
-156	common	chroot				sys_chroot
-157	common	sync				sys_sync
-158	common	acct				sys_acct
-159	common	settimeofday			sys_settimeofday
-160	common	mount				sys_mount
-161	common	umount2				sys_umount
-162	common	swapon				sys_swapon
-163	common	swapoff				sys_swapoff
-164	common	reboot				sys_reboot
-165	common	sethostname			sys_sethostname
-166	common	setdomainname			sys_setdomainname
-167	common	create_module			sys_ni_syscall
-168	common	init_module			sys_init_module
-169	common	delete_module			sys_delete_module
-170	common	get_kernel_syms			sys_ni_syscall
-171	common	query_module			sys_ni_syscall
-172	common	quotactl			sys_quotactl
-173	common	nfsservctl			sys_ni_syscall
-174	common	getpmsg				sys_ni_syscall
-175	common	putpmsg				sys_ni_syscall
-176	common	afs_syscall			sys_ni_syscall
-# 177 reserved for security
-177	common	reserved177			sys_ni_syscall
-178	common	gettid				sys_gettid
-179	common	readahead			sys_readahead
-180	common	setxattr			sys_setxattr
-181	common	lsetxattr			sys_lsetxattr
-182	common	fsetxattr			sys_fsetxattr
-183	common	getxattr			sys_getxattr
-184	common	lgetxattr			sys_lgetxattr
-185	common	fgetxattr			sys_fgetxattr
-186	common	listxattr			sys_listxattr
-187	common	llistxattr			sys_llistxattr
-188	common	flistxattr			sys_flistxattr
-189	common	removexattr			sys_removexattr
-190	common	lremovexattr			sys_lremovexattr
-191	common	fremovexattr			sys_fremovexattr
-192	common	tkill				sys_tkill
-193	common	reserved193			sys_ni_syscall
-194	common	futex				sys_futex
-195	common	sched_setaffinity		sys_sched_setaffinity
-196	common	sched_getaffinity		sys_sched_getaffinity
-197	common	cacheflush			sys_cacheflush
-198	common	cachectl			sys_cachectl
-199	common	sysmips				__sys_sysmips
-200	common	io_setup			sys_io_setup
-201	common	io_destroy			sys_io_destroy
-202	common	io_getevents			sys_io_getevents
-203	common	io_submit			sys_io_submit
-204	common	io_cancel			sys_io_cancel
-205	common	exit_group			sys_exit_group
-206	common	lookup_dcookie			sys_ni_syscall
-207	common	epoll_create			sys_epoll_create
-208	common	epoll_ctl			sys_epoll_ctl
-209	common	epoll_wait			sys_epoll_wait
-210	common	remap_file_pages		sys_remap_file_pages
-211	common	rt_sigreturn			sys_rt_sigreturn
-212	common	set_tid_address			sys_set_tid_address
-213	common	restart_syscall			sys_restart_syscall
-214	common	semtimedop			sys_semtimedop
-215	common	fadvise64			sys_fadvise64_64
-216	common	timer_create			sys_timer_create
-217	common	timer_settime			sys_timer_settime
-218	common	timer_gettime			sys_timer_gettime
-219	common	timer_getoverrun		sys_timer_getoverrun
-220	common	timer_delete			sys_timer_delete
-221	common	clock_settime			sys_clock_settime
-222	common	clock_gettime			sys_clock_gettime
-223	common	clock_getres			sys_clock_getres
-224	common	clock_nanosleep			sys_clock_nanosleep
-225	common	tgkill				sys_tgkill
-226	common	utimes				sys_utimes
-227	common	mbind				sys_mbind
-228	common	get_mempolicy			sys_get_mempolicy
-229	common	set_mempolicy			sys_set_mempolicy
-230	common	mq_open				sys_mq_open
-231	common	mq_unlink			sys_mq_unlink
-232	common	mq_timedsend			sys_mq_timedsend
-233	common	mq_timedreceive			sys_mq_timedreceive
-234	common	mq_notify			sys_mq_notify
-235	common	mq_getsetattr			sys_mq_getsetattr
-236	common	vserver				sys_ni_syscall
-237	common	waitid				sys_waitid
-# 238 was sys_setaltroot
-239	common	add_key				sys_add_key
-240	common	request_key			sys_request_key
-241	common	keyctl				sys_keyctl
-242	common	set_thread_area			sys_set_thread_area
-243	common	inotify_init			sys_inotify_init
-244	common	inotify_add_watch		sys_inotify_add_watch
-245	common	inotify_rm_watch		sys_inotify_rm_watch
-246	common	migrate_pages			sys_migrate_pages
-247	common	openat				sys_openat
-248	common	mkdirat				sys_mkdirat
-249	common	mknodat				sys_mknodat
-250	common	fchownat			sys_fchownat
-251	common	futimesat			sys_futimesat
-252	common	newfstatat			sys_newfstatat
-253	common	unlinkat			sys_unlinkat
-254	common	renameat			sys_renameat
-255	common	linkat				sys_linkat
-256	common	symlinkat			sys_symlinkat
-257	common	readlinkat			sys_readlinkat
-258	common	fchmodat			sys_fchmodat
-259	common	faccessat			sys_faccessat
-260	common	pselect6			sys_pselect6
-261	common	ppoll				sys_ppoll
-262	common	unshare				sys_unshare
-263	common	splice				sys_splice
-264	common	sync_file_range			sys_sync_file_range
-265	common	tee				sys_tee
-266	common	vmsplice			sys_vmsplice
-267	common	move_pages			sys_move_pages
-268	common	set_robust_list			sys_set_robust_list
-269	common	get_robust_list			sys_get_robust_list
-270	common	kexec_load			sys_kexec_load
-271	common	getcpu				sys_getcpu
-272	common	epoll_pwait			sys_epoll_pwait
-273	common	ioprio_set			sys_ioprio_set
-274	common	ioprio_get			sys_ioprio_get
-275	common	utimensat			sys_utimensat
-276	common	signalfd			sys_signalfd
-277	common	timerfd				sys_ni_syscall
-278	common	eventfd				sys_eventfd
-279	common	fallocate			sys_fallocate
-280	common	timerfd_create			sys_timerfd_create
-281	common	timerfd_gettime			sys_timerfd_gettime
-282	common	timerfd_settime			sys_timerfd_settime
-283	common	signalfd4			sys_signalfd4
-284	common	eventfd2			sys_eventfd2
-285	common	epoll_create1			sys_epoll_create1
-286	common	dup3				sys_dup3
-287	common	pipe2				sys_pipe2
-288	common	inotify_init1			sys_inotify_init1
-289	common	preadv				sys_preadv
-290	common	pwritev				sys_pwritev
-291	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
-292	common	perf_event_open			sys_perf_event_open
-293	common	accept4				sys_accept4
-294	common	recvmmsg			sys_recvmmsg
-295	common	fanotify_init			sys_fanotify_init
-296	common	fanotify_mark			sys_fanotify_mark
-297	common	prlimit64			sys_prlimit64
-298	common	name_to_handle_at		sys_name_to_handle_at
-299	common	open_by_handle_at		sys_open_by_handle_at
-300	common	clock_adjtime			sys_clock_adjtime
-301	common	syncfs				sys_syncfs
-302	common	sendmmsg			sys_sendmmsg
-303	common	setns				sys_setns
-304	common	process_vm_readv		sys_process_vm_readv
-305	common	process_vm_writev		sys_process_vm_writev
-306	common	kcmp				sys_kcmp
-307	common	finit_module			sys_finit_module
-308	common	getdents64			sys_getdents64
-309	common	sched_setattr			sys_sched_setattr
-310	common	sched_getattr			sys_sched_getattr
-311	common	renameat2			sys_renameat2
-312	common	seccomp				sys_seccomp
-313	common	getrandom			sys_getrandom
-314	common	memfd_create			sys_memfd_create
-315	common	bpf				sys_bpf
-316	common	execveat			sys_execveat
-317	common	userfaultfd			sys_userfaultfd
-318	common	membarrier			sys_membarrier
-319	common	mlock2				sys_mlock2
-320	common	copy_file_range			sys_copy_file_range
-321	common	preadv2				sys_preadv2
-322	common	pwritev2			sys_pwritev2
-323	common	pkey_mprotect			sys_pkey_mprotect
-324	common	pkey_alloc			sys_pkey_alloc
-325	common	pkey_free			sys_pkey_free
-326	common	statx				sys_statx
-327	common	rseq				sys_rseq
-328	common	io_pgetevents			sys_io_pgetevents
-# 329 through 423 are reserved to sync up with other architectures
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
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index c38417e79db8..4e228f2888a7 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -391,72 +391,3 @@
 400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
 401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
 402	common	msgctl				sys_msgctl			compat_sys_msgctl
-403	common	clock_gettime64			sys_clock_gettime		sys_clock_gettime
-404	common	clock_settime64			sys_clock_settime		sys_clock_settime
-405	common	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
-406	common	clock_getres_time64		sys_clock_getres		sys_clock_getres
-407	common	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
-408	common	timer_gettime64			sys_timer_gettime		sys_timer_gettime
-409	common	timer_settime64			sys_timer_settime		sys_timer_settime
-410	common	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
-411	common	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
-412	common	utimensat_time64		sys_utimensat			sys_utimensat
-413	common	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
-414	common	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	common	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
-417	common	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
-418	common	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
-419	common	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
-420	common	semtimedop_time64		sys_semtimedop			sys_semtimedop
-421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
-422	common	futex_time64			sys_futex			sys_futex
-423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
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

-- 
2.55.0

