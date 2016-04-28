Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 12/18] livepatch/s390: add TIF_PATCH_PENDING thread flag
Date: Thu, 28 Apr 2016 15:44:43 -0500
Message-Id: <b643fbd5eb584d6c4982423b662590ea8882970a.1461875890.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Miroslav Benes <mbenes@suse.cz>

Update a task's patch state when returning from a system call or user
space interrupt, or after handling a signal.

This greatly increases the chances of a patch operation succeeding.  If
a task is I/O bound, it can be patched when returning from a system
call.  If a task is CPU bound, it can be patched when returning from an
interrupt.  If a task is sleeping on a to-be-patched function, the user
can send SIGSTOP and SIGCONT to force it to switch.

Since there are two ways the syscall can be restarted on return from a
signal handling process, it is important to clear the flag before
do_signal() is called. Otherwise we could miss the migration if we used
SIGSTOP/SIGCONT procedure or fake signal to migrate patching blocking
tasks. If we place our hook to sysc_work label in entry before
TIF_SIGPENDING is evaluated we kill two birds with one stone. The task
is correctly migrated in all return paths from a syscall.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/s390/include/asm/thread_info.h |  2 ++
 arch/s390/kernel/entry.S            | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 8642c1d..b69d538 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -75,6 +75,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_UPROBE		3	/* breakpointed or single-stepping */
+#define TIF_PATCH_PENDING	4	/* pending live patching update */
 
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -93,6 +94,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_SIGPENDING		_BITUL(TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	_BITUL(TIF_NEED_RESCHED)
 #define _TIF_UPROBE		_BITUL(TIF_UPROBE)
+#define _TIF_PATCH_PENDING	_BITUL(TIF_PATCH_PENDING)
 
 #define _TIF_31BIT		_BITUL(TIF_31BIT)
 #define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 2d47f9c..5db5959 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -46,7 +46,7 @@ STACK_SIZE  = 1 << STACK_SHIFT
 STACK_INIT = STACK_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE
 
 _TIF_WORK	= (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
-		   _TIF_UPROBE)
+		   _TIF_UPROBE | _TIF_PATCH_PENDING)
 _TIF_TRACE	= (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
 		   _TIF_SYSCALL_TRACEPOINT)
 _CIF_WORK	= (_CIF_MCCK_PENDING | _CIF_ASCE | _CIF_FPU)
@@ -329,6 +329,11 @@ ENTRY(system_call)
 #endif
 	TSTMSK	__PT_FLAGS(%r11),_PIF_PER_TRAP
 	jo	.Lsysc_singlestep
+#ifdef CONFIG_LIVEPATCH
+	TSTMSK	__TI_flags(%r12),_TIF_PATCH_PENDING
+	jo	.Lsysc_patch_pending	# handle live patching just before
+					# signals and possible syscall restart
+#endif
 	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
 	jo	.Lsysc_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
@@ -404,6 +409,16 @@ ENTRY(system_call)
 #endif
 
 #
+# _TIF_PATCH_PENDING is set, call klp_patch_task
+#
+#ifdef CONFIG_LIVEPATCH
+.Lsysc_patch_pending:
+	lg	%r2,__TI_task(%r12)
+	larl	%r14,.Lsysc_return
+	jg	klp_patch_task
+#endif
+
+#
 # _PIF_PER_TRAP is set, call do_per_trap
 #
 .Lsysc_singlestep:
@@ -652,6 +667,10 @@ ENTRY(io_int_handler)
 	jo	.Lio_mcck_pending
 	TSTMSK	__TI_flags(%r12),_TIF_NEED_RESCHED
 	jo	.Lio_reschedule
+#ifdef CONFIG_LIVEPATCH
+	TSTMSK	__TI_flags(%r12),_TIF_PATCH_PENDING
+	jo	.Lio_patch_pending
+#endif
 	TSTMSK	__TI_flags(%r12),_TIF_SIGPENDING
 	jo	.Lio_sigpending
 	TSTMSK	__TI_flags(%r12),_TIF_NOTIFY_RESUME
@@ -698,6 +717,16 @@ ENTRY(io_int_handler)
 	j	.Lio_return
 
 #
+# _TIF_PATCH_PENDING is set, call klp_patch_task
+#
+#ifdef CONFIG_LIVEPATCH
+.Lio_patch_pending:
+	lg	%r2,__TI_task(%r12)
+	larl	%r14,.Lio_return
+	jg	klp_patch_task
+#endif
+
+#
 # _TIF_SIGPENDING or is set, call do_signal
 #
 .Lio_sigpending:
-- 
2.4.11
