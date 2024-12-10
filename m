Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F178F5B;
	Tue, 10 Dec 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831381; cv=fail; b=ui4e0Tq2HEbdao67dgh4cftFPrkAVgX5MXXkT6sA3fgjHi/Fj6fSEAqSof3MeI9yD52C1TxfAyrctExhcXSLPv89VeCIL5FZeS0jMsxg8ltWAEM+0GsohVv0GjiZ7liHvN0XCj8kCCU88NEx7X/BSKQ2HI6sYUrov7d+bxyvgeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831381; c=relaxed/simple;
	bh=HbiQGsZqNePQBQvqtkmtiqJb6wl8sH1P+2x7eEtXVBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k6ls2c/WdpYKzlf4Pv00UBFbx1de49TQTOxJdYCuN02g/L8u/PVtTVr88o2UAOynjo3gHsMfgUPmPfF92eVJ0lnZMBXpF3yDpSbnsNsQeoyIyhNmXG+qHT5gwxG2mPv2ehOWeoOCJqxc+JplAPPf2rdpVNkIUw63UQ1xSj4irDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBHc6JFF; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBHc6JFF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRRRSevppqZZ8iK1VD+w12xW+Gujsi4jCWPK8+bxtjE3rpNwE6Ki3rLz/uAdAovlHHkK9F9eANMe3kiN7d81gJodckcW09BqSIFzL5hDZme5FggyYDQ5uhrZa05fM8nOc7bDQjxBmseHVUg4aPGGTAXRqzuCxzGzzq5NrPzIxUoGLcBxL/XwmYsL8+2qY8FmxRDDiqu9PZuvJsEqB25w6g5nftgIXjpmbdUAb2vnAXSrZ0fobO7Lj3UjVvWpk1DViqwDCAWBt0YbpxAwuJGI79Z4Z7OGWb/qynXKAJr7VnqPGkR0J+wXe3fdjqIMgbnP9QVBWhNCOzpCsCayecONww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/1DzRdw4i8US30b+bh4YMgOeQJMiBohofaUQFNJEuM=;
 b=PbAzYwqLmm9sriD707bb+cNjbQi0Puda3GWFzN2pJAsMQ5GtDlUzM26WQUtl096GylnvQPU5TcoOH55HENIumqilHxFCfFQCJEzcjAtZIhSzn2plZM1QRTTZEsKTByAlc7bRCk6EFY2hzVZQJ+N1CESnk0Y4WbMl6xhQV4GrHurdLwhS3jQlQImLUPc2PeuxmxiPr4hk0JDozxcVxtuCOjbWs9YUCCdZNCucqmn3iVTKcwKK7ibSKhimz7nGuhiIcGxOivpbe0h0iXWjFIbWkbYszYD+L4GWpaT9WskvPQ++vQmvzq7E4U4z7JaIobV86GDI2kSyGGEvxolQS7EJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/1DzRdw4i8US30b+bh4YMgOeQJMiBohofaUQFNJEuM=;
 b=VBHc6JFFYM2NsCI3aLWKL/KF+M1kk2PLSsmkh7MjkiCqIpKGZ4nFGT1MMjV77sAXhs2XURgGwxnNv3DtG+ER582uSY2GQQ2rRoKCQoavgNYUzEipKl9aqZb34XmywEtDrt4jEEwQRmGA/LO+0PIPtNRo3+xlt6eXZxluzfR5cgGC8NXE4Mbmu+S1I7egnLDYRZmN3Jsn9WAWcZGzjO22FMXvN+ahE/TtIojK0tnjpNPLvnMDP3bmQB9SBC0e4ZjDf4ohbbHcgeJsznebPqtOoeQkp/OFfHGJadGG0A0yg+gEPWm6sEbFYF9vtBgDTyC3qTUWu1JVcmPE52ChCWdONA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 11:49:36 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 11:49:36 +0000
