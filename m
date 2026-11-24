Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528797;
	b=Ho9HMdHyPBil4/m2vuBDYiqirqEZolOo9kkcSADgyr4rnWtSnbRduSJ24DOM8oYRykiX
	 KhEYMaWz5g3Y6zTFmczIYzAnYipyy6RsKrvTbH/3ElsEhlne/e6Fn9YVkDJDtpEK+TyKv
	 LWOeUxSJXVugL6Bb1iHoJniGMSxPHM42c5RNCjiX8SAuoZ5YLY/JdGiNpygQhBEsRFrvB
	 Gdi0EIbM7HUFOgYz2XhYpMT1go5IYsjG+g0YrmAj1W1WpTbbJMMKFESTGtnK7DJH9VA2X
	 ZzkL3zRRpHzEfYdx/zFAgr6e7ecjU8ZHBOoNZH2Ig6EildXQPNpPlSLwURSOIPOU5yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PUMFWlfKneA8ODZsLNLanSlmF8pOlSWamK/Y+QhmPUs=;
	b=WBPHjQGNchxFB36jVx1515QubaMnoUx+80Xk6xd/r/NrZcfyxawvL8jda9jSIYITwYqk
	 B71Mri+AaPxBoHuy89lhg3ZeJiscNj5M/FepYFBKlkiOYfiWczRE7aqbWyNa7mnCyWPd/
	 ekulpdhS9EiZap3HPqIs5aCJ1LCs1z3vq7M4Bn2xM2i40m/0REjJdNwSKYBcTi4eGuebP
	 rDgX0wgOsV9LrupOajEh53UcdE4VNfABCY4C8ZUNSsfReLOM3NteqIi1S4D0uNR45yYB7
	 jFa1MKWTpFzQZdMObvL8C0owFOM1R3YIWe82z9Cjul6PGsqV8i4gw3iCxz5UVxD9+CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MzeVd19g;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8A606A693;
	Tue, 24 Nov 2026 13:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F8A606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MzeVd19g
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4eJJ980037;
	Tue, 24 Nov 2026 13:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PUMFWlfKneA8ODZsL
	NLanSlmF8pOlSWamK/Y+QhmPUs=; b=MzeVd19gkdLB+BKFtmvi6c95TkPTKmF7K
	rtkzC01LTX25k0IpisS9q5O6/xToWiawS6PDxQSLu6PJ1F5E4XcxePkw61SgEeyb
	LNSjlgIE5lQR7GqY2vfkYX+QZIK87kF/BPJ0A1uJwTk6javKjymYBtZ/9AeY9K0G
	UZAXah3E/sJYPY1c53X9ZMFuRF08wWzkoYaoZvVotBt2XUP83BRYHqrzneFWjIG1
	WHepaaKLW0AG7j2+nlQabUsTV9KzX7zpSz7RdnqO10iRESYgOuE2wKEwi03scIBu
	w222giSlUcGWqKZjhgnkaqMmyJVFSK/sg76wo3nyo8NQaEcKpu1sQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4fdvf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOB4GkM2610806;
	Tue, 24 Nov 2026 13:59:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vjw46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 13:59:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AODxned18940410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 13:59:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD672004B;
	Tue, 24 Nov 2026 13:59:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B383B20063;
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
Subject: [PATCH 5/5] s390/mm: Add pudp_idte() helper
Date: Tue, 24 Nov 2026 14:59:48 +0100
Message-ID: <20261124135948.1295745-6-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX+g7ZC1BaWwZY
 jknihEGH10OSmyyZxnh8FIsUxdyDEcwAYOMO1jxmcKoTxbdw68CAuKtO+XIChrTmtR0y/oSlTZG
 IPLpPz0hFWBkyguy4LLtps+PUtVn/V0=
