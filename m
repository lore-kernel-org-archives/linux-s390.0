Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4227603A;
	Wed, 27 May 2026 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840994; cv=fail; b=nBKZ5C+2e8k2+Zr8oKXu04fd3x4k1edLGtfEYjpq5ofRU95anYA2WdYWaI5AlB1gdf8N2rV3OkRJU8nQZHRvQRz5cJLR4CU6VDufj7Bs48YNOuw+1DBHIwGjiiV2RcZAAo3jBZFTyhpyEY0aNSYlP2xMAtzgJUEfWs0O71FBeRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840994; c=relaxed/simple;
	bh=BOERKevoyZKPmcK2uoGVwdy+4ROpYYPyzYHq6eTB2qI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pfWL2IrFcqAHrZITml/Gp5BUFSasf2Zz9AX5qHZMIyWX20j3mBxuCBUS9ySg39JvXnocHJWSfQbou8Ion8A5fgkQRg1sP30KQjHvpQE05ck6BZ717EfIJxgNUk5MDFWdrwWqs4+cd33PulgTaYPyJmg2HDC9kDNmSIrryxQl9JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LO17KrUN; arc=fail smtp.client-ip=52.101.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LO17KrUN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCq3yXWulsrJ4ziI2dSFyAeVyRpP3mG3MBflZMxtroNYKe+6DTqkRMpb7VqtVT2jLjBH8t0/SWzNBiZ1B+C6YJM31SAetbrPtE/ApP+cJzaCr4D36i8DRJFN1aTZayn94pmj+W0idOl1o9Hr+bP1+FG8pGEq1lGnjT7/UJ5Lxd9jS9DeQOm0JDpQvG13l3TY3EKWFBtC7lpU0VUoukXh3q+/MEZBJnfgf13sy6t7ro++Rzmq3lj4YxqPKAft3ANr4bo5nIKDMqdJF2laMKp3xZ8KFL+CEoBujUw2NsY5Ri0ow6YEWYBduphjan5jaUg5gbl+AKgu5/mzJzZcMO2dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r3WWln/QjP8KHLupD5XLn8+lnCZNNeDgCchFISW81Q=;
 b=n1gs3+7N4RIC+Mlai00BGtBz+OIwopqe1OtH0hNvHne++y2pQfvwGYGVCGUwBdgxFi+oZC3OjxM8S7Hbcoro290BWjGW3mOpadSnDJRd0Y+nmRMyXlmG1dXSefWA1ReUshPsNh74ZAo8iyPT/dZs/1C2bgiA3OZXW1hqv/h0PbzqLtMBX/H8Zhcz7gaeP673BTamstwa9QevPaATfXYXZTFv0usSB+2lofuywCyzmujCsILjewejo028re+i5JV2lvKWOYdTtzNmv2/7mgSisiwzKAwYq4dgIxlO9j8lpo37BzLx7MBnGYzlZIcHGCTvDG6bXunpc9OEbAZroZtaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r3WWln/QjP8KHLupD5XLn8+lnCZNNeDgCchFISW81Q=;
 b=LO17KrUNe7WFxGQX+hVBuLKNgB9kocL1EBYr2oL5MKRuXyIHMdQOCYn7P5+Y56TDEHtLCuMkkQaIfHbTRZ06DCbrLndAJFzl4sSSeBBcF5Sk8OdSp8CJepuFCnEaCatTa/AQfkknowXiy8UPJsDxgi9+MUMjtH5hlQGsA5KCd/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA6PR12MB999202.namprd12.prod.outlook.com
 (2603:10b6:806:450::12) by DSSPR12MB999237.namprd12.prod.outlook.com
 (2603:10b6:8:377::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 00:16:18 +0000
Received: from SA6PR12MB999202.namprd12.prod.outlook.com
 ([fe80::547:be9f:5668:4a5c]) by SA6PR12MB999202.namprd12.prod.outlook.com
 ([fe80::547:be9f:5668:4a5c%7]) with mapi id 15.21.0025.012; Wed, 27 May 2026
 00:16:18 +0000
Message-ID: <becd865d-09a4-4ac3-b719-4a0deae2692a@amd.com>
Date: Wed, 27 May 2026 10:16:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iommufd/vdevice: add TSM request ioctl
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260525154816.1029642-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::8) To SA6PR12MB999202.namprd12.prod.outlook.com
 (2603:10b6:806:450::12)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR12MB999202:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: 099d7d95-428a-4e9c-5c2f-08debb852c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|6133799003|3023799007|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dQijbXhWjiKYCbqpxJCQUTHgUmBWyP6vlb0DuERkI8B1/kFGq6V8WlESlGboFVz87/dl4zjCEB+CJ9eUV3p6kOlILD2hTWyWxxaKHpPfc2ObHlKC9lqZ8KFYFD1m5Zs++dXG0zWkqmDgU93qHQvH3w1fOJGwXLM0t+wBMsRrmYyX2+IOK6WRkCly+F4P2KI9XEbnUDGbJGS2s8ZPpu2FNKebk21WdYBr/fCu4zOdjh/S9sJyUV0f18cntNdbzU80MWbsv8a1X8WVTRi2/5x5MgYEKE7lD1FHq3bnz1Pay11JJPrWEwYGODU0KYfF6YWnoVR4IJjhIHO5J0zc9eNVd59A8t6SO37YDfsVt2jFuOHoQYaVKM8WRB742vVw/rlKfeO6p5sU5AtoolpNUMSns5pLxturjTqf3Vt6a36FpJb1HYz7UkDxiXCWY8LNSOpavrQJy8PV0E25oJBGTqcNzt1X893khEihsPZci3zfOe3Bk5aqZsKuA5N081d92NBxPqlEk8XWZsivBin+BUHFazB3oCr7KAPJgL/9BszeMfXsHRG3LLX7wnnRBbsHyy82TOXvQDIU3yW7poaTBN5dioPzJTnmqOag1JZdk22u+zOjW36XBO8ZbXQPcSNRtK6PdsW3NcUflUb9HMMEvTJk0JT0AgNhQEswhtb7EsmhZwDdxLrmPJXCM6n8Gdre0PJ8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR12MB999202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(6133799003)(3023799007)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWFOT0FlY3dQRkUrdkNocGNOZlZvQlp2UXN6ZEc2dTc5cUVTUHEvNEM2YkI3?=
 =?utf-8?B?eURENmtVSnpyN1cwbWdJbytIS0tZZTVhT0Mrd1ZFZGlrREg4MWNFdVQwVjR0?=
 =?utf-8?B?blNZU3BSQW9SZmo4N05qcWtha2hnMnZYT21PUUVBV0xCZ0h0MUoyNWYrWFRt?=
 =?utf-8?B?akZpaVRGQk1mU04zR1grR3JaMEwyVzFaVjliTXBtK1FFSzRjVzM2bDBjNGxP?=
 =?utf-8?B?c1RvTVJVR1VQNlFYY1pLRXdNRGE5UnYwSndlalNPb1VRNGEzdDlBN09RZWRB?=
 =?utf-8?B?MHpkOGprd01xVElLSHZ5ZUZaL3pLT2hxckRlV25oV2VnWGNSeGJVQkJqOFFG?=
 =?utf-8?B?VU9TeVRRUXRMdjJvQXk3WlIyMU0zenRFdDVWb1hDblBrU3JCT1liNGQ0OG0x?=
 =?utf-8?B?VlVaOExvb3FnMy9SSEtwQXVpekp5ZlRuVzloZXp3Sm4wVURaMUJwaWwxUjRL?=
 =?utf-8?B?SXdjNnY2T1BDNU1VWVZMNnpUM2pUK21nYmxPRDZEVXpOa3Q2WjlFUFAvL3Rv?=
 =?utf-8?B?a1BwanY1QUpnejNBUStnbUdHNEZWbVBVZ05sVjg5N2Z1aTRyR0NmMTJkUUVZ?=
 =?utf-8?B?YTdmSEk1V0tKRHVSUGxxYXlvTFRVTjdYY3UvbHNpcU03OGVoTkVJNUVJOTRU?=
 =?utf-8?B?VXorU3JDS3ljR21TVE0zSlB1TVQ3SGpGakJNVmdyMEF6cXNHcTJWU1AzQ3Nw?=
 =?utf-8?B?eDFaUjZIYkdwYjlpTk5USTQ1S2NvUzB4TlZuSzBXeURLNE5WQ3UvUEpDd3VZ?=
 =?utf-8?B?NmVKK3QzcHE4ZkpoYmg2UG8zZkFzWS91ZUVkbGtZVHpXdERiVlBoaHN0eTlo?=
 =?utf-8?B?aHRlWEZTQW8rcStLQml0SktFRS9oeXBLK0dzUUxGY0ljejVFMXVHSTRKNnBi?=
 =?utf-8?B?TThzNXZpSXh6UVBSNGp1bnMxbEFTZFJ6eUwwV1Q2REFYdkhJM0x6cFlvanRp?=
 =?utf-8?B?VWxTU29oYmMyQzFsWkFIU3ZCc3l5Q1hhVU1QcWJxQTIyVEl6bm1SNEEwZEs5?=
 =?utf-8?B?TUpWWWVacUJmRmcxc1RVZDRIUXhMTS9GZU9hMFN1SkNsb0VLZ3ZMZ1NuQzAz?=
 =?utf-8?B?ZUVwd3h1OENWc3pVWlNKSXJ6TmJvVmJFNWxVemFlSlBjTnhLVzloTHNmS3dk?=
 =?utf-8?B?S2cvdFg0dUlUN1JGMkN5UlVKcjFJV2UzaXNnd1dDZ01GbVl1NFY3VWMvWkZ3?=
 =?utf-8?B?Y3ZxZXJvem83NndDSlp5TEZrYis1NjNEVVFaLytMSlREUUJiSm9UWnRESzhB?=
 =?utf-8?B?MUFKdU15Rk1PZGdUN2pwSUhPbldWbi9TR3ppM1JJNUcwcmdDZWZubkRsSTdO?=
 =?utf-8?B?cGI5Z2docGliVHpOb2VZNDhLUkdEcCtRK0FiSlFCeFRpUXdZWG1sZEV3akti?=
 =?utf-8?B?UXI3WUxHWGRUcStJbXZIcVZERVZwVFE2VnNUWVo4UEJMck1leXFRb1BYYms2?=
 =?utf-8?B?dEt4b0l6MExaNm9lOW9LZ1NFbjNiR2FOZlR2a2RYYitTbk02UnFzRkYrYU8v?=
 =?utf-8?B?eDlEUDlveFFwTjZsZytJTU5acUlWdkNuenYwL1g5a3NuOWtiUEZFYVhEZURl?=
 =?utf-8?B?c0daYXg2cTA5akVlR0hzUkVkYVUrdWNmWDhRMWg0NU1xZVc2VUg2OExTbVFR?=
 =?utf-8?B?dkI3RGdKeW1ZSERFWkNVSHVRdHo3TUpqbUQwSUhwNjl1VUhqTWUzakZXS3lk?=
 =?utf-8?B?RTVzVzlxcmE2ZE05K21xcGRNRm1MMFdrajF0RFc0SnNrVkFwOVFOVU9TRENW?=
 =?utf-8?B?QkZ5MjI5QUNiaGhESnlRZ3NnRlJmVFNCeTJHaHlvZzRESU5zMFd4b2J2Tkw4?=
 =?utf-8?B?K1IxT2k4a01XcnNsY1dhNEphL3ZiUXAzb2R1TlVWRzFPVStFUHVZSUxaNm56?=
 =?utf-8?B?NndWblN5bTZJcVB4azkxSDBTS0trLzdIclNRaVdZZFFBQjdTMkh0Lzdlb09Q?=
 =?utf-8?B?cEVkQU9VeE1la2Z0YXc2Z0lZNGpocVA5dWFidGlFRno5L01veVhlWU5jNm5u?=
 =?utf-8?B?MTVJR21qQUZVZFZvSlh3dE9yV0pybzJZQzl5eHdBWXplVDNMZU0wSys5RWRB?=
 =?utf-8?B?OHNDUjQxelBrWHhDanBtSzQyMGlqV2N2aU1aeHI4bk1xZGFqNWxlQnptVXNu?=
 =?utf-8?B?QVFhSzQrM0YySG94VEh5L3JGZlRUaWVKanFRdURJN3prcno3YStqelhpWGZn?=
 =?utf-8?B?RUlyMnJPZFFPU2dkM2ViWDBxT2lPMVpCRFlOT25WdkhVMXArUDBCWUtUelRj?=
 =?utf-8?B?UlhxZE9CR3NXZXpQMVNPaWdqeFRvbDI5VWhONWpoam5pak4vVituN1RBdlhi?=
 =?utf-8?B?SmpNbERBdHluaXNFbVBaUlNQOHA3NkRDaExkME9DVUFXVlZBbXhGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099d7d95-428a-4e9c-5c2f-08debb852c3b
