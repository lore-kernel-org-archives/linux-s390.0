Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15B37F00A
	for <linux-s390@vger.kernel.org>; Sun, 22 Mar 2026 05:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774158200; cv=none; b=i82DVeYahwz+4e1UvdQzhXCQNcKcjxYhzIVXkSAJaTwxlBI3vxCW7Uawi8eZMUeg4Veb1ZGq+UDlKeqPg8ti7oLeEx4fSHhqCz1nAIYpFqkk7FCxHSAuerEZwmVQclvAsMaMNhzRxXvEjJIvJ3v1o5ZE9rEbagdJwP2MMK6GCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774158200; c=relaxed/simple;
	bh=DNY0X+PcFJlfUy4fhmHQZAJ9FKzE935dP7hKIXQ2fFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTJeB3MzT5pFQWbbXn8m5xjU5DLlPLPSm2NdTSQzqaKTbK1BeN9kqLGS7+FiU7fgSp+NOqHNT/OKXjM9mWbLfqXLleObZOM2czNw0oxmjz2c7UAK3A2qiQQCrX84NwnCtTm4vS0uymNTnCYYufL++M5CLGv7/9q6pPNOJzwqkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVDAN8pD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVDAN8pD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128ba70cc99so2277559c88.0
        for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 22:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774158197; x=1774762997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5b6oMhN2dhkfmGBpy5mRDDv5v06S/XLpgPev0I+15w=;
        b=iVDAN8pDXGMxGLS8mR+t7P0WbXPZDzP0X7I8EOhsmYRF8dkZV27TacokDlCyW2yVPG
         y7BDXWJyOYtGbAUg0/XOQmJO9DUoP2u9NuEeDIYfahhP8M14hfOzz2x9lexOj47Gm6mS
         J7hBhcdjmhgdBudr/tK/wDz3sYRbUHN3cLfJGgHrXcstbSCwSjyYuAPqCN1PHC1Ln+UX
         f1GnFL9RHNMIAf+EGw8mosGgJFUCZ1nSWe7l1d/KkBVxVMitXr4FBdwRKxcEBHmpWEdS
         sQe52zSTqm/4MSNKY6NLEeUT3+WpLHjtJIfuBfU+ihyheWywQ9xTg8seL0wIXuWgQ1kK
         C+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774158197; x=1774762997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5b6oMhN2dhkfmGBpy5mRDDv5v06S/XLpgPev0I+15w=;
        b=pebfenvgbkQ1RwfPg3ob5fZk8DzPKgQR6sJTo63aeujVwwjupcOiRfFS/d+LS1hzMY
         u+j45aw8evdRlX50nHvU+fHDtmCkew2rzzEegVtvgv0HNO6CVYIQUVipqt/HBRo9mrm+
         mZYiIVT9livakWFdusTI5fFkaq2xBemO4uSXPCTMYjGdJF3jjIIfjrKCrxIrwuSqOLN1
         g93dJ5wgByoqHWBq3gZ6ritCX9jhuPhjOxXT1GYRmDp5hkQ73dhi2VXvPa2QGRTZZi6v
         +J7FGYqf7ga351gRtksvEvntrtbMukkMpYghnV53lNX9+7Z9fWyZvbXwUpxTJtTWbqbH
         cVqw==
X-Forwarded-Encrypted: i=1; AJvYcCVozGWY0qirYwqeOWMCnfcLl4wa2osa8yzl77uKhJqAESUWGuw924jsUpc3Rlxjs2hPHwevICx2ajjO@vger.kernel.org
X-Gm-Message-State: AOJu0YxsosAOmf6zOy6CABG6ob7C53GF2Asvq9WbGNjlkD37t9pEBwlG
	jYJWQ97asxuNtOGQHWCw4vyxDgQVMbsWO4Y9dN+QPlJ5gncrvVcswPjEM+GThTADzVVq+4e4a8Y
	c+PU0nw==
X-Received: from dlbts5-n2.prod.google.com ([2002:a05:7022:b045:20b0:12a:7c27:8e88])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2591:b0:127:5c54:a124
 with SMTP id a92af1059eb24-12a726db50fmr3890614c88.31.1774158197165; Sat, 21
 Mar 2026 22:43:17 -0700 (PDT)
