Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 11/18] livepatch/s390: reorganize TIF thread flag bits
Date: Thu, 28 Apr 2016 15:44:42 -0500
Message-Id: <2cc2dc90abc8b999594d5e8cf2f396df26cd76d6.1461875890.git.jpoimboe@redhat.com>
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

From: Jiri Slaby <jslaby@suse.cz>

Group the TIF thread flag bits by their inclusion in the _TIF_WORK and
_TIF_TRACE macros.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/s390/include/asm/thread_info.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 2fffc2c..8642c1d 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -70,14 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
 /*
  * thread information flags bit numbers
  */
+/* _TIF_WORK bits */
 #define TIF_NOTIFY_RESUME	0	/* callback before returning to user */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_SYSCALL_TRACE	3	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
-#define TIF_SECCOMP		5	/* secure computing */
-#define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
-#define TIF_UPROBE		7	/* breakpointed or single-stepping */
+#define TIF_UPROBE		3	/* breakpointed or single-stepping */
+
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal() */
@@ -85,15 +83,23 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_BLOCK_STEP		20	/* This task is block stepped */
 #define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
 
+/* _TIF_TRACE bits */
+#define TIF_SYSCALL_TRACE	24	/* syscall trace active */
+#define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
+#define TIF_SECCOMP		26	/* secure computing */
+#define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
+
 #define _TIF_NOTIFY_RESUME	_BITUL(TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		_BITUL(TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	_BITUL(TIF_NEED_RESCHED)
+#define _TIF_UPROBE		_BITUL(TIF_UPROBE)
+
+#define _TIF_31BIT		_BITUL(TIF_31BIT)
+#define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
+
 #define _TIF_SYSCALL_TRACE	_BITUL(TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	_BITUL(TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		_BITUL(TIF_SECCOMP)
 #define _TIF_SYSCALL_TRACEPOINT	_BITUL(TIF_SYSCALL_TRACEPOINT)
-#define _TIF_UPROBE		_BITUL(TIF_UPROBE)
-#define _TIF_31BIT		_BITUL(TIF_31BIT)
-#define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
 
 #endif /* _ASM_THREAD_INFO_H */
-- 
2.4.11
