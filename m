Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911961E8855;
	Thu, 10 Apr 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309519; cv=none; b=GJmsUOCtUxE74Afl4BRBN4E53MkD7mlqrENuo75yJP6Qp21uGZvHMKksqOxc4cqg5i58GFBdsp2D8fh17j7GaXxcAeQILBgij7FLQqj/zXLIbkvcCq2l9JH24uJ0+AEOf5jTCtQ9fONkU9EH2AMCcaOkjtg2+YlV9/JPByW6zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309519; c=relaxed/simple;
	bh=lvlpmFigayFVXPd9kk5VyUsMJXXuo4CeStlJWJalx+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix2kl+RIc8n6bGUCZHk73jtYb0cqn8wnUta7oonZKP3oVq3BWAQSMWuwWArG5scvs58+c3KCjmMvacuYTcSkv8+jnqtGLbGX6PoF/i1ejBQj5osUzsJMlLv89ywOIlmRWL4e4l02IB4kN69qh0oTaOfCXX1bUgc+YtkZMi1EM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g8JLUbGN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8JLUbGN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f4P+Bmos+5BJg5MJGwRJiUDUj9szeOXEjPkYvMGwy/4=; b=g8JLUbGNd9XBsYxDE2N/cU/ouz
	4U/BzJEJBcVHxWSbauBFYNUgfp2BFqfloNNe1shZS5h3Zrnp2RUXrdJ8R+6EEBdJ7OJqbtHVg5UC7
	tkLEVdWdyTl1ZB7A8vU645242WqlT0sZ+pU08Ui0SfqhFymHxeyuV/Ur8PoglMBGHtWQ4AoqMyv6Y
	Yj/BC8lsQGYtj2Lg2GorxlmBY25nZ5nMItGhc49F/IIt+6aNhzj7vbEIsSlUqbreHayZaIlXCoNLL
	0sZdXEMbu4abcbuqoHvmmWy3EiByq1p1EL7HE34/CYRvq/VOm1pFl04kw7tbymugqkAWO0uG73EJu
	NAbcAzGA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2waL-00000003FBB-37NR;
	Thu, 10 Apr 2025 18:25:09 +0000
Date: Thu, 10 Apr 2025 19:25:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: nifan.cxl@gmail.com, mcgrof@kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, akpm@linux-foundation.org, david@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Message-ID: <Z_gNBRY_1UVe2-ax@casper.infradead.org>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
 <C40778F7-6A22-4A0E-9566-9D3ACC697EA7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C40778F7-6A22-4A0E-9566-9D3ACC697EA7@nvidia.com>

On Thu, Apr 10, 2025 at 02:16:09PM -0400, Zi Yan wrote:
> > @@ -49,7 +49,7 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
> >  {
> >  	VM_WARN_ON_ONCE(delay_rmap);
> >
> > -	free_page_and_swap_cache(page);
> > +	free_folio_and_swap_cache(page_folio(page));
> >  	return false;
> >  }
> 
> __tlb_remove_page_size() is ruining the fun of the conversion. But it will be
> converted to use folio eventually.

Well, hm, I'm not sure.  I haven't looked into this in detail.
We have a __tlb_remove_folio_pages() which removes N pages but they must
all be within the same folio:

        VM_WARN_ON_ONCE(page_folio(page) != page_folio(page + nr_pages - 1));

but would we be better off just passing in the folio which contains the
page and always flush all pages in the folio?  It'd certainly simplify
the "encoded pages" stuff since we'd no longer need to pass (page,
length) tuples.  But then, what happens if the folio is split between
being added to the batch and the flush actually happening?
