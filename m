Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56123563F6;
	Tue, 18 Aug 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064637; cv=none; b=bUmiIGGPnruc7GAF+JX7TLtqDIt08hyhhX+PA1g4OJEskbopb2I8Ra2f88nq/PoOeeQAL7+XLyFIJ9WS7WUjSZaXODAjJwSROuK4AbX1QTAz2UUIOhA38bi5Hwdj6c9rOxPLFqa5C8K2jioMpA6IXsPv1QPwnnAsVjhrxw0iH90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064637; c=relaxed/simple;
	bh=+3LbHmTaeyb9n65LFUSmthJYJBpc+xFIA7hCLqaX+40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m37MybOlsgENfbMwJpj5bWt0KUsDaU6jOExTC1bvHD78SLS5YH0M/+ZkqhKX9KMQu1A/wldrghqGGuH67aD4HqRdNyc/fgPJm/Sf/Ophag7ctohkic5Ui2J2vVWnW7OOXKp22742ePmXKqADP7bjD1ZtQl2Kw2pi2vLv0othkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y30Iuvcj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y30Iuvcj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3nu4401804;
	Tue, 18 Aug 2026 14:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NT/BD775Wlwof0KfO
	Q/x5DI3MH/iSW4t2nY68gCIbmE=; b=Y30IuvcjHDY6l9vUeIIJh/QQeBVdSs0GT
	NOjgO4UEbsaP9rSDR9JATQmVNjbSFomfnrnkYW1mEtl0yzaJTsaKas4QKNNilirq
	+YBK5fGTG8Oq3MzUMWy9vhzqryZLuJagb6Gwiv6umLlf3bIgqI+livUG4yEDa+EL
	7yqEJBVwQ48nI22mBgfdvAL5R9mcpJK2ZT+8vzJJ21mw9finrMNW6oLzRbNcHo2F
	nyBtJksP9Tgu30EsG8tHdR81Z2HxbqU3q/tnJeXtcilXefUYFRlU83AVMTWgo83A
	Poc3UKn0sV3HslaU2cLh0z1iHVq6j4XyZ0ISo8pUaeg35nyq6i52w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm0qne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfLn7025396;
	Tue, 18 Aug 2026 14:50:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh3q5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo4Kp27590916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E9FF2004B;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB95620043;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
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
Subject: [RFC PATCH v1 21/25] unwind_user/eh_frame/x86: Handle PLT expressions
Date: Tue, 18 Aug 2026 16:49:50 +0200
Message-ID: <20260818144954.2320378-22-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0PVimwSiMcw9
 7uWyQkImJx+Wfv/Zko1T8ixGd+SipU3Psv1s1k4FrD3nVcjzsKbyayc3hl4Q11pFPPmtcGL5cj9
 iFtxStFtTcdwvtlewK2XppgLOEx02pEIfvbZinp0Om+E5PzrP3YLXwLpxzvWZtt94rwOdp8jmju
 BuWE5U0TtGRVQW3uLJ5Xk0RLkqLy07qBP8g8DLqAjJVqkIVIBhXYeirkzb8d2+zCkqRKX8o4MyI
 x9G+vSUjVEKQTukDuAndhVXUp7brg8p+nIqbul2On10MueGzBKBW7x0RxxSmCekagJzUKHTti/G
 FMxsXtglGE0hyN0FnPCaDAKGc2nYI7w2ggx+YHXdYqWDSAacoSK6HNCiL147DX2SKLPGaIEBrXw
 cWY8iolHtxHn8uXBUBvOPKsCOp/rRvGmeKFkuvNP3m+6sd+PIl2DAzQw4k2w9tafzyED3azMdQX
 Zj2Ec298uwJnFAMyqeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX1g1FFITT/DtX
 S4gLcYs/5SnVsoqfWWWSZtP+c02ovmyx1FMy+UXnz/kmeLPVVGkMVo+7qOcqVTdB/2U0WAlUPja
 ygCeN1P0YaKnHEFelxwWsp/7aNitBws=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a847121 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lN3RThuQUzBg4E8S6xQA:9
X-Proofpoint-ORIG-GUID: 4txUEljCoj9PvnfGh3eitMbOegyMWkbU
X-Proofpoint-GUID: Fg1UZj_EHgcAEC7mvEYUNKHIPkm15sia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107

Add x86-specific support for handling the CFA expression found in GNU
linker generated .eh_frame for PLT.

This enables unwinding through GNU linker generated PLT entries on i386
and x86-64, unless linker option --no-ld-generated-unwind-info is used.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user_eh_frame.h | 68 ++++++++++++++++++++-
 kernel/unwind/eh_frame.c                    |  3 +-
 kernel/unwind/eh_frame.h                    | 14 +++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user_eh_frame.h b/arch/x86/include/asm/unwind_user_eh_frame.h
index fdccbda2fe4b..8268eb1a0ff5 100644
--- a/arch/x86/include/asm/unwind_user_eh_frame.h
+++ b/arch/x86/include/asm/unwind_user_eh_frame.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_UNWIND_USER_EH_FRAME_H
 #define _ASM_X86_UNWIND_USER_EH_FRAME_H
 
+#include <linux/unwind_user_eh_frame_types.h>
+
 #ifdef CONFIG_X86_64
 
 #define EH_FRAME_REG_SP	7	/* designated stack pointer register */
