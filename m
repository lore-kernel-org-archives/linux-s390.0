Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982D3F99FD;
	Tue,  9 Jun 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002217; cv=fail; b=f0Dy+6Ja1FkeMReevQ/SVJT8F+BMKBmf4kEW/abjYAZxKWR2RrWh7Bar5k8u6KdqdwcK+dj5oYoI7MOGrlvc8qEph8GpxjljswESBRJBSzPmAPtBLx8+cH6x9mRUxV8DYlJER/suJlaxFonfmowySdzGNC0bfKXU1EGUYaZnvVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002217; c=relaxed/simple;
	bh=8CSS5rHs67eDcABqRumKNUCRusfcH45GW0+0TySuvDo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eths0OQTrp16T4CFcthrTkSsmRqsWyHTlu7zMgibJ6qkNMH7pw5CxaAWRYTHChtNrRmFwugG0+lUsOFTkqT6vxA6TiXG0qM7+KtqoFuDMvJyNNwOUQbpDn9+920rHZspbXRi4Lj8458FMjkUh7TB21ZqkuNQ5mf7lpDzxke3Z64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eYpjfPIx; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eYpjfPIx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTWNudhYWjfutfxTi/Hv+AXl2jSH0pSPyct5mBdAVlZvoPD/5iLh1a4VPCscTIlOvg/tDC1JMdq42TggPz+R6ymvxVTMStuOjot+rE+y7K9q2Vefe7QYHs1uF0fQHu+ozJKFfMn0sY2DOTEdi42tZg6+o3UpYTSFxvjdF1KNaWoEQCc39FnmX/n+OXxCVzjXNkMc+6zofaF3/REbveqS5vJMlydQZAj86DOsth2LBxmFwFRTlyGjiUb9rS2aI8sAYUykedQkbpW8Xnp6RwacshGmbra42WvAvKyvCGpvYz94H+NqM4vnzaAiVV6XDxUNqKi76Rd19oD4HOvKvfl2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibGxpec8CzwR+uSYcLZMIxVM/tHYqjR2DOTIM3yJJyQ=;
 b=Hfj/IA87NADGOn0L1tpFDHIkfvnm18PTk1Gfu+ACOYr2XEg6X7zmAsJi610Hbt6fb1ZSmjjqcrVx6dXtJ6ZTBQYAEy4RBuJb1adgruakdZPZPgLdeUNNcLmwpMFxDPb+N4u67wsPuoTWI0XwKr4F5x1SkX1RRQFdrdyn7pKFsy/SGaNt/3pORwxibhIRSG4ULevWJCCZMOH6A+HmPUM1inS+GWZgrFe31qFVR9rXaSCEiYBcqr14FkFwEQre05kDkBBz5JKISs8HWC9Wxsraxzuhnk1thLM65AW6mCscLEyj+1jMw9GIozy2sCzLjGS1IaYalNc/PbYuxnajSHWvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibGxpec8CzwR+uSYcLZMIxVM/tHYqjR2DOTIM3yJJyQ=;
 b=eYpjfPIxPRzdDjZ+EIwdzZcOKhWjTosvFovinANiqhhYLFy/P6rrmYY8hDeGHrAkfy5LwaIZxNcfCAnmU/z+F8V2piq/mcrwnPowXGvIFXmKrJHxGTctCZLBP3nJOANZy/QbNGzEz11FA/l0D2DPpWcX2zTOJAH/Mh2vgf9+XTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by DS4PR12MB9820.namprd12.prod.outlook.com
 (2603:10b6:8:2a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:50:13 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:50:13 +0000
Message-ID: <bd069b7c-696b-4e9c-b09f-4b3709f47ef5@amd.com>
Date: Tue, 9 Jun 2026 20:49:58 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260525154816.1029642-1-aneesh.kumar@kernel.org>
 <20260525154816.1029642-6-aneesh.kumar@kernel.org>
 <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch> <yq5apl2gsw6y.fsf@kernel.org>
 <yq5aldd4spyc.fsf@kernel.org> <6a1774dd80f74_19737610095@djbw-dev.notmuch>
 <yq5aik81sf22.fsf@kernel.org> <6a272cebec4af_4fa7810048@djbw-dev.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <6a272cebec4af_4fa7810048@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCPR01CA0023.ausprd01.prod.outlook.com
 (2603:10c6:10:31::35) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9268f2aa-d119-41bf-1dcb-08dec614e211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|56012099006|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	cf90o3uCUNn8bMsmWjmx50c++rg3iET/C11yu/nXxPP3ewv5+/yDkY713Oe4wRS2S9reZq1sXA2T3QIfBDBo4kZJ+DzZ9oi2ltJpXRwd1/3dbP0MreZaazuFpSN8XsKEcfWgLEiZRbqeGstFiCzPeeFfWXfLrYebARq9w6Wlu7ZL2Qh/21uLHfvrXWeb5jW14OzlV2kNqWAAftm/x6EhtpH2TwHGvcDm1BYTshXVxCQu25OCWzlbK3ta0da8ajFHGaOC/5xWhrh/XFdMrnb7BeS28qUTpDdNlfRVSybyN7ntoXiTP+LmzG3zMQB35di9AwC5HTCGSXBjUPS/OPC325EPrnvliIbaNHmUxKiPS+mdDEX9b5SXD8eqgKA1UDxJ6x+3A5TRpS9YWH+aiJWWW+r+6+S4QaW+hxmorkgdFuKp2tW5PdFXQ58A39I3laLH8enwRSViVm19QZcLadbBF32DdrR327hmQ4RV90ith/ospAhF38iwTTyvnB7pQK2VuW+/24btz50cjmk6vHaGrZLodnxccIJKgu4vL85LvfOht8Uk0qdALqRdyCkojIGxovsXFDTTYYdLjsOEGTYkhBOyrN1tF55u7LDdQxo3PoBH08o7ZZKXR2bac64WvfDZHjZdIcJB8vvVMU8yJRCsZaute9AhvUidbJzvWN8F1H/skz2hG2iRfWu5VgqU8vqrqj7NeWg4VqRtKoWPKbQ0tQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TncyaVJpK1N1OEZzY1lpMlRtdkcza2hWZFZFb2JMZGFWUnpoMVp3TGMyRHZP?=
 =?utf-8?B?T2dzOVJmQTZxb2grYkhuZVBTNWI2NlBEYnVCcXhaTVcvb1lLZEhvUUxscDBz?=
 =?utf-8?B?ZDFlZWZvZnN1L3IzdzJPZThTcjRGUFdob2ZxaVFlMm1NZFVYaVl1NWlucys5?=
 =?utf-8?B?TDV0UjdsY3VEOGVGd3NpdkFrbFhYQS9BS0l5bGlwMkVrcEZaUjM4VW5GOHNl?=
 =?utf-8?B?VUh4aEoveVJVbWZiYU5oODRkOU5ZaFRJOGV5RjI3UGlaK21xa0hQOGZQSEZQ?=
 =?utf-8?B?b0ZJSENOWlZ2bWJrZkVOUldmOHdqMnNSeHNnRDZUNE93SG56ZkVGR3lpNnp4?=
 =?utf-8?B?RTUyN3lEQWhsdExOblNGaG0wS3gyYW05TTBhV0YvdjZOcm0rVG1VU2UrZU8r?=
 =?utf-8?B?YlkwRXF4MHpsa21xTzVPVTVZQS9uNU13amFSV0FjZ0ZremdpZ2VzQ2pTUENG?=
 =?utf-8?B?TU1qZU5yU25SNWdjQlE0TzM1VWtwNFJ5TG5pdVlTMjFwVXBIeWg2WUNvdTd0?=
 =?utf-8?B?UllrS1FmUmFUVXEyWlRpRE5xckxzWXpCR1pyMmVxL3pJY1Nxdmx6QUtHeUFE?=
 =?utf-8?B?cVlVVmN6RUNFVUJNcUc2dWt1SmEvV3JWRnlJemgvQmwxNFdQYnA4cmk5NGt0?=
 =?utf-8?B?YTkzZTg5UmE5NXpzRkxmbkEvNFY4VndpbXorT0ZpTERHamZVQ0UvdzJkTkk3?=
 =?utf-8?B?NisyQ0lUbmJUQzRKM3VrUFNLL3NrU2ZlczZhWUlTRWtRMDhMYzlUNGw3WjNo?=
 =?utf-8?B?NXpiQzVWSHprMytFZFJ2S0prVE5hRVVMbkNSckgyUkViNWEwMzkvKzJtUFRW?=
 =?utf-8?B?cWFvZHNiMlRCQVY0amJhR0RJZ3FLdHlic09qVjIwS2duT0M1cG80K2k1QmF3?=
 =?utf-8?B?Q2hYM0VCdzBITnprM1JsakErMmw4QXExZ2dwNEt4YW5OWFpLQitsV2ZZbHFP?=
 =?utf-8?B?dWxlQ3pxdS90VlZFQnU1bHc4bXUvVS9iTVRzVHdod3gvUzhIK250SUZGdFli?=
 =?utf-8?B?SStYdGRGaDVaRjhxMDhNRDBiTzJDbVNiWGNpZUdtdDJmN1o4cDMzbVBvYVZz?=
 =?utf-8?B?c2lkVmVxQzExRmxzdURDb0FkTFB1aUlaWU9EelJzeExyL09QRElRSjloT0Nu?=
 =?utf-8?B?SFJ1MVhhbHN5eTZ6WUxuNkZJU0dzbXRmUE9CVGVBVFdBd1JURkxQZVFKMjdF?=
 =?utf-8?B?ZjZrRGI4NXlhR2o2c05iNmpTK0c0UGZmMVYraURWNklVanpZY05Ib0JsU2pD?=
 =?utf-8?B?V2hUUU1mRTlXR042a09qazRhZ0wwT0d0b2oxcjZWR1J2SGErN1lZQ3UvdzJ4?=
 =?utf-8?B?M1BheFFxZ09VN1BXR0E5OHREaXo1NkFqakMvRHlqenFvOTgvUjlLdjNpaTgz?=
 =?utf-8?B?VVZUcmEySW1pV0dYRGw3TFhKaDVrSTNCRHlpN1ZSNXJUdFd1VFY4bWM1MDdW?=
 =?utf-8?B?TC9ySHU1RGp0aFJPcnN2My9GMDJOOTZZSXYvbDUrZktZVmR2TGVRMjhWYjhW?=
 =?utf-8?B?UjhQek1Mam13YlQ0NW1EL2NwZVI0a2s4WVdHdGo5WXhybmVPYkhHeG0rSlVP?=
 =?utf-8?B?NEZMWmkzU0JoUmNkdXQ5ZlIxcDRaMDJrOUR5VVRsVFBJcXZXM2kwUU1abkw2?=
 =?utf-8?B?R0FRamVnUlJiNlFRMW9jR0FVQittalBqZEJpK0tlS3ZaR3lGU3VIeUdOUXRT?=
 =?utf-8?B?and6Tm1CM2xSL3ArVlFsanJmMjdvWjJVeUNVVVVHMkpOc3ZnclI3QVpPVHBz?=
 =?utf-8?B?SGxPbWxIT3U2TlFNQVdoVEg0UlU1aEtrUlVoVmdyajRGWDE5b3EvVFgxM1ZW?=
 =?utf-8?B?K1N3akNTbFNMbFVOZGIvZTkwVWVkRXh5Y0xwSDJ1cHRpVVQvSmRGTUlTU0Jx?=
 =?utf-8?B?bUErRnB2OUM5ZUJCK05QaGxvRkd1VW9KSTVXcFMzZDl3NWdMR0lVYW9tejdx?=
 =?utf-8?B?VEZFL3lQS09pNGRvbVVKUzBNemFSUENjRFVxb3VNWXhRbndkbzZranZlSHNy?=
 =?utf-8?B?aU81d3kyV1B1VkRNNDVuVHR0VTZGaGRRbjdSRCtWWENrYkM2TlZ3d3ozN2xN?=
 =?utf-8?B?QXI4dEhMc253TkJFRThaSjFnMlEybDk3bkFVdktxcXJxemNlWXoxbHZCQ1Bo?=
 =?utf-8?B?Y3BzWDNkdFU2dHROcjM4SEZmVm1HcnUwU3l5clJDM3c0VjQxUkFEUUZ3NS9k?=
 =?utf-8?B?M2Ria3BYQTZRSFErRWRreEZVVHo2b3UwalkxUDZLb05wNmMvREd3ekYrV3N1?=
 =?utf-8?B?UTg3WEtTakZJT3dDWkUwTUNGbDQ2R0ZyTTJZZ05qb2VwcGYrUTNzNzZtNm9h?=
 =?utf-8?B?MU5yMVQvOU12WVFPV3RCRE55c2ptYlNGRnV4S0dGOWFseEpYVm5MUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9268f2aa-d119-41bf-1dcb-08dec614e211
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:50:13.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj0eOriTIFDCFBQWwtCIlQJYqdXciabLdE7LBvfGqcmiB3jg+zp+SlCz6rbxIaXXEDdVcBY9gQT4IB2jXVO6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820



On 9/6/26 06:58, Dan Williams (nvidia) wrote:

> Aneesh Kumar K.V wrote:
> [..]
>>> I think we can wait to move it to its own IOMMU operation unless/until
>>> there is a need to set RUN outside of an explicit guest request, right?
>>
>> Something like the below? (the diff against this series)
>>
>> I have not yet integrated this into the full CCA patchset for testing,
>> but I wanted to make sure we are aligned on the UAPI.
> [..]
>> -static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
>> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
>>   {
>> -     if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
>> +     switch (tvm_arch) {
>> +     case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
>> +     case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
>> +     case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
> 
> Makes sense for any command that needs tunneling. However, see below, what is
> that set, and do we need a IOMMU_VDEVICE_TSM_COMMON when architecture
> differentiation is not required?


I still do not follow why making these arches checks in runtime, should be caught at the build time (ARM vs x86 vs RiscV) or at the TSM modprobe (AMD vs Intel).

The scope becomes just IOMMU_VDEVICE_TSM_REQ_SCOPE_TUNNEL imho.


> 
>> +             return true;
>> +     default:
>>                return false;
>> +     }
>> +}
>>
>> -     switch (scope) {
>> -     case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
>> -     case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
>> -     case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
>> -     case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
>> +static bool iommufd_vdevice_tsm_req_op_valid(u32 op, u32 tvm_arch)
>> +{
>> +     switch (op) {
>> +     case TSM_REQ_READ_OBJECT:
>> +     case TSM_REQ_REGEN_OBJECT:
>> +     case TSM_REQ_OBJECT_INFO:
> 
> The design goal of the netlink device-evidence interface is to be able
> to respond to all shapes of requests for evidence. So netlink caches
> objects that the hypercall handler can fill responses from.
> 
> It eliminates a class of commands that need tunneling.

+1.

> 
>> +     case TSM_REQ_VALIDATE_MMIO:
>> +     case TSM_REQ_SET_TDI_STATE:
> 
> Are these potentially candidates for a IOMMU_VDEVICE_TSM_COMMON? The
> handler knows how to do the arch-specific response from the common
> iommufd result, or is there TSM-specific payload beyond @tsm_code for
> these.

These are not common to put in IOMMUFD - it is either TSM (for TDI states) or KVM (for MMIO validate) on AMD and other arches won't share much either, right?

> Make it the case that guest_req only needs non-common arch for
> operations that are implementation unique, or where the response payload
> exceeds what can be conveyed via @tsm_code.
> 
>>                return true;
>> +     case TSM_REQ_SEV_ENABLE_DMA:
>> +     case TSM_REQ_SEV_DISABLE_DMA:
>> +             return tvm_arch == IOMMU_VDEVICE_TSM_TVM_ARCH_SEV;
> Right, this appears to be the only case where the command is
> implementation unique. The handler can only ask iommufd to take
> arch-specific action.

There are 2 arch-specific actions - one is calling TSM to execute actual guest request, the other one is notifying the host IOMMU driver about the device going secure. Like this:

https://github.com/AMDESE/linux-kvm/blob/tsm/drivers/iommu/iommufd/viommu.c#L603

I can tuck domain->ops->tsm_enable into my TSM but rather would not. Thanks,


-- 
Alexey

