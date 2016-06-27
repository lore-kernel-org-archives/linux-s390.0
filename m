From: Paul Moore <pmoore@redhat.com>
Subject: [PATCH v2] s390: ensure that syscall arguments are properly masked
	on s390
Date: Mon, 27 Jun 2016 10:34:36 -0400
Message-ID: <146703807642.15496.11673601281156224299.stgit@localhost>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Paul Moore <paul@paul-moore.com>

When executing s390 code on s390x the syscall arguments are not
properly masked, leading to some malformed audit records.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 arch/s390/kernel/ptrace.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 49b1c13..defc0dc 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -822,6 +822,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
+	unsigned long mask = -1UL;
 
 	/* Do the secure computing check first. */
 	if (secure_computing()) {
@@ -849,9 +850,12 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gprs[2]);
 
-	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2,
-			    regs->gprs[3], regs->gprs[4],
-			    regs->gprs[5]);
+	if (is_compat_task())
+		mask = 0xffffffff;
+
+	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2 & mask,
+			    regs->gprs[3] & mask, regs->gprs[4] & mask,
+			    regs->gprs[5] & mask);
 out:
 	return ret ?: regs->gprs[2];
 }
