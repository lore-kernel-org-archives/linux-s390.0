Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770944;
	b=THs3BeB81NCrUihtVnC2oakaIKdQm8zh0KWEMnlY1v6XDPv2YxlpVmHCN3O4LoQz8JUU
	 nQ7/4Aeek18FCdYBN8i2Z5wevAkgj/94Ix2A5HyaQwLKcx2P8BNTYKXWodyBeWWbS/XmI
	 yCkoSNukjmpuEn7i/qIFV5VXl3XPeDwU8aF0JxDAfwjLXrWtECuCKJVKwSGxyOrvgvLhf
	 YNk8+c3Xww4iE2jjUG6q+9Yo0pUp5nQnrusdCaIgGrmFoRqfpklDqSjVv+9gGUeS1b1l/
	 jIxeUbzShV7tRD21y/UnR1HzOTSFnecCGb5nUpLEthL3QINktShYQo0aJq+zlnRXt6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bnmp/bT9446rOHtQDGSZ20E2dlcWbaVmV3aA5kJZmrQ=;
	b=pMbiXVKDK1/a1GAG+5NHl9eSFwSn6+osesxfuFSYBQo9IzevqK4prOHRy6ZBnyeNOEqm
	 rvMe1l3xJH0E4bXj8k+pejRlQ54C5v3LHchw+QkGYh6FbNINnc/2gvGhKpvJRvoVQcqlm
	 1/WUyT7qKfgLfmERVj05HduFmrmEEqDYBA9RBJPpHmAhITgyXH6JmQ+hvdvVwJ7/jiLFQ
	 Q5vFXrYIBNXe6QccPrD9giNaoyLtZ6dpd7szHUtNFFsng3NV+0eKy7oLqVkJXbMOwfDxO
	 IkWrVe85kLAy6O7h0Ko1P3WPZepiZDswEXdZU4+eKfeZJ6Rgx/2+lJA+mKkO6VKlbGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gojAqZAt;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3A606A33D;
	Fri, 23 Oct 2026 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C3A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gojAqZAt
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NEEFqJ2036471;
	Fri, 23 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bnmp/bT9446rOHtQD
	GSZ20E2dlcWbaVmV3aA5kJZmrQ=; b=gojAqZAtVD7GsyGHLtU/vdpuiPiIXl5j0
	mNyEfWdtYKyxu/6OVvPsYK8P5EAs1VDLW/mmUVip4cW3mTTr2DXENBedeM0EO/pn
	ffMUHhfbcLTY9oGbQlMc2ItYSKyOYXSqKllQlKcw0wgooyJjh79OMOEOZFUCbzWX
	3suUjtbYSS4/2HZbTu7Dj0yLImuenUu4iO2U/ZZbmApFJAyq3zY3p5VhLoAqSOM4
	VZSEnD4dQkRNWUrJx8QlBcpaqoSrYUgOblsrwBCem0PslYqEIglDc3GPZdSAW1rJ
	yFwuL2mNZmSGffNUvCsgsOcOnuikrmcKIDwy6LAxqQUzT7U6F/iTQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58nehs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE64II1018552;
	Fri, 23 Oct 2026 15:55:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hg5exsa2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69NFtXkN48955824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 15:55:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AEF020040;
	Fri, 23 Oct 2026 15:55:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED1392004D;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 07/10] KVM: s390: Fix UCONTROL inconsistencies
Date: Fri, 23 Oct 2026 17:55:28 +0200
Message-ID: <20261023155531.206113-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023155531.206113-1-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX4Tw44L+0VJQY
 kqh9iNWvuOYoboODBlf7A2BCmol5Yn7erEpXsyMeKTFMF/0V41aTywL32TrI6CuyleXT2YYQVAY
 p+ifUp/9oAHuCyYncilzIjTvP+DRWlg=
