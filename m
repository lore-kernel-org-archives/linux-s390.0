Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68240F72C;
	Fri, 21 Aug 2026 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342028; cv=none; b=XMaEdRChi0q3MFWR+JTvAZ0LRYUQtC49ym6kEJySORtwnz+yShYnsuv6s2/Z6L2mNfRG97jYTFz/+ndcEhBLLAkacTRrsl+BRm5Kf0FibZiMAaocFvu4RE/WKGNAWYGxLO8wcCORVpt+EEKaddaKPlHA7cZXiJXgl+K67skd2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342028; c=relaxed/simple;
	bh=+QQyByo4jRu3q83Fet4sn4qipXTG+C9lCtCzCGQstiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vB81k0XWqeRMrtppwi1Se3N9jEZ9gA5BriqmAVSkmPdoakHzQ+woRFcNvvX9/cRGpuirTbCrMjneaZqUM0rLoyfkfmtr/6GBH/CCSWraoZqbuAoRIAVq+rC64kH2BxXkFEQB5FpCRNZIeJ5Wltupge7iaI6J50mwaxNJze1utHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aY29g3W4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aY29g3W4"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVaTa2387443;
	Fri, 21 Aug 2026 19:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cyy3ouORVdz0AUfik
	DQRYaQeXKHSUi1nQaQygdWUwpo=; b=aY29g3W4Jkpg6VvGGTszYSOb8TNC9/MTb
	OgS4Reo0Glo7nfoPcR4U15lwk1/HXKGaRF6HE6Tu4U05NRJgDvIxpSpOWDk84VBJ
	OFEopEdosF37yAohal2QTchAkv14xocqU0jIXFMHkXkt8vB9m//7jmH6u7E8V7yR
	o3q2zMxlA1bjYJ7M0dK7EAHHHovyOHI9CbFoyH7HbZPCSrkMi+AzynwTvG06R6s1
	445TGYTGOBusdRw1kpyThkHyzHbbnCDhV8kGXZnd9qFm0M0v/GulmSq4JqkyS00H
	0H3mCCrurP33Isk/YD9ojTPNc5wD1SXX6x0arGkwiFb1ziSeNGOeg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4knrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfKY2023504;
	Fri, 21 Aug 2026 19:53:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twpraj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr6SD37880300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 434DC2004D;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00E720043;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
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
Subject: [RFC PATCH v2 04/24] unwind_user: Flexible FP/RA recovery rules
Date: Fri, 21 Aug 2026 21:52:39 +0200
Message-ID: <20260821195259.2688377-5-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88aca7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=ZPQ1DpjoKQCSDTLUZ9wA:9
X-Proofpoint-ORIG-GUID: RFdNlOL23WL85Qr1CA0s36Ns3096NQas
X-Proofpoint-GUID: MHzCOk0TZ-DLd80RH_QggY9siDk5Qamj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX4GxQtO6w8A4Z
 boQNGSaiEl7WbLicc+mSAa3W3VL3xRuKneRqSsSYV/f6dmnlZJdpasKUmDPQDDLpqT9oFbYHkdh
 5fG0lXAQCMDaGPv0ZTqWVoJyxB+exWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8AYdFc6m2mcb
 FXILWrzRSk9m41DapWpoNZ7zuKwxxcAAkqN9r0aRV/zkyA8/eiZSI4+1zDc56uTV1GORi3hiPPn
 tDHnETHGjRn2gS7LQivbay5bg4VMfC3jOOSYPMhD4azkHIFGcT01JJi3meyD9pj61tX1tQQsIEx
 pYrB6DWrO0tBXcKob5H07nSIM7ftT3dG3E0QWCgH0oOHLzye49GVAJUQ5SpInd0//38KVmRMOTb
 ZEXDInKSwtlQpGyyZkmHbx2F0nOyni31ezv2GNhvTnHI8Aj+t781ueve5WRv2z3x8zqsPkEdRxC
 Iz2BbAd8V1+OjjiNX8O3ZbtFA8CcHYFotgTUeGiS4Y+we2LN5Ph0bxUdbX6BTrPZb2vQN2jczak
 IHnh3gGLC5YTWmsPk7UieVmP0MYAxrtcMPM0nowjaA2jBiauKaIUWrlGIE27ApIjIMNPGmGqobO
 TKu6P7lqIJUDh5RGaRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

To enable support for SFrame V3 flexible FDEs with a subsequent patch,
add support for the following flexible frame pointer (FP) and return
address (RA) recovery rules:

  FP/RA = *(CFA + offset)
  FP/RA = register + offset
  FP/RA = *(register + offset)

Note that FP/RA recovery rules that use arbitrary register contents are
only valid when in the topmost frame, as their contents are otherwise
unknown.

This also enables unwinding of user space for architectures, such as
s390, that may save the frame pointer (FP) and/or return address (RA) in
other registers, for instance when in a leaf function.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-15-jremus@linux.ibm.com/

 arch/x86/include/asm/unwind_user.h | 21 +++++++--
 include/linux/unwind_user.h        | 10 +++++
 include/linux/unwind_user_types.h  | 23 +++++++++-
 kernel/unwind/user.c               | 70 +++++++++++++++++++++++++++---
 4 files changed, 111 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 2dfb5ef11e36..9c3417be4283 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -21,15 +21,26 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= -2*(ws),			\
+	.ra		= {				\
+		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
+		.offset		= -1*(ws),		\
+			},				\
+	.fp		= {				\
+		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
+		.offset		= -2*(ws),		\
+			},				\
 	.use_fp		= true,				\
 	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= 0,				\
