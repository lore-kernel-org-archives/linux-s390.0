Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528796;
	b=c4fhRChwKa/cu0RCtRYAGBwvTUdkEzN8WuIMZRxohREvb34/Uo/AVzlKBBRn8o2IkheO
	 jjGWKSWecAiz0948zV1Yd1C7M7fgHpcvyetx8lWkqHhF3uzln3Yjuv/Fv2hJNMDgHOCFD
	 vJkd6yUn6IQQvQ4lkY+pssOWcRnWJwA3+4jlPS6fFAz9o8+jOgcVNaXyO7SNneNiABeVm
	 nePs5Y5wQp1EcAaehTSOFvO+WdWHVQCy8lDWi3isOz81uuTcUo34pDP98/dNarNAeFiBn
	 JbFJGNdenJ87JL+SaDYfomHxF8Uwn2I71iDz9IF/EJzXzquiCiIxS+/B+hUYhpIB4Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4e09wdtjeuazUTB472jerGajqyhJp4agSHixKJuJG2g=;
	b=hP5ni6B7xNvydoQqFNNhiKRV76VCFniz1xPwjSkS7I9AGJZlysx1uYmTclZHJgyRcx82
	 JWn1OywT/nChAe1J0hjGgkZDZt/9bu/8Y/ChQ9vXuIe4/2k/TUrBSu2SlZKop6huMlCxo
	 jDRx1KVuSvvOc7f3NoU44OViobV7RO/ETKbhsJ4069/QVo89cjzG/OA83kQbxWh87Et6Y
	 TxoRggckAPTsiUMgWWLR1qPC9QuSGYTUCFYgyWv3ZbGFY4qOl6gr8ckAJdhM3FWSuGnIM
	 mayqMIilF3kyDhDPJAeavFAj35O+IjnItwHLdkUHG20pL+P5KpcbyhKiKDWIC1A0oug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sr8PTt5X;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD1606A338;
	Tue, 24 Nov 2026 13:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECD1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sr8PTt5X
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4eT12241983;
	Tue, 24 Nov 2026 13:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4e09wdtjeuazUTB47
	2jerGajqyhJp4agSHixKJuJG2g=; b=sr8PTt5X5DmX3+WncZDGizNB7MuDHmk39
	It0PYlGFFOe2L/XRkU17xP18tXmdt75B4HbKKkzM11oVar+pliSahZmbelfyqU0A
	uVeOptiqSRNGbvNSYN+z50ph9uA6++dgMumsDbW8XIkxm7tw9D/mjalwwdqsBoIL
	dTTsD9VUvEdoAQCk6g8sZPAQ39qBsa8MQPrsR3lD1B8w6O2Kwk+Co0y6AJid2WxP
	Fo4ohfItpvtHigE15EZTbwAfK80faD1jEb/pEkOLRTioK/zRe/IyBXFO/+RHNBSf
	QRxOhKjScUbd5OtQzXeAJBjldz4FpTShP2acYmEgw+G8Y+kFyNoYA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g17jab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4NEC223678;
	Tue, 24 Nov 2026 13:59:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4haphf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AODxnPL31195742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 13:59:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE8BB2004F;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 875A42004E;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] s390/mm: Add pmdp_idte() helper
Date: Tue, 24 Nov 2026 14:59:47 +0100
Message-ID: <20261124135948.1295745-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135948.1295745-1-hca@linux.ibm.com>
References: <20261124135948.1295745-1-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vU_J_yZPvFVD41yr9L9emqDlZIXzfnAW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX7UQ+7Kk4z/QA
 DHJCeyp68ew8yjLdt6C9KJizrq4rKqKHPxQtYHke8RshUAyNiZ5zLtaiFSY5NY3chZjs1YKQiYi
 lpX3cYF1cMFgnBiXUQVsA2dluZc1ZLk=
X-Proofpoint-GUID: vU_J_yZPvFVD41yr9L9emqDlZIXzfnAW
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b05985a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=otwN0_ap-KDBOC0FYdYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX1PwCNC5vob/H
 6ZesINd7cDN08SIDdQYH4H8BGDflVTKt5FjPG6q36fsjW6tb7Jyn2C9WSaAUEtkxIgFFkULlK7j
 kJ2DMJJel5I0syrM0WOaz0+QPGqDCK1tE1MOvE+KGQ4A8UnE5SCEt653vhaIdUNepnbXMV1aRXA
 NDOrTfFWY5aEn6QAdZyO2JauO9XW+2x61rgB0yNZh0/Xu1ENKPfD+QFCp/8l5Ob/1wOLQ1E/jH1
 MlCQRUJDHwRasFf/8aGDVyebxZeYDipzrdFKI+HLyXDOTxhaSiwEYJkFZUAgHIpLZcnOINl3c3e
 Gfi57pMqPFjzeUCt1mT4P3PbI+JP5MxBlBWjAQPtqXVNmFsFpC3GYzYfJF+9LnuQ8I90ADjNcTz
 ma0rswUo7jrtIkSM92ehc9oPV+Dl96UgUtfeN5NEn+T+2FoDN4x6+3NXcJMNFRk8YUJdAaxahMq
 fNV7mtwuV8gPvDSuyqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240053

Add a common pmdp_idte() helper in order to avoid the
repeated machine_has_tlb_guest() checks.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 10 ++++++++++
 arch/s390/mm/pgtable.c          | 18 ++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 378d2db6e6be..0d5ea2dca786 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1661,6 +1661,16 @@ static __always_inline void __pmdp_idte(unsigned long addr, pmd_t *pmdp,
 	}
 }
 
+static __always_inline void pmdp_idte(unsigned long addr, pmd_t *pmdp,
+				      unsigned long opt, unsigned long asce,
+				      int local)
+{
+	if (machine_has_tlb_guest())
+		__pmdp_idte(addr, pmdp, opt, asce, local);
+	else
+		__pmdp_idte(addr, pmdp, 0, 0, local);
+}
+
 static __always_inline void __pudp_idte(unsigned long addr, pud_t *pudp,
 					unsigned long opt, unsigned long asce,
 					int local)
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index f6a960f39abf..72b62ad480bd 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -144,24 +144,14 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 	set_pte(ptep, pte);
 }
 
-static inline void pmdp_idte_local(struct mm_struct *mm,
-				   unsigned long addr, pmd_t *pmdp)
+static inline void pmdp_idte_local(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp)
 {
-	if (machine_has_tlb_guest())
-		__pmdp_idte(addr, pmdp, IDTE_NODAT | IDTE_GUEST_ASCE, mm->context.asce, IDTE_LOCAL);
-	else
-		__pmdp_idte(addr, pmdp, 0, 0, IDTE_LOCAL);
+	pmdp_idte(addr, pmdp, IDTE_NODAT | IDTE_GUEST_ASCE, mm->context.asce, IDTE_LOCAL);
 }
 
-static inline void pmdp_idte_global(struct mm_struct *mm,
-				    unsigned long addr, pmd_t *pmdp)
+static inline void pmdp_idte_global(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp)
 {
-	if (machine_has_tlb_guest()) {
-		__pmdp_idte(addr, pmdp, IDTE_NODAT | IDTE_GUEST_ASCE,
-			    mm->context.asce, IDTE_GLOBAL);
-	} else {
-		__pmdp_idte(addr, pmdp, 0, 0, IDTE_GLOBAL);
-	}
+	pmdp_idte(addr, pmdp, IDTE_NODAT | IDTE_GUEST_ASCE, mm->context.asce, IDTE_GLOBAL);
 }
 
 static inline pmd_t pmdp_flush_direct(struct mm_struct *mm,
-- 
2.53.0

