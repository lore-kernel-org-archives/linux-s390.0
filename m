Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167A395243
	for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885477; cv=none; b=tb7GXKPBDGUVyJj12YYRZEk5HFRUc55qQuf2u7T1PWJFsAgNRMnRSzVmHgaxb9DID+8zDtGnVO0x0IisDoV8SQkUYLhDUKGIFunQAYOPbupfltH7vf64O6PQj+Z1i/4AF1KsYRE3aLMJBFsVc+dIybaQyEBDW8ZA7WEHHM2NFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885477; c=relaxed/simple;
	bh=r4o8kNBsfNITnPuziuAzBiGGbEdWSyP9HN1hm0J0N4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4GysLD0u8iUGNfKvLKBbC/4u0yKLMwLwfMHN9gOMS226Lj+0MBq0pD+tHJ10/5e06atWnHtCIlqznEm3SXq5faouGIdv8z9ZaXNqp2Uj27xXadTaydqLZhcVuDNhUOyX8ANlpuVBkg6p6dAzogv78+QjVHEH+WG1FS7HGqJXxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Aa0y6wdw; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Aa0y6wdw"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-512f750d4b2so5858601cf.1
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 15:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778885475; x=1779490275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=immH+g/3RYXTN+iTjjy3LaccswRoDpZE21Qsh/sCfkE=;
        b=Aa0y6wdwQdQJLuCuY/J6Ayi18P0IsRvuPe0YESsaCTGj+OO0A5qnFHHcArUPwbkZGy
         /3ULnMIrCpJoEetah300odJn0ZTP7zL4u931d6v530FQLI+cKc6MytplXK7f42ZNmDye
         GYPbzLh5UN+19W7GlUtMnLQsSJDo6N8KbuHI+5McYxjwDz/40SaydbXb/viLnl8RQtMW
         eASlY0Wmk+GSzHnhIxDOIVQ2pV9i7V29UM2YfwziWKzwA4WBsNSh8f1XNAAtawSLWvjT
         OiG8OnZKZpXow0kNgbvekOLs0yITBrmUcJjN5cMA2Wy2UQtdit/RGN5NzF4+TYHl2Eiw
         xnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885475; x=1779490275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=immH+g/3RYXTN+iTjjy3LaccswRoDpZE21Qsh/sCfkE=;
        b=CdTiyAP655k7wB3/on5NyEPVcn+YgqYxbAFgx5W3E7quM+OW6YM0dGXiJwReCzEjvI
         tljuxTCNHG4xPkZhfNQ9buevZTbub7nVYOTkGB+qIF2OExdSuYK4b7wLSBfx6NWVm455
         ZEo+ZCloRgqhCpNWnsHs8tFmlJVIdlkD+DtIe3UhqUtfS+3Q/MD8f0a6cQruZdQFTuli
         DbH9fbkA+SCmnOtdXXQSnQzyiWCGqnhIi4nJe9o1tMlqkgWapz4pcR1p91oXF9KrlXAT
         SLAgeZIf8PNZhXiQiYU0iZSmVBLM3bOCMANJuhpEHYNHV67x9VXojrYzlbIhQSxT2lpq
         fJGw==
X-Forwarded-Encrypted: i=1; AFNElJ+ExLREckuwAg/8D8q1D0DpZGH+Mo9odMylcnd7eocbv/HwtRZo6SLoF6ItNO5cj3Aw6eYTCsVGHY9i@vger.kernel.org
X-Gm-Message-State: AOJu0YxKC07pcYGg1n64m7o3jJENDpQyJ8siBUgTpHu5AYyXdj2ZIQmp
	vIEYoNOXsdlkQtfQLn4/eRh5pUWQWXySETARlYNnAbUafcR5YN/JDsDH6Vox9+KIsPw=
