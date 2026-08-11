Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE93C2790;
	Tue, 11 Aug 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463817; cv=none; b=E84RU6vPOLmaVQqv6+2f1pAXchgR23z887p4t2ejrLnDyg/zAlzMowIHcFodET9YiZOA34iXDscBv4e45Bp5ywH1aO/bGZ4l+hMAPZMp+uavLCjufRaqs3Zyy+t4KU6FqKpq9RnBG6Rgg6D+TczqyTyYbgHYvy/2pu+heq+YxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463817; c=relaxed/simple;
	bh=EFw81Acb1G2/PyCUgjTEDnYc+mN3GY2GCy1oaS6PBGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3xusR6OseABRoldhu1UVIF2XiPnxeYYt2i/XBSlZc2m+Nuc1eHiZznsDop1rqQHcyVrDTdU3FTLQoJCIvFb++DWtQFjAlzgULRSGJPorLbTNKocHnwejaAA756pfjX4cb5PKP/KpE0NOTDAXYii3aByTCFrPq2iPMmAQ1OEoDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nYi7QJpW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nYi7QJpW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXD8U570053;
	Tue, 11 Aug 2026 15:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YhESjB02iaQH/SiO5
	fSmX42hnZLZ7xVitq8orrHphRk=; b=nYi7QJpWzgdJgrmOtjFQcyLVG6krtElFo
	IvvG8IhvzZkKzwy320qm+veDtVS/SN+jZvsFmCr0cLo7JGi1ICGkkWNDi3R5K5c0
	IxWxwIEnMsmTiCJxD6/PsExo7EU8ttH9rnTjs2ms3+MHDV4WNH7UJKCtaSazbW84
	9a9M3/4MDcvlHt4LM2uc1X3+TxfdgETCCyhXubO8cCpQ6hW5h4PTj3OZ7IPJ5NRA
	EGjABP36wB0BjPx0AY+hAXzoeFFTmnwpxiXY3Q0Xz7Y6p+k/+x+pFzJGZonK/VQV
	XaqwxqwaYvej3OOMDubY/mZk79f+aCK0ctQ2BXb9Szf6QdaCCEieQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw54ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuGWp018926;
	Tue, 11 Aug 2026 15:56:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1j0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuhHs37290344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C8E2004B;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8284820043;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 07/11] KVM: s390: Move all code into kvm_arch_prepare_memory_region()
Date: Tue, 11 Aug 2026 17:56:37 +0200
Message-ID: <20260811155641.219777-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=XQGuvBUbV6v71_fLNr4A:9
X-Proofpoint-GUID: EuSe__kzKG7bJo_LBVr4_fBqczS4ynF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX4ouYUjMuFLYN
 Kl1rK4+pNZYb4D5FTwyNciVrthtqsdWMwmPBymynezrFMeYEazc0V5XdOiittt306ILVxAq9HVI
 Z9dyb+i+QtMTztWxuFgO05wsYZlcHy3D+E0C22rXo7ljFkktiIzrpalpDmewFCBwLQvDwo5mtNo
 bYW9oz4oXU5uG50BkJ6mtId2r0qcetm6QLuc0WMxGd435L7pGaid+ulVuqSsgPPwZkR51VhuKki
 YuDNr4lWFpLB5+wo3ygcrRqtPOnDR7sYxzetdCFA0mrdaAXHKF8OKEBacuyRlFX7CcBG5nj+r5c
 oEmcsRaFjTLv2QdLlufZ3lRJksGxvTeveLBYqWgSdbQgKb9ydoH8QY/lqp+bJUAUgGZr4MzhEAw
 w069wXEWOLlInkMWhwDf7TMU6snVbDp/LnN1MXVn9rRVny7zte9XQeFs87Zcrz4jq/0X891+Y/P
 ovhOSceIxL3NvNHB5bg==
X-Proofpoint-ORIG-GUID: EuSe__kzKG7bJo_LBVr4_fBqczS4ynF6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX5TAV0xGvqyFa
 pqm9FfthvwKz4+gK4JuaBv8WDTZ8oDdc9kf0UCpLdqrLXp8xAb2g5nqFvCUgX9fKhi8Bv6iTgjF
 BfTq0z3acEioTyowC14mgUa1hsCQjiU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

Move all code from kvm_arch_commit_memory_region() into
kvm_arch_prepare_memory_region(). This allows the function to fail
gracefully if needed. The previous behaviour was to print a warning and
continue execution with page tables incosistent with the memslots.

The new kvm_s390_mmu_cache_extended_topup() function is used to
guarantee that the necessary DAT table updates can be performed
successfully.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/kvm-s390.c | 124 +++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 65 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 02c5428ba239..c4196f9af05d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5766,11 +5766,28 @@ bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
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
 
@@ -5785,6 +5802,10 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
@@ -5793,57 +5814,27 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
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
+		return 0;
 
 	mc = kvm_s390_new_mmu_cache();
-	if (!mc) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!mc || kvm_s390_mmu_cache_extended_topup(mc))
+		return -ENOMEM;
 
 	scoped_guard(write_lock, &kvm->mmu_lock) {
 		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
@@ -5852,28 +5843,31 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 					    &kvm->arch.cmma_dirty_pages);
 		}
 
-		switch (change) {
-		case KVM_MR_DELETE:
+		if (change == KVM_MR_DELETE || change == KVM_MR_MOVE)
 			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
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
+
+	/*
+	 * dat_{create,delete}_slot() can only fail in two cases:
+	 * - Internal consistency error in the gmap DAT tables
+	 * - Out of memory while allocating DAT tables
+	 * The first case should not be possible in general, and is a symptom of
+	 * a serious KVM bug; the second should also be impossible because the
+	 * mmu cache has been filled to the brim, and has more than enough
+	 * capacity to handle the worst cases. Hence it is safe to put this
+	 * KVM_BUG_ON() here, as it should not be triggerable unless some
+	 * serious bug has occurred somewhere else.
+	 */
+	return KVM_BUG_ON(rc, kvm);
+}
+
+void kvm_arch_commit_memory_region(struct kvm *kvm,
+				   struct kvm_memory_slot *old,
+				   const struct kvm_memory_slot *new,
+				   enum kvm_mr_change change)
+{
 }
 
 /**
-- 
2.55.0