Message-ID: <82c14009-da71-4c2a-920c-7d32fcb1ffcb@nvidia.com>
Date: Tue, 10 Dec 2024 12:49:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Transmit small messages in linear skb
To: Alexandra Winter <wintera@linux.ibm.com>,
 Eric Dumazet <edumazet@google.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Nils Hoppmann <niho@linux.ibm.com>,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
 <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
 <b966eb7b-2acd-460d-a84c-4d2f58526f58@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <b966eb7b-2acd-460d-a84c-4d2f58526f58@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0204.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::13) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 647253d3-fe7c-4bd7-7637-08dd1910b85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3dwZWxhL3ZuZHQvekd0d25ROG9HVGJGOEw1NTdWelpoSWpQS2NIRGtkUXVK?=
 =?utf-8?B?Zi9sS3pqK3BrOUxRNE9QSHZkd0l5MXFHM2lsM0Y1T0h3WGt5WUIyV1lpL2dv?=
 =?utf-8?B?YWF6c2M2dE82Q3FoSGRKNlZrUUI2ei9wRGlrRVlqalc3T0t1WTYzVWVYWWZu?=
 =?utf-8?B?T250RTN5cGZNZGlJNUpvKytraDVrNGFibk1pd0JRcTAwQjhWTmJ4T3BaSUpw?=
 =?utf-8?B?TWlqOFgvLzZ0NC9PQzl0MXFXRHN1QjYrMnZDeHphUzg3d1liSjRqKzVjS3h0?=
 =?utf-8?B?RExLTHpmLzBYZklSSE5yYVVlRkhlU0dnekVnVHlJTWMrRDNjQUc2NDVEVTU3?=
 =?utf-8?B?Y1dwNTI1Z1hMVnR4Qk83aW51NGxyOVR6UXlDcVNseFBwWDlOMDd2anBZNG9W?=
 =?utf-8?B?aGtDeFNreWtpSU1yWWh5Ujd0Vi9DblNQcitXVFVIU2E5ZFZYU21YQWlTMmg5?=
 =?utf-8?B?c3YvQ2M5SkVoME9UNjZHMWw0ZTFxaVNZYzI3VE5KODJlN1U0QXoxeEFhbHJC?=
 =?utf-8?B?dFBOdzBCZmhwTDJsblA2dWYrWnd3T3BNMURxMFo2aSsybFhwNjJJQVdPd2Zl?=
 =?utf-8?B?ZkNVUHZpKzdvc1loTm5FQ3Q3Z2xGTVZ6ZjRHN2Ftdmo1bGI5MUI1a0xuRjRE?=
 =?utf-8?B?WVVMWW9LdytxRzNWV05xRXpvZkZPU2srVXJkMGFNREl1bnVnNnB1Wno1T200?=
 =?utf-8?B?ekRoWXoyeGVpazZQQzBRV0FIa0xHOHRzcHUyL1g2d0NhbjBBSEczLzREVFFD?=
 =?utf-8?B?aDdscVREbElub3VXWlloVmI2eTlLcXRQSWJrays3bTI4RXE3VnlOYm10SnRU?=
 =?utf-8?B?bUxFYUo1eFZtWDAvajNCaTNCb1Z1dm9aYTA1STd1L2xKa2tJODhXMmNVRDY2?=
 =?utf-8?B?VGJLZ1d1UktodEpiRmRjVy9PTlM2c3RaTEpocjl0aDdlU1YyN0lGQnU4ajhi?=
 =?utf-8?B?cVlOOWM5T1pWbHd1alh5VC9zazR0V1IvVk1HMXU1WHFiYTJNbmViR1JVT0pq?=
 =?utf-8?B?c1V4SHZjcmk0Q3Bmd1NrYVNnZVFjT20rWFB5dmM1MUlhZzhadE5mNTNJZlAy?=
 =?utf-8?B?K3QweUdGbjBFUHcrTlQxQmQrZGdJS3g4OEc0TmdZUWFPUmorbnhyRzVTT2Ja?=
 =?utf-8?B?cjJxbkNFUy9SbTRXS0FqZkxZQ0J5RDlMWGNCczNYUkJPTGJveFcxRmZSc1dW?=
 =?utf-8?B?WnlPWGhCcnh2YzVrVlZWNW9iYlJQb3NFZEZBdXJxOUh3bC8vd2dKRTBNKy9k?=
 =?utf-8?B?WU5LVCtoNm9QSFUzU3kwKzhPbDhvL3o1Szl6NGkwTjk0RnZ3SWJMVkRYS0Vi?=
 =?utf-8?B?K1F1YVlKd2kvSldXaTRramExWEt3WUNZZjBkc3gvSUJvUGplTUh5MGE2RmtS?=
 =?utf-8?B?L1ZVY0NnNklSWThkL1JiOHg3eExKMTVRV0VuSThZby9DRjkyYXU2TTRaRGpm?=
 =?utf-8?B?VTNLRDNhRzBaUXdvMkxwd1lxbnVRUGZLV3paUWVRUll2N0NBT3MyN1hsYy9O?=
 =?utf-8?B?STZuaTc1dkZxc08wcWllazhraEp6eDFLWlJVTytrRTB4czVrVzlWSHNrN24r?=
 =?utf-8?B?YWl1ejNNUUJQdUxDNVF1a3NEdVlSS21MdTk4VTdvZDNpZm8yWm95NzhHSVVp?=
 =?utf-8?B?U0FaUkhpS04xeTdxS0NtSWxJR1VCUG9ITjRqZUdFN09nNXI0N2tDM3pIRzJq?=
 =?utf-8?B?NHNEVEk3YWNxeHIvam9sTjR6SzFWUXRQWXJ3WmtZcUZ3d1dhWUVnVnpibjRD?=
 =?utf-8?B?dmwyaGUxd051WXIrcDFsM09ZelV0Q1ZUeW9uQkkycnhpV3UrMlFsYlFrSFFp?=
 =?utf-8?B?THJNeVYzVlFZQzJjRFFHdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW9WWlFGVGM4cEc0WFN5UGpMVEFhTzdIZDZDVWliQ2dJWjAzM05WU0xFV09l?=
 =?utf-8?B?VUxjYXhYN3dmSkZJcVozdzF5WGhSbmFyMHpKaE1kYyttT0c4RmZsaG5lZ0hF?=
 =?utf-8?B?SXd6SzEySnpIZ2hUdmJsSE1GVHFzOWNuVDdrRkllYm1YcENlTTFRWC8zT294?=
 =?utf-8?B?MmE4QXRhOFJLbFkxOFpWRERiNENsVnJnYmVjUzM1UG1UUTBIeFFIZVd6eU5y?=
 =?utf-8?B?Wm5CUUcxOUU5OGtxS0ZwU1IzNDMwSXpEaEYzWlc3eVAveFRSNUNHT3orTlBu?=
 =?utf-8?B?MTVqWXVMVVQ5ZlQ3aDluc0pYS0FoOEk4QjRZREdqNktMZFFqUVVuV1dVVkx4?=
 =?utf-8?B?Ujg2ZXZtekRhWEROenNUdUJFMGxlait6Z05aa3BNUmFUVFBEMTZ2MnpxeWFL?=
 =?utf-8?B?YklGNlpIM1J0MzZSbE1ReHpRQ1AxczJjUC9iamU0S0t6TDB0SVRJancvQVZK?=
 =?utf-8?B?dVAwOWMrNHJNck9RSHUrZWpXdUUzY0JWdm01clg0Qys3bDhpbFdsLzN2Mm9C?=
 =?utf-8?B?eHpRUTl6MXhzdGEzMllCZG5WdHZFSlZYVWVoN2F6MnhYWEl4OEZFSFpCMStR?=
 =?utf-8?B?a1NvT3crUnBHZHNJZHN6L0pkVWFQMjVHRndjcjhiYUV6bDRRMW5UbnlkUEcv?=
 =?utf-8?B?UC9mbllBRjNNZHdRRzZsUW5iZTAvZUxWZ3lXZzhSOVVrbzYwaWwvdmNrYWhl?=
 =?utf-8?B?MjhjckhPQ0FjcFJpRDJBVHdVYm95RlNjR0FoNHRhaHk0NFBHakU2Ylhrb3BK?=
 =?utf-8?B?c3V4N1FISDFTQ2RtUTBBVzJqTy9nTVFhSi9LcUtyeHM4TDRla2xhZDJUR1Z2?=
 =?utf-8?B?d0s1bTh5RWZsamgxZHpLNzZROHpzTER6K1JYa1VucThyV0NDWDRqSW05RVk2?=
 =?utf-8?B?MFFmYzdTTlFYTTIwMjBjQndaZHp0dkpBUnBoTTRJaEhlY0tsRVA2dUljV2JN?=
 =?utf-8?B?ZFdqYVhmTlo5VXRzS2ZDUU9tTWdsLzJWTVQzWXJ6T1RBcUxaeU9OQ2NQYlJa?=
 =?utf-8?B?em1yZUVuV21CS09oYUhjODF6QzFBNk9BOVNTM3ozK21zSzFVdUgxQUZ3UUZ1?=
 =?utf-8?B?Rkd6alUyQzA0STZKMXpmY0E4WDV4TVd1Y1haNHg2WWk1T3h1eS9SbkhvbHVo?=
 =?utf-8?B?RGJqVVEyS1VWYytRNUFORnh6cXVFZzZxRitNUzZyUVlvdVBsN2FKamFVSXdG?=
 =?utf-8?B?eFlSdzVCa3BPSDFKemlRWVNrb201VzNPS2FMQzFtU2c3cjkwa3FaVFQ0UTg0?=
 =?utf-8?B?UlovcTYxdGFhTXlObFFvc3lSTXl1aUErRFAwZWtzeVkvVkl1OFpTeXJreUZn?=
 =?utf-8?B?Z2xTOHViZzdSQWY1V1Vwc3JXOVM2Rm0raS9WYzhndzFtM3FhQS9BWEY3WVpT?=
 =?utf-8?B?a1ZLWlpvcHV3eWR3dk1heFVEWURpV0NodVFSTzQrZDZjL3ZnWUpnY3B2L2t1?=
 =?utf-8?B?eHFCR3FDMDlhVW52ODlwSUJxWlNUYW1ualFSSWFqODdQNEdEa0VWSldRQXdD?=
 =?utf-8?B?ZEJ5bDQ1SWZ3LzFPKzIvQmZqeWUxZ1VvMVd1cVFic0U3eEw4S0svY2ZPbWhS?=
 =?utf-8?B?WHJsbWFHSTZQazNUTG1NWnAxVFYyVXlQNGo0YllwaWR5ZmpPTGZYcDBUVzRG?=
 =?utf-8?B?d0Jxd1hreGNEaDV6N3hMUzBpb0FLQmNlSlF2SHVWU2ZTOFRCeWR2cFFYTFFs?=
 =?utf-8?B?MVVMaEYzcnBSQTNBQkZqQkxkNEphUFRhOXB3bnJjUXdBUTJJNVB3cFJ3cnBw?=
 =?utf-8?B?cFdRblRKVEVOVlU0M1NSY2tRTFZHcDc5ZHE1T1RpaVRjbVBtZ3dtQmw2RzB5?=
 =?utf-8?B?UUE3WUIvOCtlVHFoaUpyNjlPT1h0UUdRWWI5aE1iUGpiZ1dZd0VBQjhzb0Nx?=
 =?utf-8?B?eVNlNWxKZnQ3V0lKMWFMTjVkZzcwbzlFaEZSY3FrUGdkVlE1MkRVdEcwMkJ2?=
 =?utf-8?B?YnJ3NFM0MDBZQzIxdkZQTVJLK2dRbFZnK3hKNFhCMW5URmJsOWRacUtlTU9I?=
 =?utf-8?B?K1c2TzR6YlF2cENKb29ZSUVGT3lIY3l2UDhVUG90VllaYmhWa05nSEV2Q1ph?=
 =?utf-8?B?WFRYRXdSSlU3aC9QWkRDKzd5eExKUmlJRExPdHZ5VVlzUVQwbUloNU56Z1BC?=
 =?utf-8?Q?ZCmJJMpau2eNbc7WIKy34ryoA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647253d3-fe7c-4bd7-7637-08dd1910b85b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 11:49:36.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fXtAxOqgJJc2GyeJ74TWKLtHMjl46Rfz4RYQpVD9ZayIzRQ4vlwTVmHBnoB4HuuJyIVnzBHAdliuAL4lpaFiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989



On 06.12.24 16:25, Alexandra Winter wrote:
> 
> 
> On 04.12.24 15:36, Eric Dumazet wrote:
>> I would suggest the opposite : copy the headers (typically less than
>> 128 bytes) on a piece of coherent memory.
>>
>> As a bonus, if skb->len is smaller than 256 bytes, copy the whole skb.
>>
>> include/net/tso.h and net/core/tso.c users do this.
>>
>> Sure, patch is going to be more invasive, but all arches will win.
> 
> 
> Thank you very much for the examples, I think I understand what you are proposing.
> I am not sure whether I'm able to map it to the mlx5 driver, but I could
> try to come up with a RFC. It may take some time though.
> 
> NVidia people, any suggesttions? Do you want to handle that yourselves?
> 
Discussed with Saeed and he proposed another approach that is better for
us: copy the whole skb payload inline into the WQE if it's size is below a
threshold. This threshold can be configured through the
tx-copybreak mechanism.

Thanks,
Dragos
