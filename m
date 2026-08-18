Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0F33A7F60;
	Tue, 18 Aug 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064630; cv=none; b=f0AHMwmxsckohf/mod5XjQLK3+Tx93Lk41Xz1vgSOrtgC4zgZkj6hi89ES68aEBdXRGaJihnVVwQaea9U6vvQX2Tfcv2AGE/cJPA9NvCYzqxkGd8DOWe2a33M70tiw2ziohJ853V5VtpBSsNILCw/mo1mRss4rnO3PgzlnTHfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064630; c=relaxed/simple;
	bh=uHi5IOcGGygfGL5thWHRKIwx88fWG7DAaRDICca0tMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGovUJxKqnakMFYoaCDPyTQpKgRgnoLfd6X7Z5SUImGOtoLC7TSCgmf6C9ck0AFFCC9Rk9+YeojocMrNGRbr/hgmjDcuDYFgzVC8HeoGScHne3ubTmBIfCNlVo4EoBzNUrq/oAvoNT048cHV/OgXjG51EXHuZJtGp1LfWqcMCdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rkvxq6nn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rkvxq6nn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3c0F542431;
	Tue, 18 Aug 2026 14:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vrh5RBbBhCeKqV2rA
	nv4MPSnT7EeQLGUnEJ73SuzaIY=; b=Rkvxq6nn1+qQJ+u923OL9iIAVTCxVZIWP
	MFrEp1l99xf+b682ro/Be+q77Z/thz5Qm2+aSQuGTivuYgh6edxGsMAfTVnpSwQg
	RmEJdzftBfwueLc/61R5LMwKMvx7n8RxALZrbAAMKHzUfCQJYwKARiXlA20OC6G0
	qIFbg7S9i/1l5IcT9es35/U7oi7bAD3m6yE2tGTm+yDO6l9dIfHFxFKqmlcluzbv
	GEnSPnTrQ2mSwsmnbKJfIoSEKDI3S9GYzFwkvNmiEiwp3qpO1GpVEujZDbBXmYZ6
	4fqJOuA9/C+aECldPFjzGgSkhcwZ/2C4TGFbl6q/rGIMmChuKy1dQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8bs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfU2M014833;
	Tue, 18 Aug 2026 14:50:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3r6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEnvF247448326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:49:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AC4520040;
	Tue, 18 Aug 2026 14:49:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52AA820043;
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
Subject: [RFC PATCH v1 02/25] unwind_user: Stop when reaching an outermost frame
Date: Tue, 18 Aug 2026 16:49:31 +0200
Message-ID: <20260818144954.2320378-3-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84711a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=_1qlYuAciRtwIPuEvDgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX1HgocRRzc6g2
 9fzKEgl1nshKcnTWQyBY0Oa2ES6LmJWSHHb6gK2AJUdaTI+ifxZ+rnoucB0fxGXu20M6zlT1oKR
 iEraWTq4Ax+ogTPPaEGiOcJvx8uOf6I=
X-Proofpoint-GUID: BjcQdVBPIduTvG0QhKpfaWkmmsN4oxp5
X-Proofpoint-ORIG-GUID: c4yxkrPBATvtVIzOd_MAkONSX9IU3OHG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX1ENGtsLw745t
 4KzZoMlltsUQ9jvdKFpBaGApM7jCq7Vghv2c0icJDDU33683t7kspW+QJaH5ioT1cct+fv5YPau
 iEBUEsqp6VuZVXAewSV8UC+9ohhtycjwaioiCV15eQKj5tw4iOsu6xpTHz/jIOrAoyQ9NXB88xd
 rqNWXaVtuq1q/9LFT2lEXM+lEm3H4LZf4LRGYrJu/qPUFb68xnmn8poviqZtylxi3Bg3q1alEy3
 +W6zFtEOvodGTaTu+fcpvOxL7ReotZ5AXBc0x/X14KB4BrCXJksrWkLSxu2KdPrzFBSYwbB6Ym4
 wqmc85mnYrPuE0UiN4fJSV/8/2yx32pkwQq9dOy88u4mCTdNxmPDBr9QWDRk6PkGZLaZs4unSe7
 lDTlt5PXDKdsh/MX1zFzoBFJI6img3XWzdIFAybf36vA9aTS3XP78hn9VtD6KU3bdsG8do27r3j
 WNZjP2dweftf4xMafBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

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

