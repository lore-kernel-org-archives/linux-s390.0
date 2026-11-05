Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909183;
	b=4wNbe0zeiaXZO5oVYe8+tn5fs8T/do/hwdRKbvFfOSAmUKLX7cG085L+f/gFVuqclPsN
	 yo/WJBs0q/VY516fVGrwKlQgvGjjVvaYpCu3AEDJzc1Fbdst11t38O5Ys5c6aFHRQX+eM
	 NMrkBGhNYD/QC0vxgmm20oiHOXQdiVMfljipSW66KNoKAvjPLezkyCfNwSeHvDJgTyTmF
	 fk0tY2pZ7gnl/Lb/VQmw5Bd6cTdgbasILBKlz3MMDGVl8GJ/MjV3mMBcMZijTo6wZMeh6
	 6lyKyDF0p+BfQikDXO6OvquY6S/uiGhXtA0XnUMbLYIACpLXI/TV5XjKrFGxPzd1MvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909183;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=4hCktccHtejmQbaITCsv7n1x218udDpnCxY767poopA=;
	b=RYWWAJHqrLc0sTC/lQDDZ8Rfz/NIHUDPcDenXdcsBfKVbJdthFf/wicZbWdrdzbI36fg
	 NlIdEKm/ADQHgpafkA4uLbdgK7TiDEoEJLWIbS/dcvKj9+ipbMe6nM4zyNkXzKN25hXto
	 XLXTcNMLUBc+gS29l48KOrXzZ678VDHLNSO14DPvDOFbgGo+7EJ+UdLF2Qz2yaWzn0En7
	 pJxae7iKJE2w0ELXMubioWH6t44CNYKTfjhlObf626PfBeqKsg1tKC+9FSW4YmyLjElsh
	 7pYd1lLbJiCfuG/aqZT0z2cPkq3Ld5PAZ0D0wO8K536gcq1LobRsUCFlyt0SvVuF1MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Aq0LrMMj;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9C606A31B;
	Thu,  5 Nov 2026 20:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EB9C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Aq0LrMMj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=4hCktccHtejmQbaITCsv7n1x218udDpnCxY767poopA=; t=1793909177; x=2109269177; 
	b=Aq0LrMMjpZHhDcKRQtYRZcoWNj+KpYUB23xKcfmWE5EilCyEzBfuOal12MV7wCDajXpZUcFH0S/
	HS1i9oq0jZlwjAhn9zhNmeQeRzQnSShXvaqRpijXyyq93mk9lIBuxHxpWeRdIkjt20JS1XOXD0pTf
	7lp41xO9YryYHBvoBwALHgnop10zdvjvHihamX7y7g4N0dran5j/N9RnU+4Iq+m8DznRyc5/KqPjG
	RqqS2QPAU+8cvwTPMjsCY8GkJWsS5e/gTOJjBb5hKISwy3gbQEL32gABN0R8Lf7wLEn+Mh1axnnQX
	G5PvHfSi+MQYKn9FGfwJYtfa+1MyOHsgpEpg==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3ix-003hS1-AY; Thu, 05 Nov 2026 21:06:15 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:38 -0300
Subject: [PATCH v9 03/15] scripts/syscall.tbl: Use the common table
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
Message-Id: <20261105-tonyk-syscall_table-v9-3-8d1275885d9c@igalia.com>
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

Remove some of the duplicated code by using the common syscall number
table.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/arc/kernel/Makefile.syscalls       |  2 +-
 arch/arm64/kernel/Makefile.syscalls     |  4 +-
 arch/arm64/tools/syscall_32.tbl         | 69 ---------------------------------
 arch/csky/kernel/Makefile.syscalls      |  3 +-
 arch/hexagon/kernel/Makefile.syscalls   |  2 +-
 arch/loongarch/kernel/Makefile.syscalls |  4 +-
 arch/nios2/kernel/Makefile.syscalls     |  2 +-
 arch/nios2/kernel/syscall_table.c       |  1 -
 arch/openrisc/kernel/Makefile.syscalls  |  2 +-
 arch/openrisc/kernel/sys_call_table.c   |  1 -
 arch/riscv/kernel/Makefile.syscalls     |  4 +-
 scripts/Makefile.asm-headers            | 11 +++---
 scripts/syscall.tbl                     | 69 ---------------------------------
 13 files changed, 17 insertions(+), 157 deletions(-)

