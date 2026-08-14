Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425643446C4;
	Fri, 14 Aug 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718454; cv=none; b=jjwKOQptfJSmzg7nHSk6GMAp3rM6nvAwdAo7LTrck1tQ9DryaDJaxhdKJlG5sAhrbcracUDPCHPMlZXrgZyWGHFigiAcTmMVoxNoryI3llhtMioxBJhTqX16o+Xu40jd8UuPmv86k7+b/23jQkPdtMK0LX9YXcWncx5mJvI/0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718454; c=relaxed/simple;
	bh=G2LHD3z0k64ylTrt52Mk0kqsYI8nA1DE1czMAAMJmZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9blxJ7PSyF7E0uRBmZ/4V4CYuh84fFBtJBzLE4j9VRoYHg7Jg5VNllJyjpYycrfG3uVKSKSmZ3diISPcV6cVmLcD6fJ8oEo8Low87pTyePLL+VIOHysGqxVFpOliptqQ1+Z3u5ceYLyWQ2Prel2luzu70yORQO0qsnyIK7lMvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K4KVy2xy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K4KVy2xy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5p3I1370805;
	Fri, 14 Aug 2026 14:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lXAIpo3qXkww2zJ+r
	ZYA9nEJyoE9kM5kto7zlAWBB8E=; b=K4KVy2xyWL1BC6r80sU1cxqgN8hnpnaE3
	7or+HY1hBL1O36kRMBHI4wjVYXscrAeJgktfOXonexFsXCI614RQ73RQOkz4Bo1g
	hD0ERxL9E7A8nqiB+hHoTLXRP6L1VC5ayZFLcB+I/DJCrrUKIkL3HCsCsGuK6Hbd
	1aIm397ZQKwFmK7iBowy+BE2S9roTW+4jbWgHyBW5v/MfuetwQxtB7Ol3dcDWUvA
	eJJnUs+d/XcJnUjh7esys1GKIAdSri/lcsG+JxXGgRjTEcgDSsHGgAP+YLqAHRCm
	Jj08SePn67KvKEC8IN5JulNoz/DRTVE5q8h7SDb7S+QhcnWx76tHQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwm2wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEQXlI013092;
	Fri, 14 Aug 2026 14:40:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpvad4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 14:40:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EEehMs21758604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 14:40:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E18232004B;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCBFA20043;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 14:40:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 4/6] KVM: s390: Move all code into kvm_arch_prepare_memory_region()
Date: Fri, 14 Aug 2026 16:40:39 +0200
Message-ID: <20260814144041.169025-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814144041.169025-1-imbrenda@linux.ibm.com>
References: <20260814144041.169025-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7f28ef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=XQGuvBUbV6v71_fLNr4A:9
X-Proofpoint-GUID: dGS9JqxA156Knv7k_CaddBEUruGQHMPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX+oHOh/NDQTFv
 uxactGENc5ej46153lMxpFVkxVswxDYtxLaweGo/1Zgo8bq0pSNUXUd/0qf5HcxHtNj/Es0shot
 Sik4SbnKFruVT0YdaXMKAaJntVKiM3JbUW+WFcBQOJ5grpwi41Js0fSCaMbekH74p1umKL2gr7x
 9C3VooyvveRXekiwmh/rk32+pZP0qFvXF9Te74s0UOK/yAb7x25N2X1t9YiRUy67rInEuHWtx4W
 1ryZTL/QFHJ693S0J8aEwvaHl5iwaVkasognuffoCq/0Dqmwo1itnRd+0uhV0WEVpQ8nx6+SllO
 5a6dyixPM9cD7RPeogZ9IiozBb0zJnsmP6m7ky18yFOH7o572tm+HnCYzTNixpVp6MLoUVSaTvB
 Se+MdiLpifwUmdYpL26WBh/BmmBxIblO8+WAhD0gzgNWEf0pTDI55T1+VQbBWPCitZd+hgX/XbF
 OyBsRgeR5u9wua77PQQ==
X-Proofpoint-ORIG-GUID: dGS9JqxA156Knv7k_CaddBEUruGQHMPB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExMSBTYWx0ZWRfX6t2mWyTFT5Jx
 lEVE4CJNsNOpI/8WIC2NB880iVaP2WPxGDe4FGP92Qim4vHm76x49ytGUhLbKHlKID4yawFGNSn
 3KGaLvmQCzNWg2/e+om67LScD8+eclc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140111

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
index 0a08a3c7b023..50eb72447fd5 100644
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
+		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
 			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
-			break;
-		case KVM_MR_MOVE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
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

