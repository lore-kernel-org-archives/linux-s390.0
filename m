Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7933E5EFF
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284448; cv=none; b=u04nToTlzPG/7iI4ki+Rdx0MzM+m9lqjkyS8PoIHNc6nYbbw7HlKDEvsNgh/T/AYUi/TmVWJfxTZz9zYWH7ww0Ai4VVKHHMW/IHS4ZExkqKffxzHV4yCzk02LMVXTqv9wReZx1cpIzv0vPWOOxCu1KUMXoKhvtWA9Fv5WKCwzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284448; c=relaxed/simple;
	bh=gECXMGpw9B7sH8oWBrgJbLY+YztieOR6VxnjmWmVTTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv2sM/LfJMDFj/PXGVuDoEhwSKEYWfkvPDTPxfX5MVDBTFnsKDqNNvbyp51FX5NGq4SxgcnuSUQ64egbWbv+LZwukQinj+b1Faf6Xy/ckesGIe7fy9BMdah6e9+BnZFemzeQg22CDyi1e0pIcM6AzdND1Uf1gFQsiXpV/A2vpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GRJry4BV; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GRJry4BV"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b4298d271fso105060126d6.3
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779284441; x=1779889241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
        b=GRJry4BVIMcY40woHuF/zrD7rHNKtx9oAQ/gKnuFPXFk4H0K9uHggvOJpVwrb2QgLq
         lO8c6mvV/ABUv8n4k+SyqZkXJT51g2uremUxRWIAhsCIVKJPTvjSWDdLzl6QV/Ci6Lg0
         Fb6Qjiy2xhOUk6wVB3bRW42UMNUQM77n99Ax6D58oUqel5fNZeNRY7awW4RLrg2RpREa
         cf/JCLEhyoSzGHnKlUNJJrigUIIVdsYwmKhrX8qR6L8BIAHuYMlrVISaB0v0DdiCK9iU
         uQm5PNMv2eoWVBAFv8s+i/Bt9GdL9IPmuE0+saMojYNmXTYuMVfwq3Ov+51OvHaptyhl
         l5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284441; x=1779889241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+SwQbDLFG0Y+rBu9pL52xRO2ueMe5MsHi84X45A//o=;
        b=KnZRekZXkoTzcBZ4h+MGTl9nIxrUIjifVwDVKr0kl2z6olhrKEfYuIItU6UIcxXP/4
         F3g6oJ+2xSHpyhZtsyQan/6ZOvFORqtPEIVTFI0cpJxjqnSLkCups6EdZC3OU130gdJJ
         bs+H43TUqSvW7wyfZFBJaUM0isZrzGnVPFKXnjXOYtolMvGnkBvhYy9U2EWvRywpPcu9
         WIFTDppkA5l34xPgE+WL09hWbQ93lT1mPji8OGa7yrdux09JFWu0LvZIJsCSr1YZPG6h
         bjkDoTuj1UrkXwcSCCPqeQkd2WY31QJMM5vJIfd05F5qXgpF+ktJ4Mm9dAZCBxrh47zq
         BHmA==
X-Forwarded-Encrypted: i=1; AFNElJ/D2VQT98oRVD4T1Nt8kl6ShCF8loCdI37OVOwcXXKKB9U6OKki56fZKADntEYGYIwSt6sX06VW+bI5@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqGV5gUVzdq1POEOh5iXiInzIyeKc9S8uUM2ngTA/176dnChs
	MLk5UD+PcnTowp5BVakVDoqM4J00S6hKFGZAbR8uX5LeK4cfJvA7WeSUtIpAfhqrSKs=
