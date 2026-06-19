Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7F1A682A;
	Fri, 19 Jun 2026 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781834760; cv=fail; b=njqvfbLNHEeOvSlbE7jFTRLeovMOCfop1hmRzcsutNRhhlv/zbHeegW3tvdHrSGA72gddJUPRE6Ghu2nRW+a5rRbqhZNLUtTiQiRiqoCyWgXOJ0rUXvQXdq9y24KapVfYBf7WLfFBepcNcqRUqV8LSo90OHzfzRsVoxy4Qqsobs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781834760; c=relaxed/simple;
	bh=haaxgmooLEkvFKr9XCc/0Hyrcv4Bz2zzQdBaLBxmocs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=feebPSKbWvhvovMK4FYZqROVdG2MGXhMsQgsDYz/DctOmxS9aX3x0aVJEq82FTdpTUPgfU96RRclNgjSQRMiFvBNkA0fnyD0wrQ2sFWeO7jZaFmCxNwCUHvWkPhmSzMNzmQO2ZY+fxxm9J9dYzHnAN2eYhiWbZZY8vnqK4cp1Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1BPF2AAC; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1BPF2AAC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTK2RUYDVCDs1n/0iYrWETJT/cDJaBlR3H6QhAd4XbrNf9TV4Rg/PmYfW/+/aqHfOU/c3MqTyYxa0h/Bt9fL25TsQ6L2pLJcsHkTITDhHCijslWSa1fLByloBnzxj0A0kita8u0/zXcatwymvqMZneKgnf8DlwJB8K0W22P+x+1/PcEcuefzpN4XAncIQ/xhDMINLtE6pK9mtT6OEO163R5wKhViRknIftpDtzZ6K5GT/eDtApe2Qu6N4HlpwEt2SbYtFu0q7MyVq9fKlnBMUdpdFjLVSp/8jLgKdm9hfe1fy4cXwPpU9RYztA8XfmEQHOUy5kzW9nX+bwAdM7TtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO3Uwu9YXgSeFUwMQBdwSjLjIP2l7aCMzKGUPtpsJNg=;
 b=A8bdIUeznSsPM0Oe0yhX8UqfsJ71eCkjEQFwYuAuX0jNJMFJiMQXxRy3OBkqawRSfG93LXB8lgXFcsnmJDRwUX3d5aCP/JoTXI/jOs5bFyxc4LJaF5sHICMTL2sJ+z5slmgpYZAtCo937sqR1WxNG3F6SVr6ag/fKVD6rBO8mPRf+V9rj27xn1Ra/vINbPTFavjtLwOWLqlRmlkr23djPtm2T9yW28XrX7dtfrQSeVD+m2vLTz0aSV/hojN643flVF7r0dHZlJBSj7SlGs2ac052+N7xbV+lZewbxOLoMKjk+ZwltLwl0gT6jT4Dmoaux1Xykmf3nhmyXJgdmJOJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RO3Uwu9YXgSeFUwMQBdwSjLjIP2l7aCMzKGUPtpsJNg=;
 b=1BPF2AACvlclAy8QKNocwwGNiXonZ7lT8/2mhB2yBn4+SmkRSlgLERES80YzRHumVH9oT1FAak0iOw2E8SGIYn1l6quh/9ISKm8YOQ6uBKeMO6pofD9xmHnqhqapaabY88uM1ESl5jpChh9HafAA+q9qCjidY2IAYCWfO9QP6fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by SA1PR12MB6704.namprd12.prod.outlook.com
 (2603:10b6:806:254::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 02:05:54 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 02:05:54 +0000
Message-ID: <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
Date: Fri, 19 Jun 2026 12:05:45 +1000
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
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com> <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260618153705.GH231643@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYYP282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::28) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5cf836-5609-4e38-97fd-08decda74b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kX9f/Ctpt+Qw3FhU0VDSnrg0Br7W75fFKn4cJ/Qrotp/mKbEAPPTEhBUtU79MUzqVQkuo+vehL70Hef99ENh+dJhs0nVw9FnPVA3T1hKHq9NyGbdUDl6sxvDO7wA4QFzduORaImT7ADcATb6lWkN3Y5P1bh77Uctz18BowW1ydh6Fl4kH/dT79g+Fv1JTOE/Wljqyp4HiSit9fHFdDWEuPCD1ga2LJOx+wF1qycPU9aYJkHpUkLw+lsA54E65W0FV0uF24f+Hi2U35yOFRCqqAAukFtZ00jc38iea6I9cPh+JeDdCDcGzPWHtP8USXNaPUvJbdFr8Iqow43/EMQhx+ShEAZEymsIAcfJ7QEJA8JwD99KioKJI1tJTXH93W3YltTy3zzJ9BpQzH4Ps+SbGwLfTftqJRgBb2kr6tWFcaOTSgS/wduKMRNpXfYK5K8VAtM94kSDMNkirbqrePkf3B9piwM/tQQzukpA1ZLVXhsd0an8Nz8fF4sDeGoMA9oATXIgcIaPA2cVtuJtes6ziVPJ5o7x8/mHvmb0Z/rzhmQO/Cou3mo6UzzSfzkgg7RQc9KASDEInKSSqIVPm1w/B8cCR7JZshFHYo8n1x0UFHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FPR1NDaGFWNW1uVEZZQlV6bCtWSDJQSkF2RTQ3dVE3SURMQjByK0dRQlR1?=
 =?utf-8?B?MjFyaUVzd1N3UXBsQ3pYdXhzVUhaZ2NpMDY5TkJvTzQ2ckdOYll0Y1Y5SDRD?=
 =?utf-8?B?QWF5YkpyNnlid1V5QWs1Q3h2UHhIY0ExVm1qcXdWVXBVVjZmTnZXYWdZMzI0?=
 =?utf-8?B?WlJlekd5RW5XbWlod0NZSGRNdy9KRzZOLzRHVmJrQm9JempGcDU4bXBnL3kz?=
 =?utf-8?B?OHF3enFtSGE5QWllYTczWDNUUlkvcTlqQ2Nxa3NHV3lpbUtXcEZRTEdxSnkz?=
 =?utf-8?B?RU5CaktqNDNUOUxXNzFBeGtSRitIRHlaZzQ2T2hQemhPRUJYRVlRVmVZQ1NC?=
 =?utf-8?B?RDVNRndQT29LVjVpTVlGeTR1U0dOdWpsWHF1Zk16d01zdEJBa1VTK01oVXJN?=
 =?utf-8?B?NnVTQ2UyUFRDWjdsZjJjaVBRTTR3SVF0WUU2YUx5eFdpTThrbEgrZHRSejN0?=
 =?utf-8?B?QVpaNzNHWk9uSzMvbzdZei85bFhOZ2JzUU15em5rbFNLVjFRRWR2RWpWMVJF?=
 =?utf-8?B?KzRMNHZnbVR5UjdZRnZ0Mkpid293MW02U0ZPbmNGQTZkd1VDUStyNXExZC8r?=
 =?utf-8?B?MVpRUkhiczArTTViT1YyeFZKUGpKYkZLRkpKZmRtQlJVc1RQZUliZU1yZ1Mw?=
 =?utf-8?B?Mm9TckFUTWptUWJKcW56b2VieFlqT3AxT0Q0d2JKbEZ2cmxWaUxtNjdVLy9X?=
 =?utf-8?B?T25taHRwcEprbm1qSTFDSWkvRktyeXZUdzU5OHhJTjhtdWJ2UVFwWGdGYjZ1?=
 =?utf-8?B?NG1NUjJaWW9aV2tDODhoQWd0VHM5UlYvbjdEZlc2N0QrdEx3dzFBNURjbVp3?=
 =?utf-8?B?YVZNeVV4UmkwQ1hEVXAwWFJJc0VJTU4weVBxTk9peGpOejQ0c2gya1JVS3ZR?=
 =?utf-8?B?Nkc0eEZDN1dLVXFseVk2WCtLR1A1SllqemVBUnQzQm9kZ0ZkQng5bm12Rk9Q?=
 =?utf-8?B?OU4wQ1Jtd0txYzhRc1NjdnQ5amJCUmErZlduMFNaWlc5UUQraWZnV2luZlNQ?=
 =?utf-8?B?bHhJWFAwbnc3TXNLU1hlSzNYZWpKSnNrUTZ0SWlOQWtCNFFFRDh3eFNYZmtG?=
 =?utf-8?B?NFdCbFBYSmZIQjhnOC8vMUt5bWlxOWoxTHl2VklGMlpYZDk5bVpuZFZkZnhQ?=
 =?utf-8?B?RjBrcDVrcGVlMS9adllVdi9WbEVDN2RhMkIyZjJqVzJRZXZWQmEwOE1mUkk0?=
 =?utf-8?B?cjlpZFZGcG5lVGE4QWpKRCs1MU1DNVdUM29ZWUhpV3M5clR3eUtrMTdReGdn?=
 =?utf-8?B?TFNMN1RFa2JRVDl4dXp5dGFJSzAxd1NXOWhwVStRUHh4NVhSb1lLQ04yT1pQ?=
 =?utf-8?B?blZBekZJcUt0RmpINnNOM1dMT1J2TGxNc2gzYmRRU2p0TlYwcDJiYWN0TVdI?=
 =?utf-8?B?Rm9DV0tYUG9kbnM4TVhMd2VadDJuVm1FL1A5T0VlZW5ESzJvZk1Lb0FaWC8x?=
 =?utf-8?B?ZzI3eG9qMlhDcTRKTlcrUC9udnNmejJuVFdOQ2s3RzN4ZE5EdHcvdVlWc2hu?=
 =?utf-8?B?ak9xU2dwZ0xJb3RSZnAvVlNPenlDa3B4NHovZmgxRXFqam8zVG9ZT0FwSDhm?=
 =?utf-8?B?cTdZQU45dS8xZFJENEZIQVZjSkxSenV2NWxWUTZxNjZMbFM5MEowUDV2emVJ?=
 =?utf-8?B?akRadVUvSDhRMWMwcTkvZXNrdjFvSmlERDdVZ2ozeEhGU1kxQVVjUHhTd1lL?=
 =?utf-8?B?ZnVRbUp6eHBmK1VpUnJiSXM2d1dYSmZwUFJFeGlaTFZJZFZRcUtyRnh3ZXRL?=
 =?utf-8?B?aEJGdmllTFQrNzNyUnpCQ3ozZ1h4Rmd2eTQ4T0liVUlreXp2M2hVSmRlOWU2?=
 =?utf-8?B?ZERhRThEVXUwbWZ0S2l2MTV5QkJYWXN0OEZqbGZpOGkreitCN3ZUWVZFUlI2?=
 =?utf-8?B?Z1pqdGxXMThuOVF3VXpZN2VNK1V0U1JaTzZ2bGdOZ0FFdUJ3aG1GeXNoYkw1?=
 =?utf-8?B?NWNENFc4VWQyZUY3Um1pLzZYcEp3TVhsTmRsTjVWQk5LZjFZbkJQOFBTMXBJ?=
 =?utf-8?B?QUVCay9rR21VWEUzSWgvb3Y2TnRyUVlLbXdTNGJqSUt6Yy8zZUdTckZNR0Ra?=
 =?utf-8?B?TFQ1VVVsV0VlQmU4alR3MmVMZ1RScjg1SDNYR1ZjZ0JHSmNReXJkNndqRGUv?=
 =?utf-8?B?V1FWaFFtWGJTTjBma3RNekVLL1NkNUoxcDVwZWhxaVZtcUZKU2c3dWRGYnB0?=
 =?utf-8?B?K0dOdHF5V1JXRGcyWmhzYWJTVDJscEhRSHYvZjlJSndKN1JYcElCbnNrSzNS?=
 =?utf-8?B?M1plOHgvS3djZXQ3U3NFZmdmT3FleDFPVmk5b0wydWxWNGZzNWpYMUFIeXhB?=
 =?utf-8?B?dEUxVUxaMktIc2FvazJSK2hrRW9vU01sa1J0RC9MekZaMHh1QkFjdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5cf836-5609-4e38-97fd-08decda74b3b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 02:05:53.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8cNpjyzaRX5xoINOYFBPZR3VenQQ6KrftZ5X4h4vnrjSnxYh3rhfFQ2fFf76ffhPT7dlZPZICmzAVz7HaVq6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704