diff --git a/arch/arc/kernel/Makefile.syscalls b/arch/arc/kernel/Makefile.syscalls
index 391d30ab7a83..507c4fff3f6b 100644
--- a/arch/arc/kernel/Makefile.syscalls
+++ b/arch/arc/kernel/Makefile.syscalls
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += arc time32 renameat stat64 rlimit
+syscall_abis_32 += arc time32 renameat stat64 rlimit clone3
diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Makefile.syscalls
index 0542a718871a..07de53e502a2 100644
--- a/arch/arm64/kernel/Makefile.syscalls
+++ b/arch/arm64/kernel/Makefile.syscalls
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 +=
-syscall_abis_64 += renameat rlimit memfd_secret
+syscall_abis_32 += clone3
+syscall_abis_64 += renameat rlimit memfd_secret clone3
 
 syscalltbl = arch/arm64/tools/syscall_%.tbl
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index df2d1d82fb3c..957cb7d59443 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -415,72 +415,3 @@
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
-413	common	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
-414	common	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	common	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
-417	common	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
-418	common	mq_timedsend_time64		sys_mq_timedsend
-419	common	mq_timedreceive_time64		sys_mq_timedreceive
-420	common	semtimedop_time64		sys_semtimedop
-421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
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
diff --git a/arch/csky/kernel/Makefile.syscalls b/arch/csky/kernel/Makefile.syscalls
index 3df3b5822fce..15783a984619 100644
--- a/arch/csky/kernel/Makefile.syscalls
+++ b/arch/csky/kernel/Makefile.syscalls
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += csky time32 stat64 rlimit
-
+syscall_abis_32 += csky time32 stat64 rlimit clone3
diff --git a/arch/hexagon/kernel/Makefile.syscalls b/arch/hexagon/kernel/Makefile.syscalls
index d2b7c5d44d95..d164b9728d23 100644
--- a/arch/hexagon/kernel/Makefile.syscalls
+++ b/arch/hexagon/kernel/Makefile.syscalls
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += hexagon time32 stat64 rlimit renameat
+syscall_abis_32 += hexagon time32 stat64 rlimit renameat clone3
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index 06f160502537..dbfddf37b329 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += memfd_secret
-syscall_abis_64 += memfd_secret
+syscall_abis_32 += memfd_secret clone3
+syscall_abis_64 += memfd_secret clone3
diff --git a/arch/nios2/kernel/Makefile.syscalls b/arch/nios2/kernel/Makefile.syscalls
index 579a9daec272..cf68c3e82d5e 100644
--- a/arch/nios2/kernel/Makefile.syscalls
+++ b/arch/nios2/kernel/Makefile.syscalls
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += nios2 time32 stat64 renameat rlimit
+syscall_abis_32 += nios2 time32 stat64 renameat rlimit __clone3
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
index c99818aac9e1..434694067d8f 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -13,7 +13,6 @@
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
 
 #define sys_mmap2 sys_mmap_pgoff
-#define sys_clone3 __sys_clone3
 
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
diff --git a/arch/openrisc/kernel/Makefile.syscalls b/arch/openrisc/kernel/Makefile.syscalls
index 525a1e7e7fc9..85306750e03c 100644
--- a/arch/openrisc/kernel/Makefile.syscalls
+++ b/arch/openrisc/kernel/Makefile.syscalls
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += or1k time32 stat64 rlimit renameat
+syscall_abis_32 += or1k time32 stat64 rlimit renameat __clone3
diff --git a/arch/openrisc/kernel/sys_call_table.c b/arch/openrisc/kernel/sys_call_table.c
index b2f57e2538f7..7dda255db7d9 100644
--- a/arch/openrisc/kernel/sys_call_table.c
+++ b/arch/openrisc/kernel/sys_call_table.c
@@ -21,7 +21,6 @@
 
 #define sys_mmap2 sys_mmap_pgoff
 #define sys_clone __sys_clone
-#define sys_clone3 __sys_clone3
 #define sys_fork __sys_fork
 
 void *sys_call_table[__NR_syscalls] = {
diff --git a/arch/riscv/kernel/Makefile.syscalls b/arch/riscv/kernel/Makefile.syscalls
index 9668fd1faf60..436123cf0ee5 100644
--- a/arch/riscv/kernel/Makefile.syscalls
+++ b/arch/riscv/kernel/Makefile.syscalls
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-syscall_abis_32 += riscv memfd_secret
-syscall_abis_64 += riscv rlimit memfd_secret
+syscall_abis_32 += riscv memfd_secret clone3
+syscall_abis_64 += riscv rlimit memfd_secret clone3
diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
index f1c3d287c14b..89706d20f896 100644
--- a/scripts/Makefile.asm-headers
+++ b/scripts/Makefile.asm-headers
@@ -18,6 +18,7 @@ src := $(srctree)/$(subst /generated,,$(obj))
 syscall_abis_32  += common,32
 syscall_abis_64  += common,64
 syscalltbl := $(srctree)/scripts/syscall.tbl
+syscalltbl_common := $(srctree)/scripts/syscall_common.tbl
 syshdr-args := --emit-nr
 
 # let architectures override $(syscall_abis_%) and $(syscalltbl)
@@ -57,14 +58,14 @@ quiet_cmd_remove = REMOVE  $(unwanted)
       cmd_remove = rm -f $(unwanted); find $(obj) -type d -empty -delete
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) \
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --common-tbl $(syscalltbl_common) \
 		   $(if $(syshdr-args-$*),$(syshdr-args-$*),$(syshdr-args)) \
 		   $(if $(syscall_compat),--prefix "compat$*_") \
 		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
 		   $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --common-tbl $(syscalltbl_common) \
 		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
 		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
 		   $< $@
@@ -76,14 +77,14 @@ all: $(generic-y) $(syscall-y)
 $(obj)/%.h: $(srctree)/$(generic)/%.h FORCE
 	$(call filechk,wrap)
 
-$(obj)/unistd_%.h: $(syscalltbl) $(syshdr) FORCE
+$(obj)/unistd_%.h: $(syscalltbl) $(syscalltbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 $(obj)/unistd_compat_%.h: syscall_compat:=1
-$(obj)/unistd_compat_%.h: $(syscalltbl) $(syshdr) FORCE
+$(obj)/unistd_compat_%.h: $(syscalltbl) $(syscalltbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(obj)/syscall_table_%.h: $(syscalltbl) $(systbl) FORCE
+$(obj)/syscall_table_%.h: $(syscalltbl) $(syscalltbl_common) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 targets := $(syscall-y)
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 0ab531605120..ee828d03094e 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
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

-- 
2.56.0

