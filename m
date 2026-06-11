Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B53E7176
	for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177864; cv=none; b=Op/eIYotgAuSiVv67hEWW6yuN5AWn6smBfKWCNKbMtsxeoJA3taRoisT9FbeoshYXCZbo/XWNUL7OVDeVhW0QTvX1XdjyhmM4Xf8VU2aVbGqIhDo7kSJUMpgBN1P5XYCbW4boOUh/Xr1pR2PQ8u6EGigKvCY1V5YCJFwFTiB57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177864; c=relaxed/simple;
	bh=orxD3R+xslULBC2Qa+4Si7LAvHUVQFpXJKWY1Fr3wjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPfNSKGbkdvMBjLvK/YHchzA3cJN6qQuIQyGWClF9gDFJ0uLo9NdhACb6SMI26XTNPgqIeb7uGYM1l9tRMzTSiMBzOgVn8ETloqRvraxR5FPZ/innA0BtS4fxTANGRaObK1MWyBvghiE5Z4V+8p9L1A14lIgwksmZjgmTSsFouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jSSrQ/R2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jSSrQ/R2"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce3876a50cso80032026d6.0
        for <linux-s390@vger.kernel.org>; Thu, 11 Jun 2026 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781177862; x=1781782662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
        b=jSSrQ/R2vKn6AUzSYTH3h3LeC0O0C8znEXHi2HolbDUI5lH2AUaQB+aLH+tCmOmjwn
         U6LW/r5qnXzB6DbBJOSsB/JXvZ5RcHmVGpLg9GdwuiDhNGioac7I1S5JjImJxE4WcoLW
         Bgmuf2vAKiJfh5ysJGoCFwzUeiQ21Pb5kOgtMdb4lKjnhajv2yv1xvEYPDgkPyFr9T2K
         OmkArXxJzgD9GFfkvgA8J49weQcIyn0DYdku2inQ0lHcE8EL4+TId4Yih8DI2r6v71jx
         DylioDM7bI7RpeYoMcdMOmDYCXVROiLTIcwYi9ZMhjnHRmflB6caw+Pe2kLcElK/sr8m
         yyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177862; x=1781782662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
        b=BpE5PTngEJSKgm4sIwOiAAbnS8drx04h8YFR6G0IW8Tg36uNI9v4F2DPoQvJ5C+8Ul
         K8AxInksPYw0rdb/mJGKqrlElSdUIwhUuYOz0883dOHGpUDTYxRgVwEqrQKxaDCm0Bkk
         R0Nz25DGP3nKIhFpussQJm55xmPutgHMVA8sEQA8SWsQOFbDq6a8ORbCS/VkHSHEbLn1
         WWK1wBxwf2er11ZDTRDGjnH02z1CZ93Vq0Wr0y3TC9lvfrQZx2Gxlkvw9OgTAwoSDH4v
         PWFFh9bOwXyv0wQMx9cJz1tBxgqrGpPMIQFOJfyFGpwVMB9uMlyq5wD1MMdKAQv8P8mE
         noJQ==
X-Forwarded-Encrypted: i=1; AFNElJ88FSzVcsORp5P9oMUhzFL9l1MvLqqMrIkyQYxdTX1W3hsU4yEu6HHnDFsYTttB5R+3z7eEurGFYQIV@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJ6G64+pr5zMgU7N0nzEQm2NmRnN2+hBOCey+jhAZulpmBm5G
	GZ7AZx8veMlehroD6uCfAOO0jLbTftkRltBHuCDUdoNCYcHT4NMlWpGGUh7JbutVh6k=
X-Gm-Gg: Acq92OHRM+M48t1gyzeKtiLcp5QFfrxktpRYNBKpcZWljyWzzwJ1b/vN9u2FiwCH02L
	E1zZC2b9XbodTLyUOCgchWxbsRMJYGiiyWO08nOMMazpVyRf62YNKX2Zq3Y9YDOg91RBTBxsOVI
	kWKRNH7QLxU0jxEJv5Ng8hUgOY6x1+pRhR1t02kyTetFM3qrr914gB/1d4Eee7wU/z8fOGl38M0
	9jm9NJKIRyB5ewoMdfW9qPIUpC5vBIkZ22X/ZsFgrf955Jembm71PKAghw/XT7E/WS42Sw5OcZO
	9KFMbOVoJ9k99hjUQVEQ7AW3aI2C3MgCIarWUjfT0dkxCI+nEEDQ8z3WJGQRVDN6uJvjTgAs+Hj
	V66//L/zKf6yZkI4I9K3qH3/5UwQKaH+C5m/s5XJgMQDCLVTtU1bEpVB4Jga60wIVtO/3viCnAV
	S/7tsNGKSuVQwm6vYzHUOX/kTIE3W4xMTPmI6EkavgqMi9nMfr5cHLxWNp/6XsKXpnceML61p6S
	mFhz57FggHTPTf+
X-Received: by 2002:a05:6214:410b:b0:8ce:b2e9:a4c1 with SMTP id 6a1803df08f44-8d1d8cfbdc0mr38674016d6.14.1781177861623;
        Thu, 11 Jun 2026 04:37:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e838f586sm15478786d6.20.2026.06.11.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:37:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdjA-00000005ezW-0ftx;
	Thu, 11 Jun 2026 08:37:40 -0300
Date: Thu, 11 Jun 2026 08:37:40 -0300
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260611113740.GB1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5aa4t1myw4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa4t1myw4.fsf@kernel.org>

On Thu, Jun 11, 2026 at 10:55:47AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > The sashiko note does look legit though:
> >
> > 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> > 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > 					   gfp, attrs, NULL);
> > 		if (!page)
> > 			return NULL;
> >
> > I don't see anything doing the force_dma_unencrypted test along this
> > callchain..
> >
> > I guess it should be done one step up in dma_alloc_attrs() instead of
> > in dma_direct_alloc()?
> >
> 
> I think we should do something similar to what dma_map_phys() does here,
> considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.

Yeah, I think that's the right idea for now..

> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
> +
> +	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
> +
>  	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> +	} else if (is_cc_shared) {
> +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> +				attrs);

But it would be clearer to put the test in the iommu_ functions I
think, since they are the ones that have the issue. We will need to
fix it someday..

I think we can ignore the op-> functions, arches cannot support CC and
still use dma_map_ops..

Jason
