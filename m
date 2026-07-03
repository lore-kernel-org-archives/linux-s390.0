Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3B38E8A0;
	Fri,  3 Jul 2026 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073765; cv=fail; b=QcRcmeoYQ0KIQLi1iDfLmfADavrCvGLe8e9oN8B89tHmFg8Bv31qE3KSk4eshYkkk+B28XLyjSDWNBBFR7s7+Qe/QG4qVejLZwjcnOjMopCJ0BxQwjbYYrXVob89dZUj5cc3irjNY6sofSP/QDrbO+LG5/Qlcc/mnpdSckYA1q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073765; c=relaxed/simple;
	bh=MOK8namwZuMFcbgqWg0d7cpI1CwMBDlDVrMUHYwp8GE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsXgnfY5uk6WS4gPQkviyUXHLI8WDtrEj3X3ageEOxLf9BGXJ/RhS1NmQmVXDqNUAPgEjirObiaH/yY+GJ+BIYpoK4PkVd0dLPvdfrkmZCTJWkG49V3RDi3hLzKhmTFZzNcmjF2KHd1ONu1UhqNMGY5EF/XJVpIDxWDQg/YUzsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UEycZv4Q; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UEycZv4Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oggyBYgpf0LgGqj0VM2/ibVSCa+uoObFCptdBTOseoiJeAMRMZfoUKiwC7dqeeGcxR/jspzQDbhQ5I8nDhHOyEkUE98RyMDS2nHYgA1hbOyAFuBdruJp8sWGA2HRT5vO+6Gsie5vYWmJ0aFwfv6cPCUE+1gm/UY58F4H50MIAi53AQe1GSLXZJyBDwFIdJUix5kXTM61LPiTB7SAX/rjwTPN5LIfKAoBUfJo3NN0CeBzz5g0yb8O7EIfeLJOvWhBwsUlKAzy7xrY74Dgfse8UtGPjKu7uVydNPIL61ZE9T4ktdM44WkJ2jIibeNt+A7KLn3iRrXnWoRz5OYjY5QRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBVMhNGGtTnLBZyGOG8H8b9TrV4fbJMm6cRAgaU9WDY=;
 b=ugGsr0SZn2ldjEOdCO0TvxfZ5lb5hnioRK/+bPZOjHfTVeYAW22wTtgW04D5BtQJG8bcxr6+eBRGjbxu5TJeqShdZDPk3akMi5wloywy8n0eqHIl8JdwJY5Id6a8l4zKJMJUKql3PhEKqSmHktGnodP/Of6wLP/rsPtgrPQF81nD7PZMnSYi+mTppHAesqel4oj1YE63vAaHMQa1ywhKDyw61HRpaLPsmGQjYGw67ArOpDeguq5AfK6f68ju4zJxl9HJBTKsmrOrffLVhfhGWOpHaEu3A/F7W2PbFK8msKDyN8RpKrNBT2yNT6T7mUjRwLO7fT+jauLf72jf4qGIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBVMhNGGtTnLBZyGOG8H8b9TrV4fbJMm6cRAgaU9WDY=;
 b=UEycZv4Qi1wa4Se+BkowHJj6ptewku3pXsIaNs4z4Eb87IcWXvuPl3w3uMRxxxIjUb+o5jGw7VO8QqYvDs9WMSXOBoDQu9gxmZ4S2eG/UvN0amU9EXpmu+cjPHJfKZs4rBaGmwxcAR8uXY2ouSorTzKWDIJsqcY3V8IOhQwO+Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:15:59 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 10:15:59 +0000
