Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974470830;
	Thu,  2 Jul 2026 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954272; cv=fail; b=rRaK3e9BGWqMWTmjdmww5Ds4dGjRy5Z4iYB8pIx/6zmFI3LfCcDmZ/GczMbGpCDY3VyZ5/N4qFu4qGRwUD9zv/7BCsdAGrU/dgkepjsfCrkaaH1/Rgbp88XSjOhH/Lq6B1oKWHeRuhr7NQsTONcEHTe8nCR520YU4dyuqsku78k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954272; c=relaxed/simple;
	bh=2S3HisgLWJZZ50b+nEvNRrJ/wwqed/hUwLagcM1P40o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFzXmhKA/XyiYLda/4lzdX912JVPv8Or+J30sXmOn0VyCGMPGBHHkOuwVmRNhT8eEttoxbLHocMggYAGp4xf+C90Q9Csb3FczXrZt2p05d+hxwdULY/ZBFsA4YfveX0VvNfAawXmpT0llRtRctzpyGTIYabTDg4/TRUtmM8QfFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bm81kGXN; arc=fail smtp.client-ip=40.107.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bm81kGXN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNLI96ojasc79ecRGjnMfePWTvenH6im+YIj2gFLZG9vS/PPyYgd9+dhHzrJKNcepMl4swSUjiMN3agdoIFJRFaVrhuRbxai5H8opebVCwG1rp1FLyIzvydnc+lAsJ/l4OsG3pAfhRWxaXVTrVWsbvy3UAC/6DfHjPTb/oxQ+xfmhE57aJtKeg+8vhDvEBlU3ptmAROQvZ63Ukk3p0u2xCFRf/RBu70Vqo7AgXoxtY8fyQ3KeOmTv3E9iNKioIL9IBqozwHpjsGzIAuKmMc0TRI3DV4155XfXM/SuIcl8qOHA717S98X+FHQTynbYtllBjHImpGYMc/VxfME+tqubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaP8gBqnh5GPSVyYN1kd/wUuTR0xf8hvRMj30o/v9ks=;
 b=LJdCNG2fWfqYDAJwRqBHYVdDmArsLTRrSb0dPBzQMpBHkkx4aEKaWQxjIysO0kk+bHX1C5063P2+BNGA731Bbe4cwAfvBuVH+K3duawbTt7myhy9G/Vr3rt7rQK0JqI3l5qWuaFmnQmsZkwAVTUF0prmbPjB96E6nKocgQ0F9E8GyxKoIkQ6bwOBhV6rGQq7ljxgM7GCJEauotJp1gg7X0lq1krtbDhMEwHiB2yJI49BAbq4NziP2WnSYw+EuO+OXex2DT0yIp4uEhMIobdjx7R5a3ULC8stmdNhElSJttFbezJQQkePdoPLxrAOeaf9aJGiDCad/c8HjfWYgOieqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaP8gBqnh5GPSVyYN1kd/wUuTR0xf8hvRMj30o/v9ks=;
 b=Bm81kGXNaBHmo6BPVzF/iTwkDGPKoAU7aiyPDr94IVs8+TtEITFEUINL75xqm8aPQ4CraBe/hGwQdTeIfR91RYxvMB9xEzQygE59as3kW14T2BzEloxP+KseA/eN4cWcq/CpBTMeI3+aD4+UAuNe9kn4FAnGTkHBPc9REaBGVyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by PH7PR12MB6418.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 01:04:21 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 01:04:21 +0000
