Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508D371CEA
	for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762134; cv=none; b=ADBOx0Kvtwwlb68d4xDnVyaQi1+EvpO3v68KYz540MX768UUargUnyH5aUfLiJno75M/rN6Y97PDjNU9uK628s24IDw30Wa+uem65+SbqRgFoyyAO0GvPucFmraMhHugd7VEg0WtB1iwvXimFjpQSS0+PaZ7npMv7qeEjbjIGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762134; c=relaxed/simple;
	bh=DlRTtK+pet5LFFKBQ/8FceU5SmBcugQNcR+otGWnOYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2sGJHe2dz8ZPM2oYZCupgvbkNtJrq2R8yF9wQnIyqgMYqFg1gTbQhWALz6W3xoC7qtfXni0aF50Mj8fFUkXKLswRbj+TvTcb7EvXYsCxvASvqw/LSNVqxJCJz9GJfulWZkddVX//zeeZ+oGXKlAZTwGybm4Ntl9p9OJlTF5BZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Vp4f97Fe; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vp4f97Fe"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-911449d9d03so44256285a.1
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778762131; x=1779366931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
        b=Vp4f97FeyywShkRdTRWbKsCXCwi5OOjvVLX/kkAJ7P+lU8VWg8cHNjQkjlsrN0aupT
         h+2xMZe5wPFUj6FGlhtTRCoaHZh66+RTRkEx8SW65VAwyOJw323pFdnD2wV2zgsOKTRr
         F7WEWIgaKA4K6VYHyjTEOmxtR/NV7s8WEEoT+TBW3zCCuxPvzRijIH6C2lumF8qZz6+Q
         WOA/kvfrLqZdjYeClcU6aV7f2EeCxjtcZ8KJcWYBWAsZbxLsa0kjzIah6dIXcviLQeny
         jT0XhgQc6NK33lxo+ciW3MPewa3NYv2QesApX+LG7DhDoYFUEDoZxpCqPKLKHru9bUKw
         TQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762131; x=1779366931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0syXDbvsxMHU2qFtHkGrYSSCi/zfIXRFYXzTsoQZCg=;
        b=dpaB/d16J6hQlWoJtZcZel14hTP4vqdAYjQqXr1u7abJvdAkRWw8TtDbAci/ZLaZaK
         fyITFnk2sGYcBLZ0u+nNEKFqPWje95oBeVFC7A0lsCyAWM/1hD2A4nmhzI1cKtHkVmSP
         g7Z2ByH7B5X/gGGwx2r/fbErLXzNkNTEsHi+F5AiNYVG6q9WFjQR13WHC9NKQVS8GaGs
         l3VgTMTmXTSyKs+lAvGzIsrxVz5ptlb9JnFypgT5KvOuqckoCtaTgcTQytgULvwyr6Vl
         Tq9Ub9Imt3zQlYccg0guAgiFB6Z35vrwpFJk6xUmyZOOM13JMYHtqWAwzmwq7GxVnosZ
         zVkQ==
X-Forwarded-Encrypted: i=1; AFNElJ81RQh/t8lU7Jj2EEvThZrZhnWz1bF6BYp07/zyyYeuVFRLKilLYjHZvPjHTkDFf9UU+aRWTOShglf7@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlZE3zyx4jf2zIb2sA1nvRkoqfcu2jVxzVDSgKNjyxxn25D02
	9VHXJ2/+/8ycBE8VzMd4BTaZ2Tp3NFqliRiS555IZlDCRoqxkdhqbN/46OFfrQYW2/A=
X-Gm-Gg: Acq92OHNOa2GXnZymLe0HOrInR8QDduTRwn6f9/eeqE53GYoz2VHzG3pALlq4nnWPav
	GPYBb4YFciNnanzfv1qaaf2QfWnpwHZJoKGFvazXazfiVTY4XB6JtOtvNztlAVX+Gl70z8Q0zPb
	bhkevFF9Hldt5tGypx21Ccgg98wRxxCM14rgFuq3+Szk+aWIL4x1+mMmEh5HrOqwmLBcyohpFmj
	dUwttZVKqIwyzayWBewj+FBmqUy1hrfPOsyCLTQuJbHSYY7JurOQWWUetvSuAcVm7WO+LoeZCTC
	yheWopMB22CP8Nm6PRuXdLguIM9KA14X/47qr42UIC23J12gBg7f9Zbr/F8toQSdb/BgTgsCsZ2
	InKyaFGnoSIEwsdIfvHR4zbV1lOZ8LCY3ti+LnbcO+IrW9vS8GKukpTXY8R2jl2+WGbssXKG21F
	5AdNq3ntICZvKhliWgJjAUfjCI2rnpaVUV0Kb41AZQyKZQULl6Qgt7Q404HzHuzRfnHL3SyBxWZ
	PcHWw==