X-Gm-Gg: Acq92OFLVmnHDjoYGwHrocsjum7vnjqa9LqsTHCyrORPCcg86hSfl8g9KAAvmL27IFO
	vgZ0a+5i9hs+9ezKgiXAvHn7eaRdc32gehxaRQnHqCSA+lfhOqUzr6Vjvks6vv+45OVm9dvEhzJ
	VrKKzRnAVrrrzu48bhMMWbe4q0SC7HfF+J0PwmI3HEswRfrqrpF0oZdOZsaiTAslIsxJ0KDnQ7y
	YQB/mWyJdum3Dp7H3710QiYcDoDmN/VaGFtvPgNvHz4BzHr/gI3NYDN85lJBmuCuMRj63suljdA
	8OAXyY4vON1r9JwFglv8QFzaMCxf1wUEu9Eg2WaZEx6X0IZn2kOivheOFAyZ/sIt3mptG25b2Pr
	C/jH+al/Ly+qyqqSVcQButwIHAZIgZECfUX6m+4Tu/HFEk/QIVT20WypeaS7HkfhazdVHw51hq2
	Y4ZdNpxUQGeY2FxbeBCi9blA092QH65QRhQK6UarTm/6KsAUUKZoej5C8PN5yydbaOoFJpjA5Gm
	1Laow==
X-Received: by 2002:a05:622a:590c:b0:50e:fcbc:6b7e with SMTP id d75a77b69052e-5165a275f74mr79497231cf.29.1778885475017;
        Fri, 15 May 2026 15:51:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585c5e0sm56735501cf.29.2026.05.15.15.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:51:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1NC-00000008Fgc-00Mh;
	Fri, 15 May 2026 19:51:14 -0300
Date: Fri, 15 May 2026 19:51:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20260515225113.GN7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
 <20260514123529.GZ7702@ziepe.ca>
 <agXfm3mS_M3fvRrN@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agXfm3mS_M3fvRrN@google.com>

On Thu, May 14, 2026 at 02:43:39PM +0000, Mostafa Saleh wrote:
> > That's a somewhat different problem, we have the dev->trusted stuff
> > that is supposed to deal with this kind of security. We need it for
> > IOMMU based systems too, eg hot plug thunderbolt should have it.
> 
> I see that it is used only for dma-iommu and for PCI devices.
> However, I think that should be a problem with other CCA solutions
> with emulated devices as they are untrusted. As I'd expect they
> would have virtio devices.

Yes, any security solution with an out of TCB device should be using either
memory encryption so the kernel already bounces or this trusted stuff
and a force strict dma-iommu so the dma layer is careful.

This is more policy from userspace what devices they want in or out of
their TCB. Like you make accept the device into T=1 but then still
want to keep it out of your TCB with the vIOMMU, I can see good
arguments for something like that.

> > > While we can debate the aesthetics of the setup , this is
> > > the exisitng behaviour for Linux, which existed for years
> > > and pKVM relies on and is used extensively.
> > > And, this patch alters that long-standing logic and introduces
> > > a functional regression.
> > 
> > Yeah, Aneesh needs to do something here, I'm pointing out it is
> > entirely seperate thing from the CC path we are working on which is
> > decoupling CC from reylying on force swiotlb.
> 
> I am looking into converting pKVM to use the CC stuff, I replied with
> a patch to Aneesh in this thread. However, I need to do more testing
> and make sure there are not any unwanted consequences.

Yeah, it is a nice patch and I think it will help reduce the
complexity if it aligns to CCA type stuff.

> > In a pkvm world it should be the same, the S2 table for the SMMU will
> > control what the device can access, and if the SMMU points to a
> > "private" or "shared" page is not something the device needs to know
> > or care about.
> 
> I see that's because dma-iommu chooses the attrs for iommu_map().

Long term the DMA API path through the dma-iommu will pass the
ATTR_CC_SHARED through to iommu_map so when the arch requires a
different IOPTE it can construct it.

> In pKVM, dma_addr_t and IOPTE are the same for private and shared,
> so nothing differs in that case.

Yes, so you don't have to worry.

> We don’t expect pass-through devices to interact with shared
> memory (T=0) at the moment.
> However, I can see use cases for that, where the host and the guest
> collaborate with device passthrough and require zero copy.

Once you add the CC patch it becomes immediately possible though
because the user can allocate a CC shared DMA HEAP and feed that all
over the place.

> One other interesting case for device-passthrough is non-coherent
> devices which then require private pools for bouncing.

Why does shared/private matter for bouncing? Why do you need to bounce
at all? Do cmo's not work in pkvm guests?

Jason