Message-ID: <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>
Date: Fri, 3 Jul 2026 20:15:49 +1000
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
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
 <20260702144729.GP7525@ziepe.ca>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260702144729.GP7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0165.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::15) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4c620f-8fca-436c-552c-08ded8ec1430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y7r87hAgRGbWF+BoU5Rwk0nsXIRRgL0NNBybQpriNyOJ7AAP9Ybdglt/ag7GOb+C9GMpdoamzlHl9c69WvqoZ+LiQp0JWEExkYpjbLhOLrlLcNtQcFjdHo7a46UVRf6SmXTazLu7MJO4ZEGQI1aZvnTvo75nnahaVySuyddGFoYcby5T5xO6q111AASYmmsItHw8ayvMD8b4D2OBjRJyoCzn6EfPJMzwt0clN8xe8+DTyDClC6C8xhgKZL4An33KCZzGyxQUpDA+xN9rz4LQiYgCCYwowBVXUELtv7HzYaSN38LHMKIE8/r+CauXRRavlgkMdonBz6rrIZN5eCYraO3etvR62ouND6Dfy8Rqq6MF8dzSHts0jxe31MpcQAwY+6cAqQxRX/NV54kd6tGO57ene15SDpXILOxS2xpAc+uWMOMqWfLxxt4Ot8WhPyCGHII+stH6fRSaI6QNk3wSnGJ4G5eAfPZLtQavqlMC3EDKCm3gRsm/JkR5jcooBQSSf22qk8X3tbJMVCG0yqDREnUIOAeH1vmKVSjet/igkwNipxfU6ryMpSNUmjRZ6GMF2tJoKSxoYbnJC0OE8IZx+iIIEpC3g67Bv4nrUhUPJLte4Ri7yj3Iio55PgT35GUqMyq4j+3XA/yZ3z2HjtSi9kI8t9RLiHYl7rMi7OEAAus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEE5L0FtUDE0bEIzVVAyOHVFck1YWEJKYkgrTlNyUko4UHM2UlZ6UkM5dmZo?=
 =?utf-8?B?SnpWT0hjMHVzUTlrMjVLT2V3VTZoM1NzTHNsc0djeGdDa2xvMjBSY1Npa1Va?=
 =?utf-8?B?RVFhd0MycStGcjM3QkMxUjdORlA2TGpaZElwbEhiTExBcFI3YS8zeWZzM0ZB?=
 =?utf-8?B?TmNIenJOTDhyN2pOL2RHZlFUcFJ6OFR3blBPUlJQMS9IWXZkRlpRK2JiQUNY?=
 =?utf-8?B?RGp6aTdQa1RVNzByR0VOODdwbVppb1g4eEZtRHhxcHo3ZS9pVEN5V3J0UXdZ?=
 =?utf-8?B?ME1mMFR2SC81a2pvV2IrZ0JKRmI2Rm4xZzY3YkJRNkU5cS9ZTWs4dWVMWExj?=
 =?utf-8?B?ZGQ2WVg0VzFuL0FsMTVNT0ZpRjU0K0VBTHB5K0xwSWdtRzJRTmtSQlJYL1JN?=
 =?utf-8?B?WGhzK2wrU1M1TUFVaDVlNmN4d1NpaWp1QjhHV2g1QXpZTDl5Ujh5a2pHakk5?=
 =?utf-8?B?WnBTUTVUU1IyM0hjdVJFL3RQWWV6UHArZndqZnVlV3NUTmhZOVE4cVNMa3Vv?=
 =?utf-8?B?Um50UVNiYWZJM0lRaUxmUlE1bWhyUU0xM1FzblVqQ0RPdHJ2U2QzWGx0SEdw?=
 =?utf-8?B?eElXblJkQjlmdGNWVFBaU01vVFJBUnFVRW5DcEtBK0tkR0EwcXJFSVRHR3pw?=
 =?utf-8?B?OFcxN3VOSk85Sk0vQVMwcjlFQ2NWcnBSd0F1Lys2dEFiWjJ3T1VxeDZzOUh5?=
 =?utf-8?B?UjhGVjdscHBoVnN4czBKNTdxTUErMnFtM25JL1ZQY3p1M2VWS2NNeDVNTXRn?=
 =?utf-8?B?SURNK0xKUCtrWGZiREt3R09pS3VUZkVvcm1SejFPWjBCVGVmcDdUWExlNnI4?=
 =?utf-8?B?b2ZLSjhVQjNyZUNSNTNFUEVoQmNpOGtCclBrSmVmZkhYUW1JdTUzV0NJTVRo?=
 =?utf-8?B?ZXE3cFRvNzNVd1NxNzNPN3psUFhXUy8zbktsMFJDTXNPV0l6UjVTckdMakla?=
 =?utf-8?B?bVpKSkNHTjgvbVE3YmxRTEJaZURlTVJGOXF5MU1rMFRhcVo1TS9tZ2pTUWdK?=
 =?utf-8?B?eXFpckhNdUpNTkJMdzZnT3Q4dE1MYVU5b3hCczJpUUNpUnVQR0dJRHJ6M1pQ?=
 =?utf-8?B?Ukxid3J4eTBNc2hGb1RqY0RNeTBqejUyVC9VZzg0LzNzL1M0ZlZITVd2aVZ0?=
 =?utf-8?B?akZWQVRtRVZXVnRydFZLM2RzSU9KaTZoVzBXR3Q5NEJDZjUxbVB0NUpUTlg3?=
 =?utf-8?B?Uyt1VXpteVpKekhwdnJxdUUwcEpqVUlieWdvMDM0QVVQQ0xjOTB2OUVDZHZO?=
 =?utf-8?B?UWM2TEdQSi93bFB0NmhGa3RDVUpwcGNoS3BRdE5ZaHpOZ3E5NExKVkRHNy9n?=
 =?utf-8?B?VWgrNDVHOHBnaDlaeEI1QVowbC9IY2RMcW9LbHdOc1libWN3QTB4VkFpK3Zv?=
 =?utf-8?B?dWFIQ1ZoVDJ3NHg0N1Z3WDZvK29lRFEyQlFtb0U5MDRZd2FXVklCQ2grWWNn?=
 =?utf-8?B?WVRwR3JMTERla05lcStLK3RQWW56QzBWTVZ1RGRFd3ZCSVJKOHNtOG0xSThz?=
 =?utf-8?B?b1A3YkMwUWVWdlE3Wk9MZGJmTUdzU3RWclhuY25nZnhzK0haWkRQYkZUK0RS?=
 =?utf-8?B?TVJ0OWh2UUpEQUtuaXJBTTRFREorSjJET2RLVnVqTUJ4RUFkL1hUYUc2WVZl?=
 =?utf-8?B?Z0ZLVkFlM2pMMXQ0VXNMcGZuVWRTQmliakNhZWt6Rjg1Q2J4K3lnSEZiMmdX?=
 =?utf-8?B?clhYWnFPaGNQQ0tBZXF2TEdEb1RFbmNwMXdBckJlQXpMZEFlRnErSGZncDdn?=
 =?utf-8?B?a3Z5QTZoT2hrVUtHNUlHL25rRUdoTWY0dUptTlNDWUNZNFlGTzc0ajM2WHFr?=
 =?utf-8?B?OTA4dUNyQklLQjRzaVNRenpVVFc1YWdtWVE5dWw2cmU5Z01oMDZvZHZobUtv?=
 =?utf-8?B?ZEtkcUdqMG9HVUxWa1h4YVZIdi9EbGtCSHB6L2lDQjlieXlUYjBuanRSS0tp?=
 =?utf-8?B?OFRwSjBRODdBYXZBZnBDaFJySFdtcDR2ZW9VckJjSFZFN3VBOUFRR3JlVzl0?=
 =?utf-8?B?U0JDN0pIRHNyVXdud2tPUCtpOEFacldSaUVTTWcvUG94YnRnTWRyTE52eFZ4?=
 =?utf-8?B?RGI1d1d6NDFaVmRaRUIyazJ1bmR4bCtJbTlrQU5UZ2ZlSEkxeWFRRnVGVito?=
 =?utf-8?B?U1V1ZDcvSkpmS3gyQ1RCdVRqZ0hVWk8vTWxFYVpXL2RpakNLaHg0RVNBUnB5?=
 =?utf-8?B?NTZxK2JLVEFJemIyYk54ZURETVZNcENRM2RBU3V3UW82Wis3YU9leGp4NzlR?=
 =?utf-8?B?eWFhTDljcEdRbzJhYWtDSSt6U21LT201QTRMelR6b2gvcmx6VDNDTTVGdklP?=
 =?utf-8?B?WWVneXg1T1QwNWR3MkhIeGg5emF5cmNxTWNTYllkaEU3TkltQm5yUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4c620f-8fca-436c-552c-08ded8ec1430
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:15:59.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzwBfwuFS/Shf2EaUGk5hugTlMbxb3ika7JIX0/7voBlCugtw1Eznw2wOM6zcYJr08Aqu9NLsK+c6+mYScreFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309



