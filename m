Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E594C43461
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2246102A
	for <linux-s390@archiver.kernel.org>; Thu,  8 Apr 2021 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhDHRrK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:47:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232202AbhDHRrK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Apr 2021 13:47:10 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138HYDOF067773;
        Thu, 8 Apr 2021 13:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=meKz8RWXyTqkUGvEWHnyHHb2dq7BOg1IXldYaEAy0q8=;
 b=LYsd7Mtm4r23hDy+8mdLp/SNLGADdBJc7Z3gGuh9ZlN2x7QXJGmWK/jW2olZxgv2kvs2
 gcRJvvDxQ/VLIslK4kuh3uekGAzDiU2CfWchLBkJe1wz99hf8nluwHD5uVcNZoZtcwsb
 0etF9kXobjdhhSbOtSQJeBOs2QsTHbJZQy1BJJqCI55Kw7/jgfZOjpTALryzu2Ezjt5v
 RZkIk364cNi2vVUNmlcZA0IZLDDSz3ARVLTFpHtlZNeO6AqsU+WHSp60v3+ZKcaY8/Ps
 7jr2m364JsNeO2Thqj1rXsycNlWlTkcJJZKN03a+0Wn/vHjvw46y3iC3vMuCTlChBUJk FQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37rvup0xr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 13:46:57 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138Hh5s1019871;
        Thu, 8 Apr 2021 17:46:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 37rvmq8y33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 17:46:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 138HkqTT33685966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 17:46:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B6C552075;
        Thu,  8 Apr 2021 17:46:52 +0000 (GMT)
Received: from osiris (unknown [9.171.26.226])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 3E4B552067;
        Thu,  8 Apr 2021 17:46:52 +0000 (GMT)
Date:   Thu, 8 Apr 2021 19:46:51 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.12-rc7
Message-ID: <YG9Bi8VS59wzWYXV@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r6ioRla1s3JwVJUaEtGsMf1JsyvQsxrr
X-Proofpoint-ORIG-GUID: r6ioRla1s3JwVJUaEtGsMf1JsyvQsxrr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_04:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=941 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080117
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Linus,

please pull a couple of s390 fixes for 5.12-rc7.

Thank you,
Heiko

The following changes since commit 84d572e634e28827d105746c922d8ada425e2d8b:

  MAINTAINERS: add backups for s390 vfio drivers (2021-03-28 20:20:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-6

for you to fetch changes up to ad31a8c05196a3dc5283b193e9c74a72022d3c65:

  s390/setup: use memblock_free_late() to free old stack (2021-04-07 14:37:28 +0200)

----------------------------------------------------------------
s390 updates for 5.12-rc7

- fix incorrect dereference of the ext_params2 external interrupt parameter,
  which leads to an instant kernel crash if a pfault interrupt occurs.

- add forgotten stack unwinder support, and fix memory leak for the new
  machine check handler stack.

- fix inline assembly register clobbering due to KASAN code instrumentation.

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/cpcmd: fix inline assembly register clobbering

Heiko Carstens (2):
      s390/irq: fix reading of ext_params2 field from lowcore
      s390/setup: use memblock_free_late() to free old stack

Vasily Gorbik (1):
      s390/unwind: add machine check handler stack

 arch/s390/include/asm/stacktrace.h |  1 +
 arch/s390/kernel/cpcmd.c           |  6 ++++--
 arch/s390/kernel/dumpstack.c       | 12 +++++++++++-
 arch/s390/kernel/irq.c             |  2 +-
 arch/s390/kernel/setup.c           |  2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index ee056f4a4fa3..2b543163d90a 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -12,6 +12,7 @@ enum stack_type {
 	STACK_TYPE_IRQ,
 	STACK_TYPE_NODAT,
 	STACK_TYPE_RESTART,
+	STACK_TYPE_MCCK,
 };
 
 struct stack_info {
diff --git a/arch/s390/kernel/cpcmd.c b/arch/s390/kernel/cpcmd.c
index af013b4244d3..2da027359798 100644
--- a/arch/s390/kernel/cpcmd.c
+++ b/arch/s390/kernel/cpcmd.c
@@ -37,10 +37,12 @@ static int diag8_noresponse(int cmdlen)
 
 static int diag8_response(int cmdlen, char *response, int *rlen)
 {
+	unsigned long _cmdlen = cmdlen | 0x40000000L;
+	unsigned long _rlen = *rlen;
 	register unsigned long reg2 asm ("2") = (addr_t) cpcmd_buf;
 	register unsigned long reg3 asm ("3") = (addr_t) response;
-	register unsigned long reg4 asm ("4") = cmdlen | 0x40000000L;
-	register unsigned long reg5 asm ("5") = *rlen;
+	register unsigned long reg4 asm ("4") = _cmdlen;
+	register unsigned long reg5 asm ("5") = _rlen;
 
 	asm volatile(
 		"	diag	%2,%0,0x8\n"
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 0dc4b258b98d..db1bc00229ca 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -79,6 +79,15 @@ static bool in_nodat_stack(unsigned long sp, struct stack_info *info)
 	return in_stack(sp, info, STACK_TYPE_NODAT, top - THREAD_SIZE, top);
 }
 
+static bool in_mcck_stack(unsigned long sp, struct stack_info *info)
+{
+	unsigned long frame_size, top;
+
+	frame_size = STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
+	top = S390_lowcore.mcck_stack + frame_size;
+	return in_stack(sp, info, STACK_TYPE_MCCK, top - THREAD_SIZE, top);
+}
+
 static bool in_restart_stack(unsigned long sp, struct stack_info *info)
 {
 	unsigned long frame_size, top;
@@ -108,7 +117,8 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	/* Check per-cpu stacks */
 	if (!in_irq_stack(sp, info) &&
 	    !in_nodat_stack(sp, info) &&
-	    !in_restart_stack(sp, info))
+	    !in_restart_stack(sp, info) &&
+	    !in_mcck_stack(sp, info))
 		goto unknown;
 
 recursion_check:
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 601c21791338..714269e10eec 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -174,7 +174,7 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 
 	memcpy(&regs->int_code, &S390_lowcore.ext_cpu_addr, 4);
 	regs->int_parm = S390_lowcore.ext_params;
-	regs->int_parm_long = *(unsigned long *)S390_lowcore.ext_params2;
+	regs->int_parm_long = S390_lowcore.ext_params2;
 
 	from_idle = !user_mode(regs) && regs->psw.addr == (unsigned long)psw_idle_exit;
 	if (from_idle)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 60da976eee6f..72134f9f6ff5 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -354,7 +354,7 @@ static int __init stack_realloc(void)
 	if (!new)
 		panic("Couldn't allocate machine check stack");
 	WRITE_ONCE(S390_lowcore.mcck_stack, new + STACK_INIT_OFFSET);
-	memblock_free(old, THREAD_SIZE);
+	memblock_free_late(old, THREAD_SIZE);
 	return 0;
 }
 early_initcall(stack_realloc);