X-Gm-Gg: Acq92OFwGjhAR1WWiprKBZApKVu8PHba9xl7H5PEsga/OfJRp05WEtvwF7AQkwW8VHq
	IHYrV8QuKuG+w8oYDVTIKza74k/xuK5+nEppuffBpwWkjUxhObbjyHTA7VcmJg50NkI/NBf5DYO
	JQzrhAv23hASUBHvh26Mq4viCZKDKm4RCSatSu7cKttOZ4hbQjGmCYh3coMNWSLCQuNsdYzOiMn
	oA7vr3HoupOz7sq+zE5QNnQ82RDJUgunYESvCK9uzHoQd0B+iWKNBkTj5NBz1DOaHYPoYexwQXe
	qeMCtPhfD1gXC4wNjrD+CKgf3cEw4W3V7gN9ejbAmC4B+h2ma25C16ghIleoCN3G7b6IexJgNxh
	nnnmiWal7TI6wKrJN0NE6v7iuTNUp93pf0dF0sIEHy9Wpa+TCtvHtyndOi3BDRw/bV/scsVcEYv
	ta7iPXxRLtqcHgAdsFe6DYncf/mXGwvg3u7RSUeaUVbucJlNT9CIC8abaRQwIFSQmkpaWt3ibsf
	X37SntF4efAziPl
X-Received: by 2002:a05:6214:5c42:b0:8ca:16fd:7297 with SMTP id 6a1803df08f44-8ca16fd752cmr347910676d6.30.1779284440966;
        Wed, 20 May 2026 06:40:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360ac735sm122405916d6.19.2026.05.20.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:40:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPhA7-0000000HB8S-389S;
	Wed, 20 May 2026 10:40:39 -0300
Date: Wed, 20 May 2026 10:40:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260520134039.GT7702@ziepe.ca>
References: <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <yq5amrxvshxg.fsf@kernel.org>
 <yq5abjebsaid.fsf@kernel.org>
 <20260519152741.GM7702@ziepe.ca>
 <yq5a8q9fs7ud.fsf@kernel.org>
 <20260519161120.GO7702@ziepe.ca>
 <yq5a5x4ispg8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5x4ispg8.fsf@kernel.org>

On Wed, May 20, 2026 at 09:27:27AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, May 19, 2026 at 09:35:30PM +0530, Aneesh Kumar K.V wrote:
> >> Yes, that also resulted in simpler and cleaner code.
> >> 
> >> swiotlb_tbl_map_single
> >> 	/*
> >> 	 * If the physical address is encrypted but the device requires
> >> 	 * decrypted DMA, use a decrypted io_tlb_mem and update the
> >> 	 * attributes so the caller knows that a decrypted io_tlb_mem
> >> 	 * was used.
> >> 	 */
> >> 	if (!(*attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> >> 		*attrs |= DMA_ATTR_CC_SHARED;
> >> 
> >> 	if (mem->unencrypted != !!(*attrs & DMA_ATTR_CC_SHARED))
> >> 		return (phys_addr_t)DMA_MAPPING_ERROR;
> >
> > Yeah, exactly that is so much clearer now that the mem->unecrypted is
> > tied directly.
> >
> > That logic is reversed though, the incoming ATTR_CC doesn't matter for
> > swiotlb, that is just the source of the memcpy.
> >
> > /* swiotlb pool is incorrect for this device */
> > if (mem->unencrypted != force_dma_unencrypted(dev))
> >     return (phys_addr_t)DMA_MAPPING_ERROR;
> >
> > /* Force attrs to match the kind of memory in the pool */
> > if (mem->unencrypted)
> >      *attrs |= DMA_ATTR_CC_SHARED;
> > else
> >      *attrs &= ~DMA_ATTR_CC_SHARED;
> >
> >
> > Attrs should be forced to whatever memory swiotlb selected.
> >
> 
> But that will not handle a T=1 device that wants to use swiotlb to
> bounce unencrypted memory. That is:
> 
> force_dma_unencrypted(dev) == 0  /* T=1 device */
> attrs = DMA_ATTR_CC_SHARED;
>
> In that case, it should use an unencrypted io_tlb_mem:
> mem->unencrypted == 1

No! The DMA_ATTR_CC_SHARED only states the nature of the source
memory, the DMA transfer will always happen under T=1

It is perfectly fine to memcpy from shared to private and do a T=1 DMA
from the private memory if we have to bounce.

Jason
