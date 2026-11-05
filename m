Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893037;
	b=MLBzjfIxPM0yflnPXYh1Ty1AdquUbW9S2nisQ1rG78Ahs1HUpvgLpJKo1m+s68Zxdsiy
	 jiCFyooTt9KD0y+p0+AWK9qCs+JtkfPTZLpR1qr8bnBzdpjtNCVm0lgTOEmNSBU8UyI/9
	 w1JTaiJJLSofYCDT2vla1KyCDdwjuxVaDFJLAgp0z2A5re/C2hXvZPCMxr5fu3oomr0ef
	 ojPHcGVPG1m0RDwdGN9nDIjXK3negWQVvJkOlGi9JtMnVA4h2Z3VsUoJ8o5QguBxUadoi
	 jjI8NMWnS6NdEmjBAKhToOsHByyxUFd5jVhRAInofsKXu1FvUrxYIvWwXpAi42erSww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Iw76mMMB93dHCVelA5y10fkWJaHjfd/A0VdbGgQy89A=;
	b=xBw1JJpgAuhGHItkcYLLnOhzXHCJSYD/BanGbf6CuDBM/RkFv8aTrh05ZoNoeLBi0EpV
	 c/l1n5fBPGYcLIYyFDIFd8tikRExi1H2G0al/4pGll+jl2Y3T0+WMm9AUvuryB43rU54r
	 kfMOYLM3tPUwwNp5Y8l5W6hLSPKFign+oLnmUtXisLo3d1r4aQhHA+85PZhjUTcBlluLK
	 gayb2ubR0L3o8EkyZZVwl5jVodLU/BlTXuGUS3A8fINj7qbjejuPha6LPPrpq1+w280M6
	 cm9E5JFjIoJ6jYg/5CWXaCK+6aXzL6/koL+BrrHXNE9jSuwJJFpMXLgXaqqEXy51cOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iz71zmbq;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2D606D804;
	Thu,  5 Nov 2026 15:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F2D606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iz71zmbq
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5Ei8OF3787406;
	Thu, 5 Nov 2026 15:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Iw76mMMB93dHCVelA
	5y10fkWJaHjfd/A0VdbGgQy89A=; b=iz71zmbqGnHVZa1lAIO9eeh3UvZn1mIwe
	q+dl7Qq5fsbgPt0skLFQt0T7AXaf1S5ySU0xs8hRQFbqJ4DVWw72W2Ctzt5HW0NY
	IHgT6NFvHUtwoBaKKrPqGu0Q3kTTzgsL3QkvcfwV76zHLYUuVx/8ZhnxywYc0bV+
	zYR823KPkZzRUv0B+qfnnSAvZpp61oxdx4gKHVqVOEomt28EHLzud6wPenkLRjkV
	pDSg98TqZT43zgknx5FpKG1rrR8l47JnJ8vBmeSbyp3w2vjFo3jH3SUz26A8x1bk
	aZ11rPsac0ODeCZGhF2+pG0Z9029xcSDY3REgmNeBcwBFlDOFXJqg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn82736ur-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ1Xr1685877;
	Thu, 5 Nov 2026 15:37:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrejdkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 15:37:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Fb6T917039736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 15:37:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D220020040;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2AC2004D;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 15:37:06 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v6 5/5] KVM: s390: vsie: Fix pinning using the wrong flag
Date: Thu,  5 Nov 2026 16:37:05 +0100
Message-ID: <20261105153705.208516-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105153705.208516-1-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 6pHgacSmtDvv7M8V7D2vrzDQJn1MAbrs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfXxcOcl4wadRXw
 mEO/7W8gC5mLo7XXe97KmFNnhffz7b8WIUtlNr6jkcjmUraZnTDLDb6zXpLuWEiiX+PBq+aBM1h
 WS7Ua60K5AgXrMtGjdfrGummkW4hxhbm4scov1b1DLcq62zl3bNDmkQ4M9hzwrhZ2qGSGcnA7/3
 9ZqO4FT0MBV30aDbwA3qkTFMP1cMWoPHndhRedPSeq9+ii/MNvW2vkIHlLf2W3ABPsAhpaQ5BXX
 Tv4qFJXeOcmEYAGDr2+Qrzz4yhwMIQR7m93pYj2Krm5Q2D3d7pXbVw4b1tMDwsk21MmJACcRWwN
 KE0PNsktlaAMBeERpOzgdiHEMaTrE2su8n0sWz6Ww0o3TPJHW0lACv92B+o1VDyKeVtCLHgIvRA
 Uo5znnumcZNOYQJ0wA/DoBMcWi6ZxLSj9e5z7p36UBlb7cfoTEeoBfm7C9I8gXYpmARm/BXAjM9
 vH8s/Zx0ilOmQgfE6MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX1HK362puBd9t
 acIPfCs1s/DTL8u4GKnWE6I1nc29zjynaO9Mw5Lm4bE2b8XbqgGmRrG/ouam9OXvgvRbpj26CKj
 qpigoxDfM8k/uMMmLLHc9/WnoUw7boo=
X-Proofpoint-GUID: 6pHgacSmtDvv7M8V7D2vrzDQJn1MAbrs
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aeca2a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ugznIdUm-YL1OzzZZBQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050060

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
 arch/s390/kvm/s390/vsie.c | 133 ++++++++++++++------------------------
 1 file changed, 47 insertions(+), 86 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 5926689fa226..3ce133f20fa2 100644
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
@@ -681,72 +682,43 @@ static int map_prefix(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struct
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
-{
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
+static hpa_t pin_guest_page(struct kvm_vcpu *vcpu, gpa_t gpa, struct kvm_host_map *map)
 {
-	kvm_release_page_dirty(pfn_to_page(phys_to_pfn(hpa)));
-	/* mark the page always as dirty for migration */
-	mark_page_dirty(kvm, gpa_to_gfn(gpa));
+	if (kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map))
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
@@ -783,13 +755,12 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -801,12 +772,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
 
@@ -820,12 +790,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
 
@@ -836,13 +805,12 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -866,12 +834,11 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
@@ -881,13 +848,9 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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
 
@@ -901,12 +864,10 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
@@ -1601,7 +1562,7 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
 out_unpin_scb:
-	unpin_scb(vcpu, vsie_page, scb_addr);
+	unpin_scb(vcpu, vsie_page);
 out_put:
 	put_vsie_page(vsie_page);
 
-- 
2.56.0

