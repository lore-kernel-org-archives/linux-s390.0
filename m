Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919491;
	b=GNC9VNGvphLxvvUTQqJKpaWy8fPYjrVv1VAmuDa0chlfAW1qyQMpYQlNEeLku9Csmj/Q
	 uoHobUw6Ty9zYbPguUPgtE9RUhau5Qftfd+85DQNqo7ZIA7S0n4T1MmNm+/cEcrUgO6EX
	 1+WXotWrjjKKV9cT95CNzp/0H5/EQr9Si0yL7dOsup3D9LD3kJpleJ8Q6XT1cEtscIsey
	 z7xEDx/n0Fxb7PK4RaHyAtddCBggu+VHl/goOpeXtXiztCAXuteZKLtNe1KKAwFUzuWQN
	 PTRJkX/1YxyK6pthscZwbILMLMRwSPVbN6mFqgPp1/uyRaB+xDAsDBQGwWzwgujQ3xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919491;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=w951ovg3w2Vsfylh3ccdzN6FDyrcXZTYdvPxHdlj9QY=;
	b=cTLC89k6GmjUQ8UofEwe8MkbBpPJunWgH6ot6ckaD5/apvqAjY+YKLbR3WwBH6kvrNNt
	 KeAzv1iDu8hGyCo49nx9GO/MVW7k39E7cLK86IWOOc0GOPx2eSGYmtvjskO6o8Io25iV8
	 EaRHBP4LSkBWjqOSu+O0nIirIw4qbczIo+LQD0/GeFcGkHCWaQ0WsLtxa4rJVJLxxz4UI
	 PCue/MtOWmQEWBSS6nQSEvT9csEmQgi9Wh4iA9hgu/8wpOlW6O5k2U32+cujgQ4waNtyo
	 gZ+zw0CXIQtrefUXjsBv6Czt7HG37fb9XNrA/xH7NnRtXZDByQj/knHJu2IfpT4CQFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBwzihIj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79095606A335;
	Tue, 17 Nov 2026 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBwzihIj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9431F000C4;
	Tue, 17 Nov 2026 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919491;
	bh=w951ovg3w2Vsfylh3ccdzN6FDyrcXZTYdvPxHdlj9QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YBwzihIj9Shh17NXGQFTAEvDovM8+5df3UglwbIP4LhlDO72jMNqyPF0WYqaMxoE5
	 l5OzmmQDWs6bndpK3tF6rQ3lBt1zG/W2Vr4hLKm0xMK5Q3tuGJG1nrSyzrUsBppXaW
	 SGkiwCNY7E+RlbeAppGntzan52lAp84hU06UHxtci+ahGbgAeTdRtu45d26OC8ja6O
	 3fEkU5hLUtqSGA/TZDUwg1RsB15zGb0qJLGToS4ZL8Ufc4PY4HfNys3VnAcnlDfQwK
	 nJPevvKsk4LSoOAzEx/JixDM6Bfp0Lr62Bqpj8jf8A4v/ui+HRG2kw8vE7zZM/LEt8
	 9JwP4xNMylkVQ==
Date: Tue, 17 Nov 2026 14:44:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/5] s390/hmcdrv: Replace page allocator calls with
 k[mz]alloc()
Message-ID: <avxMOsbgkaC_kQA_@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
 <20261116134656.125125Fdc-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116134656.125125Fdc-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 02:46:56PM +0100, Heiko Carstens wrote:
