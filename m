Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE7353A76
	for <linux-s390@vger.kernel.org>; Thu,  2 Jul 2026 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003653; cv=none; b=j9HM7LB8z99awnLF77AARTDMnF7w8tromcoP5/ZBp89QyGUnsf+CVRbTJuysp/vEwk8xQCIPfX8BvbMIQIVaB2hRXrDAVBz4d2w1iB/PqTG9Hr8KWq84Z9rLuhUkwyrOnJGSLXrtxxw9w5H0AGHRu8oFGM/2p/UVdXUPi7AOC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003653; c=relaxed/simple;
	bh=wPrLPIkahV/48dLiq8gAC7HDusdQj1NNPVoCnuPpx5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzekqfTQ9zHkmlemHfF0YCcLZ1zTyiFgRU/1zH+5Bfoy41s2G8kMZNBpU00mFXUUEZJMJJ4Au7HUhUMSxpauQAfGTM+tIy+/h/sZ5aa6x5POCy4fGz2FCSDZ1W06Q7BHEG77PPFkBe1humUGp0Lb/PK8Mn6DtL3rg+hmV1J4JHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kl8+oXvt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kl8+oXvt"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c16ac21acso11595251cf.0
        for <linux-s390@vger.kernel.org>; Thu, 02 Jul 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783003651; x=1783608451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
        b=kl8+oXvtgIhx5vCMfaYKf//uaV+saIqUWsAuQDSaQoDdiWQltwZ1c1lCRDz6EG3sh1
         s1dYQG1NH7YiaOrGHtQ1hdnVcBQWrlqn/rUEvTBBflreFAivX/vYeuOQrDvZdQ7L0msT
         8PeQ9g8VIF3+FUf7pXup9K8XoUgCKS33GTKdyxSMyHsi3HeIfmUR/b5cWzjKrg/R4T1v
         MzmO8KfKQIJTn6B5f7V1uQRlsTXmP16KdhrOlIWoEi7EnJXL7mQcR68hM90Jpn64oTya
         tzEimeXJb76eAkoJh/5IO0WBTQdeiqD7m0pCG/TI2Z8BqC5k1E4z5hr0y5vHzOCQS6NO
         OAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003651; x=1783608451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHZVkcI1dGlitqBERLzcSZUkSvuExam94MObbuJvLAQ=;
        b=FB5mDtHhH/IQPQ484sr5qH8ddYeL29ShlVwG6HMEqWuzqwL5cqk4WDDy9kdIh2Hoqo
         BsELvKLlVQLWC5eF6ZRgqfDrQksWRbNbiIGDXolawPu5w/oNSv8aAnNBTFnieHUxyXpO
         x9lroEi/nnWCRjpVmjY75LRDHVhyAub6PzKO/wi0VjqzBoLCwsDac6uVRTnEgz+Z+38m
         TSZrsTxTynFr2jbWlSmywRZx+n60acXKRFFIRZJbcVOmYqf6DLM2Xw7XbVuZoW21kL3c
         g2XYY+2Evg/YB8Utz2AeeSQPSdjoeJr4ExJaA8nYv3Dg5R6DExGBm91kkF1mFWDdsZwz
         rGhA==
X-Forwarded-Encrypted: i=1; AFNElJ8AVCc4J0oDhRLq/ww+E/6iAvbpOBtke0vmyBsi+CuUaFSospbS1mheUg00Sae51aEWixqav7ArHVhK@vger.kernel.org
X-Gm-Message-State: AOJu0YxWq9wdypOngtHOR6CwHoPf5pik4sMy/tz2GwuU8LuXSFgR5Gdh
	8DvlLh6O8Sj/4WHdvRL8/2nYGyJ6PkX4ZV2xcSvo9UqCTpRDqC4VUJzk2yZ9oOReBpA=
X-Gm-Gg: AfdE7cnEbsqH1O//h3mspp6wvn+Hwi2HcdKGIUSr1JSSnPFbWmy4REPAF2aCaqXltnh
	NpudVm/7DG9uu3hlygj68pJFSnhqmrqoK7lel/X7gvS6eZougIs5OsspHetKZXTeVzG4YoWqBct
	iwdOGaBPSxudtdz4ykesTKrNuft1RFnAyIvbdEiR/pWhH2hBZYRZiN6HJE6U4wN+8g7kKTqkTKt
	H67bO1t2Z/JaMmTgXHYZTRHSltNUjBzIhvghSvGLoX9Ph23/3Mkk8s9CHOtVxvUr4WUzZM+pEgg
	IaoErkXalpF7eCw/RUXTVqEqoB81ViKo85poeYm6FGlTwahvlemA1TUZApFm582K9ognUQt6T0t
	d24rNMI0tjzNRKIPqwr5VTUlUNquBpPg4L4KcMTsDghx97PzJchX0UPGgJJbLogzqqI9WavLV0m
	YYR8qdVu5hG/YBl+CG3/5Bl4oAf9Gcd0LgGotcFEa3Ujgt792RGOZ1gf8l137L0cWMaOE=
X-Received: by 2002:a05:622a:1b92:b0:51c:1ec5:d0f with SMTP id d75a77b69052e-51c2aebaa70mr65534301cf.40.1783003650663;
        Thu, 02 Jul 2026 07:47:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c61857sm15516901cf.28.2026.07.02.07.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:47:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfIhN-00000005tmX-0mNc;
	Thu, 02 Jul 2026 11:47:29 -0300
Date: Thu, 2 Jul 2026 11:47:29 -0300
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
Message-ID: <20260702144729.GP7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>

On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:

> > > not externally available so I'll have to trick the DMA layer into
> > > using SWIOTLB (which is still all shared, right?) as I specifically
> > > want to skip page conversions. Setting low DMA mask won't guarantee
> > > that the DMA layer won't allocate a page outside of SWIOTLB and
> > > convert it. Manually do
> > 
> > Why so particular?
> 
> aahhh I missed "pre-". I need a way to get pre-shared pages for my
> sev-guest activities.

It sounds to me like you don't, what you are worried about is
optimizing the dma_alloc_coherent flow to avoid fragmentation and all
CC architetures require this optimization.

So I'm strongly against you trying to open code something in your
driver. Use the DMA API as-is. Propose general DMA API improvements to
reduce the fragmentation problem. It is a real problem.

Jason
