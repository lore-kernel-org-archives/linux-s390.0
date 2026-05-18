Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1803E1CF6;
	Mon, 18 May 2026 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092380; cv=fail; b=dUn9eh3SzCh7dni6XUlj7WAmuxjT+8xTYpa5yW2CXEUfOleis/eOJ/kWA/Gz+1o2zTbTMwOxC8/4BdMV21pYyXmMSMIdiY25/5iEvAxThf3hCwao/CDTtdoRrbXCz6A/fyI80ISYU+OHFsEn+MbusD1hW4dxbvesx6s6m/VFmtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092380; c=relaxed/simple;
	bh=VaOjxLKabT8/+rNqsAmW32TzUMbq+xo+xgvxH82Ho3g=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eNZUY9ELQ/Ua9GfBsmw5R7+x4tDeclUj2evOemNQR4kn5JucmN8USXjuqeM20B8H8lG0GeizL6umV3E6cPl8JJ9Td7esy/HIwcbm/A27WIIoMchkMbHA0b5fTbTg8Qbue9UA8CQU/MB8TlUHCbddvgSRpUbJYqFjag3If4FMxF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2udR0MB; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f2udR0MB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUMsuptlyYKVoVQ0kFBSJEHTCGYpxkguUUIfHJKFYg3PfsvamZn9cxlVhPCRbS0ldBDkelDfxHW/EfVIonHrcZpyZ03r+qE/88XtUWWfkpVNTox7arKunHrjYp25OnFPjxpGk1zeiNZVlBIWPiLdXVx7u4XwXsCwreFbt89+4pO5Hh0BV0V/oYsM29Ed0HD7M5cZ1/k6JmPawjtFZDWwoqdRMOkefSL2WW/9fCsaXgkZ3PYooXsVYOE7cDpIj4p121TfDcJ2WDq5MUuE6CKsiSOUOZSDb8SZApeE7fKZAO5DchPsCBlZ3m3JyYooEqLiG7B/lxzDHF8FJQGEsr5tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOO9+7kaHEhQ4ycpJFEyDcA43xnlJdHdSHPTvkdJ7fg=;
 b=Zg0RZTTAHzVcbMVgRVBef6NFdoyTwzopOPuNirjFvwqP6iIP077v2RxZMbcvBI36pHv/OyDnZzzAgU6LMbm0L4fmUWK+bkHamhN69RrT6ckLTDocbNDh6/Tq2wgqzP+Qi7xBKcMPUUE1X4AX9DYXPWQczWwCJOULLnATxbmJq0zQbFplghK+yiTI5BlcPpZKEqOr++uGe/Fjg31IDh+X9MjCULqo10kWqEmwEoXdxGTO6Jl6ivxNHBYB70H7aPMmaj1KTikwvZsCxyAp2d2Uau4i81c0q5tvqTGiWjaUQM3gBlmZBU7x95SEx1Zpw48qkDBlwJmjw2yYefObULjA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOO9+7kaHEhQ4ycpJFEyDcA43xnlJdHdSHPTvkdJ7fg=;
 b=f2udR0MBUryMQ4ZizhYXLFJ+HoTNFr4EB2fa7pM+zVq5CBFfLICCGEdBadpQCwQ6H3+CKlEu1v9AIcAsBFn9DvpUAupLqM2nD/z7I55aWKS5T2jLaWS5JfuCLQEweZLPBV7pPFf6ND96rAhPtp0rRdL/rSPSSH7jJBmtEldelYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:19:34 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:19:33 +0000
Message-ID: <df4b78cf-6192-4fe3-8ad5-df9e6fdda8e6@amd.com>
Date: Mon, 18 May 2026 18:19:27 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
From: Alexey Kardashevskiy <aik@amd.com>
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
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org>
 <6f01978e-ead9-409b-866d-69231dc44d00@amd.com>
