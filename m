Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036136C9C2;
	Fri, 29 May 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066699; cv=none; b=tS8FcaSzLvfxMKOub9DZIXSIGaGBvOrV9d8Rk1bius8ICHWNoKLbpM2PR1wYrb2lJOpMtOce3eayy03zRQ5T3xo0dp5ghpg8GFKDqC9BaPW7YP/gexMqLT8bIaZEQmU5Z0TKIjK6xsBiDGrV1uiIlxZqZDomVZMcSg94pDsckBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066699; c=relaxed/simple;
	bh=UlEGYP8jSj19m7y5UJVI2ZyhNH8EIvLeJPip/Lv2Xuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2eQ+H+laUxRtUVs9AAWf5/iFJo2mEuIJmuHiMYxmi7aTrbGw1vLx77Dvck5oHMeu9sJLMu0KeGHmvs8LhYTXu8zrKhTczLA/rsDyfo3R6zZ4DxWjz64QHqBkNIEuCjaOOWE3GA/fw/CHn1srqNxrjqUwbqoCXE9QhL8Q4QYPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U4/nFoQv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U4/nFoQv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TAosco1684644;
	Fri, 29 May 2026 14:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZbqJ94R3zv4TlxZ4l
	Pc4zdJzKpGMXMz18Ox5ufJCyYU=; b=U4/nFoQvWtpnDPs5NgsviOC9xALQgm6ht
	MnvJAEzEqiF409LHTXoo0Wn1FI4dEGETwT5OusV++kQhYmsY8RqPVEVOazPBVqdw
	1Uv8EaaiddI6dSFBUQW2iD5evAyr+RbDSfSLPVJ3uLO7rsrg9smtYcJwRDKpY8ZF
	bR1FOgLOblJKR6cOmaRlz/blB0vjxD2oIBP3jp0CTPu2rmJqvKMwfc6s52Rnwqlv
	QRYnKs+q04vXn0WUdRaDwRZa7en2E/25GCKLc29HE5aokAGYJMmFUpVRErIjpJDs
	e3pX1zwNJ5NLAzi30h2RrhzXwPTkTg5ytOgYlUsMvaDErpbktnIuQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884jkk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs73q011911;
	Fri, 29 May 2026 14:57:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbf5qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEvt5l15073756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:57:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E786420043;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A19162004B;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/6] s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Date: Fri, 29 May 2026 16:57:48 +0200
Message-ID: <20260529145752.1209016-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529145752.1209016-1-japo@linux.ibm.com>
References: <20260529145752.1209016-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19a977 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=_2yia0w1AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=V3UG4Yqg79Bxd1UTefQA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-ORIG-GUID: R9eW0Qss0zsCCnEpJgtD5pbCm2A7AZMZ
X-Proofpoint-GUID: dxxobNePvy5wUELnQsC9OtlomR9g9tqV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfX3BisU75UTUcD
 FyJkXJ8/DfRNZm2WWRqYmM+uOudw8RPpASoc4OE8sbchcXc4LeEKM0bAspMVowir3nkMpZWY5fb
 uCArFUjQZBRbcZC/7DRV34trPhTfS3jjOevsilk3pw9LAzrOeywedBPjuWbeuNPfsz3Qa7Obttv
 mVroY6jwrnsv+boz/FVcq5/0WspxiIimkesfXZ4lji97ajFH7mcz5cSY/RcrphTkx1sAfaSMgCJ
 Tez1KJ6nq3xetAVEXEtLpq1yK+luUYLkw6ZbyKYNyakkXh03/8ez5NZGVz4ibU/zzmvQdk4z3Yq
 vZqgwjC01tOWHH8WxA5kBUgdherdBPNwi9GlpA328S5lDP7lxLPTYyFbsYqyCjOVFsSSJJ+niZx
 0kKPuRZkuvbT1yUAL0lrmUUWg20e+AU4+7LB6TA9/O2AXXzaY6GW82SohbkLkSU+wzVMLUR3qj3
 w03f6k9+3kB+nLbOfeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290146

Rust static branch support needs the s390 jump label instruction sequence
and __jump_table emission in a reusable form. The current implementation
embeds the sequence directly in the C asm goto blocks, which cannot be
shared with Rust.

Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
describe the brcl sequences for the likely-false and likely-true cases
and to emit the same __jump_table entries as before. Switch the existing
C helpers to use the new macros to avoid duplication without changing
the generated code.

Acked-by: Gary Guo <gary@garyguo.net>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
2.53.0