On 19/6/26 01:37, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 09:37:22AM +0100, Aneesh Kumar K.V wrote:
>> Alexey Kardashevskiy <aik@amd.com> writes:
>>
>>> On 10/6/26 00:47, Jason Gunthorpe wrote:
>>>> On Tue, Jun 09, 2026 at 02:43:08PM +0100, Catalin Marinas wrote:
>>>>> On Thu, Jun 04, 2026 at 02:09:39PM +0530, Aneesh Kumar K.V (Arm) wrote:
>>>>>> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>>>>>> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>>>>>> are handled consistently.
>>>>>>
>>>>>> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>>>>>> shared/decrypted buffer handling. This series consolidates the
>>>>>> force_dma_unencrypted() checks in the top-level functions and ensures
>>>>>> that the remaining DMA interfaces use DMA attributes to make the correct
>>>>>> decisions.
>>>>>
>>>>> Please check Sashiko's reports, it has some good points:
>>>>>
>>>>> https://sashiko.dev/#/patchset/20260604083959.1265923-1-aneesh.kumar@kernel.org
>>>>>
>>>>> I think the main one is the swiotlb_tbl_map_single() changes which break
>>>>> AMD SME host support. There cc_platform_has(CC_ATTR_MEM_ENCRYPT) is true
>>>>> but force_dma_unencrypted() is false. Normally you'd not end up on this
>>>>> path but you can have swiotlb=force.
>>>>
>>>> IMHO that's an AMD issue, not with the design of this series..
>>>>
>>>> The series is right, a device that is !force_dma_decrypted() must be
>>>> considerd to be a trusted device and we must never place any DMA
>>>> mappings for a trusted device into shared memory.
>>>
>>> swiotlb=force forces swiotlb, not decryption.
> 
> If force_dma_decrypted() == true then swiotlb must allocate from a
> decrypted memory pool. It is right there in the name!
> 
> The hypervisor environment should *never* set force_dma_decrypted()
> because all devices can access all hypervisor memory, up to their IOVA
> limits.

