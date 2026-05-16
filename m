Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB4390C9E;
	Sat, 16 May 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936031; cv=fail; b=l39VIXuhtf5GIp7lpGyaz5vZKI6Sp8iej9J03xIn9z/0V45nv4iquR1D90z5ttCqBC6ghcjveLOdD+ZpSHsE7XgkWKWDFh1X8kuvtR/V7hk662IlDK6VFoNYTTDe6gGnm/vL9yYrphopohCdihRMc1GD2ElBy3l7ogFJ8jKsxqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936031; c=relaxed/simple;
	bh=4lQg2D7SuPbTMbIlYx6EiAQNMBMBZkd1zbAaMeqkI6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=or5GX+LMIwl0rBs53Gg7vlMAzDxywuQ9uLtbrODit0O6Aonz5hRtDTc8rBbuxPMlWBMtTJjRsjbh6+GihM+tRRGPYh0KTnDIjbNEbJqQVP0Ajn5reg7raUFGbP6JkUjlDlHtP5vbQtkOOnmxll7haiLeF2G1Y5HrS1rXYo3yZ/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L3DFzTFi; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L3DFzTFi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC4xr60rk8uI8PQbuPqv2v1LdnsWiNul8y98nZjo6Geqqbkks/wFciNxFkQ3aZTjseEUIWEz4bAOFYz1Kw9LcgGLJ893Hn3Ulc+OFdpCygCyov+jUOf2nkc/HHHhQfwT1CrIANJxm2V8A6k8ygeihKv3fMaZmvvRhq7UWJfygqmjVScIIQta7NqxedUG1ROnP8ElBbsiA9NSgbCYQKF4u7dVwrKlMAeofsJv8VYxjW21EREC8rVe0MrV6GDYQNoQgVyUVbxwQInN2Y38KVO9PaNkdM4q7e8EJIEKbKlL/iX/u9q9fpgRDWpYts2RMcVqXvWfS3lRYvgqNJoqE2MX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyxU4OKFp56ngD6qwRCeyFFITUQj9CckMdRCfQl7hDQ=;
 b=NHU9gMU5bqPe5TL8L5Lwe3oPkAKDCaQRxvHaMulvQI0EC/8Bsm2HYu4bLofwPLKM6Zm+1fUBeCtI1EYAUwr9X2W43QSCljmHCzaeTVEH73laqgqE0OBTy3+/jWEnp9i04VTol3TbAhEqELk4GLDkFu+S4I0i1wzyQCd17zyqNidSYO9mPp212mj+8Q/PJva8FIf1SP2iVzz+zaANlaJAhNdGdvvn5vT/iFmXyw97NUkZgcXAvaw9MzEmpttIkXormpwMwwaSiH4IpTOkjBPhNsb3E8WPxpWrHiceY2TrWhusMqVIRmdY9MGYVM3XgOjUqrMbbPaY3q8wuxg07rkclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyxU4OKFp56ngD6qwRCeyFFITUQj9CckMdRCfQl7hDQ=;
 b=L3DFzTFilMrH5FDVyrcSIE6XqRlnMr7ZOS+/pngj5L78Mx1F/Q907ytgznKiSsZ1MkYkTzL+5TCnLtjUlQrbeXfwJfCPGDqL4EVvvaawNZ+XpbpEwiQPv/d93c6MObwc1iZgIdMojJlJSneV7unWB8QVIO1QIUwUWCOaws9CPOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 16 May
 2026 12:53:44 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.21.0025.012; Sat, 16 May 2026
 12:53:44 +0000
