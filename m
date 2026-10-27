Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122369;
	b=vuSq3P/kHJgoKDUEvAqgTUT9ZOG/Ga7Sgb485/tIEfypsSFugvsise+vOPHIUg7ROHkf
	 y1/SOfJ8RYR5qbOJE3n1bTIV904bdmzVdxpC+ivCmEsT+4mF+ZpYLN9vgOdNyHyORAPnv
	 xXkKuPYG6v9oDPzWFGUsE85N/zsDxzO51ibaLqx4xoZydSBD7Ez6vmxQE77W+gz4fNsgP
	 PNkArFDiYcpKG5qpScGRXiGX8WoCgnhnTDj1QzkNtwO7V/gM/EaVEa72mGCNIwEbYe8S9
	 jdsevdvS98o6CLcBVgYY9Eu6BR5RMr+1+sAG6ihLo7OP+yHoGQhARSs4jPgNi8vp8Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122369;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4fMuLgmYvjX3xo8QP/iPEhZWBmTaa0bBMzpjgLt2cpE=;
	b=irjZd8OsXx4EXvNDH87RF+yyYQ4c/K3Dge7B277UaAIX270V6qvvnlWv/MReaKAiExb+
	 pBw4buSFJgHM2rZyhm6orB+y6uCf4H6UWP8g5k+HrPQuQFv2eLKiZAjcuxuJTf2MSgMeG
	 lRRCFP2GKGvTrh6MFY+EKEfITnLwsIlIhy3ueIY+38HHEy5luru0Tn5wutek3+vmJJQT0
	 TZnquH0NxqPkNxMPS/XL0EtaSfYtBKv3OXBQAWy5kBpYYYh9GyD2oAwGsaRvSN5helhPT
	 CQMSPcbVIK2WY8n1T/a3r30pPOcEGKqYiZb3Tg/uXe8Z+3mGHnSuMceYhBSNEOFRRcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VDvpIRaG;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E04606A32E;
	Tue, 27 Oct 2026 17:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E04606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VDvpIRaG
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RHES6J3129257;
	Tue, 27 Oct 2026 17:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4fMuLgmYvjX3xo8QP
	/iPEhZWBmTaa0bBMzpjgLt2cpE=; b=VDvpIRaGglWvYUVdCy4WrohcUWKx2aUoh
	g25NhSj5+whdb0QFUc7cutGB671cUSl+n5ymdx/F4PvhfGTOmt3u/v6jxtaAeGhi
	NcQjtw4c2jCZF/qGEvpVDj5J+XGVhQx3tf1uYp92UyxT596SrNb2tzVes5wAKgSc
	g+F7/61Ai0WYUErFx3Xad+4CT/oLQi4Volw1M5wM6ykXIPMmsqx/tC1xOwDZu15n
	oNbZviYFAI98//pYhVZy0O9MlsgsppEpaEujJtNKaxha3Aqu3JalHVAFYlhZieig
	+iXYwCHTG48IeajxIW8B+vQqxMm0Pvl7rbn8P7FI/FiOPjmnGZP4Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavge8n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69RH53iB226004;
	Tue, 27 Oct 2026 17:32:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn9ma7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 17:32:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69RHWdDE48955888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 17:32:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA70420043;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9834B2004D;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Oct 2026 17:32:39 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v3 1/4] KVM: s390: Fix UCONTROL inconsistencies
Date: Tue, 27 Oct 2026 18:32:36 +0100
Message-ID: <20261027173239.224849-2-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae0e03e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=J4Tbm5U8bJx2TlbRrzQA:9
X-Proofpoint-GUID: bL50nKylT-9Leo0T-p20i1NjFLWfWnGJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfX4Jmv4mV8L9dK
 YgZgaU0vVqsNFZ45joGp+Px+LDwGE75aIJzULbUVPtBkdCbbLXOGMwqJqpFGct/TcsKxB84zDmD
 xQCEVEIfv8MUDtvoh6EwrpZpOTOmwkY=
X-Proofpoint-ORIG-GUID: bL50nKylT-9Leo0T-p20i1NjFLWfWnGJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2OCBTYWx0ZWRfXx9R5ko1RFrxQ
 LRaeBftGfJvnvLsB0THBOofnb/fF6NUy0vqGOwB5ngifQg+RkENt+nxbJl2Dz3I0XIEiSBJknx0
 vJeAyv/f+C+nhBLSjFI8QoI/HBS57NxtjSOEf94mLFloCbRy8FPZLacAYrilVPfrePb+GBtalKF
 bOc9Jhn+LIL00j9QEwFaDyq27Z3tThPqXUPU0/ZdBO3rqmGqC2pGQsOGkClSV8FNAdQ/w1do9GK
 GBTGRtDMDStq2Z/i1g76qBKx5NYXg3FliI4d5M+PVhkChx3541RiOMHZ3XUwYPYcGoJdYGVTBs+
 SzE9AMcsZmjCuRQD1e4eSxtcQ3Kx4ftYQncgZ3sBFS9CgqlzpHGRNekLjhsI6uD8FiYZWTRzcLZ
 XKtytMndoBAn0FbwTTLck1SIZ4GubY8H+aOV4k1SqpJw3R4NoOyV1QmNDQlrCSQSfoBahB3RQjj
 ibQa6Yg9YibfSr78Arw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270068

