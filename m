Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A93BFAD4;
	Thu, 16 Jul 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236272; cv=fail; b=drS+fx2Glp2lXUgeARHFfazFpYeJLEBt5OBIu++VDchqibN746PxM/lm3ayx1sMODrJybqxC44TCOyYty573yGdTenlVJfVhTMAHj+/P6qDoFX2CMjgeITvAB4OutRgEunf++S8kwnXlcPghVK0cy+qwUVb4VGs5uYs1ondlU+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236272; c=relaxed/simple;
	bh=bPPrF4aJCznBQMoDLeGmikEjeCLjKhW236VdluCaMwA=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=ADfJ2dKy8FjOkRGGNyf+/6zaf/+d5dGHey/PuBp4q+KNsuy3RTp8w1W86SoervbyKX9EQ3dAEkDJoPsO3mzRVgbUilFWeLSJC8gnkPJP9Dp/FPVB4SYXfC2UA0gKK3K4LAzux5xRW7aS+i4d/s2c8BDV44WQP523BJwvU7z5rP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YGeayh7A; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGeayh7A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIhWNJy0CxheW7ghnzIwCFOob4XIOUQnirYwFuvlvPrNQRMD6FlBhTgemchn3ZQYi3qTfzUCDYxJXcQ+8/FlLDnya42gQI4DmzxqgjoF/e8OcTgJZ+lHKKZrc3w1gTFhw6uiHFZrIzUERx1RkuUk+PS5pR9jtFMIFc/s5YZ0OTpN0vYdv9tXzE7Pexo03EF4INUAxJRdLZdw3Od0OkIQDCb73GYu35V3qMvF+rxmYuc6bR0jF/ji3UFTQXusWFLQYZfdcQr6q+Su/wKsEIksNvDidysloRjaZzhHSBGtbbsdeYyn0TwYYbBNpw28HRbPeDVYSU3s7o934kjJ26F9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TURODzLWfdqxRaUKipXe/jJvez4m0lmehNX4k8OxZdw=;
 b=kNh9WeLU4CrmK+/WmPWC8KrbmSymjTUC7wiK+ET9nL6V2yZcIzwsoDNg6viacKzA9wI3e6uwzrWS+k5ads+zb6Ln0VE1Brs460RGAxzIladVMPvMl78onsU2DP4p4/oRQkz515m3Ok04psbkLZVLn45pUbYtQ8gABuiO8oyQS962iDEtO1QiT+vtL23OGmJZ0wTG3IRqifCuxvAqT1ZcfjPZ9kqERlEocJRI1Ya5uRRmNn4nwo7WCOA9/qBhwegjPTLA0ZKwQ282DmcRlIxrO5ur016vQs2LcZpuquBVROSWfPwQPJ5cyMvEQrA/faUfrVlDBEyOPOPnwhoYcvblZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TURODzLWfdqxRaUKipXe/jJvez4m0lmehNX4k8OxZdw=;
 b=YGeayh7A0UPiYR8K5VVwth+duuoDRCyUfmqOyMuP52AjuWD0hRv0siKzzHnn/ib5zjw4KQBFTB7w5NFWCsxwOYL6n8MAw3ggo4O4DFRXUKumPpQrIKqNP7cevyT+iIkbNySThkF0kVBL+BDcz6/bVubgAfcIKugpbd35Yow+2Gm1EURMQe2wwtp25iY2RZBUICFzxMmq1//XbWMjke5fYwhzPkXBKRnFtcFMJpGYGeq2gKfMowlX/o0l3sq2NB4WgPDoyY0WSCMfhLNVk/f+E8T11K4WMCg68nUo2YsFx0OfW4jxEk6Q3PLNXuJH3BdM4NaFz6SVBL/2XcCpIXPNWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:11:08 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:11:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 17:11:06 -0400
Message-Id: <DK0AYXAPZJOE.1G174PZD8NHLA@nvidia.com>
Subject: Re: [PATCH v2 01/10] x86/mm: drop order parameter from
 free_pagetable()
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-s390@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andy Lutomirski" <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman" <jackmanb@google.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Alexander Gordeev"
 <agordeev@linux.ibm.com>, "Gerald Schaefer"
 <gerald.schaefer@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Oscar Salvador" <osalvador@suse.de>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260716-bootmem_info_part2-v2-0-4afc76c73d61@kernel.org>
 <20260716-bootmem_info_part2-v2-1-4afc76c73d61@kernel.org>
