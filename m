Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119762;
	b=sczNBVhsidm81j4u8rLKbbUCzVxuReJRksCc9aqWRM6hlgkToT0S9zsyp4tzLmaZeLJR
	 RedTROs2zp27fNxuIdtP0Snz7M3/TdDN+29CExGRBUvz38qf/oWGOHF6HYAQGwoKaJJwK
	 9vnGwvRadRCO1x3edKSsnqTf+zOAxIJmja50HrMVk09s1iQYoeIi6WI78dxaip/Cz+/gy
	 Pj28glvcnBm7d7tuckpnaCyRByXejaUelrTwYb6HCL/1cBsc13nivA2ZzSi66fvNWFhDr
	 YC9yKgaIaRby+Z2O0Gz2x095LSawGUxL8/K2t8Fz41yriA54FLOKRM/95p1pp6zbpJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119762;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=+Jq2A0NnQEwVE/jTfpO1M0vsCQtPBhWy3vC8T9/2poE=;
	b=j0eV8WWC9a1CNPncv2HsQXlIcinxTXFsaOcWXLNNhGHKe2bxyiAI7Zp0xulLaBJ13hha
	 ggaH1M6fbh8+++RNwGuaEEB0lmTECZtclVu0f5p2lr+Um1y+l2zVeHk9J+R/VdFRdAQmA
	 Gft1lCB+XTrLwSndoFKkVbCRaDoZ+T2uUg4g0pjiIjXU2meWbT32jiZMFhN/2vJYunBbM
	 FxX5pcHOM2BwanKqEnb/8sjV9ezDqg8dMTp04EMd4io4EN/SydIxt0Z6O5tvjeSK4nLff
	 JDzxrd7CsDcyujrem5Wf6uMvxFwIdjuiqBu4uxm+H54DFrLD+mU0R5sUgV65iXGZ8bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Z+WrCq1j;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE86071A5C;
	Thu, 19 Nov 2026 20:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EE86071A5C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Z+WrCq1j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=+Jq2A0NnQEwVE/jTfpO1M0vsCQtPBhWy3vC8T9/2poE=; t=1795119761; x=2110479761; 
	b=Z+WrCq1ja45VrP7zZiMu+y8cgAiDRpAWpok7mM8AP1sKrnye0KI9AWBssv6SHTgzfT9KWjOus7+
	UvHdK3iZrYx3G1Z5aHnmQ9m5LCw8gKPPFTh+hsJO5DQ0W/FRThflXxTOyTJMrRy1jr3uoC82HauAQ
	3i2o4CbHtO49uGIMxXWKKhltO8LLqjGHUeUHnoTdQfZs8zhMHdDlf30Bo65jIMpRW9gikMZvyNGqx
	1ycwmzzGDyHNFGHnutoe5NMx4jcGUqKFtGS8Ja5kNP64BdiVmd9Bvgigj8BZPxo2xqtg+79+r1rXN
	8tMwY59Vql7QAfv7CFJbBtvh94jjkLPtOCSg==;
Received: from [177.172.124.218] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xU8eV-00000001cIK-44oN;
	Thu, 19 Nov 2026 21:22:40 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 19 Nov 2026 17:22:01 -0300
Subject: [PATCH v10 11/16] alpha: Use the common syscall table
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
Message-Id: <20261119-tonyk-syscall_table-v10-11-a7c9ebd900f6@igalia.com>
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
index b265e4bc16c2..d12454986a0b 100644
--- a/arch/alpha/kernel/syscalls/Makefile
+++ b/arch/alpha/kernel/syscalls/Makefile
@@ -7,17 +7,23 @@ $(shell mkdir -p $(uapi) $(kapi))
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
 systbl := $(srctree)/scripts/syscalltbl.sh
+systbl_common := $(srctree)/scripts/syscall_common.tbl
+abis := common,clone3
 
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
index d57c423026c3..c032fe7c87f0 100644
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
-545	common	clone3				sys_clone3
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
2.56.1