Date: Sat, 21 Mar 2026 22:43:06 -0700
In-Reply-To: <20260322054309.898214-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260322054309.898214-3-surenb@google.com>
Subject: [PATCH v4 2/4] mm: replace vma_start_write() with vma_start_write_killable()
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
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that we have vma_start_write_killable() we can replace most of the
vma_start_write() calls with it, improving reaction time to the kill
signal.

There are several places which are left untouched by this patch:

1. free_pgtables() because function should free page tables even if a
fatal signal is pending.

2. process_vma_walk_lock(), which requires changes in its callers and
will be handled in the next patch.

3. userfaultd code, where some paths calling vma_start_write() can
handle EINTR and some can't without a deeper code refactoring.

4. mpol_rebind_mm() which is used by cpuset controller for migrations
and operates on a remote mm. Incomplete operations here would result
in an inconsistent cgroup state.

5. vm_flags_{set|mod|clear} require refactoring that involves moving
vma_start_write() out of these functions and replacing it with
vma_assert_write_locked(), then callers of these functions should
lock the vma themselves using vma_start_write_killable() whenever
possible.

In a number of places we now lock VMA earlier than before to avoid
doing work and undoing it later if a fatal signal is pending. This
is safe because the moves are happening within sections where we
already hold the mmap_write_lock, so the moves do not change the
locking order relative to other kernel locks.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> # powerpc
---
 arch/powerpc/kvm/book3s_hv_uvmem.c |   5 +-
 mm/khugepaged.c                    |   5 +-
 mm/madvise.c                       |   4 +-
 mm/memory.c                        |   2 +
 mm/mempolicy.c                     |  12 ++-
 mm/mlock.c                         |  28 +++++--
 mm/mprotect.c                      |   5 +-
 mm/mremap.c                        |   4 +-
 mm/vma.c                           | 117 +++++++++++++++++++++--------
 mm/vma_exec.c                      |   6 +-
 10 files changed, 142 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5fbb95d90e99..0a28b48a46b8 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -410,7 +410,10 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
-		vma_start_write(vma);
+		if (vma_start_write_killable(vma)) {
+			ret = H_STATE;
+			break;
+		}
 		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
 		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4b0e59c7c0e6..e2f263076084 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1159,7 +1159,10 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma)) {
+		result = SCAN_FAIL;
+		goto out_up_write;
+	}
 	result = check_pmd_still_valid(mm, address, pmd);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
diff --git a/mm/madvise.c b/mm/madvise.c
index 69708e953cf5..feaa16b0e1dc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -175,7 +175,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
 	madv_behavior->vma = vma;
 
 	/* vm_flags is protected by the mmap_lock held in write mode. */
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma))
+		return -EINTR;
+
 	vma->flags = new_vma_flags;
 	if (set_new_anon_name)
 		return replace_anon_vma_name(vma, anon_name);
