Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B6729B77E;
	Sat, 19 Sep 2026 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777925; cv=none; b=dlvP/YKIReM7W7JuDEA8gODxsPtYa6o4UgMgUWhhDrfpfi78BSC7hjlr5oj38LRTAUsmRWbh4jABTJzQwZxyHy+mPLONqruR9X7Wp7vNpZPXEg3oI50lNn+134lzOwGeZyZg8AEc1/9sf7xsIT1vD2p3s4sCHA6DXAOyXCU1aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777925; c=relaxed/simple;
	bh=kaVtmi/xEMa92Fi5Tnla2UCOIzagQQV/4HCdBCWbvB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiwYiAIXBmLaZUxnNuGjQO8/duV1qP5K4Q5LbulKQywM8os/hCtgI0G0FqoMiF3t9Clbd012V706+GprdYK9thUhLY1NMNWhPWhdBu9tSLz6cH2YjT90fkvGGfcSnnQZKw9EFmUpSRboqRoUt9z1t1DFPFUoUCe4iUgM0RKMs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e2b4BIo0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e2b4BIo0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=UodmOkzlrkccAaaUx4timuyw1DwzgIpMaV1MscKjP44=; b=e2b4BIo00Wv4cQhDgiMTybxoE7
	gZj7P5R90YI5s29tCBij3JE7VB2yojjx4EDCkpbYhK3a6eYPs9lpsF4ZWU3mUQG00UY5C6JfnzQXj
	aIOSAjF6MYAA+81YNYrERwfFZhoOW2w9BGLKf3m7wbK5tUj/tSzrg8PwjVtYF5f5ObbbdrYbxXx92
	oDpSm7KaCtqNlU2eHe6uwXgaukM+GahPaieEi1XiXa3ii8cZ4BfupCbA6r2pKI+a0qNPtxn6M9cXN
	cn1I9h3om6+cav9tI95m/zmN3VihujFuli6jAeccSAk9LFG/GiJSYcf0rwdUzklyU76l/ywKnnuYt
	u/ttVpuw==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x7ize-004Bwz-6D; Sat, 19 Sep 2026 02:31:50 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 18 Sep 2026 21:31:18 -0300
Subject: [PATCH v8 11/12] alpha: Remove alpha_ prefix from custom syscall
 entries
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260918-tonyk-syscall_table-v8-11-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
In-Reply-To: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Some architectures need special entry points for some syscalls (like
clone3). The current approach is, instead of having a special name like
arch_syscall, to name if as __syscall. This is enough to different the
common entry point to the architecture specific entry point.

Change alpha special syscall entries to do the same. This makes easier to
join the syscall tables. Leave alpha_syscall_zero because this syscall only
exists in alpha anyway.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v7:
- Fix __clone3 entry
---
 arch/alpha/kernel/entry.S              | 8 ++++----
 arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index 9f2608de2544..8a85fcf117cb 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -879,9 +879,9 @@ ret_from_kernel_thread:
 
 .macro	fork_like name
 	.align	4
-	.globl	alpha_\name
-	.ent	alpha_\name
-alpha_\name:
+	.globl	__sys_\name
+	.ent	__sys_\name
+__sys_\name:
 	.prologue 0
 	bsr	$1, do_switch_stack
 	// NB: if anyone adds preemption, this block will need to be protected
@@ -896,7 +896,7 @@ alpha_\name:
 	ldq	$26, 56($sp)
 	lda	$sp, SWITCH_STACK_SIZE($sp)
 	ret
-.end	alpha_\name
+.end	__sys_\name
 .endm
 
 fork_like fork
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8fc4701a6328..59eb066a40bf 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -9,7 +9,7 @@
 #
 0	common	osf_syscall			alpha_syscall_zero
 1	common	exit				sys_exit
-2	common	fork				alpha_fork
+2	common	fork				__sys_fork
 3	common	read				sys_read
 4	common	write				sys_write
 5	common	osf_old_open			sys_ni_syscall
@@ -72,7 +72,7 @@
 63	common	getpgrp				sys_getpgrp
 64	common	getpagesize			sys_getpagesize
 65	common	osf_mremap			sys_ni_syscall
-66	common	vfork				alpha_vfork
+66	common	vfork				__sys_vfork
 67	common	stat				sys_newstat
 68	common	lstat				sys_newlstat
 69	common	osf_sbrk			sys_ni_syscall
@@ -242,7 +242,7 @@
 309	common	get_kernel_syms			sys_ni_syscall
 310	common	syslog				sys_syslog
 311	common	reboot				sys_reboot
-312	common	clone				alpha_clone
+312	common	clone				__sys_clone
 313	common	uselib				sys_uselib
 314	common	mlock				sys_mlock
 315	common	munlock				sys_munlock
@@ -474,7 +474,7 @@
 542	common	fsmount				sys_fsmount
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
-545	common	clone3				alpha_clone3
+545	common	clone3				__sys__clone3
 546	common	close_range			sys_close_range
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd

-- 
2.55.0

