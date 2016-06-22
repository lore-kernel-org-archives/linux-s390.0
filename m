From: Paul Moore <pmoore@redhat.com>
Subject: [PATCH] s390: ensure that syscall arguments are properly masked on
	s390
Date: Wed, 22 Jun 2016 16:42:51 -0400
Message-ID: <146662817147.26957.1285313998059040337.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audit-bounces@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-audit>
List-Post: <mailto:linux-audit@redhat.com>
List-Help: <mailto:linux-audit-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-audit>,
	<mailto:linux-audit-request@redhat.com?subject=subscribe>
Sender: linux-audit-bounces@redhat.com
Errors-To: linux-audit-bounces@redhat.com
List-Archive: <https://lore.kernel.org/linux-audit/>
To: linux-s390@vger.kernel.org, linux-audit@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Paul Moore <paul@paul-moore.com>

When executing s390 code on s390x the syscall arguments are not
properly masked, leading to some malformed audit records.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 arch/s390/kernel/ptrace.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 49b1c13..ac1dc74 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -822,6 +822,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
+	unsigned long mask = -1UL;
 
 	/* Do the secure computing check first. */
 	if (secure_computing()) {
@@ -849,9 +850,13 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gprs[2]);
 
-	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2,
-			    regs->gprs[3], regs->gprs[4],
-			    regs->gprs[5]);
+#ifdef CONFIG_COMPAT
+        if (test_thread_flag(TIF_31BIT))
+                mask = 0xffffffff;
+#endif
+	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2 & mask,
+			    regs->gprs[3] & mask, regs->gprs[4] & mask,
+			    regs->gprs[5] & mask);
 out:
 	return ret ?: regs->gprs[2];
 }
