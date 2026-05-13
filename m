Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451F1DE3B7;
	Wed, 13 May 2026 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651670; cv=fail; b=TULc97OcPvCE2K1VfCuMbthTH5hedtBGQAv0PvWpXwhPNnuQ+3kltS/zSEslCfllZJ6a9VdfrMtwowu1bOMnZ5vzy9nOTjNjC9ptjdeB8pUVQQUaCgERAnkVmcVc24YIpB3y0CU2WciHTnyUoyU0qQEpnHlaksgq/Wql4wQRNsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651670; c=relaxed/simple;
	bh=hTZM5mPSw2nZw4oKcga9d/EcAoDdXQh8saukytPyHgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwfm/6cOUSL/+EML/Uvi8imTSIW93AURm49yXCXPyVRkrOdTA6jumN0tTiYUwy9hfTPKTItPP3p/szj9SZQFHjrVcAAQp05KMdsgCGPIlEuolyb6Z7YDsn95eTDkUi+fIf+9l9toU4cWfsx6/+dMULecYapDd3IkBemjybfEZPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rn7HtyD9; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rn7HtyD9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnIniu2hn0QPtKgQU9SO8RDM8Er7xL/pHXSilbdtYS0vjuk7KdOqtqG3aBYcvP5FmBvHCfbqZcm5sOIcTWXAgYfKZAVZmk5yLECUcZ6S5SCaIY5ON6zmaVlz/KPa10au+5bM7scebI3CFhwD0UZJ6OqYI9v7e4gwtqjiDjOIPViQZcZ9JYAl6i+M0kM/u2c9LTRFjdEAXtloZnJKlXj5gEmVRihTDTIawqqz5A/24YdOWM3PNas2Zq6qPJGxOqzdDJPX7HBe0jCyk5Doklo/CKJ87N1fREiyEcD8nZwXrWgX+qsiapmhxdkzNzRjKFHOGqJGSO/fXyk9x5ZL7jD8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUj/rqXL4xIAvB3noygtdItJnvmtvfw0MMRlgPcDOFk=;
 b=y0UPcXZa+KjPJtjp4AVndw/gALVq6R5DMkhTtJHY3vDYR0Ya1LXLHYAvZa66bdQx7OeCk4BowJR/oxo8k12JDMm20AmwzpN5qyJOgEUU2uScK7XHznpWm7qyckwwoz8SWcL6ZNT2U8tLvXiBRFFLCDEyuDgR4UgbngR2ClGtMonko5Hx7MweMIRh2wdtylEIoOhC82PABTD6yNswd1UC5UdjUjPfwByAxBR3Bq8oj6Olsn4y8EY4Pn+7j/PBVc2MRQdsYejL3UyQxTfBsBAGrJadm4zrJnDfUC5dj2gtWDwT5HOmN86Vit++vPMnYgj8K5UqbQ3nCrFdDOBvnVtdQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUj/rqXL4xIAvB3noygtdItJnvmtvfw0MMRlgPcDOFk=;
 b=Rn7HtyD9BKorQGqRo726rRYR2FuEsMRCvxc0nQ2h8KMWqVRc+a9Fs7WTDwot92zPGu4NvvYrSMLM9QXr/XMJDqgJud/nraMk3iSLYXsqkC9cLG0lI+MW4uGaWJLD0tJ+4qst5jo0gmRdRqXWckYRICBB1OLArMdVwTOznxTJF0I9CxJWGVfeFAWANwbBMGfskHeLZVurIfYOmxJbd2QH0WiVMPMm2Z4igRhj++P49KWocWR58xHZTg2lhs8ILWYZ7V4CJhiA9/Vt+GCJTo3aTcwvtto6Ta6TxLVjcJf4PzwYCAl03y5l0HKEjKVvnrTzytLH6v+kLsmtzBCDsgQ+vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 13 May
 2026 05:54:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:54:18 +0000
Date: Wed, 13 May 2026 13:54:11 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Kees Cook <kees@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Donet Tom <donettom@linux.ibm.com>
Subject: Re: [PATCH v2] drivers/base/memory: make memory block get/put
 explicit
