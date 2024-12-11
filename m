Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72E1DDC28;
	Wed, 11 Dec 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938629; cv=fail; b=MojKdUfAkyY5koTjfKrFIQPuCc2aIpopoKe/jAkmNMXHDak7O/H96dG4Sv+q6SUgdd7iljYGCTlzsJQhoEvRqwlkYbu07KL9sePeBY3tS9EF6bJLQxi9KeOGng0OqG2DQvuRHHmycFkXnPY1PbhCBWc2lJtzvR+iMTbknO54eds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938629; c=relaxed/simple;
	bh=RVRRHTZ1JUPaic4YS3gBfRYCJ3MMLrKoGiqnH7xX+aI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ia+L2PKo6FexpYrMSnIeJq2bJCh1+drhoXQQlQYBoqQ3Zvw+oDMedRXMcRPoLPS9WkhA26/XnuAmMbR6Fh3GAp7zG6dHt7igY4nno6HUI2COiDdh709CXtXjKgiaiImeCEiZkky3LtMbXo5dUpBazZUjtPBjwzodvCE9/0mAByE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiHi7SR0; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiHi7SR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6j30iYayUajAHlQgAGNTq3GNpOWGaQlXolXYxmQC3oORcgYDpyHpS/1gN6W4F4i8KQPJchEM7AKK7inEwAaYRYTljJyWeh6iXV3c8V/oLIqE0gwPPs4x93TozVe8nxYANCXGC6Ddp4WKenIW1ppynawV295Y9Wr4StacK84SWmcyLJKrj444cBY7jwbGex2aMKv3mD5LUJoX6mAx9FdvqNTILrXmoEFFb7amP/BTA6O3DchKsyR8lKp5BqEEYY5YmdU728hrZlQquc6NOmm3pjIgUo0kQHmF7oyZtdVWg2NacD81m9d8LOxbxddX4xZaYiTuQwthT/wQaQC84xY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLkFy75HmlbMwZz8C/Qtshlc67TS/KFy4DvzTnd6JnQ=;
 b=JLC9T0j71OBgaIT+gL0UURtwGafx6GhNCDXlDZnPfJdZTWXXIUKnVsSJWRhAVbugfH81PyjDhsIPBnUlZk/8jtKttrVqrw0XrVkR+g7JdSbyaS/WQopptXob20lwjLKAFp6rtPWtt4fg8gtxuuLGf6u6ohYVK7jtDZMdWtTtsmXka/KKOKrEi3Lsb2NXbBDZ4P6j9R9AKpOgEgCNPUORWTJx0He6mp7HO+pqorK5ZklX3mSwog1onspqrJPNgPBHUAZy5Fqy6ufKDN6Gx30ocXH7FiKWiDYhJ2dbt70COw4rHLFRxFPRK5O9YTTpSCZBGz5P5dbfzGDpkyj+tFVW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLkFy75HmlbMwZz8C/Qtshlc67TS/KFy4DvzTnd6JnQ=;
 b=TiHi7SR0tzisYX7VUyY1RY+icQhI4fzEfsIH7yt+q59E6eebKX0zWkhKdXJqUYKniZwk+YH16IMNjVeQSuczvYhzdHypuIVR47KuZr3VK1JoCrdDbd7ZZp5xxBg+HzZ5c6AKbKNtk38LxYbmHAcaMmcgXsfqOhpsIhPcSn9xRZlM5JTos3a3IhL3rqWQ53OXMqXkEX4958P0yzkK8beCz0JJIQWaPEeAJE+Ld1D+wI1SAUexs9dzobkcjoQytwJpiDFhW/mJJVv92LcgGxs/eVEmzStbxMtGHyVaBk1wDC5/Mj1mxFf3/vIq8Mk9h658H+7GJbtfB1KCOPMNDMJ5+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 11 Dec
 2024 17:37:02 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 17:37:02 +0000