diff --git a/mm/memory.c b/mm/memory.c
index 68cc592ff0ba..b930459e32ec 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -366,6 +366,8 @@ void free_pgd_range(struct mmu_gather *tlb,
  * page tables that should be removed.  This can differ from the vma mappings on
  * some archs that may have mappings that need to be removed outside the vmas.
  * Note that the prev->vm_end and next->vm_start are often used.
+ * We don't use vma_start_write_killable() because page tables should be freed
+ * even if the task is being killed.
  *
  * The vma_end differs from the pg_end when a dup_mmap() failed and the tree has
  * unrelated data to the mm_struct being torn down.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e5528c35bbb8..929e843543cf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1784,7 +1784,8 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		return -EINVAL;
 	if (end == start)
 		return 0;
-	mmap_write_lock(mm);
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
 	prev = vma_prev(&vmi);
 	for_each_vma_range(vmi, vma, end) {
 		/*
@@ -1801,13 +1802,20 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 			err = -EOPNOTSUPP;
 			break;
 		}
+		/*
+		 * Lock the VMA early to avoid extra work if fatal signal
+		 * is pending.
+		 */
+		if (vma_start_write_killable(vma)) {
+			err = -EINTR;
+			break;
+		}
 		new = mpol_dup(old);
 		if (IS_ERR(new)) {
 			err = PTR_ERR(new);
 			break;
 		}
 
-		vma_start_write(vma);
 		new->home_node = home_node;
 		err = mbind_range(&vmi, vma, &prev, start, end, new);
 		mpol_put(new);
diff --git a/mm/mlock.c b/mm/mlock.c
index 8c227fefa2df..efbb9c783f25 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -419,8 +419,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
  *
  * Called for mlock(), mlock2() and mlockall(), to set @vma VM_LOCKED;
  * called for munlock() and munlockall(), to clear VM_LOCKED from @vma.
+ *
+ * Return: 0 on success, -EINTR if fatal signal is pending.
  */
-static void mlock_vma_pages_range(struct vm_area_struct *vma,
+static int mlock_vma_pages_range(struct vm_area_struct *vma,
 	unsigned long start, unsigned long end,
 	vma_flags_t *new_vma_flags)
 {
@@ -442,7 +444,9 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
 		vma_flags_set(new_vma_flags, VMA_IO_BIT);
-	vma_start_write(vma);
+	if (vma_start_write_killable(vma))
+		return -EINTR;
+
 	vma_flags_reset_once(vma, new_vma_flags);
 
 	lru_add_drain();
@@ -453,6 +457,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 		vma_flags_clear(new_vma_flags, VMA_IO_BIT);
 		vma_flags_reset_once(vma, new_vma_flags);
 	}
+	return 0;
 }
 
 /*
@@ -506,11 +511,13 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 	if (vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT) &&
 	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT)) {
+		ret = vma_start_write_killable(vma);
+		if (ret)
+			goto out;
 		/* No work to do, and mlocking twice would be wrong */
-		vma_start_write(vma);
 		vma->flags = new_vma_flags;
 	} else {
-		mlock_vma_pages_range(vma, start, end, &new_vma_flags);
+		ret = mlock_vma_pages_range(vma, start, end, &new_vma_flags);
 	}
 out:
 	*prev = vma;
@@ -739,9 +746,18 @@ static int apply_mlockall_flags(int flags)
 
 		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
 				    newflags);
-		/* Ignore errors, but prev needs fixing up. */
-		if (error)
+		if (error) {
+			/*
+			 * If we failed due to a pending fatal signal, return
+			 * now. If we locked the vma before signal arrived, it
+			 * will be unlocked when we drop mmap_write_lock.
+			 */
+			if (fatal_signal_pending(current))
+				return -EINTR;
+
+			/* Ignore errors, but prev needs fixing up. */
 			prev = vma;
+		}
 		cond_resched();
 	}
 out:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 110d47a36d4b..ae6ed882b600 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -768,7 +768,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
 	 */
-	vma_start_write(vma);
+	error = vma_start_write_killable(vma);
+	if (error)
+		goto fail;
+
 	vma_flags_reset_once(vma, &new_vma_flags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
diff --git a/mm/mremap.c b/mm/mremap.c
index e9c8b1d05832..dec39ec314f9 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1356,7 +1356,9 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 		return -ENOMEM;
 
 	/* We don't want racing faults. */
-	vma_start_write(vrm->vma);
+	err = vma_start_write_killable(vrm->vma);
+	if (err)
+		return err;
 
 	/* Perform copy step. */
 	err = copy_vma_and_data(vrm, &new_vma);
diff --git a/mm/vma.c b/mm/vma.c
index ba78ab1f397a..7930a4270eb9 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -524,6 +524,17 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
+	/*
+	 * Lock VMAs before cloning to avoid extra work if fatal signal
+	 * is pending.
+	 */
+	err = vma_start_write_killable(vma);
+	if (err)
+		goto out_free_vma;
+	err = vma_start_write_killable(new);
+	if (err)
+		goto out_free_vma;
+
 	err = -ENOMEM;
 	vma_iter_config(vmi, new->vm_start, new->vm_end);
 	if (vma_iter_prealloc(vmi, new))
@@ -543,9 +554,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	vma_start_write(vma);
-	vma_start_write(new);
-
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
@@ -900,12 +908,16 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	}
 
 	/* No matter what happens, we will be adjusting middle. */
