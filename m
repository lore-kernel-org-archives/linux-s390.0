Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9D445ADD;
	Fri, 28 Aug 2026 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787918106; cv=none; b=VOiKBKfYYl7YfFoGEzF9qJW9ELVOVgUd7qGJWGc7XFLzfB3mjAIjlo/6vHRzAHb+N7D8TJ55WFlsmxx5wxF+VotgkeKu6EcL9dCDqeOE9A/gmTXBm40joXMxiNKcOBzkLlXzlSBjKFCGARDRuAKReazCE98KHh/lh9c9Lkc8OUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787918106; c=relaxed/simple;
	bh=EzLjQ3QYSPWodEBYgfMxFm7MZ+LhS3n4I0WeCxb34YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaU4xDC+mGNmL2DK3mIRLNCUQ22kZxX9SWqjWuLEd9STslowzh4jCLISTq1lUx+/pNC0cWOwhXAd3OTyNOAARWKxQ6HPQ1A5dDmkq9OYMiI1CY1Eln/j2yWenx2wXnwL/5MUVEzAQpuriWTcgsBt7a4wGY0GRFGzQuhZLJgFP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=liw2NxWq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="liw2NxWq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SAWYBJ604147;
	Fri, 28 Aug 2026 11:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MSGaBAdIZ/lnnJ342
	a9nyiDB5OQtvOqXd+WYx37VX88=; b=liw2NxWq0eKK9YWAb2XDSzwYbFxS5iWWy
	8F4zQKohQp5ddCadpmq1EzlPZZnRSEMe3c3vI7q6eQDp8ZZhsX+oDx83AzkGa0Mm
	DgpgUA0WMlPySg5MDhzv/YdOQjfKeKNlAbM6wNrgdW/40sN9A9FFaH6Lt16glJ/W
	ckxzOdm7mDaNSNMZsbvsWMkx4VJD+pWcYWAXoS5H3pWzSxMuilOuv4X7mCjRbk12
	KuKhsAXmod/u2whc8ZJEWU18MYylud4h7Wy+w8MEDWBSqCB363qmcX79iVNyymrw
	2O7JerO11F1ZUqPuiMVCIqNq9WPUOOaM25c8uy8Ao0FQ2zT9znNRw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726f3rjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SBfGHR031558;
	Fri, 28 Aug 2026 11:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragwsuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:54:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SBseld7799070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 11:54:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB572004B;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5996620040;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Aug 2026 11:54:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 5/8] KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
Date: Fri, 28 Aug 2026 13:54:36 +0200
Message-ID: <20260828115439.145885-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828115439.145885-1-imbrenda@linux.ibm.com>
References: <20260828115439.145885-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a917707 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=XQGuvBUbV6v71_fLNr4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX05wObuSFoToM
 S0wBXZutBZrTzCMqTBpIycEyt04QGdppnT1pK4sKcjq9rCbCDhRYz7QLirhTXkq9S+/icE7V2e7
 6J2KYwvmUEYzTvlmilDHXOEjMxTokGY=
X-Proofpoint-GUID: f91U8Li3JdN0YHzWtKX5wfF1Gexa2gFz
X-Proofpoint-ORIG-GUID: f91U8Li3JdN0YHzWtKX5wfF1Gexa2gFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA5OSBTYWx0ZWRfX2czpOgQKckBg
 NoMso2/EAhcTXaBe6MIcB9uYPwnttKbAk3//nMh+lzNs51ZQ1yf6XvQVSqNLdhlaXJIMaJxg4rK
 Whw2BFdwe5LPKsssIUH13B2C2gVPeap6eoz2jATgO/NrwiSPBxXrSaiVQ4rfs71xz10mkDo0WaS
 wKW5Cn/dtWD2JstxgICiSU3sVtooA0956GG61A61HGMdXgcSkQTrJiH5y4r3BOL9vY9XRvH1xbp
 8RmrwCfMVUWxpI6RQSz9Mq3mLFTkcmInBTkx53I07ZwryrSCC14vnWay0SFpoe2YwHdv42YZtYJ
 VRow2SmgembeWa6PPM27njmI9wcCZq28Rzw0IpWfIXJ8chUosFqc79jatI2c6uTVH1x3ZJbKm+o
 +BzpNq3QTcr09ZDFAEGGLEBARaGR/wprz4SLn83mMJTIEN+qVuLHsfy1GB6WQZCwm1mmGywXhOg
 4eG9iUyHYojc0CKU02A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280099

Move all code from s390_kvm_mmu_commit_memory_region() into
s390_kvm_mmu_prepare_memory_region(). This allows the function to fail
gracefully if needed. The previous behaviour was to print a warning and
continue execution with page tables inconsistent with the memslots.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/kvm_mmu.c | 89 +++++++++++++++---------------------
 arch/s390/kvm/gmap/kvm_mmu.h |  4 --
 arch/s390/kvm/s390/s390.c    |  1 -
 3 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index 4c8054e18490..c2ffb5e59ec6 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -47,6 +47,9 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 				       struct kvm_memory_slot *new,
 				       enum kvm_mr_change change)
 {
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
+
 	if (kvm_is_ucontrol(kvm) && new && new->id < KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
@@ -61,6 +64,10 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
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
@@ -69,65 +76,41 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 			return -EINVAL;
 	}
 
-	if (!kvm_s390_is_migration_mode(kvm))
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
-void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
-				       struct kvm_memory_slot *old,
-				       const struct kvm_memory_slot *new,
-				       enum kvm_mr_change change)
-{
-	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
-	int rc = 0;
-
-	guard(mutex)(&kvm->slots_arch_lock);
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
+	}
 
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
-
 	scoped_guard(write_lock, &kvm->mmu_lock) {
 		kvm_s390_update_cmma_dirty(kvm, old);
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
+	/*
+	 * Can only be triggered if dat_{create,delete}_slot() found an
+	 * internal inconsistency or if the mmu cache ran out of memory;
+	 * both should be impossible.
+	 */
+	KVM_BUG_ON(rc, kvm);
+	return rc;
 }
diff --git a/arch/s390/kvm/gmap/kvm_mmu.h b/arch/s390/kvm/gmap/kvm_mmu.h
index cdbd390bd33c..43cde61bae03 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.h
+++ b/arch/s390/kvm/gmap/kvm_mmu.h
@@ -10,9 +10,5 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 				       const struct kvm_memory_slot *old,
 				       struct kvm_memory_slot *new,
 				       enum kvm_mr_change change);
-void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
-				       struct kvm_memory_slot *old,
-				       const struct kvm_memory_slot *new,
-				       enum kvm_mr_change change);
 
 #endif /* ARCH_KVM_GMAP_KVM_MMU_H */
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 8f7e09d7d049..eca4a4359ab2 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5781,7 +5781,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
 				   const struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	s390_kvm_mmu_commit_memory_region(kvm, old, new, change);
 }
 
 /**
-- 
2.55.0

