Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04663C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76A9610C9
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhJLNlK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:41:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49138 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236994AbhJLNlH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 09:41:07 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CC1jl7006720;
        Tue, 12 Oct 2021 09:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JdF3PyMzHVdIeottPX4XsVKf2P4Vtqm36fHzXHbLZ2I=;
 b=nsHqwGFUAXiGfk6Bnb9TN3dRtLfMZHg0IjyKiL/uVdrwkzWRINSbynvgyMckzucdiNva
 qWcSlesN7W8daKYcy3YnjG63lDmtP4xTg6Ft2nD2Cx/vVm+GRaJnpXjIMSKS3Cjqdk2l
 V8/yfbfok/ap/LHDKKUZelrbufm/2Coh0mtUGPp3PwwYvd+pVdfCZwzzc7t1T1S7Dz/S
 VCCXSFBkG47WvsyC3GSMR7uSFuyvdTWJpkku2AXe4NbdS4vkWx1yLf0K6wgmweZEl3Qv
 4LSPZ1no8YO06NDWUPPlGVWVpRaF7iheHqTcbuzc2wiu6Li2Rii9G4tgBzPw0OlQeoVc 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bna0rtd2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:48 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CD8SGP014554;
        Tue, 12 Oct 2021 09:38:47 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bna0rtd1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:47 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CDRPQF011096;
        Tue, 12 Oct 2021 13:38:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3bk2qa151g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:38:45 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CDcVhU50332016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 13:38:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2995E11C066;
        Tue, 12 Oct 2021 13:38:31 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A2611C087;
        Tue, 12 Oct 2021 13:38:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 13:38:26 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 4/4] samples: add s390 support for ftrace direct call samples
Date:   Tue, 12 Oct 2021 15:38:02 +0200
Message-Id: <20211012133802.2460757-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012133802.2460757-1-hca@linux.ibm.com>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EOpDuwseaqhNSeSviLHUuwraEFUdooCT
X-Proofpoint-ORIG-GUID: VGKo3ZNbINLaLcvI1BouYa0X31q80pRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add s390 support for ftrace direct call samples, which also enables
ftrace direct call selftests within ftrace selftests.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                     |  1 +
 samples/ftrace/ftrace-direct-modify.c | 44 +++++++++++++++++++++++++++
 samples/ftrace/ftrace-direct-too.c    | 28 +++++++++++++++++
 samples/ftrace/ftrace-direct.c        | 28 +++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 908da6f1aa0d..f615c3f65f5a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -192,6 +192,7 @@ config S390
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 5b9a09957c6e..690e4a9ff333 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include <asm/asm-offsets.h>
 
 void my_direct_func1(void)
 {
@@ -18,6 +19,8 @@ extern void my_tramp2(void *);
 
 static unsigned long my_ip = (unsigned long)schedule;
 
+#ifdef CONFIG_X86_64
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
@@ -41,6 +44,47 @@ asm (
 "	.popsection\n"
 );
 
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	lgr		%r1,%r15\n"
+"	stmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	stg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	aghi		%r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"	stg		%r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"	brasl		%r14,my_direct_func1\n"
+"	aghi		%r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"	lmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	lg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	lgr		%r1,%r0\n"
+"	br		%r1\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	lgr		%r1,%r15\n"
+"	stmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	stg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	aghi		%r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"	stg		%r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"	brasl		%r14,my_direct_func2\n"
+"	aghi		%r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"	lmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	lg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	lgr		%r1,%r0\n"
+"	br		%r1\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_S390 */
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 3f0079c9bd6f..6e0de725bf22 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include <asm/asm-offsets.h>
 
 void my_direct_func(struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
@@ -13,6 +14,8 @@ void my_direct_func(struct vm_area_struct *vma,
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_X86_64
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
@@ -33,6 +36,31 @@ asm (
 "	.popsection\n"
 );
 
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	lgr		%r1,%r15\n"
+"	stmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	stg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	aghi		%r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"	stg		%r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"	brasl		%r14,my_direct_func\n"
+"	aghi		%r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"	lmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	lg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	lgr		%r1,%r0\n"
+"	br		%r1\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_S390 */
 
 static int __init ftrace_direct_init(void)
 {
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index a2729d1ef17f..a30aa42ec76a 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#include <asm/asm-offsets.h>
 
 void my_direct_func(struct task_struct *p)
 {
@@ -11,6 +12,8 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_X86_64
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
@@ -27,6 +30,31 @@ asm (
 "	.popsection\n"
 );
 
+#endif /* CONFIG_X86_64 */
+
+#ifdef CONFIG_S390
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	lgr		%r1,%r15\n"
+"	stmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	stg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	aghi		%r15,"__stringify(-STACK_FRAME_OVERHEAD)"\n"
+"	stg		%r1,"__stringify(__SF_BACKCHAIN)"(%r15)\n"
+"	brasl		%r14,my_direct_func\n"
+"	aghi		%r15,"__stringify(STACK_FRAME_OVERHEAD)"\n"
+"	lmg		%r0,%r5,"__stringify(__SF_GPRS)"(%r15)\n"
+"	lg		%r14,"__stringify(__SF_GPRS+8*8)"(%r15)\n"
+"	lgr		%r1,%r0\n"
+"	br		%r1\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_S390 */
 
 static int __init ftrace_direct_init(void)
 {
-- 
2.25.1

