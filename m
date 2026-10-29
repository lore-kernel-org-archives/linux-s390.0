Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278855;
	b=Hyk6kKQppvRIQdHd0IuW+VkB/FuPNGMWPeDa6ZpjhUIp3AoPADdoQIqnJUDWgOwJ4M75
	 UNago+veGP1JGagXuiJhgubQZE/4xYbWSomJ/lJBRrs360E3frxVOg7zl5iJ8bYmzfMQ6
	 PTRFzXgEKQhi7OlX1Gg9NK1sojzvmYIS7ql7jdponHT082YDLj2FqMS7Afkbdwl5YaKfP
	 AnOmPsFO3EAdtBdGReywZesgfn3LPt03YLexrwquQLYK6y70u+uVp2DGPFyYSTxlBp52R
	 GFlP3on54VyKkZKm1SPoYy/6nBTQ2Z5Qt2ObmLote/54lokLKXQ4BSqxLCuta5Sv4YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=F950SaGN7ubI7nSv3wOeMxlFCprCU9/Cn35cUDdeZlU=;
	b=n0sT8t9itvcJasoMNCeKyI0zPUeMrO7HqiWHcB5xfZ9gxQps25HeGut/lhmg0w6H1V9z
	 CbE3BY57FiYE/jZn5x9wPQ44UVAKCdO0SMZT4/0Q9ZNkIizmaLrktdmVVAhH9hYTu2Lhk
	 b+FLWkHWQ52hrYQjY5RKfBhVgyB1WEPdDQH5Y8jO8lLW1zuaLWDwCRnDruiY0EeLVgssa
	 kOn8zWc5GGUflcOR/izLvW945TMufdbFSVBJpY8zdXMqZKtuQzSqXUQpw6V4Uatp56k0H
	 xx3jcUQyYlZONVmBWU0w30tsfP5qOI9dGuB7kU/pBQt8DA4rl31p32NOJkG/ZsomljQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="PDu/Yrje";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149E606A31D;
	Thu, 29 Oct 2026 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5149E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PDu/Yrje
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCi3qU003069;
	Thu, 29 Oct 2026 13:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F950SaGN7ubI7nSv3
	wOeMxlFCprCU9/Cn35cUDdeZlU=; b=PDu/Yrje940qL8j/kExqKFhmLjTp+Kxki
	Jj3Vg4/Yv3ZSkUU3YGkrVocIJ9auI/eEbIITAilBzvtECIL1T5F1F2A5CCvxRtb5
	rlxckbBuc5r2j4CSohfGEk1TIOOVU9a3Usf2H5yXopb5Wuk7f+AwW2hUvQvIRE6J
	Iz6at1QsDA7dJVd1FGb+JEugrCufxOW8Yf4s4cX25f2ldZiJRW4JP3oW0zAZSZ9m
	SP2HXxgB2c4U1UhtkL/Eo6BpKJhxTlAWvso54mP20NlDR8tIgxEMzKqKtAGBohDf
	sDBMA6Rcue1YV9iM6rTfDSsa0tvLGmmwl8onHHKuNsJR8urYu7x5A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd7a8ke-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCnuTU3196240;
	Thu, 29 Oct 2026 13:00:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hjvh218w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0jdF38994224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A16E42004D;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 790952004B;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 5/7] KVM: s390: vsie: Fix pinning using the wrong flag
Date: Thu, 29 Oct 2026 14:00:42 +0100
Message-ID: <20261029130044.125032-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029130044.125032-1-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae34384 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ugznIdUm-YL1OzzZZBQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX7kGbjOT6MBN/
 3oSxmm8CSOStzwmkedIhgBow90hKjuBkidAgHqqtl8tJiTC0fp44qK5zUezr6CYHvwzKC6veNQt
 Fkjk8fK4rPUUeRJhQmaF7FC06PRdR4+jzfha9kcOEYUaUioMDIwha2c5N71bjMyIeenoZb4Fi36
 HhCcTLvfayBQcOSWmzO30Wok+PqK/5ywl+4Z5SfiSyIta6CrHXH1+78ilAT3OaRfCyYqsItnEkA
 CYL0GijfE2MzwRSq8GlVc96LF/zpYDAuUtzPHg3f3H76nTXgSYb4ELpmoBMJ1BZx7ekaR6+mbSM
 hoyP7OoEqbrzaqwFxPUuKzZYyCWtCHfDXHfMTN7kGk0OJ9l6Bp+T2XLCb7/khLF+PIVJ4rPwqJQ
 WxB5wRiT5GTCYMidNOPyYI+65Xpb6EdPil0+wom/rNcXWBlZhTIcyWAgIT8KkeFwu7WAVB2dDqs
 jSjb017GzfyGRE6dj6A==
