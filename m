Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909195;
	b=uK3RmiRgDL/eBsVg5azv5H8DtHXzTaymkInf221yZ3xa3gydvZZwZ+ooDRG2S+gSmpsZ
	 +HRqSiUOrBUMAmo28KW6KRog6JSYg+mQO3/8V4PfVjUX+5tUS8/o66ubs+fgaa84R3nDV
	 NwTWMqJnuANwh5R1jGR0CRVvuyLbWr3cE3XaF5x6TTtr66tA8WYZeKOTn95Op+LJZVDKV
	 bti8RCsHW6d//FECqyDbRHeWjhuBdTFyy6xem3B+oqM2riZifj+SrCo/IcvrWXbaIWyly
	 AOw5vm9kRorHEtVp+Ga99YcZddu7qAz6DGnJAg0JjOEgPZNb/qY6EhAsBrgVWgVe76g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909195;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=LQ3Xg6CxvvU2iv9DdL4h/2msHF75RV9KEBgisv8r64I=;
	b=ajdWAckj7W6KA3B8DKxsdjLwJblMCFgXkWXC6yNsOICl0iQtnnpimKKtplUT/Rxl0Twn
	 /A8vzyVdjAPxZHXAqXLd/GzGE208aewtlKhbEMe+iHqYH0Zkws0RaHhrldyi598lCGpW2
	 zGXabqpCfboS/tVmNySHX2BNtsTb0IxxpqUhGWYm0zAETZC5IAf+4XAiTC0YU6+W1Nepx
	 TDzhEsKv5wik7nbv2ynG0zmfc4a+JvVxKXA6wN/4WhnyVInCa2MbLijMrKEZTeWZWB+/3
	 JH8xC0jrG0u4bKjldkLqh+7jsAsQXksa7x9LlqXttheK7qDEfo50DF3QRkME/LSfIsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="B/Q/6wCY";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461A606D81E;
	Thu,  5 Nov 2026 20:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9461A606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=B/Q/6wCY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=LQ3Xg6CxvvU2iv9DdL4h/2msHF75RV9KEBgisv8r64I=; t=1793909194; x=2109269194; 
	b=B/Q/6wCY/2/pvR4W6L638pGCVqeBZXExQ0Ddah5vzkZ9MbRAvDBJ2pBr7HEVybOS0zh738IcZ8r
	3SBTaepbbUlDR3XGQKstnj6t93n25GKbJjcacOQqeGyD7NAL1aWrIzNeAE4hlMflliyc2pjjEB2yG
	i7Iwgy2+NcdNVBIQg0jGLavaN1U9Gb3qLZk8uDKtzRere5paQe1x1EGMqhxQYoSRCH2Rdtt0pDx5n
	RwExiy/qUIBm32RxKj462SP75XLCaL+T/ohUdWb2C3XImEeejnK/96m2MMUvM0r5/iRlphQzvLRDV
	qFRD9scNYlbEEm5adx6I3btafgg7MFNFSlJg==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3jE-003hS1-AC; Thu, 05 Nov 2026 21:06:32 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:43 -0300
Subject: [PATCH v9 08/15] mips: Use the common syscall table
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
Message-Id: <20261105-tonyk-syscall_table-v9-8-8d1275885d9c@igalia.com>
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

Syscall numbers from 403 are shared with all architectures, so move the
toolchain to use the common syscall table and remove duplicated code.

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
Changes from v7:
- Remove common file syscall_n.tbl for n32 and n64, keep them separated

Changes from v6:
- Add abis to sysnr rule
- Fix syscall typos (sigtimed_wait_time, usta)
- Fix rebuild rules
---
 arch/mips/kernel/scall64-n32.S            |  1 +
 arch/mips/kernel/scall64-n64.S            |  1 +
 arch/mips/kernel/syscalls/Makefile        | 23 ++++++++---
 arch/mips/kernel/syscalls/syscall_n32.tbl | 69 -------------------------------
 arch/mips/kernel/syscalls/syscall_n64.tbl | 49 ----------------------
 arch/mips/kernel/syscalls/syscall_o32.tbl | 69 -------------------------------
 6 files changed, 19 insertions(+), 193 deletions(-)

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
index be11ea5cc67e..a8fb8a3f7234 100644
--- a/arch/mips/kernel/scall64-n64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -109,6 +109,7 @@ illegal_syscall:
 	j	n64_syscall_exit
 	END(handle_sys64)
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
 #define __SYSCALL(nr, entry)	PTR_WD entry
 	.align	3
 	.type	sys_call_table, @object
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index 1bfc2346d100..e9ad494678bf 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -7,28 +7,39 @@ $(shell mkdir -p $(uapi) $(kapi))
 syshdr := $(srctree)/scripts/syscallhdr.sh
 sysnr := $(srctree)/scripts/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+systbl_common := $(srctree)/scripts/syscall_common.tbl
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --offset __NR_Linux \
+		   --common-tbl $(systbl_common) \
+		   --abis $(abis_$*) $< $@
 
 quiet_cmd_sysnr = SYSNR   $@
-      cmd_sysnr = $(CONFIG_SHELL) $(sysnr) \
+      cmd_sysnr = $(CONFIG_SHELL) $(sysnr) --abis $(abis_$*) \
 		  --prefix $(sysnr_pfx_$(basetarget))_Linux_ $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
+		   --common-tbl $(systbl_common) \
+		   --abis $(abis_$*) $< $@
 
-$(uapi)/unistd_%.h: $(src)/syscall_%.tbl $(syshdr) FORCE
+$(uapi)/unistd_%.h: $(src)/syscall_%.tbl $(systbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
 sysnr_pfx_unistd_nr_n32 := N32
 sysnr_pfx_unistd_nr_n64 := 64
 sysnr_pfx_unistd_nr_o32 := O32
 
-$(kapi)/unistd_nr_%.h: $(src)/syscall_%.tbl $(sysnr) FORCE
+abis := common,__clone3
+
+abis_n32 := $(abis),32
+abis_o32 := $(abis_n32)
+abis_n64 := $(abis),64
+
+$(kapi)/unistd_nr_%.h: $(systbl_common) $(src)/syscall_%.tbl $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(src)/syscall_%.tbl $(systbl_common) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_n32.h			\
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 29df491b52b7..6cb5d6bb4f69 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -342,72 +342,3 @@
 331	common	rseq				sys_rseq
 332	common	io_pgetevents			compat_sys_io_pgetevents
 # 333 through 402 are unassigned to sync up with generic numbers
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
index 4341b2fd96da..bdec294ba8cd 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -338,52 +338,3 @@
 327	common	rseq				sys_rseq
 328	common	io_pgetevents			sys_io_pgetevents
 # 329 through 423 are reserved to sync up with other architectures
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
2.56.0