Message-ID: <fd135adc-a8a4-48e5-b649-2a29789b22d8@amd.com>
Date: Thu, 2 Jul 2026 11:04:12 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
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
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
References: <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com> <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca> <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca> <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca> <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260630174216.GK7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0104.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::29) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc7829e-0d78-453c-be0b-08ded7d5d9b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	vkW5DZxgHyLzmGFoS8kHgDSRupGtfOffLT7WjaIl0RUa1Q44pi3EkDKg4CZnmXfVztYxpdkkXzlRXCCqJz5/8WgvB/uCUX+CAlUyoOC8QMvIpfCCuJ7pgcuw+ZUXzXWbAjKvZJecJvkFtnK26o+u+zGkbQ+ybN41Kng++IcgD3Imec98I89IlQqhPlmG9DE+SdSc4q420QZ674PA0XVHQYbPb+yo/W96lVYbTjKa4YOxvDUTOb08vQWTXphj5diFw3u3EtM34yZXNR9Z1T8TzmwKJ8hLQvZ4BrNJeWIEJWWg1O24u3zv4mUI4jXW0jUx2IHL3QcZgRVVifBaqJHTznvZEYez9Cf+sm369HiURgt0MjKgTuATkWIhCjlrx1IVq5zhpEM221qSW/q8MYXvNbQy6+jI7qXgLgvd0BTNR2G75V5v+9rfybozd44EejtLIDiSTy+CltAYMl4gVFZhbE/zUSftQcGvvtpsK9U29sOlnwVSbRDv4QaDo6mAJV5AH+n7SK6+qFhGdr4P0XSAvX7FG1Re9Fi1BS4PxUa/fD6EOBhxAtZB4TDO+blKxUUCLYarfsmaQQVGFeSCTnqFd5V7KrRZwV76THMje+Gx3md4ph3fbkm8ZCLU/PzKC0Kv93sfqFVIBKTZwwgU0D8pV7dtT6GVVI93386DgnQftIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmxYL3Y5Qnc5Q0hETGhDY1JZb2JrTk1XOUR1YS9DQ01UWTJjNnBDZ2ZzVFhD?=
 =?utf-8?B?M0RwOWt1TS9SWVNOeWc3UVdLOVN5YVVnb1hIVE1kUG9KbWNXVTR1Z0U1ZlEy?=
 =?utf-8?B?Z2ROU0lPRW5kN2ZVTUhra0s4VFRPS0tCcTR0a01WbFRudm14K01qTFpZUzlE?=
 =?utf-8?B?RUJNVWFyYTNFT2RVaHB4YUJITUlLeFY0WG53RFE1eUtZaENSOEswUEtoSmJk?=
 =?utf-8?B?cC9aZ29jT0JtcDJVd3N3UkdYa0pxdU5QaGJIYmtMb3JaVm1vV3Qxemw3S2RS?=
 =?utf-8?B?Mk1pM0RWbUdmSnE2OWp5RnFHVmt5bjVWcTNyR0p0UUpsNkx2ZW8xNVgrc1Rn?=
 =?utf-8?B?RithMzROQU01UXc0YkxxMTB5WmZWbmJHVXozcVl0THBaWW1xYlFpSVFrSnli?=
 =?utf-8?B?NnVxbTZ5dU92OG8zbU40SEdWY1dTTDBOVlpBbEJGQUYxcDFpNWE4R0pVdTcy?=
 =?utf-8?B?T1VGRGQrWU9WZXJ5czg1alpiYlhCenhLck01TGVYNTJaQ0ttN2hhYjJ5L25Z?=
 =?utf-8?B?eTJ1elI0MXFlZXFsS2xBd0h1cjVtaTd6bi92RDNxeUJuWDhsNXFZc3M2ZnhW?=
 =?utf-8?B?WlZKVzFmWVM1blBmQTlrMll2eTc1TURFbXhVZGo5c3NFOGNHNGl2NVlTaVov?=
 =?utf-8?B?Y1NERGQyM1hPYmRLdEswYXpHNkUwSzlqcEczVG8xNlBhR0c3cUZHQnU1b1BH?=
 =?utf-8?B?blhya0k5c2lrblhPYkU2Sk5ZKzlrOE94L2crQjBWWnBYSmZ5cER0a1F5ckpV?=
 =?utf-8?B?aW9nTkpUVDFlZlNSa3BzdXVLTW1hTkRvbWdqTkdLSE45dGxOc2tmSUxuMTFF?=
 =?utf-8?B?d05jdlZwbk1kU080Q0FNa0VZZzJHd2xFRnFXRVJmaDdnNi9QWFpqRmhjblls?=
 =?utf-8?B?aHA1eVY3b1BQNU9FUmlNbW81WXZyL3RjNmdnN05VRFRzSXJRbTJXUVJwQktk?=
 =?utf-8?B?d0gyenRlYWg0d2xEcThRZ0lwVEpLc3hOUmhETytMVklVUjdRMnpUd3IvUzF4?=
 =?utf-8?B?UEdGaVVhcWhkZkYzMER6VmlRSFpzRXNvMkhnMi9EdldkaFhNRHlvS09TQStN?=
 =?utf-8?B?bmJobHZYbG15SERNbXhUSHFadWpJLzdzak1LcG5ZNjNpci9RM0VvRSt5czh2?=
 =?utf-8?B?bldWWi9vSlI3ZUZ0cHl4QzJTRnNrN2xNVVYrQmx4SHUwcXUvTTJsaTBMMUlZ?=
 =?utf-8?B?RmVTOExlZ2ZHdUlVM1ZESXZEa0dSWGFhc0JtQVJKKy80TEg3aVNnay92d3E1?=
 =?utf-8?B?aWloY0xOS1hPcDlWUUk0bjkvWjdML0dnaU11RTVJM1lOOUFQZmpXZ05KTUU3?=
 =?utf-8?B?Y1dnQ2hxTFU5UUI3dG01ZTRXdFhHSHNKaGVocVhvdXlPdk1hOTRyMnk1V1A3?=
 =?utf-8?B?eXhyZ1BNSUJNRGN2Z280QVFQMStVY2RITWpKcHdlcVdOWEl3MjVOeFVNTE5R?=
 =?utf-8?B?bVMybXZyNFNpbXEyMUthQlpkc3VEcnV4ZUZ2NmJrN01XMVhwMDFiLzFYY0lE?=
 =?utf-8?B?UlRaZ2dtNzM4UTJ1UGltTytFTHF3NVFjMHljOEdMMmRBNFJDdU1XM1piUEY4?=
 =?utf-8?B?SS9SV2dTdzFISkZRSDhYb3FUcVdTMjYxRHVVNHZtam5NK0VjTGJCM1VDYldS?=
 =?utf-8?B?L2FpeEtuQXRjZGZueTVnTnBrZXE0YTdFcmlwdEtJeXhVTkpsR1o0M0w1UXor?=
 =?utf-8?B?Q2lSb211YUliQjYrNkx1ZC9majNtZFl0U1J1czN6WUc0Y2NuVnduOCttOGRr?=
 =?utf-8?B?aXEzSGpRM0VKS2U4R25nRzNTb0M1eW5kL2padlZ0c2RXQ2FjNXN4Z3JqL3Fa?=
 =?utf-8?B?dFJpQmc0M2JBL0tTZGVGS0Nibnp0M0tFamxyYzJHbGhHUmUxTCtUb2xXK3dS?=
 =?utf-8?B?Q2Y1OXpINkR6dS82UHZlRzhUdmttY2k4dlVZTU95WkRFWVRISTJLcGZLWkN4?=
 =?utf-8?B?NjM2bjNkOWJlYjZkZTdDYWJIQ3BtMERCd0dRaWFIeHNaWm5mb1dwS3RiMXJ1?=
 =?utf-8?B?UzVGMGV3T2ZzT0wzZHg5Nk5QaDU3ckhtempmaXJtMS9tV2lXU0tJK1R0ZG9Z?=
 =?utf-8?B?TkZ3bW5MdjZoWmNObVVjZHEveTRZb1lLRlZLRkg4WFVpTGp1TS9nNlVhdWxB?=
 =?utf-8?B?UGJjN0Z6Z1NZbi9Vcy8zSnllMm96SGRKc1VMQi9CTjNuWlU5UzJvUWdDdEhE?=
 =?utf-8?B?cnpmU0VqQyt1aDJ3MElOV1FGZXdlRUh6S1FqbTlnUG5WRkF0LzNUVlNYS1c4?=
 =?utf-8?B?ekwvZVZpS3A5MWc3akhUU2VrUHhQYTNiUmsxdEZOaGtlM2gyZ2xYU0J0bGdn?=
 =?utf-8?Q?XgdWGaMBeaut2akeqE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc7829e-0d78-453c-be0b-08ded7d5d9b2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 01:04:21.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK0+R2Flz78bKqbtX3+xF6YXoWukvWXyptyCzPDCDwinaKpGuN9iS7kvnLEvsqcAlQk4OEGjiYo22c4rkr/hDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418