Content-Language: en-US
In-Reply-To: <6f01978e-ead9-409b-866d-69231dc44d00@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0180.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:249::29) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM4PR12MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 033350a6-593e-4d77-f68c-08deb4b6314f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	WAOnr4OrQU7G4D9Lr9oOiNAwnJLwErIFi6iu3UWFbkx5XfVgj2oe1JyQ9CTjcvq3ePmpzPHfkzqP85bOKQp8lI5AWG+Ll1I327nQw5AOCv+MQMDTiJKSs6P1/cR6iuobnE+r4iVQ4B6OoGr5NyNerY9FFvj16Dv4zK3Ayru9e71WI88Ka+Lv/Egr8r/OPjuFbAT8A6GTuQf6AEbiY+6XMHssPwkcvpRA4JyV6i516UsJ+2PdPuS35Bs8n9n23wq7EQhWsjdHOeuyUCnI/thTx81iccxWpQVsXub46XXLfY1lHG9jvdL9YsgwNTWHf6R2d9qVHwrKM4dAsqwj/EntVXjnV1G45ML50ioEDj3VXtI9+BHLmm8nD0xJypt2ZR/M5CCjKRzr2xhfK9mY/bBDK8As4yzIFbKHNqlwrf5O0d1+FOCeG2FeIFHvj7eDE3XO5iuBJ05ZI5/l5FVcYjmtvWWcFsAKVc6Qsk+9nGVlTcIb7VDYefjSyQLGWOjhu4wx7R579EPWHX+dgo5qSl42cYld0ygNQchZ8JIS4dxgfVyyeUU1/9uchKu4eYgCE1oD1jiOXPC+u6ZVgbzOkBvPtmM8i8W3jB4YCTQkqhG8ZTlG6AF7kem00iS9kBITbQ9cz8iYTSWhhirj1HRp3AaujUeMNduR+tA2OJhfkXQPrl0i/YA0JXM5+Rkt2MwUoQSf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVQUlhOcFNtRVo2am01d0p5SWdtMkcxcTc2NVByTmlEMVRFSGFrMDVRUTFE?=
 =?utf-8?B?SmdrenhabjdObFZ1MGp2YnNYUldMWFBMN1FhMDc5YUQxeUdWeFRCM0dkRklX?=
 =?utf-8?B?aUFsd244S3B4Q0FXZ1daWFQwZDhSR0orTWg5SC9TYU1lcElTOEJhMEtEOFph?=
 =?utf-8?B?V0NyWWQyM0Z5Y3JKa0huNm1JVlNibnY0Q210ZzFRazVzOUpuS0k2cmIxTUxN?=
 =?utf-8?B?aVhSWk0ycW5SZlBUSndmeTlQc2lkdlArcm13NjdTUkxJT2RBdkp0OEM3bU1x?=
 =?utf-8?B?c2ttN0dBMk5BS0U2SUJGM3RGZmVwYlZia01abjMvdmRMbjhvcTJBazNDMU4w?=
 =?utf-8?B?cENzelRlSjVqTjAvVnRiODdtQ2Z5N1loQmhQRWxDUERlTlNNeU82TGZCRWwz?=
 =?utf-8?B?dnhac3V5Mlp1MEk4SGRiMDMvWHhQTEtlTnY5WTFFQ290QXgvMWVjUUpXbkxy?=
 =?utf-8?B?em44WWk5Qm5iY2dFTEtwY0xkc2xVTEhYQjFDejJ4N2U3VU9zeTdaUXIzQVAr?=
 =?utf-8?B?bTJlYnQrdnF5RG9ZampSWW5JRi9vU2pBNmxwdVp2UXg1SHZvYXN6YzhjZUNZ?=
 =?utf-8?B?WFVEZURqNUZ0aFpQNVE5WlpqMkdzMS9aZngyd1E1S3paK2dwS3JkdkthRGh6?=
 =?utf-8?B?YkdXejR4S3g4V2JlN0szMnVjSXp2eDNQRzZHb1N4Z2pSQ0ZwWXYrQTJBSlB2?=
 =?utf-8?B?TzlrWVU5OWxkQWpGalNYS1JkbjRCbDU4SGMvRVlaV25UMnpodE5hdnJ4UkNx?=
 =?utf-8?B?UUhrWHRwZk5LVnQxelRta3lvckVGUjlBUUk2c0VxNHZkTG9UNFYwcE9KSUxX?=
 =?utf-8?B?N0x3c1R1U2JRbEVleCtmaDFpdDZqTlZzaStucjJtbXFiOUxWUWV3YzZib2h4?=
 =?utf-8?B?bTBEN0wrZlcrL0M2ekdFS2pWcGl5ckIyYWZwVXNkZk5KVmRTa2Z5WmJtcGNi?=
 =?utf-8?B?UHY1ZXpRS3JOVnFYS2Y5Um1UR0dUbTEvbkM3RWM0bHB2OGhnL2tneVZHN2c0?=
 =?utf-8?B?bWpDdUpLNjJjOU1OcVo1c084bC9SQzNLNUlQN0dTaVdmdzRnV2s5ZG02MHZS?=
 =?utf-8?B?RTA2YTh2QkZQdFlycUZUUkw4RTc5TGMwV0d4VHVxVWZqMU0zTnIxQjhMb3hZ?=
 =?utf-8?B?YmsrOG0rMDVOODg5TGhGL2VNZUVvbzE3MkhMYWdqTk1lL0RvTUpYenJyYnlB?=
 =?utf-8?B?UjM1UmxINHlVSE15VDhRZzNZSldqbUp3U045MTlkMWFtSGJLRG5zSGpMSXRk?=
 =?utf-8?B?WkxvbFdpa28vaHlna0pHMUExc3I2YjlscnUvUlZ4cWdHcytwZVdQRkxodGJ3?=
 =?utf-8?B?Z3pWN045T2hQemw4NGFteUQ2eE10UkZOMlJsWEVIVFhvWjNEOENDSDV4K2tU?=
 =?utf-8?B?V0dLQVdhQjRIMTEyNVAvU2wyeVNLMW4vdGRQVFJMVk5Hb3VOZW5ZakcxZWx2?=
 =?utf-8?B?N2I0Zk5FemhQMnhpY2R2VktuVE1MUDU4akFVOHY3UUgySTBBcmhONG53TS9W?=
 =?utf-8?B?SmNoTlByNlBUQlRJVUMwQ2krV2FwM1BIbi9YQjIydmVQT1phN2N2TzhYd3hL?=
 =?utf-8?B?UzNzdkxCUFY2ckF6T2thb0l4ZTUzU1J1S0JzMTEra0IzL2hzdk5rQStUdjFL?=
 =?utf-8?B?TjdhZk5YTlc3Q3p5RzJDSVBNMDlERGdvWDE0dTlEa3dvSUpSOTVUOTBCbjJm?=
 =?utf-8?B?OE5vdkREL0NFdFJLd2l6WEdEVTA5Z2daM0hKR3E1SnlPWnQvZFNrU2RQOHVL?=
 =?utf-8?B?aFdrbVl5YTAxQXIxNTVYeUNiSDZwSWZTd0ZPVDNaWFlBSGp6RW1vcWxmQUFL?=
 =?utf-8?B?cDA3UjVGSWozdzZQZlhlWGZmbFFZVE0xWGdGUk9ucGZFWVpLcVBrQ3RlV2Rq?=
 =?utf-8?B?K082ajRyRUtpUmRqYWVBUzB0T0VFNUtSMGc4aDI4ekJGcU52VHRkQVhLa1hw?=
 =?utf-8?B?ckU1ZE55NFFaYy9CN0h6ak1QM3FLcHozUzhUMkVSbWErRXlhdjVoWkRJbWZT?=
 =?utf-8?B?QlU2eDdXSlg4T3BBcHJORFdDMlN3T0ZuQlhSdDJacy9ibk5rakpJWWxVUi9y?=
 =?utf-8?B?QkZNeWxoTFhyWlZkYmhxcTJENDZ6Y1hvclJqM01xOC9wQk43b0tGcmJmMktW?=
 =?utf-8?B?RkhUNkl5Nmw3dE53UW90ZWk4ODlOOFAybDhwaC9WZ21mUHFoWmV6bFdQcnpK?=
 =?utf-8?B?WGlualhsWmMraVIxNmhiR2JNUlN0WTRxTFdYRGZkUkh0NlpZS1R3UHVuZEdk?=
 =?utf-8?B?Sk9Ua0RJTlhBbXNMUEZwZlBPS21kRHVpN0Z6dkY2aXNmMjNQelNVQ1B1dmpr?=
 =?utf-8?Q?5Bn6mlNG1e+4vU5FsS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033350a6-593e-4d77-f68c-08deb4b6314f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:19:33.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6VyH7TBjVRevSAHoMLWMlWDcU9x3wvkWCJfcB0q2XY1B9+IY+XusFk0SdUzQ16O4ToqHZgB9LMYZm2nJZtodA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647