On 3/7/26 00:47, Jason Gunthorpe wrote:
> On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:
> 
>>>> not externally available so I'll have to trick the DMA layer into
>>>> using SWIOTLB (which is still all shared, right?) as I specifically
>>>> want to skip page conversions. Setting low DMA mask won't guarantee
>>>> that the DMA layer won't allocate a page outside of SWIOTLB and
>>>> convert it. Manually do
>>>
>>> Why so particular?
>>
>> aahhh I missed "pre-". I need a way to get pre-shared pages for my
>> sev-guest activities.
> 
> It sounds to me like you don't, what you are worried about is
> optimizing the dma_alloc_coherent flow to avoid fragmentation and all
> CC architetures require this optimization.

It is not about fragmentation, it is about unwanted page state changes when few pages are shared for a very short time.

When I needed these pages, I could: get a private page, convert, (possibly trigger RMP and IO PDE smashing if that 4K is backed with 2M), do the VM<->HV communication, convert back to private (and possibly unsmash the page).

Or ask swiotlb for these already shared pages, and skip all of the above.

How would defragmentation help here? It is two or zero conversions.

> So I'm strongly against you trying to open code something in your
> driver. Use the DMA API as-is. Propose general DMA API improvements to
> reduce the fragmentation problem. It is a real problem.
> 
> Jason

-- 
Alexey

