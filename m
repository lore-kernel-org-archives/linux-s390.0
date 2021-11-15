Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD4CC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 15 Nov 2021 21:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1833161ABA
	for <linux-s390@archiver.kernel.org>; Mon, 15 Nov 2021 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbhKOVGS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 15 Nov 2021 16:06:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348799AbhKOUAG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Nov 2021 15:00:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFHHnvK025868;
        Mon, 15 Nov 2021 19:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sO1Oi5VKUJ0bxyafdJWHQkTX+khJK29yvVkG9bhm6bI=;
 b=mqNS5De7hI0AkrsPuLpdTf+pjytSK5NosYslR+8gcQecCLsYHfEqsX8S9tsN8YPBJPhA
 g+aWV0KxYbP0lIvP4t3ck+8v1NPKRW2bYVWtVxLrhJedQjTwLftNf7RINgerxfJARi0Q
 /ia4HDaTzpYyDlqLRdYxnZecpgwgeN5KHUr83pQMm6N1x6yuoWIyyTbA5Bmg8uwk733e
 F18FkGehBd457+lBbNi7RCOp1YaHHPVplzoRdNmC2icbaFsmtvUP8QEiEzwDqqFcV8mi
 reFugYBktfpBJ2rW6xssJLGa+Ro8ot1iWUF1dykP9xtlKJLMRSkJVPJtZCSMLBUU/Bv1 tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cbutwk2n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:54 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AFJefHO011349;
        Mon, 15 Nov 2021 19:56:54 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cbutwk2mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:54 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AFJrltZ008010;
        Mon, 15 Nov 2021 19:56:52 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ca509s6n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 19:56:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AFJuop312452294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 19:56:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FB3B4C046;
        Mon, 15 Nov 2021 19:56:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BB0E4C040;
        Mon, 15 Nov 2021 19:56:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Nov 2021 19:56:50 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/2] ftrace/samples: add s390 support for ftrace direct multi sample
Date:   Mon, 15 Nov 2021 20:56:14 +0100
Message-Id: <20211115195614.3173346-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115195614.3173346-1-hca@linux.ibm.com>
References: <20211115195614.3173346-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LBpWFVaP42Ljkxkd8plmu-R-6RnG9x-u
X-Proofpoint-ORIG-GUID: ofOwwGrS6wKckpb2etCK26eyxYZvAMEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_15,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                    |  1 +
 samples/ftrace/ftrace-direct-multi.c | 30 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8857ec3b97eb..1462b8182425 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -194,6 +194,7 @@ config S390
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
 	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index b6d7806b400e..2fafc9afcbf0 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
+#include <asm/asm-offsets.h>
 
 extern void my_direct_func(unsigned long ip);
 
@@ -14,6 +15,8 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_X86_64
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
@@ -31,6 +34,33 @@ asm (
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
+"	lgr		%r2,%r0\n"
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
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_multi_init(void)
-- 
2.25.1

