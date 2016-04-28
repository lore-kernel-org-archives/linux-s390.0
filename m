Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 09/18] livepatch/x86: add TIF_PATCH_PENDING thread flag
Date: Thu, 28 Apr 2016 15:44:40 -0500
Message-Id: <6360fe5cab85aad424600518f645a9ac773cc72e.1461875890.git.jpoimboe@redhat.com>
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

Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
per-task consistency model for x86_64.  The bit getting set indicates
the thread has a pending patch which needs to be applied when the thread
exits the kernel.

The bit is placed in the least-significant word of the thread_info flags
so that it gets automatically included in the _TIF_ALLWORK_MASK macro.
This results in exit_to_usermode_loop() and klp_patch_task() getting
called when the bit is set.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/common.c            | 9 ++++++---
 arch/x86/include/asm/thread_info.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ec138e5..0eaa1d9 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -21,6 +21,7 @@
 #include <linux/context_tracking.h>
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
+#include <linux/livepatch.h>
 
 #include <asm/desc.h>
 #include <asm/traps.h>
@@ -202,14 +203,13 @@ long syscall_trace_enter(struct pt_regs *regs)
 
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
@@ -236,6 +236,9 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
+		if (cached_flags & _TIF_PATCH_PENDING)
+			klp_patch_task(current);
+
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 30c133a..4e4f50e 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -97,6 +97,7 @@ struct thread_info {
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
+#define TIF_PATCH_PENDING	13	/* pending live patching update */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_FORK		18	/* ret_from_fork */
@@ -121,6 +122,7 @@ struct thread_info {
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_FORK		(1 << TIF_FORK)
-- 
2.4.11
