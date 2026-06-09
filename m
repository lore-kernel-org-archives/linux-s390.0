Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D003E009B;
	Tue,  9 Jun 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021823; cv=none; b=fNTBYIsR5ePY1dDT8AkvsrJbQZuZtZXSwrGLhxQ/xEyy4XXg6UzyxUzRzmUiZxxS17rBzxHF4bkz/BWAyLxFdVFVjhjOAouRmcJh+QVraZHpEU3+TQxB2pcCuAT+6mGI8tekyYPBF+4/yN61aS7SWiQpl3YPPUTwjenp9ccHCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021823; c=relaxed/simple;
	bh=/m0kCb4H5ZRvx3+KwFCzamoiQDgIj8JHzOIXcUbu2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQmQPlG0I4s0iirMSBTq2GsRxn/LX/a6/6FGtJVsvEfSBgw+gxrqKVzOOpkM06rMPKTSbRA4rmGY2Z7tXSC6J6V/dKQRFq1LKuFNTXrElOIDnyqfCTejucZQ/VbwYXdqGiPyzBR9Lp2tBMkI9b4/tx942x0Pk54KSa327p8hs90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rIGJTrkk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rIGJTrkk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CwPOr1475403;
	Tue, 9 Jun 2026 16:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+kx6+VFAffAOX221N
	9Sn4YC8rqVcjxUqvfEquMZYTeQ=; b=rIGJTrkkbbkwZUXuF7HgOkswCZDOeNetA
	u5nQQBGuxqcDofe9ih1zYMZmBTVlBN+tuhCk1v33yAzi3bBBl7E1LuJsJ+LdYMAx
	COkzM85zx6vuK4KuuoyaRmWLC2MYaAqDiuEIoJXgZUl9meiszK1ZW5hngfBwxq81
	ZpTQsDKDOf6Euvn8CT1sqUSJD+WbXq+xgAejQaHEf/6aK/7nsEE5jMXMppY94W2r
	U/vZAtzW5W+1m4Wf2plnsdHXV/ZKadENGcSXZAl60qH0bpb/EVsziwYSLjdaxYar
	8j69E54qR1ZNDEVf37Kl/XiP4r/S0d+ob0LY+ztegkd+FX1tXGXag==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qn3kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:17:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659G4f3e017255;
	Tue, 9 Jun 2026 16:16:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych2q9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 16:16:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659GGrbB7405902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 16:16:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00BE420040;
	Tue,  9 Jun 2026 16:16:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC4C02004D;
	Tue,  9 Jun 2026 16:16:51 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.28.58])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 16:16:51 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v1 3/3] KVM: s390: vsie: Use mmu cache to allocate rmap
Date: Tue,  9 Jun 2026 18:16:46 +0200
Message-ID: <20260609161646.695361-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609161646.695361-1-imbrenda@linux.ibm.com>
References: <20260609161646.695361-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a283c7c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xGrK5rwyTb2P39Z5L3IA:9
X-Proofpoint-GUID: Z7xQ8B31mSj0pXS6jdgIhnw6nQXaS9ln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1MyBTYWx0ZWRfX1MoDzRxhsCzI
 YP6kzDhImYTbkEMjGS2CTys4wsLVu5QxDJ9b7F5qY/WPGic277gWTJrfTHE2b88zo3jQvz4SOgf
 GwpfJTIDHC12TJlAKhrBkhOEqAFbjQ+MUDtoMaI4CeO4j8JbY3S3vHNpSVpeZSJQHfu79SJBC/q
 gcKzUp6Sz+ruYS35P/7SEzHgQDVB2rcJAmdMrJa4/H/coo//0yecV3zRjoNHAO4boTgpT9SmKHP
 2ZFvQi2/cl8/tH4lut7tVn8UgtvKI+13bIwGMWCA+RGq83R1ht9KzgDzg3syCDiNDeubzK+/hf3
 R6kZiiiV/yF3rs2a819ZUZ8G8QAPiAQZlJMTU4aGb2lF+IIg01ABQmZokGmKI5xNuHaQjOjq2Qq
 gsUU/LyG2pfx/RiCKqFPnE3CZnCpilCWK0N1gadt0OWVYRpOsPxiZML53Wj9laszbHp97iyqpGA
 dFvQ9Lsy5p5zSayYD7A==
X-Proofpoint-ORIG-GUID: Z7xQ8B31mSj0pXS6jdgIhnw6nQXaS9ln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090153

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
index 20e28b183c1a..022ea7736521 100644
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
 
 static inline int _gaccess_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg, gpa_t saddr,
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
index 4e6979783e16..75df5d39bd78 100644
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

