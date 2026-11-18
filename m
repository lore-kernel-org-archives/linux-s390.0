Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013251;
	b=NcivA4fUJ1gLHIIGGxDMpcITVW2FzAo/LeYAo5SkQKJgy396L49rNunPtb9kY05ZL0mT
	 p13oPhYlMiVQ2scsRJn9W8SN+YdoyADMv2/NIMmQFkZHpuJoSBBXi25mlsj43IMg3wo7K
	 PvC501GbX5Up8+qC1pOnchiT4HQIozi/XHFOycXKPodGXNg6RHehMvtpEGwZ6odTZzf2V
	 0jjhHTY0u1Q0w4vehtNPa4Z6m8E404rJkVq3OtiUcBBYoCObyZhf3y1tf0ScKJWrldXcy
	 wt3xiQ4l+lJRymvnLLZb26ESfy4f7ZhAVvcOxtwA3K6a3ftoItFcVWg/opZHWn1Wigg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zEwB2PyU+1WKjwuNBhRrXTyTDFAH8vgxMea+ghYEQ4A=;
	b=ooGMZaOtxqgaca0MFQG5dwhe5V4uIMy0kvloEJW9lGfZ/kFOUBbrOawZaIOwT04u5BI1
	 yzdWjG+NftaE/drvn+Pb/0nu3htgl9LvpTVQJPao5qjylY/iJ/LqXZg7OQDq4OtYK+ARD
	 Ub30U9WZiZZEvRbISf/PXPKnMSG8ssspW3IxBQGLC5ZqRyBqH2lcfI3KCTBPFxaPhZMAi
	 mdpVzIN3KMavXXdHSYEoD5iPEjqHfJl2DC0F44j3pC0rTFj2IlIF4PnC0MdxyqBjQVDtl
	 +gL8Rjdfe+2E4oDIU4yUi+QBYeDxW6OVwLyxnBZ89DKTqdR54rQRpBE02pGS/8UqBHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qmQ0xW95;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4671606A338;
	Wed, 18 Nov 2026 14:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4671606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qmQ0xW95
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQoCB012054;
	Wed, 18 Nov 2026 14:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zEwB2PyU+1WKjwuNB
	hRrXTyTDFAH8vgxMea+ghYEQ4A=; b=qmQ0xW95ba4B2pKhnkttgxXUO3FA5R0Vg
	d/uuwlbCChXWVH8HiX1jNW4FEDUDFdD2XcHEDEVl5ZY34jb6YhuS+iCnWSatg8xY
	4y3GuwAToqolUj3nZd7jzKGDYqGaE/0/HD5Q0AzKv82y9rnSeeHY7LV3Ryy0EAq5
	hiZOVCzMPIH6PNdNts0BZb1ys1wuK3rOWuqRl8kUUNBqS2A47Io1TCHdwkUGaiuI
	sIzOhsu7kcIlkmMc2jyLd8GfLpFdVUtAktolT9BSiSvX811wwGCRhL3GRY3aS5Eo
	/7QqNluIaVtSc7feo+rUxnwJqFdQ3Gcs4LGn6gFOTNLmjkbFOsexg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vtuxh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDZ3532073429;
	Wed, 18 Nov 2026 14:47:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4s8fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElBdU31457552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61E12004D;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D7E820040;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 8/8] s390/set_memory: Add __must_check to set_memory() primitives
Date: Wed, 18 Nov 2026 15:47:09 +0100
Message-ID: <20261118144709.202520-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
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
X-Proofpoint-GUID: OifMKVJFCU7ZFAdHX5csPSozfR8PXqzF
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afdba74 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=IftA_ebVYfbSm7GF2iwA:9
X-Proofpoint-ORIG-GUID: OifMKVJFCU7ZFAdHX5csPSozfR8PXqzF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfXwTwx5neIzRR2
 lKoaUMFyMPGESWbF7jrOWZuPEk0SOuynRJBlWhph69Vg+K+Ra1DwC52qzoB77nC1btFHoAP/nAb
 RKMK5kqAXhcDA0i7aTnTyt+qlUZD1GM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX6L9/hMlLlACH
 vmAOjyOss+VkoU6cBKQN0D4i0+hlro+wV2tTBGhrJ3XKKyghMkzsQ4OsI70snESLvmpvwO1FEZ2
 qeRzW2Mr5Dgfkn1Q1Yo8TrwPDWFhsoPQq/z1TEWYKKHOzeadfX4LmKJRMKiyw7DIqIx4BtrnxLz
 ZE/zJDPLPAflj7F0rYqKD6WL4HEgtdojhP8AV6p9vMBiC5KBX82FE0qpNq68RZ+sHMaoroWgymM
 KEfDuLRW0+nI6HKhZJHZqGc5/j9qXPF6X3zQ/bQ3zX8BzFGDQ0MBtijAh/q1cr7+W8WqQNCVhy/
 ylb8BOP4KI/4B7zmNolPeAAoRcHATQgjPjA2BJ3mAhM9WN/cLBAm4EigHPLBGkYxHtiwPk5jdoG
 MxvxuCyMeGLbd9ULAurVram9Hm0jf8aK9BHzy0MBT/khz9U+TLLP+vg2Acu8AVAPSSia5/gexxv
 R7b3tcu/3EyrFxA/+/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180057

All set_memory() callers in s390 architecture code check the returned
value. Add __must_check to all variants to make sure no new callers
which don't check the return value are added.

This is the s390 version of commit 2abbd6d5fbe0 ("powerpc: Add
__must_check to set_memory_...()")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/set_memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index e3562bf0c1aa..036295215a1a 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -39,12 +39,12 @@ int __set_memory(unsigned long addr, unsigned long numpages, unsigned long flags
  * for areas larger than 8TB, which may happen at memory initialization.
  */
 #define __SET_MEMORY_FUNC(fname, flags)					\
-static inline int fname(unsigned long addr, int numpages)		\
+static inline int __must_check fname(unsigned long addr, int numpages)	\
 {									\
 	return __set_memory(addr, numpages, (flags));			\
 }									\
 									\
-static inline int __##fname(void *start, void *end)			\
+static inline int __must_check __##fname(void *start, void *end)	\
 {									\
 	unsigned long numpages;						\
 									\
-- 
2.56.1

