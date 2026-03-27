Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2137F75F
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644914; cv=none; b=pJ4i0OW6/BOP55rowCe7VQdRrATnlU1A/ETVatxFMqZ2TC++oL+DplhUOAmsRCtxTvJlErqqaiEuwsFCWt5BDPYiiu2BuzZeXueGIxTvRHwmO/jcFBPxTc5BSLO5d359Q4BxAdxX18PjgN+Cxz++05Q6IEZ+nUvfMQcsw1Cj23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644914; c=relaxed/simple;
	bh=d5mnzxn4Tjwdwq6SneMA/zGXA7gBgTdol5RbAikXVvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQI4Ezi6Vem95nI7VEo2rBUNQYtyX4PbEAHo+EbyOqsp6zegWVLhF5v7jVY1QgpXCWqc86lytHmyDc2dwoAKZzBPLRFczKGvm8inZAbivba4y54QiO+e1qJ+O1lqszLkZ3j+Ot89i4ZYAEuODRClUn37TOxwv/vb/BSULjKsAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5uZucig; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5uZucig"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so2440014eec.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774644911; x=1775249711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6skjtd7OxVmiwFu5TmEIQZKDuU+5vel5eIP7VGPQHkg=;
        b=g5uZucigZDwE7NyCqBEYkRQOXhOpVkYFRISsZ5p0llxgndtPPQxdb5uKgdjiuTwD7Q
         wQ9/hivbLB8lOfMW+Q/ndrvuEpIZhTzn5w7sgnZq5mT60rBmiOdNLDQ4epGuNK3UQ78g
         91wuLODB9gVI3uSkqzYOJ4M1U+uIbeCDIrI7HlXedAQCkfKCFsDfawsbsZznKgjJrtsG
         2ev2gmAOV33p8OFFjSJgUW0jvilRtaeyrWSnCm0FH+CxpLCyuyMU5KfLKpst1khE2z6B
         Sn6ljoHT94m3XV5cVv6KlCy4kZgp2IRjhI+W8jbOCCSaLlaIQ/8ICZKShMBuWICRra7d
         /noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644911; x=1775249711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6skjtd7OxVmiwFu5TmEIQZKDuU+5vel5eIP7VGPQHkg=;
        b=ryBcWL1UFcwSWbw0blff8XTRRHJhh9pUFX46HVFUJuwTn4baYj3hB4Y1usIL86R7xt
         CUk3PzBc5NNHXzjuvyTIwUeFgjXbwrW1sjaqx+aiOjCKNYsPKcUidDOHImCRvL/F+hC5
         C7WdE7nvI/OLbx1rgKNAzv2b56AJ39iYrvpZ2ERDZyLjLrrEyxFWCR5/fZ3l7hz6YQfq
         czfWrDJzOZsxuvaYAAeqEyfkHNHsnQ3MkgQCGGb01jwzECz3CC4SPHeiXnOdx0Xc+C26
         dIBsyer8Tif2pxuWqhjLgAwRZmBmJQLOUxDG6IhAt/Sr6vz7fljfI4BAAhwHo3cKjHUZ
         z16A==
X-Forwarded-Encrypted: i=1; AJvYcCUSJNNpSn08WcWgqX5rQA/e82a6+lTuSqQBreCGqnahq65yF/MfdA0SYmZ69HFpfsWFezGE86aXpWhU@vger.kernel.org
X-Gm-Message-State: AOJu0YycVpJufQcmUXRQXW0IDdlUHSrpgdg7g9EOXceKUOtYomvEKC61
	2ahyIRrxEjOeQOY0GB8FkzKjx4TQKEIDdpZa1KuS9X+MjCBtEBV0W1EwoXvQW8IoaSHnI/ubYWQ
	+Vp6vFQ==
X-Received: from dybrq15.prod.google.com ([2002:a05:7301:468f:b0:2c3:adf7:d755])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5b89:b0:2c1:1dea:c443
 with SMTP id 5a478bee46e88-2c185e460a2mr2052736eec.19.1774644910254; Fri, 27
 Mar 2026 13:55:10 -0700 (PDT)
Date: Fri, 27 Mar 2026 13:54:55 -0700
In-Reply-To: <20260327205457.604224-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327205457.604224-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327205457.604224-5-surenb@google.com>
Subject: [PATCH v6 4/6] mm/vma: use vma_start_write_killable() in vma operations
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, ljs@kernel.org, baolin.wang@linux.alibaba.com, 
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

Replace vma_start_write() with vma_start_write_killable(), improving
reaction time to the kill signal.
Replace vma_start_write() calls when we operate on VMAs.

To propagate errors from vma_merge_existing_range() and vma_expand()
we fake an ENOMEM error when we fail due to a pending fatal signal.
This is a temporary workaround. Fixing this requires some refactoring
and will be done separately in the future.

