Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42C371063
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345983; cv=none; b=cK/DxQk80r6LO0aeUDvwaaj1cTpcHoIUnKeOWqcyJfb3xo40m3Rshtq856m1htTRPY/6zijSbAqM2nzBcyFARaLHVDfKtrdIgwPvHTbpcXqicUII+GpZSPW/qksTXLLMLfG1RdwryJdJvimH6moyCowSOQ6qbd7dCF7Ifon9pTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345983; c=relaxed/simple;
	bh=6DUqg/j7MJoyMnUAkNIXLh7vawHaggQP3JXWAMjbmEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwuaqJi/w0BJZqrrOev5kJK0Pz8glBPaho2P/r7ZvnCkOkxsgvdIasSZCm5MJC8lEmlpyiHt04EpQBs+0WKnHjZVNpcQffMhId1KNI8MEy9tr8YkjFCRFnCaof3jKItAb0QSbqbW5la1Ip632g9TlEsLR8QHKcj76KYVfSP9+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaFU0e2h; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaFU0e2h"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a95b6f61so4310154c88.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771345980; x=1771950780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Ark9R30Qkzih8r6uy5tMYPv262iFz804WfSXpH0hs=;
        b=DaFU0e2hQZapGmtjhFeBRN4MSzYRJNiAumz0w34bZmNs0cQ+xgQPxj9TiAGhsEoj2j
         lRI36W5X6l9skHVFFN77ToSDrPuDja/2lfhM7+wsz6lFsRRStRQt5l87han0BrWLB7Mx
         vPva+xBaoNUppvNzT/0X3dvNP4Qw2s3ajeHEpfHQT085SSmfB8ZePRNlRI2umRX4Z+mA
         jU85rC901hsurCKEf0458y6fJBjs3l67nfZ1QEyratLObVDAr4k1U+lF30d1iqe5c1LA
         OseWsqCYN2LfHzizRrz0XczlmK8ABzHjjOFJI7qudXnbbxEvrnpkXShcNXYvFa/vI0da
         HwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345980; x=1771950780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Ark9R30Qkzih8r6uy5tMYPv262iFz804WfSXpH0hs=;
        b=Kdz/BuPj9Im8m/wEQn32PfEAS4Nl+EqnDcJOZYPMD+gwBYf0+w55yVLUGBoUMXY4az
         ewJBa0v5aTsxSs9IIORrlMmDrxqy4TFmXD74z/AmUJw8ijZA1sY25e3qkmcniR8D2lxA
         z+mtagiJVuCysykesgRM+sEoAs/sMegULBARonpnZDE9bFLdplKzY1U74uV1JhODih49
         gLolf9ayLAx8QrlHPiUDVCPH85q8I98Rc6AP0GHBTQWQJSwysx+erQtGBB+siOELzZCj
         tAbjBBD7aeQTmFutEdKVbeBgwqdlzZHF0/QuHufHETNEuplq0kKmHjznyqTe4K1iGYjN
         X5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTjr/rBMI8jJhXVIiJa7DF3DvxzAcyEu7ZtS9U+9AP3pbP8gpJR8+UvAzvK4ZkZRjIdvgrFqk7v2lh@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTQNfbCT34kGvczfn0zE0Y4PIXbZIf2i6YxdOb5jrd2L8ugJI
	8n+MSpRUFGdPGltGeoj3ozjWohubuVMN/KHpI6nvDro8+xgAuJEP5+Hp3vaJqffJybwNX9R2/L9
	xh6j39Q==
X-Received: from dlbvt13.prod.google.com ([2002:a05:7022:3f8d:b0:119:49ca:6bae])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:250e:b0:11d:f440:b743
 with SMTP id a92af1059eb24-1273adf34c5mr6016405c88.7.1771345980160; Tue, 17
 Feb 2026 08:33:00 -0800 (PST)