On 16/5/26 22:53, Alexey Kardashevskiy wrote:
> On 12/5/26 19:03, Aneesh Kumar K.V (Arm) wrote:
>> Teach the atomic DMA pool code to distinguish between encrypted and
>> decrypted pools, and make pool allocation select the matching pool based
>> on DMA attributes.
>>
>> Introduce a dma_gen_pool wrapper that records whether a pool is
>> decrypted, initialize that state when the atomic pools are created, and
>> use it when expanding and resizing the pools.  Update dma_alloc_from_pool()
>> to take attrs and skip pools whose encrypted/decrypted state does not
>> match DMA_ATTR_CC_SHARED.  Update dma_free_from_pool() accordingly.
>>
>> Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path
>> so decrypted swiotlb allocations are taken from the correct atomic pool.
>>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   drivers/iommu/dma-iommu.c   |   2 +-
>>   include/linux/dma-map-ops.h |   2 +-
>>   kernel/dma/direct.c         |  11 ++-
>>   kernel/dma/pool.c           | 163 +++++++++++++++++++++++-------------
>>   kernel/dma/swiotlb.c        |   7 +-
>>   5 files changed, 122 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 54d96e847f16..c2595bee3d41 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -1673,7 +1673,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>>       if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>>           !gfpflags_allow_blocking(gfp) && !coherent)
>>           page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
>> -                           gfp, NULL);
>> +                       gfp, attrs, NULL);
>>       else
>>           cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
>>       if (!cpu_addr)
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 6a1832a73cad..696b2c3a2305 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
>>   void dma_common_free_remap(void *cpu_addr, size_t size);
>>   struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> -        void **cpu_addr, gfp_t flags,
>> +        void **cpu_addr, gfp_t flags, unsigned long attrs,
>>           bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>>   bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 0c2e1f8436ce..dc2907439b3d 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -162,7 +162,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>>   }
>>   static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>> -        dma_addr_t *dma_handle, gfp_t gfp)
>> +        dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>>   {
>>       struct page *page;
>>       u64 phys_limit;
>> @@ -172,7 +172,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>>           return NULL;
>>       gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>> -    page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
>> +    page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
>> +                   dma_coherent_ok);
>>       if (!page)
>>           return NULL;
>>       *dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>> @@ -261,7 +262,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>        */
>>       if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>>           dma_direct_use_pool(dev, gfp))
>> -        return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>> +        return dma_direct_alloc_from_pool(dev, size, dma_handle,
>> +                          gfp, attrs);
>>       if (is_swiotlb_for_alloc(dev)) {
>>           page = dma_direct_alloc_swiotlb(dev, size);
>> @@ -397,7 +399,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>>           attrs |= DMA_ATTR_CC_SHARED;
>>       if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>> -        return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>> +        return dma_direct_alloc_from_pool(dev, size, dma_handle,
>> +                          gfp, attrs);
>>       if (is_swiotlb_for_alloc(dev)) {
>>           page = dma_direct_alloc_swiotlb(dev, size);
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 2b2fbb709242..75f0eba48a23 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -12,12 +12,18 @@
>>   #include <linux/set_memory.h>
>>   #include <linux/slab.h>
>>   #include <linux/workqueue.h>
>> +#include <linux/cc_platform.h>
>> -static struct gen_pool *atomic_pool_dma __ro_after_init;
>> +struct dma_gen_pool {
>> +    bool unencrypted;
>> +    struct gen_pool *pool;
>> +};
>> +
>> +static struct dma_gen_pool atomic_pool_dma __ro_after_init;
>>   static unsigned long pool_size_dma;
>> -static struct gen_pool *atomic_pool_dma32 __ro_after_init;
>> +static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
>>   static unsigned long pool_size_dma32;
>> -static struct gen_pool *atomic_pool_kernel __ro_after_init;
>> +static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
>>   static unsigned long pool_size_kernel;
>>   /* Size can be defined by the coherent_pool command line */
>> @@ -76,7 +82,7 @@ static bool cma_in_zone(gfp_t gfp)
>>       return true;
>>   }
>> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>>                     gfp_t gfp)
>>   {
>>       unsigned int order;
>> @@ -113,12 +119,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>        * Memory in the atomic DMA pools must be unencrypted, the pools do not
>>        * shrink so no re-encryption occurs in dma_direct_free().
>>        */
>> -    ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> +    if (dma_pool->unencrypted) {
>> +        ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>>                      1 << order);
>> -    if (ret)
>> -        goto remove_mapping;
>> -    ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
>> -                pool_size, NUMA_NO_NODE);
>> +        if (ret)
>> +            goto remove_mapping;
>> +    }
>> +
>> +    ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
>> +                page_to_phys(page), pool_size, NUMA_NO_NODE);


