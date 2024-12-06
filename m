Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BF28FD;
	Fri,  6 Dec 2024 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460622; cv=none; b=rsUsOVpb+LHTlnztB7Js9i3JUaArYcDWgXzxnpn2d8fBQ/rgslwKRh4b5JybumY7fcuY79oXrROdc5wCpGJkR3W0wNZ4M4EJpvx47hEsI1y0ZUcH2eVWUUH4pRn6Mk5G9naO4xFPpOgzmfY3VNtqVwgW2L+snDPR88LsfFtSUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460622; c=relaxed/simple;
	bh=azcIaN9xS4OhBh13wKTotBQOrofPdrThVZnKKRGCi5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIjuVgLqPgjKdb9PFPvZAqx6pxVl0trlA0bzNTs4/Qplx29muvqDfOu0Civ+sCkFduVGvYF6NcDxFDXQi628ruCnZaseW6gceSjBn3mWPEQifr8dTmAHP+LkupgtMqLBOkC110Aa78QWsyaly/74vKkboo6R9ZDCLduYdkmgulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJhjBHsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJhjBHsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D6C4CED1;
	Fri,  6 Dec 2024 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733460621;
	bh=azcIaN9xS4OhBh13wKTotBQOrofPdrThVZnKKRGCi5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJhjBHsyo2CyO7dZGswIJvUxYIRO9xAsjEWLd98w8UNcfr1Cikneln+LMjOK6JVCI
	 d9trAdJM6ACDpujasfZIeFgJQT80miFednLZt91bNalsYUPFDX8OIrzcJBwE2i/H98
	 gnHjgjRXaqrhclbMeXBbFbjrGaF4nbPku4GkC1kYn6pfmn7sW3uqPkBwWC71w19c3l
	 vlGsVnpykXr5S0WdkcKe4OvKqdYNUvVpPefJPqO94lZ4YEYE00ece9GDesbXWGm1SL
	 wXIaqz1A5SNiwyZDn9waKgt8O3Go2+rGCaO1uglx3tXdSWiE/tH2Y44z2EG4E8CdJC
	 ftdqdWXplxrCg==
Date: Thu, 5 Dec 2024 21:50:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guillaume Morin <guillaume@morinfr.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	Eric Hagberg <ehagberg@janestreet.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: support FOLL_FORCE|FOLL_WRITE
Message-ID: <20241206045019.GA2215843@thelio-3990X>
References: <Z1EJssqd93w2erMZ@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1EJssqd93w2erMZ@bender.morinfr.org>

Hi Guillaume and s390 folks,

