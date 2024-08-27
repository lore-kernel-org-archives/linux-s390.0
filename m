Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B80189522
	for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744775; cv=none; b=XGAbVqQQ44jU2shJACq6leGPqLYjoy+c35PcChAdOyZ1dppdnU+3/foDtWAXcsnXMOAQlELOAPIH3/v4Em55GyITyaoKBAqpk6xL78E5q0jtFoVV9TuOmud68tXTH058G23Z91a9xY8d5fnX8WBqEVIPwqb+SZpAPwMf+R1MiTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744775; c=relaxed/simple;
	bh=ikZCmmAm5THeKWLXLqgcL8YwQmmXnt0dgIwvfcrnj0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=T63sChGQQx0oI85moNw65Wc++8vcZyL+Z/dR7caf2OCtLcbfxaaiAZjQKn6cvNU4bb7IDXRk1Sdp8nXeU+2L0NP0AjFJvAI0NpwGB4JpvS5/vfbUvMhtNnflbMmWe7+Qv0rojRfROMLYAVuHQ+FX6V1A0LMmV9Zc/0kebXhX1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aonowNXF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aonowNXF"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240827074611euoutp027f223eef77406ebae2cfb71ba8743c9e~vhjs503Wm2967229672euoutp02U
	for <linux-s390@vger.kernel.org>; Tue, 27 Aug 2024 07:46:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240827074611euoutp027f223eef77406ebae2cfb71ba8743c9e~vhjs503Wm2967229672euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724744771;
	bh=kfDFUjs7/q5tIplnMbJnk4YsrEAYZmv3Pq/OPVvfdLM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aonowNXFnsPBl1w5o3cHGIn0bWkFavi8nntq8BZnBxrL1W506Eyh2lI/cllMpe/uf
	 tQks1xYDXHMUOOCooyhNJLg6aPGnRZHapjBr8+K+1jwQg++AbMyFle1rzera/r4oRb
	 keqdrJux1RG3zdjIKCHIAfyC3II02q+GUc5+nDzA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240827074610eucas1p13ac389b59f36049879f9f074056b2a1e~vhjsbJFKV0306003060eucas1p1G;
	Tue, 27 Aug 2024 07:46:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F8.A5.09875.2448DC66; Tue, 27
	Aug 2024 08:46:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240827074610eucas1p213b68cc09fbe310cb707804e90a6a3c6~vhjr4wuuc1758917589eucas1p28;
	Tue, 27 Aug 2024 07:46:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240827074610eusmtrp2a06199635b59700d136eb9e7aafd0dcb~vhjr4CO3o2030920309eusmtrp2I;
	Tue, 27 Aug 2024 07:46:10 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-95-66cd844202b0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 14.64.08810.1448DC66; Tue, 27
	Aug 2024 08:46:09 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240827074608eusmtip2a9ffd70ae4400a94c17978bd742ea4ea~vhjqpiDOe0430004300eusmtip2O;
	Tue, 27 Aug 2024 07:46:08 +0000 (GMT)
