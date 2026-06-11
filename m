Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95F35504D;
	Thu, 11 Jun 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190089; cv=none; b=u1X8q+8wrRCYvxkzxtUocT3eQPqyPdW4Oc1sUSFS666G1bDTUPIDoGm8eAFwOdxJzlGfSdVu689Ho2Z6oi/1wiPNE6DJa0Ty0oZdrSXx9UjrPhgknQChTXze2CSu1mC51p0wHklS6fa/Z91ULukwcFFKeoB3V2EfUI81C4XHmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190089; c=relaxed/simple;
	bh=K9j7x50Ja+QJdMOP1Dk0Ftq2as8WycJEodAaLqa0Gg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpV8rZwsOrrgDDGuuXV7iajVJOFTGoiERIexop0qZfHPm0eVbKYDOjWMlmP6LfyoRBCTsboC8zCV0gQg9F3GcI+NCx3ee2BpY0LD/WX2PXKQDEExAiHfc6YurgLDUc6Yeyb5vNEYR4ulzCrHJ4vgd91uAOkktgRrNbuFlzI6XRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ASX45AEf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ASX45AEf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBP2Nv722249;
	Thu, 11 Jun 2026 15:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Su2kNFzNN9J+2M5+R
	zMNTDQ0MqXKXhJtSYsRBa4iG5k=; b=ASX45AEfcB8EJLDLnitZWG8EhPFoUoLXl
	2Ygdbfc83Bd3TXPc8KE38VX7ICYYPKaFeng5XSOb+iYhCuDmEq+SpqkOfRwnc6ui
	SHXizmA5mbOWx7UBVgMcJVEsKiAEAoWvQpQF9DNFGZJdB+7uaYhD/mb0Lrjq2LO7
	zyp472BFiyObgKyOVMprcoN+7QwUe640yJafrOGvdiEVPGK+PhdLpU9fZcV4CZhj
	hVDsWXq0mMc0zqk9JYa2QJftVgICLn17ctKGi/kVr4WLFTxm1dASmgII4FKOxSWd
	l9ZkLRrikXMBlNORJKq8gSaOFaKH6B+Myeinwl7iihKnsBn1hr9sg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dcdd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BEnb27031558;
	Thu, 11 Jun 2026 15:01:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08unfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:01:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BF1HGT36831520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:01:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C512004D;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B7CF2004B;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:01:17 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 5/5] KVM: s390: vsie: Use mmu cache to allocate rmap
Date: Thu, 11 Jun 2026 17:01:16 +0200
Message-ID: <20260611150116.218162-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611150116.218162-1-imbrenda@linux.ibm.com>
References: <20260611150116.218162-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX+mk4SNo0oj/R
 BZOsPQOTqbvh9zOKpg8aBNSLcqQMZyrfct+Nrz4jhtm58QySDh51PFiZLr9wtBIiK2Ol0Q8S4GI
 dwf3ZtMY30RyBCyGZl05iG8aq2et4m4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NyBTYWx0ZWRfX4+tslWODymkt
 VHzK1+PnhRwskhka0uZS1nTPDBoRREQATi/C3JXJff4ZnEzLdwv4qpYPV3clOVIAnIm6doJqK2V
 CaqCbT73DtoXfnq3FBrAuaJ25lDz+TIV7yRxiRTn7nzm0ZRbm3kbr9bnNDQ0/RL4MiDfd95bhsv
 yIqwPQl47/XfaFqtOzR5mVkK1gqByYzUIvn1Eoyp8QgHt1pATYZAGfSCqGKGphyGvCB6LCsBLPe
 q5Ax89KoIJZbxHqSmCRUY6y3klGEmRpPZJYRPmR4nitZn1gfJRMGq+LBY8NSFf1fFGibLKZYp0F
 QpieG3CPBQhg/QY7WjJxjmm91zirYy9GO7+NiHMvuttfVFHQReXy09yWuKZRKN9Vhlw7+1rul/U
 Em8vuQ2gGkumubrzcP6t5KJQOlLO2IaY1sngPQKlEczSV7aZvZrCHppsGeQJpsojz+kWkD5gXr6
 A2lgpL7rhB/nGJkd8dA==
X-Proofpoint-ORIG-GUID: 3wtaU7N4W5QPoJbt_bmodf0D18wZHBg_
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2acdc4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xGrK5rwyTb2P39Z5L3IA:9
X-Proofpoint-GUID: 3wtaU7N4W5QPoJbt_bmodf0D18wZHBg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110147

Use kvm_s390_mmu_cache_alloc_rmap() to allocate the rmap in
gmap_insert_rmap(), instead of a normal kzalloc_obj() with GFP_ATOMIC.

This guarantees forward progress.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
CC: stable@vger.kernel.org # 7.1
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260611104850.110313-6-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gaccess.c | 16 ++++++++--------
 arch/s390/kvm/gmap.c    |  7 ++++---
 arch/s390/kvm/gmap.h    |  3 ++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 0584fc91606f..36102b2727fb 100644
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

