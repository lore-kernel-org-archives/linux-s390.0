Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909184;
	b=r70PthGHLsRCyyBVK9le5cwUdHRbiwGDGhYNsFP5mos2FjApRuCBwkPUjY2usCiyQVr2
	 WkifthXOAN+TOyv5SYC3+0vjXsu5Z0C7wNQspFC3t/68MYdBjuk3w+NZWUWzNTQ9IXQaK
	 c9Gq+kZ2IVSufLYmh3bJi/wVZqbqVvnY72+fF2z1BOyj6N8DSRh0vzZboxgyM9VCtu2qi
	 OOwX8rKGNVHj9QhO1gkSlMOlnkRcUE4/LTFxTJKulaPqIZxh9pLo+UeXXX8JI4XohIRdN
	 Qng/j8quGVfGo8gMwe4e+jIYrrKGCyrEhFYVyUJGSlA6ppqsaX/tQ3EyWoW96AmnTIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909184;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=yNbuuc7ThMlt79T0UHc6c2gYE5BOeK1088M/tFwNgc4=;
	b=kQ7uHB0GXjU0NURRtCoHBhAKaTRBb5xQijZNW0Vf6zWn+fO9+TMGkFWKdXCCqSe03Oh+
	 emvhsFb/NNAiCwNlgCgMCCiZGjbsCuoO8QVKow4fdYtPG99Kx4dqairW2ACX8ftDinMl3
	 1/AoT7kUV6kRtZ2e8Shh/c3NC3FxLGVGBr1NoqsRXcAFhk7GggClcswXvRV9wb7lsWfRe
	 EpmZOpTUeDUEA/lHNlm1jMi5L7GZl9TQXKCzKTXe7Wq3lfamMxf2bhP2u09P8XTI6tYeM
	 pCIIUblhX/Gwga9vAOfwSFTYhAvd4yHXzw+SLDd1dyvz/9ohhLYOIfNTMljfFdE0P/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RE5SdS11;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741A606D82E;
	Thu,  5 Nov 2026 20:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4741A606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=RE5SdS11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=yNbuuc7ThMlt79T0UHc6c2gYE5BOeK1088M/tFwNgc4=; t=1793909184; x=2109269184; 
	b=RE5SdS11UOXckNkKFdtCja9CUeeRlXbVScptzxdYZ3aEe4OPg5xwjz541HcmETKW0dOnegyi6ul
	mZwikBL8I6BYP1neQ9c+Iqd9C1QxKHAXKrCPZuZlOT9UXqc4kwVPUD6eUcaWOZy10vSRvuzqxz4o1
	0LrzV9Hz9P9mjlZtH/60jz7zVAl3dQLJrNs0xqLfHtH8nvJbfVQ4t3/D0jDABTtFuAKvKeHUtUBV/
	F7wEcuJg+xiTKVLPoWGOzRWk8zEzIbScd9klc9J9dXnDIl37EEBXXyGpRjzK6HJLfwliIlnHf/mKG
	3DY27SO6dlqi8F40VjtUuoX0EtxkuOCrR1tQ==;
Received: from [177.172.122.137] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xP3j3-003hS1-VE; Thu, 05 Nov 2026 21:06:22 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 05 Nov 2026 17:05:40 -0300
Subject: [PATCH v9 05/15] sparc: Use the common syscall table
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
Message-Id: <20261105-tonyk-syscall_table-v9-5-8d1275885d9c@igalia.com>
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

The generated files are not exactly the same as before, but they have no
functional changes:

 - syscall_table_32.h would generated lines like the following
   __SYSCALL_WITH_COMPAT(422, sys_futex, sys_futex), which is equivalent to
   __SYSCALL(422, sys_futex)

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/sparc/kernel/syscalls/Makefile    | 12 ++++--
 arch/sparc/kernel/syscalls/syscall.tbl | 69 ----------------------------------
 2 files changed, 8 insertions(+), 73 deletions(-)

diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
index 8440c16dfb22..35ea0834aef3 100644
--- a/arch/sparc/kernel/syscalls/Makefile
+++ b/arch/sparc/kernel/syscalls/Makefile
@@ -5,19 +5,23 @@ uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 $(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
+syscalltbl_common := $(srctree)/scripts/syscall_common.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+abis := __clone3,common
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis common,$* $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr --abis $(abis),$* \
+		   --common-tbl $(syscalltbl_common) $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis),$* \
+		   --common-tbl $(syscalltbl_common) $< $@
 
-$(uapi)/unistd_%.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd_%.h: $(syscall) $(syscalltbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(kapi)/syscall_table_%.h: $(syscall) $(systbl) FORCE
+$(kapi)/syscall_table_%.h: $(syscall) $(syscalltbl_common) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h unistd_64.h
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 5b9fe0e8140f..5f407da6b9da 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
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

-- 
2.56.0

