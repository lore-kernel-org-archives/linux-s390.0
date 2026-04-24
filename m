Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611C32E134;
	Fri, 24 Apr 2026 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065863; cv=none; b=a7ctFlCux7dMM+Eyh7LYY0s/lwgjH4ehEckjtpuojiQYjAi5gIC87OBMBtlE2vdwpj0TyH46/FisNQlxlOTLvZQMYgLMXYF8PM8qwb0v36ZZK3ORrgPRbKmj5N5W95lM+5h9T050e58vghfU1qmvvYpj1VIQMlmzlEheDKbre3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065863; c=relaxed/simple;
	bh=59p9R4tUG6NFn05rj3yz4ykiis61uI2XT3LSk12LyDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtr0XdRIHDYkfPoqGXI79n0H7we30DFUR00G0Saa4BT7p86ocCnDYCSpxbzXd4/Lb45ZUoNMbpV3+sy+RqMn9movxHAwMPs5Wh406awaB/0/AQHno6twSgMKvCHjbIWEXNsTNSd1A6E3zqEpqYTysCw1nOOq6VwqAynTnZdT/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBJOzKCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBJOzKCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8242CC19425;
	Fri, 24 Apr 2026 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777065862;
	bh=59p9R4tUG6NFn05rj3yz4ykiis61uI2XT3LSk12LyDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBJOzKCn9I73w007YObJ66qbwPLT8wzG1UZngVZyWhS/ouKeGExHLS7UIsFYL1Kt2
	 q8U67hseLfoAyonQ7hivSRSwkLTyeQj/UFtIbM59n3ooDmzEBAFWRlGmTxYyfS/Kjk
	 mkjphZQ1Ddae3fDtXSHZgGTwYPmpfkHjlWrnGY+TpwCyk2h3otZFOldLHHgwLfvZt6
	 W42fuLnW3zT57Z+4dd8c+b+jaLVBgJHDcjoo2GL3CJ4BE/97AqbYwFe9LBMlKFAxAX
	 WgXs+/YcmiuMTIVdNq510NL/KHk6d/5y2fTPVEVp/CNzo0DjETh19ZU/aW4JS+EQjw
	 jrqDVEEZydRbg==
Date: Fri, 24 Apr 2026 14:24:21 -0700
From: Minchan Kim <minchan@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, mhocko@suse.com, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <aevfhYW0K3y9jTjI@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
 <7b4bf980-4ff3-4f53-8c64-1ba2d85cf1b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4bf980-4ff3-4f53-8c64-1ba2d85cf1b8@kernel.org>

