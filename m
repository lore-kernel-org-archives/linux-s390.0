Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298FC3CB570;
	Tue, 15 Sep 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497478; cv=none; b=Ngxn08g2l5zkXK9AqsZ46ZxvohL9qRqvlW214lklWPD/lcMBCLKLDeMngQQasUrJpJn5nZ/W9rPSDfUe6rA6RDVftMxHGZv8wjlAjwnvF2fJysCrfC5KblSTO/ZePYlKcixtsO6uvgQFkdr/FbV7CX2tPAQ3ouqa8eEu3S2U3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497478; c=relaxed/simple;
	bh=Klx+310PRy5qwnD0SLscJxXqAV6R1h8pCRQIm8Fwumc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8gcjoA0znx/IKSwWCDGgZ0u7tvmBlOHsC0ynygugXboCIvam/3Oqk51BhBUDb1vWHntIL654JLuEagSR3pUwvQSlmr8UqND+iQZBDMSqGy3Qb/GXVXZkzMRvhOdCDdz4p8jMIjJ/iG8JpsTUJYhucdIfgL/xK0SQ0R4Kl+c5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEoX88do; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEoX88do"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E1E1F000FF;
	Tue, 15 Sep 2026 18:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789497476;
	bh=9E02YgiBpyTZKu+31wR0tLr5bMzt07hhGwsEwCkmANk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PEoX88doD61Dy5rzbllW/FcIDDbOq4DAALPWfQIeJTitzhFY2rnYcoTHy0BiUFznO
	 Nxxa6CD3mv9ZnfYYdheKxsLrCafA3LYDp3mvc9ybz1wpI8eydhTIYMP7+NyqkcqcMq
	 tlq6cyrx73qwfvRaHno0ByQ30zCqG1kzrSha6zZhqfg4qxQNPwvbWrEMvlZRt5Fzi0
	 a9dg7hqmHoQ1llyDSRfJ8ygnA9rOwuo9fqZrnVbkoDCr54PClhxn/7A6iXqSqbQXp9
	 jkQBtAoJI5gIWbbRBgeo6uFprzmZpvR8qW2vN4dkJosfY5Kh9OMnW9rNtpx0b0KihZ
	 6FKLJWX/Dn76Q==
Date: Tue, 15 Sep 2026 21:37:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/13] s390/cmf: Use kmalloc() for the CMB area
Message-ID: <aqmQf-H4yeSnE2Ko@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-6-e931086fdde1@kernel.org>
 <20260914175952.14910Fc6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914175952.14910Fc6-hca@linux.ibm.com>

On Mon, Sep 14, 2026 at 07:59:52PM +0200, Heiko Carstens wrote:
> On Thu, Sep 10, 2026 at 02:00:08PM +0300, Mike Rapoport (Microsoft) wrote:
> > alloc_cmb() allocates the channel measurement block area shared by
> > devices using the basic channel measurement format.
> ...
> > The measurement block origin must be 32-byte aligned. Each CMB is
> > 32 bytes, so kmalloc() provides the required alignment without rounding
> > the allocation to a power-of-two number of pages. Reject an empty area
> > before allocating it.
> > 
> > Replace use of __get_free_pages() with kmalloc() and free_pages() with
> > kfree().
> ...
> >  		spin_unlock(&cmb_area.lock);
> > -		mem = (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> > +		mem = kmalloc(size, GFP_KERNEL);
> >  		spin_lock(&cmb_area.lock);
> >  
> >  		if (cmb_area.mem) {
> >  			/* ok, another thread was faster */
> > -			free_pages((unsigned long)mem, get_order(size));
> > +			kfree(mem);
> >  		} else if (!mem) {
> >  			/* no luck */
> >  			ret = -ENOMEM;
> 
> This is the only patch which made me raise an eyebrow, since the allocated
> area is smaller. But it looks all good according to the architecture.
> Since the allocation changed anyway, it might also make sense to switch to
> kzalloc() and get rid of the subsequent memset() (not in the context of the
> above diff).

I suppose separate alloc and memset() are there to save a couple of cycles
when another thread is the first to allocate, no idea how important this is
though :)

I can send a patch on top if you'd like.

> But... I doubt it is worth it to send yet another version just for this.
> 
> The whole series looks good to me. Vineeth, Peter, any thoughts?

-- 
Sincerely yours,
Mike.
