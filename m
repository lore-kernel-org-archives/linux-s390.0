Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FE126F288;
	Tue, 18 Aug 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064632; cv=none; b=fPMFeKeSCnVWhp87sGnNU7d/lL2ag+tnASSWWSDEWeW65906evzsmNkI0jsbRoqIqWS0nzqY/Av0mtVynWg6+ftZtdxyV3SbfyuhdbEkPTGObm1owqf96nNV0iDbpAjNq5bR9avbP1NjvF773Ydv4d3JOnY585CIr0+7F09fzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064632; c=relaxed/simple;
	bh=pxvnkWjyvllmDpNuTjBidERmsTqRP+y+9EN7+vcXhiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjLM7ta2zj2LFagw/imHWQI1GvQuaXyFz+rB3Y+1TAoHJnEze0FDLnhjzB9zA7KbqzOcWlsXYNdk2Gwqu+O8lC+mfhg9/d0JrkjyQGZlO3BkrmyCVH+zv1kjdIToOsi4U4rcUDnO9xWoO15EyEwLGM/3axqGODyGkyA0u07mPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZK1Lo1qK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZK1Lo1qK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3cPe542428;
	Tue, 18 Aug 2026 14:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OutS/vKpuqD7JZiOr
	99VKYen3/kOqOdagaSdljOjgy0=; b=ZK1Lo1qKe/Do4onnBLwpIfbwLGXSw1WLu
	Uufr/U/V4gz8M7uQ6RbERLjf47stTFmfHSBU2fipIppNu0a3zxJb/f/K2Oz7pE2w
	dKjJrAmBFM/UR5R6yVV45TgIyrPWLjGeuX8eGH2ZkvmdGRFtS1Wj/C94h73SXVri
	BNWqGG5Fy1VgqDc3ZROlZCMpRVJUp1+jJs+IGTliV2L/qikONCT8H/K9Zl0mthAz
	POzQpOGvTEgdy2VEC2ZtR5n6YXHo2okWoxIivAzbzpQt2QZCJ7Flr3O735qs9mPG
	4+tujDrrx46xvUQGm1UgOw4ZM2HKGNIznD+VtAZhROC/2oN+zmlqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8bsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfHNO032404;
	Tue, 18 Aug 2026 14:50:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybgbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnwit26804506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B3BD20043;
	Tue, 18 Aug 2026 14:49:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 538A12004D;
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
Subject: [RFC PATCH v1 05/25] unwind_user: Flexible CFA recovery rules
Date: Tue, 18 Aug 2026 16:49:34 +0200
Message-ID: <20260818144954.2320378-6-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84711b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=IqD6mcJyx09DUBNVDg4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX45AChHTl32qm
 9l3FVFT95G3Y5UdfBeL2mtXBNPBG6zvSzxsKtBKG7a14QxOpYeYWh7hoBCjT5GbUJRVZGIjo6Ap
 NQZJHffILydiLHXcDlxWHo7xEn1/H1E=
X-Proofpoint-GUID: CuXYJYWmmgOnqSIeGQgtNOF3bMgxIBMt
X-Proofpoint-ORIG-GUID: lFCVTm_HiiHuq4N_JjyW9MxNqg5tmPAS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXz+Niq5DmiYGn
 pZY60Si1KQRxnPkZkhLXEQvRnRviPPRSezzc5LqgyTw4BcMqhowXxLvuitEhgsf5C2+3NJs1bPI
 b3fITdm0N1LOM4Ceu5rWsS5fNopHsci6BfdYoDdLcng9RLpmFFpg0VoMayBEacNEu3vtveeJuEF
 setVuGOuZoM2pND95nbSLhM0y6DBLEQIifcsbfxbTq1jhePUhCcutIuSjZ0vaycnjJVilABfFIi
 afUMfAvowW2phIkodIMe5wDur7vf0E0VFwy2Sj7h0P4wEKJD56wyFkMNtvN6hpDcbKvGOQOZl0M
 0M1dZ9o/hgjdmGqiFHEz8MHEHjgFEvDNQstINnIkZS0l0opUF/mF1Q1sgv2CP7FiiSM1JfjuR7/
 N5ihOWugkwShR7G9L53ZXl47Ae9sIQDk+Ke5+2q+BOtMJZcaex0eeQj12/KbYFFX2rjUsouznls
 +oEca+I2jZApqAM+ofQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

To enable support for SFrame V3 flexible FDEs with a subsequent patch,
add support for the following flexible Canonical Frame Address (CFA)
recovery rules:

  CFA = SP + offset
  CFA = *(SP + offset)
  CFA = FP + offset
  CFA = *(FP + offset)
  CFA = register + offset
  CFA = *(register + offset)

