Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1113A3F7;
	Mon,  1 Jun 2026 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336027; cv=none; b=dV11aOoMln61J9PMfqlqgA7eoSAZjVjB+we3ieIxgByRudUOBrpVCGsaGixU3Zu709NtHJfl2YK0XAPJBrsTPXgJlZ1xwmivtilljZLAP9CoP3VGTP7V8gKNQvY7zqyiWkWOTPJCXwP495BTQQ/eoapGrMLGsZYn43HJvopw8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336027; c=relaxed/simple;
	bh=UlEGYP8jSj19m7y5UJVI2ZyhNH8EIvLeJPip/Lv2Xuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se7KPrwAoEM55/p5hDLMM7PQ9QQ8oOcXyrHfpWjBjEYVDuZbfqFgb0dDcIfR7vMsmHlBu1xECFUJy+psgrj9MqMfZFX4qyiGIBOTJOTVVF0AhRNm8+7RzYcgYq4EayaT4Ky7VLASjqeJdw98KOrn4NOfg96WZKLv4h1UyiqpE/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pxY/6VTX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pxY/6VTX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65183V8Z2708324;
	Mon, 1 Jun 2026 17:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZbqJ94R3zv4TlxZ4l
	Pc4zdJzKpGMXMz18Ox5ufJCyYU=; b=pxY/6VTXdOugpDHnca4K5bzB+DO6aOAI0
	BmQNSGg7Cs1yAw0Kw0gy/EAYVqxU7/z01iNRFZqTHz1z2qrC/N21PPzCJBN2Pi8a
	s0VKGULe7fM5/Knm9Osvskpa+rKe3st/TTeatQR9N0ywMqF84y326Uo8oGs9qmAp
	6bxU6lxX0bvFvekqJvdgiC4v15VEeR0QXVrYcDxkH+gLOtOjhEMlT9djpbwlI6zD
	JlCLPbNhMy4X5bbNHsz/OGBCB+w70U/Pc/glFEnwP7sIpu8pe5BafhUaXCODvE59
	1QWPA/oTxD0f4H86v40vqJkiT7HGXepCsf7EyWktIieluJlRKJHRA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahj1sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651HdE4X022661;
	Mon, 1 Jun 2026 17:46:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqh7abp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651HklUn45220106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A63E20040;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0245820043;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 17:46:46 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v5 2/6] s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Date: Mon,  1 Jun 2026 19:46:21 +0200
Message-ID: <20260601174625.2910233-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601174625.2910233-1-japo@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfX/OF62GgYouUS
 h9eY46xwMWyfPKS6PQkJQQDm7kY7YkGYcakJrkmfG4c3NJ3DjJhlfF/WdUYJPlUJpHw5tktPEAt
 6XDs4Yl5r8VD7bYEZqqXZua7p/y9cltsTvlmHRLzSRO+UQ1Cwpng48+8lL3qZxxdiwfEGZQCsL2
 OguuQyg6L0IqM2eojIcjXdy2N+Nhd2QfkrlEaJrrZUvlx/7RAfLKVHrQLhnu7c+gf+SfURmTElC
 5mFQTY6L1pg+jRR+yGQmOU+gh78MWJAeCcdEMx5wU3FC9Sjd+7nQ6eEl2JyvvJEoLVmWTt37TPa
 Pf5J79CHf9deiWEbeWlPGJSkGZdbiZgQBpkg9lEPsZfTcwk8WqJ+lDR7LN+qYooxhfibAxA/R+F
 Gvd6H7z/yDiecx6uNIfSuudRm+27EnY6NDgql790q9kChEWt2tMKSyuvdrt7Ee5d7G3CWdC5vXH
 Vz32tik0hpQAQl3rAWQ==
X-Proofpoint-ORIG-GUID: 9Bl-JSlMxba5Wi58Z0jA9Ex6e-uvbMf_
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dc58c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=_2yia0w1AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=V3UG4Yqg79Bxd1UTefQA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-GUID: L3KN9O8HH5Ij7RoKU9xRJ9jXmuS0e1RX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

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

