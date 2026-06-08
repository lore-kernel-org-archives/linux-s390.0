Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF123D8915;
	Mon,  8 Jun 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942522; cv=none; b=eyHXzhbPFknP1FqPoxkKdLafpPtJ9U5bTmj280i9ZEPoYPlJ9gkkrp0umCA7I0FNEKA7KDpJ5MQhzijO8nKB1T7O3kWK5Bc41wg1c7mwwNzjW2Y+9hi9k133bZgyVf7/EwfGT1E5odcf+gpCtUGjXlsv9wgY1Ed80lkntt1skLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942522; c=relaxed/simple;
	bh=NsiXgfMjrDJjgxqe+NpRrQ8wAejU9KwZ6faRF02L4f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDWvOHLd60COVf2GoSgVecEvVvQngO41+nBFuVJlHRzylM3PcJUUd+QMQ7AmK1ISAB7VG0aQI44e3+ASNtgmCeeCZJdsK6O/a0lZPbCPpbDkT/2tdWPytKbXlHhwYZ7a4mIw2O9/Ar20olv9r+AkH3ny0vDpRwg3R1r1ZmNeNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KRWB3Fvk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KRWB3Fvk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DZ7uZ3480113;
	Mon, 8 Jun 2026 18:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=R/d5uAGA/A/PtHXYL
	oaHW8B0R8vQ7C9tt0+DkWtuxpM=; b=KRWB3FvkDiSd/jIRcze09tTPXrpeWIHUR
	jtBkbaysCsp5g16LfFK01N5Vogd2gcorUptLlF1bqawydqSaUhmQSRFmUQYO8QQS
	Udd3Lr1LTZSGlL7X/iPTUkRjfxO5MzJ7GNd3MoA7Q73Hq1gw/f9gZ62sfpHMeAOR
	pEd0wO91sS+XzCDkINX6klijft/xEN+NTob17H7NTJdeiS83Fuau7fNHBQ3EiA8E
	7FuAjRStYQ8z3o/AolpRXWkGQw6KTEG/NM8+T3PsCYBRFmpu2doL8Z9jN8XrWqOG
	ZQ1/izNgnxmO2r46hmxTZFMtdjNu2artBcw73KXL58mLu2I3ok7Zw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6srgxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658HnelM023294;
	Mon, 8 Jun 2026 18:15:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpxqex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEvVN31850832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3131E20043;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFBFD2004B;
	Mon,  8 Jun 2026 18:14:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 18:14:56 +0000 (GMT)
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
Subject: [PATCH v6 2/6] s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
Date: Mon,  8 Jun 2026 20:14:47 +0200
Message-ID: <20260608181451.3734956-3-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608181451.3734956-1-japo@linux.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Z3M_4wLGPtWh2W7wz7I_5icdE_MykGZ5
X-Proofpoint-GUID: VZPn9GfBXmu1Frxf4b_1GwIyAWZHWZ-E
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2706a6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=_2yia0w1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=V3UG4Yqg79Bxd1UTefQA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfXwa0ysiCFKzxP
 dJ+1/0ZQ3DZ9MG3gIUmPIB9rpOSuYTFRAf8nbD0zhexdkok5teXkqFDOh4VQY8sQ6zEyL9pcwlK
 m7++oET3mV/dcKBlYSdlkptiX/eM1QZJSIzaQy7WhCprjHFws1Cto5mBq9M9BRoV998zY93CPxP
 ojG/sMwTAkWbLTPCQg97bjln3tI0aKI32sCxP+EdMlOjOlF0/9upvlTZOnKgFBtoZDGXr5LjjBm
 V9mFGxaoj27xldSAuUInshVC3TFwHVsGOdvgWP0QQO+bKmQayYaMti2A1UgpszHl4RaFgbEXTn+
 HrisxQ8cBOBwH7x9reKyDzSr1hjB/CWy/4ek8D/0bWTqqzN6YOkpRBl+QrhKSqDWsN1f9TZ2vBP
 XknotTCcA3Rl2Xc/ZqP1QQL65dqYFs+Jclhp46UR0/R4JSBKpVJ/ruALWR1COUKUj2svMTcJ+Ny
 S0zU37ZgqvbOUhna+5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080170

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
Acked-by: Heiko Carstens <hca@linux.ibm.com>
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

