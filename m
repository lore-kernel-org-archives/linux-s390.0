Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316401F3B8A;
	Tue,  2 Jun 2026 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389657; cv=fail; b=T6gkWqI1HXbAa3kTGlb4zjFY08gxq0so25QN1AFlhRKCKQf5rVG39dIS8vY/BUn71+bjcBLzkAXWIGTN9Ssic0JngaGUl8yNmtXpkb8xNeDb8r6pcVeGzTEnGeoihTF+34BEgZC4tLz7VZz5cDxeciNPOv32Umq1xN/1Y8L1qB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389657; c=relaxed/simple;
	bh=yZPiHqRX8EK1So1TIdYXzt+HroFIsy2TTYgk+gYKd3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TuT/D9UWqUqVL/lmq3nvJPw5asSfDZRCYVKWmXz/keGaEeiDejSGA+UdJv0RL7DKkceF36hmeCemXzf3FhKQdX7+aqs/QQ503JHZcDPCJs8eXOnXp9Ea8AUs8K+9kFNnCWMsdqbpSgpr9cbF2Jm2fE7l3YU/3tcxV3UC87pK5vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2QoeidLW; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2QoeidLW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyV9rNVazpEsu1jqFbuo3OuBZW9BEG8c5kX/53lkiIiyvqgtybFLhhGPvGYKWBom4JjQsIn2KcbNbxJufF5JJqnZSUmXvaPRhbSWOD9uNKbYUm0Q5WlXJ4a4yiXY4ELdqksRjg9hhizZ/+APyISjr69CU2dm5EqRXwCJkf4AD+COt0QrU7ENIm3/RniGmmBFQtqyeoZhtIv/qwtTW82TnlWjAeBcwPKQTVzQDylKNs/pRu4xn0VaijioUvNZizKGydCMoxxqJIM7WPcZnFzQ8NHiAt3YRhxVZHLMzC/iWsSTlpWytvZ2arMNKwTHYRYuvFicLAaEuGC0TrijNHuzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbF79Kva7slDJKE7CrwyYRAVnEU18jzWePo7D6jZfiE=;
 b=vqrf6FoLRS4iB8VWjh5UGrZWkdvRk+petR3JCpmyS9/SmCyVG8aKOvDGrywmtuP6ABNzO5CqxEt/vkkO9L2MS8dhyzpf+DdlynVV5AmWeUR2yZCbcZ/3SdAHz7fNnfkR0E/e9jRTllPlSThD7ZZudlmyDeFwTXkw/Hmz1FPOQJj7tZTuFsOnqK54YULWGAaaLqMs2zGfM7/Q4dcCtOqLCZKGGDdaoIFRhLy8HsGhAvGX/Z8q+Lb1vl2fGmvNlg83GtqDlel3uAPVyE39CBZDLrY/1SF90TBXhNYrS1rQhp2/cbUp5mDnPPV01OT65aOyXKEUljqk2rgwIaJSsvaeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbF79Kva7slDJKE7CrwyYRAVnEU18jzWePo7D6jZfiE=;
 b=2QoeidLWNhDG/jNVCc+c+BNOkeMQxS5bliR8XWgrDLYgkliGL8AMAfHwvdX7QrH78kEcYbTejXq5f2NHlO7CJt4W+E1zVaeuAnsKzZkzDPpWKpp/t7SzRbdjmF669/g50CdUQmz76tHyFLtJCMpm0LDE4jhgA3KyyMMxQ26mEcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by DM6PR12MB4219.namprd12.prod.outlook.com
 (2603:10b6:5:217::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 08:40:52 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0025.012; Tue, 2 Jun 2026
 08:40:52 +0000
Message-ID: <ea56cb07-6366-4242-981c-1cb25715747c@amd.com>
Date: Tue, 2 Jun 2026 18:40:42 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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
 <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <6a168c8ea7d10_2129b2100e@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0052.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::11) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: e5121517-8857-4de3-e034-08dec082a79a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	N1NxnoJhKCKZDMQKH6igORi4LYcMsSO2mINeP3zrbTtmeuuv8aGdzh10K7kkjKSYWIhRxD/JlbYtYHIF3LqCjoVe5sYaBdpZ1x8/PB6YaM40Fo6mMmNx+oUl3Rjqnds0Q0y6S6z6Bl5ZUSAzHaTvUuJDEnpLpuB2Ey3gd2I4QoRRiuG/AtD+q70v0qC+j7/jgAM9Z7+XlwjeO4LMX04o1fmEJoaF00VQp2Q2Qv5GPYTG9AbYPzdLhTtTp+i9tvWOQmEFVQLvsS4VjQXKyVys7O7Q28tTcTFNrVgDHMznsuC6Px1ki9aEmWzs/8LOdv82IRul8ekcCOwd60sygfu67dOvEuzliGFGfSkBSAH04KXGSq/dWn7Skd+Hk8rHH1wJHwUDpTBxRo5TMmvWJDs1GY5qN+ubo5pbVzSlSi6lz7nlAaATgpCcGJ4DPt2yXqXh7gaKptpB6RKloDYdrqNv2IFGVAozvsYbO3Z695mDcpFea9gkPNwCBGiqSKxwrM5d5HoKhxeLiUTfK36AYBfk5tmH3IHxNwkziXjqf5QwAkIriubFluBAiudwuI2L6V8S8/kPEujOG6o61TDZpzKBqVuNkFFsjD1eO+s3nWxzC3otHumzZfWOSqiJ4Wf38HxV8FczjEwH940vJAy3vSBArIkuKRbTDjbKZWOKPDeJ149mQROIeHFNVhlQtK1hXHv/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3FTSUdaSk9ya0ZHSnU1UWdZSjVCRUpZQ3JGQkVWTWxINk53aGhPZ3hkL0k4?=
 =?utf-8?B?dU9zbGEzenJoaGlsK0JHcjdNMU5DVXd4anQwTXh2a0FKNEFqbloraFNMTDEz?=
 =?utf-8?B?NEMxZ3l4RnNRWmk4NzZGS2pFV0pNWXZsUjFwZWZFRUVvYlk0ZjkrSWx0MVpD?=
 =?utf-8?B?SjExWEQ2K3k4UHZYZ2xoWXFIb3M1ZUgyWFM1cnVPQlhibm5SYk5UYjljMWYz?=
 =?utf-8?B?ZWszeHVXZU1mTEI3QkZBaDFpekZjOUIwUm4rRUVndEV1TFlwRHhWU2s1Y1lP?=
 =?utf-8?B?NHNib3ErTEZPVGJoY1Bnb1dxYmVVTGw2WTNKcGRYUmk0djlPZTlzZ3FRelQ5?=
 =?utf-8?B?RnZKNTJ3d3Y4NHdFVTF3WDk4V0hWYnV5Nllna1BSZGordytqSjFrTnNzMWdW?=
 =?utf-8?B?N3B5NERNK1JhbnB0bk8wWmVvcUtMaVZIbUQ4Q2xWb2tRSVgvM2VmdlZsbmVJ?=
 =?utf-8?B?aUdHd0lWd3dzNHVScXkwcHVobHRSOE03WjcrU28wQ3p0Q2gxL3g0VFlscm1p?=
 =?utf-8?B?UXNHZEQxalNsMlhEM053NHh0V1NNNWg4K2k2b0xuc0pDQ1JYTmcxT1NZMUU4?=
 =?utf-8?B?aXNVWmozeWlNOXlTOHFqM0FId3ZGSkcyWUlpTDhhdDBCQXVzazVQdTBaM1dp?=
 =?utf-8?B?UlZSamtiOGxtTVFUVms4YVVaMUR3cnFOOFl5bVVSZEJXSlZZQ3RPSDhyaHFq?=
 =?utf-8?B?Q3lNVkhMa2pmWjBoTzJzY2tCUi9JQldWNkpoTEpPRGF2clI1cVd4NElIZHdq?=
 =?utf-8?B?SDB1K280bjJLL2pPTE1xT05MaVpsUmt6NzJjaFZNWTFLRlFrQzZTWVFUOWpI?=
 =?utf-8?B?K0ptQUFEbEtkNXJFazBJSXVOZlR4dUwrM2JjM0l4bGp0aUlCMlVWQnkxaktq?=
 =?utf-8?B?Ly9lMk85OS9pOU5JR1J2WTlWRWdNV29yaFdVUk0wZkFscUtpMExYaE51RkJm?=
 =?utf-8?B?QkZKV2FObkErT3dBMTV4NkhRZlNGbVFrYTJUa1hzbFRBa0RaZlJNLzVMdEtE?=
 =?utf-8?B?WG5xcUZzK1hlMG1HRWdGOFBseWFSVjYvVUZjYlNka3M4RWhIa2FqYXU3UWh4?=
 =?utf-8?B?N0NYU0JEMEtkOEgxdVgwclJ3OUJuamEydDRJb3MvVVVZMC9UWmZta1hNclAr?=
 =?utf-8?B?K3FJcTRua1lJTkY1cFhqZFg4c2xZSHVMbEtSM1FLVW5YNDZ3QUNUS3BOMmR2?=
 =?utf-8?B?elR4N0xTOXVZNWRRVWU4emdnem1RZTBIaFNkd29xbUt4dysvNGJ5bW1oSE1R?=
 =?utf-8?B?cEJWT05VQVpyM0l0a3JIT3d4M3hLNWZzSTYzNzJnWXFNNTNBQzRwZ3NRTWpZ?=
 =?utf-8?B?YStXWEp3THc3NkZhcStEWUFkOG1mMGkrRFZPU2dOMkoyWEo5cU01SlNKeDA4?=
 =?utf-8?B?NmxmTXBSRGUwc1lON1ltUjRmdElHOEZuWm02QnFTQXEyV0NGb01MeCttWSt2?=
 =?utf-8?B?RGtBVUdNTklGYVJnR2hIdmtpMDVBYVBWN05IQmU3QWp3aHM3ZkxCY3AvWFE2?=
 =?utf-8?B?dFdNRkxYbnhKbHBYRjd4aFNMNEI2T04wS0ZQdm5aYW85TUJyWCs2S2djdmE4?=
 =?utf-8?B?UmIybjBCeS9Nd2l3RkhWUmpzbGFFMDM3NHhKaXU0RnJVVVordy80MjlTNDFy?=
 =?utf-8?B?aGhuSzF0UVprWHh2VDhZVjBhMzV4WU85ZzJ2bTROMGpxZDZaTHF3eWxEaWt6?=
 =?utf-8?B?QzVPR2RFeGRJVHVFa0tHNi9FU1gzUGQ5QVlFT3BXVE5hVURnUTVySGowQ0dV?=
 =?utf-8?B?S3YzNyswTVNlMEMxVUlrWStKRnp4ak1LdUVsMWE5OW10L2NhejBnTGE4SXd6?=
 =?utf-8?B?WGs1TTBleWNidm1RQ3hTSHdhZjZ6S0svWW9lVGNlcTkyK3lsYVpYbTZWQW1q?=
 =?utf-8?B?MTJxUXdIcWJ2MFRWMk5WSnNGN2k5M2VjZ3VRYmVwVnA4SXdPNGxWUU1TS3Vm?=
 =?utf-8?B?TElPSmFJQ0NrRDRqd0FUclZUb2Yza0IrdDMyYW8zWmpwS2pHZ29rdXNqUjVO?=
 =?utf-8?B?eWRpQlIrck1PWWtZcExLZE1pS2k1VnczQWdJNG1nT3NKaDZ6SUZncFBvcVI5?=
 =?utf-8?B?djFjZVBRVGhwcEZ4dm1Ua1Bia1pyclBYYnFRUVkvS0ZJcjFUcCtDeXdDZnR6?=
 =?utf-8?B?Wi91OGJURWFtRVdCS2s2Z3dZR3JoUjg4a0pHNmQ2TG5BN3RBZ2NlVGU0MGtq?=
 =?utf-8?B?OUNQWXh6QXhqYW9kZW55NnFlWW9Ca3dQQkNpaDJ0RTJiWUZuVzUrckFuZ0I4?=
 =?utf-8?B?b2Flcm1malFMM0lva0dGUGhIeWFzSkN2ZTBzWHZHd2w1MnlISDVoam9HWkll?=
 =?utf-8?B?cy9qdy9wT3k4YkNjVERCZG0zS0lEcjBFQnNIM3E1NmtFQUt4S1JOdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5121517-8857-4de3-e034-08dec082a79a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:40:52.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAkWqgsn6UfULMzf3wVhGxIX23tSyqxxZvOlNh56LWX5rySJWgi8E5nf51hshpC0d7mAFY+ijqffxKh4ru5apQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219



