Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305C313E1D;
	Fri,  8 May 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277397; cv=none; b=iPQMsPMneSRb2+LpXrSWTeQkwjMhyN5zCcydSHNUl2saZeX1T6jyEWDfYSU49LqXtBbKOSDUGlN6Fi3OK0G+I+jNwrIaErYwvXczyityHDhRvTS8eN+ppp6Qk5Xi0WD7ukNHup/7GL8xp5kp5+dfsgEfZl9LinO5Htvvxs+L/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277397; c=relaxed/simple;
	bh=E4/S7h7x9+VkHjz+trqpUCCjAbfa/5Fb4fkF5zP2WWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHdKRXzTx5tbojZG2l5VjnnZ7S1MGCouAYDeveQwfDAb+gwiRv0tj2pF9PFax9qpewUhdHTz7jB4ixZHsjCHnHIDFxGERAvrUuPzFhFJ+KEqk26M4Pdkrf9Wt9dIoC32IFjFCyu69nTN3G57CD5tC13puj6huVGqxkecsBH438w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjLk8Q+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjLk8Q+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1BDC2BCB0;
	Fri,  8 May 2026 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277396;
	bh=E4/S7h7x9+VkHjz+trqpUCCjAbfa/5Fb4fkF5zP2WWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjLk8Q+iHwQyjywvpCvrlThddaPjfA0/KW7CRqpZtRFNbAGzgwUw/Tn732VkbmWeF
	 JZgyUs6HKHSY6uy8MeTO51AZ+LiqFjo3qnmlggQLR1PqYvMSTjVEAGrpaJjf1VY6g3
	 VRAG2yKL93gQiRku2ORPFgMG/QupHaHQUeNB4xlxQ5kom9kRfpvyq30QyzQD5kxrHI
	 D+uFnS/Ys0/RglApXgB67b0ip6zGJoWuJVlpMxJTZ6U7NKjtZvb4s8kob30r7ip6zM
	 aJ7Xsq34gCpUimFZK1VY97zJUmyGJPKXgaXkXtXfsZPbdHHOjaVyJ0BmJa3S2L5F2X
	 5CGXGLyS1Oiqw==
Date: Fri, 8 May 2026 14:56:35 -0700
From: Minchan Kim <minchan@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <af5cEycgIu2GUicn@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
 <20260505145318.97692A14-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505145318.97692A14-agordeev@linux.ibm.com>

Hi Alexander,

Sorry for late reply.

On Tue, May 05, 2026 at 04:53:18PM +0200, Alexander Gordeev wrote:
> On Tue, Apr 21, 2026 at 04:02:37PM -0700, Minchan Kim wrote:
> 
> Hi Minchan,
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
> > + */
> > +void free_pages_and_caches(struct mm_struct *mm, struct encoded_page **pages, int nr)
> > +{
> > +	bool try_evict_file_folios = mm_flags_test(MMF_UNSTABLE, mm);
> > +	struct folio_batch folios;
> > +	unsigned int refs[PAGEVEC_SIZE];
> > +
> > +	folio_batch_init(&folios);
> > +	for (int i = 0; i < nr; i++) {
> > +		struct folio *folio = page_folio(encoded_page_ptr(pages[i]));
> > +
> > +		if (folio_test_anon(folio))
> > +			free_swap_cache(folio);
> > +		else if (unlikely(try_evict_file_folios))
> > +			free_file_cache(folio);
> 
> This condition is absent in free_pages_and_swap_cache().
> What would happen with non-anon and non-evict folio?

Are you asking about mlocked pages for file?

During unmapping, munlock_vma_folio() inside __folio_remove_rmap() clears
the PG_mlocked flag and moves the folio back to the evictable LRU list.

By the time the folios reach free_pages_and_caches(), if the folio is
exclusive, it will be successfully evicted. However, if the folio is shared,
mapping_evict_folio() detects it via the refcount check and skips the
eviction.

However, I realized we miss shmem folios in the swap cache due to the new
folio_test_anon() check we introduced. I will update the check to something
like this:

if (folio_test_swapcache(folio))
    free_swap_cache(folio);
else if (unlikely(try_evict_file_folios))
    free_file_cache(folio);

Let me know if I missed something from your point.

Thank you.
