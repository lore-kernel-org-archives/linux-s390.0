Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5398632B;
	Fri, 14 Aug 2026 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786709769; cv=none; b=S0Tkp0bUFeW0YBOnovSYHgnsp2PNL3ApBrvLY7OSh6v5SaeF0dRwiuYk9I1IIUtNJHP41sox7PN5toMV556+4IfoCzpOpbzQo+7wMaiNDzB2nYaS5ihaBcmQ7gaj0ypdS4xWtlVhjnnyFmGJkzwFWswi/owZpcYUIVCteIm3Vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786709769; c=relaxed/simple;
	bh=7vYVqkb7/gr0yqGHUQQVcTXGt2Qbp0FgMcVEkkSolKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9qj/0XELGLtHG+7a6r8/ucV9bNQgNXZ3t9mYFjNLofhsIHS9EyEwxm65u+tCTniwGF1Tp2VmbaJp2drAzIp1b5o6OtVAUC57E30AFASeAJUcS0SD748fx8xby37tzWPgF7UVGogyaIs2PhUmEU2mBbYrp9BROKB/MvaBYS4jkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GHMI3fkf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GHMI3fkf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EB1jhh984611;
	Fri, 14 Aug 2026 12:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+Spdl3Tafte+NIT5vMOT1LXRXYMbh5gefzgHLzPzQ
	ak=; b=GHMI3fkf2xX4IwnGQDL6bjxpcUxsw3OLtrWYRnEaUqlNoPNWF0nv6AHMQ
	E93Q8gONrKwuqgHNxCzBhOSqgbVbNTGpCbD2iyazj8Dv67iOA5sq61gGiCYDxckb
	9OgLB8D0wXedRhu1fT8oyVE0vSeFKv7p3rbRq60f/sweguv+wFE0xckCJUv1yxcb
	xsHGbEWRivHv7cnl0nYG48aCxAwAntpBAjLzZ0dxpITTWp8RpHich1s3ooWjzYJQ
	ZRHVBw+p2RahiDNJf2M3njdpuqHmHbSL8rSXOHT93nDFhObOI4MaPTzjfVaa09LY
	MEgE++ZATTZ3ZcDVWS1QSOAUTe+/g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwkgx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:16:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ECBHd7005706;
	Fri, 14 Aug 2026 12:16:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hf510-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 12:16:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ECG2kJ31785706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 12:16:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D1A02004B;
	Fri, 14 Aug 2026 12:16:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0664220040;
	Fri, 14 Aug 2026 12:16:02 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.12.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 12:16:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3] s390/cpacf: Unpoison instruction results
Date: Fri, 14 Aug 2026 14:15:25 +0200
Message-ID: <20260814121559.1240939-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7f0707 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4nVjCsc_dGox6U1-_OoA:9
X-Proofpoint-GUID: VH_W5DtoAeH4dj6iHZ5HiApGtMuXmWAK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX4e0ODbUEJ+A1
 kGQIPDoa6V6g9c2XyJon/9IWBb6wKDuhWqiqZ3PyWo8skeJa+QToksIBox/aSCM8sAKVnvDuuUT
 aoaBmINrB5FqKPFvAHLIuenE3sCTJTpFaJPG4vYhSeelbq96an2GciWWU3/5YKzHPOFIYkcoErY
 iYQc2cJVvboc+ltL9UaFliIOOqC7UAqy24QfNrfCG9InzMVeRRWu+H0hTro35olmscEPQTf7G11
 K9HQcoUbVfnKjCcdziGsPGAwYUZ9le+0jehMeCnXl5BurSKRyZjcF1/q1qHaL6fQu3vJBD3MHbZ
 Vy/JFNK6GOlx6BHQhSksZbInDhMcQw7TnbotyyiwfLVQ91t6ByzCoaHJ0Hdnc+UBpsKVpwt2ei5
 ezbSdPn1A5H8kWrKjVngiSOimzDxZrYxOU0/UHuP27V6TSY34GBuz0HNZTsOF9GVG372rvsG5U6
 zOCAnt3HIRZSca20LGQ==
X-Proofpoint-ORIG-GUID: VH_W5DtoAeH4dj6iHZ5HiApGtMuXmWAK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX9+GRq6FKERrw
 CNeflyRDDiUfzq+hFUUkJTf8lIXxikW7mcD/UTfSnBrnF/GCky44do1HR+ACK/j7Zxq/tTSCCGf
 FkPeaDahJrwZnaMTxE1xb+E8GfSHiT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140091

Stop KMSAN from complaining about CPACF outputs being uninitialized.

Do not unpoison variable-length parameter blocks: mapping function
codes (like CPACF_KIMD_SHA_256) to lengths will be ugly. So let the
callers do this once the need arises.

Also do not touch cpacf_kma(): this wrapper does not handle cc 1 and
cc2 at the moment and has to be reworked.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v2: https://lore.kernel.org/all/20260807122132.3592583-1-iii@linux.ibm.com/
v2 -> v3: Drop cpacf_kma() change, add R-b (Harald).

v1: https://lore.kernel.org/linux-s390/20260806190223.3292580-1-iii@linux.ibm.com/
v1 -> v2: Unpoison outputs of more instructions (Sashiko).

 arch/s390/include/asm/cpacf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index a83683169d98d..6174552d856dc 100644
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
-- 
2.55.0

