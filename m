Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5903C13E0;
	Thu, 16 Jul 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236422; cv=fail; b=H6qElK1Czbmb+2UdZjXBtwM6FZG28Smvbz6KFWm4vWoJDSQxfLNji9ECz7al6HtvQLj+mWiUHKT1IjwJNad/aZuy+2ninYlpD4azcqXV1M44Q5DKFeKTSSGm76MszVeb1xbiIHqp4RGT+5ZDNwQv3bhiNYHSyZ9Bzij04sFFO3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236422; c=relaxed/simple;
	bh=2F75L2g95nUHXduxw0FV+PZF19x4LQVHCYstejtQxVk=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=YY+R0z8+tbiBmtclwMyhxGixWojudwuNpJSW3eaevi+8LH35/0uYSKno3g7WLhrYgJDrp4hyGk5uLvMhkRnPjMgLeD7rJ2WlXLrgbzgoBLvK8yM4AxoXMJg0VwZ3RGq8CifR+mv282BTSAGOeD3GOaZ8rKd1S2j8WlHJQeEcJ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxlOutC9; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxlOutC9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9t+j0Kj9gJhPaBY7I1TlXfMvW2KeVVfESyEuqBL7cPiyvw450yxLsdqmqZukUF331Kdpx4wdo0+nYj5UoTjS1yu4eCfPkDK464CG39lmyqKXMTT+r2k9Y19757C5lA7aaUZZuXU4nnNanfBqiakOOjOeLti9SInvAqkat/8UcfGt6W1rd9u4H3t2JAmGfnwTtEvphx6LiMd+yS//a4uAXXzeuXHj0KkU4BdKHALNuzSmScZztSGAyK73rvaAtzByFW8DpHvnOqc02Bl2gGcQkKKK8lckJFHRLqvj8qvCeMwtEPzygJaSX0Ed6bTnNMP7ak0A9wlRoNVJYkRdo01cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ15O8asbbkyGDnwbWe27ifFCFdM3D7Sw3so2x9EDao=;
 b=KDWqqCF94W/dEvnutwAwiirnbHKDNx4sCzCDKUowYiqoYdl7u0buXy3vvFsdZxkG1KqyEkDD2mQNkjNgtczVxmMzALnHtMAQSzP9/fsc74gBPgmLlYXj4tADbUL5K8vyYsJI8DBbjiH8gTwpPCM67TacxU8Jsa1ciLGY/xfA79x8JX+t3XVGfpImuMyA6au0L1ydfCij1+PzqC0nzfwAHbqH2GGh9Iwd2F4PyfQ+yOtLqPbdc2XY6bxlT2tQ2Xq9P4h4KmqQV4X/6vLlMynCyQaj+xjYqax+ZUY4vPPNyWrY+59KWStp6ruvGWedR90ELm/giG2u48p/a/mysSBu/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ15O8asbbkyGDnwbWe27ifFCFdM3D7Sw3so2x9EDao=;
 b=bxlOutC9/GSOhSQQEnigXBa0+nYASyLACIejg1rlrj0AjnYcP6+YuwMpQk0cEeHkZGuAFVrT7L1X3obv4pLQvZ9/AI4H4n//ZteVcfksZ9Px/yS9xNoW3N3K6imfCcdte8Gq4PuHYkkGk9n7L1juKkSdPCUtu8zUOlaMGRvoIby3iUboLnnk7X0+SZY48kYOIhWk/USID36R7cMcQnf7hXtHMe5HREmkC38aFVZifm8sJG0b27vzpyd3N7bIoOjwHzt6KQZ0bZeWVSRx0zqu7D23U/uo1YkoKa0U/3y1LBm9Us0OGg8cKd7GPowndUYHbU9qZ/OO1SZhvO2Hb1zscg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:13:33 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 21:13:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 17:13:32 -0400
Message-Id: <DK0B0S62Y96H.3RZQ5ES88NMNX@nvidia.com>
Subject: Re: [PATCH v2 03/10] s390/mm: use free_reserved_pages() in
 vmem_free_pages()
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
 <20260716-bootmem_info_part2-v2-3-4afc76c73d61@kernel.org>