X-Proofpoint-GUID: JiI5BG9cnzORZC45R07GbTX6szlmZHYF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX436M30MBIbxN
 woL4avCia1sjnoSYr+vkigozfNg9QxUjv0pFsdIIH73RTf9zZ1DTGRuBXU+ikrLT0nuWNXhUQKJ
 EKzp4B+mBe9cARKXHpuul3Bc6ukuNZk=
X-Proofpoint-ORIG-GUID: JiI5BG9cnzORZC45R07GbTX6szlmZHYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290049

When pinning guest memory using pin_blocks(), gfn_to_page() was used,
which under the hood uses FOLL_GET, which is the wrong type of flag for
memory that is accessed directly by hardware.

Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
correct thing to do.

While technically a bugfix, the previous behaviour can only lead to
guest corruption in extremely convoluted test scenarios that cannot
happen in real/production systems.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org #7.0+
---
 arch/s390/kvm/s390/vsie.c | 135 ++++++++++++++------------------------
 1 file changed, 49 insertions(+), 86 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5926689fa226..6dd06ed52bb8 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -49,20 +49,21 @@ struct vsie_page {
 	/* address of the last reported fault to guest2 */
 	unsigned long fault_addr;		/* 0x0228 */
 	/* calculated guest addresses of satellite control blocks */
-	gpa_t sca_gpa;				/* 0x0230 */
-	gpa_t itdba_gpa;			/* 0x0238 */
-	gpa_t gvrd_gpa;				/* 0x0240 */
-	gpa_t riccbd_gpa;			/* 0x0248 */
-	gpa_t sdnx_gpa;				/* 0x0250 */
+	struct kvm_host_map sca_map;		/* 0x0230 */
+	struct kvm_host_map itdba_map;		/* 0x0260 */
+	struct kvm_host_map gvrd_map;		/* 0x0290 */
+	struct kvm_host_map riccbd_map;		/* 0x02c0 */
+	struct kvm_host_map sdnx_map;		/* 0x02f0 */
+	struct kvm_host_map scb_map;		/* 0x0320 */
 	/*
 	 * guest address of the original SCB. Remains set for free vsie
 	 * pages, so we can properly look them up in our addr_to_page
 	 * radix tree.
 	 */
-	gpa_t scb_gpa;				/* 0x0258 */
+	gpa_t scb_gpa;				/* 0x0350 */
 	/* the shadow gmap in use by the vsie_page */
-	struct gmap_cache gmap_cache;		/* 0x0260 */
-	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
+	struct gmap_cache gmap_cache;		/* 0x0358 */
+	__u8 reserved[0x06f8 - 0x0370];		/* 0x0370 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
 	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
 };
@@ -681,72 +682,45 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
 }
 
 /*
- * Pin the guest page given by gpa and set hpa to the pinned host address.
+ * pin_guest_page() - Pin the given guest page and return its hpa.
+ * @vcpu: the vCPU
+ * @gpa: the gpa to pin
+ * @map: the map representing this pinning.
+ *
  * Will always be pinned writable.
  *
- * Returns: - 0 on success
- *          - -EINVAL if the gpa is not valid guest storage
+ * Returns: - 0 if the gpa is not valid guest storage,
+ *          - The host hpa of the pinned page in case of success
  */
-static int pin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t *hpa)
+static hpa_t pin_guest_page(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map)
 {
-	struct page *page;
-
-	page = gfn_to_page(kvm, gpa_to_gfn(gpa));
-	if (!page)
-		return -EINVAL;
-	*hpa = (hpa_t)page_to_phys(page) + (gpa & ~PAGE_MASK);
-	return 0;
-}
-
-/* Unpins a page previously pinned via pin_guest_page, marking it as dirty. */
-static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
-{
-	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
-	/* mark the page always as dirty for migration */
-	mark_page_dirty(kvm, gpa_to_gfn(gpa));
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map))
+		return 0;
+	if (!kvm_vcpu_mapped(map))
+		return 0;
+	return (hpa_t)PFN_PHYS(map->pfn) + (gpa & ~PAGE_MASK);
 }
 
 /* unpin all blocks previously pinned by pin_blocks(), marking them dirty */
 static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	hpa_t hpa;
 
-	hpa = (u64) scb_s->scaoh << 32 | scb_s->scaol;
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->sca_gpa, hpa);
-		vsie_page->sca_gpa = 0;
-		scb_s->scaol = 0;
-		scb_s->scaoh = 0;
-	}
+	kvm_vcpu_unmap(vcpu, &vsie_page->sca_map);
+	scb_s->scaol = 0;
+	scb_s->scaoh = 0;
 
-	hpa = scb_s->itdba;
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->itdba_gpa, hpa);
-		vsie_page->itdba_gpa = 0;
-		scb_s->itdba = 0;
-	}
+	kvm_vcpu_unmap(vcpu, &vsie_page->itdba_map);
+	scb_s->itdba = 0;
 
