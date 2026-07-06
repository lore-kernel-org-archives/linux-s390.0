Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00836F91F;
	Mon,  6 Jul 2026 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363544; cv=fail; b=KhzI6mPFXCO7PiWhz/w082D9LHAHNa83cMn/otdesu50Q5IO5JhTaA51LNSs87dgDVYBSNyhmyG8cxdgB7zRzVPOMvkhgQXkD9DEMvtVLdox7qR7R2bk3abF35C++LvxGdTLXWgphsOSICL0jiMiTnCvD7JL4guOXKVyvKMNKm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363544; c=relaxed/simple;
	bh=mlBMGqSRsUyplMZd1BjFARHhZzoffVF0up0F8Qi4KV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KMcZyEcHISmUoEt0aU4ZV1kVewOCvv8CsIEHBzw9GARMotxYqWYe4qBjKX5OJEp1aJfWOZHWh2OCi9ERQ4o9Qrh5wgPYxOt/7H8tNwLg/k9LF23g9yyfXMeX2k4FJK1HLI8fvI/YBVn9EXrA84nOYMVvhbUNPzWKp6ZvQtR6yOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I6JOX2uX; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I6JOX2uX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fjf2/U6J7C0NBnGzmhx+QsF0OL2OrAqhjGJO+fkEmHP2VmhgnVd7FnEFDsgaybzl95myiS0S0eB8PtymVn13A4tG2rQls1VRW0XkdfQOuFD6jml6bxc6d+R6AmygKX70k9FsqWM2o7FTtz4QqfRfxFqvbaU9EHYL3nde471r3H5FQaugqWdL6+FxFoWJgXv9GQIXNmQCei15qLH0QATib5GLIa9hPugIUen6MXsGrCI/0y7t9YRFaHw04Cpc402HhTNbhMjtWraVBpA5tx0AhmNvJCpG9hb9YDCreVYGAiH743CwvtLg7phiLtHwYTYRjjAlKjJirvUzPRtJcnLYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPzEzqc0eYkC+HoB8B+lDeJYTSumZwHIoNdNUvkS2Jk=;
 b=knU/R7WrJjrpJFwFsdNW8RfjxUaEIYCRHPBef09Z7ET7r2OO/FvlzQiMfhT4ImcB1ghLTONpgyusr+AyOPfiFqoe5Z1EIwzTUZzSZ9MU6LfS+xdMrE7HxA3YyhC8VyCrrAgwfwI85sLaO7K6TfUPzS3MjVhq7m6KfoxKV2B1gZTuQhZ6Pt2152J4aotRc1bR4cDKsymVecFlpvzbciClCT1Dzs6RfXnKHYCWpXv+cB/oj2RR/PdYIFXmA4zpls+cXTfn/JW+nzSmxsYFMTvH9rXI0MVl1PCyT+1jX7Uc8ApuV0ArWoFCZp8rteKfK8gWEKnmtnYQfigChMF2CibbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPzEzqc0eYkC+HoB8B+lDeJYTSumZwHIoNdNUvkS2Jk=;
 b=I6JOX2uX4oZpE/tzDLvagRhqUcnsHxvH7IXCv4sP/eaqpPNbkDtmya8geIs2TVwryY7Lbw08DMByNF9jVflhVX0UkrQKpdOf6sRqBK24IzCGTh0IivR0MLBCnSJbhLkAGv9q56plUO0MgWrcyCYw3jOohdwXfe1WGpYnXL0+LGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by IA5PR12MB999299.namprd12.prod.outlook.com (2603:10b6:208:60b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:45:38 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 18:45:38 +0000
Message-ID: <d7afa22d-5a41-491f-b945-289ab78080e7@amd.com>
Date: Mon, 6 Jul 2026 13:45:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
To: Alexey Kardashevskiy <aik@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
References: <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com> <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca> <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca> <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca> <yq5ao6gtoncp.fsf@kernel.org>
 <20260630174216.GK7525@ziepe.ca>
 <fd135adc-a8a4-48e5-b649-2a29789b22d8@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <fd135adc-a8a4-48e5-b649-2a29789b22d8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::21) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|IA5PR12MB999299:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3f8369-2519-49f7-82e8-08dedb8ec58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	b+7fmDVqiO28LpFUt3fXwZ2IQovJZ/XNDzKwHa8eTuzvUsIClg2usZgLSfX63Fyc7m9mMKazqMjD9t9FOogm0Ga+jcklxW6JcjHJ5bpjwshiejNkZ1d8+EZS4EAGLvNA3YsQ9ZncYeOumQP/0I0zB2aJoGtXFEefJf8TI+TB94Mr2GRn0X/A/ynbI5M0t6OhTZbqZpDQqvDJ/+C0ZRAVEan8Ywt44f4Ig0mkUAitUA6ZHxCqtU8Rsndja2zSE+r6/0nAp15EpFrbHw8j3tHAD7dCJBLAyrX625MvE4C38eWyO3VOw/D9fRP6o9UDYQfjQwdT9j3d3hruJxH6GLInJW0pb0mZQN8Sxx8TzTJgQ6ddnjjboHlyaVdsTLcS7xmvjBAUkGErM1is1rnTBPHJN+HXCpq6fyugd8pBP+G1hGR8SiAq5eGI7uTHKwIXyVSy75wZHYIMIsF5BQLNnPIUmvysURNx3hiJA9OEV4d/e8HX7c/wXEExDUCYEIX2E+6eyhXneN76ir+o0RtfLW8YccTqAJB4UJ8uzEz+ZNz9aGPNHo7xjiM2CecVWSH6ImfOsbCSptLwaqQa9sRwADudtvC9BrGr7HkppKuZB3ghIUQrKOdZ3HvT5qtBNqNhLnn5SDUcBYgk352KHP080bYFdx/v/HHvP2PffUSa9rcC2Cg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3NTazhyZGIrTkxMdFZKenRSNlQvc2JLVzdzeTlwaTk1ZzdKbkFwNndCb2xK?=
 =?utf-8?B?VGR0cUtIZWFFMmE1ZzNwWkhscTJBbTc3MUwzZzM5aGlZL0IvOXE4dFUzeGFy?=
 =?utf-8?B?NXVvZlZITGRoK1Qza2hPcjdEYVlaU21hZVpociszcm5FOWpjMVltTzFzeDFk?=
 =?utf-8?B?Z3NtZzJTK3B4SFZrOFloOHVoWTZlSDFLeFFQZnJNRk82Umc1TEhDKy81Rncw?=
 =?utf-8?B?Y0t0RVZxeDFxaXJ4M0FyQ0dEZm1hcHlZOEI4WkF3Z1Nsd3V2K0ZnWEFRT1Va?=
 =?utf-8?B?YUc2eUExZDE2M0Uza0FPc3JDL1JWbnlXZ2FDVWlSbmEwNUtCaGlwT2FyTlFJ?=
 =?utf-8?B?bkdlZmFpZEdMaDBkZENFb0h1eTgxVTl2Zzg0TG4rOWtVL3hUWnBENnBXZTVh?=
 =?utf-8?B?SUlTeCtMR21ueXFQdUEyS0xaQ0xJZXo5S1NhNDlqZUk2VGNMRjhlTENxMlBq?=
 =?utf-8?B?aWpSbnF0NkphdW92clBVclcwNHdKaTNmR05JQnVBeExKbks3aVFSYXJFWnNu?=
 =?utf-8?B?RGx2bUJmVlUvY0Z6VFJzT1VzOUdocm13ZnFIVlM0MDdxblh2WVdPMXhnVGpM?=
 =?utf-8?B?Zk5oTzlHRlBSWGZJRy9QYk54U0YwMjF2REVIM0JWNWsyNmRjd0FuVUVjSVRX?=
 =?utf-8?B?dHd4RDREa0FMYTdqZk93eGNBdmdnQXREWmRMRjJPUjFnaTNxV1dvQWRhSVRF?=
 =?utf-8?B?RGlmaU93dVdoWmdIaFRMRS9yWGZKQzUyQ296bzNJU3laRnM1eTRNcFc5Ulkv?=
 =?utf-8?B?bjFuRGplSHRRcW9EenlDSGFFMHkxdnNYRi9uQ1NoOXBHa1NKb0hhMEdMSEsv?=
 =?utf-8?B?S2g0cFdrSnJTWFRxNTl3RmZlbjJOWS9LRjhoWjNmVmQyUFNFYzNwbzNDcXpp?=
 =?utf-8?B?eDhneHU4T3lwVWtocVlaRDJSN1ZsKys3RWdlaGJ3SWd2Yjh4cjVMSzlXQklV?=
 =?utf-8?B?TDRCUWwwc3FQTVUvZ3E1eG8yRTI2MCtsL0pERzVXd3ZwcFR1bVFyeDNKYi9Q?=
 =?utf-8?B?ZHlKbFNjeWszRkpBblM5OExwb20zWWJwVG16d2JUTzc2MXd6OXVjd21XcVVm?=
 =?utf-8?B?Ny81SmZXZWFvelprU3NGc1BPQlIyMG91REpNMHc2V1hRM2dnR2dhY0pYMlFG?=
 =?utf-8?B?ZnJvdGprM2V3K090MGRKd3JrUWNpWnd6MFBUdTB3WHlaWVJVb2trRTFTZE9H?=
 =?utf-8?B?YUVhaWFEdWtYY3hTMmg2TjBKWnJNTU1hYVVPS3JIdnF6V0xjNitMOTdzZ21F?=
 =?utf-8?B?aUxTT2twVUlUY1pVNjZSQkRkUVRQTTRkT1o1ck9NRVhsdnNmZDNkcHpTUEo3?=
 =?utf-8?B?Mk40SnZGS2JLYm45S0lkYmdHZUVvN0ZkVHBKT1hWQ09kUG5hMjNnS2tzb2hx?=
 =?utf-8?B?WkxGQ0ZaMmxsb2QxSHc5eHFGc2w5SFNsV0oyRi9xY29MSkg0a0llNmI0anJD?=
 =?utf-8?B?aFlIb25zUm5mZDMyUzlmZjZvRm11SXE3RXhRV2dGaGp6UmIzZUYzRW5uaVhD?=
 =?utf-8?B?dUVBS3daUi9qUXFFaE1rNE81Y052YnJtYXdvS3FUTXBZczBFZUZqZnNUTk9X?=
 =?utf-8?B?cGtGSHlJNDBVOGV0QlBlWEJpN0JNUUFRSExvenkydW80RHRGVW5PYU82bkcy?=
 =?utf-8?B?N3YzYzRFamprR0ZTdHhyL0pBSGRpYUhHa2U3NTZOZEhmSktLV1NabG9nRGJz?=
 =?utf-8?B?THB0S2FSTDJFRE5hWlpBMzg4Q3lxWHc5U21aYmd2TVVIYTFNbHQxSm1tNFVk?=
 =?utf-8?B?V2xiS2ZpcERzMXNuWWNXMElEc200OEtRaVNTc21pWkxGdlZVaENYRzFYV2xx?=
 =?utf-8?B?M0NjLzZsU1F4L1ZaS2JVUU9qdy9jSDhWWUVoalBaTlpkL2VMWGJGWFpHYnE5?=
 =?utf-8?B?aEhnaHpiVlVVQXZqZnBQY1k2djI2SXhCbkg2djd0Nm1EZEZLTVlKQVJCZjVU?=
 =?utf-8?B?Z08xc3JZY2k5YjRMMFFqN0xUdmxjQWtyU0VsNm5MaU05QXNqb0QvRTJudlQ2?=
 =?utf-8?B?VUNCWjQ2MzFRcHgycGNQU0tlTFNsUk94VzZDQy9hTGN2MXhoMHFteHJKTTB6?=
 =?utf-8?B?cTJiNlN0dm1NbGVvVktZMlF3U3dURXN0RXREaGU0c3pDbTE0alJmS1VTSGpJ?=
 =?utf-8?B?citsZGtCS0RtU3UybDIrdDNHdDZ4NHE0UUk5VlNSdUxyWkFCdGc0bmN2TkJ5?=
 =?utf-8?B?MXZzVU1YK0phaHZDM28yUm1RUGFPb0J0QkkzRCtXTVd5bmxjU0RsYVVpYm8z?=
 =?utf-8?B?SWlveUZ0SEpidGlFeHFCQTNkRXpldEZwOU1WUDZLQlRkVWJUeHNPVTNuR21Y?=
 =?utf-8?Q?ro6e85vkXOfNz2C6ZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3f8369-2519-49f7-82e8-08dedb8ec58b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:45:38.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPfh7CNLcVekbNIFLtkT+7NnqKeufVLg/+liN/XKorG8oJIBhzR2IxuubDtrQFVL5FwMSmQcMpRQbHDDvUugeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999299

