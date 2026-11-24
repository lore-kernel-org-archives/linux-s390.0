Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528795;
	b=sOzlvMZ8AHv65adzEUsXv/oyK9ZdUIp5o1rIzqKSO6Nrn+0QlHA+SMy5DjKslS3HZ3pJ
	 Fv4SZCXFz3izIJWtesbx2z4n5LtL3tHLpMyXKUCHQpllKuEzcdPEwuYfYRIsj2t+8lfxJ
	 zzHAVPGw+BFWDBm5Zy/W0C/dbGGUYblNxaHn4XF9ZV/j/moJ5+8SPrejmBQlhkkH5up6C
	 pTsU/YtmrKJSgGKDwSsWvfzUdXGhUFyPIlV38+j1JuVDg2bqkCMAZGqmuUxpMilnGSqo2
	 kuM8k4TWxBEnHe9DjGUtf4ARSpPKwub0CZn2/HEcSTQZ27s1yinfWQJ3ZPBdUOD3DkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HZdSQR7mo22J/jt9QB9seE18eHaylA+GLTqAqoxZ8Fk=;
	b=qS1w7Z05O0M6sHVvfWNChLr3DJ+X6sp1w6VArPb95wWbdqDqIAE5vma41eXyti7oN/H+
	 X2Y2/kN8OxYGtgEXSuALK+yETopo1qvi62dR3gkLjhySgId8C48is89b3iiwLd4NXCu1o
	 qRnZa7WLgzB6kTl5D4V2LPJnwBs7Ljd7RLvo9+XKzHbY+IUvBZnLf7g+hMFLdHl14kuC6
	 XyshHEkXTHUokhfIDPWvYsAZz4UkNId0v6/XutFm5pMuhaHZf724u4qG3C5KLnMhEW3Rz
	 vUOX6EFeVt3QUSVm/zXFxylka1JNr27jKC2tF9GKoHp/F9VyU3BHGSe9pm+QWbTu2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bk4s5cBh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EC606A32E;
	Tue, 24 Nov 2026 13:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC0EC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bk4s5cBh
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4aQ32236311;
	Tue, 24 Nov 2026 13:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HZdSQR7mo22J/jt9Q
	B9seE18eHaylA+GLTqAqoxZ8Fk=; b=bk4s5cBhKsh3ksxnAgy8p7/a+PuZKs6QS
	bAfY3FnzUaP9xv3qoyxjN59RPcEQ8a3X8iM44mGW4vp3FSbBoFD7qoRh4m4KcEPl
	R/0WnIkb2qgVgdBhAq1/Vscmn27qFItO0Cb/7iyE0NbtYnezWuu3TwlV52ilIQj0
	pZKAEq7ppXub2le/rQLDaN8c/9aRy62cfoCNUUSxof9hZ8JBrvIleZzaNLxO0bVX
	grDYTXT/LyqytEy1TDhgElNJOUtJVbPn263MUzK2rZH95ip9TTg/163Q+BYZNxqG
	fQU/wUR8noTj4KL7FOa+xn0Ly90OmxIKpQNWE2ohtM+itTV6eAf6A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkfxyn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4IxX2194685;
	Tue, 24 Nov 2026 13:59:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3quftjqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AODxnRH10027406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 13:59:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5335B2004F;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B0C22005A;
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
Subject: [PATCH 2/5] s390/mm: Remove unused nodat parameter from ptep flush helpers
Date: Tue, 24 Nov 2026 14:59:45 +0100
Message-ID: <20261124135948.1295745-3-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX3me+E045M0S0
 xuFDq8cYpcP6DQVElTtWe841+CJQoqT4a3s6eYM+5wS2ETHEMMshfCih7BZootBAwBP9hs5151G
 KduKGsrxbzI0OF1ARX6IEfluTxivAQsSyxIXUJ2eKLNFIStvnVwiBDA0XdpBPAOLRDcyLV/0uah
 //EnhdkZc5CyQ4npC3V944yXFx6KZywWzBoJ5qaR6rHE8q1Ypiy2Ovo6b4VKyXkh6IaZvRCsX74
 pVG5DqrFDwExMKfsWRjtmiEQS1WIl+5p59NQDaBotqR1eJSIWe6fCnMi8TNA3jO+UNGMZHRp5Gc
 7ew2JDSnw3lnIDK4GuB9/P3fOHt1BUix/R2ZyWH56Sk6kr4buQZJRGVvgn9SG1dMz9w1btT11pG
 PihOnKjcd6O47sdJhQA8q5MVbEWwkrSblYXvM723ts+BY1LVqjhWedE++s6TKMz3hRlIQI3JMw+
 SgcjYmDbab2XzH9kbEw==