X-MS-Exchange-CrossTenant-AuthSource: SA6PR12MB999202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 00:16:18.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omw3yDAqoWr6rEhLXMBCV3o6Sm04mePage/n6cSGjH4Czafq0XiVjEZF+cMGj+GsuHbZFC2wpyV2I8MZo+topA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237



On 26/5/26 01:48, Aneesh Kumar K.V (Arm) wrote:
> Add IOMMU_VDEVICE_TSM_REQUEST for issuing TSM guest request/response
> transactions against an iommufd vdevice.
> 
> The ioctl takes a vdevice_id plus request/response user buffers and length
> fields, and forwards the request through tsm_guest_req() to the PCI TSM
> backend. This provides the host-side passthrough path used by CoCo guests
> for TSM device attestation and acceptance flows after the device has been
> bound to TSM.
> 
> Also add the supporting tsm_guest_req() helper and associated TSM core
> interface definitions.
> 
> Based on changes from: Alexey Kardashevskiy <aik@amd.com>
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   drivers/iommu/iommufd/iommufd_private.h |  6 ++
>   drivers/iommu/iommufd/main.c            |  3 +
>   drivers/iommu/iommufd/tsm.c             | 68 +++++++++++++++++++++
>   drivers/virt/coco/tsm-core.c            | 39 ++++++++++++
>   include/linux/pci-tsm.h                 |  9 +--
>   include/linux/tsm.h                     | 25 ++++++++
>   include/uapi/linux/iommufd.h            | 80 +++++++++++++++++++++++++
>   7 files changed, 226 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 8eea0c2c332b..0080895e9e92 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -701,11 +701,17 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_hw_queue_destroy(struct iommufd_object *obj);
>   #ifdef CONFIG_TSM
>   int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd);
> +int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd);
>   #else
>   static inline int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +static inline int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
>   
>   static inline struct iommufd_vdevice *
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index d73e6b391c6f..5f49b546ec92 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -433,6 +433,7 @@ union ucmd_buffer {
>   	struct iommu_vfio_ioas vfio_ioas;
>   	struct iommu_viommu_alloc viommu;
>   	struct iommu_vdevice_tsm_op tsm_op;
> +	struct iommu_vdevice_tsm_req tsm_req;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -496,6 +497,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 struct iommu_viommu_alloc, out_viommu_id),
>   	IOCTL_OP(IOMMU_VDEVICE_TSM_OP, iommufd_vdevice_tsm_op_ioctl,
>   		 struct iommu_vdevice_tsm_op, vdevice_id),
> +	IOCTL_OP(IOMMU_VDEVICE_TSM_REQ, iommufd_vdevice_tsm_req_ioctl,
> +		 struct iommu_vdevice_tsm_req, resp_uptr),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
> index 09ee668dbed9..342fbdb6a6b9 100644
> --- a/drivers/iommu/iommufd/tsm.c
> +++ b/drivers/iommu/iommufd/tsm.c
> @@ -60,3 +60,71 @@ int iommufd_vdevice_tsm_op_ioctl(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &vdev->obj);
>   	return rc;
>   }
> +
> +static bool iommufd_vdevice_tsm_req_scope_valid(u32 scope)
> +{
> +	if (scope > IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST)
> +		return false;
> +
> +	switch (scope) {
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:

This scope thing still needs clarification.

I have 3 types of requests to fit here, all go via VM -> KVM -> QEMU -> IOMMUFD -> TSM.

1) bind/unbind TDI <- moves to CONFIG_LOCKED, this is "OP";
2) start/stop TDI <- moves to RUN, this is "GR"? Right now I route it via "OP";
3) enable/disable MMIO/DMA <- no TDI state change, this is "GR" but which scope is it here?

