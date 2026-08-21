Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343842125A;
	Fri, 21 Aug 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342028; cv=none; b=ngJGM/09hyxWlRVM5ilS3kx82ApmoTEOVmUAOVOekKO3o0hZreIPUGutD7GeiKv9zQrZy1ZXMvdnuOudgtRCvjFsJOWyrp67SEsD+iIEzybHH9RwrrYvnJu/D+PG2lRNmtBuelyi053ek7L4eLuXWljjSn2oh0+5WYVb3qf+Rv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342028; c=relaxed/simple;
	bh=pxvnkWjyvllmDpNuTjBidERmsTqRP+y+9EN7+vcXhiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq11V3btJqvYMhEaE3mmoFsGM6K8vQF9dQxeDWByx5ut9WJpJHD2tqmmnZfAkAsv14z+356sX9eDWJ5UlP19/7Oms+cqf8yXHFYGjap7rxtwCgEpUXXmXkpf6w1iNWDJ/8nd0P8k+vFSEzioZ+n1Cr14qbePZy1VxrDgRlitrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NdIlQRu/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NdIlQRu/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVjBw1237461;
	Fri, 21 Aug 2026 19:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OutS/vKpuqD7JZiOr
	99VKYen3/kOqOdagaSdljOjgy0=; b=NdIlQRu/4PthyVsqP3+CGi7t/1HkR+DJg
	Ozi8jpoKyFzVrrInkiZXoIE424b6+SFPlzQe4Wv1NVOugx0+u0jUYsOmpZh+gxVt
	aO/wlR+8XMFYeqi71mvSSUAi6W+Kz2pt3uptl6K5W0e3RWEdpSVKuBsqoGwvaL8y
	RargMfrxeiykKtex+lrjrdVNEPPXOEmHNB2PJCo9iPS3PIJNVedkpN7fuCjv45oN
	Qx+XqDKzZ60W5+W1reIiiO9IPayKhFE8MTcv3hQA4VuctiEJyILtyCwUmBuJLpfW
	/s9XB3mpvONdL/sLMViWojJT70ZOdWFm/WaA2QZyxn43RfdZZhxrw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2kr1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfI9R021072;
	Fri, 21 Aug 2026 19:53:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpnys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr60Z46137670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8562020040;
	Fri, 21 Aug 2026 19:53:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 481022004E;
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
Subject: [RFC PATCH v2 05/24] unwind_user: Flexible CFA recovery rules
Date: Fri, 21 Aug 2026 21:52:40 +0200
Message-ID: <20260821195259.2688377-6-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88acb0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=IqD6mcJyx09DUBNVDg4A:9
X-Proofpoint-GUID: lLxlrY8gj3mfUTUoUEGao8MhjkwExcyd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX8Lh9yUaIeOJu
 xVnlERrOrFCrmuvd4MtHM6CqO60dCb11u2xHFZeglfHDG9VRT2ItznnX0jgAtDDzqx+IKGWRN12
 jWpbOC+RzBf+HwIlnXgbMc/WJCtuHzjcMuO/vv/XQac1SWExX7RtLrnfXfrcSgdSWnNAgyFSPVi
 mgEqm1ku7qq4qRjSQWBLPT9W28Quk02J61SbzihDt0lMpTbdlWbnXocwIrsYgpsG94AuBCPkRaj
 ywAdbDT3R2WoVCSJ6oYN3wfMdha855m+SNo9hHTEJzUqAsnJoQLGt+CgrzAkg2OjNPGiJYTbely
 2VqyD4+g2LIfgXEG7ItL0Vvj6rmEaIjMmLJjO3WHa0jgQ0v3uydzP0jtwxFygmQ+BEMr30k3sk3
 BDCA9OT/C6oSCe/UmAp8p69Te4Gdr7Fu27ARcGzdFxgOBzZpzEsAytc2+mW2t1YXh4Z97v6HJHE
 FQ44hPpVDY5zUaobynA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1VsN+SodhfZK
 O2F6dGbrYwuLGSb4vDhhx/wzGBrxQhkSLWhDGucLSl5KSLvchq2s/4HMQLH8IZpaRwzruebb7Iy
 Vq6bTAd0aNi7zDxvaHi87RXMQbt06Fg=
X-Proofpoint-ORIG-GUID: dLuG5Fx5nv_AFLS0cvVlqu_zhdwyNics
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

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