On 27/5/26 16:17, Dan Williams (nvidia) wrote:
> [You don't often get email from djbw@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Alexey Kardashevskiy wrote:
>>
>>
>> On 26/5/26 01:48, Aneesh Kumar K.V (Arm) wrote:
>>> Add IOMMU_VDEVICE_TSM_REQUEST for issuing TSM guest request/response
>>> transactions against an iommufd vdevice.
>>>
>>> The ioctl takes a vdevice_id plus request/response user buffers and length
>>> fields, and forwards the request through tsm_guest_req() to the PCI TSM
>>> backend. This provides the host-side passthrough path used by CoCo guests
>>> for TSM device attestation and acceptance flows after the device has been
>>> bound to TSM.
>>>
>>> Also add the supporting tsm_guest_req() helper and associated TSM core
>>> interface definitions.
>>>
>>> Based on changes from: Alexey Kardashevskiy <aik@amd.com>
>>>
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>>    drivers/iommu/iommufd/iommufd_private.h |  6 ++
>>>    drivers/iommu/iommufd/main.c            |  3 +
>>>    drivers/iommu/iommufd/tsm.c             | 68 +++++++++++++++++++++
>>>    drivers/virt/coco/tsm-core.c            | 39 ++++++++++++
>>>    include/linux/pci-tsm.h                 |  9 +--
>>>    include/linux/tsm.h                     | 25 ++++++++
>>>    include/uapi/linux/iommufd.h            | 80 +++++++++++++++++++++++++
>>>    7 files changed, 226 insertions(+), 4 deletions(-)
> [..]
>>> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
>>> index 09ee668dbed9..342fbdb6a6b9 100644
>>> --- a/drivers/iommu/iommufd/tsm.c
>>> +++ b/drivers/iommu/iommufd/tsm.c
>>> @@ -60,3 +60,71 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>>>      iommufd_put_object(ucmd->ictx, &vdev->obj);
>>>      return rc;
>>>    }
>>> +
>>> +static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
>>> +{
>>> +   if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
>>> +           return false;
>>> +
>>> +   switch (scope) {
>>> +   case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
>>> +   case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
>>> +   case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
>>> +   case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
>>
>> This scope thing still needs clarification.
>>
>> I have 3 types of requests to fit here, all go via VM -> KVM -> QEMU -> IOMMUFD -> TSM.
>>
>> 1) bind/unbind TDI <- moves to CONFIG_LOCKED, this is "OP";
>> 2) start/stop TDI <- moves to RUN, this is "GR"? Right now I route it via "OP";
>> 3) enable/disable MMIO/DMA <- no TDI state change, this is "GR" but which scope is it here?
> 
> The scope parameter was meant to enumerate a security model for classes
> of commands that are otherwise opaque to the kernel. However, none of
> the commands we are targeting are opaque (private specification with
> unknown effect). It now turns out there is no role for @scope for
> security.
> 
> Now a command family that iommufd can validate seems useful. As it
> stands this implementation aliases command codes across TSMs. Do we
> proceed with creating an actual shared command uapi for the truly shared
> commands:
> 
> TSM_REQ_TYPE_DEFAULT: Commands every arch needs
> TSM_REQ_READ_OBJECT
> TSM_REQ_REGEN_OBJECT
> TSM_REQ_OBJECT_INFO

