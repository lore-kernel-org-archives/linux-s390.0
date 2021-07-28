Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D25C4320A
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 21:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E3260238
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 21:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhG1V0a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:26:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231519AbhG1V03 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 17:26:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SK9ros114894;
        Wed, 28 Jul 2021 17:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lTQA1G455S3S7/UbaTHLrx8l6pQJVqrPI4OUUJMUnv4=;
 b=rd5ayHjOGFqwZcsZyClFlshopwMw8YxWeevSGwlYLxIlfUAuzF6FFbErNMXvrBTtt0C8
 TXRrk1jzyqj3wGgh6FRWm8ScNX8PtQGlBZhAwJzIhSRJiXWNrcrUbEtnKLFXw7Nt4/0i
 R5DQ9N0eKTBhl3Nvq8KN9jv4LaPL0+mQq501GsiHwkzbeC6dC/75RqKenhYNISqtUJNm
 KyQW0KDh11/gITkJC/l4NtigOTrDP8nmfIJ5DjuGmSqApE00iXEKTKvj79rEgd4qJgW/
 5w19fuUwabh4N393TX7IRiZ6y19Iv0vIZqBoQLnGpfEWIlP6H8ClPhiW+z4wi+vOxWR1 DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3970t9nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 17:26:01 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SKGWmx149064;
        Wed, 28 Jul 2021 17:26:00 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a3970t9n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 17:26:00 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SJo5db010087;
        Wed, 28 Jul 2021 21:25:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3a235m1a3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 21:25:58 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SLPt6Z24510868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 21:25:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF84AE057;
        Wed, 28 Jul 2021 21:25:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C22AAE045;
        Wed, 28 Jul 2021 21:25:55 +0000 (GMT)
Received: from vm.lan (unknown [9.145.77.113])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 21:25:55 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/2] ftrace: Introduce ftrace_need_init_nop()
Date:   Wed, 28 Jul 2021 23:25:45 +0200
Message-Id: <20210728212546.128248-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210728212546.128248-1-iii@linux.ibm.com>
References: <20210728212546.128248-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4H6YnvIV8U5ZK8s8HaUBHT8TpYDmVQ0P
X-Proofpoint-ORIG-GUID: l1xqRmQLSmwZLK6KInKr9z3mPlclVn6D
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_10:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280113
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Implementing live patching on s390 requires each function's prologue to
contain a very special kind of nop, which gcc and clang don't generate.
However, the current code assumes that if CC_USING_NOP_MCOUNT is
defined, then whatever the compiler generates is good enough.

Move the CC_USING_NOP_MCOUNT check into the new ftrace_need_init_nop()
macro, that the architectures can override.

An alternative solution is to disable using -mnop-mcount in the
Makefile, however, this makes the build logic (even) more complicated
and forces the arch-specific code to deal with the useless __fentry__
symbol.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/linux/ftrace.h | 16 ++++++++++++++++
 kernel/trace/ftrace.c  |  4 ++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a69f363b61bf..f1ea8988a045 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -643,6 +643,22 @@ static inline int ftrace_disable_ftrace_graph_caller(void) { return 0; }
 extern int ftrace_make_nop(struct module *mod,
 			   struct dyn_ftrace *rec, unsigned long addr);
 
+/**
+ * ftrace_need_init_nop - return whether nop call sites should be initialized
+ *
+ * Normally the compiler's -mnop-mcount generates suitable nops, so we don't
+ * need to call ftrace_init_nop() if the code is built with that flag.
+ * Architectures where this is not always the case may define their own
+ * condition.
+ *
+ * Return must be:
+ *  0       if ftrace_init_nop() should be called
+ *  Nonzero if ftrace_init_nop() should not be called
+ */
+
+#ifndef ftrace_need_init_nop
+#define ftrace_need_init_nop() (!__is_defined(CC_USING_NOP_MCOUNT))
+#endif
 
 /**
  * ftrace_init_nop - initialize a nop call site
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7b180f61e6d3..7efbc8aaf7f6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3100,6 +3100,7 @@ ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 
 static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 {
+	bool init_nop = ftrace_need_init_nop();
 	struct ftrace_page *pg;
 	struct dyn_ftrace *p;
 	u64 start, stop;
@@ -3138,8 +3139,7 @@ static int ftrace_update_code(struct module *mod, struct ftrace_page *new_pgs)
 			 * Do the initial record conversion from mcount jump
 			 * to the NOP instructions.
 			 */
-			if (!__is_defined(CC_USING_NOP_MCOUNT) &&
-			    !ftrace_nop_initialize(mod, p))
+			if (init_nop && !ftrace_nop_initialize(mod, p))
 				break;
 
 			update_cnt++;
-- 
2.31.1

