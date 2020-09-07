Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729236AbgIGMr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 08:47:29 -0400
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v2 2/2] s390x: Add 3f program exception handler
Date: Mon,  7 Sep 2020 08:47:00 -0400
Message-Id: <20200907124700.10374-3-frankja@linux.ibm.com>
In-Reply-To: <20200907124700.10374-1-frankja@linux.ibm.com>
References: <20200907124700.10374-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, hca@linux.ibm.com

Program exception 3f (secure storage violation) can only be detected
when the CPU is running in SIE with a format 4 state description,
e.g. running a protected guest. Because of this and because user
space partly controls the guest memory mapping and can trigger this
exception, we want to send a SIGSEGV to the process running the guest
and not panic the kernel.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
CC: <stable@vger.kernel.org> # 5.7+
Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/pgm_check.S |  2 +-
 arch/s390/mm/fault.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/pgm_check.S b/arch/s390/kernel/pgm_check.S
index 2c27907a5ffc..9a92638360ee 100644
--- a/arch/s390/kernel/pgm_check.S
+++ b/arch/s390/kernel/pgm_check.S
@@ -80,7 +80,7 @@ PGM_CHECK(do_dat_exception)		/* 3b */
 PGM_CHECK_DEFAULT			/* 3c */
 PGM_CHECK(do_secure_storage_access)	/* 3d */
 PGM_CHECK(do_non_secure_storage_access)	/* 3e */
-PGM_CHECK_DEFAULT			/* 3f */
+PGM_CHECK(do_secure_storage_violation)	/* 3f */
 PGM_CHECK(monitor_event_exception)	/* 40 */
 PGM_CHECK_DEFAULT			/* 41 */
 PGM_CHECK_DEFAULT			/* 42 */
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4c8c063bce5b..996884dcc9fd 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -859,6 +859,21 @@ void do_non_secure_storage_access(struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(do_non_secure_storage_access);
 
+void do_secure_storage_violation(struct pt_regs *regs)
+{
+	/*
+	 * Either KVM messed up the secure guest mapping or the same
+	 * page is mapped into multiple secure guests.
+	 *
+	 * This exception is only triggered when a guest 2 is running
+	 * and can therefore never occur in kernel context.
+	 */
+	printk_ratelimited(KERN_WARNING
+			   "Secure storage violation in task: %s, pid %d\n",
+			   current->comm, current->pid);
+	send_sig(SIGSEGV, current, 0);
+}
+
 #else
 void do_secure_storage_access(struct pt_regs *regs)
 {
@@ -869,4 +884,9 @@ void do_non_secure_storage_access(struct pt_regs *regs)
 {
 	default_trap_handler(regs);
 }
+
+void do_secure_storage_violation(struct pt_regs *regs)
+{
+	default_trap_handler(regs);
+}
 #endif
-- 
2.25.1
