Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122370;
	b=tZbCAQ7hlOOr4qTqnS75mu+oo8Vx7pR3NdWyXgu+s3vG/Dc4NF5wNToJfR3nlw+PT30Q
	 qCv2DGasnYhJd1J7/r2VLPYo5ccfj17NpOeIIEMCdZLdTYhJWOm04ql1d4rkQeAyAw9c5
	 +XP4kJnYAdkPU5lr3g47gKSV81qxTMoSqC4XGj4SPC2VDXtMH0F0M9R8A/Kt+5W9KR6sN
	 wikQXCVgSj07mQ84U85b3XgYWnVt0lEunv29Y3FU1rK7yg1aT+m1K+oqeSOKUo/xmLNuE
	 MWkGOo+IceRJvsSJoWRSg0u73aK1SOpBMkmC3ArCsru/l+xAEXpXxW9eZTTQfLt8xJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122370;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Bx77vG8fgSGqZKPYwF8T80Gm1qYuuLD+7NHnPJ1frnc=;
	b=e7gPo4NnnHBB6v3I4xbSklm+ucotS74CfZ0e+5jgxFMpIamdacoO8zsMtnw0X5oY5jaI
	 CneTzGs9y5F0CKC80yem/+0OqyOouD8gqz2ADmP2atmEDDd2MEYhmBJ8o9GntPRND1/ne
	 nUHRBFJgzzsTuGeq6cVIhpTCxIJu4TwGtSiJC74E0baTJJCDnxJdsNKngir6ZVQvnkHl+
	 ZQAu4wwTKIEV1IJY7qNHdMIyROd7Th0CwYZ1OiNR+lWyBVLGHFh49a4/RBfcYdjhCHJ1g
	 H+1qnB7uDTaH0MQOmBIbsh16obuxzTj4r33iDLrECHm6BZzqLHAHwnU1b+P987p+nYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fadt0Kji;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9969A606A322;
	Tue, 27 Oct 2026 17:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9969A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fadt0Kji
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHEVh33040763;
	Tue, 27 Oct 2026 17:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Bx77vG8fgSGqZKPYw
	F8T80Gm1qYuuLD+7NHnPJ1frnc=; b=fadt0KjiovK+c4wTTC6KuER68XkoQWmGN
	wTrefCFTDpse9V7Pnr2KI6scYkoVsE4RkI4EiJlz/DPp5VxQV8z9i29sWlTzj12S
	HKN+OXhzQzz+Ks5KW6qbRdbNi1FaUkAOwpPAH5Sha5vjBXVuWjEQH1Rv+cGTo+Vf
	V41u6FvKnG9r2ELnCJAEXcBB7a2P/cPoC1HcF0eJN3/CYMwZG1I/DG+T6w4HuIRR
	E+dh7HQUaKagxLvDwfjALnZZyYMjAZkW/NM83go2BrnUK/Rr1t2fZxrnW3AN0NTU
	yxT4aA0tpt+R9OX2m//j3G6gjWmfgRhr+cuG0Dfc7RuMiSofAJqtA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m91ck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RH53Lg3288258;
	Tue, 27 Oct 2026 17:32:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010g4nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RHWeUk38732278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 17:32:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EDE220043;
	Tue, 27 Oct 2026 17:32:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F652004F;
	Tue, 27 Oct 2026 17:32:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 17:32:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 4/4] KVM: s390: vsie: Fix pinning using the wrong flag
Date: Tue, 27 Oct 2026 18:32:39 +0100
Message-ID: <20261027173239.224849-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027173239.224849-1-imbrenda@linux.ibm.com>
References: <20261027173239.224849-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX/yj7KC4ZlPkR
 5E2TpFzICIDDCqyGB06c+kK/LEJ+WwMsV3Ptxf04zRjHLqFe9axH1e8gffRkEc9FiBmDBR2cA1d
 A9AHvDLM0ollHhHQ/m9TDQgpS8fBHGA=
X-Proofpoint-ORIG-GUID: H8l3_LuMFR-7EVfu7jRth9-LJfkVHKaR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfXwNKiMsj6duCe
 ha126pLnvr/fI0SjWQSQJ/9J7SD7Sj/d9t9Xz3g4FXQpuMNUOQn5AU0GVKYkrfl5sGPAZ2hOu1m
 XVxCWOIfW3W66NyVNhE5jHTfviOVCmdKgZBuwtCfL1M4livhUYwxhRHn2Sx5XbxeqWxGm+4CzJP
 pr5w7WoDMHgI00P27/8on3xsMtOjkxDp2PhxIrHfkMrSHbNPALThA4/m0+bASUsSFeITXHGYfyH
 eoWRT5eexKDT4qsIkv77ox23tU2VMFiJ8Vl6mD0jG5cZaRu/Wk+UPARVgvAlXLYQTifWbKdoiKg
 5GrgjGr5ILL+WkZS2D7dcuFPWZi3v25XE21Lk4fcQ00GqjrwSqkjGg5GQDePulcKIfnU34wbjzI
 kQQjM9cV1NNLpOXDiCa9bpZKWZ0BzrZBlA0AWlLVkdlHC4O21b+I9ytZap8iMktXg/Fqc4/01Rt
 svUM3VS27Cq26CNRrIA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae0e03e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ugznIdUm-YL1OzzZZBQA:9
X-Proofpoint-GUID: H8l3_LuMFR-7EVfu7jRth9-LJfkVHKaR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270068

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
 arch/s390/kvm/s390/vsie.c | 137 ++++++++++++++------------------------
 1 file changed, 50 insertions(+), 87 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5926689fa226..cdaa84539645 100644
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
-		if (rc)
+		if (rc || !hpa)
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