On Thu, Dec 05, 2024 at 03:02:26AM +0100, Guillaume Morin wrote:
> 
> Eric reported that PTRACE_POKETEXT fails when applications use hugetlb
> for mapping text using huge pages. Before commit 1d8d14641fd9
> ("mm/hugetlb: support write-faults in shared mappings"), PTRACE_POKETEXT
> worked by accident, but it was buggy and silently ended up mapping pages
> writable into the page tables even though VM_WRITE was not set.
> 
> In general, FOLL_FORCE|FOLL_WRITE does currently not work with hugetlb.
> Let's implement FOLL_FORCE|FOLL_WRITE properly for hugetlb, such that
> what used to work in the past by accident now properly works, allowing
> applications using hugetlb for text etc. to get properly debugged.
> 
> This change might also be required to implement uprobes support for
> hugetlb [1].
> 
> [1] https://lore.kernel.org/lkml/ZiK50qob9yl5e0Xz@bender.morinfr.org/
> 
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eric Hagberg <ehagberg@janestreet.com>
> Signed-off-by: Guillaume Morin <guillaume@morinfr.org>
> ---
>  Changes in v2:
>   - Improved commit message
>  Changes in v3:
>   - Fix potential unitialized mem access in follow_huge_pud
>   - define pud_soft_dirty when soft dirty is not enabled
> 
>  include/linux/pgtable.h |  5 +++
>  mm/gup.c                | 99 +++++++++++++++++++++--------------------
>  mm/hugetlb.c            | 20 +++++----
>  3 files changed, 66 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index adef9d6e9b1b..9335d7c82d20 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1422,6 +1422,11 @@ static inline int pmd_soft_dirty(pmd_t pmd)
>  	return 0;
>  }
>  
> +static inline int pud_soft_dirty(pud_t pud)
> +{
> +	return 0;
> +}
> +
>  static inline pte_t pte_mksoft_dirty(pte_t pte)
>  {
>  	return pte;
> diff --git a/mm/gup.c b/mm/gup.c
> index 746070a1d8bf..cc3eae458013 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -587,6 +587,33 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
>  }
>  #endif	/* CONFIG_HAVE_GUP_FAST */
>  
> +/* Common code for can_follow_write_* */
> +static inline bool can_follow_write_common(struct page *page,
> +		struct vm_area_struct *vma, unsigned int flags)
> +{
> +	/* Maybe FOLL_FORCE is set to override it? */
> +	if (!(flags & FOLL_FORCE))
> +		return false;
> +
> +	/* But FOLL_FORCE has no effect on shared mappings */
> +	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
> +		return false;
> +
> +	/* ... or read-only private ones */
> +	if (!(vma->vm_flags & VM_MAYWRITE))
> +		return false;
> +
> +	/* ... or already writable ones that just need to take a write fault */
> +	if (vma->vm_flags & VM_WRITE)
> +		return false;
> +
> +	/*
> +	 * See can_change_pte_writable(): we broke COW and could map the page
> +	 * writable if we have an exclusive anonymous page ...
> +	 */
> +	return page && PageAnon(page) && PageAnonExclusive(page);
> +}
> +
>  static struct page *no_page_table(struct vm_area_struct *vma,
>  				  unsigned int flags, unsigned long address)
>  {
> @@ -613,6 +640,22 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  }
>  
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> +/* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
> +static inline bool can_follow_write_pud(pud_t pud, struct page *page,
> +					struct vm_area_struct *vma,
> +					unsigned int flags)
> +{
> +	/* If the pud is writable, we can write to the page. */
> +	if (pud_write(pud))
> +		return true;
> +
> +	if (!can_follow_write_common(page, vma, flags))
> +		return false;
> +
> +	/* ... and a write-fault isn't required for other reasons. */
> +	return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);

This looks to be one of the first uses of pud_soft_dirty() in a generic
part of the tree from what I can tell, which shows that s390 is lacking
it despite setting CONFIG_HAVE_ARCH_SOFT_DIRTY:

  $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390-linux- mrproper defconfig mm/gup.o
  mm/gup.c: In function 'can_follow_write_pud':
  mm/gup.c:665:48: error: implicit declaration of function 'pud_soft_dirty'; did you mean 'pmd_soft_dirty'? [-Wimplicit-function-declaration]
    665 |         return !vma_soft_dirty_enabled(vma) || pud_soft_dirty(pud);
        |                                                ^~~~~~~~~~~~~~
        |                                                pmd_soft_dirty

Is this expected?

Cheers,
Nathan

