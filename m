Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DD34C9AD;
	Fri, 24 Apr 2026 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777067809; cv=none; b=shL774AJuKc+YtzDroTuRCFVIFCskxgGtbVi8TxC/7nMFmAwuhdmI8Bo5LLKH1Gqc6Tujul8pJpYez/ycMh6902r+hn0k4XHrr7R95nbb6V07ot8Tl6glaKOvewo/WiDe/DaFvxQ0YXieIL/nLmc+MHAYFn8nPqJ/G2KBgwmuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777067809; c=relaxed/simple;
	bh=bDOd/gakIbkBKObfCe2HtqThY9/sGAFIg0LgcuIt8Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+ZmxZCX+/DFEnuWwsNnb9G7hFRIUsV2Y83Jttu9aziKjeTURCJWC4IVWv6cPLlP90H745nHEwK2n0Y2XP+PM6+xhPFmKy20iq2iWd1vgUWZA60C7hXJWnNIHvgqeTCFvpuP+uagaaX23dX5dA0eQeSyGCc+b4XJWWlxZJBdeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP5Ta0oM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP5Ta0oM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78664C19425;
	Fri, 24 Apr 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777067808;
	bh=bDOd/gakIbkBKObfCe2HtqThY9/sGAFIg0LgcuIt8Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EP5Ta0oMk2Y+untGzKqrixCmcUbFndrmsNr6pjlfH0xBaEOhKEZjBLObEo1ab3r5a
	 VcnLsFYRL4Yq9sG999Igj9FIXZQN7oRALgrvT8iOisTIKWQk7/IDBL3nxSu1LnEPL5
	 h7wT/AhjwNzVUFrMPDFiNXLwf101hJoCwmesVRw1WC7Cvx4zSIks9qByQMX0r8/Lrp
	 Yzf4M1fBzi3S4+ClbXww0DBvvndtWUsRWpq2CqhSdBSg/y7D/Wj5BE+Rz/3bfdIn+a
	 sensTX9uA/2CMzrcTLVikpmvhOd25qH00TaSUQkHItwFR+oJEoERHQaEr2My+tyic3
	 l5yTdF8zC0k0A==
Date: Fri, 24 Apr 2026 14:56:47 -0700
From: Minchan Kim <minchan@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <aevnH-0yVstaPjiJ@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
 <aevFb-ZemUo4nB3I@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aevFb-ZemUo4nB3I@casper.infradead.org>

On Fri, Apr 24, 2026 at 08:33:03PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 21, 2026 at 04:02:37PM -0700, Minchan Kim wrote:
> > +++ b/mm/swap.c
> > @@ -1043,6 +1043,48 @@ void release_pages(release_pages_arg arg, int nr)
> >  }
> >  EXPORT_SYMBOL(release_pages);
> >  
> > +static inline void free_file_cache(struct folio *folio)
> > +{
> > +	if (folio_trylock(folio)) {
> > +		mapping_evict_folio(folio_mapping(folio), folio);
> 
> If we already know that the folio is for a file (and I think we do?)
> then we can just use folio->mapping here.  On the other hand, if it
> could be KSM or something else weird, carry on.

Thanks for the review. It made me think about the shmem corner cases.

Since we already check folio_test_anon(folio) before calling this path,
we know we are dealing with non-anonymous folios.

My specific concern was shmem folios, which are not anonymous but can
be in the swap cache. While mapping_evict_folio() might technically work
for them at this point (since remove_mapping handles it but I might miss),
it feels unintentional and fragile because mapping_evict_folio() is
primarily designed for page cache eviction, not swap cache.

To make this robust and safely adopt your suggestion of using folio->mapping
directly, I think we should handle swap cache folios explicitly
in the main loop like this:

void free_pages_and_caches(struct encoded_page **pages, int nr,
		       bool try_evict_file_folios)
{
    for (int i = 0; i < nr; i++) {
	    struct folio *folio = page_folio(encoded_page_ptr(pages[i]));

	    if (folio_test_anon(folio) || folio_test_swapcache(folio))
		    free_swap_cache(folio);
	    else if (unlikely(try_evict_file_folios))
		    free_file_cache(folio);
	    ...
    }
}

And then we can use folio->mapping directly in the helper:

static inline void free_file_cache(struct folio *folio)
{
    if (folio_trylock(folio)) {
	    mapping_evict_folio(folio->mapping, folio);
	    folio_unlock(folio);
    }
}

This way, we are guaranteed that anything reaching free_file_cache() is a
non-swapcache file folio, making the direct use of folio->mapping safe.

Please let me know if I am missing something here.
