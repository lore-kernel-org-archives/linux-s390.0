Return-Path: <linux-arch-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 11/14] s390/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:01 -0700
Message-ID: <1465506124-21866-12-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20160609210201.Hu_D_1eK9Yd13IIzyOuO-xbcqtl3euj0e-_8XojxVRA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/ptrace.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index c238e9958c2a..cea17010448f 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -821,15 +821,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	long ret = 0;
-
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL)) {
-		/* seccomp failures shouldn't expose any additional code. */
-		ret = -1;
-		goto out;
-	}
-
 	/*
 	 * The sysc_tracesys code in entry.S stored the system
 	 * call number to gprs[2].
@@ -843,7 +834,13 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		 * the system call and the system call restart handling.
 		 */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-		ret = -1;
+		return -1;
+	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL)) {
+		/* seccomp failures shouldn't expose any additional code. */
+		return -1;
 	}
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
@@ -852,8 +849,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2,
 			    regs->gprs[3], regs->gprs[4],
 			    regs->gprs[5]);
-out:
-	return ret ?: regs->gprs[2];
+
+	return regs->gprs[2];
 }
 
 asmlinkage void do_syscall_trace_exit(struct pt_regs *regs)
-- 
2.7.4
