Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134473A48C5;
	Tue,  7 Jul 2026 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451165; cv=none; b=O5Jd9EeP2MEaNFYzFC2XO0b9ra7xqbxZTK7byHhiJnm44LuVKMgXr2a45jy6934BSRZP75EWDnC1W9y6uYFFaokySQPg67/yi7YoH1At8IiKYjVt/Xo28b0I2Fs1QVwBwrmEXBRb5oI3BVZ539OjCGfvMdZA2Jn5bkEuCPc0xlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451165; c=relaxed/simple;
	bh=+ktDdqlAbRngCLl2vZq2nnX4xHAlOriB8nGAOrxQ1Qo=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DxHI06yhmCiMHSZ8Gt2jr8syQIUvadv2HmVqSFwlsJauyLIB+87IB4nChXQC5F4pHLr/nDp4b0E4jVG2GN5x+0oDHVGnZcwsHAFtPIALWufPTDhZwFMDu7hdYVzllVTV4JqQTYcVbLd/hEiXV7djFAJK0zFjpgmJDcGljCRZ+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjLMGEZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjLMGEZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8731F000E9;
	Tue,  7 Jul 2026 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451161;
	bh=hxSnO03KgHWOZGMce0tACqpsA4dr5cG/I6UVdKHVTVw=;
	h=Date:From:To:Cc:Subject:References;
	b=XjLMGEZIqo7ptFMh+dt6XLydZgtGilujB6Pr3G5Xs8jTgXHjTmjHbXax45A1Irn7Q
	 ZoKgOQ+erxKpVuTEY1CN+p5oa4NISG5yLBcptFbbuZ5Smi9OI4/1GT5wKmBvG/kUCm
	 Kb++/j50MCS4Bd4ZIaLeUp05IkQ8BBoXhS1+C2Dfdb2Px/6YBrEpRHirZkoMvFkjrB
	 Esy2/NvwC38v686eB+S6XqRLlxxoxacZU7i1j9g0fzbALa1yDrWEDepcbm0R60qZn9
	 YK/VjvOicJpHE846L2yVE16swnlEjzi7zlbAJYmhCaJqshy4C6LdDpsWMl5NR0b1d9
	 qdpIAZc9XtCbQ==
Date: Tue, 07 Jul 2026 21:05:58 +0200
Message-ID: <20260707190253.718191130@kernel.org>
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
Subject: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
establishes state. That's wrong because add_random_kstack_offset() calls
into instrumentable code.

Move it after syscall_enter_from_user_mode() to ensure that state is
correctly established.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/syscall.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -19,8 +19,8 @@ notrace long system_call_exception(struc
 	long ret;
 	syscall_fn f;
 
-	add_random_kstack_offset();
 	r0 = syscall_enter_from_user_mode(regs, r0);
+	add_random_kstack_offset();
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {

