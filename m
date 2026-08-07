Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6E472F6B;
	Fri,  7 Aug 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105328; cv=none; b=br02ouooG9bJktDxny90uZ5quOu7uA5fmbkcOd3BKWUzeTWecWVvUFYR/aDPfm6kdakiHOOANNtKMO0e82fGwHQlS79FP+TidTvV4oBELm8CRS1JfJ9UJ4x1CcMF9qoF6B4V+la3Yu+O34Lf1WV7G/RA00FcuxMIFBr7xHQHzDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105328; c=relaxed/simple;
	bh=cEoa0BLgDVjztI8OflZy1SozsRt+FpP2jU9k1KxRpEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZzlI53VTEIwJMc0NwhqeihX31fgCPLdCcw3UzLUQyZBitARUPgNwCvfL+Sc95/25UNg+DcjFIw1d6Gt+B0RhRTSB+eHox2XEyWy2QCi8l8Jf7hAYt7TEPRLqBeYVcMeOppCUnfAhhCbW/m1wd4/GATlKkLWoCcFoZuB9+Cra1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJacvyHp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJacvyHp"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IWSQ017220;
	Fri, 7 Aug 2026 12:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2PIjYQNfbifaSVrrGDkbNgVPcIeY3Ays8uYTTGpc0
	Uc=; b=XJacvyHp+CJtGG7hXmZSjFN6CRZMIRl1OJIoS7r14FRydPqH/fe8+RmGE
	U59R6sHZOuf/Ur7AFgQXb6z2s5U4LPXpxUpaFgPEDXkqL+jzSZu49XHnOSw7GyIg
	461zeDW3R6vUsMH6cd+6xneZfw73MesAIbf7ASnM9am0CCTUgRwhXmRLSd62G4zL
	yunx7rKkG5rPBTYM8hq1asOCm6IDMzuMmZWM+74W5nmSC0G8TPbXi+CDR581xjgY
	5ZJ4F1N9ctnZVh4MIvBGCTros2OvGwoa+v+VVeUNPJsPxxszeNxZVK1ogO1ic756
	5GqMtIVQLk7iGBn8bTVZDSDhES0sQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy00bpa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:21:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CBREI012790;
	Fri, 7 Aug 2026 12:21:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyyd1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 12:21:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677CLbsH38404592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:21:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2537D2004B;
	Fri,  7 Aug 2026 12:21:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B498420043;
	Fri,  7 Aug 2026 12:21:36 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.90.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 12:21:36 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] s390/cpacf: Unpoison instruction results
Date: Fri,  7 Aug 2026 14:20:52 +0200
Message-ID: <20260807122132.3592583-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfXxt1CEP+PR/KQ
 fJyz14U4HUBme6Ar4IzYXG7egY8ZkVgQrfydmUqiNrALFVf1kElYJyisv/MQJSamOY+xcymUgvY
 IrxXWg8c5Z74s8/ktcHUlzYiNyvxnLk=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a75cdd5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FCybggmRgiRb8RFvbkMA:9
X-Proofpoint-ORIG-GUID: 559-qdB9YEtDkaCGkZEc44JfB4I_wL_f
X-Proofpoint-GUID: 559-qdB9YEtDkaCGkZEc44JfB4I_wL_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX7JrwWWo3ZWY6
 k8KCxPr23GgKs9eA7+cmCrWzijxInubXGLEr0xbnZlJLTmUO7wDt5tH+gkSEA+iY1hafNoDj+9o
 McszWyv8iBv1hx9xhNU1oXdEz1fSJiIvYywuyve7bQzkrm/BeKNV1UcUChiSEXtkGSKiZ9pIgK2
 z8gQBBkIoJ2WoH5YCFGio44btkW/VukYb/KYeyDEqGtGzL9NSvK3I8X0e0zMXmC65rbQpC2e/4t
 jGRWG4M18mcHVFMakh0ouz/B83lHsmnlcEYLo69KX3sZ0FYZSeYuPi/M28zj6bx3k7rBq3Hzh6D
 UZCa9rce7d/yZy4go6Au3pMUg+xaTOwXKSr6lfn4x2BnY0Q+zzHTpb7wNkIco8BGHFwFi3SWhYN
 fQToN0W+YjwsMuRE66pD6RgNA30UvDV9XYkunddT9G2/A/6hqrhU9u0XYF1OgolztHWR0Akt/0w
 adzl0zj1L3kXpg/IV6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070095

Stop KMSAN from complaining about CPACF outputs being uninitialized.

Do not unpoison variable-length parameter blocks: mapping function
codes (like CPACF_KIMD_SHA_256) to lengths is ugly. Let the callers
handle this once need arises.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
v1: https://lore.kernel.org/linux-s390/20260806190223.3292580-1-iii@linux.ibm.com/
v1 -> v2: Unpoison outputs of more instructions (Sashiko).

 arch/s390/include/asm/cpacf.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index a83683169d98d..13d6a6344802a 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -301,6 +301,7 @@ static __always_inline void __cpacf_query(unsigned int opcode,
 					  cpacf_mask_t *mask)
 {
 	__cpacf_query_insn(opcode, mask, CPACF_FC_QUERY);
+	kmsan_unpoison_memory(mask, sizeof(*mask));
 }
 
 static __always_inline int __cpacf_check_opcode(unsigned int opcode)
@@ -370,6 +371,7 @@ static __always_inline int cpacf_query_func(unsigned int opcode,
 static __always_inline void __cpacf_qai(unsigned int opcode, cpacf_qai_t *qai)
 {
 	__cpacf_query_insn(opcode, qai, CPACF_FC_QUERY_AUTH_INFO);
+	kmsan_unpoison_memory(qai, sizeof(*qai));
 }
 
 /**
@@ -422,6 +424,7 @@ static inline int cpacf_km(unsigned long func, void *param,
 		  [opc] "i" (CPACF_KM)
 		: "cc", "memory", "0", "1");
 
+	kmsan_unpoison_memory(dest, src_len - s.odd);
 	return src_len - s.odd;
 }
 
@@ -454,6 +457,7 @@ static inline int cpacf_kmc(unsigned long func, void *param,
 		  [opc] "i" (CPACF_KMC)
 		: "cc", "memory", "0", "1");
 
+	kmsan_unpoison_memory(dest, src_len - s.odd);
 	return src_len - s.odd;
 }
 
@@ -587,6 +591,7 @@ static inline int cpacf_kmctr(unsigned long func, void *param, u8 *dest,
 		  [opc] "i" (CPACF_KMCTR)
 		: "cc", "memory", "0", "1");
 
+	kmsan_unpoison_memory(dest, src_len - s.odd);
 	return src_len - s.odd;
 }
 
@@ -619,6 +624,7 @@ static inline void cpacf_prno(unsigned long func, void *param,
 		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
 		  [seed] "d" (s.pair), [opc] "i" (CPACF_PRNO)
 		: "cc", "memory", "0", "1");
+	kmsan_unpoison_memory(dest, dest_len);
 }
 
 /**
@@ -731,6 +737,7 @@ static inline void cpacf_kma(unsigned long func, void *param, u8 *dest,
 		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
 		  [opc] "i" (CPACF_KMA)
 		: "cc", "memory", "0", "1");
+	kmsan_unpoison_memory(dest, src_len);
 }
 
 #endif	/* _ASM_S390_CPACF_H */
-- 
2.55.0

