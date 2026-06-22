Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178E18C02E;
	Mon, 22 Jun 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782089917; cv=fail; b=CIHVUGKDpKgxzHRKJg9zV0AkK4bkPAY6FHkUiY82yZ/vBp/Y3LnSANK7fIKKa960GDKpcqnlV1QEy11lMwYf3mtZq+1Ctlz2isuW8XCrKz6Z8WIkVmpQxwGrTrHWAh3hdFKCVodOY7+GTw28sBP40+B3C1XfOMXHFE3P3BGEC2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782089917; c=relaxed/simple;
	bh=7CHy71Nt7nUICvVAYTE9tsXPYUoxYjmZk+P0TPDPGGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R336smlEFSdYwu0K0U04Ue2sWWk1ShA9kQHfusPF0Ux3ZVARDvc0SwTRpwppxv/PAGd/lF1nHFXG9Gk+wlmqDUu1krtbCHZ8BUydy8hQ0S5AzKkjhD6VBoEdKe+Z/VvYbKAZ7x1CBiWk+NYj6wOfqA6MPmWdx/offlW92i3PAQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rrRfZOxZ; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrRfZOxZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMAqy/0MFsA2psc6ReWgWqyzA8l3jj0ISXznOvxaHg2/H9uBkHnybw88v0Wt/M5nJUZXNMAhzHPCglo8/ZJTnYeZCNZyCVL/NfYg8aY17Y9XlyTONxNXDq5R+I6H7bvHS47ISupe7yV+qL/e/lLeM9fU01zNjfW6qKhLgMzqiOQ8pib0dcs7aD6NqLakhE310fO0VLfLFhH415JWgBcI/rxy+fd5iKfazcOuX4V3GdfMPOWHBZOmzakt4DJwsucSHZ38okGzjOLdtd9nlBrN8ubjX5/F46tf7McNlyGJwfkSzGOLyQK0oCXnnMNp5As/+L5K/EKAyHxZACT62dDLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaGyQ9yh8csbwApDJxSVr9q03p5Lu/Ktj4l8kTToqMA=;
 b=G7Hlsp5f3wHDcr8FnKcEYsB70y/LV6s/Y8EM0JsrrUuQNS5y7gm4AfbCU0CnwzxSMNnH8NXjq0m22ppw2VsMFaGDZmlzaSNN4J8p5mPU2QRERXFY1RfDwVTrhjJl62KAWF+BnxpNLOgY6IPzfWqHNi6ylihMnyzFl3lz4ZXJpcdjBPXiWTWj5GDWAbhSUgw6//HXNihbgwj25YQrP4Ndupmpc3INk4s50LtnpxgmgxTDmN986OF3rEHODGy05Z9hS8Y75ZpdDsw/d5GBxmwqSx32YokIBsU7ysYA1VyUpoqRvzRTze4eOKT2UN97NADLI08o19X/Vpt1usy4Gl/WMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaGyQ9yh8csbwApDJxSVr9q03p5Lu/Ktj4l8kTToqMA=;
 b=rrRfZOxZ/w4HP2kJoN3LIjfMGeisZjIbWMzF1bTr40Hr68H/5gU/oRToK1Qz+CFA0231FXnOa6FfCNrDzpavekcy7qnVLA7xjjaoDhSzp96E5BO+m7tiCCRUathASNumfzR7NfT34qLX2Nntt02T9Q7Qr8GrbelMz5JXGu2ruG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 00:58:32 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0113.015; Mon, 22 Jun 2026
 00:58:32 +0000
