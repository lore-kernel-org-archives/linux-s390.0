Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC83D9041;
	Mon,  8 Jun 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942523; cv=none; b=kG1iOmlZmQML2UPJCi5oWtAvVM7dkya2sxQKOp6wHt6CbOvbj9gXnKYHfKlqRwb3gJ0okQIsZmgA2N5XNxLJ5T4Z1pZzxUDBJZOrrwo8LsxM9dapC1AgQ6kMLZDT7hKKjriLQG9YIPXYIOqLIhuxklFF7VjOIDC8a7mx8XUh58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942523; c=relaxed/simple;
	bh=zkPVQ5iYH5V51TRpOLygowOTrddfFMZjzV6XMnDtx74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnzefbOMHO+/B4592Zf1T0V6Zs3WmDGXQab6DfVPYZiJw6Npjso+2+oTIwL7wvtDBnGXNCJPgx0xyrsKNVbDer6cMg7Zg7gwUApVpQIPGSzYw5gs03xyh3rYf9tTFN04bjJDl7TWCRJ8QDu6wOlxYeE5DvbAPWnasD3Dx7y5gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GXtXnhzH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GXtXnhzH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658GePdq1207171;
	Mon, 8 Jun 2026 18:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pCgArfWh1z7dGTQUN
	PDJcBjiw2AR1reflJVRbNUihc0=; b=GXtXnhzHNJFda3mT15Uhu2TGkjPVVgxP4
	aM4fVT+p8jHRH0+lG3jXLQ6otW5oRWxZZors719sa4JC5aOmIkpGb6jHjrh9qV4j
	3Dio9i9nKSjIha+Ym3a+oR0HfanDt972pEB4bg+kdVek24DKdatdWaos2KwsoaZo
	NNcLGr2EvdZSKEb9rC1DyLOooAtB0r+qIEG1InjK0FeXw9K01F6FhwK5vwRB1927
	dJ9ryTPHyek4vami1tMU/mFIDnzBbowNzNGOP97jmvRLwtjMTedIAJ/yhHoFWO4n
	3qNTk0iqwRapoJ/NDuupxR8A75nNvcuYfnqnIBGxDKUFWvowBlJvQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6srgxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658I4bsv002573;
	Mon, 8 Jun 2026 18:15:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy6a8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEuHL49938796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA96A20043;
	Mon,  8 Jun 2026 18:14:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91EAD20040;
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
Subject: [PATCH v6 1/6] s390/bug: Provide ARCH_WARN_ASM for Rust WARN/BUG support
Date: Mon,  8 Jun 2026 20:14:46 +0200
Message-ID: <20260608181451.3734956-2-japo@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: cqWWZqCMqnBHxHEqlw20X-eTaoDawo6w
X-Proofpoint-GUID: tKqqsRX7M-TElpNUXI2VZEK0qEZMhIWp
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a2706a5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=_2yia0w1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gpATZORf9AIJ6E5TQREA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfX1MFDIxFyn6A+
 nsbsK7/rYh0lui5yJjBXhaS8zFMFfA2dUPlrQL/pqWLiTCudOmRaW+2aIss+8Z1zkqzjgSQW672
 h+sMmsUNQ/ftuFSVe3fA3qNBxD5Ps1CP6mYwT5jq358w0OMA7NGgrv9hvTR+X6Obu0y/m9H69xp
 k9P+P8gy17uiJ+1NJ51+AezJJwDfK4ZTOsaWnwqlUNzEPv458O63nvZc9XGN9tIBhVXAPxQQuTY
 OMrI7wEpnRD/4P+fsLlJx0eo+NKPRbpEMufgtj4hUlXYcF98eK5yeqZmT+5So60LqTQt7VDSZLR
 Pa8Z46v2htzL5RLkNX4+nnh2cKUYwnQXfGWv64kQvJ4NFOk4aHttsokTXBUmh55Mgk0aAlePT+2
 9S4BlmvQ/EyRcOTXep5B9XR7FoVvnc1zpsb35hRQiF8GxBlnqG9w2G/CezkDIhwm2Kc8T8uM0wE
 9LAXCwbxBGotnTqlyYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080170

Rust WARN and BUG support relies on ARCH_WARN_ASM to emit __bug_table
entries. On s390 the macro is missing, so Rust code cannot generate
proper WARN/BUG metadata for the kernel's bug reporting infrastructure.

Define ARCH_WARN_ASM to produce the same assembly sequence and
__bug_table entry format as the existing s390 BUG handling, including
the monitor call. Define ARCH_WARN_REACHABLE as empty since s390 does
not provide reachability analysis for warning paths.

Acked-by: Gary Guo <gary@garyguo.net>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 arch/s390/include/asm/bug.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 50a270edb020..2010342c97b1 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler.h>
 #include <linux/const.h>
+#include <linux/stringify.h>
 
 #define	MONCODE_BUG	_AC(0, U)
 #define	MONCODE_BUG_ARG _AC(1, U)
@@ -121,6 +122,17 @@ do {									\
 #define HAVE_ARCH_BUG_FORMAT
 #define HAVE_ARCH_BUG_FORMAT_ARGS
 
+#define ARCH_WARN_ASM(file, line, flags, size)				\
+	".section .rodata.str,\"aMS\",@progbits,1\n"			\
+	"9:\n"								\
+	".asciz \"\"\n"		/* Empty string for compatibility */	\
+	".previous\n"							\
+	"0:\n"								\
+	__stringify(mc 0(%r0),0) "\n"					\
+	__BUG_ENTRY("9b", file, line, flags, size)
+
+#define ARCH_WARN_REACHABLE
+
 #endif /* CONFIG_BUG && CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS */
 #endif /* __ASSEMBLER__ */
 
-- 
2.53.0

