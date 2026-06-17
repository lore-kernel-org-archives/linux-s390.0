Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4B477E52
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710878; cv=none; b=MlUV5gipENKXa1EiLwxTLOmuqrr1WjgomVK87Gi6CMsSMlj96nIHZ9fovsON8wktt+qYvRBti/K+9qlo8Y1ECvuNtlJipJqb6+B1f1VJMy7135qP5DRS2vmxkgAKm+oWnoxOtPKbYL1YZZvphFpFlBRzY9y6s1t2tJ3cGVBhrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710878; c=relaxed/simple;
	bh=9QIEPp5EWbcjDNMKHBFL5JldJkQ5+OL5Nn42Ql7e+rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUNDtQfFA6ILi8lKmvjrwdKJ101/hMgJkRclQBvojzyF63mNrrwmWBWjhkCDbXDPA8liD8fZa6oSlqOHJz/4Z2MD38vAcuGVgHqHdK/T9lezRwyKNbfZgqHpm5z0Ae0YxowXl2IyBVhVyPrbYo0IBoumZPhXATrAFVYDoO3L1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BNaxItY/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BNaxItY/"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51758478240so32773561cf.2
        for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781710864; x=1782315664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
        b=BNaxItY/Nm3pO+SwE/+o2MlZBzHaWgJpo7MzlvPnaJQNym2Hhs45Ll2TS2NIVxJKV0
         WHOrQv4H68aelwt7jHzHWBzlbdiAF7gs98RbwPKX+mRiztm8w53KKerlz9GSLV1up8LG
         bmOQ9mrrParstns0khNNkLFXV6TNlug+U53Gz7inX6SUpiN9+nkl9Pi2Ljvz7sWNpxDn
         YMS3uTRo71SKzAoL2uYVyb2blcGBrOaIlzAGhygX6ozdHMigdhRyk36MjUhXX2WUuyS2
         6dXoB37uRHL97D4ONuc/aRoRTHfO8gMCbZaZrZDBV/nvrqieROGN1Z4vHordHBGQuj/3
         Xr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710864; x=1782315664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
        b=luBsrjdjw9TRommZlfg6vaI1NYHVi0h2yKJMoXM+OlgYwWQPB504pfWVVeqda2oza6
         i6H0SLvPhk6V8mx8q83mjxwwG3pG8lq5uu+UnS//0ZicHh3WKtUrmRlseD5q4UmBmv/Z
         V0H8PVsZEJOctPWXLksiCbw8a5m8Igl4JpjqHXDbCxIpD+HTdXu/hQXWn8wPxNoLxeat
         M1xcl7hEE5DKThsTt6IN/wMJL/aGI0VoXyGvUVZJDiNKb8pLx73KnFONMapsslhbeL/L
         /RFi5a9zECTXx0YJcndCb9fC4pZYGB7n/6oS0ix3Kvoz+zwnOS4/7Z8ah9H1+e78aidS
         2PsQ==
X-Forwarded-Encrypted: i=1; AFNElJ++6rNUOnIrY5ZcvL4Xlk2UyTkp6noE7kOrLQ5MCJOx1nksFDSDyF5Wv4zE9aVN7zOJa+CCwaJIvWKO@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3sCjNhx7d6Vm5T0nmlBOe+P3Y1wMriXB/6vHLBDZuIFaNte3
	3TB7eHIrjbSWqwpicK6/hnquQocnhF+3pyShcoDGpLN+0C9yHP1Q4PMtnnaf9aR9hgg=
X-Gm-Gg: Acq92OFWA0Mgev/cmNmcZcNCUt/6lgPIfhVbMAN46Sm+AQtAuv9jwGecXNtjwcMb1zf
	xBGoLfucwjzt4/PGDeDe3vAfaWoziya4d4Vabjo0AwCpzDvTPibEFV3TmYSHpmRGNJ+1E9Uvasq
	re8MH6Q0rwbqslcLFdJ+cLaTypoMI9aa/WTMm4SfAZDMMe+WLE+0szmdiUiWpa8KsCPNtnVOH7r
	DswhusQcItHRPvCR79klStWjJ59PFk4fHVqYYmqWdcxQbOp/y+gTI4nOD3NKZIZkZ//FSzRRAy1
	UDj4So56kb3kLG4wBqbtHKa9P/ETxfOBoctytxS5LizutIkFwaqhwgIK9CGLvkY266LZlBHaxFt
	BmqbX+QlkLUhyBPUPmVGt+qzWL53kJxS5uL2HZtPAwYa3dsZl5UNjsTBb0gOAIcr2D355WSXi2y
	h1s0dqz70Ot1eKbSTyPSYbMWQCjcSzmLD+fpyot2DHFaL6lEMLx5m2k6zReywunqyuIvf0qwZPP
	ov9Ng==
X-Received: by 2002:ac8:638b:0:b0:517:7620:20f9 with SMTP id d75a77b69052e-519a8e01895mr53967651cf.19.1781710863733;
        Wed, 17 Jun 2026 08:41:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a3c4asm171544001cf.14.2026.06.17.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:41:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZsNx-00000000iiO-3Q8i;
	Wed, 17 Jun 2026 12:41:01 -0300
Date: Wed, 17 Jun 2026 12:41:01 -0300
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
Message-ID: <20260617154101.GE3577091@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>

On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
> > @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >   {
> >   	bool remap = false, set_uncached = false;
> > -	bool mark_mem_decrypt = true;
> > +	bool mark_mem_decrypt = false;
> >   	struct page *page;
> >   	void *ret;
> > +	/*
> > +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > +	 * attribute. The direct allocator uses it internally after it has
> > +	 * decided that the backing pages must be shared/decrypted, so the
> > +	 * rest of the allocation path can consistently select DMA addresses,
> > +	 * choose compatible pools and restore encryption on free.
> 
> Why this limit?
> 
> Context: I am looking for a memory pool for a few shared pages (to
> do some guest<->host communication), SWIOTLB seems like the right
> fit but swiotlb_alloc() is not exported and
> dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,

Then setup your struct device so that the DMA API knows the
guest<->host channel requires unecrypted and it will work correctly.

I think this is a reasonable API to use for that, and I was just
advocating that hyperv should be using it too.

But it all relies on a properly setup struct device.

Jason
