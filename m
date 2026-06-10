Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B6D3446B9;
	Wed, 10 Jun 2026 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110380; cv=none; b=KszlCvie/Hud0aigwCL5f8wXrAR8hvs4fkakmEo+UsOCn7uhYKrQebxi3nijBfirMk1sz/PF+jzjw7zTNkXZiBUqBCZRiH675sgeviN3xD2DPDkmDCGkjk+Ib0vpOg5uZdAoc55CeBMb4rpcPo+rZwU89keFd21OcI3XghjbCPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110380; c=relaxed/simple;
	bh=buMTHdNLk6Fs9W60Sq+uUQBmcES+KtPCU7xjQISvk9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVtWGZjH+e2jcZhLBsOzVARct+1mpFDzoQnIRfmJU9LwylkkuUuxE5W9hkukaBFsiq0lC+AbRnUI9dfrS48SjeuySh5pJHJexr57PH9VnotBKr2nbtbP2Az+kE6Iafx9wmp4u/WsbLla769RKTmZuiH1gb5r2EdLfPYOePQcq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BOHBn7DZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BOHBn7DZ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7rBxZ2567984;
	Wed, 10 Jun 2026 16:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=U9UWtiDkvcF7UXUH9
	Xv2hR5ZU+iy/jT5Zi6TuaynOSc=; b=BOHBn7DZuUSenHN/K4+qau8jXOCN8xCfn
	S1ZVUqUNdqJM0bI0sq3rwLv6OLMIxLHLgfbh7vOgkDXd034LMKN9w8q3/qu0Hddo
	4Y0UWveVEj2G2491o7VHH4dOwVUZgvTurTg9lsagRq/fUloY46jkQUdzLDpwpBmb
	0x8U+Kp6QjGnQZVK0Y/xx0Pk5UTQa++iFqak3/QqxzjwIhfl5uAWI05PkcalNIbD
	QU2tDhK6osIly/g4ioLL0MpUVa0weh8tuBJkJeN2NYojP2GCD2/PNWRLgFcR7ISw
	UzQiw76029gG+dJSkA/v7+Bi15/PpRVY5SPZnyHwlhrfjzCRHAKtA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95j4n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGntRI013586;
	Wed, 10 Jun 2026 16:52:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjygqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGqmve27263314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:52:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C79220040;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 772852004E;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:52:48 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 5/5] KVM: s390: vsie: Use mmu cache to allocate rmap
Date: Wed, 10 Jun 2026 18:52:47 +0200
Message-ID: <20260610165247.238366-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165247.238366-1-imbrenda@linux.ibm.com>
References: <20260610165247.238366-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a299668 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xGrK5rwyTb2P39Z5L3IA:9
X-Proofpoint-ORIG-GUID: QIW_XConxmgrOK7QHMb6ikBym3xrSwGL
X-Proofpoint-GUID: QIW_XConxmgrOK7QHMb6ikBym3xrSwGL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfXw1TlhqB+BuBc
 LMk/OgC6SSkyW8S5FS9KLXByRaUvIHkvRcrGRkODegihTjdQ7u9h4ln8/+05PYy7OanM743HA3V
 kOxNFERjPoelVBcFzBcVq33J380C1wCtmUZ/UYxvETqXJAc/hq6lIvJ4u1BlUCYgzBbrH22O1Cx
 07e1UfV6F+zG6NJDUAQWXgHwC1DwsBlCpZ39peene74em+4KcYo6LWUNcW986cJyTs2CGV2XLLt
 wmYNaljCrG0DcG97xZJQc95EoOCMgGEgOgzf5kPk/zoikbMmLFRid9QQBSnL5xebBuFyHTVJcVk
 Ep4x+oFJVqlH6n1MYKL/yCVCyzjVr19SIEYAcNxpH95/j0sU/fNT86bkLP00QWw8VMeXYc3Lhc7
 6y699Jp7gE9OWae0SsEcWJDHv/cgQe3qGJj68Y3IrpIWH7r+oE7Cszd3x3CDUmS07XTNxraHZpa
 crOPqCuSys5fzvhFlpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156

Use kvm_s390_mmu_cache_alloc_rmap() to allocate the rmap in
gmap_insert_rmap(), instead of a normal kzalloc_obj() with GFP_ATOMIC.

