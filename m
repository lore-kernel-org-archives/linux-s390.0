Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920912;
	b=1iumnCiRMGnNWv/BNjW+4VidwUvakAxJw7LTa8Vz9rz9XSYsi4D9rr/b7paLXYkqr6wS
	 i43eKJYS+tGsCQ2feu8i1yFoZUnfruLgB36pFe+ozg5xgaGOqrI24XhMKBfNt7YWqeoUX
	 SeogmuIMk+Zx1/PbjKXFXSASNHzQlUiov89PXntCHd8uLMzY3CnYEx00EPt386ABWfedP
	 fVbx/l0I4zScEQ4/peLI63Ji1Bv0kSuwMpJg2Rn1BHMcWHZMCU3IRheSxcE5ou+grof7H
	 Lcb0Knavcq2OliaiIZ8ve9Mb0tX+1u4SUVrqyr6vqouo1fuJNsUlTv2NiVrz0NLOYSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920912;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BS0imCMGjfHQIl7YcMlSSRR5WwouJwY7rnnH2z0iY9k=;
	b=lSnbK6FzAEpxMyZydUnpK0qdDPxMPWI6D3O7FUwIUmqy8hBmtDvIvucuS6e16M/7h2e7
	 YzJYzd99hoYxuot6ATGU1XDiaeH1WKHHM3cVNuxxrbbJa/lqCwhbvuUL+BpEnb7tTNZgw
	 Qb3ggyLlGn/Y5nJGN/43A+J/0M2aDX8vrwQKPKLxB608ThbXwqlO+2fLhBuGCJLGgWnMM
	 Ny23zWm+mDxWTi6db6OgWZ9Or6yN3O0bZLfeV3p7Nhxx26zRFct4Gz6fZckRByp4iTfcc
	 wB5cERt4kuDgUtLgkboUjiis/zQ5yWSDfjIIwIVdttMjafmSq45bHmdgca3/hnTI+Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/EKTTkr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F7606A32A;
	Tue, 17 Nov 2026 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/EKTTkr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA861F000C5;
	Tue, 17 Nov 2026 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794920912;
	bh=BS0imCMGjfHQIl7YcMlSSRR5WwouJwY7rnnH2z0iY9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X/EKTTkrhL7VBc+MAtvhnoiN6TlDDymKZP3H635lhyaJgXZPXq+CGFoCJaYsQeErf
	 n3rH0EVLDsvvQA8N1q/GAMK75x8van3jVyPbUSImS8uutMMlB4oQbgD0Y9uw8VjkZU
	 uPIG/3VvO19OnQn5StEm9+ThFHK5ZQkWsFAn3Ecz3ZgxTg5Ck0p5om26ccLjDsESJQ
	 RvbUZ9QWTglB1cpSYnGDBxd0FAA6LWYxmBIVNo79dRHflXW3SHth55c7/sr/JaebYl
	 tgwXWbE0fJj8Ls1x+6B/ycBHC+Tl8CyyLn9bAzgksVp11MM69PmicD7KGPFMrZRgFP
	 Md+FWgg1UZ6IA==
Date: Tue, 17 Nov 2026 15:08:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Message-ID: <avxRyt00VGvWlKea@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
 <545cec68-2444-4dcd-987d-cea05ffe3362-agordeev@linux.ibm.com>
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
In-Reply-To: <545cec68-2444-4dcd-987d-cea05ffe3362-agordeev@linux.ibm.com>

On Mon, Nov 16, 2026 at 04:12:56PM +0100, Alexander Gordeev wrote:
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
> > power of two.
> 
> This hints that the SCCB size is less than PAGE_SIZE, which is not the case.
> 
> > An SCCB must be page aligned and kmalloc() guarantees that
> > the alignment of an allocation is at least its largest power of two
> > divisor, so the extended SCCB is still page aligned.
> 
> This implies that the slab size path was taken, which is also not
> the case. Yes, the result is still aligned for PAGE_SIZE, but for
> a different reason ;)
> 
> I would suggest removing this whole paragraph. I can do it if you agree.

I'm sending v2 anyway, will drop it :)
 
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
> >  	if (!sccb)
> >  		return -ENOMEM;
> >  	sccb->header.length = length;
> > @@ -119,7 +119,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
> >  	}
> >  	sclp_fill_core_info(info, sccb);
> >  out:
> > -	free_pages((unsigned long)sccb, get_order(length));
> > +	kfree(sccb);
> >  	return rc;
> >  }
> >  
> > @@ -173,7 +173,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
> >  
> >  	if (!SCLP_HAS_CHP_RECONFIG)
> >  		return -EOPNOTSUPP;
> > -	sccb = (struct chp_cfg_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> > +	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
> >  	if (!sccb)
> >  		return -ENOMEM;
> >  	sccb->header.length = sizeof(*sccb);
> > @@ -193,7 +193,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
> >  		break;
> >  	}
> >  out:
> > -	free_page((unsigned long)sccb);
> > +	kfree(sccb);
> >  	return rc;
> >  }
> >  
> > @@ -236,7 +236,7 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
> >  
> >  	if (!SCLP_HAS_CHP_INFO)
> >  		return -EOPNOTSUPP;
> > -	sccb = (struct chp_info_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> > +	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
> >  	if (!sccb)
> >  		return -ENOMEM;
> >  	sccb->header.length = sizeof(*sccb);
> > @@ -253,6 +253,6 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
> >  	memcpy(info->standby, sccb->standby, SCLP_CHP_INFO_MASK_SIZE);
> >  	memcpy(info->configured, sccb->configured, SCLP_CHP_INFO_MASK_SIZE);
> >  out:
> > -	free_page((unsigned long)sccb);
> > +	kfree(sccb);
> >  	return rc;
> >  }
> > 
> > -- 
> > 2.53.0
> > 

-- 
Sincerely yours,
Mike.
