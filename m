Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D3379EC8;
	Fri, 19 Jun 2026 12:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871265; cv=none; b=X6lh2x6iDfFtTH/PO/M0fSR3Mnng8hPQ487MsqfwFGOkRGT4u2n8NA5jwXnnkBY8cJ2r8iGQZ3zyRw7320a1VM0MpKGdRpIJeEn2ShR+aReL+bKdtKPvFQeotOebe6jSHVMI/AWrx3J35JtxNj633EvJojkWaXqVhHmM/GqT5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871265; c=relaxed/simple;
	bh=D18Y7QMf2ua3rnX5TS42ytW40kBRhvzW3ESkYKGnS+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r8PbCLFVci419vh6DvSNHywzu0TFEK1xUTESRs44i1Lk8j0aSTsye977j6/Qe/I5EUMT8s8Gm/WcNJ4A5Si/dugoj9MTVKw0hXaC1vLeyCFJVV1tfp79VmBwRg+/aQvyOut8Kyv3UX19+0Y2vEFWb5oDN/mYBdJsmJHeK+M1rIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt0Naddy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt0Naddy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9471F000E9;
	Fri, 19 Jun 2026 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781871263;
	bh=KrOJsDp07RvjHOd4cMkZps4YSuiVy126p7RvYOPP0A8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Rt0NaddySWLItBMWeGU37cEP6ghBwAiCgFoVL/yDeYKFrgWjjOXw5fnpeRkuQFogY
	 CLQbZdwDh+aShieCJXxvlci/ACzTq16EHZ6mSrAk3gTro6XT5InFDGLxT0cVRcEqfb
	 FihgVAzw/GPJ10OXjcrRrP/594+fy9kNP/aeuNTCXdZBvKOKjXYtpHsmL/+1mwrFLv
	 oVkEnkNi8gubNsQu/SLW3F9g7CDV8OKpc/DTxyw/Rmn+RCGXkd42YTjCTaq4zmSo9u
	 5ej1hm8jG9aoxWXPIhtGGBmT2MJcNjAicaMSdL3a0XPTJmSSxFB09c0n1Sp7+9yfRg
	 /ADZdG2vuqkog==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260618153705.GH231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
Date: Fri, 19 Jun 2026 13:14:13 +0100
Message-ID: <yq5ao6h6enhm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Thu, Jun 18, 2026 at 09:37:22AM +0100, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@amd.com> writes:
>> 
>> > On 10/6/26 00:47, Jason Gunthorpe wrote:
>> >> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
>> >>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>> >>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>> >>>> are handled consistently.
>> >>>>
>> >>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>> >>>> shared/decrypted buffer handling. This series consolidates the
>> >>>> force_dma_unencrypted() checks in the top-level functions and ensures
>> >>>> that the remaining DMA interfaces use DMA attributes to make the correct
>> >>>> decisions.
>> >>>
>> >>> Please check Sashiko's reports, it has some good points:
>> >>>
>> >>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>> >>>
>> >>> I think the main one is the swiotlb_tbl_map_single() changes which break
>> >>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
>> >>> but force_dma_unencrypted() is false. Normally you'd not end up on this
>> >>> path but you can have swiotlb=force.
>> >> 
>> >> IMHO that's an AMD issue, not with the design of this series..
>> >> 
>> >> The series is right, a device that is !force_dma_decrypted() must be
>> >> considerd to be a trusted device and we must never place any DMA
>> >> mappings for a trusted device into shared memory.
>> >
>> > swiotlb=force forces swiotlb, not decryption.
>
> If force_dma_decrypted() == true then swiotlb must allocate from a
> decrypted memory pool. It is right there in the name!
>
> The hypervisor environment should *never* set force_dma_decrypted()
> because all devices can access all hypervisor memory, up to their IOVA
> limits.
>
>> > So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this
>> > patchset, it fails to boot. But it boots with a hack like this:
>
> On the host side I expect this to cause swiotlb to allocate encrypted
> memory and bounce to it.
>
>>  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>>  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>>  						dev->bus_dma_limit);
>> +		/*
>> +		 * With memory encryption enabled, SWIOTLB is marked decrypted.
>> +		 * If SWIOTLB bouncing is forced, treat the device as requiring
>> +		 * decrypted DMA.
>> +		 */
>
> And this is more insane logic. The right fix is to allocate the
> swiotlb bounce from the *encrypted* pools when running on the
> hypervisor which requires undoing this abuse of force_dma_decrypted().
>

Agreed. If the device can do encrypted DMA and requires bouncing, it
should bounce through encrypted pools. We don't support encrypted pools
now and that means, we mark the option ("mem_encrypt=on iommu=pt
swiotlb=force") not supported for now? 

-aneesh
