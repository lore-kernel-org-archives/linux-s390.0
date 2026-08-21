Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8093DFC6B;
	Fri, 21 Aug 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342020; cv=none; b=frQudqBGbKip6BN96VSNbeFnj7FRbhPyHS5UdzU5y7vm+rTStqY7qBfSZcWlnu915VSwTbm4zx+QFL75+xSpyD+RVkmEjki/uU1ZsjmiUwy6t7a/lZzO6Fhb4quYTt7FpO5hOou7MZOftbKsptS2KDuHO85eJPKg939iwOgdrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342020; c=relaxed/simple;
	bh=WMyBpQzaz7z8JbLlLulfrQmBGsKPHDahtYmddyFk8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihkypqxoHc2md2mEvcfobc8Kg3EYNYRqBq6tZt/QtPeVOZnRDvw525dYPlOqSh33fW761C20yzRIEY2a3rdIfXTggCAdNcQPAcha5GvjOfCR/EblOKk3kBtuE43/XPg8Mc/4jKV0H3PPk8t8yn4AJrAAPemg+AyW88VbFlCkYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tPG47Xxv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tPG47Xxv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVVOS2363561;
	Fri, 21 Aug 2026 19:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dFCr5T9phyYLehboO
	bVirVwXB3O2bo8jq4xPArTF4sg=; b=tPG47Xxv2G0jIEfBuDf3JDM3KivNVLIBX
	huX0P2Ix2x0u8rl47N8K4Y2RcpgXBi6KleljqJ4GVz6beEMEoQuxK+7PNR5c5dwt
	DA5O7Kkirtdix6F66ND8/WuaPZA2xkdIw2VyJXuG6CLEVVrZ8yCaGMLEW6CjOA9U
	jpomlA/0XQTnVYPDdDabv7FY9i8NDY6CxAjHD1iJQ/B370/jHcQxyyUSa4TWQfQO
	31UqHofuAbVARIjJlkxhauq43E9xBkMdM/iSY7ikzi3lCf9OIHFkawuShtimCdES
	Wt8D0RDOpfEvoqi2fmnWMNoKV3EiAC2mtk/yglSWHuwqnFYYLC4Dw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0uxm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfKY4023504;
	Fri, 21 Aug 2026 19:53:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twprb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrAUP10420730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0125B20040;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFECB2004B;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
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
Subject: [RFC PATCH v2 17/24] unwind_user/eh_frame: Add support for DWARF expressions
Date: Fri, 21 Aug 2026 21:52:52 +0200
Message-ID: <20260821195259.2688377-18-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a88acab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=KkslVM8iKOnbzSZrsQ8A:9
X-Proofpoint-ORIG-GUID: F2cjGmsoF7SvFBo8kVlmsC1HIOVJwAev
X-Proofpoint-GUID: fAPKUeWmHTvd3YCRHPSSzwsgZPa1dlqI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXx3eKJIgdtg9W
 nwtLi0HNVNV33Tn1knPX1VtuU8kCNbfy6fZZs8XqoxWShIbRQAmCDBE96CT3A04OS11l9iYA7Py
 cyVFdTDshHFZrkiRq7Wg6wfwrHf0ujI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX9EAjLZQE0Ac+
 84OyBff4e8QawnTvJghqcf5h2DcsxunjbiY/iZAjGNOGpSgRNDj81IjxKDf8z05Ksj0gx/Mfqfl
 oOFf23+XhTo9ZHQ0ueJXArT4I1DID0bRWT7Ih6NyJoD5AdwF9z4rCoR1IOmsg14+y7TKd03dMfj
 iRlGgORsaJZNDgf/WhG6hVoKky9O204MaVyxku+XLtA7V4Mo0el54FMZ+AsB/4w8Wol3NYbeF//
 KP7IYPpb64uuMj0MOsYFVQoJsZa8dQnqyQ+omsNPv2K7Q4U96cvUkbwRWrUmG1BXaBSXech7Rb6
 rMpm4VGTFojHH8t6lZcsTGmzfMxogYI0D9WMLGQib3r2dFaoRXBLNU0TcsoKGDNBKNlOQMTU6ho
 W5bLvh1DZaPV4WKic3v0KRF8pQOcDoRWF/Bc9LGWs7qNzicOqVCYpP2sZhbJgfX3Er1SW0L7lNX
 EHaFFC27KaQP/8eckHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

Enable architectures to handle DWARF expressions in DWARF CFI
instructions DW_CFA_def_cfa_expression, DW_CFA_expression, and
DW_CFA_val_expression.  Limit the maximum expression length to a
reasonable size, while enabling architectures to override the
limit.

