Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C036C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D4C60F3A
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 13:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbhJLNlH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:41:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51054 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237016AbhJLNlG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 09:41:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19CDWFVQ026937;
        Tue, 12 Oct 2021 09:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K0T1ManLtfk+fx5MZtziC2l19/dCqzjItx9MzuGLJdM=;
 b=VRaxNCflIX4zM8iLtffXYUGDhmN0ZoJoL0kdvYi0wlzR/PNpVLNfbOLPNGIBo6Hfs/Qn
 7dqGdxYxLyZkcU0hS9mRuOIsoOTHEV5nkD+sXdrrEIey+6B2LBSNLTLZW8TkUbHqRbtz
 Iglb71WdieaSwHbA9Z25Njt6I0curXHmmBQe+vE+N0rBA4WgJjmWcdprPcCnrcTBstL2
 3cOc6nhYXztdHDHL1VAxll/yeducHGhUndmu86+YIv1UwV68KYv+MuTIDBSfzkiaiEBU
 HuDPIhINmazlNLpDmRthybLS/bxPVBXhRyKRY6JREwfkJOcvy25wQxP6IKB3WS04Bp4f Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn998ucf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:30 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19CBDPHl030610;
        Tue, 12 Oct 2021 09:38:30 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bn998uce1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 09:38:29 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19CDRPTa011580;
        Tue, 12 Oct 2021 13:38:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3bk2bjfmsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:38:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19CDWf4E27721998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 13:32:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A820611C06C;
        Tue, 12 Oct 2021 13:38:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8EBD11C058;
        Tue, 12 Oct 2021 13:38:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Oct 2021 13:38:09 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/4] s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Date:   Tue, 12 Oct 2021 15:37:59 +0200
Message-Id: <20211012133802.2460757-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012133802.2460757-1-hca@linux.ibm.com>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9wUq_F27LWkuDYG3nfpX0qL9ommdkVQD
X-Proofpoint-ORIG-GUID: 1CMld5QjXa7HjtSTWZPzZNsNqhrsNOme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_03,2021-10-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is the s390 variant of commit 562955fe6a55 ("ftrace/x86: Add
register_ftrace_direct() for custom trampolines").

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig              |  1 +
 arch/s390/include/asm/ftrace.h | 12 ++++++++++++
 arch/s390/kernel/mcount.S      | 23 +++++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 87b71b91e5c9..908da6f1aa0d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -153,6 +153,7 @@ config S390
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 4a721b44d4f4..267f70f4393f 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -58,6 +58,18 @@ static __always_inline void ftrace_instruction_pointer_set(struct ftrace_regs *f
 	regs->psw.addr = ip;
 }
 
+/*
+ * When an ftrace registered caller is tracing a function that is
+ * also set by a register_ftrace_direct() call, it needs to be
+ * differentiated in the ftrace_caller trampoline. To do this,
+ * place the direct caller in the ORIG_GPR2 part of pt_regs. This
+ * tells the ftrace_caller that there's a direct caller.
+ */
+static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+	regs->orig_gpr2 = addr;
+}
+
 /*
  * Even though the system call numbers are identical for s390/s390x a
  * different system call table is used for compat tasks. This may lead
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index cc25fbd75ea9..39bcc0e39a10 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -22,10 +22,11 @@ ENTRY(ftrace_stub)
 	BR_EX	%r14
 ENDPROC(ftrace_stub)
 
-#define STACK_FRAME_SIZE  (STACK_FRAME_OVERHEAD + __PT_SIZE)
-#define STACK_PTREGS	  (STACK_FRAME_OVERHEAD)
-#define STACK_PTREGS_GPRS (STACK_PTREGS + __PT_GPRS)
-#define STACK_PTREGS_PSW  (STACK_PTREGS + __PT_PSW)
+#define STACK_FRAME_SIZE	(STACK_FRAME_OVERHEAD + __PT_SIZE)
+#define STACK_PTREGS		(STACK_FRAME_OVERHEAD)
+#define STACK_PTREGS_GPRS	(STACK_PTREGS + __PT_GPRS)
+#define STACK_PTREGS_PSW	(STACK_PTREGS + __PT_PSW)
+#define STACK_PTREGS_ORIG_GPR2	(STACK_PTREGS + __PT_ORIG_GPR2)
 #ifdef __PACK_STACK
 /* allocate just enough for r14, r15 and backchain */
 #define TRACED_FUNC_FRAME_SIZE	24
@@ -51,6 +52,7 @@ ENDPROC(ftrace_stub)
 	# allocate pt_regs and stack frame for ftrace_trace_function
 	aghi	%r15,-STACK_FRAME_SIZE
 	stg	%r1,(STACK_PTREGS_GPRS+15*8)(%r15)
+	xc	STACK_PTREGS_ORIG_GPR2(8,%r15),STACK_PTREGS_ORIG_GPR2(%r15)
 
 	.if \allregs == 1
 	stg	%r14,(STACK_PTREGS_PSW)(%r15)
@@ -101,8 +103,17 @@ SYM_INNER_LABEL(ftrace_graph_caller, SYM_L_GLOBAL)
 	stg	%r2,(STACK_PTREGS_GPRS+14*8)(%r15)
 .Lftrace_graph_caller_end:
 #endif
-	lg	%r1,(STACK_PTREGS_PSW+8)(%r15)
-	lmg	%r2,%r15,(STACK_PTREGS_GPRS+2*8)(%r15)
+	lg	%r0,(STACK_PTREGS_PSW+8)(%r15)
+#ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
+	ltg	%r1,STACK_PTREGS_ORIG_GPR2(%r15)
+	locgrz	%r1,%r0
+#else
+	lg	%r1,STACK_PTREGS_ORIG_GPR2(%r15)
+	ltgr	%r1,%r1
+	jnz	0f
+	lgr	%r1,%r0
+#endif
+0:	lmg	%r2,%r15,(STACK_PTREGS_GPRS+2*8)(%r15)
 	BR_EX	%r1
 SYM_CODE_END(ftrace_common)
 
-- 
2.25.1

