Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E6389460;
	Fri, 21 Aug 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342031; cv=none; b=iGCUvs4JRiKfEUuaVkAS2oWHqwe+VlfqwsTDvBgs3OePNlNUGurI0O6rTGDokBm8xZ6X14f7zLqW2rCTNaPfu7d4S87XU3h06dtjqWCzA1j7WWsP7o2eMz7vX0ljnK9ih3MMBIJ8CCUShJ7MTtBzAsLenjkqyC44Xfx27Vwn+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342031; c=relaxed/simple;
	bh=P1YSpG+zs128CymzdiY+3Nnu13S/UugxwgcnR7b8GMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lATJA8LYh4acshqbzAYMzhA8I1IidSL+128T4MeaKxFXiT6tgoLQCH30zhpXGOAmx24cuDKixLGswF/bXcLyqsjlri1mbru7JiQU7zj9oYGjUAty/MGsmduYXu7BD0Z9W2h+feg+KsA5VN8Y376G2mhgDryJH5qbvOGxl0OWSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LA0Fxjgu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LA0Fxjgu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVvZr2253873;
	Fri, 21 Aug 2026 19:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Py6xfwdNsaHG7pzwS
	kL8ia98s+iXudOl/0MXjctgP6Y=; b=LA0Fxjguezwj2uyYtVMXWFKD+lHn75WtR
	/oVq0GCT6DUHdXq8XSQbzRkKIpDQNLhPMeRQT/8SNDonFv8bJ/BnZVDkkfDg8QXX
	JdtjSGlH3bjtz4yReTUJC9xrPNg+dn4RgBqXm5OsjU3+iOy76xEEJvnJpm+jnUKv
	B56KSf/3lX52or1F1Bzgi/0+43nrvESXuMwOYSa7s33tq+1FU6qrC0Jc/1dmUG5N
	IUphwQ458Ut2N7BqXlfLhmsVi11rm+oYmMLacNuCRQvf6QSF9kNLtGh+7p+1LK0B
	0w+euJ9qe7YT4TzRnVtM6xKYU6BCZ2S5OeTLoZ0G+jLijETGQ/vGA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4krms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfKUF008731;
	Fri, 21 Aug 2026 19:53:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yxdxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJrAI710420484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEDC20040;
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9103920043;
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
Subject: [RFC PATCH v2 20/24] unwind_user/eh_frame/x86: Handle PLT expressions
Date: Fri, 21 Aug 2026 21:52:55 +0200
Message-ID: <20260821195259.2688377-21-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8saOyv/gDEtr
 I7GxitEGxzBXqt1pRVMFNJZ4RmtOzWAeMZ+j6PmPFareRLK4ZFIr6J5+Dj9Cj+qfE2rV/DX+IJV
 tEbrIuaxINysFcTKQJnewbmwsbZi2PI=
X-Proofpoint-GUID: 8Pcb3teDPGwBNila6rlEwAYe63BXY_49
X-Proofpoint-ORIG-GUID: YhFiri8BotwIrQ0cszGGj9zx1iESGqcp
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a88acb3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=lN3RThuQUzBg4E8S6xQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfXxTMwDFTKXbZm
 pGZh2l9Z7VR4zY+X/cgKMfpT4fNO78LDpTFCBxiaOAQdhFR5sSKTx6QvwcWMq0BpcaDEbX3m/DC
 w+mBr6FWnoY6yji98ZU/dI0S6itM5NbJzPP0ZMzHJSuy1LCsrSXhxwULnDfvt+rSkqKjXLXCNbt
 TsJYkfgg25wAw2YcBR+NYJ8EqVLYErLvQn6zQbeWIe5bGFLVaG5oWHHAQyEr24hID6eRCVayuYc
 lLAjkvxRhEforXMgyIjojcUyzh8r31cDQaI59nDNno4o6R+QoDpyx3N5VGyszBso71RcpGHY5hu
 S/t5o2QYHzYZRIgIcG1Bjo7EwH7TvErx5d7JfwWX6AsF85QW0MmlYPCVsA6ItTPmwSF79C5aG94
 oFuek4rl0KgmKGDHUZvAYwW0RbubhBQtxL4qfp4X3H/8TBm4R6kqT+fA4pjnpWOa+yMWt9ikBUo
 LDIYUoMRiKLyCN4ntdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210155

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
index a98804dbe588..0a81ba1a0377 100644
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

