Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194411FC10E;
	Thu, 10 Apr 2025 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744311122; cv=none; b=Ie1xXN8ubWaCeZnVV8wQDyAaXyVGUm9Hp4K6hBN27p/xwSxVG4XwfUOtT3kmKQQyppP9mV8+O6BEjYv+3hXl3/Mg+krq1Vwa41jezFFSop26I+GNm5h8uE6NHVHYLtjruSKUqsT59A76KVuh0KfKEQIx2AwXp6piwUaiRoPFZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744311122; c=relaxed/simple;
	bh=geZDvZePwyITqRYcUFYHx0BERKIuGg+vxy2E5uxV2Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iouK6lNYw4G9YjLTgkSIRf/NQfJe+EIbpIoU5EwZp074ZOiwJF5PNiGBCBi061F8tYWAR9RFx50Z9H2DkuL6V48xiZxhPD7KALKbS955oouXoLot570ThyfUiBFFovS0i4tKZzL0sK1Wr74pSfxqAhupf54u5TNQBMI7p1owNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dE2zDHZV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dE2zDHZV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5xOoxBESvFSvlUi8RPYrSqpLBX72FlC4rdxePaYq4Gk=; b=dE2zDHZVBGxsKX19KxDVtzXuv9
	y4Snvzc1lBYtTc0UU1E6WgAc3re9u6h6/lXS/lHtuUS0cI2wim7Wg9WtKq9f1p5HYz5CPeurau+CI
	amOROTcdM41zZA7izjcpyBqeTzD1FlUShNn4mpSNB0iX/Bom9lNh3LTBSHea5qnvsf1cPaMIjE8OK
	40FbiSyGsbXj3C/RCNEsQDtd9FiL6MmNJVsh7FfRtZ4od7UtySId35TI6w3jmRrPcdrMLPjLk135k
	Kw7id5r8oQ627iXpG9Qi69/GC7SloEvieLZYiGoGKijFThFlgBQdvDtn8LIYSgnsFCfIBrv086/YR
	/AGhI3lw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2x0D-00000003GdX-2Xgc;
	Thu, 10 Apr 2025 18:51:53 +0000
Date: Thu, 10 Apr 2025 19:51:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, nifan.cxl@gmail.com, mcgrof@kernel.org,
	a.manzanares@samsung.com, dave@stgolabs.net,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Message-ID: <Z_gTSSJ8RnRrvFz4@casper.infradead.org>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
 <C40778F7-6A22-4A0E-9566-9D3ACC697EA7@nvidia.com>
 <Z_gNBRY_1UVe2-ax@casper.infradead.org>
 <83e8b1b3-fc73-4a49-9f6c-36489c3f39d6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e8b1b3-fc73-4a49-9f6c-36489c3f39d6@redhat.com>

On Thu, Apr 10, 2025 at 08:36:34PM +0200, David Hildenbrand wrote:
> > but would we be better off just passing in the folio which contains the
> > page and always flush all pages in the folio?
> 
> The delay_rmap needs the precise pages, so we cannot easily switch to folio
> + nr_refs.
> 
> Once the per-page mapcounts are gone for good, we might no longer need
> page+nr_pages but folio+nr_refs would work.

Ah, I see.  And we'll always need to support 'nr_pages' because we might
have COWed a page in the middle of a large folio and so there's no rule
we can possibly invent that allows us to infer how many pages of the
folio are mapped.  We'd have to go and actually walk the page table
in the rmap code, and that sounds like a terrible idea.
