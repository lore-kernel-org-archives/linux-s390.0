Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAD3CF95A;
	Thu, 21 May 2026 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383013; cv=none; b=QQNghhtKDhofFJyuKOCSWzivEfAmmnIl+J9k3QWVNP8UWqlXPvFGoThNKG+ol1/pjlqSbCBI6PUsYdx4PeSw1YFjEA/pt/TfbS6TPK+nzGym9bxUiU9jp9U4sXeJwooUC5dqkqoYjBOEX9VHdPznC9/jQLnQF43QKIUkmzat6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383013; c=relaxed/simple;
	bh=lewZg26xmVIa8Tr2DFlPkAVbD6QPjysyvwqJ4rRoCxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf2YjUkLdAic2Xat0ZYslprHU8Ufz1RxYKGfNjgkYPFptKN70XIZa03Y4P2DAlX6AAcct3XXJlIVq9AOUsPCSEFW2/iJ55H/9aRwvf3qyyAu1MD3R+AavWDUgpEh2iarWcHqEppopxqGAStiAunXDlABbisMMOSfK9xEdkIOoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MfPQadVW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MfPQadVW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGuKIK3690499;
	Thu, 21 May 2026 17:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SATqmbSFXwW8xUoKj
	K4Drkuv8iE2NRpd8ZZZ2c9B07Q=; b=MfPQadVWsu7TP2n/+pILFGRakAdxltJU2
	yN/3aExwRgjb0yEUZng86FAtjXPffBHZWqs1JJXdVklOUgG1RkBj5PMXR73rlpLn
	8fD9l+MhLTklUHZrH5pn3EdYCjEiAbi5XFTdFWqxbbL6E91K10MHFMbwJ4Wq+CK0
	C4/jP7AgASoK5/ypO+avSXKRvF/fbY3g3jHa/ntFC51QsJOKld8b+/5fi+Vsnb4k
	sn1rvDDq7z5iSuaRVy/kFAG4QZpVh46zi28RkR2m4nWvDcxw3Uis1wr0fJaacTRz
	SlYdZlW2qyV4X32k891BUaVr2W8vrOTRYjdMuNbSUErKn9PoCE1Pg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawf0p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LGs5dd015307;
	Thu, 21 May 2026 17:03:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gn2g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LH36dt31588712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 17:03:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5777920040;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EA4F20043;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Date: Thu, 21 May 2026 18:56:20 +0200
Message-ID: <20260521165622.279953-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521165622.279953-1-japo@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2NyBTYWx0ZWRfXzSqVnFNsqhae
 b4ZWmSo9N0ziZ3S0WaOTGDHvH5J4UCEKjkrDqcvzXlfSMfPwC4rhXDPXPXrphNlO1IImtz3kAfA
 91FU2kVE04KakKRYLsJCp0NG3f8QZq+dVOMqfi3fjR+5h+IQhbDeHw+U4re0MBlq7vJ1Qc0jPK3
 K1Kx+5DXbEn85pcuJohsrfKG6tfJQCY9v1MeIktKTdN7st6IAvw61igKc3AqpR2D9lBFZZ7Tsds
 a9Q+MC8lxT+xce7VwrjtTdXJ3Kyw7jEM73LOiHNAUaZADNM7vsZ4SjsCplaBTmPHylRRpD1F7gQ
 8kaGtU1XMRzkuwjzj28W9qdSLw8/chcPCygtYz0bDwPnX+Ub3Bc/zXcxYQtBh3mBd4E/5N1QAkQ
 BmilUjPB2z6WLt8Qr7s4dUj0iAgfN/3EfRPXbY4J5AlqoW/LxPdAqUglZQVwgM2c7MVpoPK1xk6
 6bdxL59YmPY2tsgWznw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f3acf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=V3UG4Yqg79Bxd1UTefQA:9
X-Proofpoint-ORIG-GUID: naEMPCAJ6jT6aKL8qZ3s_q27tnm5EGS2
X-Proofpoint-GUID: h5r23O5umdIL6LXx7k1ozNaieTJcSXyS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210167

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