Message-ID: <agQRSj2sGXSVegGJ@MWDK4CY14F>
References: <20260512072635.3969576-1-songmuchun@bytedance.com>
 <agMVtO5QPGYVb48D@MWDK4CY14F>
 <3EE08C93-F28D-4363-AC1C-C9B99F8ABB7C@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EE08C93-F28D-4363-AC1C-C9B99F8ABB7C@linux.dev>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 9adbf709-c0c9-4bc0-55f5-08deb0b4122e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	rMYR9QTrQh2K1aNkM8UlIHe1xoz+fjo/qlrS5RFNcJQ5HUx+v0pEU64l8XK0Lq2W714jxHaIvlsllJYT56C3UaplZV8vYYH1SdvynNYHLY0rm0f8n2LG9rHhJDCs9YJvrEQziN7ml8ZHshKOjDPgdY2BYeIG7tIqj0J4g5etUu0yEqBBX39QBzGOzggRLgJFCYeAaMHQDhoLVkzfPjWdKTiw2g2V+McybyCJr3quvZf5+Pcj3psBN8cpEzt8uk89y0lgv5ymBzuVspq+Kuq5JyAOfaL2y+MrIfEdKSc/WqvLywQXmTfe5Y51DRvZiA3qC6J3dtbVgH30zdMdq/BbgGFjyZlH9i5anO9XWKyCa3BcC1/DuspWERdiBOs2ahjEoCsqTv94yg+weqEcTQ3l0ZvhN5ttQdXqhL9P615Ue+RtdEsgT3BSF9k/ntS4QJ+5cIT/Cc83pHCEz11+GMZ81Vkwc5TRHCvI3xS7Mrb+nqTYxKHo/hM2wePMXM8zTfiKTGVG886oZHze5/FIiigta9ILi3q97VeYd//7+5zJBmRQusskEniFgM6zuP5pX9EHWLjvkeIxdD60T3SfWg6PWZd0ekDTrEVwDJ2HcuvHfSxjEMwkhRWq61WI12ZQO5+2PybBtHJFtajAzVV2d2+EmumoXdb++qQU58Xcuq5TtZpiALs5FCs+JIYRSoF2MLbPrp9KVkq5fi4kdoDY0+hLhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXZWNDlwU25ReHhGaXlZQnNyZGlHNkR0cm1jc1pBQldITUJqUEhFVjB3ZFlH?=
 =?utf-8?B?cURGQlJjNElrRGd6ZDBQVU82YjA1cnRyeG1UeFFibDRucEVkR09qTTJBSlk4?=
 =?utf-8?B?NU00NW45eEdUK2lQa1hZbWJKK2pkOVI1SjhmK1k0ajJnZ2RoQWgzVzVaQVVI?=
 =?utf-8?B?blNmcmxiZ1NXeUx0UzJSYjhsQ1g0eCtYTUcrcmNiczBRZ0xKMWkwNkRYMGJ0?=
 =?utf-8?B?ellZUytBak01Vnc1SFlyV1phSXlSMG1YNldRVVlmV1NSY05KREhINSsvWkVS?=
 =?utf-8?B?bDFaeEo3WENnWGNlVWVQRnRXRW1WVHRzTE9kNXdoUXl2c245TXEvWHpFMHR3?=
 =?utf-8?B?TW9MbUljUVpRdTdYTmljY0hRdmJ1aUFVd2dLRWxneExhNGc3RnZWcTl6V05N?=
 =?utf-8?B?d3ZHMWIxaWh3QXVUS1N0N2hXcXZsY3FhVmVocGNQN1ovN1creVo4MmJMdjln?=
 =?utf-8?B?OERUR0hLYmorMjZDNW5mSHRJbVpkOFpIYkI3S3NVSEt1ZGVGSktVVmZHQnkw?=
 =?utf-8?B?R1NZT096bzNTRmVBcDIzUXgrcHpoZG0zSXM3OW5veUFKRFFkaDJWN1JiUjVr?=
 =?utf-8?B?Q2VIQlVsNFNOQlBDTGxLdjNQQjh6bjhnVE9FUlUwa0xxVGxIOC8xYzNUMTha?=
 =?utf-8?B?MmhWYVhIdHJHbmh0eVJSNWpxVyt6MVRTQlo2Sll6ZjhVSzJxV2M0YWErVXZO?=
 =?utf-8?B?YVBhVm05QjJyNExzNGo2by92WTFMNkZLSk1MdVdBUFBmM2prZmM1NHIwNXAv?=
 =?utf-8?B?azVSVTV1cy9mUzRINzFkTzBTdU1LdEZWNTBEUjVqN2VJd09lWCt1ZmROdUV6?=
 =?utf-8?B?TTVqQzRDQ0NLN1BSSzEzcG9KOXZqYVJ5dVBZR29yNi9VbCt0SHE5bU85NnJF?=
 =?utf-8?B?MkVJLzVIUU94Z0p3TG9Pc3lrK3ZXM3lCVktMS2dvSGdkOUJQcnl0TGlrbldR?=
 =?utf-8?B?SU5OSWcxVGMwOUZOMzdYV0ZsbUp5Z2ZDanR6bHQyaVJUbExWa2xqMVpSZjE2?=
 =?utf-8?B?MmRBN1duajZnNGtyQ05XUW05VWJiMkI4bzVpaVU2MFJvUTI2ZU1QWjdoeTFm?=
 =?utf-8?B?YmtyWGpSNGJldU5oK3Z3OFNXWkRPODM5VXR6ZnZTdER2aE9aYzFjVGpkZlZT?=
 =?utf-8?B?V2FrUGJCOW9nVm4ydWVyd085dGxCSDZ4OVgrY04xdzMrSEJaOUJCaitRYnl0?=
 =?utf-8?B?YzdXTDlKOUk0cEptODRCS1lmWG1iSlJtQ0VVNkhUem5hMEFIaHlWUkZ3SWFN?=
 =?utf-8?B?U3JQdlZDczRSdFByd0h5RFVYbzRHK01hWDBJUEtNeDd4L2JTUVNiWmtyazBp?=
 =?utf-8?B?V05tTSsrdk54TFI1N0JubDlNSDFYeGErNzlhbDdDa1FnN1RyZVJIUHZNRDM1?=
 =?utf-8?B?bjlydzFSYUpPMHVMb2lOMW40c2tIZ0NPaUpQQU05bzFNZ1oyYVRJUU82dTBq?=
 =?utf-8?B?ZnV4ckxtNzBnQ1Y2Q05sNlNJdTBmcU9Hd2RaN3RyaWpuTVkxbDBSenlqVVZx?=
 =?utf-8?B?Z3dDaUtxOTJqditJUlpjL2J4M3VscHFCNmF1eUFidHZ3SHphNWxCOEpRTmZ3?=
 =?utf-8?B?MmtYKzhyUHhwNHBLR2p3cEtnZnQ0bU9aY2RidDd3QUhPYUs1aDN6QmxFM2Zj?=
 =?utf-8?B?bXZUbVBGNVRXaHRiVUMvdXhFVTFzUmIxeS92bVFZTWNZVTR4K3pOOERPUXgx?=
 =?utf-8?B?T0RBdFd1UmxURUZ1K2ZtcTZKVE1tb3hqTGExNWlVM0ZoMTZDODZGZWxNNEYw?=
 =?utf-8?B?cUhzUEdZSGc0Z2VQdW55WmRGTEN0N0RZYlJ5cFpHMWJ2R2U2bkU2KzNPbzBI?=
 =?utf-8?B?SzJEUFNGcWRwaUV4aC82dUhxYW95bDNMK0w5anYyQ3V5akpMSlRhVk9MWE9k?=
 =?utf-8?B?a0VaWndiaVhMVnlBaTVlUUhrK0R0YW95NFRxMmNSSTI0TjJJcThEVTUwT0dO?=
 =?utf-8?B?UVVMeXZOOHdpWmY5Uk8zOWo4aXpDMTlEN2N2NzA2NTdHaG0wUzgrMDFObkZL?=
 =?utf-8?B?ZHFZei9WYmVaRFJpL3RKb2NtdEdPcHRWWXkwWUVhOElIeUh5a0RkcVVoQUV0?=
 =?utf-8?B?ZXJ5TllvOXhod0IzN1loZEdCWVJnWVFpRVk2a0tENWtXZDBsajNhZGN1NlBl?=
 =?utf-8?B?dXRic21CdktMQVQ3aTYwRmF3UDBmODRkckdRemEybXluWExSai9BcHFld1ds?=
 =?utf-8?B?OGtVUXZqd3M0d3BUcXlld0xBUHljMDBDK0hmVUUwNUk0VjNiSnFoN1lveHJk?=
 =?utf-8?B?eFdydFlVdWRCU2I0b1hMU25TdGQ2S3l1ay9vRWxkdzJvcmNQV2VxZEpQSVJk?=
 =?utf-8?B?RHN1ZHNCVjBjQ0cwNFlqRUZrQ210R3g5a2grRTRRem4xek1oaFFtUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adbf709-c0c9-4bc0-55f5-08deb0b4122e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:54:18.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe9DlIF3ANyfZWyC+4wgzy1Zc8yfQi2nZF+4s74ZLNp8tMkrL10BiU9ITp+3F+c0YS++5STYboFxeVe4lz5KQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851