thanks,



> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * iommufd_vdevice_tsm_req_ioctl - Forward TSM requests
> + * @ucmd: user command data for IOMMU_VDEVICE_TSM_REQ
> + *
> + * Resolve @iommu_vdevice_tsm_req::vdevice_id to a vdevice and pass the
> + * request/response buffers to the TSM core.
> + *
> + * Return:
> + *  -errno on error.
> + *  positive residue if response/request bytes were left unconsumed.
> + *    if response buffer is provided, residue indicates the number of bytes
> + *    not used in response buffer
> + *    if there is no response buffer, residue indicates the number of bytes
> + *    not consumed in req buffer
> + *  0 otherwise.
> + */
> +int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	int rc;
> +	struct iommufd_vdevice *vdev;
> +	struct iommu_vdevice_tsm_req *cmd = ucmd->cmd;
> +	struct tsm_guest_req_info info = {
> +		.scope = cmd->scope,
> +		.req   = {
> +			.user = u64_to_user_ptr(cmd->req_uptr),
> +			.is_kernel = false,
> +		},
> +		.req_len = cmd->req_len,
> +		.resp    =  {
> +			.user = u64_to_user_ptr(cmd->resp_uptr),
> +			.is_kernel = false,
> +		},
> +		.resp_len = cmd->resp_len,
> +	};
> +
> +	if (cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	if (!iommufd_vdevice_tsm_req_scope_valid(cmd->scope))
> +		return -EINVAL;
> +
> +	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_guest_req(vdev->idev->dev, &info);
> +
> +	/* No inline response, hence we don't need to copy the response */
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return rc;
> +}
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 3870d08ffe0d..c24886851f9e 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -8,6 +8,7 @@
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
>   #include <linux/pci-tsm.h>
> +#include <uapi/linux/iommufd.h>
>   
>   static void tsm_release(struct device *);
>   static const struct class tsm_class = {
> @@ -127,6 +128,44 @@ int tsm_unbind(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(tsm_unbind);
>   
> +static int tsm_pci_req_scope(u32 scope, enum pci_tsm_req_scope *pci_scope)
> +{
> +	switch (scope) {
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_INFO:
> +		*pci_scope = PCI_TSM_REQ_INFO;
> +		return 0;
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE:
> +		*pci_scope = PCI_TSM_REQ_STATE_CHANGE;
> +		return 0;
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ:
> +		*pci_scope = PCI_TSM_REQ_DEBUG_READ;
> +		return 0;
> +	case IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE:
> +		*pci_scope = PCI_TSM_REQ_DEBUG_WRITE;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info)
> +{
> +	int ret;
> +	enum pci_tsm_req_scope pci_scope;
> +
> +	if (!dev_is_pci(dev))
> +		return -EINVAL;
> +
> +	ret = tsm_pci_req_scope(info->scope, &pci_scope);
> +	if (ret)
> +		return ret;
> +
> +	return pci_tsm_guest_req(to_pci_dev(dev), pci_scope, info->req,
> +				 info->req_len, info->resp, info->resp_len,
> +				 NULL);
> +}
> +EXPORT_SYMBOL_GPL(tsm_guest_req);
> +
>   static void tsm_release(struct device *dev)
>   {
>   	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index a6435aba03f9..ec2236a7a279 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -4,6 +4,7 @@
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
>   #include <linux/sockptr.h>
> +#include <uapi/linux/iommufd.h>
>   
>   struct pci_tsm;
>   struct tsm_dev;
> @@ -173,7 +174,7 @@ enum pci_tsm_req_scope {
>   	 * typical TDISP collateral information like Device Interface Reports.
>   	 * No device secrets are permitted, and no device state is changed.
>   	 */
> -	PCI_TSM_REQ_INFO = 0,
> +	PCI_TSM_REQ_INFO = IOMMU_VDEVICE_TSM_REQ_PCI_INFO,
>   	/**
>   	 * @PCI_TSM_REQ_STATE_CHANGE: Request to change the TDISP state from
>   	 * UNLOCKED->LOCKED, LOCKED->RUN, or other architecture specific state
> @@ -181,14 +182,14 @@ enum pci_tsm_req_scope {
>   	 * to TDISP) device / host state, configuration, or data change is
>   	 * permitted.
>   	 */
> -	PCI_TSM_REQ_STATE_CHANGE = 1,
> +	PCI_TSM_REQ_STATE_CHANGE = IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE,
>   	/**
>   	 * @PCI_TSM_REQ_DEBUG_READ: Read-only request for debug information
>   	 *
>   	 * A method to facilitate TVM information retrieval outside of typical
>   	 * TDISP operational requirements. No device secrets are permitted.
>   	 */
> -	PCI_TSM_REQ_DEBUG_READ = 2,
> +	PCI_TSM_REQ_DEBUG_READ = IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ,
>   	/**
>   	 * @PCI_TSM_REQ_DEBUG_WRITE: Device state changes for debug purposes
>   	 *
> @@ -196,7 +197,7 @@ enum pci_tsm_req_scope {
>   	 * the TDISP operational model. If allowed, requires CAP_SYS_RAW_IO, and
>   	 * will taint the kernel.
>   	 */
> -	PCI_TSM_REQ_DEBUG_WRITE = 3,
> +	PCI_TSM_REQ_DEBUG_WRITE = IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE,
>   };
>   
>   #ifdef CONFIG_PCI_TSM
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 7b6df827321b..6101a2a1db61 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -6,6 +6,7 @@
>   #include <linux/types.h>
>   #include <linux/uuid.h>
>   #include <linux/device.h>
> +#include <linux/sockptr.h>
>   
>   #define TSM_REPORT_INBLOB_MAX 64
>   #define TSM_REPORT_OUTBLOB_MAX SZ_16M
> @@ -128,6 +129,23 @@ struct kvm;
>   #ifdef CONFIG_TSM
>   int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
>   int tsm_unbind(struct device *dev);
> +
> +/**
> + * struct tsm_guest_req_info - parameter for tsm_guest_req()
> + * @scope: iommufd allocated scope for tsm guest request
> + * @req: request data buffer filled by guest
> + * @req_len: the size of @req filled by guest
> + * @resp: response data buffer filled by host
> + * @resp_len: the size of @resp buffer filled by guest
> + */
> +struct tsm_guest_req_info {
> +	u32 scope;
> +	sockptr_t req;
> +	size_t req_len;
> +	sockptr_t resp;
> +	size_t resp_len;
> +};
> +ssize_t tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info);
>   #else
>   static inline int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
>   {
> @@ -138,6 +156,13 @@ static inline int tsm_unbind(struct device *dev)
>   {
>   	return 0;
>   }
> +
> +struct tsm_guest_req_info;
> +static inline ssize_t tsm_guest_req(struct device *dev,
> +		struct tsm_guest_req_info *info)
> +{
> +	return -EINVAL;
> +}
>   #endif
>   
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 66398efa31d1..7953e99a9671 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -58,6 +58,7 @@ enum {
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>   	IOMMUFD_CMD_VDEVICE_TSM_OP = 0x95,
> +	IOMMUFD_CMD_VDEVICE_TSM_REQ = 0x96,
>   };
>   
>   /**
> @@ -1373,4 +1374,83 @@ struct iommu_hw_queue_alloc {
>   	__aligned_u64 length;
>   };
>   #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
> +
> +/*
> + * TSM request scope values are allocated by iommufd. Each device-bus transport
> + * gets a range from this number space.
> + */
> +#define IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE	0
> +
> +enum iommu_vdevice_tsm_req_scope {
> +	/*
> +	 * Read-only, without side effects, request for typical TDISP
> +	 * collateral information like Device Interface Reports. No device
> +	 * secrets are permitted, and no device state is changed.
> +	 */
> +	IOMMU_VDEVICE_TSM_REQ_PCI_INFO =
> +		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE,
> +	/*
> +	 * Request to change the TDISP state from UNLOCKED->LOCKED,
> +	 * LOCKED->RUN, or other architecture specific state changes to
> +	 * support those transitions for a TDI. No other device or host state,
> +	 * configuration, or data change is permitted.
> +	 */
> +	IOMMU_VDEVICE_TSM_REQ_PCI_STATE_CHANGE =
> +		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 1,
> +	/*
> +	 * Read-only request for debug information outside of typical TDISP
> +	 * operational requirements. No device secrets are permitted.
> +	 */
> +	IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_READ =
> +		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 2,
> +	/*
> +	 * Device state changes for debug purposes. The request may affect the
> +	 * operational state of the device outside of the TDISP operational
> +	 * model. If allowed, this requires CAP_SYS_RAW_IO and taints the
> +	 * kernel.
> +	 */
> +	IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE =
> +		IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_BASE + 3,
> +	IOMMU_VDEVICE_TSM_REQ_SCOPE_PCI_LAST =
> +		IOMMU_VDEVICE_TSM_REQ_PCI_DEBUG_WRITE,
> +};
> +
> +/**
> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
> + * @size: sizeof(struct iommu_vdevice_tsm_req)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @scope: One of enum iommu_vdevice_tsm_req_scope
> + * @req_len: Size in bytes of the input payload at @req_uptr
> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> + * @__reserved: Must be 0
> + * @req_uptr: Userspace pointer to the guest-provided request payload
> + * @resp_uptr: Userspace pointer to the guest response buffer
> + *
> + * Forward a TSM request to the TSM bound vDevice. This is intended for
> + * guest TSM/TDISP message transport where the host kernel only marshals
> + * bytes between userspace and the TSM implementation.
> + *
> + * Requests outside the iommufd allocated scope values are rejected. Lower
> + * layers may reject scope values that are valid in the global iommufd
> + * namespace, but not permitted for a specific bus.
> + *
> + * The request payload is read from @req_uptr/@req_len. If a response is
> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
> + * response bytes returned by the TSM path.
> + *
> + * The ioctl is only suitable for commands and results that the host kernel
> + * has no use, the host is only facilitating guest to TSM communication.
> + */
> +struct iommu_vdevice_tsm_req {
> +	__u32 size;
> +	__u32 vdevice_id;
> +	__u32 scope;
> +	__u32 req_len;
> +	__u32 resp_len;
> +	__u32 __reserved;
> +	__aligned_u64 req_uptr;
> +	__aligned_u64 resp_uptr;
> +};
> +
> +#define IOMMU_VDEVICE_TSM_REQ _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_REQ)
>   #endif

-- 
Alexey

