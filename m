Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011013.outbound.protection.outlook.com [52.101.62.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2611D43F085;
	Thu, 16 Jul 2026 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784166940; cv=fail; b=aLoQqImfxLdKPav1QM0kuAZ/Ybd2Eeh+LCRUvuKMXB6FFODfsHqoR/HCGGrwYb0hZRkuL2QLhucXMLEhxGL5+CRonq7Hn3r76Nuz/bSS0uEL+FSm5BQPo8c8dSO5ssfyqOLrZbFwbAO11rRb0hx2CtTSh7RAbScVwk/rodT2mc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784166940; c=relaxed/simple;
	bh=kme2F/2Gj4ocP8DuHc4/4stIhaByvO1khmT8lhhwshg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F8Tsf0gi/J5tgFqeVHaxfxKErWJpD+fJnwHRxynmx5YJ41UesWGCX8WCF2pD0wXAF4UbVf7ND57OzC9uDwXY8nvYidqPSE9ta89dZdVgpLk7kNO9lq1XWpNb1tp32p0soGIhz+wFFxg7RLOHCz0cszRr+Eo2icRofuOiDuoS2aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KcGX72NG; arc=fail smtp.client-ip=52.101.62.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KcGX72NG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJGCzjVhW8V8zendMo67b56lWFWHiAfdaUJqmG2xoVlfeKfj0vrK/uBCsLUznY60fI8lnT0LyF3g+yM60rcSWpWApL7dwolGr+s7hjwMkpCbLHwwZqcuquUjlv10Smpq9HK06c6jUb99SF6K6ZyjRrWfaoKWhp32yOCFhYZUKn9mnDRtBfRcX3YKSbEzOjIFLiKDKDIhfK4rVUXLCPWGQN8ATNT+RPJLBRRVdIbIMkVNnapGtXHCsXhmaS1/yEyJtFJsor0j5EINpkyb4kRwHbDHHIlazBsHSEyM5402dSrYauFKQYYKVbB6+eAlEwooLs3HoxUanqg4RYSeFlHDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/nm4eBTeryvdummOUlc9sparb30fgg4Vsv5lLPFgO8=;
 b=oxl8fPtD6VbZN5H562GTWZWZqsMW/rpFNHEG6N9QBnN0/tikHW6AzK/lbk4CnV/50z4IIqr0CaaAflpfr2nGxrPnSSURNklwvn4p/M4PtEHe34oY5sePC+ZT88HGwivVpu2WihlzrZaESS8wY5JVF6v1hy6uN16RGVR/0U9fXYoZi2PjsvFobUoVy9HbV9oonALBoRC7yXzBl2xLdMDdOejoCseVGI7JYUMnd4VnqYcjZWN7b/VAmYLtS+IUblWkf0wMcJuc0TMu7aWgH3gpEsP3lM/rCxB0cgGszxANKHYdUvDgfkgSQfZNsYZlrZ/gX9ee1c5y0kHfzOfNz8YpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/nm4eBTeryvdummOUlc9sparb30fgg4Vsv5lLPFgO8=;
 b=KcGX72NGwop+JAvjIIpxxzb2cTgbUhu08TZW6o9eHuMFCT9in3wsxdOwA698R00LhRSE/ZHdjgSZ1z8ilR+VTSjj0TqZSoEcL04g8VJYuHcRxOBB8wTlP2mExCxu7wDBY1cD7rDZxIZf0q4lPZR1ihDL0ISKdV2s+TrO+Uwd0S4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CYXPR12MB9442.namprd12.prod.outlook.com
 (2603:10b6:930:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 01:55:34 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 01:55:34 +0000
Message-ID: <9d83ec13-3b1e-4c1b-8bab-16ea057cfba0@amd.com>
Date: Thu, 16 Jul 2026 11:55:20 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Jiri Pirko <jiri@resnulli.us>,
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
 Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org> <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5apl0xgy89.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0051.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20a::14) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdefcaa-7381-4e34-8787-08dee2dd532c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|4143699003|11063799006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LDI9dnkp/bF59M2uVsgk+p1VyUnj+a0ovCMfeGxDu8kn8ISn2bHyaqKWKcoYtCkMtOWVQqpWGQg1LKK66LO8lbIGd4vvli32OrN5L8Vdj+aWo8ZEudTBOcYdGcacai0RZFvd+Vp/59oWBMtrIaAP53ciwxNPgTCDfTw/8UTnID9/+yH726IHDIlV6tLTuE6cHWIkMVY9/33Wg0DsPhfuqbdwbcv1ad/2HpZoxqwDmH5sUkLOZrMxNq8pwUv3nej6p61h6Hpdw1lwaytpPXaU5SNVafEIKzxGxDeKeMbkDiH3O0t9X0UFzQegSRFi2hxRgOEgY+dKT8OOjb8JtdiiOj/N5bJXXvQPZpmDehEXvRIHHKWfR13yriInWfDxi4pg965kwJ0BR6ACX5uKoRp+kJCN9ZXfeWx9VV/AI0NmKShCFZ2iJbrRfu9VFgVqew633KFDYMNHEPhbhOFqKD6AhUsYdjTTALFBZQ5KY3dEBOD0oQ0T2Dgkbh08XX0Mw3Zrdq4AOwsDK9YgJS/zNVvE7SVHq/S8mVrejx4Iyz2nNZpx9+GrMBLFrWAUfzESUkNP/SO1TYZmBGyOt9v5wac+sx0j61cJZ8i39PNr+sPik8v1PPNVf/ghGEekUhUrENW+WyRDG+24mcP9AMue18gejScPQFCvCJfjreSs+7gf1dY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzFVSE1DWXRLSVozWXNDR0lKRWdTOFhLY3NIbkZNZ2JvRzRSdnVVQ0xQOS9m?=
 =?utf-8?B?eDJtMmEra1VhdVdkUzJhT3d3NG9EaGZKYXNycnBJUWl0YUxmMmlpUlZVM04y?=
 =?utf-8?B?R1YvTTg4WlRMbHA4cnlOSXpqUVlsczBnWTRjY1JVaU0xUGdZVlhndW9qSzJo?=
 =?utf-8?B?QldNRHptb2Q3SU9RSDdRT0tkb09oK3VRVGN2Z1JIKytuYWtQbjdGRDJOdzhU?=
 =?utf-8?B?aXVrdHRCdzI1My93UGZHMDBNMlE2NWYvMitQLzVQLzR2Q1dQMjFDQkdvYU1z?=
 =?utf-8?B?d2VlSVB1V25vWXVXZWdWNmdVZ00wREw5VHA4aTdCWmRvQ1ZUNm1PYUhNRCt6?=
 =?utf-8?B?Yi9sS1kySkVvOWhlVytIVEU0bnJVTE9uQk5xdnZQcWdjMVFJbk0rTmJXSld5?=
 =?utf-8?B?enNnUC92ZnBURHhCc0sweWt0YzFSY1BuTDJHMjB3UTNpblBERDlHYk9SYXVa?=
 =?utf-8?B?Z1grMkRDNk5kWFBaWm0vVGE5RGlVTXZlMXkwZGxlZ01GTjZwVUcrZzJtMXZZ?=
 =?utf-8?B?eEpPa3UrS1NUUTlidW1oK3h2Y3Y1ZVlERVY4eWVpVDZDSDlGcUM1eU5VQ2po?=
 =?utf-8?B?VDg5eUs1aGszd2w1RWltQmwzc01XcTZ6QWxEa2dKTjhQU0VVQnZyNzFtQXpw?=
 =?utf-8?B?Rk1SM1o2TlRKNWQxY2FqZ0ZuVllGcmxnNlczU3kzR0UvTkRBcG9zSGdNeUpm?=
 =?utf-8?B?VHpHRDZUd09RdFJVRC9NUkNQbVpvK0YxV0Z4WExNQVpFNThuNjVSTzcrT1c3?=
 =?utf-8?B?aWl2aURDbkFFNVdiZEJlaFhRK0VmT3Z1bzE1em95QlhWa05HNTExVFVjVkF3?=
 =?utf-8?B?QnN5b1FFL1hkVkppL3g2V24wdyswUlF6RkZKVEhQam14SCtZdUFJNzF3WFJ6?=
 =?utf-8?B?VG1pTkVvWUxkancrbElXWlpnY25SbFNPNDVtTHN0eEZaWkhBZFczVmoycXZC?=
 =?utf-8?B?M0U2VW1yUVUwejdHTWhlR2Y1aUdzL1AzLzZnRXlUMm5QbWQyeHFvQjJIK0ky?=
 =?utf-8?B?TWEwYWZPWitOOC9kY3hHVjJQYkwyZXF5RXdCYlVUdVh1elJIbWpodnQ4V3N2?=
 =?utf-8?B?YmZFdmd2V3o0TUczQU9EaGtRY2NYdkM5ejl4UGluaUpUZXhDR1dOTnZ5VnJa?=
 =?utf-8?B?K3BpZnQzai95VW5jOFA2SHQ4NHQydnF0ME5YNFJTWVJ3eHkrWlpDNGtmMS91?=
 =?utf-8?B?Um1vbUNRRE5lWnY0SXB5S3NBcWRJMFVwZGVmUHNZTW1GNHhtenYxR1RZd0U4?=
 =?utf-8?B?c25YUXIvYzhWblJKejlVWTdCTUJ1M3g2S3ZQek1PRXpNS004V1lLM2JZLzFR?=
 =?utf-8?B?QTh4U3cwdWtqQU9yazBOWjlmNmN5bFFPdmUyZ1YwZ0tTczIyWm1ETGxRL2Iz?=
 =?utf-8?B?bTE2VkNrUHBseEY0U1RQRGZpN0tYa0NVT0poYTRaSzBYL28wOFhvbTlublh0?=
 =?utf-8?B?YTZ2TndrQ200UEY4L2N1QUVRN0M4TUlzWnpVRFR3WGdEbmp4MlErcHduLyts?=
 =?utf-8?B?NVU0cG1VNDJIL1hwM1gzaDIwTFVBR1hTeldyK3V2Tm5aY1QrSjVSYzZtRHpJ?=
 =?utf-8?B?K0RFejZvTzllSEgyOEU1T1BxZ3RXdndWVXArSDkvaTExZGNTcWMxSDBqZkR2?=
 =?utf-8?B?T09CNXVMUkkrWmNqM3p4VE8zVVRYUzhhcGp3ZzV2UExwSHBtS2QwSWI0ZTB0?=
 =?utf-8?B?Q0NmbmF3YldzNnpYRVJhZ2ZRUjZHUzNiQkQ4QmdiYTVWbzV0S0tCTEpNbXJh?=
 =?utf-8?B?TmNWMmwwN1Nqd2NCSDM2TjVzZ1huZEZRNDVZNy9QdFQ3c1NrQjJ6d2ZOeWRl?=
 =?utf-8?B?bFZYRHFlTUViL000YmNLQnRybm1PWnF3Z0R4ZzhvQzJKMnJsYzZMdDgwUE43?=
 =?utf-8?B?RWFEZHVWa1paRjJZVjNYUjh5ZTVtNGZWL2V0YTNGSS9BYjZHUnZtdWdQR1Qx?=
 =?utf-8?B?RDY4RFhQcEhCanhQbG9Xd2JRVGZtdFhGQWN4Um5ra2xOa1dsbjBZUis0YUlT?=
 =?utf-8?B?UkM2UENkTWkrUC9RM2FTM2d0ODJpcVlBSStraXZUNG5TcGd1U05HS0hWbE9V?=
 =?utf-8?B?clFsNm9pZTVwL2lNZXQxeXYxalFDWWhiTThzZ2FJM2JBY280dXpXcXlnWWRL?=
 =?utf-8?B?NEdTa2hGYmRQU3MxUVg4anF2VnNPYi9FMFlUVHlvbWhWbnZDSGVvaUxXTHhG?=
 =?utf-8?B?dTYxWTM5dUd3eVFnRHBMQTgrOE81UVFTOUE2cFRjK1FsTTc4dXRPSWhzN3Ft?=
 =?utf-8?B?S2RWc3lsRFk2b3daS1QrOEhpSWw0ZllRem1oYklTeFVVWTMrbzViT1krVEs3?=
 =?utf-8?B?VkNSRXdNb2dIVW9rYVZQS2RvTDVmeUZ4MnZVWHNCVENSb1VjVHk2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdefcaa-7381-4e34-8787-08dee2dd532c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 01:55:34.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0n5fry6jt8DThgczWTNwKlzhtrsb0/6iVovs4Qy5f5Y4ikDmhsqRfq5HVp0yi31ijwYyR/astGrc8zioZRpeAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

On 9/7/26 03:58, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> 
>> On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 97987f850a33..acf67c7064db 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -338,10 +338,8 @@ void __init arch_mm_preinit(void)
>>>   	unsigned int flags = SWIOTLB_VERBOSE;
>>>   	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>>>   
>>> -	if (is_realm_world()) {
>>> +	if (is_realm_world())
>>>   		swiotlb = true;
>>> -		flags |= SWIOTLB_FORCE;
>>> -	}
>>
>> For this part:
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>
>>> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
>>> index e05dc7649366..f3fc28f352ba 100644
>>> --- a/kernel/dma/direct.h
>>> +++ b/kernel/dma/direct.h
>>> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>>>   {
>>>   	dma_addr_t dma_addr;
>>>   
>>> +	/*
>>> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
>>> +	 * as shared by default.
>>> +	 */
>>> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
>>> +		attrs |= DMA_ATTR_CC_SHARED;
>>> +
>>>   	if (is_swiotlb_force_bounce(dev)) {
>>> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>>> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>> -				return DMA_MAPPING_ERROR;
>>> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>>> +			return DMA_MAPPING_ERROR;
>>>   
>>> -			return swiotlb_map(dev, phys, size, dir, attrs);
>>> -		}
>>> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
>>> -		return DMA_MAPPING_ERROR;
>>> +		return swiotlb_map(dev, phys, size, dir, attrs);
>>>   	}
>>>   
>>> -	if (attrs & DMA_ATTR_MMIO) {
>>> -		dma_addr = phys;
>>> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>>> -			goto err_overflow;
>>> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
>>> +	if (attrs & DMA_ATTR_CC_SHARED)
>>>   		dma_addr = phys_to_dma_unencrypted(dev, phys);
>>> +	else
>>> +		dma_addr = phys_to_dma_encrypted(dev, phys);
>>
>> For AMD/SME, on host with memory encryption we now end up setting the C
>> bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
>> some other MMIO bus understands this attribute. Maybe we should stick to
>> something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
>> since this is not universally defined, just use the old dma_addr = phys
>> if MMIO and ignore any unlikely DMA offsets.
>>
> 
> Considering for AMD/SME system an unencrypted dma addr is one without C
> bit, will this be good?


Normally both encrypted and unencrypted DMA addresses do not have Cbit, with the only exception of "iommu=pt" (which is not the default afaik). And in this case, having Cbit in DMA handles only makes sense if p2p trafic goes via the root port (== IOMMU in passthrough mode, and I am not sure even about if the root port will convert this Cbit to T=1 MMIO in this mode) but if it goes via some PCI bridge - then Cbit won't mean encryption for sure. But I do not know much about p2p (never touched). But in any case force_dma_unencrypted() seems to make no sense here.


> 
> 	/*
> 	 * For host memory encryption and device requiring unencrypted DMA,
> 	 * MMIO memory is treated as shared by default.
> 	 */
> 	if (attrs & DMA_ATTR_MMIO) {
> 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> 			attrs |= DMA_ATTR_CC_SHARED;
> 	}
> 
> 
>>
>> In the other case, for an arm CCA guest, if the MMIO is shared we end up
>> setting the shared attribute but that's fine, it's only an IPA address.

IPA == guest physical address? Thanks,


>>
>> -- 
>> Catalin
> 
> -aneesh

-- 
Alexey