On Fri, Apr 24, 2026 at 09:56:01AM +0200, David Hildenbrand (Arm) wrote:
> On 4/22/26 01:02, Minchan Kim wrote:
> 
> Can we make the subject easier to understand?
> 
> "mm: process_mrelease: evict clean file folios when reaping a process"
> 
> > Currently, process_mrelease() unmaps pages but file-backed pages are
> > not evicted and stay in the pagecache, relying on standard memory reclaim
> > (kswapd or direct reclaim) to eventually free them. This delays the
> > immediate recovery of system memory under Android's LMKD scenarios,
> > leading to redundant background apps kills.
> > 
> > This patch implements an expedited eviction mechanism for clean pagecache
> > folios in the mmu_gather code, similar to how swapcache folios are handled.
> > It drops them from the pagecache (i.e., evicting them) if they are completely
> > unmapped during reaping.
> > 
> > Within this single unified loop, anonymous pages are released via
> > free_swap_cache(), and file-backed folios are symmetrically released via
> > free_file_cache().
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  arch/s390/include/asm/tlb.h |  2 +-
> >  include/linux/swap.h        |  5 ++---
> >  mm/mmu_gather.c             |  7 ++++---
> >  mm/swap.c                   | 42 +++++++++++++++++++++++++++++++++++++
> >  mm/swap_state.c             | 26 -----------------------
> >  5 files changed, 49 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> > index 619fd41e710e..2736dbb571a8 100644
> > --- a/arch/s390/include/asm/tlb.h
> > +++ b/arch/s390/include/asm/tlb.h
> > @@ -62,7 +62,7 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
> >  	VM_WARN_ON_ONCE(delay_rmap);
> >  	VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));
> >  
> > -	free_pages_and_swap_cache(encoded_pages, ARRAY_SIZE(encoded_pages));
> > +	free_pages_and_caches(tlb->mm, encoded_pages, ARRAY_SIZE(encoded_pages));
> >  	return false;
> >  }
> >  
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 62fc7499b408..bdb784966343 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -414,7 +414,9 @@ extern int sysctl_min_unmapped_ratio;
> >  extern int sysctl_min_slab_ratio;
> >  #endif
> >  
> > +struct mm_struct;
> >  void check_move_unevictable_folios(struct folio_batch *fbatch);
> > +void free_pages_and_caches(struct mm_struct *mm, struct encoded_page **pages, int nr);
> >  
> >  extern void __meminit kswapd_run(int nid);
> >  extern void __meminit kswapd_stop(int nid);
> > @@ -433,7 +435,6 @@ static inline unsigned long total_swapcache_pages(void)
> >  
> >  void free_swap_cache(struct folio *folio);
> >  void free_folio_and_swap_cache(struct folio *folio);
> > -void free_pages_and_swap_cache(struct encoded_page **, int);
> >  /* linux/mm/swapfile.c */
> >  extern atomic_long_t nr_swap_pages;
> >  extern long total_swap_pages;
> > @@ -510,8 +511,6 @@ static inline void put_swap_device(struct swap_info_struct *si)
> >  	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
> >  #define free_folio_and_swap_cache(folio) \
> >  	folio_put(folio)
> > -#define free_pages_and_swap_cache(pages, nr) \
> > -	release_pages((pages), (nr));
> >  
> >  static inline void free_swap_cache(struct folio *folio)
> >  {
> > diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> > index fe5b6a031717..3c6c315d3c48 100644
> > --- a/mm/mmu_gather.c
> > +++ b/mm/mmu_gather.c
> > @@ -100,7 +100,8 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struct vm_area_struct *vma)
> >   */
> >  #define MAX_NR_FOLIOS_PER_FREE		512
> >  
> > -static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
> > +static void __tlb_batch_free_encoded_pages(struct mm_struct *mm,
> > +		struct mmu_gather_batch *batch)
> >  {
> >  	struct encoded_page **pages = batch->encoded_pages;
> >  	unsigned int nr, nr_pages;
> > @@ -135,7 +136,7 @@ static void __tlb_batch_free_encoded_pages(struct mmu_gather_batch *batch)
> >  			}
> >  		}
> >  
> > -		free_pages_and_swap_cache(pages, nr);
> > +		free_pages_and_caches(mm, pages, nr);
> >  		pages += nr;
> >  		batch->nr -= nr;
> >  
> > @@ -148,7 +149,7 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
> >  	struct mmu_gather_batch *batch;
> >  
> >  	for (batch = &tlb->local; batch && batch->nr; batch = batch->next)
> > -		__tlb_batch_free_encoded_pages(batch);
> > +		__tlb_batch_free_encoded_pages(tlb->mm, batch);
> >  	tlb->active = &tlb->local;
> >  }
> >  
> > diff --git a/mm/swap.c b/mm/swap.c
> > index bb19ccbece46..e44bc8cefceb 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -1043,6 +1043,48 @@ void release_pages(release_pages_arg arg, int nr)
> >  }
> >  EXPORT_SYMBOL(release_pages);
> >  
> > +static inline void free_file_cache(struct folio *folio)
> > +{
> > +	if (folio_trylock(folio)) {
> > +		mapping_evict_folio(folio_mapping(folio), folio);
> > +		folio_unlock(folio);
> > +	}
> > +}
> > +
> > +/*
> > + * Passed an array of pages, drop them all from swapcache and then release
> > + * them.  They are removed from the LRU and freed if this is their last use.
> > + *
> > + * If @try_evict_file_folios is true, this function will proactively evict clean
> > + * file-backed folios if they are no longer mapped.
> 
> There is no such parameter.
> 
> But I do wonder if such a parameter would be better than passing in the MM here.

Makes sense.

> 
> Also, is there a way to avoid moving the function?

I guess you are talking about "free_pages_and_swap_cache".

The problem is mm/swap_state.c is conditionally compiled only when CONFIG_SWAP
is enabled.

Since the expedited clean file cache eviction should be available
even on !CONFIG_SWAP, we need this function to be compiled unconditionally.
That is why I moved it to swap.c, which is always compiled.

I am open for any suggestion.
