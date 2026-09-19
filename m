Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F633E36A;
	Sat, 19 Sep 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777929; cv=none; b=p+HqHjMT42V7OMQ3584Vx4w2wWwcbPaP4c8fAoKKFEJYgWY7i0HenEEJjk6N4v+uiYcI5QmhWqxOboPl7ZEtWpx+Ff0l/BItKkU4Ued89W3M/VPA/qQqRjIJzsRPd+WrpzOZlTv3C7lGfWazAXt2NRrxN7+w8WELaJAEXOW3zTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777929; c=relaxed/simple;
	bh=OtikyZssAKLrIaMcIUXeT/skONTqMKpJaKJsquefQjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJuxviR90fLRNlKiqjR5XWbNPRwGgArqhVX7i0IQMuYBbCv78SwLIyWff9Xdk3jkG0XqxXP8TvbHylPq74ZyvJe57XMcCbOyjFIrl90Nq+A96krmKD00NIES/WqwTr7zmVBCeh33/mDOUgXVEjDzuqQ56Q+keyRMBqac/arQLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q5DRUzLy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q5DRUzLy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=IFghox/W/KFaX7+SXlhM+ZKUnFTZKDq2xXH3UcdYXUQ=; b=Q5DRUzLyqZGOr5u9a5fjONwggA
	jej6yFWaUEqbZ4vTmfAJsPsM8g+QU/33dComtEpm7sXthlty58nXOa0h+vEZ8h2qTFd25qcNDLWN0
	h8wdAHid8z+wky2fk0XuZt/Y0ZaLqUVO9op6Mum2qMRmaZBF92FUlOXQbBSP4b8m0rsaVGWTtrise
	iqLLxnMxahc5REFxRPrGhik6e725lqgvtNUqmr2CoD9AoiR3XLRgtLpHB2XgL+NDg7lxspx+QesJt
	XvdG+/7/PMi68W529Cg7EXzEGg7hYwlRzqI8AJJ1HEb5VFfzEsk7g1SwSk+IGr2Nv75HkHpUdGzuG
	TYHErDjA==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7izh-004Bwz-Pf; Sat, 19 Sep 2026 02:31:53 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 18 Sep 2026 21:31:19 -0300
Subject: [PATCH v8 12/12] alpha: Use the common syscall table
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-tonyk-syscall_table-v8-12-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 Magnus Lindholm <linmag7@gmail.com>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Remove some of the duplicated code by using the common syscall number
table.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 arch/alpha/kernel/syscalls/Makefile    | 14 +++++++---
 arch/alpha/kernel/syscalls/syscall.tbl | 49 ----------------------------------
 arch/alpha/kernel/systbls.S            |  1 +
 3 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/Makefile b/arch/alpha/kernel/syscalls/Makefile
index b265e4bc16c2..03099daff6b9 100644
--- a/arch/alpha/kernel/syscalls/Makefile
+++ b/arch/alpha/kernel/syscalls/Makefile
@@ -7,17 +7,23 @@ $(shell mkdir -p $(uapi) $(kapi))
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+systbl_common := $(srctree)/scripts/syscall_common.tbl
+abis := common,__clone3
 
 quiet_cmd_syshdr = SYSHDR  $@
-      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr $< $@
+      cmd_syshdr = $(CONFIG_SHELL) $(syshdr) --emit-nr \
+		   --common-tbl $(systbl_common) --common-offset 110 \
+		   --abis $(abis) $< $@
 
 quiet_cmd_systbl = SYSTBL  $@
-      cmd_systbl = $(CONFIG_SHELL) $(systbl) $< $@
+      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
+		   --common-tbl $(systbl_common) --common-offset 110 \
+		   --abis $(abis) $< $@
 
-$(uapi)/unistd_32.h: $(syscall) $(syshdr) FORCE
+$(uapi)/unistd_32.h: $(syscall) $(systbl_common) $(syshdr) FORCE
 	$(call if_changed,syshdr)
 
-$(kapi)/syscall_table.h: $(syscall) $(systbl) FORCE
+$(kapi)/syscall_table.h: $(syscall) $(systbl_common) $(systbl) FORCE
 	$(call if_changed,systbl)
 
 uapisyshdr-y		+= unistd_32.h
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 59eb066a40bf..7066a3920899 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -463,52 +463,3 @@
 532	common	getppid				sys_getppid
 # all other architectures have common numbers for new syscall, alpha
 # is the exception.
-534	common	pidfd_send_signal		sys_pidfd_send_signal
-535	common	io_uring_setup			sys_io_uring_setup
-536	common	io_uring_enter			sys_io_uring_enter
-537	common	io_uring_register		sys_io_uring_register
-538	common	open_tree			sys_open_tree
-539	common	move_mount			sys_move_mount
-540	common	fsopen				sys_fsopen
-541	common	fsconfig			sys_fsconfig
-542	common	fsmount				sys_fsmount
-543	common	fspick				sys_fspick
-544	common	pidfd_open			sys_pidfd_open
-545	common	clone3				__sys__clone3
-546	common	close_range			sys_close_range
-547	common	openat2				sys_openat2
-548	common	pidfd_getfd			sys_pidfd_getfd
-549	common	faccessat2			sys_faccessat2
-550	common	process_madvise			sys_process_madvise
-551	common	epoll_pwait2			sys_epoll_pwait2
-552	common	mount_setattr			sys_mount_setattr
-553	common	quotactl_fd			sys_quotactl_fd
-554	common	landlock_create_ruleset		sys_landlock_create_ruleset
-555	common	landlock_add_rule		sys_landlock_add_rule
-556	common	landlock_restrict_self		sys_landlock_restrict_self
-# 557 reserved for memfd_secret
-558	common	process_mrelease		sys_process_mrelease
-559	common  futex_waitv                     sys_futex_waitv
-560	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
-561	common	cachestat			sys_cachestat
-562	common	fchmodat2			sys_fchmodat2
-563	common	map_shadow_stack		sys_map_shadow_stack
-564	common	futex_wake			sys_futex_wake
-565	common	futex_wait			sys_futex_wait
-566	common	futex_requeue			sys_futex_requeue
-567	common	statmount			sys_statmount
-568	common	listmount			sys_listmount
-569	common	lsm_get_self_attr		sys_lsm_get_self_attr
-570	common	lsm_set_self_attr		sys_lsm_set_self_attr
-571	common	lsm_list_modules		sys_lsm_list_modules
-572	common  mseal				sys_mseal
-573	common	setxattrat			sys_setxattrat
-574	common	getxattrat			sys_getxattrat
-575	common	listxattrat			sys_listxattrat
-576	common	removexattrat			sys_removexattrat
-577	common	open_tree_attr			sys_open_tree_attr
-578	common	file_getattr			sys_file_getattr
-579	common	file_setattr			sys_file_setattr
-580	common	listns				sys_listns
-581	common	rseq_slice_yield		sys_rseq_slice_yield
-582	common	fchroot				sys_fchroot
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 68f3e4f329eb..9a67d29f7818 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -7,6 +7,7 @@
 
 #include <asm/unistd.h>
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
 #define __SYSCALL(nr, entry) .quad entry
 	.data
 	.align 3

-- 
2.55.0

