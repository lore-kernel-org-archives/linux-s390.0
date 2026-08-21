Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164E40F75B;
	Fri, 21 Aug 2026 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342026; cv=none; b=iyHMjp9WX02UrlcC9zxkUCpieuzkVrgHT5jGlFA3PaC3GD/R8SKLvzNvNSQYhwT+Hf+Cy51/ZGfQjS0kVz2lKJgWEWMoWo1dTZze/VK1uEtGTAqbSaOECfioR6vRvGvQDmqJ8jCQznFXJcF1vcWwQ9wCQMhxNNskx8HxBSisGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342026; c=relaxed/simple;
	bh=g7TvgZy6XOZBKCswfNzB3dLoqZ/eGefaLm9pTKHCZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTODGJKureYuoePEKdSphIbQOH7I8IFftHzBGnUvy1QIvwz3CI51sNSRSHzmyXOv/4fJqYzN82yoGsxJkmLYaqkbq8wL+9ZNDZGw4T4qKdiXg6kOZo8CmW+l3sJhAgJ5lGRvGictSVm7w1ZFmSCA5OTfMTg0bBBLXi7j2/IS/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J4rFDmMe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J4rFDmMe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVhLp2363840;
	Fri, 21 Aug 2026 19:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uc2H1ny73nZVVmNdP
	1gES8aoeXmzxmUN+CBNL7lP44c=; b=J4rFDmMeku/auoQ6pq0cG9AvN1G0eRKdq
	p7Fv6MhRyVUvVnDB4QpHgUogQK+yN1IZTp/uELnspoa+pcTYbzAIEzID+/8sHssr
	88p23+2KckAaLJQ+8Qlcz/IO6VjlyuIKcDCn2rm821oHwbBTMtNlvmfBCh0P4pnA
	dRHLCMCQWdiOxm8bR4f2nxuzUmzBg1AnePjHEIUeNWAqrewerYaRERFA51Z1rEcN
	gMVALkh62CunP2+Kr6DodosNlb9RlDQYxh6WRwpuJMTiaKRuJjelXo8lv8BU60v6
	mQM+zELXfmixt9Wo3GM6kVIX/kn7XujzkBQA0WN3ldgeGaaCWHdMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uxmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfMOt020629;
	Fri, 21 Aug 2026 19:53:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqpupt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrBMl50331920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F6B20040;
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3ABD2004B;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
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
Subject: [RFC PATCH v2 21/24] unwind_user/eh_frame/x86: Handle DRAP expressions
Date: Fri, 21 Aug 2026 21:52:56 +0200
Message-ID: <20260821195259.2688377-22-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88acac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=CAsaE8RiOkJQvnkcRxMA:9
X-Proofpoint-ORIG-GUID: kNDSzTw_ntX5oD9COhkRCOds83m98PVh
X-Proofpoint-GUID: -Q-PoLBGfZFKRTshpn4oP7FrtUEgbK__
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX43eWqKv8u+oe
 EuhMGs1F1ztP1niXFFaAeHNELsDfQoBqpdLHqH8Prkiz98QNEX1fN5Uq2hN10kKEhS1d/SuzAPv
 2hSCjfEbVhRtr/CRVQuNn9FZXc9/vHg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX2a/6WPtw/cvL
 Vk89LGqAnfZ1NUTtR4fudZhF8RJgxirftP3Pao//Dpwdb+AHF0VRXAi786gV6CIgrnJUX3dou0n
 u4K+aTu9AyiXHV42FQ6U7mlKWDG6YfeeBiSi6PEfq9xLAr/dzc/+6wkoaiuQtGs4YG4xUGaX/xx
 yUsKgzS83+tD/drOVe/qNlasMEyuRv9pFBHzqP3mHWRsUSgH+jjJ9BPnIfJKXxUwkTDEo9xQv93
 EV+AG/7zbv9W5mHSN/eXknJSXcJmUhA6k3B44+WdbIVM3ewA+jj9reKdHh//81lzraIQjkian6A
 D/+ZCFcgdXeNjwslIqKSrIksiKwFMo/JBP3O3B+gd8T2z5Z0tibxTyg6O2dyTwdM2tBvinjcwZd
 12H6l0O0wmy2EoxM1naeV2wAKK2s6vuXJDaUxPJ00Ga0V/Rklr6/kfRggaYLnaxrelRQbVDByNE
 bT3NgzKtijlxhuBNkNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

GCC uses DRAP (Dynamic Realign Argument Pointer) when the stack needs
to be dynamically realigned (e.g. for aligned local variables).  This
uses DWARF expressions to describe how to unwind through such frames.

Add x86-specific handling for the CFA and FP expressions patterns:

1. CFA expression (DW_OP_breg<FP> + offset, DW_OP_deref):
   - Semantics: CFA = *(FP + offset)
   - Restores the CFA from the saved SP at FP-4 (i386) or FP-8 (x86-64).

2. FP expression (DW_OP_breg<FP> +0):
   - Semantics: FP = *(FP + 0)
   - Restores FP from DRAP location (FP+0).

The implementation uses mask-based pattern matching similar to the
existing x86 PLT expression support.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user_eh_frame.h | 65 +++++++++++++++++++++
 include/linux/unwind_user_eh_frame_types.h  |  4 ++
 kernel/unwind/eh_frame.c                    | 57 ++++++++++++++----
 3 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user_eh_frame.h b/arch/x86/include/asm/unwind_user_eh_frame.h
index 8268eb1a0ff5..670740cdbd8c 100644
--- a/arch/x86/include/asm/unwind_user_eh_frame.h
+++ b/arch/x86/include/asm/unwind_user_eh_frame.h
@@ -79,10 +79,75 @@ static inline int eh_frame_do_def_cfa_expression(const char *expr,
 		return 0;
 	}
 
+	/*
+	 * DRAP (Dynamic Realignment Pointer) CFA expression:
+	 *
+	 * DW_OP_breg<FP> + <FP_offset>	// 5 (EBP) - 4 or 6 (RBP) - 8
+	 * DW_OP_deref
+	 *
+	 * CFA = *(FP + FP_offset)
+	 */
+	static const char drap_expr[] = {0x70, 0x00, 0x06};
+	static const char drap_mask[] = {0xf0, 0x80, 0xff};
+
+	if (size == sizeof(drap_expr) &&
+	    !memcmp_masked(expr, drap_expr, drap_mask, sizeof(drap_expr))) {
+		unsigned char fp_reg = DW_OP_breg_register(expr[0]);
+		unsigned char fp_offset_byte = expr[1];
+		long fp_offset;
+
+		if (fp_reg != EH_FRAME_REG_FP)
+			return -EOPNOTSUPP;
+
+		fp_offset = (long)(fp_offset_byte);
+		if (fp_offset_byte & 0x40)
+			fp_offset |= -(1L << 7);	/* Sign extend */
+
+		/* CFA = *(FP + offset) */
+		reg_state->cfa_rule = CFA_REG_OFFSET_DEREF;
+		reg_state->cfa_regnum = EH_FRAME_REG_FP;
+		reg_state->cfa_offset = fp_offset;
+		return 0;
+	}
+
 	return -EOPNOTSUPP;
 }
 #define eh_frame_do_def_cfa_expression eh_frame_do_def_cfa_expression
 
