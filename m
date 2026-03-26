Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F07385526;
	Thu, 26 Mar 2026 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547107; cv=none; b=qiQ0ekoxlxQmc+9N3sEWkae7I9j2W3jzFGC2TV8dbjEuaylWH8dQkVKPUTG7vDA/rUz11P+eVcB7pChbEVdR+rSZc9a9mwGLtNqNCx/Mb3vktg9FplPpVnV3lb3WiOLDcqOtUHjTdVq/A0eZeiNuT6i3TV1AxkBlPmyC/It6/eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547107; c=relaxed/simple;
	bh=w2b5+NfbcqkMBxY/qLqmZHPuyfFesG4+GS6tIl1Zybg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfh24x3l8tuTggC1qvZy8IsLlklWQEVBUXI46iUpRXVxHufZQ7sgZ5f7sfwlkOQw4jE2P54jBe/zIFLofbA8es/WFwstZWH78sfPRQCWtDwYfUmSTOTJH2wDgCMaQHIohDMmjgzlK4QrVdco2r/f28q771AHyp7ljJvNM0Bj+0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTA6AHCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTA6AHCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D585C116C6;
	Thu, 26 Mar 2026 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547107;
	bh=w2b5+NfbcqkMBxY/qLqmZHPuyfFesG4+GS6tIl1Zybg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTA6AHCrIkzwHpTaMtek81hjInOoZjZD/Bjd7dNN7DziyxTKKPUUYUL2kMJleQEQA
	 detkHRGuMTSOXRdXLrcCFq162S3nkqqmsu9O72gy456HS6/ut8OcKc0mYKais7XO04
	 gEmbL3rqh0ao1trGqrijXziKbSZcNof8jXDICqk5eTWQTP+zzD/ej8zUbOs3wRCSZE
	 6w6Vtf+5rYoLRKDRic8RhsMj8Z4kU4Xz6X/wOEWynBY4ehDb5UNKGitLsZvEZKF2je
	 GEUjsci6jsvPG+WlPd3Wr6DaahnnlQ/3Llq363jsCiQxLTJw0zFnfmP+h2B6Lb23kK
	 8htu7gMQV99Dw==
Date: Thu, 26 Mar 2026 17:45:04 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 4/6] mm/vma: use vma_start_write_killable() in vma
 operations
Message-ID: <3574764c-1cac-401c-9183-6bc3d2627587@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <20260326080836.695207-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326080836.695207-5-surenb@google.com>

