Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652640A92C;
	Thu, 16 Jul 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198653; cv=none; b=sUL/SEkz/5vWrgpGpqjO3W1b/8m15/AroQBQBEm3NvcthM0WcyeqzWnz43SrO2Jqyt7l9f2I8b6hpzTvR8gUe3QcdwFt3yg7mXhjZjXiemZvcTN6cL/JKpCrxy9kxvoonHa6M4FHhmXLOr9irYvYA2164XvFF1UfyDEFCZQfuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198653; c=relaxed/simple;
	bh=/wwJ8YIkXCpBwSVVTMrGXqVGLZdZXp1TX5uW8ri0eyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=KXyrN65aklRqiD0LUKjyHfGB5MMo2dxEK4MZmqF25apPdiq6tEbSVWG0dbZGavAlgS8hwLUW4/jIOA7jkp0d0DltqnBKZlKmIxQRTmVczG0J8hbkOM0lLBCA/bOc1SWJlIHle7pCNtxs2pCuqhTupIewdE4YKHIbXxo+/IYyP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MSTbwqnb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MSTbwqnb"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260716104401euoutp0162896187b46659a20abee1581481c5cc~CvzYh7gBq1199711997euoutp01Z;
	Thu, 16 Jul 2026 10:44:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260716104401euoutp0162896187b46659a20abee1581481c5cc~CvzYh7gBq1199711997euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784198641;
	bh=4NOe5ksl2vlSwjo56KjbWsmML1a42hyFiwBD/c9eZDU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MSTbwqnbrDKyLKGraNwvsA+y4j51U4MbSsUqWrLD7zYBuseQk2jHYvQzKWIBHlqF3
	 POTrMf4g8ZRPRjBC3B//DjIkSnL2hCqPkA9P1ECuexq2YdaXf+5B3xWtrCF/91gL8O
	 xIohKEswRPMt4SaVihbMOLSt8JqgZ1C22LyTuDUo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260716104401eucas1p1f2c155f5f3a4655c82e831bffdeeece7~CvzYOfJRQ0283202832eucas1p1K;
	Thu, 16 Jul 2026 10:44:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260716104357eusmtip2cc624be619bcd0856727825883ac67e0~CvzVIUrCg2851928519eusmtip2d;
	Thu, 16 Jul 2026 10:43:57 +0000 (GMT)
Message-ID: <1eec88e6-1ea8-4525-bb17-e41444d715dc@samsung.com>
Date: Thu, 16 Jul 2026 12:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
To: Thierry Reding <thierry.reding@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko
	Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
	Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
	Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Andrew
	Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
	Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
	Hocko <mhocko@suse.com>, Robin Murphy <robin.murphy@arm.com>, Sumit Semwal
	<sumit.semwal@linaro.org>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
	Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
	linaro-mm-sig@lists.linaro.org, linux-trace-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ak_E4UxfnFJywJa7@orome>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260716104401eucas1p1f2c155f5f3a4655c82e831bffdeeece7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c
X-EPHeader: CA
X-CMS-RootMailID: 20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
	<CGME20260701160902eucas1p1214af933ba0f54b85630a3a4e5a4689c@eucas1p1.samsung.com>
	<20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
	<3f47aeab-33b1-4966-a5ce-5d6d5261e0e2@samsung.com>
	<e212caac-6c30-448a-9e10-32fff8b842f6@kernel.org>
	<83e5e74d-7106-4e14-9d10-56438372f6a3@samsung.com> <ak_E4UxfnFJywJa7@orome>

On 09.07.2026 17:59, Thierry Reding wrote:
> On Thu, Jul 09, 2026 at 07:56:45AM +0200, Marek Szyprowski wrote:
>> On 08.07.2026 10:35, David Hildenbrand (Arm) wrote:
>>> On 7/7/26 12:02, Marek Szyprowski wrote:
>>>> On 01.07.2026 18:08, Thierry Reding wrote:
>>>>> From: Thierry Reding <treding@nvidia.com>
>>>>>
>>>>> There is no technical reason why there should be a limited number of CMA
>>>>> regions, so extract some code into helpers and use them to create extra
>>>>> functions (cma_create() and cma_free()) that allow creating and freeing,
>>>>> respectively, CMA regions dynamically at runtime.
>>>> Well, the technical reason for not creating cma regions dynamically at
>>>> runtime is that on some architectures (like 32bit ARM) the early fixup
>>>> for the region is needed to make it functional for DMA.
>>> Can you point me at the code that does that? Thanks!
>> Check dma_contiguous_early_fixup() and dma_contiguous_remap() in 
>> arch/arm/mm/dma-mapping.c. Those functions ensures that the CPU mappings for
>> the CMA reserved region in linear map are remapped with 4k pages instead
>> of the 1M sections, so later, it will be possible to alter the mappings and
>> change them to coherent when needed (altering 1M sections is not possible,
>> because each process has it's own level-1 array even for the kernel linear
>> mapping).
>>
>>
>>
>> However, in the use case in this patchset the reserved region is only shared
>> with buddy allocator by using the CMA infrastructure, not registered to the
>> regular DMA-mapping API, so it would work fine. I'm not convinced that this
>> is the right API to use for this though.
> Are you saying you're not convinced that CMA is the right API to use for
> this? Or something else?
I read this again and indeed CMA seems to be right solution. I only wonder
why do You want to create the CMA areas dynamically? Imho it would work if
You just create large enough CMA area on boot, what would automatically
share the memory with buddy allocator and then allocate dynamic VPR regions
with cma_alloc(), potentially unmapping or marking the allocated region as
reserved in linear kernel mapping to avoid any potential speculative access
to the protected memory.

In both cases You will probably won't need the DMA-mapping API on top of
it, although it might be even possible to partially use with by
registering custom dma_ops for the devices using the protected region
(assuming that it would support only DMA_ATTR_NO_KERNEL_MAPPING
allocations).


> I certainly don't think we want to get the DMA-mapping API involved for
> this because that always implies that we perform cache operations, which
> we specifically don't want for this memory.
>
> Thierry

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

