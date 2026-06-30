Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67546AF3B
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835370; cv=none; b=qQTrA/n7+Gh/6QWWBdvLwKZyB8RIDIoWD4MjEQF4ejjAeJYIEmePdMB9Q0y5B1vZwMHTDqHQqjxc0w2/cIBuMx6XKDpw13wWvojLDFK7dRVCisigTG2aA5av/k3727zvnm1h9qWL1qiebjrHs9TfqDqr9iCUdpv6YxvSjnfrM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835370; c=relaxed/simple;
	bh=kHw7DLrL4QjCK55x79lTHIkq15rpEE6+NeVSt2Lz+08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzp5GWfhxVyiphoe4SR8dIxFeG3C1UbsQl7Tc4RYYozidXXi76ywgMPgdCunPfd3YDCGVi5+r6BG3i9/ScJikEuaeJSq7YwSy23ExAT54neX0up1SrIcw3rPggUd0m99ec2eqIEaiF9KTLiqyMQmJyksAfsRMvz9HC33nksV8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oAv3KPde; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oAv3KPde"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e50c5d14cso153612185a.2
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782835366; x=1783440166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
        b=oAv3KPdedZiBYPAKOd3BNJKidX7yI83EZrsgIkAgm39IxaWkcZuYJXws6zuK+gcm+u
         SHxUl2bZI7AaZ7AdKTj3jb1T1fwFI6nzhGZuaaisVNMH28BEpw/SIZBgtIB5Z1cKYBB3
         WLMROfmOT1z6zUF4re3Jl83MIVhUDNm0opyKa0EACC69EMj0uGmFWg8UGuV2iVf1wYNI
         u9hJIYvLTvmMkFa/ndCCDe3APfD6EBXlyQF+J6chHpbCOZmWx8Ljz+MTgS2ljwji1hbf
         3KezeC/uRqIrWm31u/sPUHugaZ8Q9vQArwRzgNSwB/zbJqne/uMSFPhgk4lLKyPRX2QD
         APag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835366; x=1783440166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
        b=ECfL+CRGsPlnXQXnqXoPDJ0qpME8ZYu3xOYfm6u4YXjtposEzLkeCFtq29UCDTPXpa
         4r1J+cGE/Bml4o1LPHkI11NMdsc0RWA6fCLS/wPdyIGd2CGezMgvEHZ49342YO4dkuDB
         W9bzFWguPWeF+/7htNkXseG+KR3nEXXBoneCLAT3RKmFIFTg0W5x4uAO9+DTYUABrqmX
         FwL+cnNhM71K9QcQccPyClO6JQh7PnaXRtxgvLg+Rgt5w+XNZmzlaMj7lvgeRVcSfkkD
         1zdujDU6AdmWy+EHvRUqq+HkkYtYY/B1J3Buj7l/qXKq0a+vJqQ3QLUKzu9U8IDsaVG9
         mbYg==
X-Forwarded-Encrypted: i=1; AFNElJ9jw2kAW1BZoKwKF8tmfDkdxQipjs8fMCcqr9OZX60B6VTiZui9QgVoUEqN7gCfjrnj9NM8+6OF056G@vger.kernel.org
X-Gm-Message-State: AOJu0YzOneDdxC/LW7JrdlzC6nI4QJWdUWUUXgLjSB8zsWSgNiw3Rocy
	rTCQcIQ+L91RtQqI0NhpgtsQEHyJzeOQoVXgbId7Bxpj4HWI3tV9rI7rLORckg7Md3Y=
X-Gm-Gg: AfdE7clSwusg4T5f5nT0ZfqZru694L5AvTeHqcJnd6FqC+7UClGpBRDkgBMQtwOfBuy
	6AzcuF3fNj9nzsNR5josn7KskTqUlmrZTnARsNmsrlX72InfV4Poa56gM6+9OPfy1uodHibqCvx
	ZvyUrhh3ieZt+tjgqlO/BWY7IODX35L2/TDZsa9kANvcMeuCoZ0HmBOGsa4UWfOEzXUWS9Ot1E1
	sr427PC1Tt/Tp5Wznn18Aveig+hk9dku3HAxvChoPbiuxsby7d5I/BxfftioaoKoA3hGZpkUK0W
	EtuiTXLx0lCWS6cI+Q+T32EuJhYSlkazKrJG9ISF3UbfHsV3LZ2zswR7N1olpzw0++PsZElzzbg
	iPHu+OxB5Curtviyf8WBSEejGasG4n1eKU62miWUQF6qn9hpfmTrljrralY1D6puSGD0MMcH4tO
	ZKPxVcT/ur44UL08MdB1pn27rNhEFpl27gR50iBzf2emUIqIn/sZOYFceiD0GtTM7bNds=
X-Received: by 2002:a05:620a:839b:b0:915:c4de:7ac0 with SMTP id af79cd13be357-92e6278d80fmr646181785a.31.1782835365891;
        Tue, 30 Jun 2026 09:02:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6236b9fcsm262102385a.41.2026.06.30.09.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:02:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weav4-000000027Ay-3dT0;
	Tue, 30 Jun 2026 13:02:42 -0300
Date: Tue, 30 Jun 2026 13:02:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
	"Cheloha, Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260630160242.GI7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>

On Thu, Jun 18, 2026 at 12:39:21PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 18/6/26 01:41, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
> > > > @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> > > >    		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> > > >    {
> > > >    	bool remap = false, set_uncached = false;
> > > > -	bool mark_mem_decrypt = true;
> > > > +	bool mark_mem_decrypt = false;
> > > >    	struct page *page;
> > > >    	void *ret;
> > > > +	/*
> > > > +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > > > +	 * attribute. The direct allocator uses it internally after it has
> > > > +	 * decided that the backing pages must be shared/decrypted, so the
> > > > +	 * rest of the allocation path can consistently select DMA addresses,
> > > > +	 * choose compatible pools and restore encryption on free.
> > > 
> > > Why this limit?
> > > 
> > > Context: I am looking for a memory pool for a few shared pages (to
> > > do some guest<->host communication), SWIOTLB seems like the right
> > > fit but swiotlb_alloc() is not exported and
> > > dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,
> > 
> > Then setup your struct device so that the DMA API knows the
> > guest<->host channel requires unecrypted and it will work correctly.
> > 
> > I think this is a reasonable API to use for that, and I was just
> > advocating that hyperv should be using it too.
> > 
> > But it all relies on a properly setup struct device.
> 
> Sounds good but how do I do that in practice? 

I think we haven't got there yet, I understood Dan's plan was to add a
bit in the struct device that signals if the device must be
unencrypted or can support all memory.

Currently the dma api assumes all devices must have unencrypted by
default so it should be fine already, shouldn't it?

> not externally available so I'll have to trick the DMA layer into
> using SWIOTLB (which is still all shared, right?) as I specifically
> want to skip page conversions. Setting low DMA mask won't guarantee
> that the DMA layer won't allocate a page outside of SWIOTLB and
> convert it. Manually do

Why so particular? Any address that satisifies the constraints should
be good enough?

Jason
