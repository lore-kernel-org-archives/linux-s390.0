Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111438;
	b=1YdEopcrRia0yTj4ZWPft1B9/Hjq91netC8AUFSpvTZCmwTwwJwHx4XDXutFQyCyCKja
	 NNmU5xocux82ugxl7ek//jTSxl0ew355cVqrNE3+n1BBTUNywhXR/b45Y0+nBZSOidtJU
	 vWVBpL3AvdAB4JA3eY+S38JDmyTI8Nqwd4XvEcThbnauKvFUW2OVdL61H8EFT+k3sxnT/
	 q7gHzCq8gp/0GAP7+6rOmLV1YRu7abwgyBZxeBDmuSyhy7/AKn8+1J2yYWyGmBZi07sau
	 Z03JKzRl5v4gz09VG5i3tEpnI4ZYPOgicGO/UsrAfzzyxFzjc4wy+/zevCgyUgLHqmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mtRkCmlykCcQDj9S/f1cgvTvm520WHsmfsu8JrUnpFY=;
	b=TZwh2EXnuAPaR/EGcSGWs9pxEhljCEW25iNFb/3t/1a8JTfShKbAJZkJ7HOFxYGtwzR0
	 R/3B4n/1S/u3N3bpiNDmKHqHx4KWNuVA0blV1v0gdGnig0kcR8rtCBPqFiXbHTZtHOGlf
	 2WMK/uIylzbMRK0etxg16wduLugDfCMEKWqm/tb8FvXpHZbykgLzC3NkkOTaS6oNClebk
	 ACFbJMW0JVS7aGkM6EtPDkuXMEGQiFMN8+/3r9PIENPJ/3pNLRN/uCildpOOowqPchLas
	 0vhFlkX5pFDbm0gVX12fXLiMGWcbpMCIMgwiluWPEq2mX8qE1GdakFEX/QZGRni1NbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DPWX4s4f;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E6606A326;
	Tue, 27 Oct 2026 14:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DPWX4s4f
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69REEGKE1050686;
	Tue, 27 Oct 2026 14:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mtRkCmlykCcQDj9S/
	f1cgvTvm520WHsmfsu8JrUnpFY=; b=DPWX4s4feL0IhaJURHMFqHUSRWQA0XD7C
	YR2QKgiMzN0FSCiPfpq4woR0ciqfE5c8UIKjoYM6/KRyHiWmd7WthApwe+/IQRMm
	ajqYsIG9yZkY50J/xIvNN9ABqHhgO02fy3YlXROZT8bVifbEyfzwtY2u2vfPP1/B
	vUqSBA6jnbGUxCyc8CSIwzYZcLJ0vfkQN1P8IRLdKOyn9j/5cNBcZl6E2P3htfkP
	XulKgz7i6X2O9eHsVIWVabGhmYtOhvP/SVyMzriQ2ln//7RH1hI/+ojJt/QfJuWH
	0uv0uAwpPA4tg7NlCDvBIlVmdU5uLcc3c8pQCGJOzNW4wv2BaHqOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsyxdx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoioX053900;
	Tue, 27 Oct 2026 14:30:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjsu7ryrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 14:30:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69REUW2q43712844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 14:30:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F9F12004B;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644012004D;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 14:30:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 08/10] s390/alternative: Serialize text patching with text_mutex
Date: Tue, 27 Oct 2026 15:30:28 +0100
Message-ID: <20261027143030.3154657-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027143030.3154657-1-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX1x8wENyoz13T
 R58wcjsQ/oAcFG9nFPE6MeirVCajVgIk+94x24zkyb25gUOUBdooHCpE/qHoSuYbperbnE78b2N
 SA9tZl/pkc/wECAD8EBmbi3MJ2+usa8+UlTWU1UU7/yOjQnbU8wkCSrSbBn6i4yAkaArDcapW/8
 a8GTk12Hql9PIj0+DfErqFYCFeI8gQ3C4JFRB3vRzy8E1cHcFNecOaetQa1o1h14a5raXG/I+hu
 gcpvfRw1sz2RLAhEYCy3WyZX64/D5k11ILRaNBNmbW7Dh08vjGKmtw7MHvVZFjBXvgxwETdnTm5
 DU80F+mWFPX/lPig1dAHeL6g9LoFk51cSgF/F2cgdyya8InHeAWZ78tYzidjGFOZx1YXMAuzaul
 9xuBGe/tRskpPB7hcQB8MVm70EBwwIW2pM+JC6fpfChJyBVJSvQGw6hRlP5psa7ZbeJbYS8hMwy
 zyfVt7AH7Mab22XXfpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXzfoByKJykQiV
 3d1PrygztR0w9H/xamYk+cBpEBr1cM8IQZeTIWO2N/q+xGMWt6Z/1Bv4fEiMPbb/CPiegJQzb5A
 m690BSZPLQal348eXY0tmNDxvLynNzw=
X-Proofpoint-ORIG-GUID: dqsHN_jQU55yTC1rEUUP5cQWg2viU-7l
X-Proofpoint-GUID: dqsHN_jQU55yTC1rEUUP5cQWg2viU-7l
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae0b58c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MAnzGUVWnLbHPBr5iOwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056

Acquire text_mutex inside __apply_alternatives() around the patching
loop.

Serialization is not required for __apply_alternatives(), however this is
part of larger series where at the end s390_kernel_write() requires that
callers hold text_mutex.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kernel/alternative.c b/arch/s390/kernel/alternative.c
index 02d04ae621ba..6013a75f5241 100644
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -5,6 +5,7 @@
 #endif
 
 #include <linux/hex.h>
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/printk.h>
 #include <asm/nospec-branch.h>
@@ -55,6 +56,9 @@ void __apply_alternatives(struct alt_instr *start, struct alt_instr *end, unsign
 	bool debug, replace;
 	u8 *old, *new;
 
+#ifndef __DECOMPRESSOR
+	guard(mutex)(&text_mutex);
+#endif
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
-- 
2.53.0

