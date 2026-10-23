Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789403;
	b=mF9TcpEkHvrHB7jGSyOCk4NP91JZ4Q1gRkdtaczk8b9PjnKHTJgkjmwC6vLVNP9jHW/8
	 XmqoEni4SIqYZmNPQTSBIWaj6dZmuWpgC/3Zrc43i2Z5Fnhqxc1ayrR5Wi/nJpb11Ygxm
	 TYr2BiFcWOJQ5ozga3g55nUFS6rhPFbuhCt2hHgXL+3x5bIVaehPIeuiiJQku+yM8Hd+K
	 IrqPiT/Ra+CUVMR9gTJmBa4midyaWFjuabaov5p2WmBP1W6nqdsjT11ieI/aTz5GU/CzM
	 nhBdhUDnAEGqe6ufy87dVUh6u8wheFYJn3gw3jqZY5B/518Csz0krY+huIKJEA2/jtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789403;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=z4qvQCN58U+JYqI9bDmfn/D5nhfh4S82nzs2P03LmsM=;
	b=2uMfi+UvGPwoaHqv8xhNSBzIIlBfsLU4dwwgY4lbq4Fi6qzE2SvfmKRML7OqwFM23Q9b
	 fFcc9Q3MaapADU6HhXq2e49uuScl6H126A/ms89SO53ZdgRKTSItJScUV7xZOsb8HiEHl
	 TeNgnkI+/GoPdeyRl+EGiHGQr2axqxZcwP8Q9cAiUt5asAifQYNu8z0M6E/XRtycR2Pbk
	 iaIaU6K8vJOIpOhpr88mAIYSC81n2vqCZ115KL+EwFeTmtZbwlb8hTE7TxLh1PUvfV6kr
	 Ptp3Wc8fUDPo7Vs9UvWSmpZxlgCWY+B2g9CgeDWTQlIU6hU0tjbzLvPai7BxHCor7LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq2tmGaB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1729606A31A;
	Fri, 23 Oct 2026 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uq2tmGaB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F501F01828;
	Fri, 23 Oct 2026 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789402;
	bh=z4qvQCN58U+JYqI9bDmfn/D5nhfh4S82nzs2P03LmsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Uq2tmGaBxQvk3ht7HGTfPReMFqJyJBCqOBq0vIxhArHZHHeoamuJ6hketeNzAHwZ8
	 StcQA3xVSJUZdHusYqq87suQp54bO9TdiZ0Pr4Ze4Wu2fGh5HjQOT/CoRjmyJUuOT5
	 DQIFlkgiCw5uboeFrJN90fUZm+ihmGYUDBYalCT5RPVFLoqxwSKvqaI9hdOaScug8P
	 bsCdObO84vUQd+eimnQGnJ/jGAyvXaf1qnLPgmpV54ONY8AyHfNjtN36ieHAOum0Wt
	 WlnPPiOkJPBZadv8Dcg6YFnsEANfVbG9w4HaV+a+oZJwLVONF8+aKkQsdWKxbxEmfR
	 J7+cwITy6EDVA==
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
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
In-Reply-To: <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
Date: Fri, 23 Oct 2026 23:03:19 +0200
Message-ID: <87se1wyvs8.ffs@fw13>
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

On Fri, Oct 23 2026 at 08:38, H. Peter Anvin wrote:
> On October 23, 2026 7:24:22 AM PDT, Thomas Gleixner <tglx@kernel.org> wrote:
>>The real question is how we ended up there. By design or as an
>>implementation detail which got later set in stone and the selftest was
>>written to test the implementation instead of testing against a
>>specification.
>>
>>I went back in history and in 2.6.12 the behavior was for both i386 and
>>x86_64:
>>
>>  regs->ax = -ENOSYS;
>>  syscall_trace_enter();
>>  if (syscall_nr < MAX)
>>  	do_syscall();
>>  ....
>>
>>IOW, a tracer modification of regs->ax is not overwritten when the
>>syscall number is out of range.
>>
>>Between 2.6.19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
>>regs->ax when the syscall number is out of range.
>>
>>In the 3.8 merge window seccomp introduced the -1 == skip bogosity which
>>got fixed up and made "consistent" in several changes afterwards. Just
>>that it never reached a state of consistency due to the overloading.
>>
>>So are we stuck with this behavior or do we sit down and define what the
>>correct behavior should be?
>>
>
> Going back on something from 3.8 that is actively used seems unwise. I
> fear that that ship sailed a long time ago, even though I hate it just
> as much as you do.

Well, overwriting the tracer written value for invalid syscall numbers
is something we can't undo. Though the interesting question is whether
the -1 overloading needs to be preserved. The new code uses returns
false when the syscall has to be aborted and that leaves the return code
untouched. When syscall_enter_trace() returns true, the syscall is
invoked, so it would be consistent to overwrite the return code with
-ENOSYS even for -1. But yeah, some esoteric nonsense might rely on that
behaviour for the wrong reasons.

Fix below.

Thanks,

        tglx
---
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -77,6 +77,8 @@ static __always_inline void do_syscall_3
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
+	} else {
+		regs->ax = -ENOSYS;
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


