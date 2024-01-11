Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2196433D8;
	Thu, 11 Jan 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UxZKmTe0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eyV353Gb3rs9D7r5JzxpgJQ7hyZY60SX+2ttc0hiYio=; b=UxZKmTe0o39V6jtqPpN1r++qn3
	QvmHm8Z1fGYtYLQxLwJ1Yj9QpZjZCZQ0yG0Z7LzIMIuSspNBLa85Yk5Lw37IxZpJ5UsyUFtBRfocT
	Qi7VYvAgzO8A7QLvICl7VjBMo7x8dZOgdrpPtor6oittNSXMmRwNpTYvn2IItMK+9YLwHV1tJZGcH
	KHcoc9nuhGm8RelzJv81LEruaIvmY2arDd8YdoO3tmQD/wXMAR6CYActZpOXPUuQy+vXfDezqUj5G
	glEM2QQknqRd1YyCNmzZyksp74mbcFuLYU+Y/rc1U1WqFqIQ1bzq+33kR4LNWkCITZV2A4Ecmv5jc
	DNcyKaGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rNwDP-00E3bj-Rz; Thu, 11 Jan 2024 14:39:27 +0000
Date: Thu, 11 Jan 2024 14:39:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	david@redhat.com, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/8] mm: swap: introduce pfn_swap_entry_to_folio()
Message-ID: <ZZ/9n3gitoBnq8na@casper.infradead.org>
References: <20240111111239.2453282-1-wangkefeng.wang@huawei.com>
 <20240111111239.2453282-2-wangkefeng.wang@huawei.com>
 <ZZ/9NZKf3X3TGDsa@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ/9NZKf3X3TGDsa@casper.infradead.org>

On Thu, Jan 11, 2024 at 02:37:41PM +0000, Matthew Wilcox wrote:
> On Thu, Jan 11, 2024 at 07:12:32PM +0800, Kefeng Wang wrote:
> > Introduce a new pfn_swap_entry_to_folio(), it is similar to
> > pfn_swap_entry_to_page(), but return a folio, which allow us
> > to completely replace the struct page variables with struct
> > folio variables.
> 
> I have the exact same patch in my tree except I called it
> pfn_swap_entry_folio().  I also noted:
> 
>     Thanks to the compound_head() hidden inside PageLocked(), this saves a
>     call to compound_head() over calling page_folio(pfn_swap_entry_to_page())
> 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Oh, and I converted a couple of callers ...
migration_entry_wait_on_locked and change_huge_pmd.  Those should
probably be added to this patch.
