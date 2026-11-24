Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528795;
	b=v/0BycmBOmZarwZG0+YSXJJymqL3KcS5rhMfOmzF+2JyXrIJFuondQOJQ8RFNtV9ZnHl
	 qYn3gjDpOakL0rCww4U3q3YL0laerVUl1elJuIHvVJvWH8fpyWaMHx7LThUgDGY6psRWS
	 hH1eXzP7xeWC5iHW53J4XWSvf0cvWxPwKEiMPQwHQA8CDGigsQKBVqEAGkajAd7eo8yPR
	 rRBZx1mEhJjICFVSf5YjXHy7JE9lGCQ0csORWGg0Eni6i39iUjcdHMVwMfCI15C6SXlDh
	 TQOdrYu2s6BtFSR/6+odMNunRPjkrmJaKkmvDGXkARFi8AQwn2sRGWA63Lh7nfTVxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ye56E2efZFAoOZOv+S933AGpO2nN1a5HFssMxjr4crI=;
	b=b1xZDmz6lY139ABhet+jFuv1ARU91djVvm2mU7JmXHGe4WWkZOLr1bw/DYUngLHDBwO6
	 ePmHBHpSOj/w3YTnnfdD/DCWkKXfAjX8D9LnGGPt4z58EhWIZqI+rQX0tnM3j2614Jtnh
	 kg39wd19lVEfJaIUkvebdHStEZkDAr51Xbn3q0Ft4D6+xNEFc6LaTC0cSENoBpL+V7mgI
	 hetCnW4O2JITayFCUpAcVLkzM9QVJp6xuwz6qC91DIL7sXlXEo9M/Uzb/EVBKatilGXf/
	 uoB6spdct7deTxgiu7utmlNA4I2xE9V1ay70N8cf7MYDKe+PBfYgn/UKbVKzUamu0ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FHOpz6F4;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE09606A339;
	Tue, 24 Nov 2026 13:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE09606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FHOpz6F4
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4tmc2190242;
	Tue, 24 Nov 2026 13:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ye56E2efZFAoOZOv+
	S933AGpO2nN1a5HFssMxjr4crI=; b=FHOpz6F4HjdaEjEh3k1nt6uleTVuoVq2Y
	vRq1HRlMyQZEYxRB5/IxCXli0qKxMPbebl2qU8E0Y2gvu2Z63DfCWkTphYbvkMbC
	IQOj3k+DQ8s+ebv2T7xv+EbdDPa+ZiV60NIVbvTTOwTsHsiY4l3cJKleTdjT6+lY
	fBCssONu0Zdti9uDicAEW1t17UYk3Fa6PTq0PKBSP9iZBJzpyTm2YOmP/xWTCARs
	2gAIeV7Sq4tHh2I7kf4sXjKBSwCH1XCHIvFWncXiah2/ULMMgG2Vk14wSRPIGmZa
	3YyyceV3AtH2Sgajj1hIbG6+y6pcFLsLBP1Y0ZoaU9mCDC0fAdenA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv7kej-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOBrilQ595739;
	Tue, 24 Nov 2026 13:59:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a410b4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AODxnN618940408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 13:59:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 826B420040;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 582A42006A;
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
Subject: [PATCH 3/5] s390/mm: Add ptep_ipte() helper
Date: Tue, 24 Nov 2026 14:59:46 +0100
Message-ID: <20261124135948.1295745-4-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b05985a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ptYQGPvC9C3rTDOO18AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX0GgGzqJ0leO0
 mVwOcqP4xjdF/0seWAUh3tX1r/wcB4HB7RSsBvpFFx6OEXwJXwaYcLiACot0SPRaerp4SRvacTT
 lZJtLgNXiioejkB2v7kRR0YdP9lU/lg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX1gGrSAtES7AQ
 4HcEnev2dM2zDXiqUg/kUmwPqoUtchejEWoTtbfv/MPewTH7C9TkqTcQF5VPONpCVh/wF9Ptngk
 12lsnJjZSXWFnFhwLs8HeW1VAMGZL3njERh/M2jQ59qRtGlleZbdEIBgecF1CP/m31+236AVziT
 GaK/YAiRjhpAWlAlfMHlndw2lTS0mKG1HCeYKEa7hRmxIIqqwf3oOlNZo2LrVYQodrq7jK4oQL0
 e1DuicM1gEZevtzF8gTcqHhHw16Q/3Gyi+SKR/ZQxTyDjD0TpnutCek7A0Vn7NodCUNOAuGFhQV
 6n18KY6/RorJkenD7OUhz0Z6X7ndhadmFuy3T4ItgytuXPOIpmseDM/T998jfmIKTsOJ/VJZOku
 QVp7KIU1d4vN/BSNYkpf4OjFxwgfA9bYJUjobR5EJVdQFzcTkGDgDwHZQuRLuBdMYyuELOpbkjI
 VeI0GJKUPD9aBfbY4kg==