Note that CFA recovery rules that use arbitrary register contents are
only valid when in the topmost frame, as their contents are otherwise
unknown.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-16-jremus@linux.ibm.com/

 arch/x86/include/asm/unwind_user.h | 12 ++++++++----
 include/linux/unwind_user_types.h  | 22 ++++++++++++++++++++--
 kernel/unwind/user.c               | 24 ++++++++++++++++++++----
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 9c3417be4283..f38f7c5ff1de 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -20,7 +20,10 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
-	.cfa_off	=  2*(ws),			\
+	.cfa		= {				\
+		.rule		= UNWIND_USER_CFA_RULE_FP_OFFSET,\
+		.offset		=  2*(ws),		\
+			},				\
 	.ra		= {				\
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -1*(ws),		\
@@ -29,11 +32,13 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -2*(ws),		\
 			},				\
-	.use_fp		= true,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
-	.cfa_off	=  1*(ws),			\
+	.cfa		= {				\
+		.rule		= UNWIND_USER_CFA_RULE_SP_OFFSET,\
+		.offset		=  1*(ws),		\
+			},				\
 	.ra		= {				\
 		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
 		.offset		= -1*(ws),		\
@@ -41,7 +46,6 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	.fp		= {				\
 		.rule		= UNWIND_USER_RULE_RETAIN,\
 			},				\
-	.use_fp		= false,			\
 	.outermost	= false,
 
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 1b5db76e886a..670ac860ae76 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -27,6 +27,25 @@ struct unwind_stacktrace {
 
 #define UNWIND_USER_RULE_DEREF			BIT(31)
 
+enum unwind_user_cfa_rule {
+	UNWIND_USER_CFA_RULE_SP_OFFSET,		/* CFA = SP + offset */
+	UNWIND_USER_CFA_RULE_FP_OFFSET,		/* CFA = FP + offset */
+	UNWIND_USER_CFA_RULE_REG_OFFSET,	/* CFA = register + offset */
+	/* DEREF variants */
+	UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF =	/* CFA = *(SP + offset) */
+		UNWIND_USER_CFA_RULE_SP_OFFSET | UNWIND_USER_RULE_DEREF,
+	UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF =	/* CFA = *(FP + offset) */
+		UNWIND_USER_CFA_RULE_FP_OFFSET | UNWIND_USER_RULE_DEREF,
+	UNWIND_USER_CFA_RULE_REG_OFFSET_DEREF =	/* CFA = *(register + offset) */
+		UNWIND_USER_CFA_RULE_REG_OFFSET | UNWIND_USER_RULE_DEREF,
+};
+
+struct unwind_user_cfa_rule_data {
+	enum unwind_user_cfa_rule rule;
+	s32 offset;
+	unsigned int regnum;
+};
+
 enum unwind_user_rule {
 	UNWIND_USER_RULE_RETAIN,		/* entity = entity */
 	UNWIND_USER_RULE_CFA_OFFSET,		/* entity = CFA + offset */
@@ -45,10 +64,9 @@ struct unwind_user_rule_data {
 };
 
 struct unwind_user_frame {
-	s32 cfa_off;
+	struct unwind_user_cfa_rule_data cfa;
 	struct unwind_user_rule_data ra;
 	struct unwind_user_rule_data fp;
-	bool use_fp;
 	bool outermost;
 };
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index f5d68e86d72b..9df5040df9b3 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -52,14 +52,30 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	}
 
 	/* Get the Canonical Frame Address (CFA) */
-	if (frame->use_fp) {
+	switch (frame->cfa.rule) {
+	case UNWIND_USER_CFA_RULE_SP_OFFSET:
+	case UNWIND_USER_CFA_RULE_SP_OFFSET_DEREF:
+		cfa = state->sp;
+		break;
+	case UNWIND_USER_CFA_RULE_FP_OFFSET:
+	case UNWIND_USER_CFA_RULE_FP_OFFSET_DEREF:
 		if (state->fp < state->sp)
 			return -EINVAL;
 		cfa = state->fp;
-	} else {
-		cfa = state->sp;
+		break;
+	case UNWIND_USER_CFA_RULE_REG_OFFSET:
+	case UNWIND_USER_CFA_RULE_REG_OFFSET_DEREF:
+		if (!state->topmost || unwind_user_get_reg(&cfa, frame->cfa.regnum))
+			return -EINVAL;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
-	cfa += frame->cfa_off;
+	cfa += frame->cfa.offset;
+	if (frame->cfa.rule & UNWIND_USER_RULE_DEREF &&
+	    get_user_word(&cfa, cfa, 0, state->ws))
+		return -EINVAL;
 
 	/*
 	 * Make sure that stack is not going in wrong direction.  Allow SP
-- 
2.53.0

