Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2C37AA9E;
	Tue, 31 Mar 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949749; cv=none; b=Wf984kiO7pIRO9+ED6DqH4WsjXVA5GtLV6gopZhnC/SU+kaUlf5HcdeSbhdQeuqJpsxu6d8MoDlMJONya+oAnBpZUgK+gzQX81UWrROsrJIFJk9qagn2LkNbjkd12XhuOGSqRC7CaHHgikqIkM91ZZo6oLSdSJpcwX8flFgxr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949749; c=relaxed/simple;
	bh=QjbGnsBbsYu8AXy/HwbuH+528+5xrd5qo/0bIOJymqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqiBqOk8rNuWEk2IGA0PvJLTjEzt0QeJCRN6P4y7o0vyqXlVjwyzMrv8wP8JRVMTAlt/D83uQIIj2afvmtfoi+KT0GzKZlLRpD3BfTpku29Vx0mmNm+N4BpYHIFWsSHAceZBHJeFd8xgJprW8p3sA+wi9P54AJnqvn5Vp8BAqZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfqe69hd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfqe69hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7708EC19423;
	Tue, 31 Mar 2026 09:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949749;
	bh=QjbGnsBbsYu8AXy/HwbuH+528+5xrd5qo/0bIOJymqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mfqe69hdpWppLKx9XJfxUeg28uOg70RVdflcA7ip7g8dxBdzR1M+a5VlfPHE78yyd
	 mMsnQbvo2r3TfLNWrq0ztp9IPpB1HY6O/065w898RgLOfHlkk0lQO3C3P3rnPGRaSQ
	 6cD0dEQZaVz+8Ak0SrRBkDC0IRBi6GSzTIoK8eq7m314BQZyX7TM0D2ZwEUdPiRQ3I
	 nW/hDj9S/R3fWNCwZGexGRAtbCTAZ3UuvVKibfX01Qy9vmGi9Yqv8a47uQtJXnbzEl
	 Xe4sRLN/vLHsydEOWhWnOp8YgtUeeMiiX0l/UbcWcvGMgYhnLYoRKD36jHfhVo83PH
	 82BWtU8EfN5eg==
Date: Tue, 31 Mar 2026 10:35:47 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
Message-ID: <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
References: <20260327205457.604224-1-surenb@google.com>
 <20260327205457.604224-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327205457.604224-3-surenb@google.com>

On Fri, Mar 27, 2026 at 01:54:53PM -0700, Suren Baghdasaryan wrote:
> Replace vma_start_write() with vma_start_write_killable() in syscalls,
> improving reaction time to the kill signal.
>
> In a number of places we now lock VMA earlier than before to avoid
> doing work and undoing it later if a fatal signal is pending. This
> is safe because the moves are happening within sections where we
> already hold the mmap_write_lock, so the moves do not change the
> locking order relative to other kernel locks.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I think Sashiko (presumably) has regressed this series :/

