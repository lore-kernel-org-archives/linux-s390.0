Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEF26A0B9;
	Fri, 24 Apr 2026 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059188; cv=none; b=DHeWWptwDdFfWsld6f8jPyQ7GrhV9aSl6EGl7yQwiksGnlD4Pg3PZq1nvvN8dXPn0r+W45cw4uhDr6GXwGhI036hmNVRtIjC/JFTCOIcNfZpQaoKY0vErUnZCfU4wsT4pR/qYTibFqmcOl8satpRcfrCwiC9Z/1EnijcDzY4x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059188; c=relaxed/simple;
	bh=+MYRbr3OFdV6Nbv+dV/7GlmTEIKQUJcsRWcYZSxJ0Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpKD9CC6Qyh2mfd/iVM8nDzuJ8iZIzohlJdwW2qZFayXRSndqtRYXvRHbuCULNxwBw5PwjMdu/cTn4lp+GiUmoMoEtTeNBC28NUFst/aGjhuuy7HZ04/6TjhlmqHYoHivg8ezMhxJ+o7ew3SadrnprewcH2D91bvJcFwP7KO2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xr6CBaIa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xr6CBaIa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2PAallPai3NT1Ru+JLoUF71PzOdI7Dew3EE7u60fC4=; b=Xr6CBaIapBw6xdIU6KkiuKamAU
	hhXfugzjoN1SzNwKa+AVSxK8MLw6gLgrFm8LB83ADQf37w8XGME1BmN0zQRbsQD6InAJvK7uZ2T6M
	Q6OeG/vjJk8H+ogxA3RQDIGtoi7TX1iuIRK0jV7z3i5KC3OO7PPv8fWnQuTnT2VQSEa19ewGDDogv
	kpJFRvfq5dwzrtWgJ7dmj5wzgZ7OYRjBhNZHx2Z/wEGZ/cVWgz6RGJYDTi/Y1J6nR0eh0pDaTge6D
	KRINvi/gXQIzWE6QRHNfq5mL0zLE5g1GCPE8ft/lldpy4oyyhe+7tDjUU8VjAnfHormcQWKauTOMV
	qQ7pEnDw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGMGt-0000000Fhjc-3cRb;
	Fri, 24 Apr 2026 19:33:04 +0000
Date: Fri, 24 Apr 2026 20:33:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <aevFb-ZemUo4nB3I@casper.infradead.org>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421230239.172582-2-minchan@kernel.org>

On Tue, Apr 21, 2026 at 04:02:37PM -0700, Minchan Kim wrote:
> +++ b/mm/swap.c
> @@ -1043,6 +1043,48 @@ void release_pages(release_pages_arg arg, int nr)
>  }
>  EXPORT_SYMBOL(release_pages);
>  
> +static inline void free_file_cache(struct folio *folio)
> +{
> +	if (folio_trylock(folio)) {
> +		mapping_evict_folio(folio_mapping(folio), folio);

If we already know that the folio is for a file (and I think we do?)
then we can just use folio->mapping here.  On the other hand, if it
could be KSM or something else weird, carry on.