Architectures are supposed to only handle specific known expressions
or expression patterns, not to implement a stack-based expression
evaluation machinery.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in RFC v2:
    - Fix expression length overflow checks. (Sashiko AI)

 include/asm-generic/unwind_user_eh_frame.h | 41 ++++++++++++
 include/linux/unwind_user_eh_frame_types.h | 37 +++++++++++
 kernel/unwind/eh_frame.c                   | 72 +++++++++++-----------
 3 files changed, 114 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/unwind_user_eh_frame_types.h

diff --git a/include/asm-generic/unwind_user_eh_frame.h b/include/asm-generic/unwind_user_eh_frame.h
index da238557605b..a3cd3b3b55c7 100644
--- a/include/asm-generic/unwind_user_eh_frame.h
+++ b/include/asm-generic/unwind_user_eh_frame.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_UNWIND_USER_EH_FRAME_H
 #define _ASM_GENERIC_UNWIND_USER_EH_FRAME_H
 
+#include <linux/unwind_user_eh_frame_types.h>
+
 #ifndef EH_FRAME_MAX_CIE_LENGTH
 #define EH_FRAME_MAX_CIE_LENGTH 128
 #endif
@@ -14,6 +16,10 @@
 #define EH_FRAME_MAX_AUGSTR_LENGTH 16
 #endif
 
+#ifndef EH_FRAME_MAX_EXPRESSION_LENGTH
+#define EH_FRAME_MAX_EXPRESSION_LENGTH 32
+#endif
+
 #ifndef EH_FRAME_MAX_STATE_STACK
 #define EH_FRAME_MAX_STATE_STACK 1
 #endif
@@ -47,5 +53,40 @@ static inline bool eh_frame_reject_sp_rule(void)
 #define eh_frame_reject_sp_rule eh_frame_reject_sp_rule
 #endif
 
+#ifndef eh_frame_do_def_cfa_expression
+static inline int eh_frame_do_def_cfa_expression(const char *expr,
+						 int size,
+						 unsigned long ip,
+						 struct eh_frame_reg_state *reg_state)
+{
+	return -EOPNOTSUPP;
+}
+#define eh_frame_do_def_cfa_expression eh_frame_do_def_cfa_expression
+#endif
+
+#ifndef eh_frame_do_expression
+static inline int eh_frame_do_expression(unsigned int reg,
+					 const char *expr,
+					 int size,
+					 unsigned long ip,
+					 struct eh_frame_reg_state *reg_state)
+{
+	return -EOPNOTSUPP;
+}
+#define eh_frame_do_expression eh_frame_do_expression
+#endif
+
+#ifndef eh_frame_do_val_expression
+static inline int eh_frame_do_val_expression(unsigned int reg,
+					     const char *expr,
+					     int size,
+					     unsigned long ip,
+					     struct eh_frame_reg_state *reg_state)
+{
+	return -EOPNOTSUPP;
+}
+#define eh_frame_do_val_expression eh_frame_do_val_expression
+#endif
+
 #endif /* _ASM_GENERIC_UNWIND_USER_EH_FRAME_H */
 
diff --git a/include/linux/unwind_user_eh_frame_types.h b/include/linux/unwind_user_eh_frame_types.h
new file mode 100644
index 000000000000..e9f9d1abb76f
--- /dev/null
+++ b/include/linux/unwind_user_eh_frame_types.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_UNWIND_USER_EH_FRAME_TYPES_H
+#define _LINUX_UNWIND_USER_EH_FRAME_TYPES_H
+
+enum eh_frame_cfa_rule {
+	CFA_UNDEFINED,		/* unrecoverable */
+	CFA_REG_OFFSET,		/* CFA = reg + offset */
+};
+
+enum eh_frame_reg_rule {
+	REG_UNDEFINED_IMPLICIT,	/* reg = reg */
+	REG_UNDEFINED_EXPLICIT,	/* unrecoverable; RA: outermost frame */
+	REG_SAME_VALUE,		/* reg = reg; TODO: reset to CIE initial CFI */
+	REG_OFFSET,		/* reg = *(CFA + offset) */
+	REG_VAL_OFFSET,		/* reg = CFA + offset */
+	REG_REGISTER,		/* reg = other_reg */
+};
+
+enum eh_frame_reg_index {
+	FP_IDX,			/* frame pointer (FP) */
+	RA_IDX,			/* return address (RA) */
+	NR_REGS
+};
+
+struct eh_frame_reg_state {
+	/* CFA recovery rule */
+	enum eh_frame_cfa_rule cfa_rule;
+	unsigned long cfa_regnum;
+	long cfa_offset;
+
+	/* FP and RA recovery rules (SP uses implicit recovery) */
+	enum eh_frame_reg_rule reg_rule[NR_REGS];
+	unsigned long reg_regnum[NR_REGS];
+	long reg_offset[NR_REGS];
+};
+
+#endif /* _LINUX_UNWIND_USER_EH_FRAME_TYPES_H */
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index d185187b0c34..a98804dbe588 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -12,45 +12,14 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/eh_frame.h>
+#include <linux/types.h>
 #include <linux/unwind_user_types.h>