True. But we do not have encrypted swiotlb pool today, right?

> 
>>> So when I try "mem_encrypt=on iommu=pt swiotlb=force" with this
>>> patchset, it fails to boot. But it boots with a hack like this:
> 
> On the host side I expect this to cause swiotlb to allocate encrypted
> memory and bounce to it.
> 
>>   		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>>   		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>>   						dev->bus_dma_limit);
>> +		/*
>> +		 * With memory encryption enabled, SWIOTLB is marked decrypted.
>> +		 * If SWIOTLB bouncing is forced, treat the device as requiring
>> +		 * decrypted DMA.
>> +		 */
> 
> And this is more insane logic. The right fix is to allocate the
> swiotlb bounce from the *encrypted* pools when running on the
> hypervisor which requires undoing this abuse of force_dma_decrypted().

+1.

But how does the kernel decide if it is this swiotlb pool or just some page which happens to be below the IOVA limit?

swiotlb can be for bouncing (with all these dma_sync_single_for_cpu) or, if dev->dma_io_tlb_mem->for_alloc = true, for coherent allocation (no need in dma_sync_single_for_cpu).

I am looking for a way to set up my "sev-guest" device such as when dma_alloc_attrs(snp_dev->dev,...) happens, it allocates a page from the shared swiotlb pool (with no actual bouncing) and there is no obvious way to trick the DMA layer into doing that.


> 
> Jason

-- 
Alexey