+static inline int eh_frame_do_expression(unsigned int reg,
+					 const char *expr,
+					 int size,
+					 unsigned long ip,
+					 struct eh_frame_reg_state *reg_state)
+{
+	/*
+	 * DRAP (Dynamic Realignment Pointer) FP expression:
+	 *
+	 * DW_OP_breg<FP> +0	// 5 (EBP) or 6 (RBP)
+	 *
+	 * FP = *(FP + 0)
+	 */
+	static const char drap_fp_expr[] = {0x70, 0x00};
+	static const char drap_fp_mask[] = {0xf0, 0xff};
+
+	if (reg == EH_FRAME_REG_FP && size == sizeof(drap_fp_expr) &&
+	    !memcmp_masked(expr, drap_fp_expr, drap_fp_mask, sizeof(drap_fp_expr))) {
+		unsigned char fp_reg = DW_OP_breg_register(expr[0]);
+
+		if (fp_reg != EH_FRAME_REG_FP)
+			return -EOPNOTSUPP;
+
+		/* FP = *(FP + 0) */
+		reg_state->reg_rule[FP_IDX] = REG_REGISTER_OFFSET_DEREF;
+		reg_state->reg_regnum[FP_IDX] = EH_FRAME_REG_FP;
+		reg_state->reg_offset[FP_IDX] = 0;
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+#define eh_frame_do_expression eh_frame_do_expression
+
 #include <asm-generic/unwind_user_eh_frame.h>
 
 #endif /* _ASM_X86_UNWIND_USER_EH_FRAME_H */
diff --git a/include/linux/unwind_user_eh_frame_types.h b/include/linux/unwind_user_eh_frame_types.h
index e9f9d1abb76f..9547e963bb5f 100644
--- a/include/linux/unwind_user_eh_frame_types.h
+++ b/include/linux/unwind_user_eh_frame_types.h
@@ -5,6 +5,8 @@
 enum eh_frame_cfa_rule {
 	CFA_UNDEFINED,		/* unrecoverable */
 	CFA_REG_OFFSET,		/* CFA = reg + offset */
+	/* CFA expressions rules */
+	CFA_REG_OFFSET_DEREF,	/* CFA = *(reg + offset) */
 };
 
 enum eh_frame_reg_rule {
@@ -14,6 +16,8 @@ enum eh_frame_reg_rule {
 	REG_OFFSET,		/* reg = *(CFA + offset) */
 	REG_VAL_OFFSET,		/* reg = CFA + offset */
 	REG_REGISTER,		/* reg = other_reg */
+	/* expressions rules */
+	REG_REGISTER_OFFSET_DEREF,	/* reg = *(other_reg + offset) */
 };
 
 enum eh_frame_reg_index {
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index 0a81ba1a0377..d1656f5d40f1 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1098,18 +1098,33 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
 		return ret;
 
 	/* Convert CFA rule */
-	if (ctx.state.cfa_rule != CFA_REG_OFFSET)
+	switch (ctx.state.cfa_rule) {
+	case CFA_REG_OFFSET:
+		if (ctx.state.cfa_regnum == EH_FRAME_REG_SP)
+			frame->cfa.rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
+		else if (ctx.state.cfa_regnum == EH_FRAME_REG_FP)
+			frame->cfa.rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
+		else {
+			if (ctx.state.cfa_regnum > UINT_MAX)
+				return -EINVAL;
+			frame->cfa.rule = UNWIND_USER_CFA_RULE_REG_OFFSET;
+			frame->cfa.regnum = ctx.state.cfa_regnum;
+		}
+		break;
+	case CFA_REG_OFFSET_DEREF:
+		if (ctx.state.cfa_regnum == EH_FRAME_REG_SP)
+			frame->cfa.rule = UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF;
+		else if (ctx.state.cfa_regnum == EH_FRAME_REG_FP)
+			frame->cfa.rule = UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF;
+		else {
+			if (ctx.state.cfa_regnum > UINT_MAX)
+				return -EINVAL;
+			frame->cfa.rule = UNWIND_USER_CFA_RULE_REG_OFFSET_DEREF;
+			frame->cfa.regnum = ctx.state.cfa_regnum;
+		}
+		break;
+	default:
 		return -EINVAL;
-
-	if (ctx.state.cfa_regnum == EH_FRAME_REG_SP)
-		frame->cfa.rule = UNWIND_USER_CFA_RULE_SP_OFFSET;
-	else if (ctx.state.cfa_regnum == EH_FRAME_REG_FP)
-		frame->cfa.rule = UNWIND_USER_CFA_RULE_FP_OFFSET;
-	else {
-		if (ctx.state.cfa_regnum > UINT_MAX)
-			return -EINVAL;
-		frame->cfa.rule = UNWIND_USER_CFA_RULE_REG_OFFSET;
-		frame->cfa.regnum = ctx.state.cfa_regnum;
 	}
 
 	if (ctx.state.cfa_offset < INT_MIN ||
@@ -1150,6 +1165,16 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
 		frame->ra.regnum = ctx.state.reg_regnum[RA_IDX];
 		frame->ra.offset = 0;
 		break;
+	case REG_REGISTER_OFFSET_DEREF:
+		if (ctx.state.reg_regnum[RA_IDX] > UINT_MAX)
+			return -EINVAL;
+		if (ctx.state.reg_offset[RA_IDX] < INT_MIN ||
+		    ctx.state.reg_offset[RA_IDX] > INT_MAX)
+			return -EOPNOTSUPP;
+		frame->ra.rule = UNWIND_USER_RULE_REG_OFFSET_DEREF;
+		frame->ra.regnum = ctx.state.reg_regnum[RA_IDX];
+		frame->ra.offset = ctx.state.reg_offset[RA_IDX];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1184,6 +1209,16 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
 		frame->fp.regnum = ctx.state.reg_regnum[FP_IDX];
 		frame->fp.offset = 0;
 		break;
+	case REG_REGISTER_OFFSET_DEREF:
+		if (ctx.state.reg_regnum[FP_IDX] > UINT_MAX)
+			return -EINVAL;
+		if (ctx.state.reg_offset[FP_IDX] < INT_MIN ||
+		    ctx.state.reg_offset[FP_IDX] > INT_MAX)
+			return -EOPNOTSUPP;
+		frame->fp.rule = UNWIND_USER_RULE_REG_OFFSET_DEREF;
+		frame->fp.regnum = ctx.state.reg_regnum[FP_IDX];
+		frame->fp.offset = ctx.state.reg_offset[FP_IDX];
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.53.0