+	.ra		= {				\
+		.rule		= UNWIND_USER_RULE_CFA_OFFSET_DEREF,\
+		.offset		= -1*(ws),		\
+			},				\
+	.fp		= {				\
+		.rule		= UNWIND_USER_RULE_RETAIN,\
+			},				\
 	.use_fp		= false,			\
 	.outermost	= false,
 
@@ -41,4 +52,6 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
+#include <asm-generic/unwind_user.h>
+
 #endif /* _ASM_X86_UNWIND_USER_H */
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 941cef652435..b2b1c2572fed 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -33,6 +33,16 @@ static inline int unwind_user_get_ra_reg(unsigned long *val)
 #define unwind_user_get_ra_reg unwind_user_get_ra_reg
 #endif
 
+#ifndef unwind_user_get_reg
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
+{
+	pr_debug("%s (%d): %s(%u) not implemented\n",
+		 current->comm, current->pid, __func__, regnum);
+	return -EINVAL;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 4fc3dd9b4e29..1b5db76e886a 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -25,10 +25,29 @@ struct unwind_stacktrace {
 	unsigned long	*entries;
 };
 
+#define UNWIND_USER_RULE_DEREF			BIT(31)
+
+enum unwind_user_rule {
+	UNWIND_USER_RULE_RETAIN,		/* entity = entity */
+	UNWIND_USER_RULE_CFA_OFFSET,		/* entity = CFA + offset */
+	UNWIND_USER_RULE_REG_OFFSET,		/* entity = register + offset */
+	/* DEREF variants */
+	UNWIND_USER_RULE_CFA_OFFSET_DEREF =	/* entity = *(CFA + offset) */
+		UNWIND_USER_RULE_CFA_OFFSET | UNWIND_USER_RULE_DEREF,
+	UNWIND_USER_RULE_REG_OFFSET_DEREF =	/* entity = *(register + offset) */
+		UNWIND_USER_RULE_REG_OFFSET | UNWIND_USER_RULE_DEREF,
+};
+
+struct unwind_user_rule_data {
+	enum unwind_user_rule rule;
+	s32 offset;
+	unsigned int regnum;
+};
+
 struct unwind_user_frame {
 	s32 cfa_off;
-	s32 ra_off;
-	s32 fp_off;
+	struct unwind_user_rule_data ra;
+	struct unwind_user_rule_data fp;
 	bool use_fp;
 	bool outermost;
 };
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index f8a97d4167f0..f5d68e86d72b 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -11,6 +11,17 @@
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
 
+#ifdef CONFIG_DYNAMIC_DEBUG
+
+#define dbg_once(fmt, ...)							\
+	pr_debug_once("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
+
+#else /* !CONFIG_DYNAMIC_DEBUG */
+
+#define dbg_once(args...)		no_printk(args)
+
+#endif /* !CONFIG_DYNAMIC_DEBUG */
+
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
@@ -63,22 +74,67 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
-	if (frame->ra_off) {
-		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
-			return -EINVAL;
-	} else {
+	switch (frame->ra.rule) {
+	case UNWIND_USER_RULE_RETAIN:
 		if (!state->topmost || unwind_user_get_ra_reg(&ra))
 			return -EINVAL;
+		break;
+	case UNWIND_USER_RULE_CFA_OFFSET:
+		/*
+		 * RA = CFA + offset does not make sense.
+		 * A return address cannot legitimately be a stack address.
+		 */
+		dbg_once("UNWIND_USER_RULE_CFA_OFFSET invalid for RA\n");
+		return -EINVAL;
+	case UNWIND_USER_RULE_CFA_OFFSET_DEREF:
+		ra = cfa + frame->ra.offset;
+		break;
+	case UNWIND_USER_RULE_REG_OFFSET:
+	case UNWIND_USER_RULE_REG_OFFSET_DEREF:
+		if (!state->topmost || unwind_user_get_reg(&ra, frame->ra.regnum))
+			return -EINVAL;
+		ra += frame->ra.offset;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
 	}
+	if (frame->ra.rule & UNWIND_USER_RULE_DEREF &&
+	    get_user_word(&ra, ra, 0, state->ws))
+		return -EINVAL;
 
 	/* Get the Frame Pointer (FP) */
-	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
+	switch (frame->fp.rule) {
+	case UNWIND_USER_RULE_RETAIN:
+		fp = state->fp;
+		break;
+	case UNWIND_USER_RULE_CFA_OFFSET:
+		/*
+		 * FP = CFA + offset is currently not used for FP
+		 * (e.g. SFrame cannot represent this rule).
+		 */
+		dbg_once("UNWIND_USER_RULE_CFA_OFFSET unsupported for FP\n");
+		return -EINVAL;
+	case UNWIND_USER_RULE_CFA_OFFSET_DEREF:
+		fp = cfa + frame->fp.offset;
+		break;
+	case UNWIND_USER_RULE_REG_OFFSET:
+	case UNWIND_USER_RULE_REG_OFFSET_DEREF:
+		if (!state->topmost || unwind_user_get_reg(&fp, frame->fp.regnum))
+			return -EINVAL;
+		fp += frame->fp.offset;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+	if (frame->fp.rule & UNWIND_USER_RULE_DEREF &&
+	    get_user_word(&fp, fp, 0, state->ws))
 		return -EINVAL;
 
 	state->ip = ra;
 	state->sp = cfa;
-	if (frame->fp_off)
-		state->fp = fp;
+	state->fp = fp;
 	state->topmost = false;
 	return 0;
 }
-- 
2.53.0

