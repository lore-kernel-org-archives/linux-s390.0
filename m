Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from vmicros1.altlinux.org ([194.107.17.57]:51620 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBSG6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Jun 2020 14:06:58 -0400
Date: Tue, 2 Jun 2020 21:00:51 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] s390: fix syscall_get_error for compat processes
Message-ID: <20200602180051.GA2427@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <evgsyr@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

If both the tracer and the tracee are compat processes, and gprs[2]
is assigned a value by __poke_user_compat, then the higher 32 bits
of gprs[2] are cleared, IS_ERR_VALUE() always returns false, and
syscall_get_error() always returns 0.

Fix the implementation by sign-extending the value for compat processes
the same way as x86 implementation does.

The bug was exposed to user space by commit 201766a20e30f ("ptrace: add
PTRACE_GET_SYSCALL_INFO request") and detected by strace test suite.

This change fixes strace syscall tampering on s390.

Fixes: 753c4dd6a2fa2 ("[S390] ptrace changes")
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: stable@vger.kernel.org # v2.6.28+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/s390/include/asm/syscall.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index f073292e9fdb..c07633824715 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -33,7 +33,17 @@ static inline void syscall_rollback(struct task_struct *task,
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	return IS_ERR_VALUE(regs->gprs[2]) ? regs->gprs[2] : 0;
+	unsigned long error = regs->gprs[2];
+#ifdef CONFIG_COMPAT
+	if (test_tsk_thread_flag(task, TIF_31BIT)) {
+		/*
+		 * Sign-extend the value so (int)-EFOO becomes (long)-EFOO
+		 * and will match correctly in comparisons.
+		 */
+		error = (long) (int) error;
+	}
+#endif
+	return IS_ERR_VALUE(error) ? error : 0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
-- 
ldv