Message-ID: <9f20ce61-1edd-411e-a7c3-be541fb89cb4@amd.com>
Date: Mon, 22 Jun 2026 10:58:23 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
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
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com> <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
 <20260619120309.GI231643@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260619120309.GI231643@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0128.ausprd01.prod.outlook.com
 (2603:10c6:10:246::26) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 184e9de2-6718-48ea-6866-08decff96151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|4143699003|3023799007|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	TrkR5OBkj0SFTEYRg7Dlw3r7mkTXiPngouKmV2hEXVeMlX4t4cS8uxsh41YeS6ACueT8l0e0YcjZkck6kJomHhl7HQncARXHB4lN3/AISDZBkhBBzG420AK0pFe/6HwEHu+PryfpAu1ifoNxk+HnxpyTVZNFyCf389pKj2dcPlXAkbZ9eHXea/zwpN7sBDq9vRXG1HbTxeBMff7dxFBqhmAgYSLBEVLz2lkTuASSOloxXLRI1kbQqgTuRsHL2j1JQ5C3kQKr/4kLVSjdjB0szYQ1z3ohm+tLj+BCb2Inx91x8Y+DqkaLfxhb4ZU7lwMaJnfmKgJwmR6suNWR+y+kQKn8x83vhlBOe3gHK0R4FRDOwIrzvaomo/K+E4xeeOcE8N0raRS0P4MjUAPkMycuzudICEzYnhXYgEW5mNmcMg67b8tRMQbHmXSxucr1ZtbLfbio+pvCvrsFRubTwud5N6ogkGtb6nshyz/zvITx5XCUuLfBhYSzYdBzPeqf7L7sepzn6R/P+kvjY8otwpMCvUvERTpESx2Lr8QD9nzgZsW88dQZvAwLN3ge8PN/BcY1QrMiOPlEd4OPfCD+lqYS41Ktachn6oiP2Y2g48wTpXejmGnPxkDl6zzKUt/m2e0+xNQn/BM9preC1VtSFHeFqCyLIvmjQRTXzXRSHuCP0Lw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(4143699003)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVFVYlhRMnQyaUhLNUIxRlUyTEk5Mm5iNEpkbnlyRmJETGUwSmJVSjNDVjNF?=
 =?utf-8?B?Wm1jTHhQR3IrMHlwb0szOFFZTXdZMVFLMGd1Ly8rZmNYb2pISzlOSEdFWUcx?=
 =?utf-8?B?QVNmYjM4V3VyK3lIcW1NSER4MWNHTnRPZW5BMDN5NDlWWDQwbm8wR3o4ZTNi?=
 =?utf-8?B?QzIwblpsZ0ZJMHZWeWdJd3pPVXdqNThDd0tLTW85eTBXZWwyTHlzV05hWHNk?=
 =?utf-8?B?bmZGMVpsTkYzYWdTdStsc1FMd21rbDZuL3lmdUtDUlV5dlNDRVlPNUF3dWF4?=
 =?utf-8?B?VDVSL2JZejRxNUFLMldrSmxIa21PSzhjN1crTUMraWFzUG5yMEdiNkhodUdT?=
 =?utf-8?B?YXVWR2hvaS9KSHRPdnV1dkNyZFBLblhPUGFBeVBWbEtqOTZPRFFNMUpDelpa?=
 =?utf-8?B?MlVCcXdVS1FxR29VaU1PNXE5aDIzL0V6WmRRZzdGNHJHZTV2OUNkajRDcnZa?=
 =?utf-8?B?SGdPcFlLcmpGMlRYck12Qm9jdE5uRDR5TjlDb3BrNEZDYVZrNjE3WTg5V1BV?=
 =?utf-8?B?eWswcnFwY3pwdXZYQlV0M0tWQWdNL0NFT2owTTZuT1FWOWVUdnE5cnUzTXFN?=
 =?utf-8?B?UGZvdnFQYlB1SVFUVDhUS2hwNzJhY3B4dDU1WjJNVkRNV2RZTjh1blhRd3Nj?=
 =?utf-8?B?LzVqN1NOZjFMUzUrcnU5bW05WUtKL2JhNGluejhKWmxnSWdSc2dMSDdrMzZP?=
 =?utf-8?B?YnpVNkJnYmcyakRvTjlFL2FNeUFvTkVKcjMyQ2lVYW15aUlscmpZTmI1WDNu?=
 =?utf-8?B?RkVacnRVekIvTjRERjhVcDl1WEZjcmFKejhHcnVXUjZnMi9iRXloSHRYYkJo?=
 =?utf-8?B?ZmRIM1hVQXlHaDRrc0JFWXAvYzFQbGd2cmxwTjBGRytIdTBYSDUyTVd2UzU0?=
 =?utf-8?B?Y3h2QkxNcmwrS3RVb3dMMGJOai9rZ0MvZlRSSFpxYlhnQkRJMGVuNitQNmwx?=
 =?utf-8?B?OTVJNGtQWEVEc0NWQVN2ZmlyM3RNdU5UY1dnaDdDc2tRTnV4VDBvSGpwUmEv?=
 =?utf-8?B?aEtjZUM0NndxTGEzeXlrMXZnQ2FUNjc1cEFHQ3h5QXJadnhUT3AzdkdLbDJS?=
 =?utf-8?B?enJNRzRuZE9KOTc0YThEcldjaHFUbVZNQXREdklhcnlHTXhUZWR3cmxmWGgz?=
 =?utf-8?B?WFlWcldEcXBEbkg4aXVmbjVjUHJFQmZPZmRSUW1XamUyMlNLcFZRWHIvUHVP?=
 =?utf-8?B?cVc0dmtaM0pzOWN2aEMyTWttdjM0S09lVHArcFRRcW9IZlh0M2VUVHl1bWw3?=
 =?utf-8?B?dW9kSTF4Sk1sdmJIM1E5cHk1RVo1Z0lkRXhod1RYa05BekI2TTdZbnhiTUpZ?=
 =?utf-8?B?YUlWOXVUamlUMzkydDVVdEZsNVpDRUtUTWtCY1hlTjAzRU5Kb3daYVprbkh1?=
 =?utf-8?B?dC8vR0dmVXc4OUUyblJ0Y2xrTmNDY3RNZHRXWnplLzIzME90azB4eVFzOEVF?=
 =?utf-8?B?anUzalBvZXd0aE9zaVBIaWdmY2V6TStjL1NWRTNydHBUWEtJV0xraU1JaUls?=
 =?utf-8?B?MkJrTVh4Q09aTXBMcGtadi9Lc0xZTjd5dUg0Q3MrWVRkanFSdExHZ0ZrK0Vq?=
 =?utf-8?B?V1pnQ2drVEtGekdJbnpLcm9BV0p3bk1ubitxNFhoZlk5RTlobzVLaGZWNVBo?=
 =?utf-8?B?OG5mL0pRbi81b2thcXMxRjVCMHdpa1B2WTh4eTNoUGo5U2lVcTY4YVViREJa?=
 =?utf-8?B?VWFGb0NZVjhveHpPME43VngvZEtFbmxmS0Jkc0lLRDNTOFhLcTNsMWd5MU5w?=
 =?utf-8?B?SHcwaFZZV0RkamZoS0xuSVJPMDBSS2xISmE4cXJHNFJjQ29VZlgvYlltZHdD?=
 =?utf-8?B?clBJWG04NEoydFBMVDh0Qnl5cHJrYkUrVmxJSEloaFcvSVk3U21HazJWYlp1?=
 =?utf-8?B?SWpEaGxZNWxRaTZlQ05wS0QyOFJoNGVCMStCR1FIS1hZU0tHYk1CVFBsemlq?=
 =?utf-8?B?NldISlVOWkhnWmI3dVBZYkhjRG41RWs0WndqZ0duZkdjUGRrcW5jMGlhcG41?=
 =?utf-8?B?ZFBYaVg4TTBpR1lsc2RpNklOSDJJZURjcVBlWThVNmwwelZ2QU9ML3I3NDJq?=
 =?utf-8?B?YWpPOFgvY3ZubklWUkM3T0Y0Y1QwTWRyNkFIbDBaK1lIVWJ6OUNpZGhhMmFE?=
 =?utf-8?B?TW90MUc4QVBMWWpQMGNMWGU2TnFoVCtiWTZ3RXVNRlc1SkM3WDZmS0RhVnZB?=
 =?utf-8?B?RktmMFpEN2NGRTcyN0E5YzRpOG5vNk1mN2xKT2J4dGVua3FVTElDZ2QxdDdY?=
 =?utf-8?B?VVZtZFVhTk1GZGZWSFlZQVo1K0dza0IyaU5Hb1dvVWZIeW9Fb2NpbTIrYzhn?=
 =?utf-8?Q?TL2SSsgsh3IWEi4JiQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184e9de2-6718-48ea-6866-08decff96151
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 00:58:32.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhrF+egcCsB2mea8FAdBg1CvwoFWgJBugB4e2B0lmgz3HQD8vqAGQaVKnTXhk737w2VFIODShNcg901Z8+jJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161