In-Reply-To: <20260716-bootmem_info_part2-v2-1-4afc76c73d61@kernel.org>
X-ClientProxiedBy: YQZPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4687d4da-d3f6-40ad-f91c-08dee37ec189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|11063799006|4143699003|56012099006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	QFyQbkbGMMaW394GnvCsUlSxn2YD4j3lC3I0gG0InWo5Xo/MUemp7SKXDv/0lEcycDRcu3gywxtO9mJK89nDjdDPKmxiRvv64WWr9uQJdN2IkHZz0bpRqYlPQhl70MSrXz95EL63QCVHGWvemTnq8rRvCm0ckWYzjpieS4Pe5Vq9MseXsxO18XwhvwOnKhwm4NsQAGnIX3TMzBMbXzNXcn4I7FWqvPdjD3rrHlg8fgBaXp6OjW1E/hDfaSJ/Tg89LVvvMULUoGRlZOQ6NcWDIOEpfZav+oOlSS/K5c4xaHc7+ZCRZgFpZldN9rBc0gvEs9IL0rxeWOKCF70Cov33dAq5PrbMqOGnebPnLBiPVh2Sez970SiMIAXGc0ESF9TIVtny1Xn/izvQ1chYLp6tmTAUfE4z86XriHd7HMGsg4UhnAdqVUUFPPu25WrhdDmN7QVW+lhoHDNXOwijEadZcZzX00QiX0Om/JIKiLSSVy0hijOoZc4c24vh5uWnFZVGvRxWKRaC0IH/9MjW/v9+76al5+lA73Bb+O4CBbkprDTxqzj7j05+ogWbCavIIO5mxwxBRhGkfu5Q6GHi/G2YLdjdoDsBOgrYTA09bJe/p0yJ7xQzou2K4gZyrHCaQYMcB5+jqY1BhSTcHP8oiU4qKdpMqUXVGL6WUg6v9hv3C2A6J2VC1qyvIntTKutU9RO5U6fxItjjDshmCEMvKmcFKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(10067099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTloenJmTXl2VDFmOGdQTXczMmRGTU9ZaHRxNGZWOHk1ZlFKeGV2MGQ1Um4z?=
 =?utf-8?B?bGdpYldyMWNRdGdJQmQrb3Z2OU1ZOVZ0N0dsWDRUQTIvRUs1K3Z0dHRlYVl1?=
 =?utf-8?B?VXdnSDRrMFVMYnJ2YUx3WlNFaFVyY2c3MmczeCszY3dFVzdUMkNpT2I5Mlhw?=
 =?utf-8?B?VWxzek42c2dLWCsxREh1S3U2bk1iLzZVYTJLTzN1eHRYcE85NEZzcnhQeGZa?=
 =?utf-8?B?bHZMcVBjUGJmdXNuVFI2NFBFK3FhajZLYy80YXRSMk0wZ01sQTA0b2w2b2tZ?=
 =?utf-8?B?OWZBbGNGWThEZU9BZFlOdytqMzlHM2ZUNTMrRklqdmNmSHM5Z2xpWnRGTkcx?=
 =?utf-8?B?aWFiUE5QTG5lYlgwbFlPRU9BS2xFRnV3MFpsTWcyaC9RbVRhMEltaWlodXNp?=
 =?utf-8?B?TFltRUNwRkhreVJqRzJaQ0JtNFNmdWtPNlovWjMvWmdYTFAxdEwxdExpYU0y?=
 =?utf-8?B?Rng5UlpqbzV0ZHBqeXFWbjlFbkorRWJHcllTcFRjZlFzdEcrZ1NZallRREw2?=
 =?utf-8?B?bGI5S1V3UUhKRmlNbnFPWWZ0Tkcyc0xWWkY1REpkSy9FT2xsem5GbVhwQmtU?=
 =?utf-8?B?SzFHdXA1b0Z5K3Z5OFltWE95VGZvVlBBQ0pjcVZkcmRxL1BXTzE2S1E1cUtC?=
 =?utf-8?B?UGIxYmxoS2JocGtMMExnaWhDNXZVWENTZ21OaW5oRi9mcWVNQlcrWUpQZWhz?=
 =?utf-8?B?WDU4bHJsRnNWbDk1RWFQVzJPVDArc0RCbVhZV2RVOHlXeUtrR0NHWDdOMURz?=
 =?utf-8?B?WnJuQUZQQU1hQ3BYODYxRG94dk1sd0U2UG05Ri83QmVJL3lCbFV1VXp6SFRn?=
 =?utf-8?B?QXFVOCtkcGVTVWJwZkRrVkg3d2dNUEYreVIwZXAwUUdaQW14RndsVWJTY21U?=
 =?utf-8?B?VVdVSE9uMDJoaFFrcWdHQmR3eCtoN2xVczNBUjVnbTJxb3VtcGtoTHZ1TGJz?=
 =?utf-8?B?Y3g0YVRra0xkdW1PQlpXL000R2FuajkycmVoUkI4bCtXZG8vcXJ0MkpSc1Zv?=
 =?utf-8?B?T1REcDNEZjVNbmdrTTY5WFpQYUczWFNueUVQTCsxblZzMFV4a0NpcEwwSzZh?=
 =?utf-8?B?aWVpV2lzVFRLaVdQTERsNi9BUjlFOVRKdXVra09pM21QUFlac2hUZGt5QVd5?=
 =?utf-8?B?Q295WjZzcXlPL3pVbHJFVGpYNFRWeHo2VlVjUzRmWG9KKzZzVHkwYmJpN3Bh?=
 =?utf-8?B?cDNKaWkySDByMTF3ZUlpL00zajhFYW9EaGxNYWtIT2pQckREY3RZNStGMUtz?=
 =?utf-8?B?aEFpb0hnY1p2WE1MOFFwYXljVndxVXFvdU81eDVnRytCQ2E3Wkl1ekJVUS9M?=
 =?utf-8?B?NGVzZW04QTJqa0laNHMvQWFWRTNFUnVyQXZSMndFaHA0S1lyYmx1ZXJFeTdB?=
 =?utf-8?B?T09EK2xmU2c0VmVUMEJGUzllMzVkZE9GRGR3enU1V21zQUN2TGRDdnFtL3ps?=
 =?utf-8?B?eU85b2FkRDRyRXFSbXdUMy9RSk5NckNtMmxjUERROENXOXVQVDhRblJnQmpn?=
 =?utf-8?B?eUJwRU9GdHN2UFUxcjNWQldESTJFTjRZa3ZRRHZNYzhjb25laGpOdTVSaUo2?=
 =?utf-8?B?ZkFGeUhnSFczVTBrTHVIak52UWpCeUJEQXI5Ylc5NFJJVXA4QS9vdGRjVUk1?=
 =?utf-8?B?OXU4MzRxMkpBQ2s4N0lZR0xlaUNuRGVCeGtGSDl2S0pRZzl1dlpudVh5UG82?=
 =?utf-8?B?MkRTYTFkWWZOR3cxTDVGaHBDekpMWVBzcVFuNnlwU2UrSEZ1NW5raDJmWWlz?=
 =?utf-8?B?TUVxT1hQZHNMNVpTc2ZMbVBLZkpqNEFYaDJKbGpkMkRDOTVYSTE0ZkZORDJo?=
 =?utf-8?B?cFRKcHFrZkVnZ1hNQWhEbGUvVGpDNTdlM01DZjd0MzFrMUNnc21iK0xkYjJt?=
 =?utf-8?B?NEtkMlNWNHY3b3JYK1BtdFRxVUxYZVNidGRMRzRVSG82V2Q3L01JQ00zVUp0?=
 =?utf-8?B?WFVWWWFKTjlrZ2QyREVKYXpEd0trZFo2OWRocmNOVU0wNDQxc1pLME8wVEUz?=
 =?utf-8?B?VmpGS0txZHlPWEtqTm5PY09SS1FNTGZmVWx3aE8wR1Z5aEVkdEEwVVpOblFk?=
 =?utf-8?B?NjFwUWw1TjFYeTVrT1ZEQmVWblRUTjY5bUd4Q0JmeGxZVDR3RVp2YjkzNHZE?=
 =?utf-8?B?eHlKdzYydTZoeVBGMFNEWDJseGxnWm1FUlY4cVVhdW9iSHdjSm1ML0tGeTM3?=
 =?utf-8?B?WUt0NnFybzM4dzVnc0lHUmk4RTV6c3lrd2RrMGEwYk1CMXR6cnNDVDcybDEy?=
 =?utf-8?B?cjJYZWxBZ1AyWW96eVNkWjJvVjEwT3BReHFIUGhnc1dPajNoNEQ0dFZpZ05V?=
 =?utf-8?Q?eZc1ca9BekAc5T+QgT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4687d4da-d3f6-40ad-f91c-08dee37ec189
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:11:08.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzJLGq9jdGEOnUuHwmHZuLFS/lhESLT+VNGIScCZmF8S83Fsg5zoUrkwEbbXp1dA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595

On Thu Jul 16, 2026 at 10:51 AM EDT, David Hildenbrand (Arm) wrote:
> All callers pass 0, so let's drop the parameter.
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/x86/mm/init_64.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

