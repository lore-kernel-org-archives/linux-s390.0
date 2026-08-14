Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AF489894;
	Fri, 14 Aug 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725248; cv=none; b=YuBCrWLtXbjhuQnaLn1rFIdhXN/MozK3R3DuuXxONZ2TvkR5jTeA3jgciWNViOOm6o8WtQnqF8xFZOuVCQRgdAj/7BOAL97CcUfv6Sp7cqPvlRbIl4ARt0MeiOGaA78fIs1Yb0al1/o/HlsxXmwWsRZ51ORs87wtf4MNpUPQsM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725248; c=relaxed/simple;
	bh=YZYkHDDjG4RiAuB5DNRd0Flp9YVWczQAHXbq3hMDdik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSjWXj8uGgeXH3UuMufSo08FXuSwBxDYi7rc5ZRldSsH7Aedld+aSM2rnG/XLZzt0EEMRykDYGgD0kbwepFkcfzRYqr/AjCBTfa3wjieRZcdPMtBi5WO9pAOYEqrBlfLH0+YfIziKv0+uSzeG0sP0ccxIDEeikJOQXRq9P3ssQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rzpg5Iv8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rzpg5Iv8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5iat1370405;
	Fri, 14 Aug 2026 16:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bjor/lT8tx972mA44
	cXUeinOWNF8kIvP+1a1pIjpXdI=; b=rzpg5Iv8qSmMS9h1M+6J7DeGCRtBOGz/B
	um4fYnpc1Lq9t3m2/AAhQfjUeibkCZ/VCZBFt6w/B+GCH9IAPlfkxxHwwcS/BtA6
	fYNqMdiWZe+aKUZP198wB5d9CFlece250ObWtDJZQH9D4hNgSTikQShde8UzNo4s
	VJI4LRGAKG4HSn0hygESBjaZ3p2uvObZYvdSPhcqFQMRAH6mAkIV74ZtYExBg3ET
	ldsTNE2lE79lOPvDyMEeTYIxbsVLB4cJgv7TVUEDwtMo/WtovFbUIE2SuFXzOCk6
	2AdcqpzsIFQ66Ut3V6KGBII7WCI9L75ldmJRDG3li+7CHBw6EU33g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwmhcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGQLHM028942;
	Fri, 14 Aug 2026 16:34:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wg50a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGXuf039911814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:33:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B17A42004B;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5F220043;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 4/6] KVM: s390: Move all code into kvm_arch_prepare_memory_region()
Date: Fri, 14 Aug 2026 18:33:53 +0200
Message-ID: <20260814163355.227191-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814163355.227191-1-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7f437b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=XQGuvBUbV6v71_fLNr4A:9
X-Proofpoint-GUID: l3wvZrDLhVF-sD1WUbkUv7j52aHANsGF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX5pYKLvR0x+OV
 bh+L6tMN6StT9D3A5XMOGXv6pC9KVLnlsus3J34Fpe8WuZuv5SBUwex8NR0KTS2M55scJ0sJTep
 UcaXoKD1WKbSRH7KMtW1WESs4uIybJtD6LadSJb57vIcnjdh10ZAwehYHNFAHpm0nZgbaScAfRu
 qXUx01LEYT+eywc2i7qLF7nEV/c97rDRpw5sbuT2u5NyhzNgCCyu3Fpf2vbaEPZref9DJc0RH6z
 4CFG/ZZvgqPJpKN5iwL1ddQFRoERz7JqC9IOMVysxaXS67yfdlL7yNTiuv/exZSsz7XF67Qp53I
 GfYmuXZMOJ8+w5CY6+faUcuHoch48rgslQOM3VgUvMk5pWFW1puccUHvBELIe2ug4aMV10L2YO5
 6/BEky7hlVKB3Jdjs9t/u0oLXmMnReMwglM6BIAm5Sg+M7BR5D2Ewog+HLl6drLzRDUhdG4X8GY
 n/apdtgAwvA9A+PBqEw==
X-Proofpoint-ORIG-GUID: l3wvZrDLhVF-sD1WUbkUv7j52aHANsGF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX+RTRhDpZY3Wn
 quSH5Fc/gzt9ZTo+3MWrpRV88xNlPFqRJcML6q3Sfq/BkbVLYNmCWkRamrIJw9Vp7fXhW75hyK/
 lWn8fmnvdsYDXcjR8/8WJUBCLa/TqrA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140126

