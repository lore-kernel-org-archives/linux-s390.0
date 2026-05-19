Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536493546C8;
	Tue, 19 May 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203572; cv=none; b=BwDKi5DF1z7hQd5vTEUkefq0OnOHJZUm6JAmTIrlqfrPjxvWoCJoLClkTrFDAH9ErvIhqcs1DGWmTepVT6dXVICSVftvf+O6hu3+Pw0EKNsPrSKBviKkX0EEQ6q+mtGxoYTWltChizdshQt7m88ga7xhf5n00otgC+m/ctrH7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203572; c=relaxed/simple;
	bh=lewZg26xmVIa8Tr2DFlPkAVbD6QPjysyvwqJ4rRoCxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZX1tlMuDOIQEvpOd2wh1uCYLiZjFPyP2Vea+tMIw/cmhocSNX8gASfHHCiejoSvYQqILGX+PTVyrM6vMOHjp5UmNU/NTBDVxSZbSE1ChqmhMCbrGYx8s9jC717aAWM6uI043lBl2Q9uhB5PMs89cPFFwjw+MWhR7GaiUJTRxlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gfpEkDIJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gfpEkDIJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JDvHEN271835;
	Tue, 19 May 2026 15:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SATqmbSFXwW8xUoKj
	K4Drkuv8iE2NRpd8ZZZ2c9B07Q=; b=gfpEkDIJU8MNGmAtbXezr+IL6cAJss24Q
	Ro26NJ0BgibvF3jHaim2FZ6PY1tTSCh6oeqDh2CzKlRqlH816ROiwAJjiXHy82H3
	nc09d9KOfxmoju4DnXRV3H66XqzQ3KpipfFf5XeHZLU5+yDsdYM8Lknu06o4FyQy
	uurwPYvKLj9mZVNTE9KXdqTjWk0nt21xzOum9t/weyQIcCo+F8ZhVXIsTfvzpCFF
	RAjKX2X6kRoB3NYmzqkiTp+QfAzYUSjkZk2z2h+9ZCMlPnAMx0O6HPhnmDou4ugD
	E+HLrdzq9914MrA/h55cMvV4vPWKHTLoE9g49hDepYCdwCEYPP2Cg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74wpr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JF95BM025387;
	Tue, 19 May 2026 15:12:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk3773-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:12:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JFCTnX46465434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:12:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF33A20043;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77B2F2004B;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:12:29 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Date: Tue, 19 May 2026 17:12:12 +0200
Message-ID: <20260519151215.1611802-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260519151215.1611802-1-japo@linux.ibm.com>
References: <20260519151215.1611802-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0c7de3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=V3UG4Yqg79Bxd1UTefQA:9
X-Proofpoint-ORIG-GUID: 7vqggdS5slUs2XnpKBuKGWZHvH55Gnc7
X-Proofpoint-GUID: MHmFfRHtVh6tPTCbpMI12pqHbaRrQl3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1MCBTYWx0ZWRfX+hXUPMNc5joK
 PJ3ssRTNTPyXSLC4xr2ULNyRhrfJcBTHO20XX2rl+DtDDTWZOR1Exw/cUwO1lHR06Wm5yRXbNiD
 IKze1R9ej8rUVn1ikXESS+sBWMVqiEZHcbgXMJq1AwBKSCen6c7YQYzYccUsoNS7bJ7x+ZjggjM
 4qRtybBGqr4f1wFOHo/jg2wJ4H+LXcWoqaQ+ugw4aNmbs/zTKKPvYHRMDjomezm9sC4BZyyrK/7
 C5TSNKPvIF72WWpun/ib5oU0veD/EgktaSZ6q8O4jTL0NzBOT6OTtV9g/dUPGlVW4P/jKBEHYOY
 R8pAI0U1FEW5cDV96kdJgKay8mFcr2utha1LZdnuC5OFYW2ras3CbVFdHUlTXdNVMDYNTj2zuOO
 yvl63MjF8g24y7oTuKHRmkh+R2WF4kNYsb+bsNxkafIemM7Ky5RLnKgiVlgHCDNucS4oUvW57C1
 BZD89VonzbVcVz6XxaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190150

Rust static branch support needs the s390 jump label instruction sequence
and __jump_table emission in a reusable form. The current implementation
embeds the sequence directly in the C asm goto blocks, which cannot be
shared with Rust.

Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
describe the brcl sequences for the likely-false and likely-true cases
and to emit the same __jump_table entries as before. Switch the existing
C helpers to use the new macros to avoid duplication without changing
the generated code.

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 arch/s390/include/asm/jump_label.h | 33 +++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index d9cbc18f6b2e..0e28c90dc242 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -19,19 +19,29 @@
 #define JUMP_LABEL_STATIC_KEY_CONSTRAINT "jdd"
 #endif
 
+#define ARCH_JUMP_TABLE_ENTRY(key, label, local_label)	\
+	".pushsection __jump_table,\"aw\"\n"		\
+	".balign	8\n"				\
+	".long	" local_label "-.," label "-.\n"	\
+	".quad	" key "-.\n"				\
+	".popsection\n"
+
 /*
  * We use a brcl 0,<offset> instruction for jump labels so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
+#define ARCH_STATIC_BRANCH_ASM(key, label)	\
+	"0:	brcl 0," label "\n"		\
+	ARCH_JUMP_TABLE_ENTRY(key, label, "0b")
+
+#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)	\
+	"0:	brcl 15," label "\n"		\
+	ARCH_JUMP_TABLE_ENTRY(key, label, "0b")
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("0:	brcl 0,%l[label]\n"
-			  ".pushsection __jump_table,\"aw\"\n"
-			  ".balign	8\n"
-			  ".long	0b-.,%l[label]-.\n"
-			  ".quad	%0+%1-.\n"
-			  ".popsection\n"
-			  : : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
+	asm goto(ARCH_STATIC_BRANCH_ASM("%0+%1", "%l[label]")
+		: : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
 	return false;
 label:
 	return true;
@@ -39,13 +49,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm goto("0:	brcl 15,%l[label]\n"
-			  ".pushsection __jump_table,\"aw\"\n"
-			  ".balign	8\n"
-			  ".long	0b-.,%l[label]-.\n"
-			  ".quad	%0+%1-.\n"
-			  ".popsection\n"
-			  : : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
+	asm goto(ARCH_STATIC_BRANCH_JUMP_ASM("%0+%1", "%l[label]")
+		: : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
 	return false;
 label:
 	return true;
-- 
2.51.0

