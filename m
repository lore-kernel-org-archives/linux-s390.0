Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C606144D03E;
	Tue,  7 Jul 2026 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451204; cv=none; b=qfgfk2fpSKKSRYB83bGjqbEUtxvMd166s9aF0xRDs/4Q+dmNQ7NdwjTdx3L4IeMq/WuY6ixcSMNuwtVRYq4phxh0Vjm27fFTZVkf3GwghG+yMiZMnwnAEEyx3KGXtMa8FJAJckD4fbAluiAQ+6Mw9I74Q3Po4oC1Um2a1o6iGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451204; c=relaxed/simple;
	bh=CbRs/wo8Df+GsVt72rPyMFgSfNKcvE6Ap7XL1kO3dI4=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G01qH6/MSG+ARm+YHu9qdwgJp9lEZFAsbmsrOWYMCQ1zVx4yOJyycYFzMTbTUxulswJfWBE4sCNFu+10XMxr1MYW7+8q+vCh3u3mhgQH3Csc49nrcjwvQuZGp5RI5N5LjXxUuIC/LSXu/5BkQygTu4h08Vi4f44gCDPYbVqIwmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h91mvxoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h91mvxoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87121F00A3A;
	Tue,  7 Jul 2026 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451198;
	bh=bOhoOM4hOcQqUzsvXhQz1H8YtW+B68Wkj0kvWsv9ysw=;
	h=Date:From:To:Cc:Subject:References;
	b=h91mvxoSmiGeQM8FkyaGYFZNxd9/IUcToDeSMIPvZRCL7a8UMwB0b0QBesp5xIbLU
	 i7PsT94Sw2onA3+UmpAOBRZfRcPLnTsutjo1QPB6poAvdbvPFcNvVkGP1hB6jDLYDb
	 RKWnZ0yte8HArLwcv9oJe3tjBUUeDOAyh5mMWkxYWu67e92T5hj3A/OUFslD9ZYdOb
	 CoRjmiJVDNi/JotogxyAKQWnRnlRYa4L0e21jTcDihICBULLgdAZvlp5GRhmagJ2DT
	 +Aa9ucQxYNr6w3TZVbEH8jmFMex+6xgUViSmWosj6uNAuMiuHhylsKUcB2NMwZIOYT
	 B1ISbmvWG+Pgw==
Date: Tue, 07 Jul 2026 21:06:36 +0200
Message-ID: <20260707190254.181086755@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Kees Cook <kees@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Guo Ren <guoren@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>,
 Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org,
 linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
 Vineet Gupta <vgupta@kernel.org>,
 Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 Dinh Nguyen <dinguyen@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: [patch 10/18] entry: Use syscall number instead of rereading it
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

rseq_syscall_enter_work() is invoked before the syscall number can be
modified. So there is no point in rereading it from pt_regs.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
 	}
 }
 
-static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
+static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
+						long syscall)
 {
-	long syscall, ret = 0;
+	long ret = 0;
 
 	/*
 	 * Handle Syscall User Dispatch.  This must comes first, since
@@ -90,7 +91,7 @@ static __always_inline long syscall_trac
 	 * through hrtimer_interrupt().
 	 */
 	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
-		rseq_syscall_enter_work(syscall_get_nr(current, regs));
+		rseq_syscall_enter_work(syscall);
 
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
@@ -145,7 +146,7 @@ static __always_inline long syscall_ente
 	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
 
 	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, work);
+		syscall = syscall_trace_enter(regs, work, syscall);
 
 	return syscall;
 }

