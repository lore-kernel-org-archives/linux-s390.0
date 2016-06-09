From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 04/14] seccomp: remove 2-phase API
Date: Thu,  9 Jun 2016 14:01:54 -0700
Message-ID: <1465506124-21866-5-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org>
List-ID: <linux-s390.vger.kernel.org>

Since nothing is using the 2-phase API, and it adds more complexity than
benefit, remove it.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 include/linux/seccomp.h |   6 ---
 kernel/seccomp.c        | 129 +++++++++++++++---------------------------------
 2 files changed, 41 insertions(+), 94 deletions(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 9eaa7b34d6da..ecc296c137cd 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -35,12 +35,6 @@ static inline int secure_computing(const struct seccomp_data *sd)
 		return  __secure_computing(sd);
 	return 0;
 }
-
-#define SECCOMP_PHASE1_OK	0
-#define SECCOMP_PHASE1_SKIP	1
-
-extern u32 seccomp_phase1(struct seccomp_data *sd);
-int seccomp_phase2(u32 phase1_result);
 #else
 extern void secure_computing_strict(int this_syscall);
 #endif
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 06816290a212..14a37d71b612 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -173,7 +173,7 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
  *
  * Returns valid seccomp BPF response codes.
  */
-static u32 seccomp_run_filters(struct seccomp_data *sd)
+static u32 seccomp_run_filters(const struct seccomp_data *sd)
 {
 	struct seccomp_data sd_local;
 	u32 ret = SECCOMP_RET_ALLOW;
@@ -554,20 +554,9 @@ void secure_computing_strict(int this_syscall)
 		BUG();
 }
 #else
-int __secure_computing(const struct seccomp_data *sd)
-{
-	u32 phase1_result = seccomp_phase1(sd);
-
-	if (likely(phase1_result == SECCOMP_PHASE1_OK))
-		return 0;
-	else if (likely(phase1_result == SECCOMP_PHASE1_SKIP))
-		return -1;
-	else
-		return seccomp_phase2(phase1_result);
-}
 
 #ifdef CONFIG_SECCOMP_FILTER
-static u32 __seccomp_phase1_filter(int this_syscall, struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 {
 	u32 filter_ret, action;
 	int data;
@@ -599,10 +588,33 @@ static u32 __seccomp_phase1_filter(int this_syscall, struct seccomp_data *sd)
 		goto skip;
 
 	case SECCOMP_RET_TRACE:
-		return filter_ret;  /* Save the rest for phase 2. */
+		/* ENOSYS these calls if there is no tracer attached. */
+		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
+			syscall_set_return_value(current,
+						 task_pt_regs(current),
+						 -ENOSYS, 0);
+			goto skip;
+		}
+
+		/* Allow the BPF to provide the event message */
+		ptrace_event(PTRACE_EVENT_SECCOMP, data);
+		/*
+		 * The delivery of a fatal signal during event
+		 * notification may silently skip tracer notification.
+		 * Terminating the task now avoids executing a system
+		 * call that may not be intended.
+		 */
+		if (fatal_signal_pending(current))
+			do_exit(SIGSYS);
+		/* Check if the tracer forced the syscall to be skipped. */
+		this_syscall = syscall_get_nr(current, task_pt_regs(current));
+		if (this_syscall < 0)
+			goto skip;
+
+		return 0;
 
 	case SECCOMP_RET_ALLOW:
-		return SECCOMP_PHASE1_OK;
+		return 0;
 
 	case SECCOMP_RET_KILL:
 	default:
@@ -614,96 +626,37 @@ static u32 __seccomp_phase1_filter(int this_syscall, struct seccomp_data *sd)
 
 skip:
 	audit_seccomp(this_syscall, 0, action);
-	return SECCOMP_PHASE1_SKIP;
+	return -1;
+}
+#else
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+{
+	BUG();
 }
 #endif
 
-/**
- * seccomp_phase1() - run fast path seccomp checks on the current syscall
- * @arg sd: The seccomp_data or NULL
- *
- * This only reads pt_regs via the syscall_xyz helpers.  The only change
- * it will make to pt_regs is via syscall_set_return_value, and it will
- * only do that if it returns SECCOMP_PHASE1_SKIP.
- *
- * If sd is provided, it will not read pt_regs at all.
- *
- * It may also call do_exit or force a signal; these actions must be
- * safe.
- *
- * If it returns SECCOMP_PHASE1_OK, the syscall passes checks and should
- * be processed normally.
- *
- * If it returns SECCOMP_PHASE1_SKIP, then the syscall should not be
- * invoked.  In this case, seccomp_phase1 will have set the return value
- * using syscall_set_return_value.
- *
- * If it returns anything else, then the return value should be passed
- * to seccomp_phase2 from a context in which ptrace hooks are safe.
- */
-u32 seccomp_phase1(struct seccomp_data *sd)
+int __secure_computing(const struct seccomp_data *sd)
 {
 	int mode = current->seccomp.mode;
-	int this_syscall = sd ? sd->nr :
-		syscall_get_nr(current, task_pt_regs(current));
+	int this_syscall;
 
 	if (config_enabled(CONFIG_CHECKPOINT_RESTORE) &&
 	    unlikely(current->ptrace & PT_SUSPEND_SECCOMP))
-		return SECCOMP_PHASE1_OK;
+		return 0;
+
+	this_syscall = sd ? sd->nr :
+		syscall_get_nr(current, task_pt_regs(current));
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
-		return SECCOMP_PHASE1_OK;
-#ifdef CONFIG_SECCOMP_FILTER
+		return 0;
 	case SECCOMP_MODE_FILTER:
-		return __seccomp_phase1_filter(this_syscall, sd);
-#endif
+		return __seccomp_filter(this_syscall, sd);
 	default:
 		BUG();
 	}
 }
-
-/**
- * seccomp_phase2() - finish slow path seccomp work for the current syscall
- * @phase1_result: The return value from seccomp_phase1()
- *
- * This must be called from a context in which ptrace hooks can be used.
- *
- * Returns 0 if the syscall should be processed or -1 to skip the syscall.
- */
-int seccomp_phase2(u32 phase1_result)
-{
-	struct pt_regs *regs = task_pt_regs(current);
-	u32 action = phase1_result & SECCOMP_RET_ACTION;
-	int data = phase1_result & SECCOMP_RET_DATA;
-
-	BUG_ON(action != SECCOMP_RET_TRACE);
-
-	audit_seccomp(syscall_get_nr(current, regs), 0, action);
-
-	/* Skip these calls if there is no tracer. */
-	if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
-		syscall_set_return_value(current, regs,
-					 -ENOSYS, 0);
-		return -1;
-	}
-
-	/* Allow the BPF to provide the event message */
-	ptrace_event(PTRACE_EVENT_SECCOMP, data);
-	/*
-	 * The delivery of a fatal signal during event
-	 * notification may silently skip tracer notification.
-	 * Terminating the task now avoids executing a system
-	 * call that may not be intended.
-	 */
-	if (fatal_signal_pending(current))
-		do_exit(SIGSYS);
-	if (syscall_get_nr(current, regs) < 0)
-		return -1;  /* Explicit request to skip. */
-
-	return 0;
-}
 #endif /* CONFIG_HAVE_ARCH_SECCOMP_FILTER */
 
 long prctl_get_seccomp(void)
-- 
2.7.4
