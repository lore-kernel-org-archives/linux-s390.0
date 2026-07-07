Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AA436BCA;
	Tue,  7 Jul 2026 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451202; cv=none; b=OeW2gyQJieQzoX7jR2yE91fca0HBDsBxUXA4wOg8Y8861ZR+RViDYmhVVuUP2GKGwk+XXpOZwzQrN3Vx5wGMbiJ1ZZ6VNpopk1kwWJmCYVnv0LHUVfzxLyBD7Jo4FZhDa5I77lXve3RWq/UA+E2tFQfMRiBCrC69Z4aF4EpCang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451202; c=relaxed/simple;
	bh=qREUyjIW8fgVFwf6mCuY/7+DaL+84ELoNQHCs1rFK8I=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SUv5F0uhQpzTMh9VzevwyKKaOajTLMYNYbjC9uxDlZbNpIft0dJ7BN7RsBciA5BPBE+hiQzvhajJEQ2bryqVPfi/qr81bF9abSkvm4bMOuYEqTymylvQSa2HARDqLXbgNhjgZtDRA6r0X8M51TpxJJpKu2pEjrlbi6jPPfhGnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d68e/zkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d68e/zkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91BA1F000E9;
	Tue,  7 Jul 2026 19:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451194;
	bh=Ko42Ry29jFPoMyPQLdlxYhg8S/68hEmUYQPkE8hHtRo=;
	h=Date:From:To:Cc:Subject:References;
	b=d68e/zkh5oU9ziZmyD8/j0zm+dms5mzI3QpxXDgS3beo+n+Xnv/2HSq+wH632V3sd
	 8uTzG42LNfaK05lc2KYYdDujQ1J4Cgu9HUzFOHwcGxBUM8uoXWnE/1r5BSASo70M2/
	 BeZM/CiOfzvrrk1xZNqIUAM6oN02Mkik+/OqqvpTFPpbyHqBCzcd+u7xOyvYG2DB/V
	 bFMusVe8fZm0EviIlm2Cdc6bEcEu9PSgqO6pG/h8ekgyn42NUtvGGWIO67Mdyq29CY
	 XsTesNZZfW6pwplIhbQXruHpmuALvlix8sPBSkJLCO72NF5LTVJjzfgWsBEq/Yvuwu
	 cgcjZWz5+d1VQ==
Date: Tue, 07 Jul 2026 21:06:32 +0200
Message-ID: <20260707190254.132654198@kernel.org>
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
Subject: [patch 09/18] entry: Remove syscall_enter_from_user_mode()
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

All architecture use either:

    nr = enter_from_user_mode_randomize_stack(regs, nr);

or

    enter_from_user_mode_randomize_stack(regs);
    nr = syscall_enter_from_user_mode_work(regs, nr);

Remove the now unused function.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 Documentation/core-api/entry.rst |   17 +++++++++-------
 include/linux/entry-common.h     |   40 +++------------------------------------
 include/linux/irq-entry-common.h |    6 ++---
 3 files changed, 17 insertions(+), 46 deletions(-)

--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -68,7 +68,7 @@ low-level C code must not be instrumente
   noinstr void syscall(struct pt_regs *regs, int nr)
   {
 	arch_syscall_enter(regs);
-	nr = syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode_randomize_stack(regs, nr);
 
 	instrumentation_begin();
 	if (!invoke_syscall(regs, nr) && nr != -1)
@@ -78,12 +78,14 @@ low-level C code must not be instrumente
 	syscall_exit_to_user_mode(regs);
   }
 
-syscall_enter_from_user_mode() first invokes enter_from_user_mode() which
-establishes state in the following order:
+syscall_enter_from_user_mode_randomize_stack() first invokes
+enter_from_user_mode_randomize_stack() which establishes state in the
+following order:
 
   * Lockdep
   * RCU / Context tracking
   * Tracing
+  * Apply stack randomization
 
 and then invokes the various entry work functions like ptrace, seccomp, audit,
 syscall tracing, etc. After all that is done, the instrumentable invoke_syscall
@@ -99,10 +101,11 @@ that it invokes exit_to_user_mode() whic
   * RCU / Context tracking
   * Lockdep
 
-syscall_enter_from_user_mode() and syscall_exit_to_user_mode() are also
-available as fine grained subfunctions in cases where the architecture code
-has to do extra work between the various steps. In such cases it has to
-ensure that enter_from_user_mode() is called first on entry and
+syscall_enter_from_user_mode_randomize_stack() and
+syscall_exit_to_user_mode() are also available as fine grained subfunctions
+in cases where the architecture code has to do extra work between the
+various steps. In such cases it has to ensure that
+enter_from_user_mode_randomize_stack() is called first on entry and
 exit_to_user_mode() is called last on exit.
 
 Do not nest syscalls. Nested syscalls will cause RCU and/or context tracking
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -19,7 +19,7 @@
 #endif
 
 /*
- * SYSCALL_WORK flags handled in syscall_enter_from_user_mode()
+ * SYSCALL_WORK flags handled in syscall_enter_from_user_mode_work()
  */
 #define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
 				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
@@ -205,42 +205,10 @@ do {									\
 	_ret;								\
 })
 
-/**
- * syscall_enter_from_user_mode - Establish state and check and handle work
- *				  before invoking a syscall
- * @regs:	Pointer to currents pt_regs
- * @syscall:	The syscall number
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct, interrupts are enabled and the
- * subsequent functions can be instrumented.
- *
- * This is the combination of enter_from_user_mode() and
- * syscall_enter_from_user_mode_work() to be used when there is no
- * architecture specific work to be done between the two.
- *
- * Returns: The original or a modified syscall number. See
- * syscall_enter_from_user_mode_work() for further explanation.
- */
-static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	long ret;
-
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	local_irq_enable();
-	ret = syscall_enter_from_user_mode_work(regs, syscall);
-	instrumentation_end();
-
-	return ret;
-}
-
 /*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
+ * If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP is
+ * set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall instruction has been
+ * already reported in syscall_enter_from_user_mode_work().
  */
 static __always_inline bool report_single_step(unsigned long work)
 {
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -49,9 +49,9 @@
  * Defaults to an empty implementation. Can be replaced by architecture
  * specific code.
  *
- * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
- * section. Use __always_inline so the compiler cannot push it out of line
- * and make it instrumentable.
+ * Invoked from enter_from_user_mode_syscall_and_randomize_stack() in the
+ * non-instrumentable section. Use __always_inline so the compiler cannot push
+ * it out of line and make it instrumentable.
  */
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
 

