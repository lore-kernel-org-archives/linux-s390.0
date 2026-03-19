Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8538E5F1;
	Thu, 19 Mar 2026 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920389; cv=none; b=HHbvK2TEMvhQxtayyb8Fik9qUl3HB+L3jq5k42tcJdN2e74S3080vzxaISEUnMKuURGEoDN3+uArcR+QBY/4myur2ejArf0bTQhQhOk8wvySyJddI9UzoWDq7cnkRI8JDdX/doSed1z5oVgXmtLDILWmkdLZc6S74lVns1p0auI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920389; c=relaxed/simple;
	bh=E9JhBbwIf2oYiVeQO98SXyjx4quJ+BMudZAgGLFcb+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMkHwOGe/FHtYH4XhBC+IztTre1QsMdPnl23gSKnqAWMnXcDB3Jx+7qthdcLNy/STKZWJ+kki5AP8Zoeqvl/MhrynZqOWovYViqASxi3ZAz/a8LAZrHpr4gPDLNN0xTmwGwTYVYWo5HifjUOEa2lIJupfRyF9D8udcHxOZbyBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGx7WrTw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGx7WrTw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A442FC19424;
	Thu, 19 Mar 2026 11:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920389;
	bh=E9JhBbwIf2oYiVeQO98SXyjx4quJ+BMudZAgGLFcb+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGx7WrTwHUihAjtcSbFNMAICzyKVLizTimomndMFC17GigIHl2O5lLd1sAboSBwgz
	 teTLnani2q02pnMpHF5I64dZ3BvIk/JIUF/u8u/Bd2YHImY7IFL2+OvVZNa41u0ra+
	 0OMaJIIAcvUg7Gjcw8smNDGGOYsDwc1/HwLmjvPFzWx3oYGtRvNe6urP8AOJm5vdM5
	 jYzKtGiYHfkigeu6+1gWkC9Uvr0NJ8lJV5m9qVwNrOYChDvk1FHRUJG/M5g2z/kZLI
	 daNPIHfmjTPYD/PMmFMMlmRs2UzfU3YqHjEfUY4w3wEM9yjit59oEp/L1Mbz0Ga+4j
	 3P7vBOv+qa4qQ==
Date: Thu, 19 Mar 2026 11:39:43 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
Message-ID: <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>

On Thu, Mar 19, 2026 at 11:24:05AM +0800, Baolin Wang wrote:
> The MMU notifier young flag check related functions only return whether
> the young flag was set. Change the return type to bool to make the
> intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I can see KVM is the only user for the mmu_notifier_ops clear_flush_young,
clear_young and test_young hooks, which map to
kvm_mmu_notifier_[clear_flush,clear,test]_young() functions, and you have
updated them all.

So this LGTM with nits below, and so (with nits addressed as per the other R-b
tags :):

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks for doing this! Int as bool is a pet peeve of mine :))

Cheers, Lorenzo

