Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B35445AF2
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031826; cv=none; b=aXjFpT9QvNJn6HLvgrTSJxAYD7rp7iIhQPAYJvBYzzi9h/B7bPW3zk5NJ6Kf3BG46JzoNOYGJMwPYUbHPW5CBUNGv0abFd5hvxgHRMWuqHGAkJ/tho9jDXmmh0v9sMt2l1c09GiuXBCedDxCjjZvbNdiu9G/UVFJlgkAw/u0Lnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031826; c=relaxed/simple;
	bh=DFDuu4u3kEC19GzAK9vAdZ2AnSTtPZQ33CXAXmTNzxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwSMaI15Evbz0sUeKHO7mmaHoXu3JFMxK/XKxUTC0apVJpXQkPOHkNlGWgynAsl5YkqCIwmdBPvaJr6OYOhhaeqxG/CefE+lRPt4y5Wy7rACPCd0Bkg9+/1Tgqp1zYGYHVqrtPo1uAlIcSVt5nKt59b/8HPmesCFcXpaceE8wjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cFaKBzdo; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cFaKBzdo"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c167c58f2so28277261cf.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784031816; x=1784636616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XrBPfnLDD8eQ7eCQ6RhRSXn0CPQXVWcRtTZW3fZ/anA=;
        b=cFaKBzdo9yl1w7KYnC8lvfszIozjiapNQNWHPK841tYddlBGhI7IWwgMf1clObOBIl
         OG38iBC2jQT6dm7BTaOO6a/5a9VPFwmcXIWcc8fTvmvNypRMP5+kftwfgtRsO6LPQ7tQ
         7KS45Sic8szMRdnWKd66XMq1TqYimgbL9dinQK+Afipb5QI02BNGfhDISvqKZJHTDYc/
         roc4Lpb8DARan9pU99l+NH14Qs5VwmQamfr9DDY9v3dz6KK3z7jxFkzzpq4we5HXeSkZ
         utMY3n6ocl1nS0bscSLBD3DFSXEq1ECwUM9vY1izK1ZEY2TCyqQxAjftUNZDkQ4snm1Q
         tphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031816; x=1784636616;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XrBPfnLDD8eQ7eCQ6RhRSXn0CPQXVWcRtTZW3fZ/anA=;
        b=XR9blgfqt4TtMofC3UV5x1nUHyi2dJr6M7tCq2h7Jfh7a6UuAUQIFX27F1J5m3T5kq
         oAS2AOAwPKlVL6hljLmWrmbzcm11JQns/ZbufeR6kFDt9UexqvPLp8oMVnxVpqCcWXmJ
         naimCVa2RlJLKweLedEeQb8XHjoNSEAHueDsiBeJ++SbhbPQUiA8yqI6Luzvw2DWp6tO
         9QHHPEdny9OTQmWzvgWQaybC55H+bPzI/wdDlWyT2VixWIHkscOe/1W1FWt5AGexrJto
         umbUoZdMYZZys+AGoWRWDqxrBYvaTo1te+B0h/SObfyC2ahsBN1Pgd8RfUCn+sjST/g4
         Ldww==
X-Forwarded-Encrypted: i=1; AHgh+RqVcRyG5cttfV/GJ8rs7eo+gEz1witaOao4W8zrlKose4YePnD6GWzKcjwY/Smvnsn8hPyos9rVX96g@vger.kernel.org
X-Gm-Message-State: AOJu0YwckQmmowKo/HFTS6VuKeqWfviL3uEKog0JwDBdn/8M9ArwqlAf
	3uTKdCTLXWo9dhWklbw2vVxVWsjFjxaHVCLZ4bqo3jN+xEMqPUHN7mjRdP5qgsV+4no=
X-Gm-Gg: AfdE7cnHyzVZ9bQH/Z4aFhGRcjB/CETgovagAZYWuvywb9k82uOM5D3Jd9hjMsZMBmY
	1SoZXj16MoSnlqj2+HMNsPmoGfuDeH1382fFrZw1OnLaBzEVkuryCbkQBEEoj0n1ZM/JAE6FXFf
	ugTiWH2EcN2e50F2B9cZHtQbdDRiSpevq01O5+fdIKELlBKddMB2NmVT0GEqVXW4892HN4XBXWB
	An7iXmsRM++zamWlXCANFD7KKD0AiVK+8yDL7UOpL+dO2AgjdKoHl/GRl5n/8Nuuabf+oUxCtz2
	tJPLJYwy0WMELsDB39za3+xROeZ9DXSatamK8b34UzKBSiMBglIq1UDXtptqm1KP0lLbb9okH3P
	+NQdyoJiyRKwmsdzOVAfu1erEmvm7dg7j/zNtEfuUpxeSNibLScGpxTzEM1k8
X-Received: by 2002:ac8:578b:0:b0:51a:8c97:9375 with SMTP id d75a77b69052e-51e42494cb4mr15995711cf.61.1784031816150;
        Tue, 14 Jul 2026 05:23:36 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacad30asm109896611cf.9.2026.07.14.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:23:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjcAg-0000000FRbN-3RTk;
	Tue, 14 Jul 2026 09:23:34 -0300
Date: Tue, 14 Jul 2026 09:23:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Message-ID: <20260714122334.GF3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
 <20260713181059.GL3133966@ziepe.ca>
 <yq5awluymdf6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5awluymdf6.fsf@kernel.org>

On Tue, Jul 14, 2026 at 09:27:01AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
> >> atomic pools. The pool allocation is keyed by the virtual address stored in
> >> the gen_pool, but the pages API returns only the backing struct page.
> >> 
> >> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
> >> to the gen_pool using their remapped virtual address.
> >> dma_direct_free_pages() reconstructs a linear-map address with
> >> page_address(page) and passes that to dma_free_from_pool(). That address
> >> does not match the gen_pool virtual range, so the pool lookup can fail and
> >> the code can fall through to freeing a pool-owned page through the normal
> >> page allocator path.
> >> 
> >> Add a page-based pool free helper that looks up the owning pool chunk by
> >> physical address, translates it back to the gen_pool virtual address, and
> >> frees that address to the pool. Use it from dma_direct_free_pages() while
> >> keeping the existing virtual-address helper for coherent allocation frees.
> >> 
> >> Tested-by: Michael Kelley <mhklinux@outlook.com>
> >> Tested-by: Mostafa Saleh <smostafa@google.com>
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  include/linux/dma-map-ops.h |  1 +
> >>  kernel/dma/direct.c         |  4 +--
> >>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 57 insertions(+), 2 deletions(-)
> >
> > This seems pretty suboptimal?
> >
> > If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
> > the genpool's addr so dma_free_from_pool_page() can use the same
> > logic, which is how things must be working at all today
> >
> > The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
> > surprised there isn't a Fixes line on this commit? I don't have an
> > opinion on the search, but since alloc_pages() is used there is 8
> > bytes in the struct page that could be used to store the remapped
> > vaddr to avoid the search if someday someone wants to improve
> > this. Maybe a small comment hinting that direction would be a nice
> > addition.
> 
> Something like
> 
> +/*
> + * FIXME!! We could avoid this by storing the remapped virtual address in
> + * struct page and using that for lookup.
> + */
>  bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)

Plus some if (!IS_ENABLED()) that does the direct lookup

I would just use : not !! :)

Jason