On 7/1/26 20:04, Alexey Kardashevskiy wrote:
> On 1/7/26 03:42, Jason Gunthorpe wrote:
>> On Mon, Jun 29, 2026 at 12:16:30PM +0530, Aneesh Kumar K.V wrote:
>>>>> Thinking about this more, I guess we should mark the swiotlb as
>>>>> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
>>>>> CC_ATTR_MEM_ENCRYPT as we have below.
>>>>
>>>> The name cc_shared should be used for GUEST scenarios only.
>>>>
>>>> I guess there is some merit in keeping swiotlb using "decrypted" to
>>>> mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
>>>> gives meaning to on both host and guest.
>>>
>>> Are you suggesting to change the struct io_tlb_mem::cc_shared back to
>>> struct io_tlb_mem::unencrypted?.
>>
>> Yes
>>
>>>> IDK what AMD should do on the host by default. I guess it should setup
>>>> a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
>>>>
>>>
>>> If by low DMA address you mean using an address with the C-bit
>>> cleared.
>>
>> Yes
>>
>>> The current code already does this and uses the swiotlb pool correctly
>>> on SME.
>>
>> Well, through the force_dma_unencrypted() hack...
>>
>>> The challenge arises when we want to force SWIOTLB
>>> bouncing even for devices that can handle encrypted DMA addresses (more
>>> on that below). For such a config force_dma_uencrypted(dev) will return
>>> false and swiotlb will be marked cc_shared/decrypted = true; This trip
>>> the new check we added.
>>
>> Yes, because cc_shared (guest) and unencrypted (host) are very
>> different things and we've mixed them:
>>
>>>     if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
>>
>> I'm aruging force_dma_unencrypted should mean cc_shared and be
>> guest_only, but the SME hack breaks this.
>>
>>> We can also do
>>>
>>>     if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>>>         /* swiotlb pool is incorrect for this device */
>>>         if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
>>>             return (phys_addr_t)DMA_MAPPING_ERROR;
>>>
>>>         /* Force attrs to match the kind of memory in the pool */
>>>         if (mem->cc_shared)
>>>             *attrs |= DMA_ATTR_CC_SHARED;
>>>         else
>>>             *attrs &= ~DMA_ATTR_CC_SHARED;
>>>     } else {
>>>         /*
>>>          * Host memory encryption where device requires an
>>>          * unencrypted dma_addr_t due to dma mask limit
>>>               */
>>>         if (force_dma_unencrypted(dev))
>>>             *attrs |= DMA_ATTR_CC_SHARED;
>>>         else
>>>             *attrs &= ~DMA_ATTR_CC_SHARED;
>>>     }
>>
>> If we do this I would like to split the force_dma_.. functions into
>> guest and host, ie force_dma_cc_shared() and force_host_decrypted()
> 
> imho force_dma_unencrypted() should not look at the mask at all (the
> mask should tell the DMA layer to use swiotlb, encrypted or not),
> instead, when we set up swiotlb - we could make it unencrypted if
> iommu=pt, otherwise encrypted (although this means IOMMU and defeats the
> purpose of swiotlb). But at least this patchset has enough plumbing to
> have swiotlb encrypted, right?
> 
>> To make it clear there are two very different things here.
>>
>>> Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
>>> need to split this into two flags and introduce the resulting code
>>> duplication.
>>
>> The external flag name should be DMA_ATTR_CC_SHARED and only used on
>> CC guest. Internally that turns into using set_memory_decrypted()
>> which works on guest and host for AMD. I don't know how to make the
>> host only case clearer and still keep the code efficient..
>>
>>>> The dma api has to detect, after the driver sets the dma limit, that
>>>> none of system memory is usable when:
>>>>   - The direct path is being used
>>>>   - phys to dma for 0 is outside the dma limit
>>>>
>>>> Then it should assume the arch has setup a swiotlb pool for it to use
>>>> to fix the high memory problem.
>>>>
>>>> Similar hackery would be needed in the dma alloc path to know that
>>>> decrypted can be used to fix the high memory problem like for GUEST.
>>>>
>>>> I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
>>>> few key places? Setup with a static branch to be a nop on everything
>>>> but AMD, compiled out on every other arch.
>>>>
>>>
>>> If we are not able to reach the memory because of the memory encryption
>>> bit, then isn't dev_cannot_reach_memory(dev) the same as
>>> force_dma_unencrypted(dev)? If so, that is how it is already done.
>>
>> Sort of yes, but it is properly named to its purpose and not confused
>> with what should be a guest-only function.
>>
>>> x86/dma: Disable forced SWIOTLB bouncing for SME IOMMU passthrough
>>
>> Maybe as a crutch to get this series merged..
> feels okay but I do not really know the true meaning of "swiotlb=force"
> so adding Tom to the thread. Thanks,

With swiotlb=force all DMA would be bounce buffered through SWIOTLB. My
understanding (which could be completely wrong) for this setting is that
it is used mainly to validate a driver implementation (race conditions
between device memory access and driver memory access) and validate the
SWIOTLB implementation itself. I'm not sure why you would want to run
with swiotlb=force other than that.

In that situation, with SME enabled on the host, the SWIOTLB must be
mapped by the kernel without the encryption bit set and DMA addresses
must be provided to devices without the encryption bit set. This is
because if SWIOTLB is mapped encrypted, requiring the encryption bit be
part of the DMA address, any device that cannot perform DMA at the
address width where the encryption bit exists will fail to DMA properly.

Thanks,
Tom

> 
> 