Date: Tue, 17 Feb 2026 08:32:50 -0800
In-Reply-To: <20260217163250.2326001-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217163250.2326001-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260217163250.2326001-4-surenb@google.com>
Subject: [PATCH v2 3/3] mm: use vma_start_write_killable() in process_vma_walk_lock()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Replace vma_start_write() with vma_start_write_killable() when
process_vma_walk_lock() is used with PGWALK_WRLOCK option.
Adjust its direct and indirect users to check for a possible error
and handle it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/s390/kvm/kvm-s390.c |  5 +++--
 arch/s390/mm/gmap.c      | 13 ++++++++++---
 fs/proc/task_mmu.c       |  7 ++++++-
 mm/pagewalk.c            | 20 ++++++++++++++------
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 56a50524b3ee..75aef9c66e03 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -958,6 +958,7 @@ static int kvm_s390_get_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	int ret;
+	int err;
 	unsigned int idx;
 	switch (attr->attr) {
 	case KVM_S390_VM_MEM_ENABLE_CMMA:
@@ -990,10 +991,10 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
 		mutex_lock(&kvm->lock);
 		idx = srcu_read_lock(&kvm->srcu);
-		s390_reset_cmma(kvm->arch.gmap->mm);
+		err = s390_reset_cmma(kvm->arch.gmap->mm);
 		srcu_read_unlock(&kvm->srcu, idx);
 		mutex_unlock(&kvm->lock);
-		ret = 0;
+		ret = (err < 0) ? err : 0;
 		break;
 	case KVM_S390_VM_MEM_LIMIT_SIZE: {
 		unsigned long new_limit;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index dd85bcca817d..96054b124db5 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2271,6 +2271,7 @@ int s390_enable_skey(void)
 {
 	struct mm_struct *mm = current->mm;
 	int rc = 0;
+	int err;
 
 	mmap_write_lock(mm);
 	if (mm_uses_skeys(mm))
@@ -2282,7 +2283,9 @@ int s390_enable_skey(void)
 		mm->context.uses_skeys = 0;
 		goto out_up;
 	}
-	walk_page_range(mm, 0, TASK_SIZE, &enable_skey_walk_ops, NULL);
+	err = walk_page_range(mm, 0, TASK_SIZE, &enable_skey_walk_ops, NULL);
+	if (err < 0)
+		rc = err;
 
 out_up:
 	mmap_write_unlock(mm);
@@ -2305,11 +2308,15 @@ static const struct mm_walk_ops reset_cmma_walk_ops = {
 	.walk_lock		= PGWALK_WRLOCK,
 };
 
-void s390_reset_cmma(struct mm_struct *mm)
+int s390_reset_cmma(struct mm_struct *mm)
 {
+	int err;
+
 	mmap_write_lock(mm);
-	walk_page_range(mm, 0, TASK_SIZE, &reset_cmma_walk_ops, NULL);
+	err = walk_page_range(mm, 0, TASK_SIZE, &reset_cmma_walk_ops, NULL);
 	mmap_write_unlock(mm);
+
+	return (err < 0) ? err : 0;
 }
 EXPORT_SYMBOL_GPL(s390_reset_cmma);
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d7d52e259055..91e806d65bd9 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		struct clear_refs_private cp = {
 			.type = type,
 		};
+		int err;
 
 		if (mmap_write_lock_killable(mm)) {
 			count = -EINTR;
@@ -1824,7 +1825,11 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
+		if (err < 0) {
+			count = err;
+			goto out_unlock;
+		}
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index a94c401ab2cf..dc9f7a7709c6 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -425,14 +425,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
 		mmap_assert_write_locked(mm);
 }
 
-static inline void process_vma_walk_lock(struct vm_area_struct *vma,
+static inline int process_vma_walk_lock(struct vm_area_struct *vma,
 					 enum page_walk_lock walk_lock)
 {
 #ifdef CONFIG_PER_VMA_LOCK
 	switch (walk_lock) {
 	case PGWALK_WRLOCK:
-		vma_start_write(vma);
-		break;
+		return vma_start_write_killable(vma);
 	case PGWALK_WRLOCK_VERIFY:
 		vma_assert_write_locked(vma);
 		break;
@@ -444,6 +443,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 		break;
 	}
 #endif
+	return 0;
 }
 
 /*
@@ -487,7 +487,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
 			if (ops->pte_hole)
 				err = ops->pte_hole(start, next, -1, &walk);
 		} else { /* inside vma */
-			process_vma_walk_lock(vma, ops->walk_lock);
+			err = process_vma_walk_lock(vma, ops->walk_lock);
+			if (err)
+				break;
 			walk.vma = vma;
 			next = min(end, vma->vm_end);
 			vma = find_vma(mm, vma->vm_end);
@@ -704,6 +706,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
@@ -711,7 +714,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(start, end, &walk);
 }
 
@@ -734,6 +739,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		.vma		= vma,
 		.private	= private,
 	};
+	int err;
 
 	if (!walk.mm)
 		return -EINVAL;
@@ -741,7 +747,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
-	process_vma_walk_lock(vma, ops->walk_lock);
+	err = process_vma_walk_lock(vma, ops->walk_lock);
+	if (err)
+		return err;
 	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
 }
 
-- 
2.53.0.273.g2a3d683680-goog

