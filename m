Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C33B185;
	Thu, 11 Jan 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYTvwOvR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=46hDqLrBU4o+X3RCK6SwhB9WIHISUx+3GZIkcU5jLBc=; b=kYTvwOvRfo/CvjW9j/ib7X2Zdx
	JiKN2FGwsbNHLtV5fXZNA7ai43GvyJ6c8nZKlRxrR25ggTTeF0RXCZGDuHnR9eTi0iKqLySttryug
	wzUsjVhlfGINbxqYvMtmP5mPWIOvqt4ulOmQdMOH82/zpAp6+hBRWCrSUinfqOEjSg0sov4durCsr
	2IO8urhz82cX6/6CSbGG9eQOy/2GeutnqEaDxtJz/SOIEyiv0KJ+fRGXOR7ePOkQhpz8eHNCMndYA
	VuKOTpB917pcNrU06Bq7ItazjrA9lq9gI12RPNV8xDLJewbc3RgfF2ewso0lsdYYFk5ZzeTM3C1Mu
	4MYT3sEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwBh-00E3Xt-6Q; Thu, 11 Jan 2024 14:37:41 +0000
Date: Thu, 11 Jan 2024 14:37:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	david@redhat.com, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/8] mm: swap: introduce pfn_swap_entry_to_folio()
Message-ID: <ZZ/9NZKf3X3TGDsa@casper.infradead.org>
References: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
 <20240111111239.2453282-2-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111111239.2453282-2-wangkefeng.wang@huawei.com>

On Thu, Jan 11, 2024 at 07:12:32PM +0800, Kefeng Wang wrote:
> Introduce a new pfn_swap_entry_to_folio(), it is similar to
> pfn_swap_entry_to_page(), but return a folio, which allow us
> to completely replace the struct page variables with struct
> folio variables.

I have the exact same patch in my tree except I called it
pfn_swap_entry_folio().  I also noted:

    Thanks to the compound_head() hidden inside PageLocked(), this saves a
    call to compound_head() over calling page_folio(pfn_swap_entry_to_page())

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
