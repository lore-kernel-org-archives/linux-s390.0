Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F73E5A2E;
	Fri, 29 May 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066700; cv=none; b=QX9JNopTMp3pjQxcOd4tadQa0Pr7tUXd9HkhvRwANNtkPTm1s4xwATY4V+lKgN6WFAk+GOsRmJWXOatT74+cp7arCRJnHqF5B1GFrN4T9M8lHMzpxry+hhL3hwmK4Ck75xVxTU9BmPfxt8B1iYr7mvy5xf1LlsBVRx72pG9qmkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066700; c=relaxed/simple;
	bh=XXWBG0v/dCruQJ6/OLnskMnp6HMzg3Wt/R4URVKIf1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9FHlJcSocE6DnY/We4Zhr3B53rkjbLLMJ3jZf7fsKL3m4iljU2bqkQxjdNK0KNZBNzUpi0L9y1db73/8DBNoC/yhDq6ih/EkiSHmCxw3MzLozngpsDjw1UrM73uktljAbzITWmLDwnBk7OBXk4cq5ava9hT9grthmyQlPSwtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZrFKRlRr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZrFKRlRr"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TEdjWU2418247;
	Fri, 29 May 2026 14:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kP9ndZg5wFaJoUa0B
	3eCJsB4VeU9eiqBZ7cvmQx9k+s=; b=ZrFKRlRrPsf6p8giUVj5EbT9+DjIqzkNr
	MY6XJaLqS/p7/0oc2ofYYVXRUQiveoAA3YBmmUHCE1YinshvMhEPdGgyFN4+ZZWE
	D3lbLZQ6vvRO8oitFHiFgSPR7KpOkmpqvdI86MydX+kWJEYoEbKzQ4NLMHK4AyZ5
	79tR/gNsx/cnTMcn2FYO5cdLylMyP4zbR8r+uy5aS6ndo8ce3UVxbCWTVGcZgkXY
	dtnitUcCsvbgBQf/Q9vi56Iv9qK79XX7H9WbP9p+SpEIAJpAdYQHmnL5/XBUHBGi
	HCRaEbqmHJSHh+NEHv0J3Q/AfQUlpHVDDv9TYP69px9RhhWCZkiZw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884tnw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:58:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs6Ao026544;
	Fri, 29 May 2026 14:57:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbf4ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEvujW44761512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:57:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E8020043;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C28F2004D;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] s390/cmpxchg: Fix KASAN stack-out-of-bounds in atomic helpers
Date: Fri, 29 May 2026 16:57:51 +0200
Message-ID: <20260529145752.1209016-6-japo@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19a978 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=_2yia0w1AAAA:8 a=VnNF1IyMAAAA:8
 a=9-FPAKYo-0jGICd3_CYA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-ORIG-GUID: egA_7cV0gytuu6FjtcJZOc0ympGv0M8T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfXwXzEVAzemXQ2
 mckVK9nBDA8v82BQDtqQbc8tXKZpETBzhOOnMGqliSLSmNzBN3q4jGpiswBwdO6OmldDOtXozt+
 DjVoI78k+vR2XcGbfk30VcFDttiBAK48bnjapUw1Xu1toGlWImMplGFxtJdZqFZ5ZlJguJIw9tQ
 +bnz7NBGpJ2BAEnTc/JePiO89kpHCysCGDQPEPcqTzBXP6L+UWQYfzBukKiJp4iB2I7r0ZXrNbO
 EMVpWzA0KnJc3ortD5+gzGc80+3fHryvYv+9o+CYkAXOVWZLpCsBVoVzdbXUaFzZmPkC+urYmbZ
 EnDVpiPkaWLQIGYURQEOZT5ht9k6z0JpGtfumQpPCeAdRBuREtVltSrSLxjVgEUvX+4Y8NkNDco
 l3Eql60nqTdJVLCWwwX0QCoWagmkCKHpXji343uX+Vn9RuIaLpyqyA/4HiypEJtKGy9X9NIIbBI
 2pDtqiWpFLGJElLnClA==
X-Proofpoint-GUID: xY5V1Wui0CVgmO4f0LZkP54jbn2xx_k1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290146

The __arch_cmpxchg1, __arch_cmpxchg2, __arch_xchg1, and __arch_xchg2
functions emulate 1-byte and 2-byte atomic operations using 4-byte
cmpxchg instructions, since s390 lacks native 1/2-byte cmpxchg support.

When KASAN is enabled, the READ_ONCE() operations in these functions
trigger stack-out-of-bounds warnings because they perform 4-byte reads
when only 1 or 2 bytes should be accessed.

Mark these functions as __no_sanitize_or_inline to prevent KASAN
instrumentation while maintaining correct functionality.

This resolves the following KASAN error during rust_atomics KUnit tests:

  BUG: KASAN: stack-out-of-bounds in rust_helper_atomic_i8_xchg+0xb2/0xc0
  Read of size 4 at addr 001bff7ffdbefcf0 by task kunit_try_catch/142

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 arch/s390/include/asm/cmpxchg.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 008357996262..e6ac55cf3c17 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -35,7 +35,7 @@ static __always_inline u64 __csg_asm(u64 ptr, u64 old, u64 new)
 	return old;
 }

-static inline u8 __arch_cmpxchg1(u64 ptr, u8 old, u8 new)
+static __no_sanitize_or_inline u8 __arch_cmpxchg1(u64 ptr, u8 old, u8 new)
 {
 	union {
 		u8 b[4];
@@ -58,7 +58,7 @@ static inline u8 __arch_cmpxchg1(u64 ptr, u8 old, u8 new)
 	return old;
 }

-static inline u16 __arch_cmpxchg2(u64 ptr, u16 old, u16 new)
+static __no_sanitize_or_inline u16 __arch_cmpxchg2(u64 ptr, u16 old, u16 new)
 {
 	union {
 		u16 b[2];
@@ -173,7 +173,7 @@ static __always_inline u64 __arch_cmpxchg(u64 ptr, u64 old, u64 new, int size)

 void __xchg_called_with_bad_pointer(void);

-static inline u8 __arch_xchg1(u64 ptr, u8 x)
+static __no_sanitize_or_inline u8 __arch_xchg1(u64 ptr, u8 x)
 {
 	int shift = (3 ^ (ptr & 3)) << 3;
 	u32 mask, old, new;
@@ -188,7 +188,7 @@ static inline u8 __arch_xchg1(u64 ptr, u8 x)
 	return old >> shift;
 }

-static inline u16 __arch_xchg2(u64 ptr, u16 x)
+static __no_sanitize_or_inline u16 __arch_xchg2(u64 ptr, u16 x)
 {
 	int shift = (2 ^ (ptr & 2)) << 3;
 	u32 mask, old, new;
--
2.53.0