On 19/6/26 22:03, Jason Gunthorpe wrote:
> On Fri, Jun 19, 2026 at 12:05:45PM +1000, Alexey Kardashevskiy wrote:
> 
>>>>>> IMHO that's an AMD issue, not with the design of this series..
>>>>>>
>>>>>> The series is right, a device that is !force_dma_decrypted() must be
>>>>>> considerd to be a trusted device and we must never place any DMA
>>>>>> mappings for a trusted device into shared memory.
>>>>>
>>>>> swiotlb=force forces swiotlb, not decryption.
>>>
>>> If force_dma_decrypted() == true then swiotlb must allocate from a
>>> decrypted memory pool. It is right there in the name!
>>>
>>> The hypervisor environment should *never* set force_dma_decrypted()
>>> because all devices can access all hypervisor memory, up to their IOVA
>>> limits.
>>
>> True. But we do not have encrypted swiotlb pool today, right?
> 
> "encrypted" is just normal struct page memory, that's the default for
> swiotlb.
>
> I think it was a big mistake for the AMD SME stuff to overload the
> decrypted/encrypted CC stuff which should mean shared/private in a
> guest context to also mean things about physical memory encryption in
> the host. It is really confusing.
It is a bit in the PTE which says "encrypted", what do you mean by overloaded?...

