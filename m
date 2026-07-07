Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5647AF4D;
	Tue,  7 Jul 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451230; cv=none; b=YYTGuwYJGeUe97dcBvrw20ftC8uSYFbS1U+SklwZRdlHsNKPR3ybvb57SZ7I3Q2Dzg9zUvNe8+wS75JR5z9xcUaGPHbEg9bJFK5R4veTV3n0K8j4G3CFt92m4tpLdS0er5X8I7PttRxvzaFEgrynX7XH+ZQxYrOFZCaqP5IafBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451230; c=relaxed/simple;
	bh=HKBpddupeL2kVgWhcCDTKlNcSQTxJhknXdYEV5nr82I=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Mpr9Kmh9g7zoqkKmwWcatLEvgu7gLcJ5KaSqD4G8rCSG9RCJ3Bcw3jKty+vUQLwJon/wdoPLT3Y/ftwMNE8aHx1ZcEc+eI562UxsTQEt5egyBLs/13dWfDYsKDEL3x4nYTKWtIYXu8EzVD6NhCmaof6egAJjZbikr02g75t+2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ix0A1te8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ix0A1te8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4431F00A3D;
	Tue,  7 Jul 2026 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451224;
	bh=f3tTBJMZMBmlp5JnKGm6uVp1qFXO+k6bdzgk0bOTjgQ=;
	h=Date:From:To:Cc:Subject:References;
	b=ix0A1te8r5Eh2ztDr6+QRKYrDxuK9fCJBLeYnU+S/kJiG8kcMUDG0t7haY3angHi3
	 yEIWiFZVjLpiLcvP+/kNmvwnKBvF77QrS5+dxnyxoTIqPaFj7pKDS2a7mgV2+hH/Jl
	 1gMgd7gaUkRbKMGi+WBaEVcFz8RZe19KgNDBaCY/H1tfyVuoBQsH9m7Php1EFCLPPi
	 XVOOmkLS5GR2sX5v8V1m3yamuDFh1+M1HWpsnafwUhS+dPxVAUoYC+PeeEBBvWJ4Cw
	 UKm+OFP4sfcjyeIRlIp+xzKZPZgNtuvLsVJbilMFjNmhZkDXWLx6bncHi4nCCxb27I
	 tSHD82yuhX1dw==
Date: Tue, 07 Jul 2026 21:07:01 +0200
Message-ID: <20260707190254.493733289@kernel.org>
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
Subject: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall() indirection
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Invoking sys_ni_syscall() from a code path, which already knows that the
syscall number is invalid just to assign -ENOSYS to regs->ax is a pointless
exercise. It's even redundant as the low level entry code already has set
regs->ax to -ENOSYS on entry.

Remove the extra conditionals and the function calls.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/x86/entry/syscall_32.c |    2 --
 arch/x86/entry/syscall_64.c |   10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -81,8 +81,6 @@ static __always_inline void do_syscall_3
 	if (likely(unr < IA32_NR_syscalls)) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call(regs, unr);
-	} else if (nr != -1) {
-		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
 
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -68,7 +68,7 @@ static __always_inline bool do_syscall_x
 	return false;
 }
 
-static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
+static __always_inline void do_syscall_x32(struct pt_regs *regs, int nr)
 {
 	/*
 	 * Adjust the starting offset of the table, and convert numbers
@@ -80,9 +80,7 @@ static __always_inline bool do_syscall_x
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
 		xnr = array_index_nospec(xnr, X32_NR_syscalls);
 		regs->ax = x32_sys_call(regs, xnr);
-		return true;
 	}
-	return false;
 }
 
 /* Returns true to return using SYSRET, or false to use IRET */
@@ -92,10 +90,8 @@ static __always_inline bool do_syscall_x
 
 	instrumentation_begin();
 
-	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
-		/* Invalid system call, but still a system call. */
-		regs->ax = __x64_sys_ni_syscall(regs);
-	}
+	if (!do_syscall_x64(regs, nr))
+		do_syscall_x32(regs, nr);
 
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);