> ---
>  include/linux/mmu_notifier.h | 76 +++++++++++++++++-------------------
>  mm/internal.h                | 16 ++++----
>  mm/mmu_notifier.c            | 20 +++++-----
>  virt/kvm/kvm_main.c          | 40 +++++++++----------
>  4 files changed, 72 insertions(+), 80 deletions(-)
>
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 3705d350c863..17f2cdc77dd5 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -97,20 +97,20 @@ struct mmu_notifier_ops {
>  	 * Start-end is necessary in case the secondary MMU is mapping the page
>  	 * at a smaller granularity than the primary MMU.
>  	 */
> -	int (*clear_flush_young)(struct mmu_notifier *subscription,
> -				 struct mm_struct *mm,
> -				 unsigned long start,
> -				 unsigned long end);
> +	bool (*clear_flush_young)(struct mmu_notifier *subscription,
> +				  struct mm_struct *mm,
> +				  unsigned long start,
> +				  unsigned long end);
>
>  	/*
>  	 * clear_young is a lightweight version of clear_flush_young. Like the
>  	 * latter, it is supposed to test-and-clear the young/accessed bitflag
>  	 * in the secondary pte, but it may omit flushing the secondary tlb.
>  	 */
> -	int (*clear_young)(struct mmu_notifier *subscription,
> -			   struct mm_struct *mm,
> -			   unsigned long start,
> -			   unsigned long end);
> +	bool (*clear_young)(struct mmu_notifier *subscription,
> +			    struct mm_struct *mm,
> +			    unsigned long start,
> +			    unsigned long end);
>
>  	/*
>  	 * test_young is called to check the young/accessed bitflag in
> @@ -118,9 +118,9 @@ struct mmu_notifier_ops {
>  	 * frequently used without actually clearing the flag or tearing
>  	 * down the secondary mapping on the page.
>  	 */
> -	int (*test_young)(struct mmu_notifier *subscription,
> -			  struct mm_struct *mm,
> -			  unsigned long address);
> +	bool (*test_young)(struct mmu_notifier *subscription,
> +			   struct mm_struct *mm,
> +			   unsigned long address);
>
>  	/*
>  	 * invalidate_range_start() and invalidate_range_end() must be
> @@ -376,14 +376,12 @@ mmu_interval_check_retry(struct mmu_interval_notifier *interval_sub,
>
>  extern void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm);
>  extern void __mmu_notifier_release(struct mm_struct *mm);
> -extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
> -					  unsigned long start,
> -					  unsigned long end);
> -extern int __mmu_notifier_clear_young(struct mm_struct *mm,
> -				      unsigned long start,
> -				      unsigned long end);
> -extern int __mmu_notifier_test_young(struct mm_struct *mm,
> -				     unsigned long address);
> +bool __mmu_notifier_clear_flush_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end);
> +bool __mmu_notifier_clear_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end);
> +bool __mmu_notifier_test_young(struct mm_struct *mm,
> +		unsigned long address);
>  extern int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r);
>  extern void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *r);
>  extern void __mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,

I mean damn, at this point maybe it's legit to drop the surrounding externs here
too? But maybe not :))

> @@ -403,30 +401,28 @@ static inline void mmu_notifier_release(struct mm_struct *mm)
>  		__mmu_notifier_release(mm);
>  }
>
> -static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
> -					  unsigned long start,
> -					  unsigned long end)
> +static inline bool mmu_notifier_clear_flush_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
>  	if (mm_has_notifiers(mm))
>  		return __mmu_notifier_clear_flush_young(mm, start, end);
> -	return 0;
> +	return false;
>  }
>
> -static inline int mmu_notifier_clear_young(struct mm_struct *mm,
> -					   unsigned long start,
> -					   unsigned long end)
> +static inline bool mmu_notifier_clear_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
>  	if (mm_has_notifiers(mm))
>  		return __mmu_notifier_clear_young(mm, start, end);
> -	return 0;
> +	return false;
>  }
>
> -static inline int mmu_notifier_test_young(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline bool mmu_notifier_test_young(struct mm_struct *mm,
> +		unsigned long address)
>  {
>  	if (mm_has_notifiers(mm))
>  		return __mmu_notifier_test_young(mm, address);
> -	return 0;
> +	return false;
>  }
>
>  static inline void
> @@ -552,24 +548,22 @@ static inline void mmu_notifier_release(struct mm_struct *mm)
>  {
>  }
>
> -static inline int mmu_notifier_clear_flush_young(struct mm_struct *mm,
> -					  unsigned long start,
> -					  unsigned long end)
> +static inline bool mmu_notifier_clear_flush_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
> -	return 0;
> +	return false;
>  }
>
> -static inline int mmu_notifier_clear_young(struct mm_struct *mm,
> -					   unsigned long start,
> -					   unsigned long end)
> +static inline bool mmu_notifier_clear_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
> -	return 0;
> +	return false;
>  }
>
> -static inline int mmu_notifier_test_young(struct mm_struct *mm,
> -					  unsigned long address)
> +static inline bool mmu_notifier_test_young(struct mm_struct *mm,
> +		unsigned long address)
>  {
> -	return 0;
> +	return false;
>  }
>
>  static inline void
> diff --git a/mm/internal.h b/mm/internal.h
> index 0eaca2f0eb6a..3d6eba216364 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1831,10 +1831,10 @@ static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
>  }
>
>  #ifdef CONFIG_MMU_NOTIFIER
> -static inline int clear_flush_young_ptes_notify(struct vm_area_struct *vma,
> +static inline bool clear_flush_young_ptes_notify(struct vm_area_struct *vma,
>  		unsigned long addr, pte_t *ptep, unsigned int nr)
>  {
> -	int young;
> +	bool young;
>
>  	young = clear_flush_young_ptes(vma, addr, ptep, nr);
>  	young |= mmu_notifier_clear_flush_young(vma->vm_mm, addr,
> @@ -1842,30 +1842,30 @@ static inline int clear_flush_young_ptes_notify(struct vm_area_struct *vma,
>  	return young;
>  }
>
> -static inline int pmdp_clear_flush_young_notify(struct vm_area_struct *vma,
> +static inline bool pmdp_clear_flush_young_notify(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmdp)
>  {
> -	int young;
> +	bool young;
>
>  	young = pmdp_clear_flush_young(vma, addr, pmdp);
>  	young |= mmu_notifier_clear_flush_young(vma->vm_mm, addr, addr + PMD_SIZE);
>  	return young;
>  }
>
> -static inline int test_and_clear_young_ptes_notify(struct vm_area_struct *vma,
> +static inline bool test_and_clear_young_ptes_notify(struct vm_area_struct *vma,
>  		unsigned long addr, pte_t *ptep, unsigned int nr)
>  {
> -	int young;
> +	bool young;
>
>  	young = test_and_clear_young_ptes(vma, addr, ptep, nr);
>  	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + nr * PAGE_SIZE);
>  	return young;
>  }
>
> -static inline int pmdp_test_and_clear_young_notify(struct vm_area_struct *vma,
> +static inline bool pmdp_test_and_clear_young_notify(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmdp)
>  {
> -	int young;
> +	bool young;
>
>  	young = pmdp_test_and_clear_young(vma, addr, pmdp);
>  	young |= mmu_notifier_clear_young(vma->vm_mm, addr, addr + PMD_SIZE);
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 2502474b83b6..3e3e7e727ba2 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -364,12 +364,11 @@ void __mmu_notifier_release(struct mm_struct *mm)
>   * unmap the address and return 1 or 0 depending if the mapping previously
>   * existed or not.
>   */
> -int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long end)
> +bool __mmu_notifier_clear_flush_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
>  	struct mmu_notifier *subscription;
> -	int young = 0, id;
> +	bool young = false, id;
>
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_srcu(subscription,
> @@ -384,12 +383,11 @@ int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
>  	return young;
>  }
>
> -int __mmu_notifier_clear_young(struct mm_struct *mm,
> -			       unsigned long start,
> -			       unsigned long end)
> +bool __mmu_notifier_clear_young(struct mm_struct *mm,
> +		unsigned long start, unsigned long end)
>  {
>  	struct mmu_notifier *subscription;
> -	int young = 0, id;
> +	bool young = false, id;
>
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_srcu(subscription,
> @@ -404,11 +402,11 @@ int __mmu_notifier_clear_young(struct mm_struct *mm,
>  	return young;
>  }
>
> -int __mmu_notifier_test_young(struct mm_struct *mm,
> -			      unsigned long address)
> +bool __mmu_notifier_test_young(struct mm_struct *mm,
> +		unsigned long address)
>  {
>  	struct mmu_notifier *subscription;
> -	int young = 0, id;
> +	bool young = false, id;
>
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_srcu(subscription,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d0ab29672c71..6bcfc1b3021d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -646,11 +646,11 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>  	return r;
>  }
>
> -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
> -						unsigned long start,
> -						unsigned long end,
> -						gfn_handler_t handler,
> -						bool flush_on_ret)
> +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> +					      unsigned long start,
> +					      unsigned long end,
> +					      gfn_handler_t handler,
> +					      bool flush_on_ret)

Can we please fix this terrrible indentation while we're here :)?

static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
		unsigned long start, unsigned long end, gfn_handler_t handler,
		bool flush_on_ret)

