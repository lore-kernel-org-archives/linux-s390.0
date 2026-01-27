Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAA35CB9A;
	Tue, 27 Jan 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528043; cv=none; b=pkWyQ6FseYvnWq9OZVJPOf+ddUQc5RxktjWP0U1059/Il4hSbuTW9dTyOo1YeNlQszWz/VmYCm2wO3GoRnBkANjqcTlGrPzURcpDGX6qVsV0OAIBz0ZfUj2ojJomVHe+bmdMpsZdVRWbhMcnBVqoaCuZq72vV9sjAvyFfaUUS4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528043; c=relaxed/simple;
	bh=9DLKdTXoFCuhtc89mZMGllNE0yoAFFhZ91M2fyML8lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzpIOw1IAZyPB3mXgAbKtB5mYwde+dFKvz/6FQ13GNrec1eanp1hvRJ3f5jWmVfziIAagRzDecjw6MHz9ckTT+8GD7bCvdNTq2Wqzyte2ovdVvi9nyJjZV+JUL+VMcvdQn1N50sI+90JwvccEFq+zGoisN5E96+liCIWiTUs9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=izXTh/Qc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="izXTh/Qc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R4dY1S032521;
	Tue, 27 Jan 2026 15:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hwRBNCHKaC4Z+b+Og
	bDactYuIMHhkLAQK6b65sb5zKo=; b=izXTh/QcsYomxXLC4BtdhecoibANGmhkA
	C+6PKlpGI+DQ2EGGRQkGSG1oEUvflg6u2xhYk+Q675l6NyYIxdLV7hZ48w0J95Kv
	yEPo2yW3UsovnDXaA8+EA/7coLEn5VT1IT6LF30XWa7+7tg/zks1gJyejmqx02C7
	OlmWc90acwqZJRRx98VKcHqjikEIv+D0/DvfmvIdxr6wBnwUI/8wpXmxgszg8TsI
	kDILB14f7xt7cvfRCl4BPCL+2378qOHl9G6FQ6QFwFgdWjmHfnONKa5YjeS/TZCI
	9MwU8eDSX/A4XhSdAGn/2QNKNVOIOD2hC3a+rLAqm9qlT7UysR1eA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte42u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:39 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RErwEA017974;
	Tue, 27 Jan 2026 15:33:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrte42q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RF0BC6018303;
	Tue, 27 Jan 2026 15:33:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb41rx1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:33:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFXXZ044499356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:33:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAACE20040;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7352D2004E;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:33:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [RFC PATCH v1 1/5] unwind_user: Enable arch-specific signal frame unwinders
Date: Tue, 27 Jan 2026 16:33:27 +0100
Message-ID: <20260127153331.2902504-2-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127153331.2902504-1-jremus@linux.ibm.com>
References: <20260127153331.2902504-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nVRWLN5-QqZctx4hlKVy5MA3mvaUNbQl
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6978dad3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6XKp6n-VjBup7wJUbcIA:9
X-Proofpoint-ORIG-GUID: 6sOBiRvTAc1dmvB3im-sLZpbTwqraB4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfXwjafthCE2cNu
 XyFru7ZdTZDpYjOWbD8UWXKLbpDd+hNrKJ/8WIFYZJzrS7JsktTkpW0/oOWdxgJbd1rmkhuHbeE
 mSy6Tqj+oBx6zUyyXej//O9E6ixZ53BSGh9V7L+pQ+EiD3opKCvXV3ZDpVY0ob3GifIUsflsTPx
 5dM2UpdzocmM5hxebPev/9lJjFceK5uQEJf7+1KGCXJVtVjG8RlAX6uO1pYuljsclllIuh15rqJ
 e9LGN/E5cw6EZDNzQjfmaOzpoD2KT+mjfohMxH8mo04oULyiYyd/bTGP2HbsUG9ph3iLZc+rc0x
 FDsOmwQXO8sBhVW3cWC9ctMmPOrkGzepRPH8qVurfBE+Xhei/jmKeQB4NR0mvmYvn9oHmpjtgQn
 zKx0aS7cVNgwDzVVFv9fBx+8KBbdZpxUOAiMPmTq107+vm4Q0vOGtDvYMLkg0s7XxIyQf8v5B49
 TpFEnto+p7TLqH4vn2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

Add a signal flag to struct unwind_user_frame, which indicates whether
the frame is a signal frame.  If set unwind_user_common_next() uses an
architecture-specific unwind_user_signal_next() implementation to
unwind the frame.

user unwind sframe will make use of the signal flag in a subsequent
commit.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user.h | 6 ++++--
 include/linux/unwind_user.h        | 9 +++++++++
 include/linux/unwind_user_types.h  | 1 +
 kernel/unwind/user.c               | 4 ++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index f5e9fbcdae28..21cb9eeb2503 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -67,7 +67,8 @@ static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
 		.offset		= -2*(ws),		\
 			},				\
 	.sp_off		= 0,				\
-	.outermost	= false,
+	.outermost	= false,			\
+	.signal		= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa		= {				\
@@ -82,7 +83,8 @@ static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
 		.rule		= UNWIND_USER_RULE_RETAIN,\
 			},				\
 	.sp_off		= 0,				\
-	.outermost	= false,
+	.outermost	= false,			\
+	.signal		= false,
 
 static inline int unwind_user_fp_get_frame(struct unwind_user_state *state,
 					   struct unwind_user_frame *frame)
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index f65b0573b3a5..eb5de4cb5bd6 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -34,6 +34,15 @@ static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
 #define unwind_user_get_reg unwind_user_get_reg
 #endif
 
+#ifndef unwind_user_signal_next
+static inline int unwind_user_signal_next(struct unwind_user_state *state)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+#define unwind_user_signal_next unwind_user_signal_next
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index fac8f470b597..3985706d7851 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -68,6 +68,7 @@ struct unwind_user_frame {
 	struct unwind_user_rule_data fp;
 	s32 sp_off;
 	bool outermost;
+	bool signal;
 };
 
 struct unwind_user_state {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index a64ceb4a2bf6..b9a3b59e8282 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -32,6 +32,10 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 {
 	unsigned long cfa, sp, fp, ra;
 
+	/* Use signal frame unwinder for signal frames. */
+	if (frame->signal)
+		return unwind_user_signal_next(state);
+
 	/* Stop unwinding when reaching an outermost frame. */
 	if (frame->outermost) {
 		state->done = true;
-- 
2.51.0