X-Proofpoint-ORIG-GUID: zHlyyxYZX24EVoNxSHpaIivbOXpfuwRI
X-Proofpoint-GUID: zHlyyxYZX24EVoNxSHpaIivbOXpfuwRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240053

Add a common ptep_ipte() helper in order to avoid the
repeated machine_has_tlb_guest() checks.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 11 +++++++++++
 arch/s390/kvm/gmap/dat.c        |  5 +----
 arch/s390/mm/pgtable.c          | 10 ++--------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2d5c2ab06de9..378d2db6e6be 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/mmap_lock.h>
 #include <asm/ctlreg.h>
+#include <asm/machine.h>
 #include <asm/bug.h>
 #include <asm/page.h>
 #include <asm/uv.h>
@@ -1156,6 +1157,16 @@ static __always_inline void __ptep_ipte(unsigned long address, pte_t *ptep,
 		: [r1] "a" (pto), [m4] "i" (local) : "memory");
 }
 
+static __always_inline void ptep_ipte(unsigned long address, pte_t *ptep,
+				      unsigned long opt, unsigned long asce,
+				      int local)
+{
+	if (machine_has_tlb_guest())
+		__ptep_ipte(address, ptep, opt, asce, local);
+	else
+		__ptep_ipte(address, ptep, 0, 0, local);
+}
+
 static __always_inline void __ptep_ipte_range(unsigned long address, int nr,
 					      pte_t *ptep, int local)
 {
diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 7a25e41a1423..909d665a67a9 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -173,10 +173,7 @@ union pgste __dat_ptep_xchg(union pte *ptep, union pgste pgste, union pte new, g
 	if (!old.h.i) {
 		unsigned long opts = IPTE_GUEST_ASCE | (pgste.nodat ? IPTE_NODAT : 0);
 
-		if (machine_has_tlb_guest())
-			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, opts, asce.val, IPTE_GLOBAL);
-		else
-			__ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, 0, 0, IPTE_GLOBAL);
+		ptep_ipte(gfn_to_gpa(gfn), (void *)ptep, opts, asce.val, IPTE_GLOBAL);
 	}
 
 	if (uses_skeys) {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 1aa5fe0b30d8..f6a960f39abf 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -38,18 +38,12 @@ EXPORT_SYMBOL_GPL(pgprot_writecombine);
 
 static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	if (machine_has_tlb_guest())
-		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_LOCAL);
-	else
-		__ptep_ipte(addr, ptep, 0, 0, IPTE_LOCAL);
+	ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_LOCAL);
 }
 
 static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	if (machine_has_tlb_guest())
-		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_GLOBAL);
-	else
-		__ptep_ipte(addr, ptep, 0, 0, IPTE_GLOBAL);
+	ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_GLOBAL);
 }
 
 static inline pte_t ptep_flush_direct(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-- 
2.53.0

