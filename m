Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADBBC49EA6
	for <linux-s390@archiver.kernel.org>; Sat, 26 Jun 2021 12:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6169A6198D
	for <linux-s390@archiver.kernel.org>; Sat, 26 Jun 2021 12:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhFZMTQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 26 Jun 2021 08:19:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35582 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhFZMTQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 26 Jun 2021 08:19:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15QC3r6j194927;
        Sat, 26 Jun 2021 08:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=+iHJ0gO2gZVxl9dnU2tCTxtUS9+IXL1VspTpXvSJzHU=;
 b=FHfMu9cw3goGsZTNc9Clz36EuIVNFl/R6Uw0DRG90hll8y/ZPpxL1m+gum8yetcmTlqE
 7CHSWQjI9K2nsmeMLYf7s2SZGe5BAmaRi3qKD2nsUgVldz8Uu69j7393/7pZEXL5/OOB
 5/s1OKeyUHPhUzoQ4nWkz9OxVgnhL3nrZ3KTG/YEqHgXaZ2jetNVepvP3WwsCPA0MQmU
 hAD1ERDbmJTRY7bEPzgnXTi1X0Ld2mBhHjDSpqO3cSUqp6RP/06Y8nUKxUuPHWbcxfnF
 fcY+4I6hoZ0CGQzLd0yN4GgNl5l3Vx4Bg88eYVLNvbdSzdmodWcGF2M00w2HNO+FJxK0 Zw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39e1frvbrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Jun 2021 08:16:53 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15QC9ASs010725;
        Sat, 26 Jun 2021 12:16:51 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 39duv8823s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Jun 2021 12:16:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15QCGmGC33161534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Jun 2021 12:16:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D935AE051;
        Sat, 26 Jun 2021 12:16:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D45B1AE04D;
        Sat, 26 Jun 2021 12:16:47 +0000 (GMT)
Received: from localhost (unknown [9.171.68.59])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 26 Jun 2021 12:16:47 +0000 (GMT)
Date:   Sat, 26 Jun 2021 14:16:46 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 5.13-rc8
Message-ID: <your-ad-here.call-01624709806-ext-4573@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AybLx7clQQLX53e3Wt0AZjlGyo8ntIZk
X-Proofpoint-ORIG-GUID: AybLx7clQQLX53e3Wt0AZjlGyo8ntIZk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-26_06:2021-06-25,2021-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106260081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Linus,

please pull s390 fixes for 5.13-rc8.

Thank you,
Vasily

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-5

for you to fetch changes up to 67147e96a332b56c7206238162771d82467f86c0:

  s390/stack: fix possible register corruption with stack switch helper (2021-06-21 11:19:18 +0200)

----------------------------------------------------------------
- Fix couple of late pt_regs flags handling findings of conversion to
  generic entry.

- Fix potential register clobbering in stack switch helper.

- Fix thread/group masks for offline cpus.

- Fix cleanup of mdev resources when remove callback is invoked in vfio-ap
  code.

----------------------------------------------------------------
Heiko Carstens (1):
      s390/stack: fix possible register corruption with stack switch helper

Sven Schnelle (3):
      s390: fix system call restart with multiple signals
      s390: clear pt_regs::flags on irq entry
      s390/topology: clear thread/group maps for offline cpus