> The SME side is just a bad arch choice, the real world doesn't work
> well if you set high address bits in your dma_addr_t. I think AMD
> needs to use those restricted swiotlb pool where it allocates this
> very special "SME Disabled" memory that will have a low
> dma_addr_t.

The generic __init iommu_subsys_init(void) calls iommu_set_default_translated() if CC_ATTR_MEM_ENCRYPT (==force the use of IOMMU) and eliminates the bouncing by default, pretty much. We (AMD) do not really want to force Cbit in DMA handles and it is not happening unless "iommu=pt".

> Then alloc and bouncing will get memory with a suitable
> dma_addr_t. This has nothing to do with force_dma_unencrypted() which
> is only a CC guest concept and nothing else in the OS should ever
> touch decrypted memory.

True.

Although, with "iommu=pt" enabled, dma handles from swiotlb should not have Cbit so these swiotlb pages  have to be unencrypted.

As you mentioned in another mail in the thread, DMAing to unencrypted memory with mem_encrypt=on make no sense security wise. May be enforce either mem_encrypt=on or iommu=pt is allowed at the same time but not both? I am worried though that some weirdo still has a use case for it.


>>> And this is more insane logic. The right fix is to allocate the
>>> swiotlb bounce from the *encrypted* pools when running on the
>>> hypervisor which requires undoing this abuse of force_dma_decrypted().
>>
>> +1.
>>
>> But how does the kernel decide if it is this swiotlb pool or just
>> some page which happens to be below the IOVA limit?
> 
> You mean in swiotlb_tbl_unmap_single() ? It checks the address against
> the pool's range?
> 
>> swiotlb can be for bouncing (with all these dma_sync_single_for_cpu)
>> or, if dev->dma_io_tlb_mem->for_alloc = true, for coherent
>> allocation (no need in dma_sync_single_for_cpu).
>>
>> I am looking for a way to set up my "sev-guest" device such as when
> 
> Whats a "sev-guest" device?

It is a platform device, presented in SNP VMs as /dev/sev-guest and the guest userspace calls ioctls on it when it needs VM attestation report/certificates/etc.

The sev-guest driver makes calls to the HV (GHCB protocol) to:
1) get report/certificates/measurements from the HV <- this is done via shared memory as the HV writes to it;
2) asks the HV to get the digests from the PSP <- this is done via encrypted memory (buuuut it is software encrypted and as far as the hw is concerned - it is shared - no Cbit, no RMP - these buffers contain plaintext headers of the PSP requests and cyphertext of the request/response body).

>> dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from
>> the shared swiotlb pool (with no actual bouncing) and there is no
>> obvious way to trick the DMA layer into doing that.
> 
> Why do you need this?

/dev/sev-guest uses only shared memory (from the HW standpoint), and it is normally lot less than 1MB. If hugepages are used, then today it allocates 4K pages (they come encrypted and likely backed with a 2M page), the driver converts them to shared to make that GHCB call. The conversion smashes backing 2M page to 4K pages (+RMP +IOPDE as there is possible ongoing DMA), which is a problem (I have mentioned it as "TMPM" before - a hw/fw helper to do the smashing).

The idea here is that if swiotlb is already shared, the sev-guest could use that memory pool.

Thanks,


> 
> Jason

-- 
Alexey

