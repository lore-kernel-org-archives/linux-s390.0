Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC30C35F5F3;
	Thu, 18 Jun 2026 04:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757912; cv=fail; b=a65TuYlAb2MuS/WGRnlj6cHrC97CEjiDr18qFnM0ug0+AU6N6tilJNRkCki42uGPN9XqJYSdZ3CKUVNzctI8OipBVRkKABUfVqg/xwk7nadwtgOedHE3B3lMcOmUmqnaO8BO98PXCXBIygMgG7CCBuhK66YbLMtgOu/xEL2cor0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757912; c=relaxed/simple;
	bh=F9zTk4lG/t45RJtSrz+qhPMgBGCZx1AIEdcidehE4Xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmIup85ZWyKLtrvLYZMsGKyz10XAr2Ge9e95dl47R7fzhEIbU+miC1+mkFbtuNCueNGNGrFQImcR/h/WklwXXjBYgql8BThM8s4Iw3lNLmdPxBLXCAY2sQyiUhaRQoOV2QdRqbyHWdzZ5kxrJ7oJowmsN4I/iL0SM0umz7pQ8tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tn2L8ICK; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tn2L8ICK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQuwm+fIlOZ1YCjC2T0UPeQ4/p1m4f+L10fKU5CvI5AaMwawSN6or4OhjMj/Bl0o+EgvesBCDBaDiPU0pipghl7sfstjSnPnt7S23hPa8V3b9rcwh05gTsWzDRWu2CmD4W51N3kguKUdWD4tweebrqGVgfEETpN5SiFQDKQhs+IzLe6udzUWyCyxXYAm9uDKRJZSUQiykDX5CUejnNU1XHINdk+hgtkWQ7x/UbICjntKttqbH1dyCbLiS3qW+yKeEp/kyrXvbrddzKX0ElP014oVVKx2cx19MH+2tyE5M1J6NpLeip+2ozh+eGRWmr8fQhL+b+5jJMLvmOkjK8Sfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7335j7KHV3WiqitjlGpo/Mer3Lc36auTU7z9836cfhw=;
 b=iWUeaVinU9SYe/aP7Dpb6GIr/Fq11oKzJz0fXlpjoqgGXlCqlB++XtWfhZnemjjit9aTdgB18HY812wAUBwnAjlI+4lF9eYxWZHuiZ0b9ro5hlK3aBnHlnsxT+b5ipXRTqKR1uC/wEBt5b7QO4rl5wRJ3LjwVFo6pnd+fVwvmQzGduqJ+L7VI+GtBuvTPTHeJLTzQALJCHRtaDYEa/9AwcGmqq+yauJ0nBB6RbE2sZFOaY0f+ODMeF3o+e1VKv6AjZV5pFVVnX9dMkiEvekZbnObuw1sW2o31LUu9jSVdJ8IfLFn3juNc1lSZfos6kxMCbLBukTlBVQs6l1elY0dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7335j7KHV3WiqitjlGpo/Mer3Lc36auTU7z9836cfhw=;
 b=Tn2L8ICKDuDhKRjj7RosC/EfC0j4y0hKfIn2iSmeWNiiYKFmnWZiZFZVGkPFwAo+NedmpbJhAvgOyzL581hHxF2Ym9o3fURgxwczqp1hvgK07Htud3DqXFeD2i4DAPqA+YRTobfFzRZ6yHmwPxO8qbSLf/fsOiaupwn+9h0ZDtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CY5PR12MB6347.namprd12.prod.outlook.com
 (2603:10b6:930:20::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 18 Jun
 2026 04:45:05 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 04:45:05 +0000
Message-ID: <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
Date: Thu, 18 Jun 2026 14:44:56 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
To: Jason Gunthorpe <jgg@ziepe.ca>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Jiri Pirko <jiri@resnulli.us>,
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
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260609144746.GL2764304@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0084.ausprd01.prod.outlook.com
 (2603:10c6:10:110::17) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: b79d3294-2263-4ddc-d59c-08deccf45da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|6133799003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tqsiRuttotqwkOwQtSi2UNS0cTqdSo6zBZzUYfUnZampfmReHessoEkIJ/0RbAN64Ax8m/3YZYUfFsATZEyscht92WZJZwm3F5uFCSg7khSJ+/5qU3hhhL22vSVgkOkt1iDTwnn6fBfGfNccrq3RGjxJnD1k7KW0QPBS1bdf7i2ldG2JdgVdNZUL3ZGH0abPgJ7H4wvFWkNCkzeVSp85yaHoTfG0GS7nqf6YDmQ+ipoOC6bObPJLYFeNN/BeBbqhQlzPq7guUdm6R0z1kaMSvhM/NSnQLpftyipLIbPI48aGhJyudnskz5qp4UeIWeHvq+pwrIcznvBxDKIbKP0yuPSpGoLr2WA171bJT/MgKp1NuCehGpyPodzUM/xudyG4gYZwgGycf99+8QlYFWYV9mtR0mbydjwqFZ2KQGEGLzdrNZ17fkrbQvJtXe+NzcfmuUWrCwMM6XICemberQ7v3P/L0tHtIfI6JLwtrcEWDE99FbAvnMLamzkFMElOzMX1qdmm06o+MFjWetZwcaPigh8t31l6mLVhr+NezXq0cVNyQ5R88V3Zoc98mjOZPv6zsvoqRv9s//hLrOcmZJk478s5f0I/+ERtT7o3lZR5E7Gmf0TO1+L2fmES0YKGFaVh/g1pLcTgfh00q/NDIRLAzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnZyeklJVjgwWmxseFloTVM0OTZWV1hOTlRPRWgrclJvY0FjT0RZNnBvSzlo?=
 =?utf-8?B?cjd5eS9XK0tsRVhKMWJKM2lZeVlJbmFIMTEvd0VUaUgvdTJZZDFWQXlXOXZI?=
 =?utf-8?B?N2NwaGVqcDZyRHFPTTlHOXBEcE5vbWtIcDlzWjhBcEdOMk02UW1LN2xTVlJN?=
 =?utf-8?B?eWxGeGFrYkpvd253Y0ZRYWdIQm9QcVBOSGR0RCtuL3ZRb0xQTDZqQ0Z3VUFw?=
 =?utf-8?B?TnVtM0VVeEZRV2tJWCtjQVNZalhkMEdaRjByS3lBQXNocU91eEhKMTNkdWpV?=
 =?utf-8?B?WUo5d0p6UEhzcWEvcUM2VlMvSjAxamM5cTBrc2k1SVpPNDlWQzBJckJyWUZi?=
 =?utf-8?B?Vm00WXhIL2s2aTE3TzQwNzhlWWZ2SXhXWTQrNnlaSlcxR2NFd2kxWmlkR2hM?=
 =?utf-8?B?RXYwekVTclV5ZUNOWFNGcnlweWVrRGtWdHJYQTB2TVdlaThSbDB3L2tmK1Jw?=
 =?utf-8?B?UnFldG8zNVczVlpWVjZyS1YxRUl5TmtqeWk4Qms3eGRIc1RCdlFxUVg5WXVQ?=
 =?utf-8?B?NVYrYzk4aXBtZ1phalFrM0hyTU9KVW10aEFnN1NmMTR1WFhpd2dqUjhJYm91?=
 =?utf-8?B?ZEd6L0pFMGpHc1I5bDhYT2c3NVBOVDdrMUhzc2M3UXkvRiswSVo4ZSs5cXB6?=
 =?utf-8?B?SlRvZExnV2JSaWlzWEpISEFIc0lzM0lRN3hacDJveUlNOStZV1lSRUV4dGJt?=
 =?utf-8?B?cGFtd01KSUR4QVhKSzRvNkhIcVFDS2o3dHBtZEc2RzcvMzJjRVpsdFpUZXA2?=
 =?utf-8?B?V1NENFo5WU5CUnBGTlF1U05reituUnA1NmJ5SmhGYlVkV3oxRS9Qc0ZJWFNT?=
 =?utf-8?B?UmVLSXVqeUt3c1hWYlNmV2F0Rnlrb3JFeGlPWEsxVU9FQVlNY1R2SnB2aisy?=
 =?utf-8?B?SkJSK1RLRkU0YU8vT3daN214WFBaMWFGUHpCbkpzMzhtSGZuYmVSMUg2aWtx?=
 =?utf-8?B?SWQ0bXZnTlluTnpuS3dsU0ZBZXJ5VWpWazBkTkVCV1FEc29sbWtrZ01sQXRw?=
 =?utf-8?B?dFFIc0E3TWNHZCs2U0VWaEdieGFKclZiV2w5Mkh1R1hWTFIyekxjdVR3SXJC?=
 =?utf-8?B?YXBHU3ZVcDBjK1FVNTBBWnFJcW5xR3k4L2cvUkpvUXRSd1dBMjlsWTBIV1NL?=
 =?utf-8?B?K2dURzVPT2s0eVVjOUV6TXpZYmNQdVNXUDFaOVdta0pIbVAreGhYMURQOFIv?=
 =?utf-8?B?RVR0eG5GRi9pK2gwUC9LbDRVVzEvY3h0TUtiUWpqU1NNVUNHc3gxOTIyWnBi?=
 =?utf-8?B?RUYva3YydGJwSnk4ZHVEV0N3ekp2Ymd4V0dQc2dhczJyQVNkTE5FMFp4enBB?=
 =?utf-8?B?M0hRMkdZa3VYa1dTYmtLSnZURXhIMmNwUFgxMkpqazFFbU4rZXN0N1ZWKzd4?=
 =?utf-8?B?K3dNd3dWNmQzK2dOZGpBUGhSV05jZ0IwalBKWnczb25vMmlTUmZ3OGxzUE9U?=
 =?utf-8?B?RHJScmRPSnQrWGFVM1ZrdjZpbTF2bUNkSFZ2Yk9BV0pGRGVGL3FnQ2lTOU5O?=
 =?utf-8?B?c2tEVVcrcHo3Y1p3ZnRxaDFIVk5FOVRZYlBOMU5valZOZUJXMGt4SUY2L21h?=
 =?utf-8?B?aHJUeW5ObjhsaW9adjFodDBKZUlkN2lwbDh0amU5R0M4RGNXZS9McC9UUy9J?=
 =?utf-8?B?OHJ6WFdaaUNLeTN4ZFl1RC9WYm5wQVhrTjNmZ3ZOckJtSENwTVdoUS9wMWFQ?=
 =?utf-8?B?WEVSRW8rUUpVZlpLUlVqWGNWS1dMSzdmQVc3WHh1c0daZXNnV1ZCWm0wSE40?=
 =?utf-8?B?YjJiSTN0b0lSMFlNc3JhcjlDWjZETVdPVTIrMlFoTzBHWUIrL0hzUXVGMDV4?=
 =?utf-8?B?NnQzUGM3ME52MGtCQWtqY3AvQkxJZndYb1VoUjdCRWpmdXhpVGtSbXd0N2Nh?=
 =?utf-8?B?VmNuMEF1RWRtMGJpekhaeWJDa1ROYmFOUHRWeGdWTnZWM2s0bzA0WnJpRnBE?=
 =?utf-8?B?Y3pGcjhVNUcyTGVIbEI1RWpTakJud0RVNUtjV3RhbUllMHdJMTNFektEeU9M?=
 =?utf-8?B?c0o4eVVkYXM0bnBZU1ZTM2xWWnp5Wm9FZmlNMnYzM2FPZ2orNWJOanZtZUxL?=
 =?utf-8?B?K0UvM0ZHQTRhOU4wTWdVUkNxV0RQRm1yYmh1bHBqTTJGLzY5d013UU9kWEpx?=
 =?utf-8?B?eU1mUis5VTdZbzhaTzFLUUxqUllKR0lyWFBVTVY1VStqSHJJcE82bkIyYnZS?=
 =?utf-8?B?TTRBN2pKbXNDMlJ3WHN5WlhxcWc2eG1naEYvb0FpWHJUNEdHVEtKcHM5Vldo?=
 =?utf-8?B?RExsS1ZTYU02Y2Q2aEdJbEhQc1Q0YUVMNVczaEhMYlZpeFloQnF3RjlYZkxR?=
 =?utf-8?Q?4ljBzlj+FbgZ5aqaLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79d3294-2263-4ddc-d59c-08deccf45da7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:45:05.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSmzSkjGmpJwDZBn/XOkry3NFyDaEQdGcWt7J6581k1bro8ib9fW/E5LlT5lmDwn2MZEe/3O3z5Jyp+YCxPkCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347



On 10/6/26 00:47, Jason Gunthorpe wrote:
> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>> are handled consistently.
>>>
>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>> shared/decrypted buffer handling. This series consolidates the
>>> force_dma_unencrypted() checks in the top-level functions and ensures
>>> that the remaining DMA interfaces use DMA attributes to make the correct
>>> decisions.
>>
>> Please check Sashiko's reports, it has some good points:
>>
>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>>
>> I think the main one is the swiotlb_tbl_map_single() changes which break
>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
>> but force_dma_unencrypted() is false. Normally you'd not end up on this
>> path but you can have swiotlb=force.
> 
> IMHO that's an AMD issue, not with the design of this series..
> 
> The series is right, a device that is !force_dma_decrypted() must be
> considerd to be a trusted device and we must never place any DMA
> mappings for a trusted device into shared memory.


swiotlb=force forces swiotlb, not decryption.

> That AMD has done somethine insane:
> 
> bool force_dma_unencrypted(struct device *dev)
> {
> 	/*
> 	 * For SEV, all DMA must be to unencrypted addresses.
> 	 */
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> 		return true;
> 
> 	/*
> 	 * For SME, all DMA must be to unencrypted addresses if the
> 	 * device does not support DMA to addresses that include the
> 	 * encryption mask.
> 	 */
> 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> 						dev->bus_dma_limit);
> 
> 		if (dma_dev_mask <= dma_enc_mask)
> 			return true;
> 	}


So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this patchset, it fails to boot. But it boots with a hack like this:

===
@@ -39,7 +41,7 @@ bool force_dma_unencrypted(struct device *dev)
                         return true;
         }
  
-       return false;
+       return swiotlb_force_bounce;
  }
===

Or we say "mem_encrypt=on iommu=pt swiotlb=force" combo is just weird and we won't be supporting which bit in this? Thanks,


> 
> Is an AMD issue. We already have an address mask limit system built
> into the DMA API, arch code should not be co-opting the CC mechanism
> to create a special pool for address limited devices.
> 
> The correct thing is to ensure the DMA API is checking any address
> limits on the actual true dma_addr_t, not on an intermediate like a
> phys_addr before it is adjusted with any C bit. Then it is a normal
> low address swiotlb bounce like any other.
> 
> I think we can ignore this Sashiko remark, in real systems the use of
> swiotlb for 64 bit devices is very rare. Though it would be good to
> remove this code from AMD...> 
> Jason

-- 
Alexey