For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
the tl field was set to 1. This collides with the present bit, which
means that other parts of gmap would mistake the entry for a present
one.

Refactor the code to use a different combination of flags to indicate a
mapped but unallocated segment.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
---
 arch/s390/kvm/gmap/dat.h  | 16 +++++++++++-
 arch/s390/kvm/gmap/gmap.c | 54 +++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 90389d47ba4e..4665c1112bb9 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -109,6 +109,8 @@ union pte {
 #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
 #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
 #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
+#define _UCAS_ENTRY_LENGTH	0
+#define _UCAS_ENTRY_OFFSET	3
 
 /* Soft dirty, needed as macro for atomic operations on ptes */
 #define _PAGE_SD 0x002
@@ -421,6 +423,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, int tt)
 	return res;
 }
 
+static inline union crste _crste_ucas(kvm_pfn_t pfn)
+{
+	union crste res = { .val = PFN_PHYS(pfn) };
+
+	res.h.i = 1;
+	res.h.tt = TABLE_TYPE_SEGMENT;
+	res.h.fc0.tl = _UCAS_ENTRY_LENGTH;
+	res.h.fc0.tf = _UCAS_ENTRY_OFFSET;
+	return res;
+}
+
 /**
  * _crste() - Useful constructor for union crste with FC=1
  * @pfn: the pfn this pte should point to.
@@ -985,7 +998,8 @@ static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce
 
 static inline bool crste_is_ucas(union crste crste)
 {
-	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
+	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
+	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
 }
 
 #endif /* ARCH_KVM_GMAP_DAT_H */
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index bf91e3d5013b..225fdae3d57c 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -777,16 +777,14 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 	if (rc)
 		return rc;
 	if (!ptep) {
-		newcrste = _crste_fc0(p_gfn, TABLE_TYPE_SEGMENT);
-		newcrste.h.i = 1;
-		newcrste.h.fc0.tl = 1;
+		newcrste = _crste_ucas(p_gfn);
 	} else {
 		pt = pte_table_start(ptep);
 		dat_set_ptval(pt, PTVAL_VMADDR, p_gfn >> (_SEGMENT_SHIFT - PAGE_SHIFT));
 		newcrste = _crste_fc0(virt_to_pfn(pt), TABLE_TYPE_SEGMENT);
 	}
-	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC, TABLE_TYPE_SEGMENT,
-			    &crstep, &ptep);
+	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_IGN_HOLES,
+			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
 	if (rc)
 		return rc;
 	do {
@@ -802,8 +800,9 @@ static int gmap_ucas_translate_simple(struct gmap *gmap, gpa_t *gaddr, union crs
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce, DAT_WALK_CONTINUE,
-			    TABLE_TYPE_SEGMENT, crstepp, &ptep);
+	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce,
+			    DAT_WALK_IGN_HOLES | DAT_WALK_ANY,
+			    TABLE_TYPE_PAGE_TABLE, crstepp, &ptep);
 	if (rc || (!ptep && !crste_is_ucas(**crstepp)))
 		return -EREMOTE;
 	if (!ptep)
@@ -840,26 +839,24 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
 		if (rc <= 0)
 			return rc;
 	}
-	do {
-		scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
-			rc = gmap_ucas_translate_simple(gmap, gaddr, &crstep);
-			if (rc <= 0)
-				return rc;
-			translated_address = (*gaddr & ~_SEGMENT_MASK) |
-					     (crstep->val & _SEGMENT_MASK);
-			rc = gmap_ucas_map_one(mc, gmap, gpa_to_gfn(translated_address), gfn, true);
-		}
-		if (!rc) {
-			*gaddr = translated_address;
-			return 0;
-		}
-		if (rc != -ENOMEM)
-			return -EREMOTE;
-		rc = kvm_s390_mmu_cache_topup(mc);
-		if (rc)
+	rc = kvm_s390_mmu_cache_topup(mc);
+	if (rc)
+		return rc;
+
+	scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
+		rc = gmap_ucas_translate_simple(gmap, gaddr, &crstep);
+		if (rc <= 0)
 			return rc;
-	} while (1);
-	return 0;
+		translated_address = (*gaddr & ~_SEGMENT_MASK) |
+				     (crstep->val & _SEGMENT_MASK);
+		rc = gmap_ucas_map_one(mc, gmap, gpa_to_gfn(translated_address), gfn, true);
+	}
+
+	if (!rc)
+		*gaddr = translated_address;
+	if (!rc || rc == -ENOMEM)
+		return rc;
+	return -EREMOTE;
 }
 
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
@@ -896,8 +893,9 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
-	if (rc)
+	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, DAT_WALK_IGN_HOLES,
+			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
+	if (rc || !is_pmd(*crstep))
 		return;
 	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY, c_gfn, gmap->asce))
 		;
-- 
2.56.0

