Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684543;
	b=5cx0CNZasEhj7GIoFaF1tqm4qxt/CVau2pdmrsO2/ovHrOb2eyxbeYBf+VBC/c8HBgUG
	 Ik5R2rYUGb/LWaOrdi108RruptB1tzIcINtC9VqoNYRVOT2s6ZGpnr/MurG2IGZ8aSkWZ
	 LlSEOx30esYwc+WtBZ4g3w006nOJWgFJM+puFq6V9XTY2WFygYSbrtRGPZfzSq9Gkg0Ho
	 0/GRGOD+SnO0BySy/L0NwbS7wSngnjPehRTlzQJhWBW9Y+uQiANTNFB3sV8GySCQKuLHY
	 zQtQJlKCQJ0LAgMFiqHAbWLh7nw+d8u4wBqLzk+UTPKyGK4W8pOE5dLf6X42sblhSWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yFbcG/qW8i2wmsjhFrqXGBwJCB1SBiR0RGBtD6EriSA=;
	b=hKMZ69cgHfh2VyKOs5+JU74nFxBSD4o7hmNdN4DHnyiBYJf630QfLxWLrh35I4Iu5SQ7
	 5xMhHulzwyB/zbFBNnaKCkMjIr6rReEj7huwh5rZPEuQ2w8yE5ajAhSy6Ehdpx60ARl0u
	 CTFAs9gtO2a1x2Yo8noY+c8cWiylXOeZ294Q5OACfXeCK96K87mdCHyPOhOh8gHSvnaQ8
	 sHu34vdV44mQ5YUhOEFlPwIE+NDiMgNuKp6YIsjdj+hOMxqR+zKVi/SbQO6RkTmT43foj
	 rxcDG8h7Jt3FBR+kTyzLpaiWIMkW5XRKcQfgUlaL9XsR2Cb7mkW1votGZ2ngmiO2wvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RUhLjkQw;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623B606A336;
	Thu, 22 Oct 2026 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C623B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RUhLjkQw
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEEuPS058436;
	Thu, 22 Oct 2026 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yFbcG/qW8i2wmsjhF
	rqXGBwJCB1SBiR0RGBtD6EriSA=; b=RUhLjkQwGiqPTudfPPYCV+6/mrtqrWu1f
	xy8pCVmgHg8cHpsnrBRm5KjlTjDwLT58IfKRkY0rxrn4Lo/cga5ZpNx/ksB71PQc
	QrTpfFH03k473UUPDA+V1PrdEU2HaTfCO6SGPO2/C5uR8ksc/1qmKQaeDpXDY0AI
	UvEGDZoSXFmPX8h25QbVE9Tm+dRV8oZnEojFXzjGBSTAB3M1CW/qe0wB5X3NBRcF
	rKEUzuWws5ExnisI+TRyBUXE7xLlDQ2FYX9GFQCq+LFesr0+kTgeNaiw/Bjty3dQ
	Y3S3S2+5LqT/DzL20Gvi1VvVjZ2swBTFJPaaoKPrGWtfnUwl6B3VA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5aynps-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEJvZY566299;
	Thu, 22 Oct 2026 15:55:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg20gdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtXu950004384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4B5020040;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC2EA2004D;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 09/10] KVM: s390: vsie: Fix pinning using the wrong flag
Date: Thu, 22 Oct 2026 17:55:30 +0200
Message-ID: <20261022155531.204593-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022155531.204593-1-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ada31fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ugznIdUm-YL1OzzZZBQA:9
X-Proofpoint-ORIG-GUID: vLmM0z4HiD5s6H500YurnGCj1qmC3BLH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX/SkJqLmp7Fki
 gnCsZVMTARCxVOaEtenMbsP2DB5HNZiLKqnGPazcZWmyer5z6sXCgy7P8oGsbWo4ld2vW00V1pC
 zqX+599SVFDvBIFwry4fag6SP3/GuX8JAelwJDCN+ZD01RFPZCD8aEn/5qaVN1mRlzrKHmRcvPo
 SecNZDSe8TPlvBqOD3k/JrE25JZc2C92nced/I1dv1o0u5GE1Mr1sWNu0nLQGdbEll8icQ8dC8F
 n4DwJFclEBIzbJLcKz7LNdpQ6TP+ZDMfw0ysnHbFvdaMERUZCc6NkfjBYa61lvDYkZVNPeRb4Mt
 2lH9cQjKI89bS2L7Hv1cE4Z8YLLtm9onfSF7eZpB/WodvL4lSp3GwyJZ2OOGEyirNQJMJMQbjVI
 8WWkZF7Pz4VIlv84OZohezUipGqXelNEZ8NBfsCDtzgz+v0nADhzOe+zzUUBHOHDocYc4VeaAL8
 ibwXnPEjTWjn1D6M/zQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfXy31wwOW7smTd
 Wifbv4pLu6OdUDX5XZeLot8rIPZFtb3WRxnMBCODd2Ip5yz0+3v9sztTk//KzJaEEpu55MHu2e3
 xPO9eMRb93JJm2ZEQSTVLXRAaBcdLFc=
X-Proofpoint-GUID: vLmM0z4HiD5s6H500YurnGCj1qmC3BLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

When pinning guest memory using pin_blocks(), gfn_to_page() was used,
which under the hood uses FOLL_GET, which is the wrong type of flag for
memory that is accessed directly by hardware.

Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
correct thing to do.

While technically a bugfix, the previous behaviour can only lead to
guest corruption in extremely convoluted test scenarios that cannot
happen in real/production systems.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 132 ++++++++++++++------------------------
 1 file changed, 48 insertions(+), 84 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index 3b5c322bf8b4..d2f788bfc956 100644
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
@@ -884,10 +853,7 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 		      gpa_t gpa)
 {
-	hpa_t hpa = virt_to_phys(vsie_page->scb_o);
-
-	if (hpa)
-		unpin_guest_page(vcpu->kvm, gpa, hpa);
+	kvm_vcpu_unmap(vcpu, &vsie_page->scb_map);
 	vsie_page->scb_o = NULL;
 }
 
@@ -901,12 +867,10 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
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
-- 
2.56.0

