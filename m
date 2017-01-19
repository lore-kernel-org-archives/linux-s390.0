Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 05/15] livepatch/powerpc: add TIF_PATCH_PENDING thread flag
Date: Thu, 19 Jan 2017 09:46:13 -0600
Message-Id: <b0d4d00868529f161c621f2dcfeee60f5a721b8e.1484839971.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1484839971.git.jpoimboe@redhat.com>
References: <cover.1484839971.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Add the TIF_PATCH_PENDING thread flag to enable the new livepatch
per-task consistency model for powerpc.  The bit getting set indicates
the thread has a pending patch which needs to be applied when the thread
exits the kernel.

The bit is included in the _TIF_USER_WORK_MASK macro so that
do_notify_resume() and klp_update_patch_state() get called when the bit
is set.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/thread_info.h | 4 +++-
 arch/powerpc/kernel/signal.c           | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 87e4b2d..6fc6464 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -92,6 +92,7 @@ static inline struct thread_info *current_thread_info(void)
 					   TIF_NEED_RESCHED */
 #define TIF_32BIT		4	/* 32 bit binary */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
+#define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NOHZ		9	/* in adaptive nohz mode */
@@ -115,6 +116,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
+#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
@@ -131,7 +133,7 @@ static inline struct thread_info *current_thread_info(void)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
-				 _TIF_RESTORE_TM)
+				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 3a36711..e9436c5 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -14,6 +14,7 @@
 #include <linux/uprobes.h>
 #include <linux/key.h>
 #include <linux/context_tracking.h>
+#include <linux/livepatch.h>
 #include <asm/hw_breakpoint.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -162,6 +163,9 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 		tracehook_notify_resume(regs);
 	}
 
+	if (thread_info_flags & _TIF_PATCH_PENDING)
+		klp_update_patch_state(current);
+
 	user_enter();
 }
 
-- 
2.7.4
