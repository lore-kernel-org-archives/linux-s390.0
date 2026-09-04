Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2A35CB7C;
	Fri,  4 Sep 2026 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502023; cv=none; b=OvSB1Yh5MeuYOamqi51I6wQiTSqviydCUZQKGcN/ZqIMgOBFVDB8ZrJzMJJWjcKowDBTKkhuXjsXk4hAinGoDUKLCcwvrj79kd5GvQNPQgm5hOS5i+UkYZzepJu+FKc4EC+eb7AMfh15vSGUkWy97qJFdCE7sLhb5FBrCNnrNYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502023; c=relaxed/simple;
	bh=eCMiJ4l7MBBQC9bze2kF0XgqGwuZ2uUvpm/BZdwhKHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peZS4C0RuhNBQq/QslRIiRpa1bObAcP4amE/xQMiHBeWpj864CsdBcGU56TSVUUSnGniJWN9JexsctSmsX0HKJqpDD140TN5Ocf/KspWeU72L11Dgk+IAR4+qpNMcsFs6ONyg0oLPqmXxGYFKeELlrRkLWAnNrqkZfV9WBH/U9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s3pg+3n1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s3pg+3n1"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Xt63993752;
	Fri, 4 Sep 2026 06:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uPY9otqp89mKPstO+
	S961kfWjun2+SMQNAOp2yOcclY=; b=s3pg+3n1eYEsvYlC0LnIBz2mZoeu6WKNv
	DkOBYI5Qo+YT12sHIbd3U+7BV+eT0TtsTf1fXEi9WDQBape6oO6eUL2htPqT13oz
	LIzbMcOXCMkoAHMKUMKoXdmtiStr4p3XBSjZKC2yUpmuLLMx++LNMqQRpS6DwvbE
	QD7hAdi2ZpzNPPobRD/9Zv/vKhOnXAtKq7U5W83rkWENHW/I7fh8cEuVFBQtvAb4
	qKcnXvmJAV0sRpy7qOjeXOpV8A4USUvrTRXSDXGKfmAO+bF+fUZofX1QyKclB2k3
	x7w1BNi35vc7Ba/sR6UCcfSRk7iC8stiK+Tc/Tcj9vSp31ZpfIpHw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue8hmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uOH1002225;
	Fri, 4 Sep 2026 06:06:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqun2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466phD31261360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08BC920040;
	Fri,  4 Sep 2026 06:06:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9647C20049;
	Fri,  4 Sep 2026 06:06:50 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:50 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 05/11] KVM: s390: Move all code into s390_kvm_mmu_prepare_memory_region()
Date: Fri,  4 Sep 2026 08:06:41 +0200
Message-ID: <20260904060647.562443-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tTZYF3jxeFnbpFA5FT6YOrwEiirkMxci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX4itCcilGJ7bk
 r/PXgoZG/H5hLvSkFMys0EzrFV4qtRapF34cTnxDe4BcUk2O/bw8INM7ofkvOCrS3fSwFbqfo2I
 mSTL6uZ2AhJWm33efMomx+to3V1qhjhcfPOt57E8xZr8rIfaJYut8bZcm+cFZPPmZeJCSBZpd2H
 Ar9hDNFZMzuK7L7tTi3kMa4DhqwB+KI0JvRw2kFrW3GrHnP9LG4HF2NUBJZSPuay/dv4OWPxEtJ
 OUWdIxxAeCfRdCUFC544Piioz2vrGJ/AAqUT46n8Koc6EeOUwbNiIn3JqFzr7LWYJ2+onSF1LUE
 /df300aU81QonWwIEipsLdTMLMUCN6hle+/Os8juFfMhLsAJZKSvuwYRODKkf5QWOtCsk63ZUr4
 DAKshOLmHjnUgAEJawdHcqNzayMNK6HrRVL3rLphv9eMt8CaBZQucRaNd0L9li8khI8jPLaqMNU
 sWD05kt7HG31R4QSSow==
X-Proofpoint-ORIG-GUID: tTZYF3jxeFnbpFA5FT6YOrwEiirkMxci
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX2P9LA4ud6/J7
 2RKX3NlPGbkqwTVQOEyD+fhzYA83Ex5TSbP9Qjzj5QcL8xFr0pM6T4BzSkCCU11pzhiyebskzrA
 qGpFKT9zvouKBEpDyHhqnmBDXGf8ALw=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a6002 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=XQGuvBUbV6v71_fLNr4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

Move all code from s390_kvm_mmu_commit_memory_region() into
s390_kvm_mmu_prepare_memory_region(). This allows the function to fail
gracefully if needed. The previous behaviour was to print a warning and
continue execution with page tables inconsistent with the memslots.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260828115439.145885-6-imbrenda@linux.ibm.com>
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