Message-ID: <6f01978e-ead9-409b-866d-69231dc44d00@amd.com>
Date: Sat, 16 May 2026 22:53:17 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
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
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260512090408.794195-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:10:246::25) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: f3003a4c-8eca-4143-d291-08deb34a2971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|11063799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R2Uq2EzIkmmS5ShgBvYUROzuSXaFZjdPdb1bBozSK0gbURNxDN6YR9jde+1DTjzr+IjzcvA4md6MBlNKoZTxoksVLo4dKocOHGwp3f7KmWViUDQ72JQg13E93LHh32U+f+fLxqwzrT87OBb9jF8DzyinFmnKbadT/2OkO1xUY1/Sw+BMJhFJ+R46fUIIAO8Or/TJEwQrgIOleyJ//W7vEAKw4R/DBwKPknLeVS5Ndef913aN7ppgJa6O+Vd7E8QmYjFzp5eX7wcfnJVo2Co8OF2euLaemBzKhAXD07IOQmLT5BK1UjN8PAWlf4TCu4KUun5QbmZSMqDvqbDNvoeqKSLKhzzAwoHyvPY5obvTZ+UNr2wwFn0xrhYhDwLdumgWRUk6JO9BfZCo0n44ahd6Bsemzp7UP2QJLrZ9B+QQetUfl3V3HT/zqyd9z3rnHlkXU7gVSI7ZqJUbKrWAlGr0b1fqe1+o0A27eUQOQUucDrUOaspJv6OJq8mjOXF94GMwdWOqvKe79Ex6uC3oAUxMzPiwJX0FvnUc3wWkBH1xAupsBYPbTH5IQLL3S2iBUQY7KKTL9r+HSA3f350g/6yM5JKFKDst3QS4fxGegaAGMC7wo2Bmr9B8cy7eppD/iF9guEheVfMjCGMB0rT40Yh6dDBqiVj0YyW7DD37ZYKlU4U2ftjUiqUl9qI+AXHIN2Xy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3J1eXZzektUZnBxVVJrQXZVck5Kd2ZWc1B1Mlk1VW9WVDhwUnhMMU9nVU1m?=
 =?utf-8?B?dlBDbksvQXY4amVtSzNSL3lDVUI1d2UvRExiV3ZrbzAzOHhMN0ZGYzc3MW1I?=
 =?utf-8?B?amFHVWdDcThRY1dCWlAwY2syenc4MDh4NENobnMwZ3VNQmQxMGM0Y3k3S1N4?=
 =?utf-8?B?dFVyUFRncmRQOHhUT1hxaURudVcxZHVFUjB2VWNHS09CTWpkWnRNcnRSWnNv?=
 =?utf-8?B?dHRRS3h3Uzd3L2VjNU5zQlN2VThFd2t0WCsvM2RpRnM4UllPUmNpb0dBU3dz?=
 =?utf-8?B?Mi94dDl3MllMQ1NEcTEvc2dIa3BpSFlJTlBvUjhMdzdObW1QSWE2T1dGcTlp?=
 =?utf-8?B?bG9qcUl0SnVyM1czWkpGd2UvTno5RStiRi93MFBsR25DQjdGT29yaG52VnRX?=
 =?utf-8?B?cytSdFU5bm9DNHNNOFNMcldESnlXS2VqaU9nb0RyN21SZVhHNzh3em1uL3pX?=
 =?utf-8?B?N2VqQ0pLTyt0LzZTNHgzTzc2Y2ZUMm40dzVlR3pQblpxY0U5bHBtanovRTN2?=
 =?utf-8?B?MDFOMk5RTmFPaENIdWQveUxYcGJ0V0E5WWhuUCtGckh3cjV3TUdzK1pMQ1Rn?=
 =?utf-8?B?U2hXRkk1MldicW5TY2RISzljN0pTUDJsOERWbU9wWm9nY3VlK2lkTHRURzQ0?=
 =?utf-8?B?a2ptSjU5OWFkc2Q5WGZsR09zSHVGeVRLT005aFFTOFgyak0zZmlEMHVzbFEx?=
 =?utf-8?B?ZjVLZENIQ25CTDgwNFNXcTJsbnZPZEtLT2FOT3cwaGlSeFFyR0E1Q050L3lJ?=
 =?utf-8?B?ZVV1Q0czWWhrMyt1OW5tM1JuY3U5S0J5aVJTRHpML1NYaFU3bC9wMEIxV2JD?=
 =?utf-8?B?SzBRSVZqZGhpbXcxVTBsT044NHNYcGdvTzJQMEdxcVQwdmE1VGxkR2UxREtC?=
 =?utf-8?B?U3UrSUpJZTA5VXkzdTNaR1ZDenZYL0pIcS9TVVJDWkl0eEx3c2RFRmNzRFVG?=
 =?utf-8?B?NXRHYjJuUzQyY1FURUVpdG8rUC9WOUlsWVA2eGsrYlFKcFVSQis0YlJrY2NO?=
 =?utf-8?B?aEhHK3ZpK0xUMTVORmdBU2JFNzYwSmk3cDFYaW0yeW1uSUdZWHozVFpzK1py?=
 =?utf-8?B?TjFCa202K21maGJPT212YWUzOWg2RTIyYTk5ZFpPbTR4eUNjVVA0cm5nem80?=
 =?utf-8?B?UXRmVXR5bnRkVDdzRGpITDA0UjhObGsxT2doVUFTeE9vK1ZiU1BORmMrM3kw?=
 =?utf-8?B?STBDekwreG5YdHJ6YzVjMWFVTzJuMTUvdXFUbldwazlIWFdVVTJ4V0RQUlg0?=
 =?utf-8?B?cFlWZ043NFBvbWVuN2RRMU16VEtrenBWdVNjRnViSkZoa2ZrNldMaXlMbWp2?=
 =?utf-8?B?OE9iRlg1UmF2UHpmREJOS2s4OFVkVVVyS0gxMWo5RUxLQ0xFdzNQU2Nnc0Nw?=
 =?utf-8?B?SlBMUGYyeXRwdVVnVnRoa0loWWNwOHVyYXNBV2taNStiOXl1dCs2dEJvcVFu?=
 =?utf-8?B?OGcxNU5FK1FXYUpKZHR2WFRwY0kxb2pUR29sVCt0Qk9aTEFITTFUckNQTmdZ?=
 =?utf-8?B?QW1TZno2YVBtZ2lmZEZxWnBvbzF2b3M4WXM1Z3h6cVlLNWc4Q2d1dFR5RHBF?=
 =?utf-8?B?czNCMFd5K0JnSmp0cUppejJ3WThueGpTZnZNZTdUcXg1d01hRXhQL0lMYmd6?=
 =?utf-8?B?V2F3MUZpdmd0WGxkbUVDYTgvaDAxZFlhdFNjOVRUVVdSZjVZN2dKd1AvdjBl?=
 =?utf-8?B?NVEySkF3SWM2WVR6TzNhd0YrZlZuTVBObm5PdUNyb2tlOSs4cWVnR2RsOVNH?=
 =?utf-8?B?TFZXcExoeXYxcDVxTS9NdHBZRjhFb0dnM0RWWndDdUNjRHBkMmFobDBDWjV1?=
 =?utf-8?B?QzVvbjBqbHFpam9paTBNcm9ZdHFWMno1V1RmQnpyTWJEUUY1aDkrOWJxa09p?=
 =?utf-8?B?S2lac0d6Q3dmY21NSDZ1T3ZObEYvclVJQmJoMXg2bFZkZW1scVZsQS9LcG50?=
 =?utf-8?B?L0IyTURmNkMwbjJCR0lTKzZnZWY2U1B4a21obWR1MENydGZLS3E2S0dwRXM4?=
 =?utf-8?B?Q0VySiswODBEbEVzb2FKRmUzcklpSGl3UHlyb25sRFpja3RJK3VGbkd6NUxX?=
 =?utf-8?B?RUhzZklRMys1dis3YjJ0Wmx2dEVCLzZ6OXlkK296dy93NlkwSDEyQ1haY1dW?=
 =?utf-8?B?YUlna3IvOEF2L2x3MHVKU1U2eEd4WnIwNFVIMFlYNjhpelR6aFBPekU4NFhv?=
 =?utf-8?B?bUZZZXNmbjd3cUJlTng0NndJWGxpNTdaczRTMkNXRFVoYndQVmkzbXFhQmVy?=
 =?utf-8?B?WWZYMGJVeWNsUFVWY09pME41WTdSclorNEpFMlo0VlpCWTNzb1U3amFQUEZJ?=
 =?utf-8?B?YllqTlh6c3Z5TGZ2di9lV1pkc3N4bE95cFQwWERCTHdKd3pOODZzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3003a4c-8eca-4143-d291-08deb34a2971
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 12:53:44.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uxKH7pVZxhFhhX9N6q1kRX4Wjuqywla9+JVoFpTO/8vyKT8sn0+f9p1f2HoflYC2mPeDpteONDOJk0UjBgAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

