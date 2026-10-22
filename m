Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684543;
	b=xfVrqrISUsjdzYwptgwgYyz7wjbUhFIyQ6tjv938htCc3AK7pZY0EBmqrbBFQ/HGa6lb
	 aBLpr/uzv2v4TiHsrerXfukIxYy13N6zR/oNsIJ6gRv+RRdptAhdAkSeEol4G4r/5OBRP
	 IKQ93Ftf9IVsCHKo4jDnFRlntbr/4ZP9lzsK5D6bBdJvnsBswRRa7ONX1bkabuI192R4h
	 OJyIItAgM5eRRUPCLiZfwqvgj7/VHVW3vPx88vSVjip7iWGNBJVKokl66CXNwZ/qwL60u
	 XJD4K/Uk3SNfq7qyRoZ44bPf1J4iziLJ5xQWUvS8NE5xxmZSVQaoBwsm2sciRl7SUAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684543;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IJHDGcctcyGv1sQF7ecsRptozNfFq1dGOIWr/HMEAMU=;
	b=kk+nr66B4q6sArARRlgMbSWfChOQOKL2hsLILj03CC1Zln/128BpKsoq+z7k/qFjje3b
	 7KSQufJfD5ZFEyXnLwWDOHiw1cIJcu3nc3FIT3TgAQWeT7ZI1aiA/gJ3bEwKXq2ftfsdm
	 Tw45Tl1NV1cXNisrE+BYMNzHy6p35QUSaMkyfI73wXz42V2u8YCVWRWuW0X5TYchONZXS
	 NkOhbp2422+/N9ymxhR6A7QiK3e48vfd3S51Mx5jgj6ITzG+4nGWkqCl2U0lxlPJDL2cY
	 9aSSltfYLbUVDyZkJ3LN73gNf8adT9DGRp38YPUCLP/Es9Q/c3yH7YThb/c8cCjcaBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W6KNtDoo;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70B6606A332;
	Thu, 22 Oct 2026 15:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B70B6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W6KNtDoo
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEESxY3182514;
	Thu, 22 Oct 2026 15:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IJHDGcctcyGv1sQF7
	ecsRptozNfFq1dGOIWr/HMEAMU=; b=W6KNtDoollTzw3Moqc/OF7Ye16mR4xdRs
	b8y46ChpEyQEZe63DJot8rMqeebkVEz26Hp36BmWcJ74HGQOvuUEZvI5EA5f6Tby
	883EXkom0lY00hpAEp8g/+LNMwWLzUdew6fW2Vknbogj3SF4lXZlvPwVNSm2HxxP
	dlnhLfoGIWkIE0ckRTfkYTJNJ2c/mZBhjE+95522+ZONCN3zfsSWv+Vb/YcG0s15
	Ov+1X5i4wdt90ak9OaB4KC0BZfCWrBeZQp+/1wiRZ5GpJC8XWkbPTBDzy9bC+lmA
	2QoxsR2TdxjM/bLMrJEqIav1zAmCzhPlSnu6rOiYohTESSt9ae2eg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58fj92-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEuMcl699961;
	Thu, 22 Oct 2026 15:55:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn06ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 15:55:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MFtWLM43385244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 15:55:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90CAF20040;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 711CF2004E;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 15:55:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 07/10] KVM: s390: Fix UCONTROL inconsistencies
Date: Thu, 22 Oct 2026 17:55:28 +0200
Message-ID: <20261022155531.204593-8-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX3Uh6AoCxVnZ4
 8clwowTqQO63I5cDzJYRg2TeM3Ea3+QCwM2tYm1LUpRCVmM3W4fmxBMcpD3iSOltTmD0P8WY7tA
 YRZqZH90g8eEpl1BB1rB4bLt+ABVNn8=
X-Proofpoint-GUID: hIOOcivzjKsyxoSnbLbafNDry-5WYNfw
X-Proofpoint-ORIG-GUID: hIOOcivzjKsyxoSnbLbafNDry-5WYNfw
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ada31fb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=qdRAtj89VwdXhDZmnPMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2MiBTYWx0ZWRfX+9Xt+/i2SZaM
 609Ptr0jLu66t3y81EQRWbCDVlYY3j1Wp0r5mj2dPg3jo+f9sQocDA5zPfCFmOshOt8HrmO2xQM
 uOJvIHunJBG0ypd4sDdOiXCsOjLn3FdIPEJBgM5NuLl/AexOqHYG5NfOrk/9828ju+IEcJQAknv
 SC43GMa2J5Why1JtXg3qSJkafp/6/s+m/0SyTQeZW5oGKAzye18G0QOOxmMYE2yQJE1kJ80udNe
 1j8uH/25q32DPzZSGQVwkfp1pBWqUN0w0JAzRALnY+exkdmt8gKIM5BExjQUKnYbQU8MuROWY5w
 ZGIuoyoLAft70xL9yFW2mXpdZAvWcOwHaGPg4Fb+kJjT93jaBvGS/ibCgA8lKFhk3Wc4P4uIhPa
 pNSxQR/0JnQr1BAltq91uXfta/bIg62PryYygAKsW9EHU77AjXbLpdfeRirsx7GRD+LvuPLBAA9
 bRrK84Tp9gbYa2yAA5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220062

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
index 5dceb397fc1b..5b03a21c180d 100644
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