On 1/7/26 03:42, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 12:16:30PM +0530, Aneesh Kumar K.V wrote:
>>>> Thinking about this more, I guess we should mark the swiotlb as
>>>> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
>>>> CC_ATTR_MEM_ENCRYPT as we have below.
>>>
>>> The name cc_shared should be used for GUEST scenarios only.
>>>
>>> I guess there is some merit in keeping swiotlb using "decrypted" to
>>> mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
>>> gives meaning to on both host and guest.
>>
>> Are you suggesting to change the struct io_tlb_mem::cc_shared back to
>> struct io_tlb_mem::unencrypted?.
> 
> Yes
> 
>>> IDK what AMD should do on the host by default. I guess it should setup
>>> a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
>>>
>>
>> If by low DMA address you mean using an address with the C-bit
>> cleared.
> 
> Yes
> 
>> The current code already does this and uses the swiotlb pool correctly
>> on SME.
> 
> Well, through the force_dma_unencrypted() hack...
> 
>> The challenge arises when we want to force SWIOTLB
>> bouncing even for devices that can handle encrypted DMA addresses (more
>> on that below). For such a config force_dma_uencrypted(dev) will return
>> false and swiotlb will be marked cc_shared/decrypted = true; This trip
>> the new check we added.
> 
> Yes, because cc_shared (guest) and unencrypted (host) are very
> different things and we've mixed them:
> 
>> 	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> 
> I'm aruging force_dma_unencrypted should mean cc_shared and be
> guest_only, but the SME hack breaks this.
> 
>> We can also do
>>
>> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>> 		/* swiotlb pool is incorrect for this device */
>> 		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
>> 			return (phys_addr_t)DMA_MAPPING_ERROR;
>>
>> 		/* Force attrs to match the kind of memory in the pool */
>> 		if (mem->cc_shared)
>> 			*attrs |= DMA_ATTR_CC_SHARED;
>> 		else
>> 			*attrs &= ~DMA_ATTR_CC_SHARED;
>> 	} else {
>> 		/*
>> 		 * Host memory encryption where device requires an
>> 		 * unencrypted dma_addr_t due to dma mask limit
>>      		 */
>> 		if (force_dma_unencrypted(dev))
>> 			*attrs |= DMA_ATTR_CC_SHARED;
>> 		else
>> 			*attrs &= ~DMA_ATTR_CC_SHARED;
>> 	}
> 
> If we do this I would like to split the force_dma_.. functions into
> guest and host, ie force_dma_cc_shared() and force_host_decrypted()

