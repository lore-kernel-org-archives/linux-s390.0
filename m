Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F029378839;
	Tue,  7 Jul 2026 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451177; cv=none; b=fhx9QYMOc16cOXscb1NQ8mQ/1UNYGhjYkT1rTOiItZ0QCELUCtkpFFTUmxpI0t1sIqGGIYI2Cg/50LOTy2ozQ5xPpLFSPjVcmEc5CKHSRkoSULpVXDSQ18Yx6xYm74kLFbqhi6jtVg6oRWPxP/pxP2nj9Olh3NHIeu+LheOk0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451177; c=relaxed/simple;
	bh=ihmrVJArIw5Arei7GCnzmo+eXzjadSV5bTzArssQBXw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pUMisNMdGfNP2RX6Kl66pFEJgJtcWdjbfduOL5qKKnzuKhVenNo0gpEiRnYAu6JXSdtkiSKF44p6sYjY6+w0lsb0ckn8zUUiL2yx11ptUnUDJKSlr0abltFY2UCKOyDAWTsw5RxhMnAE/IOZA8N+ut7w5VxGLqaUl7qrAJ4IIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY1zowse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY1zowse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B438D1F00A3D;
	Tue,  7 Jul 2026 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451169;
	bh=LBj+ZkGRdAQN74z4D94PD8p6NaRtGe8kKF18FGUoSBc=;
	h=Date:From:To:Cc:Subject:References;
	b=VY1zowsespAaLkdQfjN21WoDu0I2bpmruM24iQyJPomLBoNcfhRcxHp71u2Qaoz8w
	 2Y6R/xVT7Yp0jxQTc8E5PWuftOuCpOuAgoGxlRSnJZdeLFmp/X5t3iL3htCKZRfn3+
	 ZILTZaA9qyxubwDpKLYazC72ZykMomE0EWqkxhprvJrhHU6PoirMY9t5PUOI4e22OR
	 1Mzlboe/bN4bCNA4g1TTcbgSS+G0cMdMv/Ny3g+iZse0ddGOTpczuxmdM6Qdp/eE7e
	 Cdr45b4mkb4xZpki9QM7BPX+TNtyRnQRDjpUHUDvask5gaQC50oiZ/ZZKDlC+8+3Ru
	 MjqY28jZMNheA==
Date: Tue, 07 Jul 2026 21:06:07 +0200
Message-ID: <20260707190253.816918647@kernel.org>
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
Subject: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
References: <20260707181957.433213175@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Randomizing the syscall stack can only happen after state is established
via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
it happens the better.

Provide two new macros to consolidate that:

  - enter_from_user_mode_randomize_stack()
	enter_from_user_mode();
	add_random_kstack_offset_irqsoff();

  - syscall_enter_from_user_mode_randomize_stack()
	enter_from_user_mode_randomize_stack();
	syscall_enter_from_user_mode_work();
    
to reduce boiler plate code.

Those are macros and not inline functions as the latter would limit the
stack randomization scope to the inline function itself.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 include/linux/entry-common.h |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -6,6 +6,7 @@
 #include <linux/irq-entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/randomize_kstack.h>
 #include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
@@ -150,6 +151,61 @@ static __always_inline long syscall_ente
 }
 
 /**
+ * enter_from_user_mode_randomize_stack - Establish state and add stack randomization
+ *					  before invoking syscall_enter_from_user_mode_work()
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the function
+ * returns all state is correct, interrupts are still disabled and the
+ * subsequent functions can be instrumented.
+ *
+ * Implemented as a macro so that the stack randomization is effective
+ * throughout the function in which it is invoked. An inline would only make it
+ * effective in the scope of the inline function.
+ */
+#define enter_from_user_mode_randomize_stack(regs)			\
+do {									\
+	enter_from_user_mode(regs);					\
+	instrumentation_begin();					\
+	add_random_kstack_offset_irqsoff();				\
+	instrumentation_end();						\
+} while (0)
+
+/**
+ * syscall_enter_from_user_mode_randomize_stack - Establish state and check and handle work
+ *						  before invoking a syscall
+ * @regs:	Pointer to currents pt_regs
+ * @syscall:	The syscall number
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct, interrupts are enabled and the
+ * subsequent functions can be instrumented.
+ *
+ * This is the combination of enter_from_user_mode_randomize_stack() and
+ * syscall_enter_from_user_mode_work() to be used when there is no
+ * architecture specific work to be done between the two.
+ *
+ * Returns: The original or a modified syscall number. See
+ * syscall_enter_from_user_mode_work() for further explanation.
+ *
+ * Implemented as a macro to make stack randomization effective in the calling
+ * scope.
+ */
+#define syscall_enter_from_user_mode_randomize_stack(regs, syscall)	\
+({									\
+	enter_from_user_mode_randomize_stack(regs);			\
+									\
+	instrumentation_begin();					\
+	local_irq_enable();						\
+	long _ret = syscall_enter_from_user_mode_work(regs, syscall);	\
+	instrumentation_end();						\
+									\
+	_ret;								\
+})
+
+/**
  * syscall_enter_from_user_mode - Establish state and check and handle work
  *				  before invoking a syscall
  * @regs:	Pointer to currents pt_regs

