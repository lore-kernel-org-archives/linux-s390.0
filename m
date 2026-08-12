Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7D480320;
	Wed, 12 Aug 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556377; cv=none; b=OyTMKQXbXNHQdm4RLtdpgJMGwgRr2Dm7JxNrgsNtNpHJTM0iHWeOhiEkAVRRgGegrvwnUwTK75raGuFl8TBGopJCYpRgUe/gQwGY2QTn1q28+LYIG1Xj54vayq7qqf+Lbf5gcB43+Kl58rS+0vC6lyoSNcINiOd69EOHJFRHOng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556377; c=relaxed/simple;
	bh=kFS9qd5YQKYskfWj+gzC4lKsluwuPOO3JBfg7RzRkCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPwBhQ5nhoNa9Yr1bs2U2aQ98s1F2kRcoTYu2Dl0tYar8ukCJP8e7f73FWpsolSbx7hHfkY0E8cJA7YIqKHhZi0sCRJskOohEvRhKa8h/CJwt9GnT/88ryMb62hpv/I/PsQ8BIdii6gJC9iGshbVjcQRlaotiK8n6phNUuleUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qVgfVFgD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qVgfVFgD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=V9Tg/jFP4psn44+B9clfuRyFwKR7q5MJ+UODTyV6o4Q=; b=qVgfVFgDdLoKKm1iH7Zfbi4YiL
	PalTfsPoguuADVZWIX3lHsu6CtAuoRO392R3bMdqEqA/KOhJ2+McayUY9UuWLlZttoh0pXr7XYoCp
	a8awHyZe4jWNy0qZFM2IN9DuuLMBv6zlNi6z9KClOWU5LYwpQ2xyYCQLhYSYEL7h6UoyXXTkiyz69
	f+KjqB6kVSz9032iwKURqzgwowHPBnimIRbNWhe9j8X1dczKIvqf56+LaFT1XcK1gnFLq7ifRu++R
	Wrxf9lxfd/5RuvwmCmhQkiVePhIhtBcZaT8NBfG3cMAoaO+Irn98q/kWG3jpfEzw0f9/tu7M7w6s1
	AdJ1qpgw==;
Received: from [177.139.22.20] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wuCvL-000FR2-Qf; Wed, 12 Aug 2026 19:39:32 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 12 Aug 2026 14:38:43 -0300
Subject: [PATCH v5 12/13] alpha: Remove alpha_ prefix from custom syscall
 entries
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-tonyk-syscall_table-v5-12-3d383927c609@igalia.com>
References: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
In-Reply-To: <20260812-tonyk-syscall_table-v5-0-3d383927c609@igalia.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 kernel-dev@igalia.com, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 linux-mips@vger.kernel.org, parclinux@vger.kernel.org, 
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
 arch/alpha/kernel/entry.S              | 8 ++++----
 arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index fcfd06529b12..5ca044efa208 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -863,9 +863,9 @@ ret_from_kernel_thread:
 
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
@@ -880,7 +880,7 @@ alpha_\name:
 	ldq	$26, 56($sp)
 	lda	$sp, SWITCH_STACK_SIZE($sp)
 	ret
-.end	alpha_\name
+.end	__sys_\name
 .endm
 
 fork_like fork
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 25180953c3c1..34151d1653d6 100644
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
+545	common	clone3				__clone3
 546	common	close_range			sys_close_range
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd

-- 
2.55.0