On Wed, May 13, 2026 at 09:41:23AM +0800, Muchun Song wrote:
> 
> 
> > On May 12, 2026, at 20:03, Richard Cheng <icheng@nvidia.com> wrote:
> > 
> > On Tue, May 12, 2026 at 03:26:35PM +0800, Muchun Song wrote:
> >> Rename the memory block lookup helper to make the acquired reference
> >> explicit, add memory_block_put() to wrap put_device(), remove
> >> find_memory_block(), and use memory_block_get() as the single block-id
> >> based lookup interface.
> >> 
> >> This makes it clearer to callers that a successful lookup holds a
> >> reference that must be dropped, reducing the chance of forgetting the
> >> matching put and leaking the memory block device reference.
> >> 
> >> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> Acked-by: Oscar Salvador <osalvador@suse.de>
> >> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Tested-by: Donet Tom <donettom@linux.ibm.com>
> >> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> >> ---
> >> Changes in v2:
> >> - mention the removal of find_memory_block() in the commit message
> >> - drop the redundant extern from the memory_block_get() declaration
> >> ---
> >> .../platforms/pseries/hotplug-memory.c        | 14 ++-----
> >> drivers/base/memory.c                         | 38 +++++++------------
> >> drivers/base/node.c                           |  4 +-
> >> drivers/s390/char/sclp_mem.c                  | 17 ++++-----
> >> include/linux/memory.h                        |  7 +++-
> >> mm/memory_hotplug.c                           |  5 +--
> >> 6 files changed, 35 insertions(+), 50 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> >> index 75f85a5da981..94f3b57054b6 100644
> >> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> >> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> >> @@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
> >> 
> >> static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
> >> {
> >> - unsigned long section_nr;
> >> - struct memory_block *mem_block;
> >> -
> >> - section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
> >> -
> >> - mem_block = find_memory_block(section_nr);
> >> - return mem_block;
> >> + return memory_block_get(phys_to_block_id(lmb->base_addr));
> >> }
> >> 
> >> static int get_lmb_range(u32 drc_index, int n_lmbs,
> >> @@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
> >> else
> >> rc = 0;
> >> 
> >> - put_device(&mem_block->dev);
> >> + memory_block_put(mem_block);
> >> 
> >> return rc;
> >> }
> >> @@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
> >> 
> >> rc = dlpar_offline_lmb(lmb);
> >> if (rc) {
> >> - put_device(&mem_block->dev);
> >> + memory_block_put(mem_block);
> >> return rc;
> >> }
> >> 
> >> __remove_memory(lmb->base_addr, memory_block_size);
> >> - put_device(&mem_block->dev);
> >> + memory_block_put(mem_block);
> >> 
> >> /* Update memory regions for memory remove */
> >> memblock_remove(lmb->base_addr, memory_block_size);
> >> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> >> index 11d57cfa8d72..5b5d41089e81 100644
> >> --- a/drivers/base/memory.c
> >> +++ b/drivers/base/memory.c
> >> @@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
> >>  *
> >>  * Called under device_hotplug_lock.
> >>  */
> >> -struct memory_block *find_memory_block_by_id(unsigned long block_id)
> >> +struct memory_block *memory_block_get(unsigned long block_id)
> >> {
> >> struct memory_block *mem;
> >> 
> >> @@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
> >> return mem;
> >> }
> >> 
> >> -/*
> >> - * Called under device_hotplug_lock.
> >> - */
> >> -struct memory_block *find_memory_block(unsigned long section_nr)
> >> -{
> >> - unsigned long block_id = memory_block_id(section_nr);
> >> -
> >> - return find_memory_block_by_id(block_id);
> >> -}
> >> -
> >> static struct attribute *memory_memblk_attrs[] = {
> >> &dev_attr_phys_index.attr,
> >> &dev_attr_state.attr,
> >> @@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
> >> 
> >> ret = device_register(&memory->dev);
> >> if (ret) {
> >> - put_device(&memory->dev);
> >> + memory_block_put(memory);
> >> return ret;
> >> }
> >> ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> >> @@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
> >> struct memory_block *mem;
> >> int ret = 0;
> >> 
> >> - mem = find_memory_block_by_id(block_id);
> >> + mem = memory_block_get(block_id);
> >> if (mem) {
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> return -EEXIST;
> >> }
> >> mem = kzalloc_obj(*mem);
> >> @@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
> >> memory->group = NULL;
> >> }
> >> 
> >> - /* drop the ref. we got via find_memory_block() */
> >> - put_device(&memory->dev);
> >> + /* drop the ref. we got via memory_block_get() */
> >> + memory_block_put(memory);
> >> device_unregister(&memory->dev);
> >> }
> >> 
> >> @@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
> >> end_block_id = block_id;
> >> for (block_id = start_block_id; block_id != end_block_id;
> >>      block_id++) {
> >> - mem = find_memory_block_by_id(block_id);
> >> + mem = memory_block_get(block_id);
> >> if (WARN_ON_ONCE(!mem))
> >> continue;
> >> remove_memory_block(mem);
> >> @@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
> >> return;
> >> 
> >> for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> >> - mem = find_memory_block_by_id(block_id);
> >> + mem = memory_block_get(block_id);
> >> if (WARN_ON_ONCE(!mem))
> >> continue;
> >> num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
> >> @@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
> >> return 0;
> >> 
> >> for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
> >> - mem = find_memory_block_by_id(block_id);
> >> + mem = memory_block_get(block_id);
> >> if (!mem)
> >> continue;
> >> 
> >> ret = func(mem, arg);
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> if (ret)
> >> break;
> >> }
> >> @@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
> >> void memblk_nr_poison_inc(unsigned long pfn)
> >> {
> >> const unsigned long block_id = pfn_to_block_id(pfn);
> >> - struct memory_block *mem = find_memory_block_by_id(block_id);
> >> + struct memory_block *mem = memory_block_get(block_id);
> >> 
> >> if (mem) {
> >> atomic_long_inc(&mem->nr_hwpoison);
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> }
> >> }
> >> 
> >> void memblk_nr_poison_sub(unsigned long pfn, long i)
> >> {
> >> const unsigned long block_id = pfn_to_block_id(pfn);
> >> - struct memory_block *mem = find_memory_block_by_id(block_id);
> >> + struct memory_block *mem = memory_block_get(block_id);
> >> 
> >> if (mem) {
> >> atomic_long_sub(i, &mem->nr_hwpoison);
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> }
> >> }
> >> 
> >> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >> index 126f66aa2c3e..b3333ca92090 100644
> >> --- a/drivers/base/node.c
> >> +++ b/drivers/base/node.c
> >> @@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
> >> for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
> >> struct memory_block *mem;
> >> 
> >> - mem = find_memory_block_by_id(block_id);
> >> + mem = memory_block_get(block_id);
> >> if (!mem)
> >> continue;
> >> 
> >> memory_block_add_nid_early(mem, nid);
> >> do_register_memory_block_under_node(nid, mem);
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> }
> >> 
> >> }
> >> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> >> index 78c054e26d17..6df1926d4c62 100644
> >> --- a/drivers/s390/char/sclp_mem.c
> >> +++ b/drivers/s390/char/sclp_mem.c
> >> @@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
> >> addr = sclp_mem->id * block_size;
> >> /*
> >>  * Hold device_hotplug_lock when adding/removing memory blocks.
> >> -  * Additionally, also protect calls to find_memory_block() and
> >> +  * Additionally, also protect calls to memory_block_get() and
> >>  * sclp_attach_storage().
> >>  */
> >> rc = lock_device_hotplug_sysfs();
> >> @@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
> >> sclp_mem_change_state(addr, block_size, 0);
> >> goto out_unlock;
> >> }
> >> - mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> >> - put_device(&mem->dev);
> >> + mem = memory_block_get(phys_to_block_id(addr));
> >> + memory_block_put(mem);
> >> WRITE_ONCE(sclp_mem->config, 1);
> >> } else {
> >> if (!sclp_mem->config)
> >> goto out_unlock;
> >> - mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> >> + mem = memory_block_get(phys_to_block_id(addr));
> >> if (mem->state != MEM_OFFLINE) {
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> rc = -EBUSY;
> >> goto out_unlock;
> >> }
> >> - /* drop the ref just got via find_memory_block() */
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> sclp_mem_change_state(addr, block_size, 0);
> >> __remove_memory(addr, block_size);
> >> #ifdef CONFIG_KASAN
> >> @@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
> >> return rc;
> >> block_size = memory_block_size_bytes();
> >> sclp_mem = container_of(kobj, struct sclp_mem, kobj);
> >> - mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
> >> + mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
> >> if (!mem) {
> >> WRITE_ONCE(sclp_mem->memmap_on_memory, value);
> >> } else {
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> rc = -EBUSY;
> >> }
> >> unlock_device_hotplug();
> >> diff --git a/include/linux/memory.h b/include/linux/memory.h
> >> index 5bb5599c6b2b..463dc02f6cff 100644
> >> --- a/include/linux/memory.h
> >> +++ b/include/linux/memory.h
> >> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
> >> void remove_memory_block_devices(unsigned long start, unsigned long size);
> >> extern void memory_dev_init(void);
> >> extern int memory_notify(enum memory_block_state state, void *v);
> >> -extern struct memory_block *find_memory_block(unsigned long section_nr);
> >> +struct memory_block *memory_block_get(unsigned long block_id);
> >> +static inline void memory_block_put(struct memory_block *mem)
> >> +{
> >> + put_device(&mem->dev);
> >> +}
> > 
> > Hi Muchun,
> 
> Hi,
> 
> > 
> > Thanks for the work, I have a small suggestion if that fits your thought.
> > 
> > I think we should at least add a comment  above memory_block_put() to remind the caller to check
> > for the availabitliy of "mem" before calling this function.
> > We perform the check in memory_block_get() inside the function body, I see different usage pattern
> > across the caller when they're dealing with "mem == NULL" and avoid to call memory_block_put(), 
> > I can understand we should leverage the check to caller, not inside memory_block_put().
> > But just in case the next caller might forgot to do the check or think the behavior might be symmetric
> > bettween memory_block_get() and memory_block_put(), a comment above the function would be nice.
> 
> Thanks for the suggestion!
> 
> Regarding the additional comment, I feel they might not be strictly necessary.
> If a user passes a NULL pointer, the issue would be exposed immediately
> before memory_block_put() is even called. It's unlikely a user would obtain
> mem and not perform any read/write operations; any such attempt would trigger
> a NULL pointer dereference right away.
>

Makes sense.
 
> As for adding comments to memory_block_get(), I’m wondering if it’s truly
> essential. The function is quite straightforward—anyone looking at the
> definition would see the implementation alongside the comments. It’s very
> clear from the code that mem must be non-NULL to be "gotten."
> 
> Overall, I’m concerned the extra comments might not add much value. What do
> you think?
> 

Agreed, let's leave it as it is then.

Best regards,
Richard Cheng.

> Thanks,
> Muchun
> > 
> > Best regards,
> > Richard Cheng.
> > 
> >> typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
> >> extern int walk_memory_blocks(unsigned long start, unsigned long size,
> >>       void *arg, walk_memory_blocks_func_t func);
> >> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
> >> typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
> >> int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
> >>        struct memory_group *excluded, void *arg);
> >> -struct memory_block *find_memory_block_by_id(unsigned long block_id);
> >> #define hotplug_memory_notifier(fn, pri) ({ \
> >> static __meminitdata struct notifier_block fn##_mem_nb =\
> >> { .notifier_call = fn, .priority = pri };\
> >> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >> index 462d8dcd636d..890c6453e887 100644
> >> --- a/mm/memory_hotplug.c
> >> +++ b/mm/memory_hotplug.c
> >> @@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
> >> struct vmem_altmap *altmap = NULL;
> >> struct memory_block *mem;
> >> 
> >> - mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> >> + mem = memory_block_get(phys_to_block_id(cur_start));
> >> if (WARN_ON_ONCE(!mem))
> >> continue;
> >> 
> >> altmap = mem->altmap;
> >> mem->altmap = NULL;
> >> - /* drop the ref. we got via find_memory_block() */
> >> - put_device(&mem->dev);
> >> + memory_block_put(mem);
> >> 
> >> remove_memory_block_devices(cur_start, memblock_size);
> >> 
> >> 
> >> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> >> -- 
> >> 2.54.0
> 
> 
