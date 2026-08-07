Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955F41835E;
	Fri,  7 Aug 2026 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097105; cv=none; b=aQnu5H5BIepFJRegTfz0lNtzgMGGY3wccu4Yul4IriiFanDrlsGgE1HCd2DFjSH3PJNiL19VuurZMR8HfdbxVooFd+b2AvxoDMJwaNJdrdeM7Lv9nGboH6gsiQRHhzsRqq7BF3uCQMA9F5Dea3AaZP6dmVM2/qdYFUiWiQFIROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097105; c=relaxed/simple;
	bh=MYH7/cXebbl1jnIx9/YRD6DRDQgDAdp6L2LOqbuoEvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=s95q9+oS5DYJCR+e6MJg/68DTpStj2Thf2T+Wb7joXI1tw+uyp3Uch7f87DOL2ewC1dUsafECCZKrPVI/itW8HeMh4u7OoPxJJrwGV+CMPDDalxEZqJvMEF4CJUd9/jVSS1xDlz8HF8UPc/gGBxRYQDfu8yhsOqSseIPv+nQa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eSgPaohg; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eSgPaohg"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260807100453euoutp01e08fd1317b5254e81dfe38ab56a7e318~JfdftXfrq0070000700euoutp018;
	Fri,  7 Aug 2026 10:04:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260807100453euoutp01e08fd1317b5254e81dfe38ab56a7e318~JfdftXfrq0070000700euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786097093;
	bh=tYmr0H9Ny/ow4oRf+kOxKy/va62yVPIOs3FFYDqPiJE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eSgPaohg3Ovh0J+b1VIFqfeHKkdgmjpLe5hrSy9TY75XNitr28SV92trUU9PslGo3
	 GaTZ+DDtA/CkPLguep0RMyOGadNXne7NZjAO0FCPKMjC/pYLr2u2SAbwA0Yp+g9cnq
	 bhJxJ6mGaKViGjHEGlcRFjpPia7jjmMs+eZr590I=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260807100453eucas1p136aea760b58c932260c5118603636b6a~JfdfRJz5D2159221592eucas1p1t;
	Fri,  7 Aug 2026 10:04:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260807100450eusmtip2cd49a3ac23b36ad2dca8af2eba115dfa~JfdcaVKqS0729607296eusmtip20;
	Fri,  7 Aug 2026 10:04:49 +0000 (GMT)
Message-ID: <04c8b1a8-9194-4e63-9d30-11315ea6c1a9@samsung.com>
Date: Fri, 7 Aug 2026 12:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
	Gunthorpe <jgg@ziepe.ca>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <anWqq-vjEwwaziaM@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260807100453eucas1p136aea760b58c932260c5118603636b6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb
X-EPHeader: CA
X-CMS-RootMailID: 20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
	<CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
	<yq5azezfeeax.fsf@kernel.org>
	<85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
	<anWqq-vjEwwaziaM@google.com>

On 07.08.2026 11:51, Mostafa Saleh wrote:
> On Fri, Jul 31, 2026 at 09:33:47AM +0200, Marek Szyprowski wrote:
>> On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
>>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>>> This series tracks confidential-computing shared DMA state through the
>>>> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
>>>> DMA buffers are handled consistently.
>>>>
>>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>>
> [...]
>>> pKVM topic branch is now available 
>>>
>>> https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
>> I've just got back from my holiday's and I see that there is everything ready to give
>> this patchset some tests in linux-next. I hope nothing will break.
>>
>> I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with
> I was trying to find this tree and it seems the MAINTAINERS file have
> the wrong address:
> DMA MAPPING HELPERS
> M:      Marek Szyprowski <m.szyprowski@samsung.com>
> R:      Robin Murphy <robin.murphy@arm.com>
> L:      iommu@lists.linux.dev
> S:      Supported
> W:      https://protect2.fireeye.com/v1/url?k=dbfa7485-ba7161ce-dbfbffca-74fe485fb305-800153ec5c55b6a1&q=1&e=ed464763-9bbc-4c24-9629-f9ac5e8f5ef4&u=http%3A%2F%2Fgit.infradead.org%2Fusers%2Fhch%2Fdma-mapping.git
> T:      git git://git.infradead.org/users/hch/dma-mapping.git
>
> I believe the corret one is:
> https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git/

Thanks for pointing this out! It looks that I've forgot to update it.I will send an update soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