Message-ID: <77b2b5a6-13a5-47de-a6a0-e5aaf4e91582@nvidia.com>
Date: Wed, 11 Dec 2024 18:36:56 +0100
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
 Thorsten Winkler <twinkler@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <20241204140230.23858-1-wintera@linux.ibm.com>
 <CANn89i+DX-b4PM4R2uqtcPmztCxe_Onp7Vk+uHU4E6eW1H+=zA@mail.gmail.com>
 <CANn89iJZfKntPrZdC=oc0_8j89a7was90+6Fh=fCf4hR7LZYSQ@mail.gmail.com>
 <b966eb7b-2acd-460d-a84c-4d2f58526f58@linux.ibm.com>
 <82c14009-da71-4c2a-920c-7d32fcb1ffcb@nvidia.com>
 <54945b8c-8328-4c34-982c-9a92ebab5b1c@linux.ibm.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <54945b8c-8328-4c34-982c-9a92ebab5b1c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 98912391-e6ee-4ca7-cb4e-08dd1a0a6c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnhub1lJVDN1NDJNaEU4TStmNThYWG05N2ZnVlJrRzFHNzl2RkdiWFdmQXIy?=
 =?utf-8?B?RFViRGttdjI2ajlZdENKM3N3d0lXUVZ4Vll3dHdZSWo1TlE4UHZZR0srSnNB?=
 =?utf-8?B?VVRoNkVKeFFSRjFBVy9OaWZENlVMZUxUU0dZMm9KeUdrWW4rU0VLYWtKeC8y?=
 =?utf-8?B?MWgveW9SYWhZdTdTSmo3UFBRRUQ0R1RMTEVycVFpQTlOaDBKSGdhWllidElF?=
 =?utf-8?B?SDJacW1YbnBzM2N1QUNGL0trUEZoSFNJU0duS0ZXczRSd0tibXZjYy9oSzlv?=
 =?utf-8?B?RXVXME9xaXVqZ3Z3M3ZMNjV3ZkZTUGlWWm1EU1RJazF2K1BRZk1WWVl3QnpY?=
 =?utf-8?B?WFRFQW9mckprSzJjSUErN1BmYWlMR2JndEYvRDBteTQ1d0VxQWtjM1paTG5v?=
 =?utf-8?B?RnRFRGRPU0R3aXNWU0VWbVZ4MEJpWEtOdXlmcmdFYSs4NDRkZFFHaXlsbjJk?=
 =?utf-8?B?clJkby92TXdQc1Z4LzdKUTNxVGtqT3Z0dHRiYm12QXZoRFVDTExyZlZSVjZh?=
 =?utf-8?B?ZElQQ2NXenBKeW9vUmVndWpQdWRXOE13Z1RaclhJQmVvUllWQ1Q2a2pGRVhj?=
 =?utf-8?B?N2RSbHF0REx2Z0hLRVZaZnoxU25aVUNkU0FCWVJ6enpqWnBBS2pmaU1vKzBt?=
 =?utf-8?B?eVRtM1dpa0pXbWk0dHNzVldDdnJ1N25hTEhNbjhmWUdUUTY5c3JNdDhuQ3ZG?=
 =?utf-8?B?UW1GVXNrTmhnUWJiUC9WTEFNRlo2ckxtV0xSMUhoMWlHLzhBSU9wRHBSYVdQ?=
 =?utf-8?B?aHlEcVU4K3NiUWNJbU5pbEZiWnNkb09aRmF6OEh4WVBHTkhaMWQxbnJOUklh?=
 =?utf-8?B?ZGw3bFBZR2U3L1Q3bWQ0cktQbCtCZm9EdjE5T1pQTE1HOTFnS215UThjejBy?=
 =?utf-8?B?UVNXc2tNSEViMDJnbmtuaWhyNnMvanVMM0J6QWllcnhSMEh5eEpnbUgwdXBS?=
 =?utf-8?B?Q3oxaXJBeGh5WnZOaFlnUEUzUkw4amx2aFZLS2p2eVNVNXhmT2lNUDV0ckJr?=
 =?utf-8?B?Slk0SDV0MEZMNklsSWk0eHVzMWZuMU5pcTV3byttOUJ3QVNrUHlTaGh5NHdD?=
 =?utf-8?B?K3NMWFJkTTExcERETVZnWUQ4ZWxIbloxT1huUlpVSUFyN2YrT0QwclQvRlFY?=
 =?utf-8?B?WWlSSEM1SmxaeXl1bmhveWtuSFhZcUI5Uk9KeXR6QW1PZGgxdThOMmVMUU9q?=
 =?utf-8?B?NmZDcnpXQUZhSmorOTNJNU1NbDR1b1VDK1hVSHltS3BDWjhVeEJJeVo1YzZD?=
 =?utf-8?B?NmQrYVRVeldlMXMwSUNXRElQTk9FWFZJemZnWHkrS2N3TFJob3FXYllNWmNE?=
 =?utf-8?B?cmtIRDFWZWU5cUlxa25IMWJNaktuQWJTczh3bDE2T240T2hib3Rxa0JhRjFM?=
 =?utf-8?B?NWVVMEc1Nkh2YzdFYmJDdlBhUmhFRnFtWm9DY0hQZXhtbUxDZVNxWUtISHpl?=
 =?utf-8?B?MjRkSDNHUXdEV3R0RTdkQWxNZExQWHN5RVZ6QjNuemFPQTZDQ2hLRVg1T2J6?=
 =?utf-8?B?TjhtMGVkRGwrYXRaSEdiWFA4alFzN2k2bExLcGs4Rmk2THgzd0d6RTM2RkI4?=
 =?utf-8?B?N2tzNVc2d3lZSVA0dEVUcEhNVFkxTzlpcW93ZUhEUjNJaWhPTyt6NUd1VFh2?=
 =?utf-8?B?WnhkRFdnMm1NQ1RrRUg4Zndpb0RYZ09oRm9XRmJuSUtZUTVxU1BJV0lJYisr?=
 =?utf-8?B?NVplcHliTzR0ajFiYjZlaHVReWV3N3hSdVVVVVZHZFM5ZVVZb2dObVZ3dGRy?=
 =?utf-8?B?MmdUTENzVnlwemYzNmd0SHM0a0dLd3RqL1k5TVc0WDkybGVmRklONEdnbTdX?=
 =?utf-8?B?eFhndnV1L3R2dFFhWis0UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2txTGJSTzZZK3hSMk4vUGRtNFI3dXJsWUNLQ3NQTWxMU3NwRG91Wmp2bzVy?=
 =?utf-8?B?TWMwQmJwVCtyVlBpMGlXaHVhQ2M1MVpoZ2VsQWUxOWFDSkQ1YmdWZlpzdk1m?=
 =?utf-8?B?WDF0SmdKTVZQb3ZMV1FhQzdjN2tEbEIvNnBta1BpdGs5TENwNS9LN0YwdzVq?=
 =?utf-8?B?NDR0MTk3QUkxQmFvTGpzOVBjS1lYbTNpV21mVkllQ0dNVFpySGdtRUZYcllS?=
 =?utf-8?B?UUdGTHZKYkg1OU5HRDgvdUM1aUVWcTFXOWw0bis1NUQ2alFOZ1J3cDk0am9n?=
 =?utf-8?B?QjdlNEZZRjdzSHlES3NVNGZ0U25EMHo5N25TeHU0M2Jrd0UyMVRhQUY1SGhT?=
 =?utf-8?B?L09wdTlWSWRWdW5sblY2V05DeC8vRFVadWZWS1RxOFdtUWYwY1NsVHBCbTJZ?=
 =?utf-8?B?QVYvVGxxSTZndnozV3A1eDBka29RR3BIVDhyWGxva2lGOGNqWTBxcFNxRW9R?=
 =?utf-8?B?Wlp2UTFHWDQ5ZUVkbUg5VUF3UTZ6aXZSMkFsMGtXYWp0Y2NDNFl4ZmdnTkoz?=
 =?utf-8?B?c2pRZ2U0c0kvaTJjVCtHRTVDVXY4VEZHZzhCMitKZXJQYmhKQXhIajBwN2Ju?=
 =?utf-8?B?cnAzN1VrQkJBTUh6RjRPbTBteExhU0hYSFZXZk02RTJiKzMrNFZhWCswUjRB?=
 =?utf-8?B?bjcvemY3em9FM01pWUh6djg3dDdVcmk1SVNRWlh6eldDZ0JsWEpyRURxVUdR?=
 =?utf-8?B?bHFHSVlzVGRxZHZmcWdHMkJuU09MbHdOekVYb0FOUjVnbGNnYnFKY1pwbStv?=
 =?utf-8?B?aEJVK0szMDd0a0ZHNWVHK3JYblgxbHNXRVRKaHlFZWhicEFVTEFWTVg4K3VP?=
 =?utf-8?B?bmxFVUdKR3dIQjJuYWcvWnBXaThHQ09keWwzMDZpRW56cVpkVG9GM0F4d0xC?=
 =?utf-8?B?cmFCUUxiVzZOc3dqam44Ny8raVZ2b01TWWZ0RU0wUWtraXRzRGVYZDQ5TmhG?=
 =?utf-8?B?NVYvNExYL2RqejBUcmMrZzFtdnpNUm9HUmZSK21BUlpueC8wUDluWlBGa3Jy?=
 =?utf-8?B?bWhuTEU1TW1LMkcwelllR0JIRDZOZTl2Y0xjeXhCalZKT3FTRklQSWR6SUZB?=
 =?utf-8?B?dHpqYmZvWGhhL3VteEIvOXBhQThTR05GdjViOXR1aENmaXNuMkhMaVhwSzFO?=
 =?utf-8?B?eEh1TFhPWGx5UmJnTXNmL2N4aGpNcXhkYXlVQ2ZUaVdXRDU5dnkyTXFpL1ZT?=
 =?utf-8?B?QS9YSzdJY0ZRbjFJYUt2cFo3MjMxenpSRXFmbXpBcU5YMm1udlBKWDVrQ1Ez?=
 =?utf-8?B?dnNmYndSTkY4NDlnUXpGWWNEaHpkWU1HZ0JYUWxLOUx5ODh6OVRzT0dyc25K?=
 =?utf-8?B?dGRCM3UyYXhTelZON2Z3SkJrckttMjJma3R1OW80OE4xS0JUNTdGZTd1K0dO?=
 =?utf-8?B?UnhWZkRPWER4bFRuWDllTXlZRmZpOVRabzVjdWVjQ0pVYnByV25CRGNab3VY?=
 =?utf-8?B?NlBlUm9RWWowMDdBYnpka1ljQUFwQzVyVlNsOStMYjUvSytVWjFhMDR0SUVK?=
 =?utf-8?B?THQvZkk0eDduc2VTVlQ2Wk1zK2JjWnJRNDFuMEV6QnAxN3hjQ2lMemgydmZ1?=
 =?utf-8?B?TXlhSmpobkh3dlA4ckxIc0MzeFNDbGQ1bDZ2R3VrZnNuVVc2UkswVVVrZjQx?=
 =?utf-8?B?VEtnakpabSthWWRYOUlpZzlNS1lOTUxHQW9XN2grQnQrQk9UWTIrR0ZTUmY4?=
 =?utf-8?B?YjdpNVhkRmUxMHVCUWg1ajY5cTFDWHpwMHJhNVNybllWaUJXdkUvTGpQZitF?=
 =?utf-8?B?YzgxS3BKbUJJS09zMXZEVDMyRDhicWY0SVJKTFdqaDYvbEJwQ0pGZ0d4b3Rk?=
 =?utf-8?B?T3I0SkdDUHUxcExla0VkcGhHS3BSejh4K0FPOFBGblRFVzdDU2MvUGNaS09w?=
 =?utf-8?B?UVRBTWVZbjRhWnZZbnlUTHowZzl5Z28rYWVrbEVsR3U5OVc0eDkyMDR5MkNN?=
 =?utf-8?B?ZGpnc1BiVFBnRUowR28vMTlLTnpZb3lUeXc0UzlYT2x0OTVLb1pNaUhwNEh0?=
 =?utf-8?B?VnppVHlVQ2RnYnRqb0dpaUw2V0RJeWRKWUlsT0swcVVIQjRsZVVuZHBHcGRk?=
 =?utf-8?B?WVY2Q2FZczYwNDlrMkdUc1BhV0R4emJIckpEVzBmbitaV2M0VUtTMTNXS0Mr?=
 =?utf-8?Q?lv7RA9R+wYzNwwYmg4Pa86QSL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98912391-e6ee-4ca7-cb4e-08dd1a0a6c3a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:37:02.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0McUm2xd+2Ipo0p9hfU4lDT/CA782inRPJGIO3f8PfMEG+7t0WmrgnUQ74w2gjy0pZ5jWm0vXnL4b6lVFdqV+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

