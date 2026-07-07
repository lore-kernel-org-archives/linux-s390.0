Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C183A380A;
	Tue,  7 Jul 2026 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451196; cv=none; b=J9r8iJgBclG6vfYAiv0MPNtiTW96rndjG0euZ1pRHCwm7ezNXDzLKudYVGjtDCOA/e0j5h9TWhFVS2teY017mR8mEbeRa0LZN2pDWU3V3VW1d8E3NvgdbUFozmvFxg8aJZO3NACLaNm/AyvBwWLRw8FL2ffNgsHIh5cnIgj0KB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451196; c=relaxed/simple;
	bh=f5adocVvDmANhynlDDS9Q7+CMqBafERvB6xHEIk5vOc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vo1xTm3nGzjZUA+McQx1qG1G1aNp5JO4p5h3UFuh2kGuPc77DjhUc2mJOCLyz5xbq9Aov1v+jw7/mCuc3Q/jDr0yJMvLx3DOZbLvElwLmbfHZwxYb/eGyaxjHoqO3lrfAQJPZlhNrV5IunHNA1THGSmjwpinoW2HDYJ80jI82lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQZnMsUe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQZnMsUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882A1F00A3D;
	Tue,  7 Jul 2026 19:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451190;
	bh=9cJlPyoSYNFp/gOreqxa1IqYId3zkUs6emQr6ytoL3s=;
	h=Date:From:To:Cc:Subject:References;
	b=nQZnMsUeWM0MBmYh2tftX2ldO6f4f4+KQMN8PIETF59TUOLWGfrzzUj86Bfd1xFh6
	 10CcaK+cuIh4vWxH/paWeIPEbvqCR1T98llJwakIpvPv3wZbJgr7EneYcvAjY3VyZc
	 A4mjZpEslZwnTQ9Y3RdELc2sHV368KIKF0A5adgHMQpKbhnF3wx5Vk/7BVZea8ug+A
	 sLcT2ttVqhK19d2pPXbALVn/ZjJDUgCPlmQmEO3tTnqhNKn17sPyy6QjidI+vgfixZ
	 R+fRDdpiEFDapfuQEgmUBP+RUuSIVZHbmwmncIS0zVZsCPzwXAEyG1obgAdo30Y+r0
	 YPfe7YvFhevHQ==
Date: Tue, 07 Jul 2026 21:06:27 +0200
Message-ID: <20260707190254.079478122@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
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
Subject: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

These functions integrate the stack randomization.

syscall_enter_from_user_mode_randomize_stack() has the advantage that the
randomization happens early right after enter_from_user_mode().

In both cases also the overhead of get/put_cpu_var() in
add_random_kstack_offset() is avoided.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/entry/syscall_32.c         |   19 +++++--------------
 arch/x86/entry/syscall_64.c         |    3 +--
 arch/x86/include/asm/entry-common.h |    1 -
 3 files changed, 6 insertions(+), 17 deletions(-)

--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -142,10 +142,9 @@ static __always_inline bool int80_is_ext
 	 * int80_is_external() below which calls into the APIC driver.
 	 * Identical for soft and external interrupts.
 	 */
-	enter_from_user_mode(regs);
+	enter_from_user_mode_randomize_stack(regs);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
 
 	/* Validate that this is a soft interrupt to the extent possible */
 	if (unlikely(int80_is_external()))
@@ -210,11 +209,9 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 {
 	int nr;
 
-	enter_from_user_mode(regs);
+	enter_from_user_mode_randomize_stack(regs);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
-
 	/*
 	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
 	 * syscall number.
@@ -252,10 +249,10 @@ DEFINE_FREDENTRY_RAW(int80_emulation)
 	 * orig_ax, the int return value truncates it. This matches
 	 * the semantics of syscall_get_nr().
 	 */
-	nr = syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
+
 	instrumentation_begin();
 
-	add_random_kstack_offset();
 	do_syscall_32_irqs_on(regs, nr);
 
 	instrumentation_end();
@@ -268,15 +265,9 @@ static noinstr bool __do_fast_syscall_32
 	int nr = syscall_32_enter(regs);
 	int res;
 
-	/*
-	 * This cannot use syscall_enter_from_user_mode() as it has to
-	 * fetch EBP before invoking any of the syscall entry work
-	 * functions.
-	 */
-	enter_from_user_mode(regs);
+	enter_from_user_mode_randomize_stack(regs);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
 	local_irq_enable();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -86,10 +86,9 @@ static __always_inline bool do_syscall_x
 /* Returns true to return using SYSRET, or false to use IRET */
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
-	nr = syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
 
 	instrumentation_begin();
-	add_random_kstack_offset();
 
 	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
 		/* Invalid system call, but still a system call. */
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_ENTRY_COMMON_H
 #define _ASM_X86_ENTRY_COMMON_H
 
-#include <linux/randomize_kstack.h>
 #include <linux/user-return-notifier.h>
 
 #include <asm/nospec-branch.h>