> ---
>  mm/madvise.c   | 13 ++++++++++---
>  mm/memory.c    |  2 ++
>  mm/mempolicy.c | 11 +++++++++--
>  mm/mlock.c     | 30 ++++++++++++++++++++++++------
>  mm/mprotect.c  | 25 +++++++++++++++++--------
>  mm/mremap.c    |  8 +++++---
>  mm/mseal.c     | 24 +++++++++++++++++++-----
>  7 files changed, 86 insertions(+), 27 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 69708e953cf5..f2c7b0512cdf 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -172,10 +172,17 @@ static int madvise_update_vma(vm_flags_t new_flags,
>  	if (IS_ERR(vma))
>  		return PTR_ERR(vma);
>
> -	madv_behavior->vma = vma;
> +	/*
> +	 * If a new vma was created during vma_modify_XXX, the resulting
> +	 * vma is already locked. Skip re-locking new vma in this case.
> +	 */

well you're not re-locking, in vma_start_write_killable() we have:

	if (__is_vma_write_locked(vma))
		return 0;

So I'm not sure this is really worth the effort? Was this a sashiko 'find'?

And is 're-locking' the right thing to say here? Probably nitty but that to me
implies you're locking again when in fact you're just calling the function only
to check seq nums uselessly and have a nop.

But it's not like we're on a hotpath here where we're sweating every little
thing, we're already taking the mmap write lock and doing heavy operations
etc. so not sure we care all that much.

OTOH, it's hardly like this is a bad thing so don't want to hold up series.

> +	if (vma == madv_behavior->vma) {
> +		if (vma_start_write_killable(vma))
> +			return -EINTR;
> +	} else {
> +		madv_behavior->vma = vma;
> +	}

This is kind of ugly.

Can't we just do:

	const struct vm_area_struct *old_vma = madv_behavior->vma;
	struct vm_area_struct *vma = old_vma;

...
	madv_behavior->vma = vma;
	/* If the VMA didn't change, it isn't locked yet. */
	if (vma == old_vma && vma_start_write_killable(vma))
		return -EINTR;

Instead? That is, assuming we really need to care about this at all.

But I think I don't like this change at all?

>
> -	/* vm_flags is protected by the mmap_lock held in write mode. */
> -	vma_start_write(vma);
>  	vma->flags = new_vma_flags;
>  	if (set_new_anon_name)
>  		return replace_anon_vma_name(vma, anon_name);
> diff --git a/mm/memory.c b/mm/memory.c
> index e44469f9cf65..9f99ec634831 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -366,6 +366,8 @@ void free_pgd_range(struct mmu_gather *tlb,
>   * page tables that should be removed.  This can differ from the vma mappings on
>   * some archs that may have mappings that need to be removed outside the vmas.
>   * Note that the prev->vm_end and next->vm_start are often used.
> + * We don't use vma_start_write_killable() because page tables should be freed
> + * even if the task is being killed.
>   *
>   * The vma_end differs from the pg_end when a dup_mmap() failed and the tree has
>   * unrelated data to the mm_struct being torn down.
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index fd08771e2057..c38a90487531 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1784,7 +1784,8 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
>  		return -EINVAL;
>  	if (end == start)
>  		return 0;
> -	mmap_write_lock(mm);
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
>  	prev = vma_prev(&vmi);
>  	for_each_vma_range(vmi, vma, end) {
>  		/*
> @@ -1801,13 +1802,19 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
>  			err = -EOPNOTSUPP;
>  			break;
>  		}
> +		/*
> +		 * Lock the VMA early to avoid extra work if fatal signal
> +		 * is pending.
> +		 */
> +		err = vma_start_write_killable(vma);
> +		if (err)
> +			break;
>  		new = mpol_dup(old);
>  		if (IS_ERR(new)) {
>  			err = PTR_ERR(new);
>  			break;
>  		}
>
> -		vma_start_write(vma);
>  		new->home_node = home_node;
>  		err = mbind_range(&vmi, vma, &prev, start, end, new);
>  		mpol_put(new);
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 8c227fefa2df..2ed454db7cf7 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -419,8 +419,10 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>   *
>   * Called for mlock(), mlock2() and mlockall(), to set @vma VM_LOCKED;
>   * called for munlock() and munlockall(), to clear VM_LOCKED from @vma.
> + *
> + * Return: 0 on success, -EINTR if fatal signal is pending.
>   */
> -static void mlock_vma_pages_range(struct vm_area_struct *vma,
> +static int mlock_vma_pages_range(struct vm_area_struct *vma,
>  	unsigned long start, unsigned long end,
>  	vma_flags_t *new_vma_flags)
>  {
> @@ -442,7 +444,9 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  	 */
>  	if (vma_flags_test(new_vma_flags, VMA_LOCKED_BIT))
>  		vma_flags_set(new_vma_flags, VMA_IO_BIT);
> -	vma_start_write(vma);
> +	if (vma_start_write_killable(vma))
> +		return -EINTR;
> +
>  	vma_flags_reset_once(vma, new_vma_flags);
>
>  	lru_add_drain();
> @@ -453,6 +457,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  		vma_flags_clear(new_vma_flags, VMA_IO_BIT);
>  		vma_flags_reset_once(vma, new_vma_flags);
>  	}
> +	return 0;
>  }
>
>  /*
> @@ -506,11 +511,15 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	if (vma_flags_test(&new_vma_flags, VMA_LOCKED_BIT) &&
>  	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT)) {
> +		ret = vma_start_write_killable(vma);
> +		if (ret)
> +			goto out; /* mm->locked_vm is fine as nr_pages == 0 */
>  		/* No work to do, and mlocking twice would be wrong */
> -		vma_start_write(vma);
>  		vma->flags = new_vma_flags;
>  	} else {
> -		mlock_vma_pages_range(vma, start, end, &new_vma_flags);
> +		ret = mlock_vma_pages_range(vma, start, end, &new_vma_flags);
> +		if (ret)
> +			mm->locked_vm -= nr_pages;
>  	}
>  out:
>  	*prev = vma;
> @@ -739,9 +748,18 @@ static int apply_mlockall_flags(int flags)
>
>  		error = mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
>  				    newflags);
> -		/* Ignore errors, but prev needs fixing up. */
> -		if (error)
> +		if (error) {
> +			/*
> +			 * If we failed due to a pending fatal signal, return
> +			 * now. If we locked the vma before signal arrived, it
> +			 * will be unlocked when we drop mmap_write_lock.
> +			 */
> +			if (fatal_signal_pending(current))
> +				return -EINTR;
> +
> +			/* Ignore errors, but prev needs fixing up. */
>  			prev = vma;
> +		}
>  		cond_resched();
>  	}
>  out:
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 110d47a36d4b..d6227877465f 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -700,6 +700,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	const vma_flags_t old_vma_flags = READ_ONCE(vma->flags);
>  	vma_flags_t new_vma_flags = legacy_to_vma_flags(newflags);
>  	long nrpages = (end - start) >> PAGE_SHIFT;
> +	struct vm_area_struct *new_vma;
>  	unsigned int mm_cp_flags = 0;
>  	unsigned long charged = 0;
>  	int error;
> @@ -756,19 +757,27 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  		vma_flags_clear(&new_vma_flags, VMA_ACCOUNT_BIT);
>  	}
>
> -	vma = vma_modify_flags(vmi, *pprev, vma, start, end, &new_vma_flags);
> -	if (IS_ERR(vma)) {
> -		error = PTR_ERR(vma);
> +	new_vma = vma_modify_flags(vmi, *pprev, vma, start, end,
> +				   &new_vma_flags);
> +	if (IS_ERR(new_vma)) {
> +		error = PTR_ERR(new_vma);
>  		goto fail;
>  	}
>
> -	*pprev = vma;
> -
>  	/*
> -	 * vm_flags and vm_page_prot are protected by the mmap_lock
> -	 * held in write mode.
> +	 * If a new vma was created during vma_modify_flags, the resulting
> +	 * vma is already locked. Skip re-locking new vma in this case.
>  	 */
> -	vma_start_write(vma);
> +	if (new_vma == vma) {
> +		error = vma_start_write_killable(vma);
> +		if (error)
> +			goto fail;
> +	} else {
> +		vma = new_vma;
> +	}

I mean again this is hideous and I don't know why we're bothering? This just
introduces even more open-coded VMA lock specific stuff everywhere.

And the comment is just not correct, we're not re-locking anything if it's
already locked...

> +
> +	*pprev = vma;
> +
>  	vma_flags_reset_once(vma, &new_vma_flags);
>  	if (vma_wants_manual_pte_write_upgrade(vma))
>  		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e9c8b1d05832..0860102bddab 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1348,6 +1348,11 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
>  	if (err)
>  		return err;
>
> +	/* We don't want racing faults. */
> +	err = vma_start_write_killable(vrm->vma);
> +	if (err)
> +		return err;
> +
>  	/*
>  	 * If accounted, determine the number of bytes the operation will
>  	 * charge.
> @@ -1355,9 +1360,6 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
>  	if (!vrm_calc_charge(vrm))
>  		return -ENOMEM;
>
> -	/* We don't want racing faults. */
> -	vma_start_write(vrm->vma);
> -
>  	/* Perform copy step. */
>  	err = copy_vma_and_data(vrm, &new_vma);
>  	/*
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 603df53ad267..1ea19fd3d384 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -70,14 +70,28 @@ static int mseal_apply(struct mm_struct *mm,
>
>  		if (!vma_test(vma, VMA_SEALED_BIT)) {
>  			vma_flags_t vma_flags = vma->flags;
> +			struct vm_area_struct *new_vma;
>
>  			vma_flags_set(&vma_flags, VMA_SEALED_BIT);
>
> -			vma = vma_modify_flags(&vmi, prev, vma, curr_start,
> -					       curr_end, &vma_flags);
> -			if (IS_ERR(vma))
> -				return PTR_ERR(vma);
> -			vma_start_write(vma);
> +			new_vma = vma_modify_flags(&vmi, prev, vma, curr_start,
> +						   curr_end, &vma_flags);
> +			if (IS_ERR(new_vma))
> +				return PTR_ERR(new_vma);
> +
> +			/*
> +			 * If a new vma was created during vma_modify_flags,
> +			 * the resulting vma is already locked.
> +			 * Skip re-locking new vma in this case.
> +			 */
> +			if (new_vma == vma) {
> +				int err = vma_start_write_killable(vma);
> +				if (err)
> +					return err;
> +			} else {
> +				vma = new_vma;
> +			}
> +

I mean this is the exact same open-coded block all over this patch, and again I
don't see the point...

The VMA locking is tricky enough that I don't think doing this is a good idea,
especially on the basis of 'avoid looking at sequence numbers under mmap write
lock' or something.

>  			vma_set_flags(vma, VMA_SEALED_BIT);
>  		}
>
> --
> 2.53.0.1018.g2bb0e51243-goog
>
