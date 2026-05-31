Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FE3655E7
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223749; cv=none; b=YCAdaLnhTUnz2xEjLt+4600i3XhUl7jWIcU1/pCPDOOy3FU4/k9il0EqUD0NK09RWX7E+bXlLCSDfQGzlx6CtO9owLAdBGaZG8PsLxRifVkkpoMVjsdL6bzNnyRw41poWlHsU6zvkA7o3APa+yzh6uAl5TlVINGsY9r1DHwfmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223749; c=relaxed/simple;
	bh=NW4+2tiqPNneuK7lGmq70s/inYHVA2dgeKojZE9Nmxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/FpB/3ntw9IJ4Bz8lflTUHYMhHa7QtXJisereSqNaRwoxiu2TAtpbJFTdBxhsWX3MAbadRxsJM2KUr/SXU+CbrhHBK4EY4bBfMV2XjS2EW+3lXL0cRwYHmkyWjMB90EMrfk/pZ4muylzIySo7SxtyfivfMam+62NT/9BARzr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSZyimTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSZyimTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C405A1F00893;
	Sun, 31 May 2026 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780223748;
	bh=uHtRHgcYEeRj3PWjqMvgDLNMDnbNSegb1NP4rcPiudY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MSZyimTZqoGqoxZ7BDCj6a1SbrDZ7FzH8ySQ2qZWiugAgVb4xkWuKlPit318yiddz
	 wHNSaehMNsFPD6APeW8xUhmcJrRJFeypUQn6fcePCEqDxQb2/y3sqY+2664Mcvx3Uo
	 eKRFt1aOzSjQRYQexIKVMkawU/xnRuEhc37L/XGS5Kr4RZ5UuPk59rVDs5PGZKkCdx
	 0s0XWM+mYSxnAfOgCOGWewdoUYyb3ZxLGPe36nKZcqGEdZ0leXLOGM/wZWHmvBnTNQ
	 P/a/A6uTismcqj/mIbBmoiO8oJqEVeLj3vWgZGvAd5shmcos6j3zuhf+WLbeu37lFM
	 63/vxVIyQASFA==
Date: Sun, 31 May 2026 13:35:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/6] s390/dasd: replace get_zeroed_page() with kzalloc()
Message-ID: <ahwO_UCxePgb0SwL@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-2-b7108f54d722@kernel.org>
 <20260529101522.26496Bbe-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529101522.26496Bbe-hca@linux.ibm.com>

On Fri, May 29, 2026 at 12:15:22PM +0200, Heiko Carstens wrote:
> On Thu, May 28, 2026 at 10:09:50AM +0300, Mike Rapoport (Microsoft) wrote:
> > DASD driver uses get_zeroed_page() to allocate pages for the Extended Error
> > Reporting software ring buffer and for a scratch buffer for formatting
> > sense dump diagnostic text.
> > 
> > These buffers can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Performance difference between kmalloc() and __get_free_pages() is not
> > measurable as both allocators take an object/page from a per-CPU list for
> > fast path allocations.
> > 
> > For the slow path the performance is anyway determined by the amount of
> > reclaim involved rather than by what allocator is used.
> > 
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  drivers/s390/block/dasd_eckd.c | 12 ++++++------
> >  drivers/s390/block/dasd_eer.c  |  4 ++--
> >  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> ...
> 
> >  static void dasd_eckd_dump_sense(struct dasd_device *device,
> > @@ -6958,7 +6958,7 @@ dasd_eckd_init(void)
> >  		kfree(pe_handler_worker);
> >  		kfree(dasd_reserve_req);
> >  		kfree(dasd_vol_info_req);
> > -		free_page((unsigned long)rawpadpage);
> > +		kfree(rawpadpage);
> >  	}
> >  	return ret;
> >  }
> > @@ -6969,7 +6969,7 @@ dasd_eckd_cleanup(void)
> >  	ccw_driver_unregister(&dasd_eckd_driver);
> >  	kfree(pe_handler_worker);
> >  	kfree(dasd_reserve_req);
> > -	free_page((unsigned long)rawpadpage);
> > +	kfree(rawpadpage);
> >  }
> 
> This is not correct. The allocation is still done with __get_free_page().

Right, I didn't mean to touch rawpadpage yet.
cherry-pick from the large set went wrong :(
 
> I'm not sure about the whole approach / effort, since this allows for subtle
> bugs where pages are allocated and freed at non-obvious locations. All of that
> works now, but these conversions may lead to subtle bugs (this particular one
> is not subtle and easy to spot).
> 
> Is the net gain of this conversion really worth it?

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 

-- 
Sincerely yours,
Mike.
