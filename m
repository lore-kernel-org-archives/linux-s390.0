Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7560C481CD;
	Sun, 13 Apr 2025 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744580083; cv=none; b=kRiV34VpeJHyXzYYFuUDbtyKqa+LwVvAFvh1Cbk4txCqVzgID8O+vqPvWvQWdxZGAjiRc/MeHgNViQhK1jaL1lazLlH6Cf1OtKqTgPayZE1P8emcqp2j7R9I7AkqvKt/nZr8n33NWwMl2N3Yaw9TyhCguRtfRx5Xpjvq8yeFzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744580083; c=relaxed/simple;
	bh=ggMjZ4LO0s6OYI9yoV/CFmPg5mUlDMpiyzDg4yVY9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik/wBuUgOsnlKmaClkyf5ZhRmQ8MDpEFVC4joWufSnpnnT8fjoV3izAYTIpTkt1fjaWCaWPwXseX/L2v7DFI9FVGDDfA1j1C0T7+Gm6IxLf+jKg1RnEdyROr7R68ZRHQtAB38kCphWvLdEAPuPMlMhZ91+3anPs3x4xB5LeSDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tz+4SBcu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tz+4SBcu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NprLifJ2si08c/zt+3ORc7MOgkSki3DeRgZA8ugV5VM=; b=tz+4SBcucm3JcU7e28ZPcDRI7a
	B5GiHsNzSWbbKpEAelQjrN9/zMwGj2U/xAsVsTS/bsdqXXgntzvwEYUC0XoIO7OiSC2KlgIrJQb+f
	BFbVfS21m1LBozLMuxbej2YHXwuobTvwQAvAka81sxi0Fps8wBeLJPKVxHaD/FTGtZ7KV7dzl0kKp
	TZIH19OP0NY0aZCvY4qqJdl2435C97w1ZcCjtl/vK12egWLUCnuRV56G2QlGcA6/gGn3KFtGMdjLa
	HGCFRfoliXO8kFsxaVseSeJvMpRx9Qo80uiY0RPqwluVVMjzDpu+NhtCEMZy/UYZkQBT1b6MhkGJD
	KGSMVt1g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u44yG-00000007IMO-3RB2;
	Sun, 13 Apr 2025 21:34:32 +0000
Date: Sun, 13 Apr 2025 22:34:32 +0100
From: Matthew Wilcox <willy@infradead.org>
To: nifan.cxl@gmail.com
Cc: mcgrof@kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, ziy@nvidia.com,
	Fan Ni <fan.ni@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH v2] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Message-ID: <Z_wt6M4P0nkM5y8Y@casper.infradead.org>
References: <20250413042316.533763-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413042316.533763-1-nifan.cxl@gmail.com>

On Sat, Apr 12, 2025 at 09:22:21PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The function free_page_and_swap_cache() takes a struct page pointer as
> input parameter, but it will immediately convert it to folio and all
> operations following within use folio instead of page.  It makes more
> sense to pass in folio directly.
> 
> Introduce free_folio_and_swap_cache(), which takes folio as input to
> replace free_page_and_swap_cache().  And apply it to all occurrences
> where free_page_and_swap_cache() was used.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> @@ -522,8 +522,8 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
>  /* only sparc can not include linux/pagemap.h in this file
>   * so leave put_page and release_pages undeclared... */
> -#define free_page_and_swap_cache(page) \
> -	put_page(page)
> +#define free_folio_and_swap_cache(folio) \
> +	folio_put(folio)

Since you're respinning this patch anyway, you can delete the comment
about sparc.  This file has included pagemap.h since 4ee60ec156d9
in 2021.