In-Reply-To: <20260716-bootmem_info_part2-v2-3-4afc76c73d61@kernel.org>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd4a979-4a10-46c2-13de-08dee37f17bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|921020|10067099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	W9yAhoTIlu5KZuINKmdp7ra7U/1uJYG1Jfim4FHDgmgNdepE9xUwX9rZyoYvC2SaulrBB17Fxe04hKGE4l/1W0/r06s5mkh2WrcDBrmhnPHD98WbIr3OBqltnVmptyyyRQuF1GWEE90//vN+3liZli4jz0oSDYnr6ErLQsovA9zP+UqkeKGpBXyqpZxcYxhOaiko8Ry7HmsDj/t10v+ytnQl4/IiNd2xEGApzS7Ro+MBKwEbRjnkjqGcCc5rYz0R7DvWKBh/JbCkpiSDTpC5I61mAXxce0FUbT6D7fjZ38rFUhvmnYFQ6mdVpOViDBh6vBKcYnIjhyLsXwQlIV7Ak2yvftAqmu3BmMWxfVf0qyWpy8pPP1P9b4RzWjnYzeoX7YHUVSEuIjc68JawbUPzVaRHBVlNoahvDclS0UrUgsxariCzCSu3l2Qopi4Vs0OBqG1uGk9fwTMKShm7ugYGF6463NbGerFSEPE1gnAxRmeZAg0t5vB0Pnyirp2ALD/SHiZlbVey+a4J+z5GOyuncw8mjsyUgE6YKnUoCr4p0E0A3xyI41XQ1vRJva4igfCDXM/ZYhSFfx63tBpTrWZgeBCtTd99o/EMWV1RTK54SP0gXevjKUA6FUJlli17eOO39sp28iUfmmlxsmOEXtfZ4FfllqcSYdvJLZK3n5NRZxMug1nwCvdd8UBvPGjElr55mUrL/0eaCATMC93OCbwGkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(921020)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rnc0MVRYTEViWmlVVjltdTVkVTlsODNkYVdYa3VjL0ozNVVtWUE3Z1hhRkZI?=
 =?utf-8?B?T0NCd2owWmZSR3ROVDFzTHN6cUV3NWNlZE9Ja25sVlNUVXNndUkzVGRWQVB6?=
 =?utf-8?B?VDhCejc2emhuNzJCRTJOUGRwZHUyQ0M3VXFMZ0xyQytZTHdGeWJBMzBjd09F?=
 =?utf-8?B?bmtFS3Q3MUdGekp3OGh6Wml5NnJzR1RNM2Y0VS9aU3RhcWpOYWtqYVFYUnBr?=
 =?utf-8?B?d2UwRWMxd0VYd053R1lTSEZWdlNxWGRQWE5KdkMzdjhDelVuS250bllqdHpS?=
 =?utf-8?B?WWNWb3JpM3dRaCtySkV4Y3pNNno3QTRESnpISWtuSGtGOTlNL055L29CVys0?=
 =?utf-8?B?Z1NOdnZOZ1Z1cncvYXhvSGtzT0poOWhjNWtIVkl4TXhjRUxWUy9TRkhPQVpn?=
 =?utf-8?B?OVdBQy9uekRqaEpaSXB2WGRsTmdxbUtneDd5a2NQTStWVkhvNUxlM3RnZDMy?=
 =?utf-8?B?ektoK0VqVkZZdkRrMjAvSGlXVHhnWWhwalZmTXIzRUpjUzdPQ1ljYW5ycDAw?=
 =?utf-8?B?MmFtdmdMZnl5MURpSTRGdHR6Y1pWcE5COEVkb1hGenZuTVRGYSszTzg4MjB3?=
 =?utf-8?B?dU8wM2VoNlFRNXlwWElJVjNJSTNVcGtFVUxZNThCbTZpZWEwcFpOV25JSkhG?=
 =?utf-8?B?ZUJadGJtVDZLWnp1aUVaQ0RxU0dEY3ZqMkpqbUNvcGRDSHhhTVdxV3QyQ29v?=
 =?utf-8?B?Wi9NVExwb2NTUWN0TjBxZlU1elhTbVFCWVZTL3d5R3ZSamdpcCtGelQ3dmtr?=
 =?utf-8?B?REtNL0plck1WZG9CZURHM29jWlljZ2pibW1TYkRRWStzTVR5L3lNTTQ1WXRM?=
 =?utf-8?B?MS9kK1VwYnZFZnV0YzFKTWJmZ1pmb2xLbHRKMk9vSTBlcUd6L1h5WW5HQ3Vs?=
 =?utf-8?B?NVV5bElTWWdlNW9JYkhkeHBubFhrdXZ2cEttSHhYcWVnVU8xSm1DRmM3UExy?=
 =?utf-8?B?T1o4bDY0WDFyclBxMUh2WEpGdWtHaHY3SDdZd2NrbzgyYklmK1lyUVA4UHBn?=
 =?utf-8?B?ZlpxY003c2RXNGlQTHkzWlV1UWVPWDhHS1ZjWUpzcjdjclMwTU1VTytFUkZK?=
 =?utf-8?B?cjFnVmdpVWlQNWY4ZklBVDB4Tmk0MXFZczVLbHJKZnZoRjF2Tm5TbzEvR2Q4?=
 =?utf-8?B?aXdUdGpCczErSjNSQkxmWS9KWHArQ3ZCSmtRZGQ1U1NMQ0JuSitxc01vMC9r?=
 =?utf-8?B?TEU1K3lOamlYakVzKzIxZXdLVDF6QWV5R3hXamh3dHh1Q2VQc2ZSNE9mWWwr?=
 =?utf-8?B?MzgrMWpPQS9tcGRqQ2NmTzR2dGFETUM3N1pacTlLTDVobjlSY01zUDJVNlFp?=
 =?utf-8?B?Q2JpL3d4bmIyTW51VlU4YldHQmp5U1pIbXB4RXhlRWlTTGx3VjhxN3RWbk1o?=
 =?utf-8?B?TU1wc2ViTlozbkV0Q1J6eThYTXF4bDd5aWFHUnplTXJWT1E4VDNEWHVNL3VT?=
 =?utf-8?B?SWNhQ294L3pPOTZpVlBqY0lSYzVWOEFzR2pHdnZhSVI5WkZaenBGR3dSRkMr?=
 =?utf-8?B?NzRRQjZEVExwMU1PSHREUERpSloySzkvOHkzeDErajRNeDNmaXRkWU01VktS?=
 =?utf-8?B?REZzeGN1ejJtRW1pc3NtakgxdWE1RCtOeitVQ0lMdkY4SkJ0ekxTRlFxTXdR?=
 =?utf-8?B?T25HbExlVHU5dEt0djlJRHFuM21KV2RRZkdxR2ZNQzIzMjJvbklBcTJaczFS?=
 =?utf-8?B?S1hqa2w3Yk9uZHVLbzBscjJDT0Vhb2ZNRlBHaUZWR2pTVytIMnU5VENSVE13?=
 =?utf-8?B?RXJJY1R1ejMxenhhakhLYlZYZVRIK3paenVJZW9Qdy9Oa0pIQW5xSmcvM3k2?=
 =?utf-8?B?aXBWeEwxbERocGNXVFlQVER2czRMZ1Y4d3JaQmFMa3ZKYU8rdGUrTVUxZ3B4?=
 =?utf-8?B?RlFBMVo3N1AzQ2d2dzQvYkNyQmsrK1dvcFcvNER5RDJUYS9VczZ2R0VReTk4?=
 =?utf-8?B?eS9LS2hpRW8ydGtwQ1dqaklxSERDTDcxNjdBWTQ5Ynk3Mm1QSlFOR0poWDl0?=
 =?utf-8?B?QjViSDYwMC9QZm92YzRkYk41RHlTVzUvazZsYTBJVDZ4dit2NE5NRWNQWlRw?=
 =?utf-8?B?YlkwSlhoZ0paQzc2L2VEUWRCcktwVVRndGdDbytYb3UyZEJwNkhoczJUTHpl?=
 =?utf-8?B?T0FRQmIrZXFLcnN4L3p6OUpRWll2M1BxMTBQQlkxZTRrVkxoUjN5d3lLa2Z3?=
 =?utf-8?B?M21VMmpFU0U1WVJyTStkRlRSMjJTWkhjWk5ua3ZLQUVVemQxWnJkN2JEZWwv?=
 =?utf-8?B?bCtEN0xhRktMb0NuOXg5bmV3Qi8zbGIvOTUxcUNZelpuL3ZNSGE0NExyYUg1?=
 =?utf-8?Q?ybcAHBU9hsmLcBehhu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd4a979-4a10-46c2-13de-08dee37f17bf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:13:33.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CZiHOZBq0A3Q6lYbqc/QcbDC7U72PM8RqU+t2Ca93fy38rp7qAWotHrRT5ftPMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

On Thu Jul 16, 2026 at 10:51 AM EDT, David Hildenbrand (Arm) wrote:
> Let's use our new generic helper.
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/s390/mm/vmem.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

