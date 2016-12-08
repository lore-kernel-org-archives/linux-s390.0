Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 04/15] livepatch/x86: add TIF_PATCH_PENDING thread flag
Date: Thu,  8 Dec 2016 12:08:29 -0600
Message-Id: <b7bbfce2330e61329056e4567c68be8e4c55fb5b.1481220077.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1481220077.git.jpoimboe@redhat.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
per-task consistency model for x86_64.  The bit getting set indicates
the thread has a pending patch which needs to be applied when the thread
exits the kernel.

The bit is placed in the _TIF_ALLWORK_MASK macro, which results in
exit_to_usermode_loop() calling klp_update_patch_state() when it's set.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/common.c            | 9 ++++++---
 arch/x86/include/asm/thread_info.h | 4 +++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bdd9cc5..16a51a5 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -21,6 +21,7 @@
 #include <linux/context_tracking.h>
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
+#include <linux/livepatch.h>
 
 #include <asm/desc.h>
 #include <asm/traps.h>
@@ -129,14 +130,13 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY)
+	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
 
 static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 {
 	/*
 	 * In order to return to user mode, we need to have IRQs off with
-	 * none of _TIF_SIGPENDING, _TIF_NOTIFY_RESUME, _TIF_USER_RETURN_NOTIFY,
-	 * _TIF_UPROBE, or _TIF_NEED_RESCHED set.  Several of these flags
+	 * none of EXIT_TO_USERMODE_LOOP_FLAGS set.  Several of these flags
 	 * can be set at any time on preemptable kernels if we have IRQs on,
 	 * so we need to loop.  Disabling preemption wouldn't help: doing the
 	 * work to clear some of the flags can sleep.
@@ -163,6 +163,9 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
+		if (cached_flags & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 1fe6043..79f4d6a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,6 +84,7 @@ struct thread_info {
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
+#define TIF_PATCH_PENDING	13	/* pending live patching update */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
@@ -107,6 +108,7 @@ struct thread_info {
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
@@ -133,7 +135,7 @@ struct thread_info {
 	(_TIF_SYSCALL_TRACE | _TIF_NOTIFY_RESUME | _TIF_SIGPENDING |	\
 	 _TIF_SINGLESTEP | _TIF_NEED_RESCHED | _TIF_SYSCALL_EMU |	\
 	 _TIF_SYSCALL_AUDIT | _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE |	\
-	 _TIF_SYSCALL_TRACEPOINT | _TIF_NOHZ)
+	 _TIF_SYSCALL_TRACEPOINT | _TIF_NOHZ | _TIF_PATCH_PENDING)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-- 
2.7.4