X-Received: by 2002:a05:620a:4114:b0:8ef:c472:cd71 with SMTP id af79cd13be357-90facfa13d8mr999953285a.31.1778762131005;
        Thu, 14 May 2026 05:35:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba182540sm234520585a.4.2026.05.14.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:35:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNVHl-00000005B3F-3Oru;
	Thu, 14 May 2026 09:35:29 -0300
Date: Thu, 14 May 2026 09:35:29 -0300
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
Message-ID: <20260514123529.GZ7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <20260513172450.GR7702@ziepe.ca>
 <agW2lzJI-20DyJVe@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agW2lzJI-20DyJVe@google.com>

> > How will pKVM signal what kind of memory the DMA needs then?
> > 
> > Does it use set_memory_decrypted()? How can it use
> > set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?
> 
> pKVM (hypervisor) doesn’t signal anything.
> The VMM when running protected guests will use restricted dma-pools
> for emulated vritio devices in the guest, which gets decrypted by
> the guest kernel and hence shared with the host kernel, and then
> traffic is bounced via the pool.

That really does sound like CC and set_memory_decrypted() to me..

> It’s also worth noting that bouncing here isn't just about visibility.
> Because memory sharing operates at page granularity, bouncing sub-page
> allocations through the restricted pool prevents adjacent, sensitive
> guest data from being exposed to the untrusted host.

That's a somewhat different problem, we have the dev->trusted stuff
that is supposed to deal with this kind of security. We need it for
IOMMU based systems too, eg hot plug thunderbolt should have it.

Then CC issue is more that the DMA API can't decrypt random passed in
memory because doing so often requires changing the PTEs pointing at
the page so it would break everything if done transparently.

> > > I believe that the pool should have a way to control it’s property
> > > (encrypted or decrypted) and that takes priority over whatever
> > > attributes comes from allocation.
> > 
> > We should get here because dma_capable() fails, and then swiotlb needs
> > to return something that makes dma_capable() succeed. Yes, it should
> > return details about the thing it decided, but it shouldn't have been
> > pre-created with some idea how to make dma_capable() work.
> 
> That sounds neat, but at the end we have force_dma_unencrypted() in
> dma_capable() which is just hardcoded to true/false by the platform.

For now, the next step is it becomes per-device and dynamic during the
device lifecycle.

> How is that different from having the state static by the pool?

statically attached pools to the device are not so flexible when
devices have dynamically changing capabilities..

> > If dma_capable() can fail, then swiotlb should know exactly what to do
> > to fix it.
> 
> dma_capable() returns a bool, I don’t think it can know what exactly
> went wrong (based on address, size, attrs, dev...)

Yes, but I think the design is swiotlb is supposed to re-inspect what
is going on against the limits dma_capable checks and then select the
correct remedy..

> While we can debate the aesthetics of the setup , this is
> the exisitng behaviour for Linux, which existed for years
> and pKVM relies on and is used extensively.
> And, this patch alters that long-standing logic and introduces
> a functional regression.

Yeah, Aneesh needs to do something here, I'm pointing out it is
entirely seperate thing from the CC path we are working on which is
decoupling CC from reylying on force swiotlb.

> We can address this by either adjusting this patch or by changing
> pKVM guests to be more aligned with other CCA guests which is
> something I have been wondering about if it would help reduce
> bouncing.

Every time I look at pkvm I think it is just ARM CCA with a different
design and no access to the unique HW features..

> > If we can make that work then maybe the flows are designed correctly.
> 
> Mmm, I am not sure I understand this one, shouldn’t the device also be
> notified about the switch in memory state, if it expects to read/write
> decrypted memory, how would that work if the kernel changes it to an
> encrypted one?

Nothing on the device changes. In a CC world we put the device in a
T=0 or T=1 state before the driver loads and the expectation from the
DMA API is that the device will only use that T=x DMA type during
operation.

A T=1 state device can access all of memory, private or shared. Any
information the platform may need is encoded in the dma_addr_t or in
the S1 IOPTEs.

So we never need to tell the device driver what kind of memory the DMA
is targetting, and we NEVER expect a device in T=1 mode to have to
issue a T=0 DMA to use the DMA API.

In a pkvm world it should be the same, the S2 table for the SMMU will
control what the device can access, and if the SMMU points to a
"private" or "shared" page is not something the device needs to know
or care about.

Jason
