Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6484D957E;
	Thu, 17 Sep 2026 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646044; cv=none; b=IPxlTdzmTDtBDt57/EWMRGaS26v3ol5neBeFDkiwWiuZ+eL1Ucnf6MwpKQsXttgmCvbkpitPkfz8e7YekqRRY+3t0A929Fnpmg6APjW+Ws2EZa0OtV9D+hc4238ZV7dnPxyuUbe0KInVM32Vvh6Se/zFVB3UZA2XlvTi/m2dIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646044; c=relaxed/simple;
	bh=jvaLVEbnFCdM/+XrIG6EfmKoeNrEdotsynpBFgLSflw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qO9UX/PHyDnJ0UI3OqSNg7BLcluv9wqHjip7CHpPG7jaxX5V1TOB39FgBBMTWTRlZq0CnY2aYl65qCCK+Y6LsnFUmfSYWCSNR8earJjGX+dO6CwWPckzTPgtmYp3dHYG0vvtCyPTIyCWaDOmJYnWt7xW+BnNAZJLxtgOE50mBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YUw+lKOe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YUw+lKOe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HA1UTc322340;
	Thu, 17 Sep 2026 11:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=V9ERVpr4ybPvUdFY/gMcMooqa+vD4ZbFk/cBj5IgD
	w4=; b=YUw+lKOeEBkeEyWzEjaUwnCe1skx5PLSvUCiPgcFElcEkaW5cTHV3dzhl
	Q5TeeH8U133qOTWWwvXXTFaKFS7ggQ/aUaraNWlK68dcdiu7JMS7ZVNvdbXele9u
	nw1Ve3Udja2RTnheWpeLqVHqBBHiTiX+Na0pA4fa0SwbQDw/mdqlki6tDPt0ZPYo
	A9XpgmLCnYuo6hFbZz6rSjIt3NvOZ2qMeNJPGPC8Hkvx3Uxjz0J5KWheW7byg+Ov
	F0rNmNc5ugKp8t9HojFDY/g8/2y1i5VI712B8BHr/i/dv/ewzvRJLwZQb/STJVTh
	5j8ISOmK3W823Nn/WCifYmwUzHl3A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqj443-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 11:53:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9aQBd2917878;
	Thu, 17 Sep 2026 11:53:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa23tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 11:53:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HBreGJ36569418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 11:53:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E0532004B;
	Thu, 17 Sep 2026 11:53:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29B1220043;
	Thu, 17 Sep 2026 11:53:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 11:53:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/1] KVM: s390: Fix UCONTROL inconsistencies
Date: Thu, 17 Sep 2026 13:53:40 +0200
Message-ID: <20260917115340.126628-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE2MCBTYWx0ZWRfX9/h2sGx1Zc23
 LH1WeP3vsLjFxLejr0y5MQFF9wX5H4q1vzYtSU3n8W8Ad3We5ceE2CDLyP9gqpPffPNJ6Qrnl+o
 guK49yjIdOmXvFodwfKkf+1S2GDtnJGpj+m30IdeiGy56+vdl0M1wol56CWk14Yqda3occWWJtu
 0y/bxMcaoN7suftVexyBT2FZqoSHjJHN55PP1EcQ1bpUH0RZdgg3NvhsXHmc4KNx6pCsexGOgGb
 26GlAoQCgye9XkOKtWQi+cFlqPKqmeAcw/9rR/eUoefe+j9SzvalFS1b8dEWDCWsj5wNs0xGdli
 kVoQYKaWpgQi0oHnsNJAO3MG4MTZiIhrakRWcjF+JirEKGHsuvuRLuyKhGNuWMDTBf4YKiTnAxn
 O39zBW9KAwOO0poqWTCPlpKH9F3P0L6GojJg8uOC26FoJfGfydYbX6MqQiQ9CCCPwy/uFh1ZVRB
 fS439W0nqFxZuFGANfw==
X-Proofpoint-GUID: JpaoghcP1i0kzQ8kq5d5B8KBSNaQ5fGw
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aabd4cb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=UYoTy7AoXebUC5eqFE8A:9
X-Proofpoint-ORIG-GUID: JpaoghcP1i0kzQ8kq5d5B8KBSNaQ5fGw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE2MCBTYWx0ZWRfX8r6YoMyasJuf
 saMChlnQlFgSf+R4swL+9vR1eBjd78UOscgXNPmBNeF6h4xaAiE+fA1oEUlIqaXKpe9s1PMPNTs
 DWzJdBZxLBp67AkSEDlD0dUydYQQkMs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170160

For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
the tl field was set to 1. This collides with the present bit, which
means that other parts of gmap would mistake the entry for a present
one.

Refactor the code to use a different combination of flags to indicate a
mapped but unallocated segment.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap/dat.h  | 16 +++++++++++++++-
 arch/s390/kvm/gmap/gmap.c | 40 ++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 23 deletions(-)

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
index 3f3fa864cc36..554015e0dad0 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -773,9 +773,7 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
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
@@ -836,26 +834,24 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
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
-- 
2.55.0

