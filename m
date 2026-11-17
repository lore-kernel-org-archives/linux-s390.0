Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920931;
	b=3RR9VZzTUuy0Myujyk2V+64AfjyvuKoQ96i14rIKiEHAP6BbiBg5ZOT1XwAolBxju6Ph
	 g9Yd9LQjB2ULCdwtODufHbMohNqNodp4IKWucCcnxs0INe776NjfKExE8GSsWJsQonjrQ
	 AYmH5z9UdBdKYxaN2enM0TErihdFl6HXAE56P5IRE/woBjG/cNqxJ8Fydi/PK7Pf9BqNT
	 l8b/qr0OscK83nOu+pYgzrqhXK5cBTq5TXDjA1DpUKnafze+aqGBLTNhEdARn4P4s+dvv
	 6rk3M5yl5LLP3oKUjCqqtAOTtwSWCoyFhBalqgXgdy0S675V1+mJ2sh5twijTE1xyPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920931;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uqr3O4xFJCd//nDRyguxXGm2AzeSTGRjfBy3lG9BNl0=;
	b=mjGgge3gZCs6XYju2AcdGzQ3V2pX0L62Vdckk1rDuYsvj4qlbaFetGxxM+2QqpwXgbkd
	 gfrBU926qyzecq7QKXdjrNklsJ++SJW+Ibo3eak9iybVXTT7gdgn8Q8J5kB+8t3HOqLNL
	 ZRavxHdvDggr8C5KLv7JMnzcWC3uJSZVvwm3GMgGdzyRU+1TmI2qv3aZd+4gOLWoXUkEl
	 Yru9O9noS2+tiXxv1Yd7NxQ8chBeWJFoCC8UPk1TTI/NBzyns+hCNlJrv+bdjGbft8Wdq
	 eBOXsUDF9CyMlIA5A6mktlDtHvLstZ9wBcQCOhJNfg9wMeo6QVw8+EIjOP15n03YBcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipfbuUt6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F720606A329;
	Tue, 17 Nov 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipfbuUt6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612531F000C4;
	Tue, 17 Nov 2026 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920931;
	bh=uqr3O4xFJCd//nDRyguxXGm2AzeSTGRjfBy3lG9BNl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ipfbuUt6iDNEvOEcW3itwqtyZzyCe8HrMhOaBXpKKWm20mDPL+NLsT0N38Chk95Yt
	 h0xp4BybsS1jpB8bMG6cLoYjojA3Cn+nJDRdtdgESdiuC5C3aafZj0dIeChoxOO5Jr
	 qHywk3g6C+YAPUfwUjPwNEHo/Md77D5e5bOk45MQHwjpwHk+BUz8aJzWKyK4jJ/sQI
	 fth/+iTBhR/UhlXnACdWApYiwK8FcMuNf4lVM8XzL8SQ4OYK1oxnYZBVFtjIL9R3XY
	 YS92hpKXgR3cYXUhH//A1zw6ZrrMXLcfQ9eCCCakebmlWAfAbtdrmDQjwlQuUkLTvl
	 /5+m6pC7wTZ6A==
Date: Tue, 17 Nov 2026 15:08:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Message-ID: <avxR3PtPa4Zh4pxr@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
 <20261116152216.165348Aa5-hca@linux.ibm.com>
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
In-Reply-To: <20261116152216.165348Aa5-hca@linux.ibm.com>

On Mon, Nov 16, 2026 at 04:22:16PM +0100, Heiko Carstens wrote:
> On Sun, Nov 08, 2026 at 10:58:41AM +0200, Mike Rapoport (Microsoft) wrote:
> > _sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
> > allocate the SCCBs used to read the CPU information, to configure a
> > channel path and to read the channel path information.
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
> > While on it, allocate only the amount of memory the SCCB actually
> > requires in _sclp_get_core_info() rather than rounding it up to the next
> > power of two. An SCCB must be page aligned and kmalloc() guarantees that
> > the alignment of an allocation is at least its largest power of two
> > divisor, so the extended SCCB is still page aligned.
> > 
> > Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
> > and free_page[s]() with kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  drivers/s390/char/sclp_cmd.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> > index 1dc93d945be6f..6aaf1f6a3633f 100644
> > --- a/drivers/s390/char/sclp_cmd.c
> > +++ b/drivers/s390/char/sclp_cmd.c
> > @@ -102,7 +102,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
> >  		return -EOPNOTSUPP;
> >  
> >  	length = test_facility(140) ? EXT_SCCB_READ_CPU : PAGE_SIZE;
> > -	sccb = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA | __GFP_ZERO, get_order(length));
> > +	sccb = kzalloc(length, GFP_KERNEL | GFP_DMA);
> 
> It is a bit subtle that this really works. EXT_SCCB_READ_CPU is 3 * PAGE_SIZE,
> so we end up with a guaranteed 4k alignment from the slab cache, which is
> indeed sufficient here. But this is really not obvious, and not as stable as
> before, IMHO.
> 
> I'd prefer to have this changed to:
> 
> 	sccb = kzalloc(PAGE_SIZE << get_order(length), GFP_KERNEL | GFP_DMA);
> 
> which comes with the same alignment guarantees as before.

Ack

-- 
Sincerely yours,
Mike.
