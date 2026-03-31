Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC43CF034;
	Tue, 31 Mar 2026 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950667; cv=none; b=f4xkWE5SsTWxduG8asMWLClsY8BaCvOMVNotBvAiSNzbVTuQc3RWq0JI5iXIJws/xhzqVi0EQLXI+hYumtyliMwu+T8Wsgxit+5gmMYlQyUAz17tPVNXT9zPQ+O0Wx/4DKuZm7oeoHDMpnwdrIk9QLOJt0t1MVmvMvveqykpZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950667; c=relaxed/simple;
	bh=GUYv48aqnOB+9lrhq/OJxgTDhnzEElBOBOj0aReQt00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjZe1I+Qx9uIDf8S6pP4IN9w9jOmOi1PM12PvDSQR3V7tnpBTnMM2+PTdGrbd9vodGW2+ItiZAbdTu66hhB1Q9Mkj5dgae9O3c2B7qecf/thJnQexMQjrwgkynwKXDZ0nDkM6wB+++eve1uTfAO6jLCuxuiV3qAwSAoUehCgqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNtyMoYn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNtyMoYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBD3C19423;
	Tue, 31 Mar 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774950666;
	bh=GUYv48aqnOB+9lrhq/OJxgTDhnzEElBOBOj0aReQt00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNtyMoYnwvw8y7P34krJLMvPuk9Ug1u22pw5FUadp9aWf/T6utbvWI7nh/NXWnEKC
	 tJ4F3CDEPr3Vha3SMIaiIUgFcrZiDrA98XybSdpl11bHRSaKj+zFJ0+mV+jzp+cwrj
	 jH/QZyrPNiNDzvdpGi2yzAs+H4B/F2ck5wsIPLfe3keXguMAuUV66LjmJftvhp986C
	 Jkt4gDcMMWmboVTTO8L51n5cNQ9BnwU32voSLRWWseQnTdDx3sRt/gggQPu4pccJz2
	 P0dfGFMVwgLdKgJ8TQdJb/4TtC799ap1M3TRT+hlw4zD6oJYTcZrgyemeOPptHjrgP
	 aVIemcS5phjtg==
Date: Tue, 31 Mar 2026 10:51:04 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
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
Subject: Re: [PATCH v6 0/6] Use killable vma write locking in most places
Message-ID: <f128b795-5577-40f9-8dae-936be4253642@lucifer.local>
References: <20260327205457.604224-1-surenb@google.com>
 <20260327161226.17e680fec33117d67dc8b5f9@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327161226.17e680fec33117d67dc8b5f9@linux-foundation.org>

On Fri, Mar 27, 2026 at 04:12:26PM -0700, Andrew Morton wrote:
> On Fri, 27 Mar 2026 13:54:51 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Now that we have vma_start_write_killable() we can replace most of the
> > vma_start_write() calls with it, improving reaction time to the kill
> > signal.
> >
> > There are several places which are left untouched by this patchset:
> >
> > 1. free_pgtables() because function should free page tables even if a
> > fatal signal is pending.
> >
> > 2. userfaultd code, where some paths calling vma_start_write() can
> > handle EINTR and some can't without a deeper code refactoring.
> >
> > 3. mpol_rebind_mm() which is used by cpusset controller for migrations
> > and operates on a remote mm. Incomplete operations here would result
> > in an inconsistent cgroup state.
> >
> > 4. vm_flags_{set|mod|clear} require refactoring that involves moving
> > vma_start_write() out of these functions and replacing it with
> > vma_assert_write_locked(), then callers of these functions should
> > lock the vma themselves using vma_start_write_killable() whenever
> > possible.
>
> Updated, thanks.

Andrew - sorry I think we need to yank this and defer to next cycle,
there's too many functional changes here.

(There was not really any way for me to predict this would happen ahead of
time, unfortunately.)

>
> > Changes since v5 [1]:
> > - Added Reviewed-by for unchanged patches, per Lorenzo Stoakes
> >
> > Patch#2:
> > - Fixed locked_vm counter if mlock_vma_pages_range() fails in
> > mlock_fixup(), per Sashiko
> > - Avoid VMA re-locking in madvise_update_vma(), mprotect_fixup() and
> > mseal_apply() when vma_modify_XXX creates a new VMA as it will already be
> > locked. This prevents the possibility of incomplete operation if signal
> > happens after a successful vma_modify_XXX modified the vma tree,
> > per Sashiko

Prevents the possibility of an incomplete operation? But
vma_write_lock_killable() checks to see if you're _already_ write locked
and would make the operation a no-op? So how is this even a delta?

It's a brave new world, arguing with sashiko via a submitter... :)