X-Proofpoint-GUID: 2PWVjI0Yzi6dwatDiJQeM6imky8zpxED
X-Proofpoint-ORIG-GUID: 2PWVjI0Yzi6dwatDiJQeM6imky8zpxED
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb837b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qdRAtj89VwdXhDZmnPMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MSBTYWx0ZWRfX1xp8cE75Emw3
 2wpoFO8xP5Nhbhlw6nw5yj19ZI7EaHhpAFZ/E0Wl2wtYzRUE6QubbmUKuqMtEU1kiEJkcnDgmVe
 vKhmz40O5hXi1iF0vt6K+lvQNlFA1skXAwl4yOwhewvobTXagCx7jJddJsKh6DbfgVQF0lmjRgB
 Yv6Of5DImryEu3pyttLqr36a4twPhMdMTRiOHIZTfLU72cBypvU/lRnDUDGWMKRsxFAE2bV5xUG
 EPN5zTsqW9l7tQWdnGGT8U2nLJ7Np8LW34uib+c6HMWedbV9AS1A1JJyXK1b0efIEqPg38gIdL7
 CmZB+/i74SuUfH1srngfcFZ2VJcpjUEGlBGlFJyRuaQmo8Pq0shUqgRlB6GrkVOQu4OxbYlGdmT
 IkAR5n9o4piplBKSJj5BeBGyLgpDoskrUj4u0oG+Yla4Upa/qfTMhrsYFiQtKoZWm39EDrlrr7z
 jA6Jpcu/tnczn0TVsMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230061

For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
the tl field was set to 1. This collides with the present bit, which
means that other parts of gmap would mistake the entry for a present
one.

Refactor the code to use a different combination of flags to indicate a
mapped but unallocated segment.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.h  | 16 +++++++++++-
 arch/s390/kvm/gmap/gmap.c | 54 +++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 319a8670fb10..3493f033e204 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -105,6 +105,8 @@ union pte {
 #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
 #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
 #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
+#define _UCAS_ENTRY_LENGTH	0
+#define _UCAS_ENTRY_OFFSET	3
 
 #define CRDTE_NODAT		IPTE_NODAT
 #define CRDTE_GUEST_ASCE	IPTE_GUEST_ASCE
@@ -429,6 +431,17 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, int tt)
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
@@ -1027,7 +1040,8 @@ static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, struct dat_tabl
 
 static inline bool crste_is_ucas(union crste crste)
 {
-	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
+	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
+	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
 }
 
 static inline void dat_set_storage_key_from_pgste(union pte pte, union pgste pgste)
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index c23da6fad92a..c10681f882c2 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -781,16 +781,14 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
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
-	rc = dat_entry_walk(mc, c_gfn, gmap->datt, DAT_WALK_ALLOC, TABLE_TYPE_SEGMENT,
-			    &crstep, &ptep);
+	rc = dat_entry_walk(mc, c_gfn, gmap->datt, DAT_WALK_ALLOC | DAT_WALK_IGN_HOLES,
+			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
 	if (rc)
 		return rc;
 	do {
@@ -806,8 +804,9 @@ static int gmap_ucas_translate_simple(struct gmap *gmap, gpa_t *gaddr, union crs
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->datt, DAT_WALK_CONTINUE,
-			    TABLE_TYPE_SEGMENT, crstepp, &ptep);
+	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->datt,
+			    DAT_WALK_IGN_HOLES | DAT_WALK_ANY,
+			    TABLE_TYPE_PAGE_TABLE, crstepp, &ptep);
 	if (rc || (!ptep && !crste_is_ucas(**crstepp)))
 		return -EREMOTE;
 	if (!ptep)
@@ -844,26 +843,24 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
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
@@ -900,8 +897,9 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
 	union pte *ptep;
 	int rc;
 
-	rc = dat_entry_walk(NULL, c_gfn, gmap->datt, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
-	if (rc)
+	rc = dat_entry_walk(NULL, c_gfn, gmap->datt, DAT_WALK_IGN_HOLES,
+			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
+	if (rc || !is_pmd(*crstep))
 		return;
 	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY,
 				       c_gfn, gmap->datt.asce))
-- 
2.56.0

