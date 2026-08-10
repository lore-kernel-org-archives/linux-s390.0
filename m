Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04D3DB311
	for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367302; cv=none; b=qpQhNtmikVRvVox8Dbl+DDpOfPkbeotioeC7cNi96X5sRw/EBADBUTPASyZLc9K1dIHvCmrYUbfb/NjIXMWgfs6zyhIx3pq/u8JJ0dXFUoBOEFF52nzkOXWfgV/8Kr4KbvV1GJACDSwK0XdFDTbKeOkbGqtWrNQw6BkP+sEmfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367302; c=relaxed/simple;
	bh=fYoOLYp8STPeqtUEMMg1V9r97/aMbQKiFeOjtdj7QMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSVsmFoJXFEgeLCpRZ1mgJwga19sQPj5c3QbPtgeFneSJc+EGVTeZeaQZKsoxF7viRNvILNCUUFQwiF89zTgKOYPTuziwCccBqerpVJFFhqYg6HLgTQfkghI7nkfhQhFrboiqaui9/2Bhp42gVqqhHo5wlhVT1Ll6voUZOXujFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XE3a+O7C; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XE3a+O7C"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so8464446d6.2
        for <linux-s390@vger.kernel.org>; Mon, 10 Aug 2026 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786367299; x=1786972099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTDI6EKrZhHzu91ABEa/3hYoH7aGPcaJaVd/MJRw0Ok=;
        b=XE3a+O7ClrINyZYgTEFft03F+wkedh+IrWhaFM2DEURnpZke/5a3tSIvnGOntGDUWg
         1zIlaXmjygrEKRaKri60lNtMZKHXXd6JRWQ1iFaSF4YHrfLd2RrcPd8BlKt3D4vlGj6t
         8UF/m+mzHWTJE4+yG71vvmLr0yPLH4Wqvme5OjZ2oG/9+LWAsFrtY011J4FLS6dzvXof
         rsWFivXQsx2OdchNPpMCYXRk9Ui0m7ZG64GoM+dgBY5Ms2NwXkGRB/P4QhtEAEjM2k1H
         jja+0rfYsoHpOiMpx6uj4Jgn5Qt3ro1psTdWXqijW7uiaBOnfolP7lx04xEOiUie6jOW
         op+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367299; x=1786972099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pTDI6EKrZhHzu91ABEa/3hYoH7aGPcaJaVd/MJRw0Ok=;
        b=ORQppm9WI41nc5NoIFbCZ3JVniDplUhQb0/AxdgCXYY9LRrankI2cnCZIv0/FfV6w/
         hG5tPZm897a7F1vdkOrUZjy7MEXb2jikWt0BktWK6hEHnaziMSu1kTFvFR4M7ZQKBz//
         X0/35KMzoQkt152oJDprtcgu4uSGP9F/XkRq29Ob1jBr3O3S5sTV3CUCDMm0TFsoCJSI
         OGcnxM8fnX9P3qD4XPuHbUg6H50zHXABPMdMDfoWKeTnu3eD81648CoBR7pP5srJu1yN
         GFwK50TxYa41iHLfaQDc0HwU/4BnaIguDhj2ofkGtRuDioGpdhssapfiTMU5zkRo5vol
         EvlQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8jJ3TpMOtkWIOsSR+lqv0tVqvZ+g1wVbwcl5PggxYP4QOT03mQw9yzsgbbz8LljsVm26TvlR6Wq5L@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgzdb6IxR1hmP9F96tom8SMIlsaY0z/VLIpuhaY9CjMa1iUgUf
	I7JDoHgLBMfTWrf24P0I0y2QcoYov/gV9eXq/Bv7jeWCWyTXgpu0XTZVktwKs1epDT8=
X-Gm-Gg: AR+sD139tzDKRUmxLWK3gfIredrjqS3GzmtgapTD5JdrSiBrkyhnLWiM0dG9oUvRBY2
	MpHROJJmHaCVgYYF6r1Ru63p4IlqWOCy7QGRT0v3PHsx3fgZgPzR8kKVyJuGsnv11znskt3ngzy
	ijCCVkXZIO7K/Y6AJpv0xtIz3tudQX+HwtowfKzP1YWBlBIa0iZgpaw84SnL4ab6a/x4CqaOETz
	0oFMAJtRuA8x6O5nZTH9b0uY8pB5xW0AQKy6ynA7XrrJwmDJw4Ra26Ub1zq3u1CkfMT5JRVYUna
	Yshxbr0PuKtOpde1nxgdW3WuMkXNEvk4ayjQSGL9eRBy5VV0OHtWPC+th4w9E+zyuvlT8Zh70o2
	iBDpADsDaU0w7A0MEs6PwQBwm+Rl+0tNcGUCrWs7I6C5u/Ch+k2OnBsGnaI4nePHLrTX8AwGIcz
	liF0rQVWEa2hnfWD9M19PJuMZFw7j0/cosQp+elg==
X-Received: by 2002:ac8:574f:0:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-52d20961711mr224570371cf.15.1786367299519;
        Mon, 10 Aug 2026 06:08:19 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d163c1aefsm70838551cf.12.2026.08.10.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:08:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtPjm-000000022LS-0EaO;
	Mon, 10 Aug 2026 10:08:18 -0300
Date: Mon, 10 Aug 2026 10:08:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260810130818.GN200537@ziepe.ca>
References: <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anm6K2umtx4iKnyZ@willie-the-truck>

On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> > On 10.08.2026 12:20, Will Deacon wrote:
> > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> > >>
> > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> > >>>>> But the whole thing is best effort anyway, the kernel picks
> > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> > >>>>> how many devices or how much DMA they do.
> > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> > >>>>> that as it would be the other way around and users would have to
> > >>>>> decrease it manually.
> > >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> > >>>> it should be done in common code and, yes, we are probably going to
> > >>>> have to do something alot smarter to have the common code better
> > >>>> auto-tune this for the CC case..
> > >>> What about the $subject patch? I assume that it is still needed to
> > >>>
> > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> > >>>
> > >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> > >>>
> > >>> paths?" patchset?
> > >>>
> > >> I would request that we pick this patch to fix the regression described
> > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > > I really don't think we need it. CCA hardware isn't exactly widespread
> > > and the KVM host side patches don't appear close to being merged.
> > 
> > Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?

Let's not make progress on guest support contingent on KVM CCA host
side patches please. I expect the CSPs will have VM instance types
available based on CCA within quarters, and Linux as a Guest should
work in those environments regardless of what KVM is doing. I don't
really expect full KVM support for years, frankly, the patchset is
massive. Even Intel and AMD don't have full KVM support yet.

People already have CCA capable HW, are already testing this stuff and
the closer upstream can get to being workable as a guest without a
mountain of OOT patches the better.

I agree the thing is not ideal, but it was merged to ARM like this a
long time ago, this patch is just fixing a small oopsie (was it a
merge conflict?) to put it back. I don't the objection.

Jason
