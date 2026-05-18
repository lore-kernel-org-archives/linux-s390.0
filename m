Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF037D104;
	Mon, 18 May 2026 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092371; cv=fail; b=SvYZGh9evlOYcXm9GjKuFQmzqrth5parfvuX/xGzkVMORDWSbfNnKnQrITI1gTRsjKMLldBLNwB1DBzPicdvsmv2eh0pkquzjkREpJXzuhzFHjTqqvuatjYpEifZw319HzefPaSL6qgLAzeoaxfrPpo/55sCHuUV7f3rDsx8Pz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092371; c=relaxed/simple;
	bh=RGvO1LVsum9VGsdvByQnRLAjhONcwAIdkCAFRuPhLiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYEXVdF2puy0MaaBa2rF6jdooJPTTNLkLLyrQc10o+bfj7CcnHAcf/ZEng9elgTAJfhKK4qvAD83jLSAT25WgNU46W4jVPRI1MmXThkyHLdRQG1HGEHtfU7DBceDM+UTI+NdIV3f1MMBTUp2ZdhIBEbT9uQrv/Jflm1CndUBGtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eSby0OBH; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eSby0OBH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLgG8a7anz5ypulAKsniqE+61Y2YWUWPhF0q7WEEhqmyJ5RkxdqLhY86gdxLfvh8y9pYkq3N7KlrCghPEZvmdvJX2I09Dqf3cHupOrbN5cBpso49x+1lUz0HWLZ7SGGZPS/YsYAfzQPuFw1eU6E1i2vwV2jW1/NaniZTEaiB2MgqE0g1KtpoElPhlrvcOs0awcgLtklx05Tuxp3aCi4QUmsUyLQoHOXIMeHdj1tf2Vod1jUx0JAIb/0GUNKYmQQ2C+35Cpdcfp7QODuffJ+kjCmCh+sUBXjDwSMCIJkjb5frvu8vgUzcaOq+POC/dEmpscq05ItNUA9DhF9e086iUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/eXIHQ97qvLycx7yujVJPHWnmDIXlS/vd9sn2OT4DE=;
 b=JQrakeGotb7gc3o31lPWH9wpo7Ds2ERzFhe3DJKJGR0LGwwtL5PnF3B8iZEgUK+DaAWTaxn9ZK+30uH7jyl8qnSF6F65WjdzFjbeylNmjSAjHE8r9di87Cf1mUHl7syLmFDiNRTNbBvWB1OwVrnIw9LGOwuQgrTi9u10LhlV3uSJn4zs1lKnJP9MpLtTdke20uUs8S+7p35qON7+zHB13pLdNGX2A/53ZW8Hd97P4m0I5k8ucW7pb97q8/VUpfQKuwOiNl7RvPeqYhqTgBzmixFiaNO/Kr8ZtzqUnTnwVFkGFMQYFs602IyJblgxgsX8ZtC28xsy+sNlIbmAMTBBwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/eXIHQ97qvLycx7yujVJPHWnmDIXlS/vd9sn2OT4DE=;
 b=eSby0OBHJdmkaMLdY3g3QxtDMaSkd8VMZo1ueg6dpvBmf725ADYfHOIJ9quf4V9Ie72oDVLmo/QzavMI9dN2gz3NnF+eygSfiPODMYmQ2Di4lwE8FwfCjihtp4B0/GL6ywEks411Z8ANQplxAh8pgcl+GzlDV8JLT7V4Fv6Z3N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM4PR12MB7647.namprd12.prod.outlook.com (2603:10b6:8:105::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:19:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:19:21 +0000
Message-ID: <d185a616-14dc-4697-865a-2729d00f57e3@amd.com>
Date: Mon, 18 May 2026 18:19:00 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
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
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260512090408.794195-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-MS-Office365-Filtering-Correlation-Id: ee6ad031-f696-408c-3749-08deb4b629ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LdC9a9AdRvNWza1jm6bJOBgNeo6Vg+OcWiun/TF1tZZqjs6DWJl+F1eotSvD10mdGGkQZpWRaQRaDwJSu6w62WG9Pk8TI+5RSxkBZIKgvBeMRfy/jHirq6Jv254Nk+L3H0PBJyDBegaRVN4QpCBHaxregtdYE/KdXPOPjMMzWvsJIbvEfCCAGQ+KN8MMClNhKD4CgwnpVVmZNtgzSYtYTz97YcZnPnAcCSRdFO1jLijxxymg2FmgLcGp0QRm1FqPJ5BQcTK2u7A4+PI+szS1GosBk2a8C8Kfg8C/g+AyfPXnBXVavWNET+iQLuEugWsdbAUOMSkzNqFfmqdqZdeE6C0WhPBKiPMlFTz8Sz5EiSpuQGP10fRDDzSHoCG0MhJWSJRykmfQQ7lCvpcIHhsdXl+sz/BcItf8Qm7BIcouecJgj6m3jIsXA++06qPrY5H3yFXhb5j7hLk5kRmXBNY0dGgiwWrPxAXcjpnHP62gh4y5pMlVz9B9u64jG/kZhJgzzBIklhUqG4J5G4d6x2FmEOEKkAhpXD578w0Tn8dU6Ym51B4ESZGx+LSsFz8QtiMsqumGHiJL2h7DDogYOxup1dCwDjlGoucad1UDe59kgEsIxviTKmV4kntYMg2hot/Q4sNQboKURGLACMJXN0ZKFd3cLsv3yy7OWf4ELZs4IUm0nv/t0dLaVJWtm2dBzFj8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VadTd0M1FHWC90VXo5YURQdXc3TExMcnZqRXE2Si81M0lNQ0RaODVHcjA4?=
 =?utf-8?B?VkppL3hTQk91VkxyVlNKUDJRWmRYUXVId0RuVDg5ell4VndGQllSSkRaZTRp?=
 =?utf-8?B?TjRQbDlXS0syYjQ3NXBzbUlqVVM1dGpxQkc2a0wyanhVVkVrKzA4SXVPcm9x?=
 =?utf-8?B?eld0cmtFRVJCc3E4QnJVRlVtNUlDSjNQc1ZjOGFpSnBPZCtZV0NJRHd4eDNX?=
 =?utf-8?B?bXRlN3VtNFhjS3N1dVZUM0kxY0ZsQjFqOEJMWEhMWnpWejF0Q3hYZnJONjcr?=
 =?utf-8?B?S0t3dzZjaDdxK0UrUC9oMmMyMU5WRFErRDl4bGo2VVZNMkdXbGg5UkZCbjJU?=
 =?utf-8?B?NTRNTkltS2dhQk9UMlVFQ0dZeThjZEk0S29RL3gyQWZWanh2N2RONEprTmxG?=
 =?utf-8?B?c0JiN2VnMEpCMzE0WTh3bjY5SFpBdk00K2RVUW0wbmZxdzhqTVVQWVNsTnVQ?=
 =?utf-8?B?R2NOaGVLY0JlN3NtUUE4aWpRSjF4bFpYdWVxWERpaUE3VTA0VEd0NE1yTXM4?=
 =?utf-8?B?UHhNOEZUbnd3YW1xYTdQN2VKcFRKVy96b0h3blY5OVRFcmQ0b25nNUtsNlBG?=
 =?utf-8?B?cGgzQjgrWFB4a09KbGdWV2gvWEc2UXZRaXJJVzIyL29hVS9ib1llYzdmSWNR?=
 =?utf-8?B?a2xWblhKNVdsMDZxbjU0THJDUFByNm56d2Nlc0tIVmFPQzRZYlJHOEczbnRz?=
 =?utf-8?B?bXJrcFFuT0tmSXhuOVZDK0VFck0xTXFoalFLWmNHOFQ2VXNYVzBHZndBUWtQ?=
 =?utf-8?B?ZVM5NFg5MUhlbGdVaExyVUxmSit6TEp5a2hyckhuQXNqdHI3dWkvWnk2c3RP?=
 =?utf-8?B?UEEwVEo2d3o4ZlprTW13WjN0TFAyZjkybHY1T1crSWorRzZRNlZBOHltaWtX?=
 =?utf-8?B?M0tTY1FDaTFzZEtlaG5qcTJtRDlsdUlpMlBJRHozWDgwMjg2RG0vVm91Zmtp?=
 =?utf-8?B?ZmxnZDZWNGRqeXNSYVVMNHFwYzNRQ1Zlc1J2S1dya3lPS0VYZnFqVDV3NUhh?=
 =?utf-8?B?ZmhJTWQwQmM5anlZMDlaWkl3L243VXpxbi9MWFk1VWkxVXNYdXgrQ2d5QXRi?=
 =?utf-8?B?azIyZjdVSDV4SlR1cGZyWW8xd3hoSzlLejFiY0E0S3RpRmk2RjFEVGRHYUJ3?=
 =?utf-8?B?MlB6N2tkeXBiaGd2VmR5RjhMcXVFcUhqMFFJODJQMm1YRHRrZk96Nnkwa3JQ?=
 =?utf-8?B?bkFDbjlaNHNyZHpaaGIvV2JubW84UWREYlF0bE1XYTM2NW9jSXJ0bTB4M1FU?=
 =?utf-8?B?aGhwbzlRVmZhT2NBUFpLOWVyR0NrNERBMUZEQWZZSTlObEF1Q0RrS1E2OGY1?=
 =?utf-8?B?TXVMbmt4b0MrWXV2NzZmMlVjTnJBcnprWkg3MkkreHJkWGtHVVhJMUxjU3dN?=
 =?utf-8?B?bGZnM1oyL3FBVTlVQU9EcFRQVzh4Sk4xNFdMU1hPdkdobnJVejJYd0Jmeit3?=
 =?utf-8?B?K2tjcUVPYUZJdTM3V3hrT1ZnRDc2TjdJZExOT013bVZUQUVsQ2Z4UDVIbjJk?=
 =?utf-8?B?ZU5KQlllVExKTjdpVjdXTHlKc1daVWZoMzBHbkFBQW81cHhsOUNMcjBnNThl?=
 =?utf-8?B?bUNuZHJVSW9pRDB5dzZTN3ZwUVc5ZU03dU8wYWUxVkk4cEtzdFh0ZmdRUldR?=
 =?utf-8?B?d05zTTk2cjVySWpNODc0QVEwTTNJMUFGdUhHQVFOckhVS2tSWkxWNDhaek45?=
 =?utf-8?B?WkYvNmxoY0t6b3JFZzdYTnhMS0JkKzdaOFFMQVBOVFFHZXJPV0xTV3BnZyt2?=
 =?utf-8?B?YTFHQ2Uva2l1aEhteHJCWGVmcmJzWTlDajhmeGFKZi9oRmdIQ3RhaGpOSzdY?=
 =?utf-8?B?dFJYVktuMDdBa1oxM2VrVlBLbGM3emwyNWI1b3VJUGM0amdEYk1VdmRPbC9G?=
 =?utf-8?B?bC9WZ09sWU10NEdMTWR3RE9VendRaDV0T1MvZlJNSWhEdzdiaEcwWitlRjR6?=
 =?utf-8?B?bzVWSlZsb2hva1ErbWhPdTV1THptZVRNRmhvRWo0bmhrRGtVajRIbStoeGFU?=
 =?utf-8?B?QldBRmc2N240dzM5aTNqemJhYmhNMERqc09sRE5QcWFwOFUwWGszVk5pcHRY?=
 =?utf-8?B?YjlMS1pvTFJHUk1CQ3RwODZzSjVIckFYRndpdWYxVHV2UE9jQ3N0MVpVZ1RG?=
 =?utf-8?B?QlNwdlkyZDJFUC9NY2hKNXV1SHNySG1mbUF6Tmc4aDNyMEgzMUF2ZFRBaXRp?=
 =?utf-8?B?QWF5THRRSHVBL2gyb3IxVFJmbW13eERIYXJxVXNXL0tONzNwaVYrckhTRVQz?=
 =?utf-8?B?amcrMjBadHVxSVB1SnBpQi9SODZFOWJXbHIzb2ZrOEJOS01QVXVmQU5RTnYy?=
 =?utf-8?B?NjFCdDk1RTVXaDhGZGFlREIzQXU2cDAxcFgxTjZGSlo2bVZrcGVMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6ad031-f696-408c-3749-08deb4b629ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:19:21.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXLEcjiq1bevEgDbd7B4TYLV7y/Sa2uyDx5gDvz4dsl6qtye0wDCqK3aAyjoQoEUzTNJeVAmowIQYIr/wC8HyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7647

On 12/5/26 19:03, Aneesh Kumar K.V (Arm) wrote:
> Teach swiotlb to distinguish between encrypted and decrypted bounce
> buffer pools, and make allocation and mapping paths select a pool whose
> state matches the requested DMA attributes.
> 
> Add a decrypted flag to io_tlb_mem, initialize it for the default and
> restricted pools, and propagate DMA_ATTR_CC_SHARED into swiotlb pool
> allocation. Reject swiotlb alloc/map requests when the selected pool does
> not match the required encrypted/decrypted state.
> 
> Also return DMA addresses with the matching phys_to_dma_{encrypted,
> unencrypted} helper so the DMA address encoding stays consistent with the
> chosen pool.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   include/linux/dma-direct.h |  10 ++++
>   include/linux/swiotlb.h    |   8 ++-
>   kernel/dma/direct.c        |  14 +++--
>   kernel/dma/swiotlb.c       | 108 +++++++++++++++++++++++++++----------
>   4 files changed, 107 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index c249912456f9..94fad4e7c11e 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -77,6 +77,10 @@ static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
>   #ifndef phys_to_dma_unencrypted
>   #define phys_to_dma_unencrypted		phys_to_dma
>   #endif
> +
> +#ifndef phys_to_dma_encrypted
> +#define phys_to_dma_encrypted		phys_to_dma
> +#endif
>   #else
>   static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
> @@ -90,6 +94,12 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>   {
>   	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
>   }
> +
> +static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
> +		phys_addr_t paddr)
> +{
> +	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
> +}
>   /*
>    * If memory encryption is supported, phys_to_dma will set the memory encryption
>    * bit in the DMA address, and dma_to_phys will clear it.
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..b3fa3c6e0169 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -81,6 +81,7 @@ struct io_tlb_pool {
>   	struct list_head node;
>   	struct rcu_head rcu;
>   	bool transient;
> +	bool unencrypted;
>   #endif
>   };
>   
> @@ -111,6 +112,7 @@ struct io_tlb_mem {
>   	struct dentry *debugfs;
>   	bool force_bounce;
>   	bool for_alloc;
> +	bool unencrypted;
>   #ifdef CONFIG_SWIOTLB_DYNAMIC
>   	bool can_grow;
>   	u64 phys_limit;
> @@ -282,7 +284,8 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
>   extern void swiotlb_print_info(void);
>   
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
> -struct page *swiotlb_alloc(struct device *dev, size_t size);
> +struct page *swiotlb_alloc(struct device *dev, size_t size,
> +		unsigned long attrs);
>   bool swiotlb_free(struct device *dev, struct page *page, size_t size);
>   
>   static inline bool is_swiotlb_for_alloc(struct device *dev)
> @@ -290,7 +293,8 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
>   	return dev->dma_io_tlb_mem->for_alloc;
>   }
>   #else
> -static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
> +static inline struct page *swiotlb_alloc(struct device *dev, size_t size,
> +		unsigned long attrs)
>   {
>   	return NULL;
>   }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index dc2907439b3d..97ae4fa10521 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -104,9 +104,10 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>   	dma_free_contiguous(dev, page, size);
>   }
>   
> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
> +static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
> +		unsigned long attrs)
>   {
> -	struct page *page = swiotlb_alloc(dev, size);
> +	struct page *page = swiotlb_alloc(dev, size, attrs);
>   
>   	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>   		swiotlb_free(dev, page, size);
> @@ -266,8 +267,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   						  gfp, attrs);
>   
>   	if (is_swiotlb_for_alloc(dev)) {

here we know it is shared so ...


> -		page = dma_direct_alloc_swiotlb(dev, size);
> +		page = dma_direct_alloc_swiotlb(dev, size, attrs);
>   		if (page) {
> +			/*
> +			 * swiotlb allocations comes from pool already marked
> +			 * decrypted
> +			 */