Would be nicer, thanks!

>  {
>  	struct kvm *kvm = mmu_notifier_to_kvm(mn);
>  	const struct kvm_mmu_notifier_range range = {
> @@ -666,10 +666,10 @@ static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
>  	return kvm_handle_hva_range(kvm, &range).ret;
>  }
>
> -static __always_inline int kvm_age_hva_range_no_flush(struct mmu_notifier *mn,
> -						      unsigned long start,
> -						      unsigned long end,
> -						      gfn_handler_t handler)
> +static __always_inline bool kvm_age_hva_range_no_flush(struct mmu_notifier *mn,
> +						       unsigned long start,
> +						       unsigned long end,
> +						       gfn_handler_t handler)

Same indentation comment here.

>  {
>  	return kvm_age_hva_range(mn, start, end, handler, false);
>  }
> @@ -829,10 +829,10 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
>  		rcuwait_wake_up(&kvm->mn_memslots_update_rcuwait);
>  }
>
> -static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
> -					      struct mm_struct *mm,
> -					      unsigned long start,
> -					      unsigned long end)
> +static bool kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
> +					       struct mm_struct *mm,
> +					       unsigned long start,
> +					       unsigned long end)

Same indentation comment here.

>  {
>  	trace_kvm_age_hva(start, end);
>
> @@ -840,10 +840,10 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
>  				 !IS_ENABLED(CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG));
>  }
>
> -static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
> -					struct mm_struct *mm,
> -					unsigned long start,
> -					unsigned long end)
> +static bool kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
> +					 struct mm_struct *mm,
> +					 unsigned long start,
> +					 unsigned long end)

Same indentation comment here.

>  {
>  	trace_kvm_age_hva(start, end);
>
> @@ -863,9 +863,9 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
>  	return kvm_age_hva_range_no_flush(mn, start, end, kvm_age_gfn);
>  }
>
> -static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
> -				       struct mm_struct *mm,
> -				       unsigned long address)
> +static bool kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
> +					struct mm_struct *mm,
> +					unsigned long address)

Same indentation comment here.

>  {
>  	trace_kvm_test_age_hva(address);
>
> --
> 2.47.3
>
