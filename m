Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627C35839C;
	Thu, 23 Apr 2026 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776987501; cv=none; b=MUj/GPV0jDVI8KBaoBIm8LLmHCajCtgR+kc7qlG6MHPNQeHl7+ycoyvRpBgDu0bxiFEeC+8aksuTHImQNPwY+g6Nc8ZzIyW9tEQyoCQCqFv6RxxHxVTGF7d6Xfs9uGsT80DbdIiZnCshKHLNhJR/XNxhFsoLML8iE49GIIlQ3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776987501; c=relaxed/simple;
	bh=m87qmd7Z7VaIUVFoNxdf2avdmQw/zQ+LpBXrHU3kp3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s079rKLSFJNYXTbrG+oRQ1HbFfRMgXr+1BeXFg3mlwBT70P9SQWC7wrV07INYv6mU2vw1qTR0KGA9VeA5Q/2i7jj+S04Gj2xYK+9SuWSNtnOVQItEYCJOcyW67n2Ntc1OLyIHpfD/GULeFeRVnK3/Btm8UexrP7l5cBROyJWPcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur5+oKf5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur5+oKf5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A10C2BCAF;
	Thu, 23 Apr 2026 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776987501;
	bh=m87qmd7Z7VaIUVFoNxdf2avdmQw/zQ+LpBXrHU3kp3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur5+oKf5omajvu4YTf4FQLfJpFR7xWxwrKvdnuS6jTpwApmMfG/zUCz7pTF1gdkHq
	 EDd3QWmhLxHPGclw5caWcxpq8S9oZC003AqYOb4pj8tDoNiVotVcyaMxyd01Y/+BWH
	 vpykZTPIqeo5syvHkBnrgJtvqVImkYnH/H4ZXw33xkch4F9Af+N1wVRk5EidtAwXPl
	 cvEojTI8NOTZzK4UFmVPpkNUpjcJd7uLcZkSR9KcP0ECZdrfyGontr+eA0W+0LCs+G
	 ouvortnDt7jiSXxzb8F8NcPgzaYJ4hc1RkSXuRsqmKE2uR0hqm9+fBy2q61lqiZqXE
	 rjjeh4jG8sOcA==
Date: Thu, 23 Apr 2026 16:38:19 -0700
From: Minchan Kim <minchan@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <aeqta5Uqta0uw_eE@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <b6a6eead-cfd2-4459-9c6d-384dc6cd72d8@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a6eead-cfd2-4459-9c6d-384dc6cd72d8@linux.alibaba.com>

On Wed, Apr 22, 2026 at 03:22:46PM +0800, Baolin Wang wrote:
> 
> 
> On 4/22/26 7:02 AM, Minchan Kim wrote:
> > For the process_mrelease reclaim, skip LRU handling for exclusive
> > file-backed folios since they will be freed soon so pointless
> > to move around in the LRU.
> > 
> > This avoids costly LRU movement which accounts for a significant portion
> > of the time during unmap_page_range.
> > 
> > -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> >       exit_mm
> >       __mmput
> >       exit_mmap
> >       unmap_vmas
> >     - unmap_page_range
> >        - 55.75% folio_mark_accessed
> >           + 48.79% __folio_batch_add_and_move
> >             4.23% workingset_activation
> >        + 12.94% folio_remove_rmap_ptes
> >        + 9.86% page_table_check_clear
> >        + 3.34% tlb_flush_mmu
> >          1.06% __page_table_check_pte_clear
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >   mm/memory.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2f815a34d924..fcb57630bb8d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1640,6 +1640,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
> >   	bool delay_rmap = false;
> >   	if (!folio_test_anon(folio)) {
> > +		bool skip_mark_accessed;
> > +
> >   		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
> >   		if (pte_dirty(ptent)) {
> >   			folio_mark_dirty(folio);
> > @@ -1648,7 +1650,16 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
> >   				*force_flush = true;
> >   			}
> >   		}
> > -		if (pte_young(ptent) && likely(vma_has_recency(vma)))
> > +
> > +		/*
> > +		 * For the process_mrelease reclaim, skip LRU handling for exclusive
> > +		 * file-backed folios since they will be freed soon so pointless
> > +		 * to move around in the LRU.
> > +		 */
> > +		skip_mark_accessed = mm_flags_test(MMF_UNSTABLE, mm) &&
> > +				     !folio_maybe_mapped_shared(folio);
> > +		if (likely(!skip_mark_accessed) && pte_young(ptent) &&
> > +		    likely(vma_has_recency(vma)))
> >   			folio_mark_accessed(folio);
> >   		rss[mm_counter(folio)] -= nr;
> >   	} else {
> 
> Seems we should also skip marking exclusive pmd-sized folios as accessed in
> zap_huge_pmd_folio().

Good catch.

Will update in next revision.

Thank you.