Tony Krowiak (1):
      s390/vfio-ap: clean up mdev resources when remove callback invoked

 arch/s390/include/asm/stacktrace.h | 18 +++++++++++-------
 arch/s390/kernel/entry.S           |  1 +
 arch/s390/kernel/signal.c          |  1 -
 arch/s390/kernel/topology.c        | 12 +++++++++---
 drivers/s390/crypto/vfio_ap_ops.c  | 10 ----------
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 2b543163d90a..76c6034428be 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -91,12 +91,16 @@ struct stack_frame {
 	CALL_ARGS_4(arg1, arg2, arg3, arg4);				\
 	register unsigned long r4 asm("6") = (unsigned long)(arg5)
 
-#define CALL_FMT_0 "=&d" (r2) :
-#define CALL_FMT_1 "+&d" (r2) :
-#define CALL_FMT_2 CALL_FMT_1 "d" (r3),
-#define CALL_FMT_3 CALL_FMT_2 "d" (r4),
-#define CALL_FMT_4 CALL_FMT_3 "d" (r5),
-#define CALL_FMT_5 CALL_FMT_4 "d" (r6),
+/*
+ * To keep this simple mark register 2-6 as being changed (volatile)
+ * by the called function, even though register 6 is saved/nonvolatile.
+ */
+#define CALL_FMT_0 "=&d" (r2)
+#define CALL_FMT_1 "+&d" (r2)
+#define CALL_FMT_2 CALL_FMT_1, "+&d" (r3)
+#define CALL_FMT_3 CALL_FMT_2, "+&d" (r4)
+#define CALL_FMT_4 CALL_FMT_3, "+&d" (r5)
+#define CALL_FMT_5 CALL_FMT_4, "+&d" (r6)
 
 #define CALL_CLOBBER_5 "0", "1", "14", "cc", "memory"
 #define CALL_CLOBBER_4 CALL_CLOBBER_5
@@ -118,7 +122,7 @@ struct stack_frame {
 		"	brasl	14,%[_fn]\n"				\
 		"	la	15,0(%[_prev])\n"			\
 		: [_prev] "=&a" (prev), CALL_FMT_##nr			\
-		  [_stack] "R" (stack),					\
+		: [_stack] "R" (stack),					\
 		  [_bc] "i" (offsetof(struct stack_frame, back_chain)),	\
 		  [_frame] "d" (frame),					\
 		  [_fn] "X" (fn) : CALL_CLOBBER_##nr);			\
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 9cc71ca9a88f..e84f495e7eb2 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -418,6 +418,7 @@ ENTRY(\name)
 	xgr	%r6,%r6
 	xgr	%r7,%r7
 	xgr	%r10,%r10
+	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	tm	%r8,0x0001		# coming from user space?
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 90163e6184f5..080e7aed181f 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -512,7 +512,6 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 
 	/* No handlers present - check for system call restart */
 	clear_pt_regs_flag(regs, PIF_SYSCALL);
-	clear_pt_regs_flag(regs, PIF_SYSCALL_RESTART);
 	if (current->thread.system_call) {
 		regs->int_code = current->thread.system_call;
 		switch (regs->gprs[2]) {
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index bfcc327acc6b..26aa2614ee35 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -66,7 +66,10 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 {
 	static cpumask_t mask;
 
-	cpumask_copy(&mask, cpumask_of(cpu));
+	cpumask_clear(&mask);
+	if (!cpu_online(cpu))
+		goto out;
+	cpumask_set_cpu(cpu, &mask);
 	switch (topology_mode) {
 	case TOPOLOGY_MODE_HW:
 		while (info) {
@@ -83,10 +86,10 @@ static void cpu_group_map(cpumask_t *dst, struct mask_info *info, unsigned int c
 	default:
 		fallthrough;
 	case TOPOLOGY_MODE_SINGLE:
-		cpumask_copy(&mask, cpumask_of(cpu));
 		break;
 	}
 	cpumask_and(&mask, &mask, cpu_online_mask);
+out:
 	cpumask_copy(dst, &mask);
 }
 
@@ -95,7 +98,10 @@ static void cpu_thread_map(cpumask_t *dst, unsigned int cpu)
 	static cpumask_t mask;
 	int i;
 
-	cpumask_copy(&mask, cpumask_of(cpu));
+	cpumask_clear(&mask);
+	if (!cpu_online(cpu))
+		goto out;
+	cpumask_set_cpu(cpu, &mask);
 	if (topology_mode != TOPOLOGY_MODE_HW)
 		goto out;
 	cpu -= cpu % (smp_cpu_mtid + 1);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index b2c7e10dfdcd..122c85c22469 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -366,16 +366,6 @@ static int vfio_ap_mdev_remove(struct mdev_device *mdev)
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
 
 	mutex_lock(&matrix_dev->lock);
-
-	/*
-	 * If the KVM pointer is in flux or the guest is running, disallow
-	 * un-assignment of control domain.
-	 */
-	if (matrix_mdev->kvm_busy || matrix_mdev->kvm) {
-		mutex_unlock(&matrix_dev->lock);
-		return -EBUSY;
-	}
-
 	vfio_ap_mdev_reset_queues(mdev);
 	list_del(&matrix_mdev->node);
 	kfree(matrix_mdev);