Hi Alexandra,

On 11.12.24 17:19, Alexandra Winter wrote:
> 
> 
> On 10.12.24 12:49, Dragos Tatulea wrote:
>>
>>
>> On 06.12.24 16:25, Alexandra Winter wrote:
>>>
>>>
>>> On 04.12.24 15:36, Eric Dumazet wrote:
>>>> I would suggest the opposite : copy the headers (typically less than
>>>> 128 bytes) on a piece of coherent memory.
>>>>
>>>> As a bonus, if skb->len is smaller than 256 bytes, copy the whole skb.
>>>>
>>>> include/net/tso.h and net/core/tso.c users do this.
>>>>
>>>> Sure, patch is going to be more invasive, but all arches will win.
>>>
>>>
>>> Thank you very much for the examples, I think I understand what you are proposing.
>>> I am not sure whether I'm able to map it to the mlx5 driver, but I could
>>> try to come up with a RFC. It may take some time though.
>>>
>>> NVidia people, any suggesttions? Do you want to handle that yourselves?
>>>
>> Discussed with Saeed and he proposed another approach that is better for
>> us: copy the whole skb payload inline into the WQE if it's size is below a
>> threshold. This threshold can be configured through the
>> tx-copybreak mechanism.
>>
>> Thanks,
>> Dragos
> 
> 
> Thank you very much Dargos and Saeed.
> I am not sure I understand the details of "inline into the WQE". 
> The idea seems to be to use a premapped coherent array per WQ 
> that is indexed by queue element index and can be used to copy headers and
> maybe small messages into.
> I think I see something similar to your proposal in mlx4 (?).
I think so, yes.

> To me the general concept seems to be similar to what Eric is proposing.
> Did I get it right?
>
AFAIU, it's not quite the same thing. With Eric's proposal we'd use an
additional premapped buffer, copy data there and sumbit WQEs with
pointers to this buffer. The inline proposal is to copy the data inline
in the WQE directly without the need of an additional buffer.
To understand if this is feasible, I still need to find out what is
actual max inline space is.

> I really like the idea to use tx-copybreak for threshold configuration.
> 
That's good to know. 
> As Eric mentioned that is not a very small patch and maybe not fit for backporting
> to older distro versions.
> What do you think of a two-step approach as described in the other sub-thread?
> A simple patch for mitigation that can be backported, and then the improvement
> as a replacement?
As stated in the previous mail, let's see what Tariq has to say about
doing some arch specific fix. I am not very optimistic though...

Thanks,
Dragos