X-Proofpoint-ORIG-GUID: gvq7ogR7sg5p7tnsIURY6RPq9MFl4Fuu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX0hNNxDEZgyws
 5dgHGlW2WfPDeK8t57HSUXWxo7KS/3yAgInptsp701phfRMsJZanc2jtPAALTGztQfpE6fyEviU
 oUeBbKzUj7ohuUGfDpSfwJH4Q+jDGCY=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b059859 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jbhXUUL_eohGLTBuE_IA:9
X-Proofpoint-GUID: gvq7ogR7sg5p7tnsIURY6RPq9MFl4Fuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240053

The nodat parameter of ptep_ipte_local() and ptep_ipte_global() is not
used anymore. Remove it and update its callers.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/pgtable.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 561d280d485f..1aa5fe0b30d8 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -36,8 +36,7 @@ pgprot_t pgprot_writecombine(pgprot_t prot)
 }
 EXPORT_SYMBOL_GPL(pgprot_writecombine);
 
-static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr,
-				   pte_t *ptep, int nodat)
+static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	if (machine_has_tlb_guest())
 		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_LOCAL);
@@ -45,8 +44,7 @@ static inline void ptep_ipte_local(struct mm_struct *mm, unsigned long addr,
 		__ptep_ipte(addr, ptep, 0, 0, IPTE_LOCAL);
 }
 
-static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long addr,
-				    pte_t *ptep, int nodat)
+static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	if (machine_has_tlb_guest())
 		__ptep_ipte(addr, ptep, IPTE_NODAT | IPTE_GUEST_ASCE, mm->context.asce, IPTE_GLOBAL);
@@ -54,9 +52,7 @@ static inline void ptep_ipte_global(struct mm_struct *mm, unsigned long addr,
 		__ptep_ipte(addr, ptep, 0, 0, IPTE_GLOBAL);
 }
 
-static inline pte_t ptep_flush_direct(struct mm_struct *mm,
-				      unsigned long addr, pte_t *ptep,
-				      int nodat)
+static inline pte_t ptep_flush_direct(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t old;
 
@@ -66,16 +62,14 @@ static inline pte_t ptep_flush_direct(struct mm_struct *mm,
 	atomic_inc(&mm->context.flush_count);
 	if (cpu_has_tlb_lc() &&
 	    cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
-		ptep_ipte_local(mm, addr, ptep, nodat);
+		ptep_ipte_local(mm, addr, ptep);
 	else
-		ptep_ipte_global(mm, addr, ptep, nodat);
+		ptep_ipte_global(mm, addr, ptep);
 	atomic_dec(&mm->context.flush_count);
 	return old;
 }
 
-static inline pte_t ptep_flush_lazy(struct mm_struct *mm,
-				    unsigned long addr, pte_t *ptep,
-				    int nodat)
+static inline pte_t ptep_flush_lazy(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t old;
 
@@ -88,7 +82,7 @@ static inline pte_t ptep_flush_lazy(struct mm_struct *mm,
 		set_pte(ptep, set_pte_bit(old, __pgprot(_PAGE_INVALID)));
 		mm->context.flush_mm = 1;
 	} else
-		ptep_ipte_global(mm, addr, ptep, nodat);
+		ptep_ipte_global(mm, addr, ptep);
 	atomic_dec(&mm->context.flush_count);
 	return old;
 }
@@ -99,7 +93,7 @@ pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
 	pte_t old;
 
 	preempt_disable();
-	old = ptep_flush_direct(mm, addr, ptep, 1);
+	old = ptep_flush_direct(mm, addr, ptep);
 	set_pte(ptep, new);
 	preempt_enable();
 	return old;
@@ -137,7 +131,7 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 	pte_t old;
 
 	preempt_disable();
-	old = ptep_flush_lazy(mm, addr, ptep, 1);
+	old = ptep_flush_lazy(mm, addr, ptep);
 	set_pte(ptep, new);
 	preempt_enable();
 	return old;
@@ -147,7 +141,7 @@ EXPORT_SYMBOL(ptep_xchg_lazy);
 pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t *ptep)
 {
-	return ptep_flush_lazy(vma->vm_mm, addr, ptep, 1);
+	return ptep_flush_lazy(vma->vm_mm, addr, ptep);
 }
 
 void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
-- 
2.53.0