X-Proofpoint-GUID: kA4CAfasoRxTQGIoXz_0UYVpEiabG1oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfX7n5/IzoJ3h+8
 XounBc75UgXvRjupIJ2xANc0ZeZhtV9hE9QekIUlc1gzj+qSc/c7bap8w4i8DPoi6MlIzHQKiex
 Gsl50ICwLBgLD7sZf4UyobeDG14O7A0XRncxd5qJz03HkPARUotvRjguGFfXK7AciuEBfHoq53f
 R8XJtJrbQk5bSYMOqHhkRqRzQRrU8TQgvJjFiE4CHAZEIR3gFeLq7Omw6zJpbAU4YjqQPl6FM9E
 KKJ+FfjnZzzuE3eoq1HPi3+EhrR4l0hBDV5WTgqIFzHhS3X8p7E0gQ4LkLcmjekm3qXIUnkz+1Z
 6zhqS/d5CXdHOYaRB1WdARCySyG/88y6LEdOKHFunIYx4bBCFPxycplYTyiP3OvpolNHCz6vvNW
 fJrIzwLd3X25yzJY+LxxMw0j/+aE037isAJDEsEjd5aP03I9pZYP39v6iYYF/tKDppyN7ISG9gC
 yqiykuqY1PCX3awBh6w==
X-Proofpoint-ORIG-GUID: kA4CAfasoRxTQGIoXz_0UYVpEiabG1oq
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b05985c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=QSqi4p2pd-IzvVA_y34A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240053

Add a common pudp_idte() helper in order to avoid the
repeated machine_has_tlb_guest() checks.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 10 ++++++++++
 arch/s390/mm/pgtable.c          | 18 ++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0d5ea2dca786..e8bb46071306 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1698,6 +1698,16 @@ static __always_inline void __pudp_idte(unsigned long addr, pud_t *pudp,
 	}
 }
 
+static __always_inline void pudp_idte(unsigned long addr, pud_t *pudp,
+				      unsigned long opt, unsigned long asce,
+				      int local)
+{
+	if (machine_has_tlb_guest())
+		__pudp_idte(addr, pudp, opt, asce, local);
+	else
+		__pudp_idte(addr, pudp, 0, 0, local);
+}
+
 pmd_t pmdp_xchg_direct(struct mm_struct *, unsigned long, pmd_t *, pmd_t);
 pmd_t pmdp_xchg_lazy(struct mm_struct *, unsigned long, pmd_t *, pmd_t);
 pud_t pudp_xchg_direct(struct mm_struct *, unsigned long, pud_t *, pud_t);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 72b62ad480bd..23125e88d17a 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -218,24 +218,14 @@ pmd_t pmdp_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(pmdp_xchg_lazy);
 
-static inline void pudp_idte_local(struct mm_struct *mm,
-				   unsigned long addr, pud_t *pudp)
+static inline void pudp_idte_local(struct mm_struct *mm, unsigned long addr, pud_t *pudp)
 {
-	if (machine_has_tlb_guest())
-		__pudp_idte(addr, pudp, IDTE_NODAT | IDTE_GUEST_ASCE,
-			    mm->context.asce, IDTE_LOCAL);
-	else
-		__pudp_idte(addr, pudp, 0, 0, IDTE_LOCAL);
+	pudp_idte(addr, pudp, IDTE_NODAT | IDTE_GUEST_ASCE, mm->context.asce, IDTE_LOCAL);
 }
 
-static inline void pudp_idte_global(struct mm_struct *mm,
-				    unsigned long addr, pud_t *pudp)
+static inline void pudp_idte_global(struct mm_struct *mm, unsigned long addr, pud_t *pudp)
 {
-	if (machine_has_tlb_guest())
-		__pudp_idte(addr, pudp, IDTE_NODAT | IDTE_GUEST_ASCE,
-			    mm->context.asce, IDTE_GLOBAL);
-	else
-		__pudp_idte(addr, pudp, 0, 0, IDTE_GLOBAL);
+	pudp_idte(addr, pudp, IDTE_NODAT | IDTE_GUEST_ASCE, mm->context.asce, IDTE_GLOBAL);
 }
 
 static inline pud_t pudp_flush_direct(struct mm_struct *mm,
-- 
2.53.0