These 3 are already in that netlink interface of the TSM (so common for all arches), right?

> TSM_REQ_VALIDATE_MMIO

SEV handles this in the KVM as this is where RMP and NPT are managed + opaque guest request to the TSM, I'd think it is the same for others.

> TSM_REQ_SET_TDI_STATE

This is a common one.

> TSM_REQ_TYPE_SEV: Commands only SEV needs
> TSM_REQ_SEV_ENABLE_DMA
> TSM_REQ_SEV_DISABLE_DMA

No change to host owned part of the IOMMU when TDX or CCA moves the device to secure? Or it is packed into those opaque requests to the TSM?

> ...or just observe that per CC arch commands are needed to setup the VM
> so per CC arch commands are needed to marshal device assignment support
> requests.
> 
> In that case pci_tsm_req_scope becomes tsm_req_type and is just:
> 
> TSM_REQ_TYPE_CCA
> TSM_REQ_TYPE_SEV
> TSM_REQ_TYPE_TDX
> 
> I am leaning towards the latter at this point.

Dunno, besides the DMA thing, these CCA/SEV/TDX types will only appear in WARN_ON of the arch TSM drivers and will not really be seen. If a wrong TSM driver is loaded (say, TDX on AMD), then something just went terribly wrong. Thanks,


-- 
Alexey