+#include <linux/unwind_user_eh_frame_types.h>
 #include <asm/unwind_user_eh_frame.h>
 
 #include "eh_frame.h"
 #include "eh_frame_debug.h"
 
-/* Register state for CFI interpreter */
-enum eh_frame_cfa_rule {
-	CFA_UNDEFINED,		/* unrecoverable */
-	CFA_REG_OFFSET,		/* CFA = reg + offset */
-};
-
-enum eh_frame_reg_rule {
-	REG_UNDEFINED_IMPLICIT,	/* reg = reg */
-	REG_UNDEFINED_EXPLICIT,	/* unrecoverable; RA: outermost frame */
-	REG_SAME_VALUE,		/* reg = reg; TODO: reset to CIE initial CFI */
-	REG_OFFSET,		/* reg = *(CFA + offset) */
-	REG_VAL_OFFSET,		/* reg = CFA + offset */
-	REG_REGISTER,		/* reg = other_reg */
-};
-
-enum eh_frame_reg_index {
-	FP_IDX,			/* frame pointer (FP) */
-	RA_IDX,			/* return address (RA) */
-	NR_REGS
-};
-
-struct eh_frame_reg_state {
-	/* CFA recovery rule */
-	enum eh_frame_cfa_rule cfa_rule;
-	unsigned long cfa_regnum;
-	long cfa_offset;
-
-	/* FP and RA recovery rules (SP uses implicit recovery) */
-	enum eh_frame_reg_rule reg_rule[NR_REGS];
-	unsigned long reg_regnum[NR_REGS];
-	long reg_offset[NR_REGS];
-};
-
 struct eh_frame_cfi_context {
 	struct eh_frame_reg_state state;
 	struct eh_frame_reg_state stack[EH_FRAME_MAX_STATE_STACK];
@@ -803,6 +772,27 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
 			break;
 		}
 
+		case DW_CFA_def_cfa_expression: {
+			unsigned long expr_len;
+			char expr[EH_FRAME_MAX_EXPRESSION_LENGTH];
+
+			ret = read_uleb128(&cur, end, &expr_len);
+			if (ret)
+				return ret;
+
+			if (cur + expr_len < cur || cur + expr_len > end)
+				return -EINVAL;
+
+			if (expr_len > sizeof(expr))
+				return -EOPNOTSUPP;
+			unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);
+			ret = eh_frame_do_def_cfa_expression(expr, expr_len, target_ip, &ctx->state);
+			if (ret)
+				return ret;
+			cur += expr_len;
+			break;
+		}
+
 		case DW_CFA_undefined: {
 			unsigned long reg;
 			int idx;
@@ -970,12 +960,22 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
 			if (ret)
 				return ret;
 
-			if (cur + expr_len > end)
+			if (cur + expr_len < cur || cur + expr_len > end)
 				return -EINVAL;
 
-			if (reg == EH_FRAME_REG_SP || reg == EH_FRAME_REG_FP || reg == EH_FRAME_REG_RA)
-				return -EOPNOTSUPP;
+			if (reg == EH_FRAME_REG_SP || reg == EH_FRAME_REG_FP || reg == EH_FRAME_REG_RA) {
+				char expr[EH_FRAME_MAX_EXPRESSION_LENGTH];
 
+				if (expr_len > sizeof(expr))
+					return -EOPNOTSUPP;
+				unsafe_copy_from_user(&expr, (void __user *)cur, expr_len, Efault);
+				if (opcode == DW_CFA_expression)
+					ret = eh_frame_do_expression(reg, expr, expr_len, target_ip, &ctx->state);
+				else
+					ret = eh_frame_do_val_expression(reg, expr, expr_len, target_ip, &ctx->state);
+				if (ret)
+					return ret;
+			}
 			cur += expr_len;
 			break;
 		}
-- 
2.53.0