Message-ID: <5615235b-d114-4a7c-bebf-f7fe72886489@samsung.com>
Date: Tue, 27 Aug 2024 09:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESED 1/2] dma: replace zone_dma_bits by
 zone_dma_limit
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	=?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, Ramon Fried
	<ramon@neureality.ai>, Elad Nachman <enachman@marvell.com>,
	linux-rockchip@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <87ikvmv45i.fsf@tarshish>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djPc7pOLWfTDPYfUrBYce0Ni8X7ZT2M
	Fo8XbWO3WLn6KJPFry8WFpseX2O1uLxrDpvFpwf/mS0mLGxmtvj9/R+rxcI5z1kt+l6uYbU4
	+OEJq0XLHVMHPo8189Ywemxa1cnmsXlJvceLzTMZPc7PWMjosftmA5vH5IUXmT1m/fzH4rF3
	73ZGj7kNt5g8Pm+SC+CO4rJJSc3JLEst0rdL4Mp4fZu1oEGnYsWcqywNjFdUuhg5OCQETCQm
	zjTrYuTiEBJYwSjx4eAq9i5GTiDnC6PE9Zf+EPZnRok3D+pAbJD6yetbWCAaljNKvFi9kw3C
	+cgocaCzjQWkilfATuLL1uWMIDaLgKrEo5k/2CHighInZz4BqxEVkJe4f2sGWFxYIEBiyrNN
	bCC2iICKxP/n28BsZoFrzBKbZ9hA2OISt57MZwKx2QQMJbredoHVcAqoSdw7eo0dokZeonnr
	bGaQgyQEtnNKzOjYwwZxtovEjq/NLBC2sMSr41vYIWwZif87QYaCNLQzSiz4fR/KmcAo0fD8
	FiNElbXEnXO/2EABxiygKbF+lz5E2FFi+dwXTJBw5JO48VYQ4gg+iUnbpjNDhHklOtqEIKrV
	JGYdXwe39uCFS8wTGJVmIQXLLCRvzkLyziyEvQsYWVYxiqeWFuempxYb5aWW6xUn5haX5qXr
	JefnbmIEpr7T/45/2cG4/NVHvUOMTByMhxglOJiVRHjlLp9ME+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM6rmiKfKiSQnliSmp2aWpBaBJNl4uCUamDi7wlJOrlmm6Z+X8PjOQ7rLl9JDnB+vWxp
	lPkPpcnB+fnzFTd/+MZe2q9xPFjzxK66xU/M16lsnTfhuw9ztx/7xOsCtlZ6dosrD5cWcK48
	FHV/TWK0qq5pVtOx5ZxhP3vOL/9pllf6vKLu8tMk73357o5Hd+/pkZ5n2/ho7V/5ug9pGv2h
	mz59P5Bid3TOe/t1u46et5oW0uxuoel8bIfow5xFdZNbbFrP7HnUmPSUN90zdXLZwsglJzN0
	s6xOcgX+v7z/vu2meudl24sff1/1Q7XjTPGndZG++QVzE32dzmewympLMd3enfC57NiBsMVL
	w83/6TU8OHEn/Wehskfit2uvL7wtl/6meCnEQl5NiaU4I9FQi7moOBEAMPhlE+wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xe7qOLWfTDG6ttbJYce0Ni8X7ZT2M
	Fo8XbWO3WLn6KJPFry8WFpseX2O1uLxrDpvFpwf/mS0mLGxmtvj9/R+rxcI5z1kt+l6uYbU4
	+OEJq0XLHVMHPo8189Ywemxa1cnmsXlJvceLzTMZPc7PWMjosftmA5vH5IUXmT1m/fzH4rF3
	73ZGj7kNt5g8Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
	Sc3JLEst0rdL0Mt4fZu1oEGnYsWcqywNjFdUuhg5OSQETCQmr29h6WLk4hASWMoo0brwHzNE
	Qkbi5LQGVghbWOLPtS42iKL3jBK/754ES/AK2El82bqcEcRmEVCVeDTzBztEXFDi5MwnLCC2
	qIC8xP1bM8DiwgJ+EvffbmUDsUUEVCT+P98GNpRZ4BqzROvP81AbvjBJzGh6DtbNLCAucevJ
	fCYQm03AUKLrbRdYN6eAmsS9o9fYIWrMJLq2djFC2PISzVtnM09gFJqF5JBZSEbNQtIyC0nL
	AkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIExv+3Yz807GOe9+qh3iJGJg/EQowQHs5II
	r9zlk2lCvCmJlVWpRfnxRaU5qcWHGE2BoTGRWUo0OR+YdPJK4g3NDEwNTcwsDUwtzYyVxHk9
	CzoShQTSE0tSs1NTC1KLYPqYODilGphWFwjcUBPdcWW6ufQE9mbmbj9ti/q27S+SLu1bdjVn
	3s/ZGxe/iMnKsGjvWl+xKOHDCSf5faHydx4qV1qsvV3+429p1feFjDzzivJ1boaGzjC49TqL
	semFcnq+9+pFT14Lhb9PV3p4UeaUyeHbF70F1kwQsGMyfhBRvDdijbmGoVzRo89HAy4UnL/a
	zD9RpuSCBPs1zdsTo/Oybv87+O/ejMMbpCI5Hrva9x6bmFUc+3TPhmcZ7fkrlwS/cTa6llIo
	tOX+p2kHl5/YMT9f9YJfnPOczB9FbwsPTDSv0n73+f+Vx47sb4qqlXi+ZvxTmi1Wc+v0Q6G9
	rgzheq6Prknp8byfXMVp+ThAhLfpNf8jJZbijERDLeai4kQA35+ZY4IDAAA=
X-CMS-MailID: 20240827074610eucas1p213b68cc09fbe310cb707804e90a6a3c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240811070951eucas1p1dc5315e0d710db13ce28fa0a977c7bc1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240811070951eucas1p1dc5315e0d710db13ce28fa0a977c7bc1
References: <cover.1723359916.git.baruch@tkos.co.il>
	<CGME20240811070951eucas1p1dc5315e0d710db13ce28fa0a977c7bc1@eucas1p1.samsung.com>
	<17c067618b93e5d71f19c37826d54db4299621a3.1723359916.git.baruch@tkos.co.il>
	<53d988b1-bdce-422a-ae4e-158f305ad703@samsung.com> <87mskyva7o.fsf@tarshish>
	<f206f46c-0e2a-47a3-84b3-30bb53499f75@samsung.com> <87ikvmv45i.fsf@tarshish>

