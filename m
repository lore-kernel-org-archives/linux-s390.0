Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6183921F0;
	Fri, 28 Aug 2026 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959201; cv=none; b=CyzeChWb5FVumvkrQP3j+dKQFYor5CuXG+OwRYUJqD7Zhku/UhFq4xSo5Iah71GL8MQdSYkFSbioGTwzFewhLvyJ/nQFrelhdPvM0jEvX1PW/9oeATbaNfDWK+Tav/A51xswbMLnDTxcjP/01jMcuagRknubQEJ8O3jsri6Kg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959201; c=relaxed/simple;
	bh=SbWcTZwAoabiQSBe+7UQrTIr9vRaQNfH/6rqVmrp36c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqEgT4mmVia9r1Eu0mz/jHfkhSGwyIyGQVSnWImkJntPEZ4TPyFogl7lwWfNW7u8qib2++twWtLoaPh5tTKVCa++TKf95xEwff9iPcB8Q5Llse0E0XRU/IHUyhWOce2QhauQJw0X/8vTapvawS4KDieR/LfBCEyu6Scxy75PCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CdUhxh4r; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CdUhxh4r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=CVVKIEvfe5c1rXno9Wkp2wIqaNURiaV7tGZceWzjJk4=; b=CdUhxh4rpv2TacPhHszB1Ch3lV
	8IuyDevQsXCoTnTsq6D1uT1nqj+j7OO+h805GVQ0+nLTJkzOmPavHF1aHgTq5f0wpBvoikp1YrnD+
	6pIPgISvq0cFIrS0AiYskz8ljlE5dzBnvPFxWH/d26Nc7qIOWmzt1mjrG2PWfvJ5mTM/YxJgeghph
	h2HllXCpeuHJqQVAKp3JNPDTdH954J4ycfmYGeELLEDf9ccp+1REDNaZtkkbfJ56+vKj4IytOX+cP
	7uwCaTaoWDBD+W5WRUMejTWC1SX2ZOjsENCBURiDpS8WQN9PfOfdFWD114GLN7RfPKff+UojmicvC
	0PX+OCXA==;
Received: from [187.57.78.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x05rW-00B3sF-GV; Sat, 29 Aug 2026 01:19:54 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 28 Aug 2026 20:19:31 -0300
Subject: [PATCH v6 04/13] arm: Use the common syscall table
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-tonyk-syscall_table-v6-4-fdd358456cf1@igalia.com>
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
 arch/arm/tools/Makefile    | 14 ++++++----
 arch/arm/tools/syscall.tbl | 69 ----------------------------------------------
 2 files changed, 9 insertions(+), 74 deletions(-)

diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 28b6da8ac5f6..9ea6c853e241 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -12,6 +12,8 @@ syshdr := $(srctree)/scripts/syscallhdr.sh
 sysnr := $(src)/syscallnr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
 syscall := $(src)/syscall.tbl
+syscalltbl_common := $(srctree)/scripts/syscall_common.tbl
+abis := common,clone3,32
 
 gen-y := $(gen)/calls-oabi.S
 gen-y += $(gen)/calls-eabi.S
@@ -38,20 +40,22 @@ $(kapi)/mach-types.h: $(src)/gen-mach-types $(src)/mach-types FORCE
 	$(call if_changed,gen_mach)
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis common,$* \
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --abis $(abis),$* \
+		   --common-tbl $(syscalltbl_common) \
 		   --offset __NR_SYSCALL_BASE $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis common,$* $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) --abis $(abis),$* \
+		   --common-tbl $(syscalltbl_common) $< $@
 
 quiet_cmd_sysnr  = SYSNR   $@
       cmd_sysnr  = $(CONFIG_SHELL) $(sysnr) $< $@
 
-$(uapi)/unistd-%.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd-%.h: $(syscall) $(syscalltbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(kapi)/unistd-nr.h: $(syscall) $(sysnr) FORCE
+$(kapi)/unistd-nr.h: $(syscalltbl_common) $(sysnr) FORCE
 	$(call if_changed,sysnr)
 
-$(gen)/calls-%.S: $(syscall) $(systbl) FORCE
+$(gen)/calls-%.S: $(syscall) $(syscalltbl_common) $(systbl) FORCE
 	$(call if_changed,systbl)
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 55717ed32c27..d5bc0e7adf2f 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -418,72 +418,3 @@
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

-- 
2.55.0

