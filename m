Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6A35F193;
	Mon, 23 Mar 2026 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289092; cv=none; b=Tkn3kEFX2K2yZDvHgcDCFBsHkOCSyktkXPd0uxPlESc9v7OHHwa/jHijNEDvjVA5AFdFVYppaUq02Rd/56cm+eVH+wEHBdDTflWVs5nrF6yQ/Kb4CD9YIQWwsYCXhKY0gq2QRGpedo7jQ9l6RCdvnrVJfuV9vP07f0mlbYUnws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289092; c=relaxed/simple;
	bh=CruYFImaZ7t8b4ollGRPZPQSf1fkTcITWStkRCYIOgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocjS7VOd3AcXgRV0BUcxszFFe2lH8fDHfkDCoMI+PM7ASzv0YLI5RCGr2KVKhdLCq4qw+UJF+ZEs/1XBlr+zUnPm2WkJpIifusWz4Wu6lM+nMiHncW7HLoKoe/aba8RxQ9hr7/5put5nRDgMm3PIV33Xw8zVu+1oKc6O9/6UIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDtWPwoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDtWPwoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A87C4CEF7;
	Mon, 23 Mar 2026 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289092;
	bh=CruYFImaZ7t8b4ollGRPZPQSf1fkTcITWStkRCYIOgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDtWPwoezlO5BESYMPPqNQNwXC0kehS0cJIQC+FBhxL0H17ihZQutq/GjuIR+DiUV
	 i5zcw3qJQtZnj4+CaQx149G/nnT/DghiOJlYmmca5qOVzujJ7sZqPhZoNHex4d7Ymz
	 0QWrWDuBbSKZeJugD02i12xJTXyWNNloLToP1B2CMdIsj2fcFpU777iXF6TxHnhD/C
	 b1uqjKnStXEeadUHqq7Z/EQgEA+bu2gnCs8U5l9UDPAKcTiXdyFwJLS9Kqx5z2/G9x
	 c7RVwWhnMcASmLbIKUyAIrkAzS38Uzs+m/ZjuaSeFkufx7xxPFVlo3qJSFoBHXhaM1
	 mVemqyvThdMNA==
Date: Mon, 23 Mar 2026 18:04:50 +0000
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
Subject: Re: [PATCH v4 4/4] mm: use vma_start_write_killable() in
 process_vma_walk_lock()
Message-ID: <1c44dd0b-4f5a-4fc1-983f-f728b31c9e4d@lucifer.local>
References: <20260322054309.898214-1-surenb@google.com>
 <20260322054309.898214-5-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322054309.898214-5-surenb@google.com>

On Sat, Mar 21, 2026 at 10:43:08PM -0700, Suren Baghdasaryan wrote:
> Replace vma_start_write() with vma_start_write_killable() when
> process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> Adjust its direct and indirect users to check for a possible error
> and handle it. Ensure users handle EINTR correctly and do not ignore
> it.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c |  5 ++++-
>  mm/mempolicy.c     |  1 +
>  mm/pagewalk.c      | 20 ++++++++++++++------
>  3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e091931d7ca1..2fe3d11aad03 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1797,6 +1797,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  		struct clear_refs_private cp = {
>  			.type = type,
>  		};
> +		int err;

Maybe better to make it a ssize_t given return type of function?

>
>  		if (mmap_write_lock_killable(mm)) {
>  			count = -EINTR;
> @@ -1824,7 +1825,9 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  						0, mm, 0, -1UL);
>  			mmu_notifier_invalidate_range_start(&range);
>  		}
> -		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> +		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> +		if (err)
> +			count = err;

Hmm this is gross, but it's an established pattern here, ugh.

Now we have an err though, could we update:

		if (mmap_write_lock_killable(mm)) {
-			count = -EINTR;
+			err = -EINTR;
			goto out_mm;
		}

Then we can just do:

+		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);

And at the end do:

	return err ?: count;

Which possibly _necessitates_ err being a ssize_t.

>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
>  			mmu_notifier_invalidate_range_end(&range);
>  			flush_tlb_mm(mm);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 929e843543cf..bb5b0e83ce0f 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
>   *      (a hugetlbfs page or a transparent huge page being counted as 1).
>   * -EIO - a misplaced page found, when MPOL_MF_STRICT specified without MOVEs.
>   * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK unspecified.
> + * -EINTR - walk got terminated due to pending fatal signal.

Thanks!

>   */
>  static long
>  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index eda74273c8ec..a42cd6a6d812 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -438,14 +438,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
>  		mmap_assert_write_locked(mm);
>  }
>
> -static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> +static inline int process_vma_walk_lock(struct vm_area_struct *vma,

NIT: Don't need this to be an inline any longer. May as well fix up while we're
here.

>  					 enum page_walk_lock walk_lock)
>  {
>  #ifdef CONFIG_PER_VMA_LOCK
>  	switch (walk_lock) {
>  	case PGWALK_WRLOCK:
> -		vma_start_write(vma);
> -		break;
> +		return vma_start_write_killable(vma);

LGTM

>  	case PGWALK_WRLOCK_VERIFY:
>  		vma_assert_write_locked(vma);
>  		break;
> @@ -457,6 +456,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
>  		break;
>  	}
>  #endif
> +	return 0;
>  }
>
>  /*
> @@ -500,7 +500,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
>  			if (ops->pte_hole)
>  				err = ops->pte_hole(start, next, -1, &walk);
>  		} else { /* inside vma */
> -			process_vma_walk_lock(vma, ops->walk_lock);
> +			err = process_vma_walk_lock(vma, ops->walk_lock);
> +			if (err)
> +				break;

In every other case we set walk.vma = vma or NULL. Is it a problem not setting
it at all in this code path?

>  			walk.vma = vma;
>  			next = min(end, vma->vm_end);
>  			vma = find_vma(mm, vma->vm_end);
> @@ -717,6 +719,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
>  		.vma		= vma,
>  		.private	= private,
>  	};
> +	int err;
>
>  	if (start >= end || !walk.mm)
>  		return -EINVAL;
> @@ -724,7 +727,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
>  		return -EINVAL;
>
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> -	process_vma_walk_lock(vma, ops->walk_lock);
> +	err = process_vma_walk_lock(vma, ops->walk_lock);
> +	if (err)
> +		return err;

LGTM

>  	return __walk_page_range(start, end, &walk);
>  }
>
> @@ -747,6 +752,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  		.vma		= vma,
>  		.private	= private,
>  	};
> +	int err;
>
>  	if (!walk.mm)
>  		return -EINVAL;
> @@ -754,7 +760,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  		return -EINVAL;
>
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> -	process_vma_walk_lock(vma, ops->walk_lock);
> +	err = process_vma_walk_lock(vma, ops->walk_lock);
> +	if (err)
> +		return err;

LGTM

>  	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
>  }
>
> --
> 2.53.0.1018.g2bb0e51243-goog
>

Thanks, Lorenzo