... is not this needed here
attrs |= DMA_ATTR_CC_SHARED;

?

and then the setup_page label below can do the right thing, which I tried, with enforcing io_tlb_default_mem.for_alloc=1, it works - accepted device can still do DMA to shared memory. Thanks,



>   			mark_mem_decrypt = false;
>   			goto setup_page;
>   		}
> @@ -374,6 +379,7 @@ void dma_direct_free(struct device *dev, size_t size,
>   		return;
>   
>   	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
> +		/* Swiotlb doesn't need a page attribute update on free */
>   		mark_mem_encrypted = false;
>   
>   	if (is_vmalloc_addr(cpu_addr)) {
> @@ -403,7 +409,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   						  gfp, attrs);
>   
>   	if (is_swiotlb_for_alloc(dev)) {
> -		page = dma_direct_alloc_swiotlb(dev, size);
> +		page = dma_direct_alloc_swiotlb(dev, size, attrs);
>   		if (!page)
>   			return NULL;
>   
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ab4eccbaa076..065663be282c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -259,10 +259,21 @@ void __init swiotlb_update_mem_attributes(void)
>   	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
>   	unsigned long bytes;
>   
> +	/*
> +	 * if platform support memory encryption, swiotlb buffers are
> +	 * decrypted by default.
> +	 */
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +		io_tlb_default_mem.unencrypted = true;
> +	else
> +		io_tlb_default_mem.unencrypted = false;
> +
>   	if (!mem->nslabs || mem->late_alloc)
>   		return;
>   	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
> -	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
> +
> +	if (io_tlb_default_mem.unencrypted)
> +		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
>   }
>   
>   static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> @@ -505,8 +516,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>   	if (!mem->slots)
>   		goto error_slots;
>   
> -	set_memory_decrypted((unsigned long)vstart,
> -			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted)
> +		set_memory_decrypted((unsigned long)vstart,
> +				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> +
>   	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
>   				 nareas);
>   	add_mem_pool(&io_tlb_default_mem, mem);
> @@ -539,7 +552,9 @@ void __init swiotlb_exit(void)
>   	tbl_size = PAGE_ALIGN(mem->end - mem->start);
>   	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
>   
> -	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +	if (io_tlb_default_mem.unencrypted)
> +		set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
> +
>   	if (mem->late_alloc) {
>   		area_order = get_order(array_size(sizeof(*mem->areas),
>   			mem->nareas));
> @@ -563,6 +578,7 @@ void __init swiotlb_exit(void)
>    * @gfp:	GFP flags for the allocation.
>    * @bytes:	Size of the buffer.
>    * @phys_limit:	Maximum allowed physical address of the buffer.
> + * @unencrypted: true to allocate unencrypted memory, false for encrypted memory
>    *
>    * Allocate pages from the buddy allocator. If successful, make the allocated
>    * pages decrypted that they can be used for DMA.
> @@ -570,7 +586,8 @@ void __init swiotlb_exit(void)
>    * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
>    * if the allocated physical address was above @phys_limit.
>    */
> -static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
> +static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
> +		u64 phys_limit, bool unencrypted)
>   {
>   	unsigned int order = get_order(bytes);
>   	struct page *page;
> @@ -588,13 +605,13 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>   	}
>   
>   	vaddr = phys_to_virt(paddr);
> -	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
> +	if (unencrypted && set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
>   		goto error;
>   	return page;
>   
>   error:
>   	/* Intentional leak if pages cannot be encrypted again. */
> -	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> +	if (unencrypted && !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
>   		__free_pages(page, order);
>   	return NULL;
>   }
> @@ -604,30 +621,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>    * @dev:	Device for which a memory pool is allocated.
>    * @bytes:	Size of the buffer.
>    * @phys_limit:	Maximum allowed physical address of the buffer.
> + * @attrs:	DMA attributes for the allocation.
>    * @gfp:	GFP flags for the allocation.
>    *
>    * Return: Allocated pages, or %NULL on allocation failure.
>    */
>   static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> -		u64 phys_limit, gfp_t gfp)
> +		u64 phys_limit, unsigned long attrs, gfp_t gfp)
>   {
>   	struct page *page;
> -	unsigned long attrs = 0;
>   
>   	/*
>   	 * Allocate from the atomic pools if memory is encrypted and
>   	 * the allocation is atomic, because decrypting may block.
>   	 */
> -	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
> +	if (!gfpflags_allow_blocking(gfp) && (attrs & DMA_ATTR_CC_SHARED)) {
>   		void *vaddr;
>   
>   		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>   			return NULL;
>   
> -		/* swiotlb considered decrypted by default */
> -		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> -			attrs = DMA_ATTR_CC_SHARED;
> -
>   		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
>   					   attrs, dma_coherent_ok);
>   	}
> @@ -638,7 +651,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>   	else if (phys_limit <= DMA_BIT_MASK(32))
>   		gfp |= __GFP_DMA32;
>   
> -	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
> +	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit,
> +					     !!(attrs & DMA_ATTR_CC_SHARED)))) {
>   		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>   		    phys_limit < DMA_BIT_MASK(64) &&
>   		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
> @@ -657,15 +671,18 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>    * swiotlb_free_tlb() - free a dynamically allocated IO TLB buffer
>    * @vaddr:	Virtual address of the buffer.
>    * @bytes:	Size of the buffer.
> + * @unencrypted: true if @vaddr was allocated decrypted and must be
> + *	re-encrypted before being freed
>    */
> -static void swiotlb_free_tlb(void *vaddr, size_t bytes)
> +static void swiotlb_free_tlb(void *vaddr, size_t bytes, bool unencrypted)
>   {
>   	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>   	    dma_free_from_pool(NULL, vaddr, bytes))
>   		return;
>   
>   	/* Intentional leak if pages cannot be encrypted again. */
> -	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
> +	if (!unencrypted ||
> +	    !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
>   		__free_pages(virt_to_page(vaddr), get_order(bytes));
>   }
>   
> @@ -676,6 +693,7 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
>    * @nslabs:	Desired (maximum) number of slabs.
>    * @nareas:	Number of areas.
>    * @phys_limit:	Maximum DMA buffer physical address.
> + * @attrs:	DMA attributes for the allocation.
>    * @gfp:	GFP flags for the allocations.
>    *
>    * Allocate and initialize a new IO TLB memory pool. The actual number of
> @@ -686,7 +704,8 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
>    */
>   static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>   		unsigned long minslabs, unsigned long nslabs,
> -		unsigned int nareas, u64 phys_limit, gfp_t gfp)
> +		unsigned int nareas, u64 phys_limit, unsigned long attrs,
> +		gfp_t gfp)
>   {
>   	struct io_tlb_pool *pool;
>   	unsigned int slot_order;
> @@ -704,9 +723,10 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>   	if (!pool)
>   		goto error;
>   	pool->areas = (void *)pool + sizeof(*pool);
> +	pool->unencrypted = !!(attrs & DMA_ATTR_CC_SHARED);
>   
>   	tlb_size = nslabs << IO_TLB_SHIFT;
> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, attrs, gfp))) {
>   		if (nslabs <= minslabs)
>   			goto error_tlb;
>   		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -724,7 +744,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>   	return pool;
>   
>   error_slots:
> -	swiotlb_free_tlb(page_address(tlb), tlb_size);
> +	swiotlb_free_tlb(page_address(tlb), tlb_size,
> +			 !!(attrs & DMA_ATTR_CC_SHARED));
>   error_tlb:
>   	kfree(pool);
>   error:
> @@ -742,7 +763,9 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
>   	struct io_tlb_pool *pool;
>   
>   	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
> -				  default_nareas, mem->phys_limit, GFP_KERNEL);
> +				  default_nareas, mem->phys_limit,
> +				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
> +				  GFP_KERNEL);
>   	if (!pool) {
>   		pr_warn_ratelimited("Failed to allocate new pool");
>   		return;
> @@ -762,7 +785,7 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
>   	size_t tlb_size = pool->end - pool->start;
>   
>   	free_pages((unsigned long)pool->slots, get_order(slots_size));
> -	swiotlb_free_tlb(pool->vaddr, tlb_size);
> +	swiotlb_free_tlb(pool->vaddr, tlb_size, pool->unencrypted);
>   	kfree(pool);
>   }
>   
> @@ -1232,6 +1255,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>   	nslabs = nr_slots(alloc_size);
>   	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
>   	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
> +				  mem->unencrypted ? DMA_ATTR_CC_SHARED : 0,
>   				  GFP_NOWAIT);
>   	if (!pool)
>   		return -1;
> @@ -1394,6 +1418,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> +	bool require_decrypted = false;
>   	unsigned int offset;
>   	struct io_tlb_pool *pool;
>   	unsigned int i;
> @@ -1411,6 +1436,16 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>   		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
>   
> +	/*
> +	 * if we are trying to swiotlb map a decrypted paddr or the paddr is encrypted
> +	 * but the device is forcing decryption, use decrypted io_tlb_mem
> +	 */
> +	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
> +		require_decrypted = true;
> +
> +	if (require_decrypted != mem->unencrypted)
> +		return (phys_addr_t)DMA_MAPPING_ERROR;
> +
>   	/*
>   	 * The default swiotlb memory pool is allocated with PAGE_SIZE
>   	 * alignment. If a mapping is requested with larger alignment,
> @@ -1608,8 +1643,14 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>   	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
>   		return DMA_MAPPING_ERROR;
>   
> -	/* Ensure that the address returned is DMA'ble */
> -	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
> +	/*
> +	 * Use the allocated io_tlb_mem encryption type to determine dma addr.
> +	 */
> +	if (dev->dma_io_tlb_mem->unencrypted)
> +		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
> +
>   	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
>   		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
>   			attrs | DMA_ATTR_SKIP_CPU_SYNC,
> @@ -1773,7 +1814,8 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
>   
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
>   
> -struct page *swiotlb_alloc(struct device *dev, size_t size)
> +struct page *swiotlb_alloc(struct device *dev, size_t size,
> +		unsigned long attrs)
>   {
>   	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>   	struct io_tlb_pool *pool;
> @@ -1784,6 +1826,9 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>   	if (!mem)
>   		return NULL;
>   
> +	if (mem->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> +		return NULL;
> +
>   	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
>   	index = swiotlb_find_slots(dev, 0, size, align, &pool);
>   	if (index == -1)
> @@ -1853,9 +1898,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>   			kfree(mem);
>   			return -ENOMEM;
>   		}
> +		/*
> +		 * if platform supports memory encryption,
> +		 * restricted mem pool is decrypted by default
> +		 */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> +			mem->unencrypted = true;
> +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> +					     rmem->size >> PAGE_SHIFT);
> +		} else {
> +			mem->unencrypted = false;
> +		}
>   
> -		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> -				     rmem->size >> PAGE_SHIFT);
>   		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
>   					 false, nareas);
>   		mem->force_bounce = true;

-- 
Alexey