@@ -15,7 +17,71 @@
 #define EH_FRAME_MIN_DATA_ALIGN -8
 #define EH_FRAME_MAX_DATA_ALIGN -1
 
-#endif
+#endif /* CONFIG_X86_64 */
+
+static inline int memcmp_masked(const void *s1, const void *s2,
+				const void *mask, size_t n)
+{
+	const unsigned char *p1 = s1, *p2 = s2, *m = mask;
+	int res = 0;
+
+	while (n--)
+		if ((res = (*p1++ ^ *p2++) & *m++))
+			break;
+
+	return res;
+}
+
+static inline int eh_frame_do_def_cfa_expression(const char *expr,
+						 int size,
+						 unsigned long ip,
+						 struct eh_frame_reg_state *reg_state)
+{
+	/*
+	 * PLT CFA expression:
+	 *
+	 * DW_OP_breg<SP> + <SP_offset>	// 4 (ESP) + 4 or 7 (RSP) + 8
+	 * DW_OP_breg<IP> + 0		// 8 (EIP) or 16 (RIP)
+	 * DW_OP_lit15
+	 * DW_OP_and
+	 * DW_OP_lit<N>
+	 * DW_OP_ge
+	 * DW_OP_lit<shift>		// 2 or 3
+	 * DW_OP_shl
+	 * DW_OP_plus
+	 *
+	 * CFA = (SP + offset) + (((IP & 0xf) >= N) << shift)
+	 */
+	static const char plt_expr[] = {0x00,0x00,0x00,0x00,0x3f,0x1a,0x30,0x2a,0x30,0x24,0x22};
+	static const char plt_mask[] = {0x00,0xf0,0x00,0xff,0xff,0xff,0xf0,0xff,0xf0,0xff,0xff};
+
+	if (size == sizeof(plt_expr) &&
+	    !memcmp_masked(expr, plt_expr, plt_mask, sizeof(plt_expr))) {
+		unsigned char sp_op = expr[0];
+		unsigned char sp_offset = expr[1] & 0x0f;
+		unsigned char ip_op = expr[2];
+		unsigned char n = DW_OP_lit_value(expr[6]);
+		unsigned char shift = DW_OP_lit_value(expr[8]);
+		unsigned char sp_reg, ip_reg;
+
+		if (!DW_OP_is_breg(sp_op) || !DW_OP_is_breg(ip_op))
+			return -EOPNOTSUPP;
+
+		sp_reg = DW_OP_breg_register(sp_op);
+		ip_reg = DW_OP_breg_register(ip_op);
+		if (sp_reg != EH_FRAME_REG_SP || ip_reg != EH_FRAME_REG_RA)
+			return -EOPNOTSUPP;
+
+		/* CFA = (SP + SP_offset) + (((IP & 0xf) >= N) << shift) */
+		reg_state->cfa_rule = CFA_REG_OFFSET;
+		reg_state->cfa_regnum = EH_FRAME_REG_SP;
+		reg_state->cfa_offset = sp_offset + (((ip & 15) >= n) << shift);
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+#define eh_frame_do_def_cfa_expression eh_frame_do_def_cfa_expression
 
 #include <asm-generic/unwind_user_eh_frame.h>
 
diff --git a/kernel/unwind/eh_frame.c b/kernel/unwind/eh_frame.c
index f7f1234b0437..19e2bc96ddbc 100644
--- a/kernel/unwind/eh_frame.c
+++ b/kernel/unwind/eh_frame.c
@@ -15,11 +15,12 @@
 #include <linux/types.h>
 #include <linux/unwind_user_types.h>
 #include <linux/unwind_user_eh_frame_types.h>
-#include <asm/unwind_user_eh_frame.h>
 
 #include "eh_frame.h"
 #include "eh_frame_debug.h"
 
+#include <asm/unwind_user_eh_frame.h>
+
 struct eh_frame_cfi_context {
 	struct eh_frame_reg_state state;
 	struct eh_frame_reg_state stack[EH_FRAME_MAX_STATE_STACK];
diff --git a/kernel/unwind/eh_frame.h b/kernel/unwind/eh_frame.h
index a43560486283..2f87d1b32bbc 100644
--- a/kernel/unwind/eh_frame.h
+++ b/kernel/unwind/eh_frame.h
@@ -60,6 +60,20 @@
 #define DW_EH_PE_format(encoding)	((encoding) & 0x0f)
 #define DW_EH_PE_application(encoding)	((encoding) & 0x70)
 
+/* DWARF expression operations */
+#define DW_OP_lit0	0x30
+/* ... */
+#define DW_OP_lit31	0x4f
+#define DW_OP_breg0	0x70
+/* ... */
+#define DW_OP_breg31	0x8f
+
+/* Helpers for DWARF expression operations */
+#define DW_OP_is_lit(op)		((op) >= DW_OP_lit0 && (op) <= DW_OP_lit31)
+#define DW_OP_is_breg(op)		((op) >= DW_OP_breg0 && (op) <= DW_OP_breg31)
+#define DW_OP_lit_value(op)		((op) - DW_OP_lit0)
+#define DW_OP_breg_register(op)		((op) - DW_OP_breg0)
+
 /* CIE/FDE constants */
 #define EH_FRAME_CIE_ID			0
 #define EH_FRAME_DWARF64_LENGTH		0xffffffff
-- 
2.53.0

