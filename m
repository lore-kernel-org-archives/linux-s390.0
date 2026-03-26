Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58138F25E;
	Thu, 26 Mar 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546219; cv=none; b=t+ufKa1H/7cmQUzocWDfxXjxHfNEXK0CWF6fnY5S1w7r2kiGA0Q1D4CsITWr1XKoZGxwEa5LFwQyKms8PlTho4Wdm6EisWLSDprRD97JLbiMdfRVdWZfNtISCg1G8YT1RHKeMgywFSxt7oBtUW/lkHu56BG58hxx3odv5sytY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546219; c=relaxed/simple;
	bh=4B6IWxmcxmMnOxoBKxZipB+l8hxN/7ccnuWwqYeudjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0FznXFsvH/So69SxBX+GYaH3IFAq24A4WHnAb2MT9KuAllH2bKgNEuzhEgh2QX4nlRLv2AuwKo4q84u0qINpLcQ4Anh8fi+5hr/fbE5dr5O+Q/rmkGplDwRrrEFuNLDe3UOG0k9/ZfMM+akXCVRB5G8lgK3NgScN7IBexUaLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPEn2foH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPEn2foH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24D5C19423;
	Thu, 26 Mar 2026 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774546219;
	bh=4B6IWxmcxmMnOxoBKxZipB+l8hxN/7ccnuWwqYeudjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPEn2foHPCEzJ7DeO/tSryyi/zFWpbx/VuvZycUgOtYqpauG1SBu9gTe8uzv/oOMl
	 eFgZqH/AxXoDbch0Tex8vszosgZLbtCbcZLeAt6j/o6/79wo6Gr06rYnctFY3Ech6q
	 Ml+l/xnWPe9Rye0Rj8aEqYBGxNLHX6YsAxboenQhbot3tAaPfkAFbNZm+0a2y+V9ON
	 MOAH7ElbYaTnr6fchNZDZ/OIHsAlZaV0RelhrHw70ayI2kY7YsgW+AwKOrUYaZxifm
	 sTbUF7qyXypzkFYGWGPuNsDlIleF3JK01J4wG8nLfukFvvzXeW8SL0e5wzblW6NRdO
	 JFbwnASOjjm0w==
Date: Thu, 26 Mar 2026 17:30:17 +0000
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
Subject: Re: [PATCH v5 2/6] mm: use vma_start_write_killable() in mm syscalls
Message-ID: <292e3a7e-44c8-448c-8381-a0bb7cd32dde@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <20260326080836.695207-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326080836.695207-3-surenb@google.com>

On Thu, Mar 26, 2026 at 01:08:32AM -0700, Suren Baghdasaryan wrote:
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

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/madvise.c   |  4 +++-
>  mm/memory.c    |  2 ++
>  mm/mempolicy.c | 11 +++++++++--
>  mm/mlock.c     | 28 ++++++++++++++++++++++------
>  mm/mprotect.c  |  5 ++++-
>  mm/mremap.c    |  8 +++++---
>  mm/mseal.c     |  5 ++++-
>  7 files changed, 49 insertions(+), 14 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 69708e953cf5..feaa16b0e1dc 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -175,7 +175,9 @@ static int madvise_update_vma(vm_flags_t new_flags,
>  	madv_behavior->vma = vma;
>
>  	/* vm_flags is protected by the mmap_lock held in write mode. */
> -	vma_start_write(vma);
> +	if (vma_start_write_killable(vma))
> +		return -EINTR;
> +
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
> index 8c227fefa2df..3d9147f3d404 100644
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
> @@ -506,11 +511,13 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
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
>  	}
>  out:
>  	*prev = vma;
> @@ -739,9 +746,18 @@ static int apply_mlockall_flags(int flags)
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
> index 110d47a36d4b..ae6ed882b600 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -768,7 +768,10 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
>  	 * vm_flags and vm_page_prot are protected by the mmap_lock
>  	 * held in write mode.
>  	 */
> -	vma_start_write(vma);
> +	error = vma_start_write_killable(vma);
> +	if (error)
> +		goto fail;
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
> index 603df53ad267..3b7737ba7524 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -70,6 +70,7 @@ static int mseal_apply(struct mm_struct *mm,
>
>  		if (!vma_test(vma, VMA_SEALED_BIT)) {
>  			vma_flags_t vma_flags = vma->flags;
> +			int err;
>
>  			vma_flags_set(&vma_flags, VMA_SEALED_BIT);
>
> @@ -77,7 +78,9 @@ static int mseal_apply(struct mm_struct *mm,
>  					       curr_end, &vma_flags);
>  			if (IS_ERR(vma))
>  				return PTR_ERR(vma);
> -			vma_start_write(vma);
> +			err = vma_start_write_killable(vma);
> +			if (err)
> +				return err;
>  			vma_set_flags(vma, VMA_SEALED_BIT);
>  		}
>
> --
> 2.53.0.1018.g2bb0e51243-goog
>