On Thu, Mar 26, 2026 at 01:08:34AM -0700, Suren Baghdasaryan wrote:
> Replace vma_start_write() with vma_start_write_killable(), improving
> reaction time to the kill signal.
> Replace vma_start_write() calls when we operate on VMAs.
>
> In a number of places we now lock VMA earlier than before to avoid
> doing work and undoing it later if a fatal signal is pending. This
> is safe because the moves are happening within sections where we
> already hold the mmap_write_lock, so the moves do not change the
> locking order relative to other kernel locks.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/vma.c      | 130 +++++++++++++++++++++++++++++++++++++-------------
>  mm/vma_exec.c |   6 ++-
>  2 files changed, 101 insertions(+), 35 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index ba78ab1f397a..7ee68fbfea03 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -524,6 +524,17 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
>  	}
>
> +	/*
> +	 * Lock VMAs before cloning to avoid extra work if fatal signal
> +	 * is pending.
> +	 */
> +	err = vma_start_write_killable(vma);
> +	if (err)
> +		goto out_free_vma;
> +	err = vma_start_write_killable(new);
> +	if (err)
> +		goto out_free_vma;
> +
>  	err = -ENOMEM;
>  	vma_iter_config(vmi, new->vm_start, new->vm_end);
>  	if (vma_iter_prealloc(vmi, new))
> @@ -543,9 +554,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (new->vm_ops && new->vm_ops->open)
>  		new->vm_ops->open(new);
>
> -	vma_start_write(vma);
> -	vma_start_write(new);
> -
>  	init_vma_prep(&vp, vma);
>  	vp.insert = new;
>  	vma_prepare(&vp);
> @@ -900,12 +908,22 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>  	}
>
>  	/* No matter what happens, we will be adjusting middle. */
> -	vma_start_write(middle);
> +	err = vma_start_write_killable(middle);
> +	if (err) {
> +		/* Ensure error propagates. */

Thanks! I will come back to this and clean all this up later.

> +		vmg->give_up_on_oom = false;
> +		goto abort;
> +	}
>
>  	if (merge_right) {
>  		vma_flags_t next_sticky;
>
> -		vma_start_write(next);
> +		err = vma_start_write_killable(next);
> +		if (err) {
> +			/* Ensure error propagates. */
> +			vmg->give_up_on_oom = false;
> +			goto abort;
> +		}
>  		vmg->target = next;
>  		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
>  		vma_flags_set_mask(&sticky_flags, next_sticky);
> @@ -914,7 +932,12 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>  	if (merge_left) {
>  		vma_flags_t prev_sticky;
>
> -		vma_start_write(prev);
> +		err = vma_start_write_killable(prev);
> +		if (err) {
> +			/* Ensure error propagates. */
> +			vmg->give_up_on_oom = false;
> +			goto abort;
> +		}
>  		vmg->target = prev;
>
>  		prev_sticky = vma_flags_and_mask(&prev->flags, VMA_STICKY_FLAGS);
> @@ -1170,10 +1193,12 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	vma_flags_t sticky_flags =
>  		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
>  	vma_flags_t target_sticky;
> -	int err = 0;
> +	int err;
>
>  	mmap_assert_write_locked(vmg->mm);
> -	vma_start_write(target);
> +	err = vma_start_write_killable(target);
> +	if (err)
> +		return err;
>
>  	target_sticky = vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
>
> @@ -1201,6 +1226,13 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	 * we don't need to account for vmg->give_up_on_mm here.
>  	 */
>  	if (remove_next) {
> +		/*
> +		 * Lock the VMA early to avoid extra work if fatal signal
> +		 * is pending.
> +		 */
> +		err = vma_start_write_killable(next);
> +		if (err)
> +			return err;
>  		err = dup_anon_vma(target, next, &anon_dup);
>  		if (err)
>  			return err;
> @@ -1214,7 +1246,6 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	if (remove_next) {
>  		vma_flags_t next_sticky;
>
> -		vma_start_write(next);
>  		vmg->__remove_next = true;
>
>  		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
> @@ -1252,9 +1283,14 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	       unsigned long start, unsigned long end, pgoff_t pgoff)
>  {
>  	struct vma_prepare vp;
> +	int err;
>
>  	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
>
> +	err = vma_start_write_killable(vma);
> +	if (err)
> +		return err;
> +
>  	if (vma->vm_start < start)
>  		vma_iter_config(vmi, vma->vm_start, start);
>  	else
> @@ -1263,8 +1299,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_prealloc(vmi, NULL))
>  		return -ENOMEM;
>
> -	vma_start_write(vma);
> -
>  	init_vma_prep(&vp, vma);
>  	vma_prepare(&vp);
>  	vma_adjust_trans_huge(vma, start, end, NULL);
> @@ -1453,7 +1487,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  			if (error)
>  				goto end_split_failed;
>  		}
> -		vma_start_write(next);
> +		error = vma_start_write_killable(next);
> +		if (error)
> +			goto munmap_gather_failed;
>  		mas_set(mas_detach, vms->vma_count++);
>  		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
>  		if (error)
> @@ -1848,12 +1884,16 @@ static void vma_link_file(struct vm_area_struct *vma, bool hold_rmap_lock)
>  static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>  	VMA_ITERATOR(vmi, mm, 0);
> +	int err;
> +
> +	err = vma_start_write_killable(vma);
> +	if (err)
> +		return err;
>
>  	vma_iter_config(&vmi, vma->vm_start, vma->vm_end);
>  	if (vma_iter_prealloc(&vmi, vma))
>  		return -ENOMEM;
>
> -	vma_start_write(vma);
>  	vma_iter_store_new(&vmi, vma);
>  	vma_link_file(vma, /* hold_rmap_lock= */false);
>  	mm->map_count++;
> @@ -2239,9 +2279,8 @@ int mm_take_all_locks(struct mm_struct *mm)
>  	 * is reached.
>  	 */
>  	for_each_vma(vmi, vma) {
> -		if (signal_pending(current))
> +		if (signal_pending(current) || vma_start_write_killable(vma))
>  			goto out_unlock;
> -		vma_start_write(vma);
>  	}
>
>  	vma_iter_init(&vmi, mm, 0);
> @@ -2540,8 +2579,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>  	struct mmap_action *action)
>  {
>  	struct vma_iterator *vmi = map->vmi;
> -	int error = 0;
>  	struct vm_area_struct *vma;
> +	int error;
>
>  	/*
>  	 * Determine the object being mapped and call the appropriate
> @@ -2552,6 +2591,14 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>  	if (!vma)
>  		return -ENOMEM;
>
> +	/*
> +	 * Lock the VMA early to avoid extra work if fatal signal
> +	 * is pending.
> +	 */
> +	error = vma_start_write_killable(vma);
> +	if (error)
> +		goto free_vma;
> +
>  	vma_iter_config(vmi, map->addr, map->end);
>  	vma_set_range(vma, map->addr, map->end, map->pgoff);
>  	vma->flags = map->vma_flags;
> @@ -2582,8 +2629,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap,
>  	WARN_ON_ONCE(!arch_validate_flags(map->vm_flags));
>  #endif
>
> -	/* Lock the VMA since it is modified after insertion into VMA tree */
> -	vma_start_write(vma);
>  	vma_iter_store_new(vmi, vma);
>  	map->mm->map_count++;
>  	vma_link_file(vma, action->hide_from_rmap_until_complete);
> @@ -2878,6 +2923,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		 unsigned long addr, unsigned long len, vma_flags_t vma_flags)
>  {
>  	struct mm_struct *mm = current->mm;
> +	int err;
>
>  	/*
>  	 * Check against address space limits by the changed size
> @@ -2910,24 +2956,33 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>
>  		if (vma_merge_new_range(&vmg))
>  			goto out;
> -		else if (vmg_nomem(&vmg))
> +		if (vmg_nomem(&vmg)) {
> +			err = -ENOMEM;
>  			goto unacct_fail;
> +		}
>  	}
>
>  	if (vma)
>  		vma_iter_next_range(vmi);
>  	/* create a vma struct for an anonymous mapping */
>  	vma = vm_area_alloc(mm);
> -	if (!vma)
> +	if (!vma) {
> +		err = -ENOMEM;
>  		goto unacct_fail;
> +	}
>
>  	vma_set_anonymous(vma);
>  	vma_set_range(vma, addr, addr + len, addr >> PAGE_SHIFT);
>  	vma->flags = vma_flags;
>  	vma->vm_page_prot = vm_get_page_prot(vma_flags_to_legacy(vma_flags));
> -	vma_start_write(vma);
> -	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
> +	if (vma_start_write_killable(vma)) {
> +		err = -EINTR;
> +		goto vma_lock_fail;
> +	}
> +	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL)) {
> +		err = -ENOMEM;
>  		goto mas_store_fail;
> +	}
>
>  	mm->map_count++;
>  	validate_mm(mm);
> @@ -2942,10 +2997,11 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>
>  mas_store_fail:
> +vma_lock_fail:
>  	vm_area_free(vma);
>  unacct_fail:
>  	vm_unacct_memory(len >> PAGE_SHIFT);
> -	return -ENOMEM;
> +	return err;
>  }
>
>  /**
> @@ -3112,8 +3168,8 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct *next;
>  	unsigned long gap_addr;
> -	int error = 0;
>  	VMA_ITERATOR(vmi, mm, vma->vm_start);
> +	int error;
>
>  	if (!vma_test(vma, VMA_GROWSUP_BIT))
>  		return -EFAULT;
> @@ -3149,12 +3205,14 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>
>  	/* We must make sure the anon_vma is allocated. */
>  	if (unlikely(anon_vma_prepare(vma))) {
> -		vma_iter_free(&vmi);
> -		return -ENOMEM;
> +		error = -ENOMEM;
> +		goto vma_prep_fail;
>  	}
>
>  	/* Lock the VMA before expanding to prevent concurrent page faults */
> -	vma_start_write(vma);
> +	error = vma_start_write_killable(vma);
> +	if (error)
> +		goto vma_lock_fail;
>  	/* We update the anon VMA tree. */
>  	anon_vma_lock_write(vma->anon_vma);
>
> @@ -3183,8 +3241,10 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  		}
>  	}
>  	anon_vma_unlock_write(vma->anon_vma);
> -	vma_iter_free(&vmi);
>  	validate_mm(mm);
> +vma_lock_fail:
> +vma_prep_fail:
> +	vma_iter_free(&vmi);
>  	return error;
>  }
>  #endif /* CONFIG_STACK_GROWSUP */
> @@ -3197,8 +3257,8 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct *prev;
> -	int error = 0;
>  	VMA_ITERATOR(vmi, mm, vma->vm_start);
> +	int error;
>
>  	if (!vma_test(vma, VMA_GROWSDOWN_BIT))
>  		return -EFAULT;
> @@ -3228,12 +3288,14 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>
>  	/* We must make sure the anon_vma is allocated. */
>  	if (unlikely(anon_vma_prepare(vma))) {
> -		vma_iter_free(&vmi);
> -		return -ENOMEM;
> +		error = -ENOMEM;
> +		goto vma_prep_fail;
>  	}
>
>  	/* Lock the VMA before expanding to prevent concurrent page faults */
> -	vma_start_write(vma);
> +	error = vma_start_write_killable(vma);
> +	if (error)
> +		goto vma_lock_fail;
>  	/* We update the anon VMA tree. */
>  	anon_vma_lock_write(vma->anon_vma);
>
> @@ -3263,8 +3325,10 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  		}
>  	}
>  	anon_vma_unlock_write(vma->anon_vma);
> -	vma_iter_free(&vmi);
>  	validate_mm(mm);
> +vma_lock_fail:
> +vma_prep_fail:
> +	vma_iter_free(&vmi);
>  	return error;
>  }
>
> diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> index 5cee8b7efa0f..8ddcc791d828 100644
> --- a/mm/vma_exec.c
> +++ b/mm/vma_exec.c
> @@ -41,6 +41,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	struct vm_area_struct *next;
>  	struct mmu_gather tlb;
>  	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
> +	int err;
>
>  	BUG_ON(new_start > new_end);
>
> @@ -56,8 +57,9 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	 * cover the whole range: [new_start, old_end)
>  	 */
>  	vmg.target = vma;
> -	if (vma_expand(&vmg))
> -		return -ENOMEM;
> +	err = vma_expand(&vmg);
> +	if (err)
> +		return err;
>
>  	/*
>  	 * move the page tables downwards, on failure we rely on
> --
> 2.53.0.1018.g2bb0e51243-goog
>