In a number of places we now lock VMA earlier than before to avoid
doing work and undoing it later if a fatal signal is pending. This
is safe because the moves are happening within sections where we
already hold the mmap_write_lock, so the moves do not change the
locking order relative to other kernel locks.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/vma.c      | 146 ++++++++++++++++++++++++++++++++++++++------------
 mm/vma_exec.c |   6 ++-
 2 files changed, 117 insertions(+), 35 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index ba78ab1f397a..cc382217f730 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -524,6 +524,21 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
+	/*
+	 * Lock VMAs before cloning to avoid extra work if fatal signal
+	 * is pending.
+	 */
+	err = vma_start_write_killable(vma);
+	if (err)
+		goto out_free_vma;
+	/*
+	 * Locking a new detached VMA will always succeed but it's just a
+	 * detail of the current implementation, so handle it all the same.
+	 */
+	err = vma_start_write_killable(new);
+	if (err)
+		goto out_free_vma;
+
 	err = -ENOMEM;
 	vma_iter_config(vmi, new->vm_start, new->vm_end);
 	if (vma_iter_prealloc(vmi, new))
@@ -543,9 +558,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	vma_start_write(vma);
-	vma_start_write(new);
-
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
@@ -900,12 +912,22 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	}
 
 	/* No matter what happens, we will be adjusting middle. */
-	vma_start_write(middle);
+	err = vma_start_write_killable(middle);
+	if (err) {
+		/* Ensure error propagates. */
+		vmg->give_up_on_oom = false;
+		goto abort;
+	}
 
 	if (merge_right) {
 		vma_flags_t next_sticky;
 
-		vma_start_write(next);
+		err = vma_start_write_killable(next);
+		if (err) {
+			/* Ensure error propagates. */
+			vmg->give_up_on_oom = false;
+			goto abort;
+		}
 		vmg->target = next;
 		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
 		vma_flags_set_mask(&sticky_flags, next_sticky);
@@ -914,7 +936,12 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_left) {
 		vma_flags_t prev_sticky;
 
-		vma_start_write(prev);
+		err = vma_start_write_killable(prev);
+		if (err) {
+			/* Ensure error propagates. */
+			vmg->give_up_on_oom = false;
+			goto abort;
+		}
 		vmg->target = prev;
 
 		prev_sticky = vma_flags_and_mask(&prev->flags, VMA_STICKY_FLAGS);
@@ -1170,10 +1197,18 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vma_flags_t sticky_flags =
 		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
 	vma_flags_t target_sticky;
-	int err = 0;
+	int err;
 
 	mmap_assert_write_locked(vmg->mm);
-	vma_start_write(target);
+	err = vma_start_write_killable(target);
+	if (err) {
+		/*
+		 * Override VMA_MERGE_NOMERGE to prevent callers from
+		 * falling back to a new VMA allocation.
+		 */
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
+		return err;
+	}
 
 	target_sticky = vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
 
@@ -1201,6 +1236,19 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
 	if (remove_next) {
+		/*
+		 * Lock the VMA early to avoid extra work if fatal signal
+		 * is pending.
+		 */
+		err = vma_start_write_killable(next);
+		if (err) {
+			/*
+			 * Override VMA_MERGE_NOMERGE to prevent callers from
+			 * falling back to a new VMA allocation.
+			 */
+			vmg->state = VMA_MERGE_ERROR_NOMEM;
+			return err;
+		}
 		err = dup_anon_vma(target, next, &anon_dup);
 		if (err)
 			return err;
@@ -1214,7 +1262,6 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (remove_next) {
 		vma_flags_t next_sticky;
 
-		vma_start_write(next);
 		vmg->__remove_next = true;
 
 		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
@@ -1252,9 +1299,14 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff)
 {
 	struct vma_prepare vp;
+	int err;
 
 	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
 
+	err = vma_start_write_killable(vma);
+	if (err)
+		return err;
+
 	if (vma->vm_start < start)
 		vma_iter_config(vmi, vma->vm_start, start);
 	else
@@ -1263,8 +1315,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi, NULL))
 		return -ENOMEM;
 
-	vma_start_write(vma);
-
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, NULL);
@@ -1453,7 +1503,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			if (error)
 				goto end_split_failed;
 		}
-		vma_start_write(next);
+		error = vma_start_write_killable(next);
+		if (error)
+			goto munmap_gather_failed;
 		mas_set(mas_detach, vms->vma_count++);
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
@@ -1848,12 +1900,16 @@ static void vma_link_file(struct vm_area_struct *vma, bool hold_rmap_lock)
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	VMA_ITERATOR(vmi, mm, 0);
+	int err;
+
+	err = vma_start_write_killable(vma);
+	if (err)
+		return err;
 
 	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
 	if (vma_iter_prealloc(&vmi, vma))
 		return -ENOMEM;
 
-	vma_start_write(vma);
 	vma_iter_store_new(&vmi, vma);
 	vma_link_file(vma, /* hold_rmap_lock= */false);
 	mm->map_count++;
@@ -2239,9 +2295,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 	 * is reached.
 	 */
 	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
+		if (signal_pending(current) || vma_start_write_killable(vma))
 			goto out_unlock;
-		vma_start_write(vma);
 	}
 
 	vma_iter_init(&vmi, mm, 0);
