Return-Path: <linux-kernel-owner+w=401wt.eu-S1755169AbYCLXNT@vger.kernel.org>
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 1/6] Guest page hinting: core + volatile page cache.
Date: Thu, 13 Mar 2008 10:12:22 +1100
References: <20080312132132.520833247@de.ibm.com> <20080312132703.132176945@de.ibm.com>
In-Reply-To: <20080312132703.132176945@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200803131012.23420.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: virtualization@lists.linux-foundation.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, hugh@veritas.com
List-ID: <linux-s390.vger.kernel.org>

On Thursday 13 March 2008 00:21:33 Martin Schwidefsky wrote:
> @@ -957,6 +975,19 @@ struct page *follow_page(struct vm_area_
>
>  	if (flags & FOLL_GET)
>  		get_page(page);
> +
> +	if (flags & FOLL_GET) {
> +		/*
> +		 * The page is made stable if a reference is acquired.
> +		 * If the caller does not get a reference it implies that
> +		 * the caller can deal with page faults in case the page
> +		 * is swapped out. In this case the caller can deal with
> +		 * discard faults as well.
> +		 */
> +		if (unlikely(!page_make_stable(page)))
> +			goto out_discard;
> +	}

Dumb comment: seems like this if could be folded into the one above.

> + * Attempts to change the state of a page to volatile.
> + * If there is something preventing the state change the page stays
> + * int its current state.

Typo "int its current state".


>  		return NULL;
>
>  	pte = pte_offset_map(pmd, address);
> +	ptl = pte_lockptr(mm, pmd);
>  	/* Make a quick check before getting the lock */
> +#ifndef CONFIG_PAGE_STATES
> +	/*
> +	 * If the page table lock for this pte is taken we have to
> +	 * assume that someone might be mapping the page. To solve
> +	 * the race of a page discard vs. mapping the page we have
> +	 * to serialize the two operations by taking the lock,
> +	 * otherwise we end up with a pte for a page that has been
> +	 * removed from page cache by the discard fault handler.
> +	 */
> +	if (!spin_is_locked(ptl))
> +#endif
>  	if (!pte_present(*pte)) {
>  		pte_unmap(pte);
>  		return NULL;
>  	}
>
> -	ptl = pte_lockptr(mm, pmd);
>  	spin_lock(ptl);
>  	if (pte_present(*pte) && page_to_pfn(page) == pte_pfn(*pte)) {
>  		*ptlp = ptl;

Did you really mean ifndef here?

(BTW: I'm just reading through the code, not really understanding it, so
this is not a real review).

Cheers,
Rusty.