-	vma_start_write(middle);
+	err = vma_start_write_killable(middle);
+	if (err)
+		goto abort;
 
 	if (merge_right) {
 		vma_flags_t next_sticky;
 
-		vma_start_write(next);
+		err = vma_start_write_killable(next);
+		if (err)
+			goto abort;
 		vmg->target = next;
 		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
 		vma_flags_set_mask(&sticky_flags, next_sticky);
@@ -914,7 +926,9 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (merge_left) {
 		vma_flags_t prev_sticky;
 
-		vma_start_write(prev);
+		err = vma_start_write_killable(prev);
+		if (err)
+			goto abort;
 		vmg->target = prev;
 
 		prev_sticky = vma_flags_and_mask(&prev->flags, VMA_STICKY_FLAGS);
@@ -1170,10 +1184,12 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vma_flags_t sticky_flags =
 		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
 	vma_flags_t target_sticky;
-	int err = 0;
+	int err;
 
 	mmap_assert_write_locked(vmg->mm);
-	vma_start_write(target);
+	err = vma_start_write_killable(target);
+	if (err)
+		return err;
 
 	target_sticky = vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
 
@@ -1201,6 +1217,13 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
 	if (remove_next) {
+		/*
+		 * Lock the VMA early to avoid extra work if fatal signal
+		 * is pending.
+		 */
+		err = vma_start_write_killable(next);
+		if (err)
+			return err;
 		err = dup_anon_vma(target, next, &anon_dup);
 		if (err)
 			return err;
@@ -1214,7 +1237,6 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (remove_next) {
 		vma_flags_t next_sticky;
 
-		vma_start_write(next);
 		vmg->__remove_next = true;
 
 		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
@@ -1252,9 +1274,14 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
@@ -1263,8 +1290,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi, NULL))
 		return -ENOMEM;
 
-	vma_start_write(vma);
-
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, NULL);
@@ -1453,7 +1478,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
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
@@ -1848,12 +1875,16 @@ static void vma_link_file(struct vm_area_struct *vma, bool hold_rmap_lock)
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
@@ -2239,9 +2270,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 	 * is reached.
 	 */
 	for_each_vma(vmi, vma) {
-		if (signal_pending(current))
+		if (signal_pending(current) || vma_start_write_killable(vma))
 			goto out_unlock;
-		vma_start_write(vma);
 	}
 
 	vma_iter_init(&vmi, mm, 0);
@@ -2540,8 +2570,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	struct mmap_action *action)
 {
 	struct vma_iterator *vmi = map->vmi;
-	int error = 0;
 	struct vm_area_struct *vma;
+	int error;
 
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2552,6 +2582,14 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
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
@@ -2582,8 +2620,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
 	WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
 #endif
 
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
 	vma_iter_store_new(vmi, vma);
 	map->mm->map_count++;
 	vma_link_file(vma, action->hide_from_rmap_until_complete);
@@ -2878,6 +2914,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		 unsigned long addr, unsigned long len, vma_flags_t vma_flags)
 {
 	struct mm_struct *mm = current->mm;
+	int err;
 
 	/*
 	 * Check against address space limits by the changed size
@@ -2910,24 +2947,33 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
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
@@ -2942,10 +2988,11 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
@@ -3112,8 +3159,8 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
-	int error = 0;
 	VMA_ITERATOR(vmi, mm, vma->vm_start);
+	int error;
 
 	if (!vma_test(vma, VMA_GROWSUP_BIT))
 		return -EFAULT;
@@ -3149,12 +3196,14 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 
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
 
@@ -3183,6 +3232,8 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
+vma_lock_fail:
+vma_prep_fail:
 	vma_iter_free(&vmi);
 	validate_mm(mm);
 	return error;
@@ -3197,8 +3248,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *prev;
-	int error = 0;
 	VMA_ITERATOR(vmi, mm, vma->vm_start);
+	int error;
 
 	if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 		return -EFAULT;
@@ -3228,12 +3279,14 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 
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
 
@@ -3263,6 +3316,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
+vma_lock_fail:
+vma_prep_fail:
 	vma_iter_free(&vmi);
 	validate_mm(mm);
 	return error;
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

