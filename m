Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012039.outbound.protection.outlook.com [40.107.209.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B3221F39;
	Thu,  2 Jul 2026 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951930; cv=fail; b=DcR8qPzDPIlpof3RRjizfIce0aE12kvLbBlHUFCtlMrYVtjiYUZvHQthsu9IeMcnLlOq3wM/5tSBv4pTdg0C8HZNfIbqal5r6sVI3trV6y8xOqhufWBn1vh+FzV2NsnogOWKsFRT/edfe5Xhoa3TFU3I1snPJHg6gG052GBBqLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951930; c=relaxed/simple;
	bh=jQXu0jEZyG1QsRtJOmM+c2jB2TWNvnf6akIPEOsO11I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PQIOZYih7TDJYfC2kvVgqgJoXu9pHaWF/u67Cz6boeejV+e22UeUYAzqZeVqhn1lQpKDkpJ9i9/jZ7aIBK7qHPTYVuQYAVNCyYPDVl7cozbueSiTqMYXqD9Bwu435/QPDOa8tT3iV9ncClmozNbKwXQ4cC5PC8CSJr8mnEO6OQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N3Saq3+l; arc=fail smtp.client-ip=40.107.209.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N3Saq3+l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOLqvxV3BB9w9/nuTXj3DfEmcoNJDqqvU9QJFUPACKo1/45y3OdsH1B/SXzG9ojCuIX4JqdDMytNvbzcULyDCUo3HVIngrxbThOfFKNzlnw7Mvojtit6LI8jFnxyxrRrG0u7PJMTNtjHy4twb2CGWqsl89ByPdC3pWqeo+as25LH5zyhjpyUMLNroxfrj3boep0ZAM0QD+CWtev6p1ksyw/6XiTu+Hcgm2pvEX+MWWETxchDbSKGmxMXfmT2X8bKCV6id+Sbz+41Js8WTP7PVoklLJ9juZJHEmS0vtAEtXXK25okr4ZQ3JwDpspwXNa+9II89IhdPyEp8l8N33aFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Yhufc6xvt9ifcyT6JrnbvwoW7wfKisRJN0hIK3Yvs=;
 b=ZX/EiXokTyIclQEceN2YnO6XUubMu++r63r9mh+X/SVFXNnWNdCM1BiGE739OWbRzVvRwUxa8VXRKC/OzvhK/RrdLb05VmZrQbXni8qQO6R8Yj13kYwGj7oCaWrzKlx8sD0vshnpPruNqkviE9G2vQRLC8dco1c8qjYztV/hUCVr1GP6f+tCA4ptMC+Aui4s7TrEJ4DPpx4ewAkzokUOmdPgnVurEOXsOlhgRVcbfdzFFNrQmepU1j3gOu16SFEFu2rt69AiZvQX4v3K8ejilIKrLRXsQZDI5tRPO1JQbeblnZvF+rMItT5hIwOrB5OBVMHfMXhjoIN0OLYf35Nxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Yhufc6xvt9ifcyT6JrnbvwoW7wfKisRJN0hIK3Yvs=;
 b=N3Saq3+lpzUxOgV82PY3ma58fCIlDgOAkFLRnT5SUPcl75REAX+PtHNJoakQm4YjphNHuXHX3rAp38MHbQQFCgTEj9Y5r49HkqrJx40j5sJn+RhNlxg4Cdds8JLS22UA60DZpK7XdaGAiZFsxkFI6wzV7hWKVlA4yd9+ic5YtMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by IA1PR12MB9739.namprd12.prod.outlook.com
 (2603:10b6:208:465::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 00:25:25 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 00:25:25 +0000
Message-ID: <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
Date: Thu, 2 Jul 2026 10:25:16 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free
 paths
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
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
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260630160242.GI7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0050.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::9) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|IA1PR12MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: ea092ab4-5f61-4960-a5f6-08ded7d0695e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|6133799003|56012099006|11063799006|3023799007|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p1meNHZ7/WPm688u50XyH2zieVFOZhf/YoocfZTXmF7kj1oUTx//CFegyc7SKauGWVQE3wV3Qd3fnulWYMUvNuoxXxBKhjRls6t38JtMbsuVH3kUgFpq2NxfIY7t1wdVq3CuyXM/0DcdEVHh/fM3AIb42Hw86Knh+RgnAa5NF2M+iRz1y89RQkE9mdmOib2p5UxjLYVVioVtDJP5g3O2iEnHWZ3vSWO3fG08oanpIZNKSVy/JdvA2XdUHmKlLNZVV27qFffx6P91UI7oPtvw1wKbadClSutEWCMhILiYSBdpNpYU/lcK9XxXTDG31G29er2o4m60/UwwXq3f8YFDs8PP3EO3LanqV+CzzGgd87K6MzSKlfxptf28ocXOEi9BUBj1bZf6FaBqus/ITGR6+lFaOk5jrFO8OfTjxzM+dBqP5LAPQ2yLgENJWEo1rqtaqZFvR4ZyH7FvJkt2lCCm9a1bEGM2CdW842Y/ipP++L3OgpcfkaDqn9WCdPiSUvFycHfoNvpdfVrodXAZxTKUsmUlvoaCWoVR2ehkEJV0kyaQUVkq1pETq3IeYQ1qqMqZJN0+XD6Jm6jNiPth+cIDVnyb1oE5v2BrVbzmA3ETgi11Ew7j1QM7w+UTTbT6I2uwWcva/Rd1v25NMopizt26m4yr7ccO2vcsSywNzv/ZcnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(6133799003)(56012099006)(11063799006)(3023799007)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlI0RDNTODFKc2N3ek1YYWc1bzZla0ZxNFpnTGJzc2k0T1YwQ1daejRGZzZt?=
 =?utf-8?B?WVZ6bXlrNENCZ20vQ204SmtZZzMvd0ZJZzFCSEVteXlnSXIwZjlURjQ2bW81?=
 =?utf-8?B?amEwWjFEOGJkUFdZZVU3S3NXNkl4a2NHSFA1SmtJTzFWajMzSEJBOHVuMUE4?=
 =?utf-8?B?WU1ta043Vi9hOTVkdC9ISnJYdStMbTA1TzVaZzN4SXA5aUxoQ1BlRVFZQWxt?=
 =?utf-8?B?VHEydy9XQjRrcU45RXR5L3NDc0lHTU84OXFnNVl3MnhITmdIdVhDRXh3bHlK?=
 =?utf-8?B?TlZRSlZBTjRzRndYRXA4aTVPV2NJa3doQkFsTEV1V1B2OGIrcHV3OHNVcC9j?=
 =?utf-8?B?eGpCaEpjWjBmR214V01FVGg0eFdOWERKMm94cDl6RVNDaWQrby9VcE03Z0RN?=
 =?utf-8?B?bC83SnppbkptWHVQMjhZdFhPTXljMkkyNU54L2pZZFc2Uk5RUFg1bDY2U1JT?=
 =?utf-8?B?UTdEbzkrQTlLZlZwZXN2TjJEdmJkRnRnUXVoRDdEdSsydjNSdTZwRzJSNmpE?=
 =?utf-8?B?YWdVRFI2MmExcUtLb0RUSW9Ob2FmY3pOTVFOSTYwTVRhVUpieVVadlB4ZEdt?=
 =?utf-8?B?YmRJWnBTMmlFR1dJZGJVazBHY3hzSk1EZHZGeldqZXZYazRKazlvU0Y5TDkr?=
 =?utf-8?B?WHRDaERFSWRVL0VZQ1N2Z1ZrQVFTRWsxdTZDcE5Va3RGcGFtYWxFWk1KZTBJ?=
 =?utf-8?B?UVZweFEwdmNCMlVKSjF3QU0yWnQ0NXJ2M0puRFBITW9GM1JPVGNlVnZUSkh0?=
 =?utf-8?B?N25iRXpIL2JNdnBVbnNqbzdPei9rWWc1eUEvTEtPN3duSHNGblVsT0Y5V0VU?=
 =?utf-8?B?SkZvdmNyV254OE5tM2JrMTFzZHVia21hT0RmNEhLN3pxdXA2Z1VNbEJkSE0v?=
 =?utf-8?B?ZzBodHlhQ0podlpZUXUwRmxvb2dGY0UzejZ0WGR3Ly95aE5mcmVyNHlKeWN1?=
 =?utf-8?B?MUFWTUJhYVkzRTdiM21ZVTFPYTRFUnJ0MFM2MWVkSUJtNUNqR3h5TkNzSU5s?=
 =?utf-8?B?TkNhdUZWTkRpRlJoSlhLck14ZUZsM3MvSENvMmorc2QvaUVRZlFjTVZhZW54?=
 =?utf-8?B?NitjMDBJTjdyMml2OXYzbzNoOWZWUkluL3JlYXFFdEdwUHg1M0JVMHVQYmZp?=
 =?utf-8?B?NlJNSnR6eDNvYmpScVp5UnJsU1krQWY4dDIvdmROQWM3dWd2bXJRaGI3OWVD?=
 =?utf-8?B?MWo4MGhCRThGVy9kZVc3TC9raUxQSlpmbWcvbGxIT296amdHSHFXMnloeDQ0?=
 =?utf-8?B?N01QU2o2SFhUblA0bkhHN0tzRmxhMDJ3MHIycjRUVnBrRmFQeFFVS2xUS2NR?=
 =?utf-8?B?TmRpWWNtWUdBYVJGVmluMVZUNkpERG1LQTNmbVJJdWM1dk9Hajg4T29ucXN3?=
 =?utf-8?B?ZmdMNWhaN3JQbms0UGdab01zaGQzTDQ4VXRqb0xjS0U3a3dtTXRuSnhJVlZa?=
 =?utf-8?B?Wm5wK3hrMGIwRXozZ2pMdm1tK1ZHMUhmUlZFblVhek53OWZYU1pNRGRVY1dk?=
 =?utf-8?B?V3FpUU4wYThqN25ocVdIQTdKYVExSlBhRTZjK2Ewd2dGYXppK1g2eW1tUDJK?=
 =?utf-8?B?SUE1aUxLNnE4Z2ovSjlCcTdpb3ZSNjJCdXc1c1Ava05RVTB0aWxnS2NOeWtM?=
 =?utf-8?B?dVUrc0wxd2MrZTFJV3cyRmV4SUVKSXI0OHVDVHNWTGE2SUNFU2JQcHZZOTNt?=
 =?utf-8?B?L3BWdUIvaFpFVmppZlU0UVEyZFI1Zno2RTVDZndtcUJjSW5XVGtrV2FrMG5U?=
 =?utf-8?B?ZDhlcUdWU0J6dUd4dEFONk1tSmRrWnlTUDVtWHYwRE1acG5SSmpJTEtNUW1m?=
 =?utf-8?B?aDlQRHVCYUFMUXIrOTFXVGJVV0lnRUVUMzlQLzhWdmlYOXlQYTdGcDFCeGdN?=
 =?utf-8?B?MmZla3U3bG5qZ29mTFZNQ1VGaHc2MU5FRUcrdHU4NC9mdXZkbmRacUk4cjZa?=
 =?utf-8?B?anpiUHkxdDN4NWM2RXJrUGc4bHF2K3FaNjhkb0d2bFhxbG9hTS8vaTFZVjNh?=
 =?utf-8?B?bnJkdUphdXZ0c09yZjU4SzRTZnFwelV3c2N0aEFkS21RaGw3bDM5OWNwVUVZ?=
 =?utf-8?B?ejBGbCtpTGJXcGptaEd2YjFkZzRuTC9QYUZBUUdLaUVhT1RGL1FQV1A2SElp?=
 =?utf-8?B?dzZXcE5KVnIzUEFtcEJMUUFxTUozbXJkajd4bnB6ajJUM3o0ZE1ZZDd0d0JH?=
 =?utf-8?B?aXViRmZydGNIT0VXK2ZYaFNlUVYrNi81bWZRRlhHNkM5MlhaKzdnTGhYUENW?=
 =?utf-8?B?MlZHYnVmNzc1S2VCU1gyeXljTG5aWi9tSSs1RWNTSVFBb0ZvZnBVMnozakhN?=
 =?utf-8?B?UlFQNDNVQXdYZWJ5VjFEN1A5QU5uUWt2eStKVkJuZ3dVZXRnR0ZaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea092ab4-5f61-4960-a5f6-08ded7d0695e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 00:25:25.5184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUrlBrWbc5RCgbjPHJEsAk+nbKxhn/JvXJpLN03KjNzP3xIRf2nPsbiRw+tlFrRXuUVaFafQeBmKBFjpdsjAOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9739



On 1/7/26 02:02, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 12:39:21PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 18/6/26 01:41, Jason Gunthorpe wrote:
>>> On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
>>>>> @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>>>     		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>>>>     {
>>>>>     	bool remap = false, set_uncached = false;
>>>>> -	bool mark_mem_decrypt = true;
>>>>> +	bool mark_mem_decrypt = false;
>>>>>     	struct page *page;
>>>>>     	void *ret;
>>>>> +	/*
>>>>> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
>>>>> +	 * attribute. The direct allocator uses it internally after it has
>>>>> +	 * decided that the backing pages must be shared/decrypted, so the
>>>>> +	 * rest of the allocation path can consistently select DMA addresses,
>>>>> +	 * choose compatible pools and restore encryption on free.
>>>>
>>>> Why this limit?
>>>>
>>>> Context: I am looking for a memory pool for a few shared pages (to
>>>> do some guest<->host communication), SWIOTLB seems like the right
>>>> fit but swiotlb_alloc() is not exported and
>>>> dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,
>>>
>>> Then setup your struct device so that the DMA API knows the
>>> guest<->host channel requires unecrypted and it will work correctly.
>>>
>>> I think this is a reasonable API to use for that, and I was just
>>> advocating that hyperv should be using it too.
>>>
>>> But it all relies on a properly setup struct device.
>>
>> Sounds good but how do I do that in practice?
> 
> I think we haven't got there yet, I understood Dan's plan was to add a
> bit in the struct device that signals if the device must be
> unencrypted or can support all memory.
> 
> Currently the dma api assumes all devices must have unencrypted by
> default so it should be fine already, shouldn't it?

It assumes that DMA returns a handle for shared memory but the state of that memory is not guaranteed beforehand. I dislike 2M page mashing.

>> not externally available so I'll have to trick the DMA layer into
>> using SWIOTLB (which is still all shared, right?) as I specifically
>> want to skip page conversions. Setting low DMA mask won't guarantee
>> that the DMA layer won't allocate a page outside of SWIOTLB and
>> convert it. Manually do
> 
> Why so particular?

aahhh I missed "pre-". I need a way to get pre-shared pages for my sev-guest activities.

> Any address that satisifies the constraints should
> be good enough?
Any address can be already shared (from swiotlb) or not (from outside swiotlb). The latter will may trigger 2M page smashing and this is what I want to avoid. Makes better sense now? Thanks,


-- 
Alexey

