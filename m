Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67313C432BE
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 14:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48CB160F21
	for <linux-s390@archiver.kernel.org>; Wed,  1 Sep 2021 14:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbhIAOHT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 1 Sep 2021 10:07:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244136AbhIAOHS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Sep 2021 10:07:18 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 181E4OJE055077;
        Wed, 1 Sep 2021 10:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Q8g9oUFhXBKWyakPDka0bj0QPytnDIcQr8xFgIfNqZw=;
 b=OjfHcMPmaYKJZ/8O+5y4/29OKIID+QjUgViRX3J9LRXGTpCMc+VQUOZjgFPbOFTCwfwA
 IIg+T4KJ8mdBYzW6wZgVRfS2JwqzdcPgwM9DSeKcKboRWyiFoGAof6+sJnJ8onWd3r4V
 QKwWdvg/hK60Qhu0TaTJIytmbwCfkW8KwEJbfnwpdzzTico9rgMNKS931jxQlDC8mPxB
 CqMSreXYTawc5FfnBfzlI4ebzmTfq2dTEJqDdWVakSvsY2BGis43jv7H33MKOAqDmN9R
 QXu+f/gUM9qXvTzmBSeK77qY6OSAXMwDj3CF2H1KHIpMu940bHTmQZqkjB30MzkIMqEf GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at7tkx108-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 10:06:10 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181E5wvN064390;
        Wed, 1 Sep 2021 10:06:09 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3at7tkx0xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 10:06:09 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181E38Lv004630;
        Wed, 1 Sep 2021 14:06:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3aqcs9ad3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 14:06:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 181E23Hb54591814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 14:02:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACB07A4040;
        Wed,  1 Sep 2021 14:06:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A550FA4057;
        Wed,  1 Sep 2021 14:06:01 +0000 (GMT)
Received: from localhost (unknown [9.171.90.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Sep 2021 14:06:01 +0000 (GMT)
Date:   Wed, 1 Sep 2021 16:05:59 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Marco Elver <elver@google.com>, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, qemu-s390x <qemu-s390x@nongnu.org>
Subject: [PATCH] s390/unwind: use current_frame_address() to unwind current
 task
Message-ID: <patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours>
References: <your-ad-here.call-01630505035-ext-2999@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01630505035-ext-2999@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LgNjbPh1LHt0botEu7dDzn-ePANPkbcB
X-Proofpoint-ORIG-GUID: -sRqof_5nzDHJhVxWUU-YWkrKxsQ1vSR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-01_04:2021-09-01,2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2109010084
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

current_stack_pointer() simply returns current value of %r15. If
current_stack_pointer() caller allocates stack (which is the case in
unwind code) %r15 points to a stack frame allocated for callees, meaning
current_stack_pointer() caller (e.g. stack_trace_save) will end up in
the stacktrace. This is not expected by stack_trace_save*() callers and
causes problems.

current_frame_address() on the other hand returns function stack frame
address, which matches %r15 upon function invocation. Using it in
get_stack_pointer() makes it more aligned with x86 implementation
(according to BACKTRACE_SELF_TEST output) and meets stack_trace_save*()
caller's expectations, notably KCSAN.

Also make sure unwind_start is always inlined.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/include/asm/stacktrace.h | 20 ++++++++++----------
 arch/s390/include/asm/unwind.h     |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 3d8a4b94c620..22c41d7fd95c 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -34,16 +34,6 @@ static inline bool on_stack(struct stack_info *info,
 	return addr >= info->begin && addr + len <= info->end;
 }
 
-static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
-						       struct pt_regs *regs)
-{
-	if (regs)
-		return (unsigned long) kernel_stack_pointer(regs);
-	if (task == current)
-		return current_stack_pointer();
-	return (unsigned long) task->thread.ksp;
-}
-
 /*
  * Stack layout of a C stack frame.
  */
@@ -74,6 +64,16 @@ struct stack_frame {
 	((unsigned long)__builtin_frame_address(0) -			\
 	 offsetof(struct stack_frame, back_chain))
 
+static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
+						       struct pt_regs *regs)
+{
+	if (regs)
+		return (unsigned long) kernel_stack_pointer(regs);
+	if (task == current)
+		return current_frame_address();
+	return (unsigned long) task->thread.ksp;
+}
+
 /*
  * To keep this simple mark register 2-6 as being changed (volatile)
  * by the called function, even though register 6 is saved/nonvolatile.
diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
index de9006b0cfeb..5ebf534ef753 100644
--- a/arch/s390/include/asm/unwind.h
+++ b/arch/s390/include/asm/unwind.h
@@ -55,10 +55,10 @@ static inline bool unwind_error(struct unwind_state *state)
 	return state->error;
 }
 
-static inline void unwind_start(struct unwind_state *state,
-				struct task_struct *task,
-				struct pt_regs *regs,
-				unsigned long first_frame)
+static __always_inline void unwind_start(struct unwind_state *state,
+					 struct task_struct *task,
+					 struct pt_regs *regs,
+					 unsigned long first_frame)
 {
 	task = task ?: current;
 	first_frame = first_frame ?: get_stack_pointer(task, regs);
-- 
2.25.4