-	hpa = scb_s->gvrd;
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->gvrd_gpa, hpa);
-		vsie_page->gvrd_gpa = 0;
-		scb_s->gvrd = 0;
-	}
+	kvm_vcpu_unmap(vcpu, &vsie_page->gvrd_map);
+	scb_s->gvrd = 0;
 
-	hpa = scb_s->riccbd;
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->riccbd_gpa, hpa);
-		vsie_page->riccbd_gpa = 0;
-		scb_s->riccbd = 0;
-	}
+	kvm_vcpu_unmap(vcpu, &vsie_page->riccbd_map);
+	scb_s->riccbd = 0;
 
-	hpa = scb_s->sdnxo;
-	if (hpa) {
-		unpin_guest_page(vcpu->kvm, vsie_page->sdnx_gpa, hpa);
-		vsie_page->sdnx_gpa = 0;
-		scb_s->sdnxo = 0;
-	}
+	kvm_vcpu_unmap(vcpu, &vsie_page->sdnx_map);
+	scb_s->sdnxo = 0;
 }
 
 /*
@@ -783,13 +757,12 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			 ((gpa + offsetof(struct bsca_block, cpu[0]) - 1) & PAGE_MASK))
 			rc = set_validity_icpt(scb_s, 0x003bU);
 		if (!rc) {
-			rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-			if (rc)
+			hpa = pin_guest_page(vcpu, gpa, &vsie_page->sca_map);
+			if (!hpa)
 				rc = set_validity_icpt(scb_s, 0x0034U);
 		}
 		if (rc)
 			goto unpin;
-		vsie_page->sca_gpa = gpa;
 		scb_s->scaoh = (u32)((u64)hpa >> 32);
 		scb_s->scaol = (u32)(u64)hpa;
 	}
@@ -801,12 +774,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			goto unpin;
 		}
 		/* 256 bytes cannot cross page boundaries */
-		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc) {
+		hpa = pin_guest_page(vcpu, gpa, &vsie_page->itdba_map);
+		if (!hpa) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
 			goto unpin;
 		}
-		vsie_page->itdba_gpa = gpa;
 		scb_s->itdba = hpa;
 	}
 
@@ -820,12 +792,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		 * 512 bytes vector registers cannot cross page boundaries
 		 * if this block gets bigger, we have to shadow it.
 		 */
-		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc) {
+		hpa = pin_guest_page(vcpu, gpa, &vsie_page->gvrd_map);
+		if (!hpa) {
 			rc = set_validity_icpt(scb_s, 0x1310U);
 			goto unpin;
 		}
-		vsie_page->gvrd_gpa = gpa;
 		scb_s->gvrd = hpa;
 	}
 
@@ -836,13 +807,12 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			goto unpin;
 		}
 		/* 64 bytes cannot cross page boundaries */
-		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc) {
+		hpa = pin_guest_page(vcpu, gpa, &vsie_page->riccbd_map);
+		if (!hpa) {
 			rc = set_validity_icpt(scb_s, 0x0043U);
 			goto unpin;
 		}
 		/* Validity 0x0044 will be checked by SIE */
-		vsie_page->riccbd_gpa = gpa;
 		scb_s->riccbd = hpa;
 	}
 	if (((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) ||
@@ -866,12 +836,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		/* Due to alignment rules (checked above) this cannot
 		 * cross page boundaries
 		 */
-		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-		if (rc) {
+		hpa = pin_guest_page(vcpu, gpa, &vsie_page->sdnx_map);
+		if (!hpa) {
 			rc = set_validity_icpt(scb_s, 0x10b0U);
 			goto unpin;
 		}
-		vsie_page->sdnx_gpa = gpa;
 		scb_s->sdnxo = hpa | sdnxc;
 	}
 	return 0;
@@ -881,13 +850,9 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 }
 
 /* unpin the scb provided by guest 2, marking it as dirty */
-static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
-		      gpa_t gpa)
+static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
-	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
-
-	if (hpa)
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+	kvm_vcpu_unmap(vcpu, &vsie_page->scb_map);
 	vsie_page->scb_o = NULL;
 }
 
@@ -901,12 +866,10 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		   gpa_t gpa)
 {
 	hpa_t hpa;
-	int rc;
 
-	rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
-	if (rc) {
-		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		WARN_ON_ONCE(rc);
+	hpa = pin_guest_page(vcpu, gpa, &vsie_page->scb_map);
+	if (!hpa) {
+		WARN_ON_ONCE(kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING));
 		return 1;
 	}
 	vsie_page->scb_o = phys_to_virt(hpa);
@@ -1601,7 +1564,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
 out_unpin_scb:
-	unpin_scb(vcpu, vsie_page, scb_addr);
+	unpin_scb(vcpu, vsie_page);
 out_put:
 	put_vsie_page(vsie_page);
 
-- 
2.56.0