> +}
> +
>  static struct page *follow_huge_pud(struct vm_area_struct *vma,
>  				    unsigned long addr, pud_t *pudp,
>  				    int flags, struct follow_page_context *ctx)
> @@ -625,13 +668,16 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
>  
>  	assert_spin_locked(pud_lockptr(mm, pudp));
>  
> -	if ((flags & FOLL_WRITE) && !pud_write(pud))
> +	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
> +	page = pfn_to_page(pfn);
> +
> +	if ((flags & FOLL_WRITE) &&
> +	    !can_follow_write_pud(pud, page, vma, flags))
>  		return NULL;
>  
>  	if (!pud_present(pud))
>  		return NULL;
>  
> -	pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
>  
>  	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>  	    pud_devmap(pud)) {
> @@ -653,8 +699,6 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
>  			return ERR_PTR(-EFAULT);
>  	}
>  
> -	page = pfn_to_page(pfn);
> -
>  	if (!pud_devmap(pud) && !pud_write(pud) &&
>  	    gup_must_unshare(vma, flags, page))
>  		return ERR_PTR(-EMLINK);
> @@ -677,27 +721,7 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
>  	if (pmd_write(pmd))
>  		return true;
>  
> -	/* Maybe FOLL_FORCE is set to override it? */
> -	if (!(flags & FOLL_FORCE))
> -		return false;
> -
> -	/* But FOLL_FORCE has no effect on shared mappings */
> -	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
> -		return false;
> -
> -	/* ... or read-only private ones */
> -	if (!(vma->vm_flags & VM_MAYWRITE))
> -		return false;
> -
> -	/* ... or already writable ones that just need to take a write fault */
> -	if (vma->vm_flags & VM_WRITE)
> -		return false;
> -
> -	/*
> -	 * See can_change_pte_writable(): we broke COW and could map the page
> -	 * writable if we have an exclusive anonymous page ...
> -	 */
> -	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
> +	if (!can_follow_write_common(page, vma, flags))
>  		return false;
>  
>  	/* ... and a write-fault isn't required for other reasons. */
> @@ -798,27 +822,7 @@ static inline bool can_follow_write_pte(pte_t pte, struct page *page,
>  	if (pte_write(pte))
>  		return true;
>  
> -	/* Maybe FOLL_FORCE is set to override it? */
> -	if (!(flags & FOLL_FORCE))
> -		return false;
> -
> -	/* But FOLL_FORCE has no effect on shared mappings */
> -	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
> -		return false;
> -
> -	/* ... or read-only private ones */
> -	if (!(vma->vm_flags & VM_MAYWRITE))
> -		return false;
> -
> -	/* ... or already writable ones that just need to take a write fault */
> -	if (vma->vm_flags & VM_WRITE)
> -		return false;
> -
> -	/*
> -	 * See can_change_pte_writable(): we broke COW and could map the page
> -	 * writable if we have an exclusive anonymous page ...
> -	 */
> -	if (!page || !PageAnon(page) || !PageAnonExclusive(page))
> +	if (!can_follow_write_common(page, vma, flags))
>  		return false;
>  
>  	/* ... and a write-fault isn't required for other reasons. */
> @@ -1285,9 +1289,6 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>  			if (!(gup_flags & FOLL_FORCE))
>  				return -EFAULT;
> -			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
> -			if (is_vm_hugetlb_page(vma))
> -				return -EFAULT;
>  			/*
>  			 * We used to let the write,force case do COW in a
>  			 * VM_MAYWRITE VM_SHARED !VM_WRITE vma, so ptrace could
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea2ed8e301ef..52517b7ce308 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5169,6 +5169,13 @@ static void set_huge_ptep_writable(struct vm_area_struct *vma,
>  		update_mmu_cache(vma, address, ptep);
>  }
>  
> +static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
> +					 unsigned long address, pte_t *ptep)
> +{
> +	if (vma->vm_flags & VM_WRITE)
> +		set_huge_ptep_writable(vma, address, ptep);
> +}
> +
>  bool is_hugetlb_entry_migration(pte_t pte)
>  {
>  	swp_entry_t swp;
> @@ -5802,13 +5809,6 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  	if (!unshare && huge_pte_uffd_wp(pte))
>  		return 0;
>  
> -	/*
> -	 * hugetlb does not support FOLL_FORCE-style write faults that keep the
> -	 * PTE mapped R/O such as maybe_mkwrite() would do.
> -	 */
> -	if (WARN_ON_ONCE(!unshare && !(vma->vm_flags & VM_WRITE)))
> -		return VM_FAULT_SIGSEGV;
> -
>  	/* Let's take out MAP_SHARED mappings first. */
>  	if (vma->vm_flags & VM_MAYSHARE) {
>  		set_huge_ptep_writable(vma, vmf->address, vmf->pte);
> @@ -5837,7 +5837,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  			SetPageAnonExclusive(&old_folio->page);
>  		}
>  		if (likely(!unshare))
> -			set_huge_ptep_writable(vma, vmf->address, vmf->pte);
> +			set_huge_ptep_maybe_writable(vma, vmf->address,
> +						     vmf->pte);
>  
>  		delayacct_wpcopy_end();
>  		return 0;
> @@ -5943,7 +5944,8 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>  	spin_lock(vmf->ptl);
>  	vmf->pte = hugetlb_walk(vma, vmf->address, huge_page_size(h));
>  	if (likely(vmf->pte && pte_same(huge_ptep_get(mm, vmf->address, vmf->pte), pte))) {
> -		pte_t newpte = make_huge_pte(vma, &new_folio->page, !unshare);
> +		const bool writable = !unshare && (vma->vm_flags & VM_WRITE);
> +		pte_t newpte = make_huge_pte(vma, &new_folio->page, writable);
>  
>  		/* Break COW or unshare */
>  		huge_ptep_clear_flush(vma, vmf->address, vmf->pte);
> -- 
> 2.39.1
> 
> -- 
> Guillaume Morin <guillaume@morinfr.org>
