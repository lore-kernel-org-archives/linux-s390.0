Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8A390613;
	Fri, 28 Aug 2026 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959196; cv=none; b=l2clTRSG86cqeBF3Pc6VQ/ijyCs7Pg6elkJjeNUIROQNMrBSHzmkYNbMwHRH6FqcGqjOI4Uag6lgpIaEcaJmcm9J9bGBlJAbWwmjVAa0XtUsyDF+lDw7+VU9EnfsOouqWqnvNb1CLMkADV/mwi4NL9aZ5Cmrl9vt8wYoGeDTqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959196; c=relaxed/simple;
	bh=I+D9DU+Qpmg6RqRVmUX2SYVB/9dM3/8yOvA5K/u7xmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaNNNfA8JKNqpjInSaEiKrfANOJ8UPMhSXyL+vGub2KjGrhtj38dKBqIPxa1XrhsyD5MrrAKktYVXUSveZyTOibcnP6FTXn0VraPgVg9FvfIx07H9wsL42dg68stXggl3kHgAcCCSDzurR2ZWTRoYBlwBl0CtNXmhIiHomZnSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P3ARgATb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P3ARgATb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=QBpxSHcypfaZGJ3KDm3E4qbpfYym6ulrsKFG5WrKJFw=; b=P3ARgATbVlfgkuQwD8CZ/9g54C
	nO2xiCCGE7QDxRTVXEpN8XHUqqY2yUs6a8ffR9uTDDbwHkf6m39UVkDYuKg2J/pTL6CWg/HXtZDNz
	Ce7odWVjmSuCsML5bhIr9ppswJQC0OfYt3L0JcFa7Z0SV/EUEaINkLDRM6PQRjyw09XGvCL+a884F
	Bt45BjAgqPZM/t4mWOlUI/mNPmPJzXUzzftnyIuD/RVngMYVm7C0+KPii6a0Ma5rZAhMDPiBqROiy
	P33jPNWQTk3A3x1UDjyWQx95oquughtxhLiupsKm6oaHdQFGoIr9PFmH9uAWlZAO2e7mo3B1feVZQ
	4+ZmmU0g==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rT-00B3sF-1H; Sat, 29 Aug 2026 01:19:51 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 28 Aug 2026 20:19:30 -0300
Subject: [PATCH v6 03/13] scripts/syscall.tbl: Use the common table
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-tonyk-syscall_table-v6-3-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
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
 arch/arm64/tools/syscall_32.tbl | 69 -----------------------------------------
 scripts/Makefile.asm-headers    | 15 ++++-----
 scripts/syscall.tbl             | 69 -----------------------------------------
 3 files changed, 8 insertions(+), 145 deletions(-)

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
diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
index b38931314ad7..e81d3ef8938c 100644
--- a/scripts/Makefile.asm-headers
+++ b/scripts/Makefile.asm-headers
@@ -15,9 +15,10 @@ all:
 
 src := $(srctree)/$(subst /generated,,$(obj))
 
-syscall_abis_32  += common,32
-syscall_abis_64  += common,64
+syscall_abis_32  += clone3,common,32
+syscall_abis_64  += clone3,common,64
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
2.55.0

