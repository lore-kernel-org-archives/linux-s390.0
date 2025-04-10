Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7E1EE004;
	Thu, 10 Apr 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308692; cv=none; b=WBL0iXqH/sD0h7kalzoUPAf1OAim4QMOtuVrb0DKQ20moOBEnfupeTF4BunRQ23SSDZgHyBmSTvaGvW6x5bHbrpMf9n6kYviYBukHIXSvB185I/P3v2tJyVBfMsdFo0o6hAhERxv8wKZ9TQLtLm4Qf/hBMNUSMTbquL4KRunAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308692; c=relaxed/simple;
	bh=XaELMhMPffpadeqwtJNrzE0tHmrKYF5+77sC/YzWm7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2K7Yh3wS5+JBpTiM+IvkPO7W0kj8pMS/Ea/Ia9kmtEYshVYSMT/OFYXsv4ErFNAh/jf7fI4L5fCZ5oPxDmO/QdCRFdEO0g7BJqxx149bdv0Mi5OEDl+TTwdGgWpvCcurGfearaqf+qX6Spm3rJRIeggeH3zSSjFR/kbVkhiA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RKe35nLl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RKe35nLl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yyuMpWN1TzmvBH3elyBl05iozN5VhyzZZE5A2u1FTkI=; b=RKe35nLld+M1O+UUdR42XC0y9h
	E0/JYpSjH4ruxAAQqlFDX8GG83afIQumInqD4LOKIYSyXjemx1WXUqvmtujL6xHW0GWDyuTUfvNgd
	BmBUpwQuRd1EcLsRuUK2336CNMhcWAk+en4DK2L/mH4oej5b4sBhyNrjf3skJIVoSnsojKJ37Cefe
	8owOATtmm4QxN6EvvY7Mm1mL+34MwQTc+j809hDrfgoytJy87W2CxuXNdqEtN6sg24QJMkU5bU069
	SlLmWMtp33c9seSGf33gnRCRM5ioI9zBA/pfNQTLWFo251a4sijHZXNV1leCFqLaq/3Ac51zVGSwW
	ldi/O7Qg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2wN1-00000003ERs-3FBV;
	Thu, 10 Apr 2025 18:11:23 +0000
Date: Thu, 10 Apr 2025 19:11:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: nifan.cxl@gmail.com
Cc: mcgrof@kernel.org, a.manzanares@samsung.com, dave@stgolabs.net,
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	linux-s390@vger.kernel.org, ziy@nvidia.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Message-ID: <Z_gJy1h-IoRP0JDO@casper.infradead.org>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410180254.164118-1-nifan.cxl@gmail.com>

On Thu, Apr 10, 2025 at 11:00:31AM -0700, nifan.cxl@gmail.com wrote:
> @@ -522,8 +522,12 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
>  /* only sparc can not include linux/pagemap.h in this file
>   * so leave put_page and release_pages undeclared... */
> -#define free_page_and_swap_cache(page) \
> -	put_page(page)
> +#define free_folio_and_swap_cache(folio)	\
> +	do {					\
> +		if (!folio_test_slab(folio))	\
> +			folio_put(folio);	\
> +	} while (0)

We don't need to test for slab.  Unlike put_page(), we know that slab
cannot be passed this way.
