Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD663A7F41;
	Tue, 18 Aug 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064629; cv=none; b=O8wZQdSMI6R7UU6jrKH+82TVPCx5pOxmu9O06QoRsnBUo3W06JZlBRnF58ijISM+epcgBZcQkoiata7J6wVarkdnNg0KnrZ1XBzIIh4S6t88vIHi3YjgO4Urx6JevsIcgo/XhjpEL5RHUg90UoWMGBhgOBJh1hoFbjWZgxr8rBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064629; c=relaxed/simple;
	bh=+QQyByo4jRu3q83Fet4sn4qipXTG+C9lCtCzCGQstiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llYjmDyJtG0AIMim7niIst9F4TpUAdUG+3rYH6Zp706wI1tC4QETz7eR58ZcMEp01tavxxWSIYZ2iLuPZwaVw5JQMz8P3VL7HtxD18y5ONgKZHPLLLrUOv2p9YzdN8/WTPQWkt7KSp+zWYnu0MjFS11Im2oojwj+RES3+QRvwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/fuXXEp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/fuXXEp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3gtk3582598;
	Tue, 18 Aug 2026 14:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cyy3ouORVdz0AUfik
	DQRYaQeXKHSUi1nQaQygdWUwpo=; b=f/fuXXEpHBYBx436dekrjrjdYiX96FBym
	KenBAoq0/Kpi7S4W+IsRnTK7g+UsK7p3Do+I/3h0wh1JuQgyTOiUPurHgQvgZH3w
	Z5PO2GhIqyI8vaDoa10rSo+sxxWT3vv/LsmwdMlW6/3OyL+6NTD0RYwkVEQF4rMW
	XylBPxdx5kRPbZvg+d1nuFg+mrPBZWccGe1HBF3jSMn5NhIJggnphq+GdEruai9i
	66FTTSmqUbZP3V0xrXOyWBQZXfoV9731x07K/aY5PJEkP6L8ULIGWm149Q2YxxcN
	1DsDevwEwOk1KxeaeZdSbPU5wY+F3fM8AOiGcWiaKKpXRDO1wz8pg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe8h0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfOQ8025421;
	Tue, 18 Aug 2026 14:50:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh3q50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnwE226804504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E74720043;
	Tue, 18 Aug 2026 14:49:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08E52004B;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
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
Subject: [RFC PATCH v1 04/25] unwind_user: Flexible FP/RA recovery rules
Date: Tue, 18 Aug 2026 16:49:33 +0200
Message-ID: <20260818144954.2320378-5-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXyxtV/3S/mqYW
 ZbZNKYQGpYKLekCAmQpoo2GhhhbT+mwHHKAdreBgHuzSCMTqwhiuoRZ614TJBGdHGIPQALjBzTU
 /w9yRoiW6zSO8wZ8LoLJHVXvVYCNIntlUPxLBlQ3r6Vrmr53AnBq04UWh4SQSNrkgSfp3OMX+qK
 3Sbse5/D2Z3h2PcJqR9eWlRJBQ9i7jYpeoASl5E0s53TjmvFt0AxbWdItHWaEIhpwb+mHdu6XZa
 zsrP5jo5ysms17Zcz/kww3p03ApMMD6HXwME92cFn+quiNTJC0mpSkwUh6ag0CHGiOTmZr4SiE8
 wFyLSh+LstCGvX/WaSFbpzqxq1wSBVwMXQpyLqy2uTbjxcItYkn8MaulxRnFNUYYa+xrHvcJ978
 4gpnAkbNavSf/m5DNQcfD9QdRyLfCZAVhWu2jJvu1S/4orPYRKyQbjECCadDZiPN9wSE2TJLZ75
 5fJINUrZaGHMnmjelJQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a84711b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=ZPQ1DpjoKQCSDTLUZ9wA:9
X-Proofpoint-ORIG-GUID: jJpqNrZ-Kw8rl0Cis7oREJVuEePW2isf
X-Proofpoint-GUID: RlH9MfvZJiHdJU40lmDPVAxyRtMG-7GA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX2KWEujZhJwC/
 PFP4zi8qeylENOcuwcTJspTGVwjnWrZsqW6YbwBBl8P5plJuuH/Lo9NfgFtb6FCPVynY8qh/O0e
 hbrBpsF5wPp7LLAa96hcdF7/qlhsD/U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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

