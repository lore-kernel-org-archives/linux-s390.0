Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650BB219E8;
	Wed, 17 Jun 2026 00:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657462; cv=fail; b=BgvGJPrl8AqsiG6IQKJwR6tR3PL/jhitXuasjN+KhX7r4QgEyl+IhNMZxs0l8aklUbEjCiG1bfNFd53UOlWBwUzqWoXqigkrgCMAPkypou0kEUQB4rV4oQ6Lun0+o/qjKUXHbSyA/D/ms69dSKCFtjK9v8eKWTGLWDxlKzvlZmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657462; c=relaxed/simple;
	bh=coHfAFyUav8lH2C/EBwTeKGZvN20FSscA/I4IF9CEj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5kIl55CHiQfRKzPEZPrlP1kYTxQ3L13nvFU2QjCf3Ju9U9ShTshIBk/cw6QTfXVg2rh+yKCjEu6Aegxiz/FRSjU409K4pHSY64ix7hprqSP0iFZhRdhkRr0FW1ih+miT59FVgEDzQ9j04Mc+TvLroG7DQPWWWNCWdXf1EvBQl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbFulCjB; arc=fail smtp.client-ip=52.101.53.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbFulCjB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmDOZbQkjVrJuiLw8/nOZeTLYgCbTgsOGuxjF/Jd4hTMvpVUk2/fcYa8GbJ/tKGmFKwpXxuHLMuaOGhjmwx8lvp7PKgA6Q1I2+sun+xrImWFC3mn3jOJEvnGDY73gg4ZgSN7MuG7+VR5nfA10ZNxknnFMFxvTN8qtwSFmT7KtUbeotKZjRIxXr30DNoCnHFgAwYH2mG3cE8g0K/aDodCk2HtR57xqwVom5PMPmC8E9rG+cxbYVz9NDzucnwZrfMgxHaXLGQTnA8NPI+bs0IKADhunGmGwI6UhX1lT930ThQEplt8SHaJjV8FDg6BWAaPGHr6yOoq3zKVrBSwpb5m9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8JBnesZBrm7U/LhrZYPe4Gp0x7oIXKYBqhmhzRNnEc=;
 b=hqb1Hkuuf976iKWnavL4H84yQkWopgdXGwSrW2CbLrYqht6jRzNnCDgh6cdxdU1epHp0N+V5PtB1gSe2WLiV3gKrmSZy9nLpr/bj5N6ic1o5vcxaRuhUnSvisi5VatE81fHeaUbA+ZzioAP7jJKKpBhJy4z4OU1DSmoeWNVebPWeX4I1eU87ywjIiDXy1sEThZTN32hu2ZMHNYJEpFwu7a3yKY1mtyfImCrjC3/5yfVkQ5kluVPIsPRJb2NV/727IQPHdkqfr7VSZ1Y9+SZx+/u0G0cH595ydwIVmnB0RBbxgxNdypBeRJMrOBLdsrYrMPOQJoHilgLWP0RXeFENjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8JBnesZBrm7U/LhrZYPe4Gp0x7oIXKYBqhmhzRNnEc=;
 b=gbFulCjBL38tkmww8QotejWQclPTUrfD1hSp8qKBxL+ofshQPJIWuVMje4Mg5tzsQcNf8qyY4QNNqsjZrbu3v3TJVXiCFVeIWlJLVoH10+RRNN5cCY0Cc1SsjqOFvYNwpDUH8aHbQejJKgACC93BNAFSr+oLjfIs0lptSR3SoIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by SA3PR12MB7805.namprd12.prod.outlook.com
 (2603:10b6:806:319::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 00:50:48 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 00:50:48 +0000
Message-ID: <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
Date: Wed, 17 Jun 2026 10:50:39 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free
 paths
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Dan Williams <dan.j.williams@intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
 Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
 "Cheloha, Scott" <Scott.Cheloha@amd.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260604083959.1265923-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8P282CA0021.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::34) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3c37af-cffc-4830-8386-08decc0a78c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	nkXzYCUuCGe+qORqV4+JnKcgFHHkw1lLwrFP5+ZHFs1VgzanCtsUEw7M137pvWhT6JNP/o07sz2W8dtL6SID28WSXwMcOV+p3uKcD1y4JRtz+DcdhWnw8o/miDHUNPJYyo+pDHW+qatPxWnr6YTtesdCvfa4QErw8lhuWgzxkgMDDnyaSZnuV5QfDBvAnLv5STpnXNgkRxdpHsEQIWTkttoAL+ZitY4r1oeGULU+ZMyhYCHajXagrxZq8HAmRzPXpscqPmFzagbwIgxJ9bmCFW2thlzMt1D7RFmzZQ7NHAp4soO7gT1dw2Ww9VOQrem2HrRybjg4Ed4snvDRC/ZOzO9v1xpXB/cHgYpDpVaSjTn+HH0nn7E3X+5vT1h0elXMJ2jBQdh1GVPub58a7poebsD8Q05tFpGLNru8B1ANI2q383tmfdAp/MfaN4jwFQ25O/Ny85BSs6Y29C9NKard6dUgsdes7AQPIApq7HXFp1GDD1ikM0xBSpvGroa3HTKmqm+iEuH3JpWiJwJ7k6B0H1D2HjTVe/hiuqq4bGPf7os/DstDKN+fzdgCuDtcituNSwFxGQoqeat9aC0FYhB6vcHhFhhjvu4JN1R6F9Uw//R+Vs1PEZX6Jjfr34SrmWCE2S2u/DMX7bUb5pTO/kNE33wIN73zxB4C7dGMSEMnGXQs9Q3thUEDdxc8BuPOngCq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTJNWXBBdUJWU3lONGRYdzUzYUlXK1hNUkkrUHN6bWpGbHJZcHppbkh1NFBs?=
 =?utf-8?B?eXRKeXIveHJGNWwwbmY1UFJOajNaRTN2ZlN0alU4REN1czcrYjlFUTFraUFn?=
 =?utf-8?B?SDR1MVB0YXpWQXNDQk1tbE9Tc0xISjR3b1ZGSDFNbTA4VU8wN3JBeUowSnZN?=
 =?utf-8?B?SC9SVllWMUdHM1N5YnRubytJNElSSTY1dFJLTmZ3QjE0ZXhFWTUzaHM2VEpw?=
 =?utf-8?B?MGNmTVJzNWxXRUJPZU9zaG00UXdwNG5UOFhBdndmZjA5bytzWUJYWEt0NU5j?=
 =?utf-8?B?eG94ZWVIenRVUzlpbEplT1ZmdFJwbjF6MzN2Y082RVJKNnBMci9FazhDVzhz?=
 =?utf-8?B?Nk94a2JPcEFqT3dDTWN5Y2lha0lLVEErd2tFSlZFdnUvR0YyckF4a2k0bHhV?=
 =?utf-8?B?VkROYzhLSzVNbW5DZnRrVU1jenNkNlppbWdkWXkxUEo5UkJMT0FKbEJmTUwr?=
 =?utf-8?B?dE1jTzhwMlBsczYzcVVDSFVTcnUzZ0tOc1lyVmFkUElxN0JJbU5Ob0p2Sk1j?=
 =?utf-8?B?SlhnUjl1NXZrejJidFdpTk9SZDQxQUdQRGovU2NwVWE4ZUJhOUljSmhreXh5?=
 =?utf-8?B?TEM4OCtjNG9NbUJYQVE1d1hScE9tTEhZRGp4VCswNi90aGk4dzBSMWRta0Uw?=
 =?utf-8?B?MXV1ME1vanQwOEFoMzNWRWpDSkwyb250M0NzVS9wL0NQTnVJS3ZVRW44M1h4?=
 =?utf-8?B?RHVFMGMyYzNLdUtacklqZFVRb0U5SjRyVjIxOVA3eHlGd082K3N1K2pEYnZr?=
 =?utf-8?B?b3BMNW1UWjZVNVRHMXFNbWtncU1wQ0thNVdGTFM1bXBiZGF5TDVJRWJIbUEy?=
 =?utf-8?B?MDlEZVNEVzhKQ1hUQjZqNFI0MHV4UUtZOWtYMXhVWEdnV094Wjh4RVJtMnNF?=
 =?utf-8?B?Zk1oV21HZUNkSXh5MXNTeXNRYUdqMXo0TElqUVVJRWFkRlA2OUVKZWM5VC96?=
 =?utf-8?B?THBZWU9ZdGFzYk0wVXR1cmU3aTNNT0ZGQ1ZJdEFtZDlOWW4xaXBZOFBVZkNp?=
 =?utf-8?B?K283YXJCb3NkeExaRWhUK1RpNm95TkxVZmdLVEgvV2pRbjdRNlZnYTdDUmJM?=
 =?utf-8?B?ZlpHbDBhaUpTd3NsNnQ3cXZ6QXoxQ2VxdU4zTVgxTDA0YWJKTVc5RXRteHA3?=
 =?utf-8?B?bS9hZnNyWVZ1RTVsNDgvL29ZVDhvNDRvbG95NFB4Y1J4MFE1STRKY3pGRlZo?=
 =?utf-8?B?OWVZZjJoWnUyTzFnUHFlZFNndFZna2drVFE1NEpuWGZZa0xMNlZ3RzdTclV0?=
 =?utf-8?B?Q1E2bjhzblRuRjhHYUtoSFJmQkcvWDNIYXpFQUxjUHJrWUsrUUR2SUp5NDll?=
 =?utf-8?B?YWlrbUZSRFFkUWdSRHB3LzErb1p5bXc3ZjE3S0ZTck9MOUVCYnpJbDNtV05p?=
 =?utf-8?B?d2pXbVEzNTRpTStLK05ZRDdxLzg4RlIzMndjQTg1dUk0bk43SUlaS0NoUEJs?=
 =?utf-8?B?MlZWRTFHcGR4QkI5Y21TS0dpWmFrajUydWh5VlZFWEVxdm44UG5Od2dEWE1B?=
 =?utf-8?B?QmlUZnJRaXFycTRncW5sclFFVGlSK1o4OGdwdExNUFpLNVhCcEFOdmQ2MHly?=
 =?utf-8?B?anZDdWt4RHJRbmswVWxwZFV5UlVGQkhJdTFIbUJTWUpJeUhwMjNER2RyN0RC?=
 =?utf-8?B?RGU4anl5bzMxYVk2WXlwRHFseWZ5VkFSakhUbythL2xsTXBNMGhJdXkybGtP?=
 =?utf-8?B?c0U3SGFDem80NGxrV3p6cnc1UEM1U3JhUTczd0dWZmllM056RzFhSWhkMDEr?=
 =?utf-8?B?Q0pIanp5S0tROUZWUGFkZmJVbnpOQnk1bmFwdms4NmNRWG9aV0x6Q2RwbGds?=
 =?utf-8?B?NzFtNjZIKzBQZVQwc1Fpb0hXQ0JFditJWWtkWTlBdG9ydHJSTG84dUUvaDYv?=
 =?utf-8?B?VWZNUWs5WUFxT0xYcXdMZlNCTjNtTXBhZTNpTFpWdkNPNXZzeFlaS1orc3RS?=
 =?utf-8?B?d3poK0ZKM0R4aEZySjg2Nk1sTjZ3cjZIaVZSK2hRU2J1ek16T1BZT1hqdWVu?=
 =?utf-8?B?T3l3ZUxnMHMra3h4VWUxRWF3STR3ZGd0c2lXeFByc1hRTXJoMTFTUWxOUjlK?=
 =?utf-8?B?QmkyMi9UalN5SUFBSFJFNVNDclM4UStsM0p1eW5XaFRRNjRIL0RSZTBrcndk?=
 =?utf-8?B?ZzY0dVhKWkx6aUN5ei9aMkhYcVhmU1RNOW1KK0k2QVZ1bitSNDJ2aktyd1dp?=
 =?utf-8?B?OVg5V3I0TjZLMWZXeXk1N0xuMG9zWi9FUkVOZlFnK3VHeUVONUY1TTA2MTkz?=
 =?utf-8?B?Y3RUZjVaYk1ndUdxdEc0cXVOOWE5VEY2N0RybkowSWN4TVdDa0l6K0NBdGhF?=
 =?utf-8?Q?1t5hJgEz/QtEBcgP+c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3c37af-cffc-4830-8386-08decc0a78c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 00:50:48.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJyYNehu4aFAnuaNinqQcslh0HzPNpR+EN7/6VUccgE4GzgT43HcxJmU5ai6ILjOhnnQ38ROI0a6z1yCGQ/dRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805