> On Sun, Nov 08, 2026 at 10:49:02AM +0200, Mike Rapoport (Microsoft) wrote:
> > diag_ftp_cmd() allocates the DIAGNOSE 0x2C4 parameter list used for HMC
> > file transfers under z/VM, hmcdrv_ftp_probe() and hmcdrv_ftp_cmd()
> > allocate the data buffers used for the transfers and
> > hmcdrv_cache_startup() allocates the buffer that caches the contents of
> > the last file read from the HMC drive.
> > 
> > These buffers can be allocated with kmalloc() as there's nothing special
> > about them to go directly to the page allocator.
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
> > Replace use of get_zeroed_page() and __get_free_pages() with kzalloc()
> > and kmalloc() and free_page[s]() with kfree().
> > 
> > Round transfer and cache buffers up to a page for the required 4K
> > alignment, without rounding to a power-of-two number of pages. Reject
> > unsupported sizes before rounding.
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  drivers/s390/char/diag_ftp.c     |  5 +++--
> >  drivers/s390/char/hmcdrv_cache.c | 18 +++++++++---------
> >  drivers/s390/char/hmcdrv_ftp.c   | 14 +++++++-------
> >  3 files changed, 19 insertions(+), 18 deletions(-)
> 
> ...
> 
> >  int hmcdrv_cache_startup(size_t cachesize)
> >  {
> > +	if (cachesize > KMALLOC_MAX_SIZE)
> > +		return -ENOMEM;
> 
> What is the reason for this check? I can see that this seems to be a
> common pattern, however the buddy allocator would warn as well for
> allocations larger than MAX_PAGE_ORDER if I'm not mistaken.

Since cachesize is a module parameter there's a very corner case when it
could have value within a page of ULONG_MAX. Then round_up() wraps to 0 and
kmalloc(0) returns ZERO_SIZE_PTR rather than NULL and does not warn.

The module would load with a bogus cache instead of failing as it does now.

While it's really unlikely to happen in practice I'm sure Sashiko will be
unhappy without this check :)

> > +
> >  	if (cachesize > 0) { /* perform caching ? */
> > -		hmcdrv_cache_order = get_order(cachesize);
> > +		/* the buffer must be 4k aligned, hence round up to page size */
> >  		hmcdrv_cache_file.content =
> > -			(void *) __get_free_pages(GFP_KERNEL | GFP_DMA,
> > -						  hmcdrv_cache_order);
> > +			kmalloc(round_up(cachesize, PAGE_SIZE),
> > +				GFP_KERNEL | GFP_DMA);
> 
> ...and that check wasn't here before.
> 
> > diff --git a/drivers/s390/char/hmcdrv_ftp.c b/drivers/s390/char/hmcdrv_ftp.c
> > index 3312b2ac00a9d..e22789b532de2 100644
> > --- a/drivers/s390/char/hmcdrv_ftp.c
> > +++ b/drivers/s390/char/hmcdrv_ftp.c
> > @@ -238,16 +238,16 @@ EXPORT_SYMBOL(hmcdrv_ftp_probe);
> >  ssize_t hmcdrv_ftp_cmd(char __kernel *cmd, loff_t offset,
> >  		       char __user *buf, size_t len)
> >  {
> > -	int order;
> > -
> >  	struct hmcdrv_ftp_cmdspec ftp = {.len = len, .ofs = offset};
> >  	ssize_t retlen = hmcdrv_ftp_parse(cmd, &ftp);
> >  
> >  	if (retlen)
> >  		return retlen;
> >  
> > -	order = get_order(ftp.len);
> > -	ftp.buf = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, order);
> > +	if (!ftp.len || ftp.len > KMALLOC_MAX_SIZE)
> > +		return -ENOMEM;
> 
> Same here, and as far as I can tell the Sashiko finding seems to be
> valid as well, even though it looks to me as if this worked only by
> accident. Also, as far as I can see, the reported "delete" command is
> currently not used at all from the only existing user space
> application that I'm aware of. But let's not change this, please.

Sashiko is wrong about get_order(0) returning 0, it actually returns 52, so
__get_free_pages() returns NULL and we end up with -ENOMEM anyway :)

So it's either keep if (!ftp.len) and let it fail for "delete" like it does
today or have

	size = round_up(ftp.len, PAGE_SIZE) ? : PAGE_SIZE;

and allocate at least a page for ftp.len == 0.

What's your preference?

The ftp.len > KMALLOC_MAX_SIZE check seems bogus indeed.

-- 
Sincerely yours,
Mike.
