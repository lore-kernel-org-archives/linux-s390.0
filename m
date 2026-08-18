Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53166473C96;
	Tue, 18 Aug 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064644; cv=none; b=KGJkIw/CJ5xxwAqYSIVF4K0LzS6AZf4ZskQEjAo40fYPQvTiuMY0b3cIxNDuXo/UXVFxNzx9jpLlPhyqUGCbrMPO9w0+M/GVXOylfCUgHbceg5Xrm3nXj+pyx+zNp1wmwUeEiSqvVZB3TfXHk3qwIICrt9e4Rpm+iCLg2/i8buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064644; c=relaxed/simple;
	bh=afu24jH0sWWbgxeRigYWVfRJowKKSgx1IkkKxjAfxp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC/iOuiZaGLQvMNaswJvlSLem7nCh87cTjEE2WMhFNbYuzMLsb4Vn44G3PXS+dz82EV23VFB8pWewwe8+VWdNqBVC+/TOoW1/Nk/xovLuZIGXPVUXVesVqV9F1OHgyySCIwvUAKddPzwxoLvJeVM19rDZiBoGu+OkGNHUmBQ9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QXgPdgZc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QXgPdgZc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3emL542458;
	Tue, 18 Aug 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=trqYxbRZC1GE+GBw0
	4BAIlb5GAbXbEmvr0rCES1W8EM=; b=QXgPdgZcLT41YvNbvAES00LSQZwShYX3Y
	sP7lQbOgxhXdqwiCTQ5zjCzqf859iCZ2GBztJKJQdlM/IW6HOd+gS5BbKgn5I7P+
	P0pEaORze57RC4IOiabwNEwmKdOrq69R9agL2NoIyIoOE2TNDX0OJ6dDFJNrGjd2
	FUuzdv/ZzBfaD+8WH2uIVB91gT5PueUFDDAFEhhVM4JBC3FGW4ggaHtB3wZR/xIe
	WDQJ2Ol8qVUHYE6ucckICUIPd3CS3bjAGsAE6/HCNypk1Htf/QdyYJHvazIZTP7K
	YSg24C8reGJqzWu/T5OHvTru4dbOxndhQArfQyCx5xQnW1UrdIFKQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8btj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfIRj032411;
	Tue, 18 Aug 2026 14:50:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybgch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo4Ds27590918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 650C22004B;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 144652004D;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
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
Subject: [RFC PATCH v1 22/25] unwind_user/eh_frame/x86: Handle DRAP expressions
Date: Tue, 18 Aug 2026 16:49:51 +0200
Message-ID: <20260818144954.2320378-23-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a847121 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CAsaE8RiOkJQvnkcRxMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXwMlI6J5YNSJf
 keo8VDSIyZMezkdaQxf9nHT137R7w7biRm0XGYofsd0C3rNGikZiC7bdZeG4j936qxwdulNvQwG
 t5sI1fzKjRnONetq4PYj/bULdEjfYiI=
X-Proofpoint-GUID: sCeSAK8Xmfdb5zoF9XMtps2esQF0FcnV
X-Proofpoint-ORIG-GUID: 2pbdLbsdkSudkokjWPPKIUtu8cGvk_vC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0fq23L5yxkCN
 Q3xNg2pRaS9uK82v0iD9bh7oEYsOcu8s2OR7MyOkLB/Aa81UUHnYqwnMQXjcEJAVvGuPrydRLwR
 Csfno/qHFRsT/lyQPAcNpUvMFUwRtIdJQjyg3YtT34mtpwTVjqPxsWxETAf8r6jvxSf5xq9G9H+
 bVMvmkQjOuiFnGOytw8iSml+w118pnX3vv0QAtGEkKUo2ulU4aUw6doKqmi7naCv67IJSG8D976
 rLfaAJNv9dCk1tzPumIDsuqtvWi1uuR+P0mOpIHT9Jw9f41ziJEagN4HKSrG74amYjZvD0N26Y6
 3sBsrlPCgMcmT32+fvCQoqnFFixv70VMqqcH15fmHsjTcrmQxlp/BxqWWAnPCENb3kZEdopJKcj
 B0XzSJIF/BttEIZDSHBw5ITMyLfFwl50hrAuF8j3EkA0uIELGq+xCIVSGuVoDQByK0fR/TFh90N
 R+6K9YX8HzSRS6tffXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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
index 19e2bc96ddbc..49e8a3e8d794 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -1120,18 +1120,33 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
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
@@ -1172,6 +1187,16 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
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
@@ -1206,6 +1231,16 @@ static __always_inline int __find_frame_row(struct eh_frame_section *sec,
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

