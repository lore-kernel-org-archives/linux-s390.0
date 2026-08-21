Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCB40756E;
	Fri, 21 Aug 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342091; cv=none; b=Gr4B945/Fv+HF6eX/7eV54c+eJHBkZRC8KPhSEbO6CgcBJJSYSY5lo4zOQFbhNNG1T5Isw1Z7RNdpeftw2fyXZNSGqEGqxNXkLCmcJKwCRGNCKeJ0yFvz7PPL/s5rCGonDTM7bBC96aDNsT4xLbi7N+Kpw2edmxQTw/UBmJbKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342091; c=relaxed/simple;
	bh=VxkjHAblvepLIgb9AXIOQ4663CYXn8d6zZ9kO2Cgr1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6nhrBc0iCQptjAW617mqsB7kwJRWQRCfS11DrCDj93/NLYcOdYT9dGIMWFbnFz5W72flL7Ewqa3Mms8qCB/siUCGk8/U9U3eVXtuLSEbLV2XqAYo00CuakfKYYyh7PDjfDax+B2bACAGcG6s+KuTj9nXfkLciZNeq05/YxN0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ik6Z6Eca; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ik6Z6Eca"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVxiZ2253909;
	Fri, 21 Aug 2026 19:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vy5v0kow8OvVBCKPE
	knTW3YVcH8+BOGq/wDD2Ax/0dc=; b=Ik6Z6EcagM4Th2wGIyhUWPm6WCZVvOJXD
	GFAk/4ZKbPCVUKNf7cLbMtN16ekl5NlRCI66wn4JVI1iid78IXHfKoTVVIjiudFP
	bfSHfMLCcVgd0xSilp9GSnPS4qj5TpCdaLe6Jps5b7KeE+n3XrwSXmPBI1qLx0Xz
	HkJXn4YyXUggHE/VgwxS4QYXQZUDcyRHyVoKatPM+NLD+KpQymbk47N6fEmzgTKp
	CefyrOpHmD6iIFKklcoKvYgpaPdYFej8dCjsBs92vZUB90yBmL0tK97zbXlO3Trf
	68A6w1T3jro+7JmCA3gpMns1HkLacKpTyObsnKH3/eRgaaKdsRQaw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4krka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfG0Z006045;
	Fri, 21 Aug 2026 19:53:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngxffa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr6UE46137672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C721C2004D;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89ED620043;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
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
        Sam James <sam@gentoo.org>, Fangrui Song <i@maskray.me>
Subject: [RFC PATCH v2 06/24] unwind_user: Enable archs that define CFA = SP_callsite + offset
Date: Fri, 21 Aug 2026 21:52:41 +0200
Message-ID: <20260821195259.2688377-7-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821195259.2688377-1-jremus@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX9FBsFAHQQGz2
 N9gv4AKq5AX16Zd6I3vSIabgnEmTfLOzPrSVZBJpFomPfP4zo83JrfdX1ucT08nWIZvdjdj7j6G
 BJM2jfsXJE02TnmtC8mH2uQ1TmYGqV4=
X-Proofpoint-GUID: EAk8b7H0yYpoYcv3I855zQw9brKikp8S
X-Proofpoint-ORIG-GUID: efydjJzZ6feBGaRhEFylPmhj4xk-CtEz
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88aca8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ejlfquudVdD-DdDf6fkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX194aGO/+JiKM
 LnIsfSROUvjuAHAJ2I2PpvNtq0L3yaYaHfdSHcnrfEPDm1RX24yG2WY7lxcGmzFZkF9cPh/92Qv
 Au7O/L8wMrX4PRGm4PicIJATuc/z4rRoWKS4cEj5hrpXlK8Ds3eJD/g6c2tDcclXklSG+/5ayIM
 goXURhAibpr0iVWilQsjCHjwXI9wJ7d5P812ae2sZ5LPQC6CS8AHXQ/a+WAceJn9tSuw8cYOLoB
 QfDJiaFrk9FyiHHuz6XQ9CDTlbNadWJH70pgkY/85lzN+9gH7jDyGcoOwANs4fX5QeKr3CrDBBy
 M7F1U5vWJDtU9VbZnItqeZy1bqTdT5udp60KC214hkfz23BTCqj+00k5vIjaYwnKOQyVFsQljCx
 YiYwbf1G1W7QFCtvluPW50Uvr5ykx/gKYrSIKP8jj5fS7UXLFTBxuhO9E/rIjZuOOlaW8fkolGH
 mQfaK5kT/WLsOheI+DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

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