imho force_dma_unencrypted() should not look at the mask at all (the mask should tell the DMA layer to use swiotlb, encrypted or not), instead, when we set up swiotlb - we could make it unencrypted if iommu=pt, otherwise encrypted (although this means IOMMU and defeats the purpose of swiotlb). But at least this patchset has enough plumbing to have swiotlb encrypted, right?

> To make it clear there are two very different things here.
> 
>> Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
>> need to split this into two flags and introduce the resulting code
>> duplication.
> 
> The external flag name should be DMA_ATTR_CC_SHARED and only used on
> CC guest. Internally that turns into using set_memory_decrypted()
> which works on guest and host for AMD. I don't know how to make the
> host only case clearer and still keep the code efficient..
> 
>>> The dma api has to detect, after the driver sets the dma limit, that
>>> none of system memory is usable when:
>>>   - The direct path is being used
>>>   - phys to dma for 0 is outside the dma limit
>>>
>>> Then it should assume the arch has setup a swiotlb pool for it to use
>>> to fix the high memory problem.
>>>
>>> Similar hackery would be needed in the dma alloc path to know that
>>> decrypted can be used to fix the high memory problem like for GUEST.
>>>
>>> I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
>>> few key places? Setup with a static branch to be a nop on everything
>>> but AMD, compiled out on every other arch.
>>>
>>
>> If we are not able to reach the memory because of the memory encryption
>> bit, then isn't dev_cannot_reach_memory(dev) the same as
>> force_dma_unencrypted(dev)? If so, that is how it is already done.
> 
> Sort of yes, but it is properly named to its purpose and not confused
> with what should be a guest-only function.
> 
>> x86/dma: Disable forced SWIOTLB bouncing for SME IOMMU passthrough
> 
> Maybe as a crutch to get this series merged..
feels okay but I do not really know the true meaning of "swiotlb=force" so adding Tom to the thread. Thanks,


-- 
Alexey