@@ -2540,8 +2595,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	struct mmap_action *action)
 {
 	struct vma_iterator *vmi = map->vmi;
-	int error = 0;
 	struct vm_area_struct *vma;
+	int error;
 
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2552,6 +2607,14 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	if (!vma)
 		return -ENOMEM;
 
+	/*
+	 * Lock the VMA early to avoid extra work if fatal signal
+	 * is pending.
+	 */
+	error = vma_start_write_killable(vma);
+	if (error)
+		goto free_vma;
+
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
 	vma->flags = map->vma_flags;
@@ -2582,8 +2645,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
 #endif
 
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
 	map->mm->map_count++;
 	vma_link_file(vma, action->hide_from_rmap_until_complete);
@@ -2878,6 +2939,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		 unsigned long addr, unsigned long len, vma_flags_t vma_flags)
 {
 	struct mm_struct *mm = current->mm;
+	int err;
 
 	/*
 	 * Check against address space limits by the changed size
@@ -2910,24 +2972,33 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 		if (vma_merge_new_range(&vmg))
 			goto out;
-		else if (vmg_nomem(&vmg))
+		if (vmg_nomem(&vmg)) {
+			err = -ENOMEM;
 			goto unacct_fail;
+		}
 	}
 
 	if (vma)
 		vma_iter_next_range(vmi);
 	/* create a vma struct for an anonymous mapping */
 	vma = vm_area_alloc(mm);
-	if (!vma)
+	if (!vma) {
+		err = -ENOMEM;
 		goto unacct_fail;
+	}
 
 	vma_set_anonymous(vma);
 	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
 	vma->flags = vma_flags;
 	vma->vm_page_prot = vm_get_page_prot(vma_flags_to_legacy(vma_flags));
-	vma_start_write(vma);
-	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
+	if (vma_start_write_killable(vma)) {
+		err = -EINTR;
+		goto vma_lock_fail;
+	}
+	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL)) {
+		err = -ENOMEM;
 		goto mas_store_fail;
+	}
 
 	mm->map_count++;
 	validate_mm(mm);
@@ -2942,10 +3013,11 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 mas_store_fail:
+vma_lock_fail:
 	vm_area_free(vma);
 unacct_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
-	return -ENOMEM;
+	return err;
 }
 
 /**
@@ -3112,8 +3184,8 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
-	int error = 0;
 	VMA_ITERATOR(vmi, mm, vma->vm_start);
+	int error;
 
 	if (!vma_test(vma, VMA_GROWSUP_BIT))
 		return -EFAULT;
@@ -3149,12 +3221,14 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 
 	/* We must make sure the anon_vma is allocated. */
 	if (unlikely(anon_vma_prepare(vma))) {
-		vma_iter_free(&vmi);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto vma_prep_fail;
 	}
 
 	/* Lock the VMA before expanding to prevent concurrent page faults */
-	vma_start_write(vma);
+	error = vma_start_write_killable(vma);
+	if (error)
+		goto vma_lock_fail;
 	/* We update the anon VMA tree. */
 	anon_vma_lock_write(vma->anon_vma);
 
@@ -3183,8 +3257,10 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	vma_iter_free(&vmi);
 	validate_mm(mm);
+vma_lock_fail:
+vma_prep_fail:
+	vma_iter_free(&vmi);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP */
@@ -3197,8 +3273,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *prev;
-	int error = 0;
 	VMA_ITERATOR(vmi, mm, vma->vm_start);
+	int error;
 
 	if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 		return -EFAULT;
@@ -3228,12 +3304,14 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 
 	/* We must make sure the anon_vma is allocated. */
 	if (unlikely(anon_vma_prepare(vma))) {
-		vma_iter_free(&vmi);
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto vma_prep_fail;
 	}
 
 	/* Lock the VMA before expanding to prevent concurrent page faults */
-	vma_start_write(vma);
+	error = vma_start_write_killable(vma);
+	if (error)
+		goto vma_lock_fail;
 	/* We update the anon VMA tree. */
 	anon_vma_lock_write(vma->anon_vma);
 
@@ -3263,8 +3341,10 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	vma_iter_free(&vmi);
 	validate_mm(mm);
+vma_lock_fail:
+vma_prep_fail:
+	vma_iter_free(&vmi);
 	return error;
 }
 
diff --git a/mm/vma_exec.c b/mm/vma_exec.c
index 5cee8b7efa0f..8ddcc791d828 100644
--- a/mm/vma_exec.c
+++ b/mm/vma_exec.c
@@ -41,6 +41,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
 	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
+	int err;
 
 	BUG_ON(new_start > new_end);
 
@@ -56,8 +57,9 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	 * cover the whole range: [new_start, old_end)
 	 */
 	vmg.target = vma;
-	if (vma_expand(&vmg))
-		return -ENOMEM;
+	err = vma_expand(&vmg);
+	if (err)
+		return err;
 
 	/*
 	 * move the page tables downwards, on failure we rely on
-- 
2.53.0.1018.g2bb0e51243-goog