On 12/5/26 19:03, Aneesh Kumar K.V (Arm) wrote:
> Teach the atomic DMA pool code to distinguish between encrypted and
> decrypted pools, and make pool allocation select the matching pool based
> on DMA attributes.
> 
> Introduce a dma_gen_pool wrapper that records whether a pool is
> decrypted, initialize that state when the atomic pools are created, and
> use it when expanding and resizing the pools.  Update dma_alloc_from_pool()
> to take attrs and skip pools whose encrypted/decrypted state does not
> match DMA_ATTR_CC_SHARED.  Update dma_free_from_pool() accordingly.
> 
> Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path
> so decrypted swiotlb allocations are taken from the correct atomic pool.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   drivers/iommu/dma-iommu.c   |   2 +-
>   include/linux/dma-map-ops.h |   2 +-
>   kernel/dma/direct.c         |  11 ++-
>   kernel/dma/pool.c           | 163 +++++++++++++++++++++++-------------
>   kernel/dma/swiotlb.c        |   7 +-
>   5 files changed, 122 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 54d96e847f16..c2595bee3d41 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1673,7 +1673,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>   	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>   	    !gfpflags_allow_blocking(gfp) && !coherent)
>   		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> -					       gfp, NULL);
> +					   gfp, attrs, NULL);
>   	else
>   		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
>   	if (!cpu_addr)
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 6a1832a73cad..696b2c3a2305 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
>   void dma_common_free_remap(void *cpu_addr, size_t size);
>   
>   struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t flags,
> +		void **cpu_addr, gfp_t flags, unsigned long attrs,
>   		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>   bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>   
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0c2e1f8436ce..dc2907439b3d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -162,7 +162,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>   }
>   
>   static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp)
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
>   	struct page *page;
>   	u64 phys_limit;
> @@ -172,7 +172,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>   		return NULL;
>   
>   	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> +	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
> +				   dma_coherent_ok);
>   	if (!page)
>   		return NULL;
>   	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> @@ -261,7 +262,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	 */
>   	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>   	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  gfp, attrs);
>   
>   	if (is_swiotlb_for_alloc(dev)) {
>   		page = dma_direct_alloc_swiotlb(dev, size);
> @@ -397,7 +399,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   		attrs |= DMA_ATTR_CC_SHARED;
>   
>   	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  gfp, attrs);
>   
>   	if (is_swiotlb_for_alloc(dev)) {
>   		page = dma_direct_alloc_swiotlb(dev, size);
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..75f0eba48a23 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -12,12 +12,18 @@
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
> +#include <linux/cc_platform.h>
>   
> -static struct gen_pool *atomic_pool_dma __ro_after_init;
> +struct dma_gen_pool {
> +	bool unencrypted;
> +	struct gen_pool *pool;
> +};
> +
> +static struct dma_gen_pool atomic_pool_dma __ro_after_init;
>   static unsigned long pool_size_dma;
> -static struct gen_pool *atomic_pool_dma32 __ro_after_init;
> +static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
>   static unsigned long pool_size_dma32;
> -static struct gen_pool *atomic_pool_kernel __ro_after_init;
> +static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
>   static unsigned long pool_size_kernel;
>   
>   /* Size can be defined by the coherent_pool command line */
> @@ -76,7 +82,7 @@ static bool cma_in_zone(gfp_t gfp)
>   	return true;
>   }
>   
> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>   			      gfp_t gfp)
>   {
>   	unsigned int order;
> @@ -113,12 +119,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>   	 * shrink so no re-encryption occurs in dma_direct_free().
>   	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +	if (dma_pool->unencrypted) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>   				   1 << order);
> -	if (ret)
> -		goto remove_mapping;
> -	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> -				pool_size, NUMA_NO_NODE);
> +		if (ret)
> +			goto remove_mapping;
> +	}
> +
> +	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
> +				page_to_phys(page), pool_size, NUMA_NO_NODE);
>   	if (ret)
>   		goto encrypt_mapping;
>   
> @@ -126,11 +135,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	return 0;
>   
>   encrypt_mapping:
> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (WARN_ON_ONCE(ret)) {
> -		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +	if (dma_pool->unencrypted) {
> +		int rc;
> +
> +		rc = set_memory_encrypted((unsigned long)page_to_virt(page),
> +					  1 << order);
> +		if (WARN_ON_ONCE(rc)) {
> +			/* Decrypt succeeded but encrypt failed, purposely leak */
> +			goto out;
> +		}
>   	}
>   remove_mapping:
>   #ifdef CONFIG_DMA_DIRECT_REMAP
> @@ -142,46 +155,52 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	return ret;
>   }
>   
> -static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
> +static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
>   {
> -	if (pool && gen_pool_avail(pool) < atomic_pool_size)
> -		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
> +	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
> +		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
>   }
>   
>   static void atomic_pool_work_fn(struct work_struct *work)
>   {
>   	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		atomic_pool_resize(atomic_pool_dma,
> +		atomic_pool_resize(&atomic_pool_dma,
>   				   GFP_KERNEL | GFP_DMA);
>   	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		atomic_pool_resize(atomic_pool_dma32,
> +		atomic_pool_resize(&atomic_pool_dma32,
>   				   GFP_KERNEL | GFP_DMA32);
> -	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
> +	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
>   }
>   
> -static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
> -						      gfp_t gfp)
> +static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
> +		size_t pool_size, gfp_t gfp)
>   {
> -	struct gen_pool *pool;
>   	int ret;
>   
> -	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> -	if (!pool)
> +	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!dma_pool->pool)
>   		return NULL;
>   
> -	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
> +	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
> +
> +	/* if platform is using memory encryption atomic pools are by default decrypted. */
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +		dma_pool->unencrypted = true;
> +	else
> +		dma_pool->unencrypted = false;
>   
> -	ret = atomic_pool_expand(pool, pool_size, gfp);
> +	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
>   	if (ret) {
> -		gen_pool_destroy(pool);
> +		gen_pool_destroy(dma_pool->pool);
> +		dma_pool->pool = NULL;
>   		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
>   		       pool_size >> 10, &gfp);
>   		return NULL;
>   	}
>   
>   	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
> -		gen_pool_size(pool) >> 10, &gfp);
> -	return pool;
> +		gen_pool_size(dma_pool->pool) >> 10, &gfp);
> +	return dma_pool;
>   }
>   
>   #ifdef CONFIG_ZONE_DMA32
> @@ -207,21 +226,22 @@ static int __init dma_atomic_pool_init(void)
>   
>   	/* All memory might be in the DMA zone(s) to begin with */
>   	if (has_managed_zone(ZONE_NORMAL)) {
> -		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
> -						    GFP_KERNEL);
> -		if (!atomic_pool_kernel)
> +		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
> +		if (!atomic_pool_kernel.pool)
>   			ret = -ENOMEM;
>   	}
> +
>   	if (has_managed_dma()) {
> -		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> -		if (!atomic_pool_dma)
> +		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
> +				       GFP_KERNEL | GFP_DMA);
> +		if (!atomic_pool_dma.pool)
>   			ret = -ENOMEM;
>   	}
> +
>   	if (has_managed_dma32) {
> -		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA32);
> -		if (!atomic_pool_dma32)
> +		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
> +				       GFP_KERNEL | GFP_DMA32);
> +		if (!atomic_pool_dma32.pool)
>   			ret = -ENOMEM;
>   	}
>   
> @@ -230,19 +250,44 @@ static int __init dma_atomic_pool_init(void)
>   }
>   postcore_initcall(dma_atomic_pool_init);
>   
> -static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
> +static inline struct dma_gen_pool *__dma_guess_pool(struct dma_gen_pool *first,
> +		struct dma_gen_pool *second, struct dma_gen_pool *third)
> +{
> +	if (first->pool)
> +		return first;
> +	if (second && second->pool)
> +		return second;
> +	if (third && third->pool)
> +		return third;
> +	return NULL;
> +}
> +
> +static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev,
> +		gfp_t gfp)
>   {
> -	if (prev == NULL) {
> +	if (!prev) {
>   		if (gfp & GFP_DMA)
> -			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
> +			return __dma_guess_pool(&atomic_pool_dma,
> +						&atomic_pool_dma32,
> +						&atomic_pool_kernel);
> +
>   		if (gfp & GFP_DMA32)
> -			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
> -		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
> +			return __dma_guess_pool(&atomic_pool_dma32,
> +						&atomic_pool_dma,
> +						&atomic_pool_kernel);
> +
> +		return __dma_guess_pool(&atomic_pool_kernel,
> +					&atomic_pool_dma32,
> +					&atomic_pool_dma);
>   	}
> -	if (prev == atomic_pool_kernel)
> -		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
> -	if (prev == atomic_pool_dma32)
> -		return atomic_pool_dma;
> +
> +	if (prev == &atomic_pool_kernel)
> +		return __dma_guess_pool(&atomic_pool_dma32,
> +					&atomic_pool_dma, NULL);
> +
> +	if (prev == &atomic_pool_dma32)
> +		return __dma_guess_pool(&atomic_pool_dma, NULL, NULL);
> +
>   	return NULL;
>   }
>   
> @@ -272,16 +317,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
>   }
>   
>   struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t gfp,
> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>   		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>   {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
>   	struct page *page;
>   	bool pool_found = false;
>   
> -	while ((pool = dma_guess_pool(pool, gfp))) {
> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> +
> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> +			continue;
> +
>   		pool_found = true;
> -		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> +		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
>   					     phys_addr_ok);
>   		if (page)
>   			return page;
> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>   
>   bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>   {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
> +
> +	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
>   
> -	while ((pool = dma_guess_pool(pool, 0))) {
> -		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
> +		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))


v3 of this just crashed here with dma_pool!=NULL but dma_pool->pool==NULL. continuing debugging... Thanks,


>   			continue;
> -		gen_pool_free(pool, (unsigned long)start, size);
> +
> +		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
>   		return true;
>   	}
>   
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..ab4eccbaa076 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -612,6 +612,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>   		u64 phys_limit, gfp_t gfp)
>   {
>   	struct page *page;
> +	unsigned long attrs = 0;
>   
>   	/*
>   	 * Allocate from the atomic pools if memory is encrypted and
> @@ -623,8 +624,12 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>   		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>   			return NULL;
>   
> +		/* swiotlb considered decrypted by default */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			attrs = DMA_ATTR_CC_SHARED;
> +
>   		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> -					   dma_coherent_ok);
> +					   attrs, dma_coherent_ok);
>   	}
>   
>   	gfp &= ~GFP_ZONEMASK;

-- 
Alexey