This clause could go to the else branch.


>>       if (ret)
>>           goto encrypt_mapping;
>> @@ -126,11 +135,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>       return 0;
>>   encrypt_mapping:
>> -    ret = set_memory_encrypted((unsigned long)page_to_virt(page),
>> -                   1 << order);
>> -    if (WARN_ON_ONCE(ret)) {
>> -        /* Decrypt succeeded but encrypt failed, purposely leak */
>> -        goto out;
>> +    if (dma_pool->unencrypted) {
>> +        int rc;
>> +
>> +        rc = set_memory_encrypted((unsigned long)page_to_virt(page),
>> +                      1 << order);
>> +        if (WARN_ON_ONCE(rc)) {
>> +            /* Decrypt succeeded but encrypt failed, purposely leak */
>> +            goto out;
>> +        }
>>       }
>>   remove_mapping:
>>   #ifdef CONFIG_DMA_DIRECT_REMAP
>> @@ -142,46 +155,52 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>       return ret;
>>   }
>> -static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
>> +static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
>>   {
>> -    if (pool && gen_pool_avail(pool) < atomic_pool_size)
>> -        atomic_pool_expand(pool, gen_pool_size(pool), gfp);
>> +    if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
>> +        atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
>>   }
>>   static void atomic_pool_work_fn(struct work_struct *work)
>>   {
>>       if (IS_ENABLED(CONFIG_ZONE_DMA))
>> -        atomic_pool_resize(atomic_pool_dma,
>> +        atomic_pool_resize(&atomic_pool_dma,
>>                      GFP_KERNEL | GFP_DMA);
>>       if (IS_ENABLED(CONFIG_ZONE_DMA32))
>> -        atomic_pool_resize(atomic_pool_dma32,
>> +        atomic_pool_resize(&atomic_pool_dma32,
>>                      GFP_KERNEL | GFP_DMA32);
>> -    atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
>> +    atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
>>   }
>> -static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
>> -                              gfp_t gfp)
>> +static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
>> +        size_t pool_size, gfp_t gfp)
>>   {
>> -    struct gen_pool *pool;
>>       int ret;
>> -    pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
>> -    if (!pool)
>> +    dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
>> +    if (!dma_pool->pool)
>>           return NULL;
>> -    gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
>> +    gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
>> +
>> +    /* if platform is using memory encryption atomic pools are by default decrypted. */
>> +    if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +        dma_pool->unencrypted = true;
>> +    else
>> +        dma_pool->unencrypted = false;
>> -    ret = atomic_pool_expand(pool, pool_size, gfp);
>> +    ret = atomic_pool_expand(dma_pool, pool_size, gfp);
>>       if (ret) {
>> -        gen_pool_destroy(pool);
>> +        gen_pool_destroy(dma_pool->pool);
>> +        dma_pool->pool = NULL;
>>           pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
>>                  pool_size >> 10, &gfp);
>>           return NULL;
>>       }
>>       pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
>> -        gen_pool_size(pool) >> 10, &gfp);
>> -    return pool;
>> +        gen_pool_size(dma_pool->pool) >> 10, &gfp);
>> +    return dma_pool;
>>   }
>>   #ifdef CONFIG_ZONE_DMA32
>> @@ -207,21 +226,22 @@ static int __init dma_atomic_pool_init(void)
>>       /* All memory might be in the DMA zone(s) to begin with */
>>       if (has_managed_zone(ZONE_NORMAL)) {
>> -        atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
>> -                            GFP_KERNEL);
>> -        if (!atomic_pool_kernel)
>> +        __dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
>> +        if (!atomic_pool_kernel.pool)
>>               ret = -ENOMEM;
>>       }
>> +
>>       if (has_managed_dma()) {
>> -        atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
>> -                        GFP_KERNEL | GFP_DMA);
>> -        if (!atomic_pool_dma)
>> +        __dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
>> +                       GFP_KERNEL | GFP_DMA);
>> +        if (!atomic_pool_dma.pool)
>>               ret = -ENOMEM;
>>       }
>> +
>>       if (has_managed_dma32) {
>> -        atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
>> -                        GFP_KERNEL | GFP_DMA32);
>> -        if (!atomic_pool_dma32)
>> +        __dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
>> +                       GFP_KERNEL | GFP_DMA32);
>> +        if (!atomic_pool_dma32.pool)
>>               ret = -ENOMEM;
>>       }
>> @@ -230,19 +250,44 @@ static int __init dma_atomic_pool_init(void)
>>   }
>>   postcore_initcall(dma_atomic_pool_init);
>> -static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
>> +static inline struct dma_gen_pool *__dma_guess_pool(struct dma_gen_pool *first,
>> +        struct dma_gen_pool *second, struct dma_gen_pool *third)
>> +{
>> +    if (first->pool)
>> +        return first;
>> +    if (second && second->pool)
>> +        return second;
>> +    if (third && third->pool)
>> +        return third;
>> +    return NULL;
>> +}
>> +
>> +static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev,
>> +        gfp_t gfp)
>>   {
>> -    if (prev == NULL) {
>> +    if (!prev) {
>>           if (gfp & GFP_DMA)
>> -            return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
>> +            return __dma_guess_pool(&atomic_pool_dma,
>> +                        &atomic_pool_dma32,
>> +                        &atomic_pool_kernel);
>> +
>>           if (gfp & GFP_DMA32)
>> -            return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
>> -        return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
>> +            return __dma_guess_pool(&atomic_pool_dma32,
>> +                        &atomic_pool_dma,
>> +                        &atomic_pool_kernel);
>> +
>> +        return __dma_guess_pool(&atomic_pool_kernel,
>> +                    &atomic_pool_dma32,
>> +                    &atomic_pool_dma);
>>       }
>> -    if (prev == atomic_pool_kernel)
>> -        return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
>> -    if (prev == atomic_pool_dma32)
>> -        return atomic_pool_dma;
>> +
>> +    if (prev == &atomic_pool_kernel)
>> +        return __dma_guess_pool(&atomic_pool_dma32,
>> +                    &atomic_pool_dma, NULL);
>> +
>> +    if (prev == &atomic_pool_dma32)
>> +        return __dma_guess_pool(&atomic_pool_dma, NULL, NULL);
>> +
>>       return NULL;
>>   }
>> @@ -272,16 +317,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
>>   }
>>   struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> -        void **cpu_addr, gfp_t gfp,
>> +        void **cpu_addr, gfp_t gfp, unsigned long attrs,
>>           bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>>   {
>> -    struct gen_pool *pool = NULL;
>> +    struct dma_gen_pool *dma_pool = NULL;
>>       struct page *page;
>>       bool pool_found = false;
>> -    while ((pool = dma_guess_pool(pool, gfp))) {
>> +    while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
>> +
>> +        if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
>> +            continue;
>> +
>>           pool_found = true;
>> -        page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
>> +        page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
>>                            phys_addr_ok);
>>           if (page)
>>               return page;
>> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>>   bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>>   {
>> -    struct gen_pool *pool = NULL;
>> +    struct dma_gen_pool *dma_pool = NULL;
>> +
>> +    while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
>> -    while ((pool = dma_guess_pool(pool, 0))) {
>> -        if (!gen_pool_has_addr(pool, (unsigned long)start, size))
>> +        if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
> 
> 
> v3 of this just crashed here with dma_pool!=NULL but dma_pool->pool==NULL. continuing debugging... Thanks,


dma_direct_free:
   dma_free_from_pool (loop over pools) -> false
     [here was a crash which I fixed by "if (!dma_pool->pool) continue"]
   swiotlb_find_pool (loop again) -> false
     __dma_direct_free_pages
       swiotlb_free
         swiotlb_find_pool (loop again)
       dma_free_contiguous => done.

so that works but kinda hard to follow and there is some room for optimization. I do not normally have swiottlb when I test this and there is too many of this swiotlb stuff on the real direct dma mapping path imho. Thanks,
> 
> 
>>               continue;
>> -        gen_pool_free(pool, (unsigned long)start, size);
>> +
>> +        gen_pool_free(dma_pool->pool, (unsigned long)start, size);
>>           return true;
>>       }
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 1abd3e6146f4..ab4eccbaa076 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -612,6 +612,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>>           u64 phys_limit, gfp_t gfp)
>>   {
>>       struct page *page;
>> +    unsigned long attrs = 0;
>>       /*
>>        * Allocate from the atomic pools if memory is encrypted and
>> @@ -623,8 +624,12 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>>           if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>>               return NULL;
>> +        /* swiotlb considered decrypted by default */
>> +        if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> +            attrs = DMA_ATTR_CC_SHARED;
>> +
>>           return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
>> -                       dma_coherent_ok);
>> +                       attrs, dma_coherent_ok);
>>       }
>>       gfp &= ~GFP_ZONEMASK;
> 

-- 
Alexey

