Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC603A9D9A;
	Tue, 18 Aug 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064638; cv=none; b=Gr5eTVvgRfDyoY99tQ9Xp5669nwlPCS6uQBofdNcv+Cknv3x+51MSc2JTQMKvUpDVY7NpA9Lfzfy+HeNC028nNk+/MNl+t5lJSN8L+Z/7JpGVp+cu2vyOLfKpSKw/88UjMKAiJTH+X1WNBEGHbmZS3O5C36LMyxOd5nb6FPz4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064638; c=relaxed/simple;
	bh=VxkjHAblvepLIgb9AXIOQ4663CYXn8d6zZ9kO2Cgr1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxgXguC2HCd7suwigL/wdcTrrX3wBobuVGza8UGLO6jTDupT7uPlHyLf5OgGRgOnjc6y1G5hXT7VWJMOALCtpR3dKHQuu9TdZyn6W51Opg8InIv40uHaFdf2Q/xFNgG5frv4mzijmXZb8H9tsV5tZizHfgGKvjtKnumcTPa89Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kHjfTbZr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kHjfTbZr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3bEW505269;
	Tue, 18 Aug 2026 14:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vy5v0kow8OvVBCKPE
	knTW3YVcH8+BOGq/wDD2Ax/0dc=; b=kHjfTbZrUHcOeLys3+kP+S9d6JUqDKkGn
	x50jPyVfl64Xd2Tnfg9LcZP81Qg3Hdl4xZ87Q7iyROHhghHtQ5nj2ZRztA74d1i+
	+jKQ5nJtgd3AdtYEjl11QgrUsdGyuewgoqniidD23N2yoUYmZp0hHvfrXMqMkN/x
	e8LEOCGWE8ekmos74jnnhN0PusetRZwQ8emaJ1G73GxK9C2VpN7S8Vn0wLm+cfJA
	W/yQ35isNi+uCeEBq/NWirho4Y/r3a40RPvkAhTKapftNaNbZI5milfJFhdsBVSS
	yUqsEe7Vr+MGIgtPKFzVqqXsQVC+I5LAIEjJloLBqxFYte0zee2sQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4rx1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfM2m014736;
	Tue, 18 Aug 2026 14:50:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3r6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnxCS43712876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7AA720040;
	Tue, 18 Aug 2026 14:49:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0B0F2004B;
	Tue, 18 Aug 2026 14:49:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:49:58 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 06/25] unwind_user: Enable archs that define CFA = SP_callsite + offset
Date: Tue, 18 Aug 2026 16:49:35 +0200
Message-ID: <20260818144954.2320378-7-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: WK31jflkumh_TAB4r2GSlR-3b_SAKDab
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84711c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ejlfquudVdD-DdDf6fkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXzDFRDG15wH3i
 4L0Ft9lfO6tczkGnVIAfi0Qa/ud9OEoLw3KVcHEdWEVfpejDzYnPHLehmHnuwTzCVBRKAM0abr4
 DWGVDdCo0/HXB9GMBWWuFQYvFowsRGw=
X-Proofpoint-ORIG-GUID: AlszMMSDSTmDmd0BmEaJdjLfPUN__UIC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX8eD8O8XQ6j2Z
 /r0OlZV4ng9uK6FWJ21J7EAUvhZnHbLpsnETMvz503q20pcTQj8s+r6vClFcGcc8A7BBm+R3yWw
 iIdNg2BzH+dLDK72xvwwsnBnDlTJ97gre0hg2uOkbPUiKQcl2sogqzXC9y/PjovP0CTp+d+Y7zk
 xDUCxTI0ZZ401D68WG8JgyQUWtIji2qJUGOn4fGe9v5W7K/Z2TZMP220HDNzZ/DzsSUBGbCrFp+
 aQl/43Ys6TUz6fTCQYIbzSP9YsjQMBzJEAhVjpVLSd5n0gcH24UjTklUc1mWheOTWXxFPkoLDgA
 Z8sKRx99Rt9aaxujXV6wxsSMfe4QUWB7gwHz34xk3S1UdIC3Wzpw8mV8WfBHsBqUUnhKGFvr5MV
 MwVkTRhDHMKQH7ATf/2it7c0y15nz3r/7qsBSS6LvCu8C84EM/xucVie/+6CT+nhYWYD50wG5jP
 F6Dmczvn9FyiTWTAvdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

Most architectures define their CFA as the value of the stack pointer
(SP) at the call site in the previous frame, as suggested by the DWARF
standard.  Therefore the SP at call site can be unwound using an
implicitly assumed value offset from CFA rule with an offset of zero:

  .cfi_val_offset <SP>, 0

As a result the SP at call site computes as follows:

  SP = CFA

Enable unwinding of user space for architectures, such as s390, which
define their CFA as the value of the SP at the call site in the previous
frame with an offset.  Do so by enabling architectures to override the
default SP value offset from CFA of zero with an architecture-specific
one:

  .cfi_val_offset <SP>, offset

So that the SP at call site computes as follows:

  SP = CFA + offset

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v4 00/12] s390: SFrame user space unwinding"
    series and adjusted to .eh_frame:
    https://lore.kernel.org/all/20260127151926.2805123-6-jremus@linux.ibm.com/

 arch/x86/include/asm/unwind_user.h |  2 ++
 include/linux/unwind_user_types.h  |  1 +
 kernel/unwind/user.c               | 11 ++++++-----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index f38f7c5ff1de..c96645c824d1 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -32,6 +32,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -2*(ws),		\
 			},				\
+	.sp_off		= 0,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
@@ -46,6 +47,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	.fp		= {				\
 		.rule		= UNWIND_USER_RULE_RETAIN,\
 			},				\
+	.sp_off		= 0,				\
 	.outermost	= false,
 
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 670ac860ae76..4da058096259 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -67,6 +67,7 @@ struct unwind_user_frame {
 	struct unwind_user_cfa_rule_data cfa;
 	struct unwind_user_rule_data ra;
 	struct unwind_user_rule_data fp;
+	s32 sp_off;
 	bool outermost;
 };
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 9df5040df9b3..830c620fe453 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -43,7 +43,7 @@ get_user_word(unsigned long *word, unsigned long base, int off, unsigned int ws)
 static int unwind_user_next_common(struct unwind_user_state *state,
 				   const struct unwind_user_frame *frame)
 {
-	unsigned long cfa, fp, ra;
+	unsigned long cfa, sp, fp, ra;
 
 	/* Stop unwinding when reaching an outermost frame. */
 	if (frame->outermost) {
@@ -77,16 +77,17 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	    get_user_word(&cfa, cfa, 0, state->ws))
 		return -EINVAL;
 
+	/* Get the Stack Pointer (SP) */
+	sp = cfa + frame->sp_off;
 	/*
 	 * Make sure that stack is not going in wrong direction.  Allow SP
 	 * to be unchanged for the topmost frame, by subtracting topmost,
 	 * which is either 0 or 1.
 	 */
-	if (cfa <= state->sp - state->topmost)
+	if (sp <= state->sp - state->topmost)
 		return -EINVAL;
-
 	/* Make sure that the address is word aligned */
-	if (cfa & (state->ws - 1))
+	if (sp & (state->ws - 1))
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
@@ -149,7 +150,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	state->ip = ra;
-	state->sp = cfa;
+	state->sp = sp;
 	state->fp = fp;
 	state->topmost = false;
 	return 0;
-- 
2.53.0

