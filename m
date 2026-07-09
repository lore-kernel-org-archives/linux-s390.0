Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2F4DBD63
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620819; cv=none; b=tLvGF1axeP46wofeEdCrT2+qv/gRcpcSyaABMO+tzbm7/EnNxLalBJbadZm8N77GtuBfN6hDys17tXrVXzOzgS7MOx4hx3xy1oWGBvO5nNfK4HJluf5aa3erg06AA4KohNakEJZTq1DyZ61HH5J0/UO0sUUd53IgLGJVi/8j75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620819; c=relaxed/simple;
	bh=bvUrlGSFk5YOKRSganZsEuUYcVv+Ux1auqFKnDwJzG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMzI/9frZMnSE9vzpTTes6bQUrpTljXlBvwJZMcEX333M/v0/8kpPArIaywzYI4OITy88mMSw/kKJTK7FMRUCzqettzCCnFIIsCKGfPph+Nv4w01gurvFKCDLrPrddIbiT5UuaXRd3IPItBrBzVbQlO34sU8VtZBHuF9Q+emO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CyuetQGX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CyuetQGX"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efb708b1a0so2094186d6.3
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783620817; x=1784225617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
        b=CyuetQGXo+XLSmoKTPOORB5iZq46kMYcinoWKTTT9t9YgZLQLkYpNwaUJHmexivIiu
         ECEWeHDILxRaM4+Ayvc+zpSU+PNsac7aNY6/lZqmH/QL/AoFDMu8CGhEKbIksPBegCUm
         UuqJfcc3QHSp+a+5qVjpvW4boDrYD+LeVpXx9OUax3+4uc+KdA0hzCejWb4CcqIDpTx8
         4EazscwPbkuS+p88qBUmV24VJb72qoR9F89Z+B3/+befVNJt/e2UziS9nm3eL81IA/eF
         tnaxW2tmKDOVyQo4KijfP9MSuarwiJdw2Yh880kQAkUEGw9gtkNEvizju8tYl4otpXt1
         cdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620817; x=1784225617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
        b=hxq9Gm3F2zchAJ5cbJc0QHoHsKsT7Bduc3plR4UJVY+tPG6JvNgrMN9ewsbcDzCHSn
         ldnkGd7iowYmfsQuhDcVlwcdoJvpa0LRfL1Aaf0gH8uS2JV8hAIRh9epY/dRddDFOVFT
         6lxw8jhCrw0li3pDkj5/To8hCt9znPm5SSl5DCdiFJPjf40stCyFE7SVzyVL1dXBJ0d+
         tpqWZkya9UpUs8EVJQeDN+GLR4cSNvgRcT3vYssvbGdXTaAznxcqqi7Kn+jkcxRTWs2d
         NSEOC/e0axKdGh+mW8/cTr7++j3MtFbHYTmq59u+2ScyMk1A8Ax+fIqiiUsbCnQsjiKj
         fHPg==
X-Forwarded-Encrypted: i=1; AHgh+RpxBPj5iCSPdXhgPLJZoppKvE8ROZ1Hze7hEbjmm9ijsnRANkxzeRH4yK4lZh26rR2oslekQSgp+YdX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SdkcbT9FU5h/lJ7pBytm2Uh8mM6DL33afUOJYJqzclAZcLsV
	wJuBKoJWFwsSKven4geVgIyNp5IZ+YcSY2EjB1ZRAUGY0tpG/39BcbF7G/URiFqclVM=
X-Gm-Gg: AfdE7clQ+uOzqIt3A+r/9fGiWzbqWEaogV21qI4ZcgbAthRh4b/r90GUb3itFaeupsv
	oZuMW+xrCcR6HhcaCCZnijpJA+rNOolQO4CkmAIghAAZjudZUYdJO6ix5O04fIXy25SNf5wHGv7
	deoV1yDilMz0BHM3D0uQeHxHdf8b38GGTloDnt41rara8YMe9/0htO6W1XD0YEDaVEvpDmEpa//
	Gb5+2GNYwX7w7gnlubggUEGuHEGntHXFIKXPFvAUOAUEEes9Y276Pq35jASicIvL5/9wOyg+A7E
	saaxxVFiWAC7gAcgX8ovPxQy7GlybMaYMUMd0KValw3SwpXoQn2TahQBX34nkfUdZMXP+PVE9j/
	x8WPRgKeLgjbBs2yk/lMXQVG97+pAH67LWGMoErTeuW10fROrM+BLt7GY1VvU
X-Received: by 2002:ac8:690c:0:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51c8b3b4eb1mr92527611cf.51.1783620817365;
        Thu, 09 Jul 2026 11:13:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm22695666d6.42.2026.07.09.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:13:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whtFg-00000005Kqr-0IQc;
	Thu, 09 Jul 2026 15:13:36 -0300
Date: Thu, 9 Jul 2026 15:13:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260709181336.GM118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-CT3oanlDfgTy4@arm.com>

On Thu, Jul 09, 2026 at 12:13:19PM +0100, Catalin Marinas wrote:
> > > For AMD/SME, on host with memory encryption we now end up setting the C
> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > > some other MMIO bus understands this attribute. Maybe we should stick to
> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > > since this is not universally defined, just use the old dma_addr = phys
> > > if MMIO and ignore any unlikely DMA offsets.
> > >
> > 
> > Considering for AMD/SME system an unencrypted dma addr is one without C
> > bit, will this be good?
> > 
> > 	/*
> > 	 * For host memory encryption and device requiring unencrypted DMA,
> > 	 * MMIO memory is treated as shared by default.
> > 	 */
> > 	if (attrs & DMA_ATTR_MMIO) {
> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> > 			attrs |= DMA_ATTR_CC_SHARED;
> > 	}
> 
> Yes, I think it does the trick, preserves the current semantics for AMD.
> I guess you could use a single 'if' for all checks (up to you).

Please don't change it, MMIO P2P is broken on CC systems today and it
should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
an error that we need to correct in the drivers not make work in the
core code.

Jason

 