On 4/6/26 18:39, Aneesh Kumar K.V (Arm) wrote:
> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   kernel/dma/direct.c | 53 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index a741c8a2ee66..90dc5057a0c0 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = false;
>   	struct page *page;
>   	void *ret;
>   
> +	/*
> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> +	 * attribute. The direct allocator uses it internally after it has
> +	 * decided that the backing pages must be shared/decrypted, so the
> +	 * rest of the allocation path can consistently select DMA addresses,
> +	 * choose compatible pools and restore encryption on free.

Why this limit?

Context: I am looking for a memory pool for a few shared pages (to do some guest<->host communication), SWIOTLB seems like the right fit but swiotlb_alloc() is not exported and dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,


> +	 */
> +	if (attrs & DMA_ATTR_CC_SHARED)
> +		return NULL;
> +
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_decrypt = true;
> +	}
> +
>   	size = PAGE_ALIGN(size);
>   	if (attrs & DMA_ATTR_NO_WARN)
>   		gfp |= __GFP_NOWARN;
>   
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
>   		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>   
>   	if (!dev_is_dma_coherent(dev)) {
> @@ -236,7 +251,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	 * Remapping or decrypting memory may block, allocate the memory from
>   	 * the atomic pools instead if we aren't allowed block.
>   	 */
> -	if ((remap || force_dma_unencrypted(dev)) &&
> +	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>   	    dma_direct_use_pool(dev, gfp))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
> @@ -312,12 +327,24 @@ void dma_direct_free(struct device *dev, size_t size,
>   		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>   {
>   	phys_addr_t phys;
> -	bool mark_mem_encrypted = true;
> +	bool mark_mem_encrypted = false;
>   	struct io_tlb_pool *swiotlb_pool;
>   	unsigned int page_order = get_order(size);
>   
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +	/* see dma_direct_alloc() for details */
> +	WARN_ON(attrs & DMA_ATTR_CC_SHARED);
> +
> +	/*
> +	 * if the device had requested for an unencrypted buffer,
> +	 * convert it to encrypted on free
> +	 */
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_encrypted = true;
> +	}
> +
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
>   		/* cpu_addr is a struct page cookie, not a kernel address */
>   		dma_free_contiguous(dev, cpu_addr, size);
>   		return;
> @@ -366,10 +393,14 @@ void dma_direct_free(struct device *dev, size_t size,
>   struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>   {
> +	unsigned long attrs = 0;
>   	struct page *page;
>   	void *ret;
>   
> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
>   	if (is_swiotlb_for_alloc(dev)) {
> @@ -403,7 +434,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>   	phys_addr_t phys;
>   	void *vaddr = page_address(page);
>   	struct io_tlb_pool *swiotlb_pool;
> -	bool mark_mem_encrypted = true;
> +	/*
> +	 * if the device had requested for an unencrypted buffer,
> +	 * convert it to encrypted on free
> +	 */
> +	bool mark_mem_encrypted = force_dma_unencrypted(dev);
>   
>   	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>   	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&


-- 
Alexey