Move all code from kvm_arch_commit_memory_region() into
kvm_arch_prepare_memory_region(). This allows the function to fail
gracefully if needed. The previous behaviour was to print a warning and
continue execution with page tables incosistent with the memslots.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 120 ++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 66 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 212ff0f8eecc..50eb72447fd5 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5772,11 +5772,28 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
 }
 
 /* Section: memory related */
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
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *old,
 				   struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
+	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
+
 	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
@@ -5791,6 +5808,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 		 * and munmap() stuff in this slot after doing this call at any
 		 * time.
 		 */
+		if (change != KVM_MR_MOVE && change != KVM_MR_CREATE) {
+			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
+			return -EINVAL;
+		}
 		if (new->userspace_addr & ~PAGE_MASK)
 			return -EINVAL;
 		if ((new->base_gfn + new->npages) * PAGE_SIZE > kvm->arch.mem_limit)
@@ -5799,56 +5820,28 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 	}
 
-	if (!kvm->arch.migration_mode)
-		return 0;
-
-	/*
-	 * Turn off migration mode when:
-	 * - userspace creates a new memslot with dirty logging off,
-	 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY) and
-	 *   dirty logging is turned off.
-	 * Migration mode expects dirty page logging being enabled to store
-	 * its dirty bitmap.
-	 */
-	if (change != KVM_MR_DELETE &&
-	    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
-		WARN(kvm_s390_vm_stop_migration(kvm),
-		     "Failed to stop migration mode");
-
-	return 0;
-}
-
-static long cmma_d_count_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
-{
-	union pgste pgste;
-
-	pgste = pgste_get_lock(ptep);
-	if (pgste.cmma_d) {
-		pgste.cmma_d = 0;
-		atomic64_dec(walk->priv);
+	if (kvm->arch.migration_mode) {
+		/*
+		 * Turn off migration mode when:
+		 * - userspace creates a new memslot with dirty logging off,
+		 * - userspace modifies an existing memslot (MOVE or FLAGS_ONLY)
+		 *   and dirty logging is turned off.
+		 * Migration mode expects dirty page logging being enabled to
+		 * store its dirty bitmap.
+		 */
+		if (change != KVM_MR_DELETE &&
+		    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
+			WARN(kvm_s390_vm_stop_migration(kvm),
+			     "Failed to stop migration mode");
 	}
-	pgste_set_unlock(ptep, pgste);
-	return 0;
-}
-
-void kvm_arch_commit_memory_region(struct kvm *kvm,
-				struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new,
-				enum kvm_mr_change change)
-{
-	const struct dat_walk_ops ops = { .pte_entry = cmma_d_count_pte, };
-	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
-
-	guard(mutex)(&kvm->slots_arch_lock);
 
 	if (change == KVM_MR_FLAGS_ONLY)
-		return;
-
-	mc = kvm_s390_new_mmu_cache();
-	if (!mc) {
-		rc = -ENOMEM;
-		goto out;
+		return 0;
+	if (change != KVM_MR_DELETE) {
+		/* Enough capacity to add a new memslot */
+		mc = kvm_s390_new_mmu_cache();
+		if (!mc)
+			return -ENOMEM;
 	}
 
 	scoped_guard(write_lock, &kvm->mmu_lock) {
@@ -5858,28 +5851,23 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 					    &kvm->arch.cmma_dirty_pages);
 		}
 
-		switch (change) {
-		case KVM_MR_DELETE:
-			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
-			break;
-		case KVM_MR_MOVE:
+		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
 			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
-			if (rc)
-				break;
-			fallthrough;
-		case KVM_MR_CREATE:
+		if (!rc && (change == KVM_MR_MOVE || change == KVM_MR_CREATE))
 			rc = dat_create_slot(mc, kvm->arch.gmap->asce, new->base_gfn, new->npages);
-			break;
-		case KVM_MR_FLAGS_ONLY:
-			break;
-		default:
-			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
-		}
 	}
-out:
-	if (rc)
-		pr_warn("failed to commit memory region\n");
-	return;
+	/*
+	 * Can only be triggered if dat_{create,delete}_slot() found an
+	 * internal inconsistency or if the mmu cache ran out of memory;
+	 * both should be impossible.
+	 */
+	KVM_BUG_ON(rc, kvm);
+	return rc;
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
+				   const struct kvm_memory_slot *new, enum kvm_mr_change change)
+{
 }
 
 /**
-- 
2.55.0

