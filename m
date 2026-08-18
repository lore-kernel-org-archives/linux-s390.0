Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D030DD10;
	Tue, 18 Aug 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064627; cv=none; b=A8gcO5mDtNzRJhzNZjDHACtjkHYB6HhGZKCeHHQd2vmDc+l8XI2/aSENuksjAt28WSQDAnAH2jtR/vgrrt3ogTv8Ewfhum1pqNo5oxAYfXOQ31CgyBAKbQsZwi4u7m1jFklv/m3Md9Ck2YqS9WkfMCPQLlrpWsKACeIaS4fxgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064627; c=relaxed/simple;
	bh=VC90WT957RuJBwzw59XGUifCd2WuZNM7egWBYGUnwEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn3iuJ5KolADKguMV/2VB79Rl9vbAzSB6rYttZl5mkwjjzHyrkqQFv9OebgupXysTbLetFsX5DgMyRDZmU1KcAyC1M+i8m8TE2WDvoLcdCW+8tZgMpK9JJWS6/YpzCoNEQn3WrYzvzPhXN9WvhgCkrbWCvAzKXVrD3CwEO1C2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m0ZC/bbh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m0ZC/bbh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3bZa3582467;
	Tue, 18 Aug 2026 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BpvLWygwKGaH6UwTW
	knTNvo4Od12Bd4OuLl/hxXL5h8=; b=m0ZC/bbhLLHpUPae8aMAfWXFVTiU3lzgj
	DoQLwj2SZQwlrPaHJeT1IW2d9F8dbT5NyUfWj4ics9efYkRwSqQbLTTuaqwJqjmN
	YbuKgvnmfBLqqCVv0YciKc4J+JEfwM+OFm6WJrNdasa+rxLWAfBOpBxRpkel79k6
	g7WRn0+bj9T/Kpqwt/94LAoM8v9AAC2cx/7qWD3exCIN3wjcnwEwrQI4DnNaTk9H
	tOsOyHLxM8JRW2b9xn6pzyrHDan0Ota1OSBVDnnm+xSDHY+tHsATjmeBoeaOBUlp
	R7lHcnkhjAFnOBlYLTfOVE3rjLVNYhH+rKayKGYjemG6wk1fajUAA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe8h14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfPgp014779;
	Tue, 18 Aug 2026 14:50:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3r7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo3Np39584238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1838F20043;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBA9A2004D;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
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
Subject: [RFC PATCH v1 18/25] unwind_user/eh_frame: Add support for DWARF expressions
Date: Tue, 18 Aug 2026 16:49:47 +0200
Message-ID: <20260818144954.2320378-19-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX+tmiImle5It7
 /e8kTwfxsXdohIt/WvjowMqT3idBxYfC91mOZWSFKhF9g4Shko2X0jTufnT86/2yfrgcP6J234v
 LYLTpGEXyIf0ZYznJuaujKBzP4yWzl2sALd1kuPEuMYEHvIPULBPzrMzcQq18qTvnAEg3ZFmYk9
 ElYNKy6Ayz39qw/vSHY85gcBA3ItcrjgEEEAUFaRbPiP77GQDLuvkseIDuM1DCq4g1JtTfZ4pJR
 iP3BTX0dDGjl9CgeTsqo2o+/WB+rLWN2L/4B2BuAh7YfOW1Ynycbi+ok2Pwm0955yLmaSc/QQ1u
 OUI7t4mqytsC0KH0O3mKfZJgiFQjWn9DTkP9yi91jal9VnCCJ6PNbi4yBkqqZGttatJSrklMB1M
 88z92Y02chWyNCA8GyVWuWWHworLPnzU0SojVftqZuIOPW46amVi3Yff0KkDHjz5027wkPnL5CU
 xnuLtJl1JI0UzhM+4mA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a847120 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=CQQWWhfAhHPghX2u-Q4A:9
X-Proofpoint-ORIG-GUID: NM8SFNDVuwQiShy1vP58vaz_KWSS4DiC
X-Proofpoint-GUID: 83O2yxdrw8c-6ZqzhCSgH7Vh8YKstR1e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX2rxd702mVDgh
 tDRzOizn/aQ+W/or54DH4APT9H62+K26QJiaaDs4c5SOJbzJsq7ogdyOSJzQ5kbIzlqX+1VlCwq
 S7gomkeWve9PPS15D+wNiFujvxIEAIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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
 include/asm-generic/unwind_user_eh_frame.h | 41 +++++++++++++
 include/linux/unwind_user_eh_frame_types.h | 37 ++++++++++++
 kernel/unwind/eh_frame.c                   | 70 +++++++++++-----------
 3 files changed, 113 insertions(+), 35 deletions(-)
 create mode 100644 include/linux/unwind_user_eh_frame_types.h

diff --git a/include/asm-generic/unwind_user_eh_frame.h b/include/asm-generic/unwind_user_eh_frame.h
index e6d207597206..da9bc52a645a 100644
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
@@ -10,6 +12,10 @@
 #define EH_FRAME_MAX_AUGSTR_LENGTH 16
 #endif
 
+#ifndef EH_FRAME_MAX_EXPRESSION_LENGTH
+#define EH_FRAME_MAX_EXPRESSION_LENGTH 32
+#endif
+
 #ifndef EH_FRAME_MAX_STATE_STACK
 #define EH_FRAME_MAX_STATE_STACK 8
 #endif
@@ -39,5 +45,40 @@ static inline bool eh_frame_reject_sp_rule(void)
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
index 64176242b7d8..f7f1234b0437 100644
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
@@ -839,6 +808,27 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
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
+			if (cur + expr_len > end)
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
@@ -1005,9 +995,19 @@ static __always_inline int __do_cfi_insn(struct eh_frame_section *sec,
 			if (cur + expr_len > end)
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

