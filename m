Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555892;
	b=FXIcFh7dOmBvLkccW6Pmtfk9UNfYtnbK2nFMIYfF7USaK2GOjNjmgWTIdZjYXK+JpG44
	 tqyZ0MOuwDi/WYZxJq2vyrGUGsUtRFafjL2GebWj4/sufLRJsJBbyPOS6g+vpKQG2jOz/
	 d08Nm6+1MdAl4XDfljYFpgteSVYmPyBNOrbjeYKAN+utLcDzRv7EtRP6sfdU3WPwggRhZ
	 gt3pmB2dbX842tC4cXpO8qbDFq+1x+3GWd36mGLP3BDbxJG2s/y43YRQSG4BX8G3FL/JH
	 VKpfCGNTp1Hz0GdDcZARYpLUn5L45Fh2eEljXH2E7aR2A95SjzD1/7WJ45Hy9hXQgLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=+7HwRXGWtYS3xmU+Z46/w0lVl31Dl0sZcMyXjmUDfIs=;
	b=e5Xj0w/BMboK2HQTrlV3GC9nl6B4wY2eIhjnYKaxYXq6FcqHV6g/4o/4sNm7Yk8pIt1P
	 GubvDHoF3P9IfIZ64kH/SrqXU+FvyHXCkHkydGw4xIZVnM3zDZaDNVHLokOm3NLlUV5tz
	 aj4+LvcdpZFGZawmh6JY5Sc8UMl8DTlgnC93b6QJ43JQmcZCXaa6LIvDPp3rJjDHQ9p1g
	 0TPGTX3jwWN/n+YsCLlKSua75jB7b+KM3N/9V45vjViVZa2NwK1GRGCfVyEyuhkhDNWdl
	 O1P/fPfVoq1Z7ZkCr6dgNpsYtUuNmhKMMMu5ivftXcMwLcIVwKssjyXi+rzxGn1H6MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkpyzqH8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C7606A338;
	Sun,  1 Nov 2026 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkpyzqH8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A21F00A17;
	Sun,  1 Nov 2026 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793555891;
	bh=+7HwRXGWtYS3xmU+Z46/w0lVl31Dl0sZcMyXjmUDfIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FkpyzqH892Y24Bf4MzJaxg0GENU+W3h1HrKoje37+gLiStKVwoHULfobDtcxPd97k
	 O7yDPvc5mWSjJBu8vqqdIiJljIIY/6Z6d8PFXXCg74LTEn4DannL5V6rcy3NiVl7Cu
	 DnutKq7d2bLfY2EkKJcg1fiS7Qvebb0UQQu9SHDSugPX5Tba1NEXcVGdUEzB6sw+y5
	 V2z/p2t+EDUDEUhm+YjJeNELsgmzPgXTja1HpGoACFV2HxgapWeRjmaKUW4P/rTSol
	 vGE0a3SiPbMJFefI/JNfVFZ/R4iCFJ+Rd4uFfOaqAIzWd7mtslcqNYqP4841tBmpOx
	 x3REifKbTPuGQ==
From: Thomas Gleixner <tglx@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo
 Ren <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH V2] x86/entry: Fix ptrace regression
In-Reply-To: <87mrrvxaty.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com> <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13>
Date: Sun, 01 Nov 2026 18:58:08 +0100
Message-ID: <87ecd4xwlr.ffs@fw13>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

The recent rework of the syscall entry code missed the historical detail of
the abuse of syscall number -1L to abort a syscall and keep modifications
by tracers to the return value, while a rewrite of the syscall number to an
invalid value undoes eventual tracer modification to the return value and
overwrite it with -ENOSYS.

Restore the original behaviour.

Fixes: 1b1f3b3e1b39 ("x86/entry: Get rid of the sys_ni_syscall() indirection")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20261022142425.3Wx-RrU5@linutronix.de
---
V2: Add the missing -1 check in the 32bit path - sashiko
---
 arch/x86/entry/syscall_32.c |    4 ++++
 arch/x86/entry/syscall_64.c |   26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -77,6 +77,10 @@ static __always_inline void do_syscall_3
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
+	} else {
+		/* See comment in do_syscall_64() */
+		if (nr != -1UL) {
+			regs->ax = -ENOSYS;
 	}
 }
 
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -64,15 +64,20 @@ static __always_inline bool do_syscall_x
 	return false;
 }
 
-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned long nr)
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned long nr)
 {
+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
+		return false;
+
 	/* Adjust the starting offset of the table */
 	nr -= __X32_SYSCALL_BIT;
 
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
+	if (likely(nr < X32_NR_syscalls)) {
 		nr = array_index_nospec(nr, X32_NR_syscalls);
 		regs->ax = x32_sys_call(regs, (unsigned int)nr);
+		return true;
 	}
+	return false;
 }
 
 /* Returns true to return using SYSRET, or false to use IRET */
@@ -81,8 +86,21 @@ static __always_inline void do_syscall_x
 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
 		instrumentation_begin();
 
-		if (!do_syscall_x64(regs, nr))
-			do_syscall_x32(regs, nr);
+		if (unlikely(!do_syscall_x64(regs, nr))) {
+			/*
+			 * The special treatment of syscall number -1 is a
+			 * historical bogosity as the original code used -1 to
+			 * indicate syscall abort, which is not distinguishable
+			 * from a syscall which is invoked with syscall number
+			 * -1. The historic behavior is to keep the return value
+			 * in regs->ax unmodified in that case, which means it's
+			 * either the preset value -ENOSYS or a value which was
+			 * written by a tracer. If the syscall number is invalid
+			 * but not -1 then overwrite any tracer modification.
+			 */
+			if (!do_syscall_x32(regs, nr) && nr != -1L)
+				regs->ax = -ENOSYS;
+		}
 
 		instrumentation_end();
 	}
