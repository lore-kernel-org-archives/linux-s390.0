Return-Path: <linux-arch-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 12/14] powerpc/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:02 -0700
Message-ID: <1465506124-21866-13-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160609210202.B5BzbBxK7f4zHGjVA5R7YMb9RBk5Txc940xHfuYhPsQ@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/ptrace.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ed799e994773..5dc47ebb3840 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1788,7 +1788,7 @@ static int do_seccomp(struct pt_regs *regs)
 
 	/*
 	 * The syscall was allowed by seccomp, restore the register
-	 * state to what ptrace and audit expect.
+	 * state to what audit expects.
 	 * Note that we use orig_gpr3, which means a seccomp tracer can
 	 * modify the first syscall parameter (in orig_gpr3) and also
 	 * allow the syscall to proceed.
@@ -1822,22 +1822,25 @@ static inline int do_seccomp(struct pt_regs *regs) { return 0; }
  */
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	bool abort = false;
-
 	user_exit();
 
+	/*
+	 * The tracer may decide to abort the syscall, if so tracehook
+	 * will return !0. Note that the tracer may also just change
+	 * regs->gpr[0] to an invalid syscall number, that is handled
+	 * below on the exit path.
+	 */
+	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs))
+		goto skip;
+
+	/* Run seccomp after ptrace; allow it to set gpr[3]. */
 	if (do_seccomp(regs))
 		return -1;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		/*
-		 * The tracer may decide to abort the syscall, if so tracehook
-		 * will return !0. Note that the tracer may also just change
-		 * regs->gpr[0] to an invalid syscall number, that is handled
-		 * below on the exit path.
-		 */
-		abort = tracehook_report_syscall_entry(regs) != 0;
-	}
+	/* Avoid trace and audit when syscall is invalid. */
+	if (regs->gpr[0] >= NR_syscalls)
+		goto skip;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gpr[0]);
@@ -1854,17 +1857,16 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 				    regs->gpr[5] & 0xffffffff,
 				    regs->gpr[6] & 0xffffffff);
 
-	if (abort || regs->gpr[0] >= NR_syscalls) {
-		/*
-		 * If we are aborting explicitly, or if the syscall number is
-		 * now invalid, set the return value to -ENOSYS.
-		 */
-		regs->gpr[3] = -ENOSYS;
-		return -1;
-	}
-
 	/* Return the possibly modified but valid syscall number */
 	return regs->gpr[0];
+
+skip:
+	/*
+	 * If we are aborting explicitly, or if the syscall number is
+	 * now invalid, set the return value to -ENOSYS.
+	 */
+	regs->gpr[3] = -ENOSYS;
+	return -1;
 }
 
 void do_syscall_trace_leave(struct pt_regs *regs)
-- 
2.7.4
