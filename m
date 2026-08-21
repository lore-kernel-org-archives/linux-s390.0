Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18989411A04;
	Fri, 21 Aug 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787342029; cv=none; b=nCh2CxCN/tRmtmFOJRxPKIu5JBO6AwURm5sPOhoMfaXFWPplRGksOyBfsWIPvMGcwWeu6l6v7WhYvfNkJU5JZDp16UiUi//ds9AJmku5xGdCjwuUnd9WKisvr3s3DPx4uMZZBZQrcmA+QHlhQ/4PbnIVrIGJXE9D9PRFcO56CHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787342029; c=relaxed/simple;
	bh=uHi5IOcGGygfGL5thWHRKIwx88fWG7DAaRDICca0tMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0XYwwhJZZSTr0znqKm2hiIIdy8wa/KojV4/4/PuR6wE8mxRVhza4BG1UtuOtugSUIpOdjaapP52jybVmOZB0VzkGYqrGgIjrZojSHU3xA/i7OvPXTRbxGUnpch1ezDs0Nw0xwY38MOl/+rXlBG/GT+YkqI421bazIKG2gz26sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j0AsUOwd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j0AsUOwd"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LIVc1Q1237144;
	Fri, 21 Aug 2026 19:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vrh5RBbBhCeKqV2rA
	nv4MPSnT7EeQLGUnEJ73SuzaIY=; b=j0AsUOwd7sKagcWYT52cBPtHfQbSGj4r6
	fvN4mVc2OM/ad51q6hXKtj/H1Z8XEo2jiCbmU/Fu+xcXdz8yw6XFCUbChMm5YCYP
	jl8Uin4lI1TSCiFoCYJwk/V+LeYg71LHGEdy4aTH8eV06GpsC2BS8QzhM1KPowV5
	yMoPudx8pQ7Liu8s6hzE4CSMCA9bXWCJDQT3lytCNZ1N/xWg2W4K9Bl60o651jh8
	xnU/CtDRPiF3JNHH+X3TjJLcJGfLZk+VUFyF0QWAZ0q0DYv0EJtADq6ifJ7AV9Yv
	FmOP5ZYCMfHrJTYL6gHpRaC6M2JbxfnEy8LsKQOOhMCNlyYjli5ow==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu2kr04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LJfMOS021134;
	Fri, 21 Aug 2026 19:53:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekpnxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 19:53:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LJr5pp41746868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 19:53:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4F5320040;
	Fri, 21 Aug 2026 19:53:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6571E20043;
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
Subject: [RFC PATCH v2 02/24] unwind_user: Stop when reaching an outermost frame
Date: Fri, 21 Aug 2026 21:52:37 +0200
Message-ID: <20260821195259.2688377-3-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a88aca7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=_1qlYuAciRtwIPuEvDgA:9
X-Proofpoint-GUID: 0cDuk0xmKFQnbzzqAfQDY6swoHXWnBkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX/wdTe+ho5TvF
 3NJTVBEVQMkjvsH3LtpI/3Es2Misdqnj4cuj0xE+v2cJqkFGHDoKybw8VvtvvGlO3Cp6CUFIS5h
 Zv+tEnl8HCNgfQDDkAx7ee3y7+Y46Z1udAdP1FC9tcuKtegpYcxjSt+CZS4DM3B4zNRzI6BdiST
 bWUZA8/TgE2eVX1UH8l9or9w9inaH/jESHbo0jgrac/iINgR/zTJ94zkLBjU9gF+ZzwTcgzdOya
 c+SV+e7JYOZ6maMNn7SDx/34fNldlFqMkm0fcXFJCshKXMQNu6iKtXYfOS/wDL9PtFyV+O8jKBe
 p2vnG6r5ip137v9jRLI4wF/3i5ewgiaRvG0+SSvECkNVtjDeZb48IitxthKVdWLCGR19oV+8bG7
 ir/h2TBu33zsPeslzweB76sFxRm4zhjyQsRf2Zm9Rx6de2zvu7MyC2WAyevPETn38C3Xqv2Tw5j
 CnOfK3N3L1lTSxLcrRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE1NSBTYWx0ZWRfX1s4UY+Dwp0J5
 HHoNfbBzykp7/qLKNFwgj+HeLMURVAxOtj0uEchxbMkpToQacbgDBQwxO02LOk9+ULqwjKY4nbH
 P614W35Qtbf6cr6l0iPr5WoCeOjElXA=
X-Proofpoint-ORIG-GUID: R9ZlvTLoT11pr4ui7G1Ybppm5xH2cl_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210155

Add an indication for an outermost frame to the unwind user frame
structure and stop unwinding when reaching an outermost frame.

This will be used by unwind user sframe, as SFrame may represent an
undefined return address as indication for an outermost frame.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Cherry-picked from "[PATCH v16 00/20] unwind_deferred: Implement sframe
    handling" series:
    https://lore.kernel.org/all/20260521142546.3908498-9-jremus@linux.ibm.com/

 arch/x86/include/asm/unwind_user.h | 6 ++++--
 include/linux/unwind_user_types.h  | 1 +
 kernel/unwind/user.c               | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 6e469044e4de..2dfb5ef11e36 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -23,13 +23,15 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
-	.use_fp		= true,
+	.use_fp		= true,				\
+	.outermost	= false,
 
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= 0,				\
-	.use_fp		= false,
+	.use_fp		= false,			\
+	.outermost	= false,
 
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 412729a269bc..4fc3dd9b4e29 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -30,6 +30,7 @@ struct unwind_user_frame {
 	s32 ra_off;
 	s32 fp_off;
 	bool use_fp;
+	bool outermost;
 };
 
 struct unwind_user_state {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 90ab3c1a205e..28091ece830c 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -31,6 +31,12 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 {
 	unsigned long cfa, fp, ra;
 
+	/* Stop unwinding when reaching an outermost frame. */
+	if (frame->outermost) {
+		state->done = true;
+		return 0;
+	}
+
 	/* Get the Canonical Frame Address (CFA) */
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
-- 
2.53.0

