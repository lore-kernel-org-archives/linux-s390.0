Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65844607E;
	Thu, 30 Jul 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428846; cv=none; b=mG6iX3vScp+rOBYzN2yoqn7e0l39VTsv/ZIoQGzr+2Ol7/FL+9cwZU/8VwQqJk8Sw7EZ/PDhuDJ7yj6HS/3DPv30PXQyi+8NZjqhcnvCI5hXVdKDqk4qFb9izP/kC671+UAihLAAEDiLnM0HFyLdC0fdmHIoTlWej+lPTvasse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428846; c=relaxed/simple;
	bh=eeTzb1ZbMwflNnpDixRyugPqcMasaokE3BQmnhaBsCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGyDMh1XxIAOw5sJ5f3BlXGxDfkz7ccG0l07oOziQvsKsvj6a2t8NkLNOlIiaWG9saNOWGfgeI3qaZYBJq1xaAwiaQ5TC5XXWnP8N0jzTLyJtNVrQbPufsk8FhkhsOZGw64b4LiLXlwJ+vHmaR6Y31icd0tk2bgB3TaHhnjucDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rL5RuDx3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rL5RuDx3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFlsBQ3424599;
	Thu, 30 Jul 2026 16:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aqbuTGbCbV/WQLHBs
	27XfnHYZCMUEZJ0JMpfixCf9/Q=; b=rL5RuDx30pdrw0YZW4MgWQScdlkb7VLgb
	rRbEaOtYtBdfo4PLQwnVDxRVnFrLgbzv8mYVrlcRjpICe8390U6KCcEkRpnTfJos
	3rUvi7rBteerTuc/0zSoVlW9EpZH3JjdDxLK2ZN1MelLAInjet3KGF580dgXj7ma
	esRQRHGxyQMLFQ+usbJBAwFvyIaqwMOMYYUaHDf+hFrM276r784YXkEPxwmOoHW2
	gvKqPqIu/TGfyBxAxY9R8aFO7jKKN7higFZHrYibY9hqX/AIuctswAPLBTOG8FLr
	wnE3RXZskzLL7E+VbIPMs22yIJ2zaJ6bmzE3cLhbQvdvTigETiKOQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7rs5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UGQIBc010519;
	Thu, 30 Jul 2026 16:27:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ybv5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 16:27:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UGRGFC17826094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 16:27:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C8820043;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00AED2004F;
	Thu, 30 Jul 2026 16:27:16 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 16:27:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v6 07/14] KVM: s390: cmma: Fix dirty tracking when removing memslot
Date: Thu, 30 Jul 2026 18:27:07 +0200
Message-ID: <20260730162714.133327-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730162714.133327-1-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iAUeSiv_1RnVWGnc3IA7UdOTTo6lULTx
X-Proofpoint-ORIG-GUID: iAUeSiv_1RnVWGnc3IA7UdOTTo6lULTx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX7U/LG4wAzCG3
 iBGJYGgK7a9SfUfpJJCTJXCbe6l8zk6wIRcv0z0pOczmU/5YjvA9mScW0UKyQ0VpXh9X08Ahew2
 UoL7kxpyxGt0rlR1pVwXf5Xmt6y9NaYiuO8mAIkbejKgA5qXooor/uPCpbex26U/8rV+v6pOEW2
 4KmlABnrF2vWjgiur8pwrvP49HANarPfg3a50X+wwC6TgtXvkZR+mvWFhc0lts2Qi+dEapb8M3a
 tTezoMY7FEkPjTU3wvEMVYC2Cx9JyIhDpxgV+Hz+lVHEM+Lh4oD82g3f2IPpRiGVJIXsLdxxjQx
 1ME6NG2RPOpAo9fwr5T1rF5hFOp3VGzjLg9OuHqkOk37MoHAZ/kD4vmHV5KO5IFAJoYaOWBABuN
 M+KQmMXqw2dEKQWiafE3meox141pnWcpxrhIJRQHBkheOzXgFGcuSL5K90GgKgyJofSttvKC0KO
 pfvYm0TNHehw57ayEVA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6b7b6a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=xy2Bf3EjJieBI87QFfgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMyBTYWx0ZWRfX29bk0947YNEj
 jL/VOHDt5I38pxFqCHt2/5EILqnpBTlsLHv396GEJ7nyAyYLbn/aeiUcq0uPyPFZIa6bdAcakra
 aEk4AlhZTmSHO6pBK+Wp55vO5antWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300123

When a memslot is removed, all ptes that mapped the slot are cleared or
even deallocated. If this happens while the system is in migration
mode, and if cmma-dirty pages are removed, the cmma-dirty counter will
not reflect reality.

Fix by appropriately decrementing the cmma-dirty counter when removing
a memslot.

Opportunistically improve kvm_arch_commit_memory_region() to use
__free() for the struct kvm_s390_mmu_cache.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      |  7 ++++++-
 arch/s390/kvm/kvm-s390.c | 25 +++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 171b61959908..3f2d6e8902d7 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -850,6 +850,7 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	struct slot_priv *p = walk->priv;
 	union crste dummy = { .val = p->token };
 	union pte new_pte, pte = READ_ONCE(*ptep);
+	union pgste pgste;
 
 	new_pte = _PTE_TOK(dummy.tok.type, dummy.tok.par);
 
@@ -857,7 +858,11 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 	if (pte.val == new_pte.val)
 		return 0;
 
-	dat_ptep_xchg(ptep, new_pte, gfn, walk->asce, false);
+	pgste = pgste_get_lock(ptep);
+	pgste = __dat_ptep_xchg(ptep, pgste, new_pte, gfn, walk->asce, false);
+	pgste.cmma_d = 0;
+	pgste_set_unlock(ptep, pgste);
+
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 24c3bfcd5db2..c1984fe2f9a4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5809,14 +5809,30 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 	return 0;
 }
 
+static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
+{
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	if (pgste.cmma_d) {
+		pgste.cmma_d = 0;
+		atomic64_dec(walk->priv);
+	}
+	pgste_set_unlock(ptep, pgste);
+	return 0;
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
-	struct kvm_s390_mmu_cache *mc = NULL;
+	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
 	int rc = 0;
 
+	guard(mutex)(&kvm->slots_arch_lock);
+
 	if (change == KVM_MR_FLAGS_ONLY)
 		return;
 
@@ -5827,6 +5843,12 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	}
 
 	scoped_guard(write_lock, &kvm->mmu_lock) {
+		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
+			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,
+					    kvm->arch.gmap->asce, &ops, DAT_WALK_IGN_HOLES,
+					    &kvm->arch.cmma_dirty_pages);
+		}
+
 		switch (change) {
 		case KVM_MR_DELETE:
 			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
@@ -5848,7 +5870,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 out:
 	if (rc)
 		pr_warn("failed to commit memory region\n");
-	kvm_s390_free_mmu_cache(mc);
 	return;
 }
 
-- 
2.55.0