This guarantees forward progress.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/gaccess.c | 16 ++++++++--------
 arch/s390/kvm/gmap.c    |  7 ++++---
 arch/s390/kvm/gmap.h    |  3 ++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c072b6872bf8..cf4b2fdc2454 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1419,8 +1419,8 @@ static int walk_guest_tables(struct gmap *sg, unsigned long saddr, struct pgtwal
 	return kvm_s390_get_guest_page(kvm, entries + LEVEL_MEM, table.pte.pfra, wr);
 }
 
-static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union pte *ptep,
-			  struct guest_fault *f, bool p)
+static int _do_shadow_pte(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_t raddr,
+			  union pte *ptep_h, union pte *ptep, struct guest_fault *f, bool p)
 {
 	union pgste pgste;
 	union pte newpte;
@@ -1430,7 +1430,7 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	lockdep_assert_held(&sg->parent->children_lock);
 
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
-		rc = gmap_insert_rmap(sg, f->gfn, gpa_to_gfn(raddr), TABLE_TYPE_PAGE_TABLE);
+		rc = gmap_insert_rmap(mc, sg, f->gfn, gpa_to_gfn(raddr), TABLE_TYPE_PAGE_TABLE);
 	if (rc)
 		return rc;
 
@@ -1462,8 +1462,8 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	return 0;
 }
 
-static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, union crste *table,
-			    struct guest_fault *f, bool p)
+static int _do_shadow_crste(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gpa_t raddr,
+			    union crste *host, union crste *table, struct guest_fault *f, bool p)
 {
 	union crste newcrste, oldcrste;
 	unsigned long mask;
@@ -1476,7 +1476,7 @@ static int _do_shadow_crste(struct gmap *sg, gpa_t raddr, union crste *host, uni
 	mask = is_pmd(*table) ? _SEGMENT_FR_MASK : _REGION3_FR_MASK;
 	r_gfn = gpa_to_gfn(raddr) & mask;
 	scoped_guard(spinlock, &sg->host_to_rmap_lock)
-		rc = gmap_insert_rmap(sg, f->gfn & mask, r_gfn, host->h.tt);
+		rc = gmap_insert_rmap(mc, sg, f->gfn & mask, r_gfn, host->h.tt);
 	if (rc)
 		return rc;
 
@@ -1578,8 +1578,8 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
 	if (KVM_BUG_ON(l > TABLE_TYPE_REGION3, sg->kvm))
 		return -EFAULT;
 	if (l == TABLE_TYPE_PAGE_TABLE)
-		return _do_shadow_pte(sg, saddr, ptep_h, ptep, entries + LEVEL_MEM, w->p);
-	return _do_shadow_crste(sg, saddr, host, table, entries + LEVEL_MEM, w->p);
+		return _do_shadow_pte(mc, sg, saddr, ptep_h, ptep, entries + LEVEL_MEM, w->p);
+	return _do_shadow_crste(mc, sg, saddr, host, table, entries + LEVEL_MEM, w->p);
 }
 
 static inline int ___gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 52d55ddea8d4..1d289f8fa3b2 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1000,7 +1000,8 @@ int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interr
 	return 0;
 }
 
-int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level)
+int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn,
+		     gfn_t r_gfn, int level)
 {
 	struct vsie_rmap *rmap __free(kvfree) = NULL;
 	struct vsie_rmap *temp;
@@ -1010,7 +1011,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level)
 	KVM_BUG_ON(!is_shadow(sg), sg->kvm);
 	lockdep_assert_held(&sg->host_to_rmap_lock);
 
-	rmap = kzalloc_obj(*rmap, GFP_ATOMIC);
+	rmap = kvm_s390_mmu_cache_alloc_rmap(mc);
 	if (!rmap)
 		return -ENOMEM;
 
@@ -1057,7 +1058,7 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	if (level <= TABLE_TYPE_REGION1) {
 		bitmask = -1UL << (8 + 11 * level);
 		scoped_guard(spinlock, &sg->host_to_rmap_lock)
-			rc = gmap_insert_rmap(sg, p_gfn, r_gfn & bitmask, level);
+			rc = gmap_insert_rmap(mc, sg, p_gfn, r_gfn & bitmask, level);
 	}
 	if (rc)
 		return rc;
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 20881e3ce9d8..1c040472f56d 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -100,7 +100,8 @@ int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long cou
 void gmap_ucas_unmap(struct gmap *gmap, gfn_t c_gfn, unsigned long count);
 int gmap_enable_skeys(struct gmap *gmap);
 int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interruptible);
-int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level);
+int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn,
+		     gfn_t r_gfn, int level);
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr);
 void gmap_set_cmma_all_dirty(struct gmap *gmap);
-- 
2.54.0