> > - Removed obsolete comment in madvise_update_vma() and mprotect_fixup()
> >
> > Patch#4:
> > - Added clarifying comment for vma_start_write_killable() when locking a
> > detached VMA
> > - Override VMA_MERGE_NOMERGE in vma_expand() to prevent callers from
> > falling back to a new VMA allocation, per Sashiko
> > - Added a note in the changelog about temporary workaround of using
> > ENOMEM to propagate the error in vma_merge_existing_range() and
> > vma_expand()
> >
> > Patch#5:
> > - Added fatal_signal_pending() check in do_mbind() to detect
> > queue_pages_range() failures due to a pendig fatal signal, per Sashiko
>
> Changes since v5:
>
>
>  mm/madvise.c   |   15 ++++++++++-----
>  mm/mempolicy.c |    9 ++++++++-
>  mm/mlock.c     |    2 ++
>  mm/mprotect.c  |   26 ++++++++++++++++----------
>  mm/mseal.c     |   27 +++++++++++++++++++--------
>  mm/vma.c       |   20 ++++++++++++++++++--
>  6 files changed, 73 insertions(+), 26 deletions(-)
>
> --- a/mm/madvise.c~b
> +++ a/mm/madvise.c
> @@ -172,11 +172,16 @@ static int madvise_update_vma(vm_flags_t
>  	if (IS_ERR(vma))
>  		return PTR_ERR(vma);
>
> -	madv_behavior->vma = vma;
> -
> -	/* vm_flags is protected by the mmap_lock held in write mode. */
> -	if (vma_start_write_killable(vma))
> -		return -EINTR;
> +	/*
> +	 * If a new vma was created during vma_modify_XXX, the resulting
> +	 * vma is already locked. Skip re-locking new vma in this case.
> +	 */
> +	if (vma == madv_behavior->vma) {
> +		if (vma_start_write_killable(vma))
> +			return -EINTR;
> +	} else {
> +		madv_behavior->vma = vma;
> +	}
>
>  	vma->flags = new_vma_flags;
>  	if (set_new_anon_name)
> --- a/mm/mempolicy.c~b
> +++ a/mm/mempolicy.c
> @@ -1546,7 +1546,14 @@ static long do_mbind(unsigned long start
>  			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
>
>  	if (nr_failed < 0) {
> -		err = nr_failed;
> +		/*
> +		 * queue_pages_range() might override the original error with -EFAULT.
> +		 * Confirm that fatal signals are still treated correctly.
> +		 */
> +		if (fatal_signal_pending(current))
> +			err = -EINTR;
> +		else
> +			err = nr_failed;
>  		nr_failed = 0;
>  	} else {
>  		vma_iter_init(&vmi, mm, start);
> --- a/mm/mlock.c~b
> +++ a/mm/mlock.c
> @@ -518,6 +518,8 @@ static int mlock_fixup(struct vma_iterat
>  		vma->flags = new_vma_flags;
>  	} else {
>  		ret = mlock_vma_pages_range(vma, start, end, &new_vma_flags);
> +		if (ret)
> +			mm->locked_vm -= nr_pages;
>  	}
>  out:
>  	*prev = vma;
> --- a/mm/mprotect.c~b
> +++ a/mm/mprotect.c
> @@ -716,6 +716,7 @@ mprotect_fixup(struct vma_iterator *vmi,
>  	const vma_flags_t old_vma_flags = READ_ONCE(vma->flags);
>  	vma_flags_t new_vma_flags = legacy_to_vma_flags(newflags);
>  	long nrpages = (end - start) >> PAGE_SHIFT;
> +	struct vm_area_struct *new_vma;
>  	unsigned int mm_cp_flags = 0;
>  	unsigned long charged = 0;
>  	int error;
> @@ -772,21 +773,26 @@ mprotect_fixup(struct vma_iterator *vmi,
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
> -	error = vma_start_write_killable(vma);
> -	if (error)
> -		goto fail;
> +	if (new_vma == vma) {
> +		error = vma_start_write_killable(vma);
> +		if (error)
> +			goto fail;
> +	} else {
> +		vma = new_vma;
> +	}
> +
> +	*pprev = vma;
>
>  	vma_flags_reset_once(vma, &new_vma_flags);
>  	if (vma_wants_manual_pte_write_upgrade(vma))
> --- a/mm/mseal.c~b
> +++ a/mm/mseal.c
> @@ -70,17 +70,28 @@ static int mseal_apply(struct mm_struct
>
>  		if (!vma_test(vma, VMA_SEALED_BIT)) {
>  			vma_flags_t vma_flags = vma->flags;
> -			int err;
> +			struct vm_area_struct *new_vma;
>
>  			vma_flags_set(&vma_flags, VMA_SEALED_BIT);
>
> -			vma = vma_modify_flags(&vmi, prev, vma, curr_start,
> -					       curr_end, &vma_flags);
> -			if (IS_ERR(vma))
> -				return PTR_ERR(vma);
> -			err = vma_start_write_killable(vma);
> -			if (err)
> -				return err;
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
>  			vma_set_flags(vma, VMA_SEALED_BIT);
>  		}
>
> --- a/mm/vma.c~b
> +++ a/mm/vma.c
> @@ -531,6 +531,10 @@ __split_vma(struct vma_iterator *vmi, st
>  	err = vma_start_write_killable(vma);
>  	if (err)
>  		goto out_free_vma;
> +	/*
> +	 * Locking a new detached VMA will always succeed but it's just a
> +	 * detail of the current implementation, so handle it all the same.
> +	 */
>  	err = vma_start_write_killable(new);
>  	if (err)
>  		goto out_free_vma;
> @@ -1197,8 +1201,14 @@ int vma_expand(struct vma_merge_struct *
>
>  	mmap_assert_write_locked(vmg->mm);
>  	err = vma_start_write_killable(target);
> -	if (err)
> +	if (err) {
> +		/*
> +		 * Override VMA_MERGE_NOMERGE to prevent callers from
> +		 * falling back to a new VMA allocation.
> +		 */
> +		vmg->state = VMA_MERGE_ERROR_NOMEM;
>  		return err;
> +	}
>
>  	target_sticky = vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
>
> @@ -1231,8 +1241,14 @@ int vma_expand(struct vma_merge_struct *
>  		 * is pending.
>  		 */
>  		err = vma_start_write_killable(next);
> -		if (err)
> +		if (err) {
> +			/*
> +			 * Override VMA_MERGE_NOMERGE to prevent callers from
> +			 * falling back to a new VMA allocation.
> +			 */
> +			vmg->state = VMA_MERGE_ERROR_NOMEM;
>  			return err;
> +		}
>  		err = dup_anon_vma(target, next, &anon_dup);
>  		if (err)
>  			return err;
> _
>