On 27.08.2024 09:03, Baruch Siach wrote:
> On Tue, Aug 27 2024, Marek Szyprowski wrote:
>> On 27.08.2024 06:52, Baruch Siach wrote:
>>> Hi Marek,
>>>
>>> Thanks for your report.
>>>
>>> On Mon, Aug 26 2024, Marek Szyprowski wrote:
>>>> On 11.08.2024 09:09, Baruch Siach wrote:
>>>>> From: Catalin Marinas <catalin.marinas@arm.com>
>>>>>
>>>>> Hardware DMA limit might not be power of 2. When RAM range starts above
>>>>> 0, say 4GB, DMA limit of 30 bits should end at 5GB. A single high bit
>>>>> can not encode this limit.
>>>>>
>>>>> Use plain address for DMA zone limit.
>>>>>
>>>>> Since DMA zone can now potentially span beyond 4GB physical limit of
>>>>> DMA32, make sure to use DMA zone for GFP_DMA32 allocations in that case.
>>>>>
>>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Co-developed-by: Baruch Siach <baruch@tkos.co.il>
>>>>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>>>>> ---
>>>> This patch landed recently in linux-next as commit ba0fb44aed47
>>>> ("dma-mapping: replace zone_dma_bits by zone_dma_limit"). During my
>>>> tests I found that it introduces the following warning on ARM64/Rockchip
>>>> based Odroid M1 board (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts):
>>> Does this warning go away if you revert both 3be9b846896d and ba0fb44aed47?
>> Yes, linux-next with above mentioned commits reverted works fine.
>>
>>
>>> Upstream rockchip DTs have no dma-ranges property. Is that the case for
>>> your platform as well?
>>>
>>> Can you share kernel report of DMA zones and swiotlb? On my platform I get:
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000fffffffff]
>>> ...
>>> [    0.000000] software IO TLB: area num 8.
>>> [    0.000000] software IO TLB: mapped [mem 0x000000083be38000-0x000000083fe38000] (64MB)
>>>
>>> What do you get at your end?
>> On ba0fb44aed47 I got:
>>
>> [    0.000000] NUMA: No NUMA configuration found
>> [    0.000000] NUMA: Faking a node at [mem
>> 0x0000000000200000-0x00000001ffffffff]
>> [    0.000000] NUMA: NODE_DATA [mem 0x1ff7a0600-0x1ff7a2fff]
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000001ffffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   empty
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000083fffff]
>> [    0.000000]   node   0: [mem 0x0000000009400000-0x00000000efffffff]
>> [    0.000000]   node   0: [mem 0x00000001f0000000-0x00000001ffffffff]
>> [    0.000000] Initmem setup node 0 [mem
>> 0x0000000000200000-0x00000001ffffffff]
>> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
>> [    0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
>> [    0.000000] cma: Reserved 96 MiB at 0x00000001f0000000 on node -1
>>
>> ...
>>
>> [    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 3MB
>> [    0.000000] software IO TLB: area num 4.
>> [    0.000000] software IO TLB: mapped [mem
>> 0x00000001fac00000-0x00000001fb000000] (4MB)
>>
>> On the fa3c109a6d30 (parent commit of the $subject) I got:
>>
>> [    0.000000] NUMA: No NUMA configuration found
>> [    0.000000] NUMA: Faking a node at [mem
>> 0x0000000000200000-0x00000001ffffffff]
>> [    0.000000] NUMA: NODE_DATA [mem 0x1ff7a0600-0x1ff7a2fff]
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000ffffffff]
>> [    0.000000]   DMA32    empty
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000001ffffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000083fffff]
>> [    0.000000]   node   0: [mem 0x0000000009400000-0x00000000efffffff]
>> [    0.000000]   node   0: [mem 0x00000001f0000000-0x00000001ffffffff]
>> [    0.000000] Initmem setup node 0 [mem
>> 0x0000000000200000-0x00000001ffffffff]
>> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
>> [    0.000000] On node 0, zone DMA: 4096 pages in unavailable ranges
>> [    0.000000] cma: Reserved 96 MiB at 0x00000000ea000000 on node -1
>>
>> ...
>>
>> [    0.000000] software IO TLB: area num 4.
>> [    0.000000] software IO TLB: mapped [mem
>> 0x00000000e6000000-0x00000000ea000000] (64MB)
>>
>> It looks that for some reasons $subject patch changes the default zone
>> and swiotlb configuration.
> Does this fix the issue?
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bfb10969cbf0..7fcd0aaa9bb6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
>   
>   static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>   {
> +	if (memblock_start_of_DRAM() < U32_MAX)
> +		zone_limit = min(zone_limit, U32_MAX);
> +
>   	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>   }
>   

Yes, this fixes my issue. Thanks!

Fell free to add:

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

