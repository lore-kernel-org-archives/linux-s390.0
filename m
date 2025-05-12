Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62722AE45
	for <linux-s390@vger.kernel.org>; Mon, 12 May 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067749; cv=fail; b=SAOheeeoCaDCtpGAL5rNo78/1E3h8NC9mm4XOX13faKWbKOVIv2THlFfoisuHJbRRKM4g7NQYFzsZ7fDbbM5fg5p/JG9NTg2JCXuegulpPL3LMBzJwzB7NUw6XVjUt962us74eX4D4OLkGiCck8eQWp/9ssLkVkbZSjJY3zQcoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067749; c=relaxed/simple;
	bh=mqQVdjEqESx6xcPgR7brZiNlgSNfpmgPolEdSu+aGVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JR60OaaysAob1vPMfYfK2hlcf44BqV0OITmIdmKuj4qs1C9wYdSyjUn0a0kTH1Kl+Flby5xVEMONPs/5KLWCgcwxsJjH1ZvcUW5+iPFrBN34qjhtNdkBmXUtaLoI26qx7hkAZuyjXySf9vw04Cz9SySjKvlnRnr3Ts6fkOE0Ehw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JKwjIONC; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JKwjIONC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwxcuzIAf1T3pdnT58iW5vceHVAxETy38F7rRAFlg4P/8MmcTxBlrf35TgydHrxBjlxUAYvIVmvXfJgt7rEpZfodONywfWQfhpesQuNjY2eUl1q5bLmBnY/1ii/8gNkfB1ROJFdteBiCgrmWR3InM/EvK5i2YlRn92OPHdQT42QwbGuiDWKFkauqwW7HVYr1FCTrpAa5+LQnDMwyGCYeacnj5edJ559zARV3embdfXPN+Zu1wRKkJN38q/5mp0S4kh54FMrofHulbKKOoONIeFWWXWY/yw/bcN3fx5Q//C2VFF+5cVkQoAFpokHQnYLkNM0X0gfLTHR8BHq5LybDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEwrWGn53Ew07irHUMZXavP24ZXveu/9U39gXNua7BU=;
 b=KOJ0y8/yEsxNUOJYDijBlM801Zh5rWMzVbVa1xYxkQLCX8zK80zfqBFkKXdMEEzQd1uIAX+BMAsmnHczP/EFTTx80AI52UGnVGMeLZ/5BNFCWD8+OYESVDkEvWgzApJFGzCA50LatudOmNvDfgoXYbTBQA/V9WdjPue/T47QsDUT/Q84zLg27FR8ZL4AJdVGAayhnuRyIwmXaFl+gnBA8laMRTNNz7/3oBCJZG1mU4Is0BCihBXoG7sBDTiV6SSxM7PpQZBJTydtFUyVQsR5Aud3b5m3ocNuFm4S9mwOG72JAgQ1TrXRyQJJYLyeZdHFSq0e7RNe2sFFUgOnKBRnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEwrWGn53Ew07irHUMZXavP24ZXveu/9U39gXNua7BU=;
 b=JKwjIONCLrwGCrZvvj9SUG0oDycy5UPNj/HgYsksIJAmfokx2zr3u6/+tHJ4xwS7RA1wqxCNg/7/2qYWsBlxBArcu1zQ/m5XWJ1esWIY4oWpYJVUETKEcVXKD2a8azEOH4Pm3xY00rk/2qe0khC7/R3JzpwQ/zdjyMOewRToenWDQMycFPCyByJOS1vO+cG7xq2//p/9NPNGaWvK0pFjJk1wVgarxcW29VvjMZ/GAKY1LWYKm6WpZ9aGk7L5ay8G1x0vKdGJCm+kTNQAEPGmBbCBE6yUxp5vpb+Dt0zbZWR83emItHRKhYwcI25lFUUyqwP/O1W8n14pakOIW3YdZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 16:35:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:35:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Marc Hartmayer <mhartmay@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
Date: Mon, 12 May 2025 12:35:39 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>
In-Reply-To: <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LV3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::11) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aadb9f1-ea1d-42cd-51b8-08dd917308b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ocTtLoERYoOajIT7Qhd14VTI5VwK7K1JPmusOpz83B/fde5hgk8yZxpHnsB?=
 =?us-ascii?Q?5M94b4V2DFPHc2JS7XBt+ObKaXi6I857BXN4moRx5+/a8MvgHlCtPCWdVeGA?=
 =?us-ascii?Q?bviuE6k+qi/mvxQ29dxUmYASe7j+0j6Q7P9CK/lOP2EyTnpa2YnoEvvxYaC/?=
 =?us-ascii?Q?JOLptJnil84smVE96Ph+krab9IyBmrTIf1qzaAB8PnYXx8PGaRYj2Woyu3uI?=
 =?us-ascii?Q?hxVsJJyOxcMcdoKnRQE7QzfugXGUN1Qu8+VsvM7MxOCDC4Tx30u4bS2ADrvc?=
 =?us-ascii?Q?789Z1Q/r393cSrdZBoXw8GVAIrGNSJj0tPITZ2EQviRi7okwMr1pTa1mD6qe?=
 =?us-ascii?Q?vbjqnS7NZtHrb/PioRKM1HBhsa6PLDQ9oYWwJlGRHczgCivR446jNmawZHWd?=
 =?us-ascii?Q?ATBDpC/WFV9XmNPh54HRu4D3SbZF5Nk2ioPQ1JRhNyj9nJNQuxvpI82WV+OE?=
 =?us-ascii?Q?fSX0d3Sjevum0SCMUMTJqMvsQkjI4oIkmqdHeQuejKYcPCfWiDN1mzb7nGNn?=
 =?us-ascii?Q?BrB4PLv5hLEfQVjl6cbhO9qdE8yWE7eyIYwUtGElB0rgRSrdEQUKWfJ/Rh/D?=
 =?us-ascii?Q?hxGn6leXj2YHoDouqcCm0lBifd/S3KxoryFf3Y6JlelYu70K6x2blR/jmLf3?=
 =?us-ascii?Q?QEJZeYAOfbMKugvdLpCriC/dZHvuFybAP9OLFQkHdz9jFVPSFvpo4fyTmgyg?=
 =?us-ascii?Q?EwKB7RBWEvcCqW8w4YyPcxwv2DUjzBCEZHA+9d8Q6W+mtfSJtvDronMAE6HJ?=
 =?us-ascii?Q?fZNUK7S7x8/8X38fYwpy1ZrikkfNkj9lkgsPwZLclUNhWoTNMDwpyAbDtb+4?=
 =?us-ascii?Q?dG67dtu81q9Ve99JJmHmAOSOuYmRZPk6TBByYuLFdSgZu325RfEJvljtxp1m?=
 =?us-ascii?Q?b2SLSX1L0rspDx7b5S2cji04uiF/L9gz6QKv8VevcKuPZPrdVOuxBMbh4aiz?=
 =?us-ascii?Q?xK8v7eEF7eOLWcZv6DhJJLD2WspmdP/kjqrZq6ojKbU21NxNw9NoTtiL7h3R?=
 =?us-ascii?Q?Ejn39v7kfI3YrNWuzWf7oGTqmc760KucLZeEstZmfHxGHqFBaEqSjHmkXoO1?=
 =?us-ascii?Q?ywv8YzUv3XPxwS6hvJi/e7RLIWoHQJJ0nJn0wmnpv/iIYlTpyllIiNgzBLz6?=
 =?us-ascii?Q?eakkKbKIq6CljKpKtGHT3hbZ2TENwpA8+wtlj9ec1/p0KE7dKAHoiC27L0A3?=
 =?us-ascii?Q?l7fzaqLvYIUUJuuhOyn/Zv/0o+gvAq547iQro8Efm2fKRdp54QB5iU99ZT1f?=
 =?us-ascii?Q?begjoFB3fCLyR0h6uCn1eAG9iI5Z/ANqPsvdZSN5RX8vabSlCyE9zosP730Z?=
 =?us-ascii?Q?0dGVNa64ZeUcnjyKYuSwVUAumU+PdwlAwZBpBP4jEW/5j39QdgIEebmhU3GE?=
 =?us-ascii?Q?HmF3OOZHjkEKfn/myPNQbjO9qHUxl9jOqQd/Ue1ZU3Fux1inhiDrk4C4k8er?=
 =?us-ascii?Q?iE6rdUPyVYE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhmBuXmtHFW8qdXGwrqw7oTf7/xq8DG56/5zQvCsg8OJJRAGtmMFRoYPjhQ9?=
 =?us-ascii?Q?Jcx6fxnzu6gmcGTzBKvYVXDClcXekvWv64KeGzKgnTH/H6uK5ChcjQ5nLgz1?=
 =?us-ascii?Q?3mzbdfhZ1wvQPGBkhdeeSIkeeGWYheyNQp8MJ6TTavk9peKIVNGCPR8iGBcM?=
 =?us-ascii?Q?7N6KWSH5iDd17ZClGnnSCGLfLNXID9jQrG68htOCkUu5axrcT8GIbzCH1zJQ?=
 =?us-ascii?Q?7cO23OBJdmXAQbdyd+z592+tjjHmGgu5rqejsKNlgJdoj667hsFk63i3+jTx?=
 =?us-ascii?Q?3w7hP6kFNX8u9JJohL0Rb/afx19p0kERpYD0PUe5ZJ8ndyI2EXydE0TNnqdh?=
 =?us-ascii?Q?nBT0+BfVYfaVbCo+ee8g9Wdk4geqmby9+dBxqVY2A+2Pz0rrpRapzcWsnKms?=
 =?us-ascii?Q?68BKkbatHgDYzpRarnKxCS4Re7GPtsrDIlKMkQ/PKfThmnHt+p8fDVx/PhSi?=
 =?us-ascii?Q?5eu8+bsW6fUrNZulygERm9ZWfTCagt4w/6k71mHRXhLpkaH0lNL7/KQYpUvd?=
 =?us-ascii?Q?539i/0rZPUk9NYqFiJPXn0icC9H3KFjyL1geq1dgdpw5M1mV6+waYOhhIcaV?=
 =?us-ascii?Q?iVotnl3+MhMfxOMdJ5m+R+pdJHGejRehynEVnAj9I8AHiWGPTgIlqWRgh2/R?=
 =?us-ascii?Q?rnOEh1mnLqwH/yI+8STEeL3BAQUdq65ZdIsrxz1E3oq1s0ZS6EtWbgbDUkgQ?=
 =?us-ascii?Q?MtkX0XPT9DvvNi3UX1CJy8HD1qtRiKXNVXOVIPXyfpPcDRX79rWIczmUYEE0?=
 =?us-ascii?Q?d2nubqp3STVRSlZrL+GgZfPqfCH1u0KXYPhGRSBpr6a+gzsh3m1KAefm9Eej?=
 =?us-ascii?Q?rc760bZlXE9noxU5Ql0YF5Eu7TYotB+ZvMkXW88Pg6YBkSYaYvBRB4XxyJxF?=
 =?us-ascii?Q?uSkxnc9FBO+Ek/31b+LdP2sQfa37lIP0OxwaKnRkPg0bGxqdoUNPP5spDcYF?=
 =?us-ascii?Q?ecpHCxDZ3mqTaXFtTdCQKKAhEi0yFg/j4WQ3fyh5Zo6Xc6E36T5rDwj7BTAq?=
 =?us-ascii?Q?scQMDQSbt9wUV35p6PD+QsAf5e+i5YTtE+xgL8EZBkEG4gryEPjnnXO840dh?=
 =?us-ascii?Q?a7CeQW9DWC6Y+IjY7NhzXyNwcFYpOUDQNKdiuVBXPcjY3HLFLH3aLVor0J5j?=
 =?us-ascii?Q?VbC7I2bJmQT+z77TpFzBqS5OIm323+e/0HCR0X3RbjMonEgBbk9gHW3Qu4/k?=
 =?us-ascii?Q?pUlHrVbgW08PYzO7+h0RrqM0KDVbr3rBdOo8O6PlVLd87r+5Wc/nQzJjBd3t?=
 =?us-ascii?Q?gdYC16rqpaeX7SQUEWvYnfkOnYnXCJpXiGhhtST11kyVNZSq+Bgisrt1DRnm?=
 =?us-ascii?Q?sjSIWzhDhd+IJvr2b5L1VWX4dKMHzscZKNlWPCqsZ6uwSGHoG4hxElqL1k2z?=
 =?us-ascii?Q?kbkpphoaEYH4GfbBQuQ2sHtEJaeIeUOybEjc+Obhjy6kdQL7tA7xa/2dBxru?=
 =?us-ascii?Q?UC7muyIe8o1E+n83ZkiKtAieYJFx+XfoDuFyA1umQPB2/Eo361t1tD9pF0gW?=
 =?us-ascii?Q?6et3NOPiwlnk/rr96hP6CbzT/51bN4OHJQo2qyOPQV14sDxRxv5QOs/VUsl1?=
 =?us-ascii?Q?nrBcPOqQvqeaPC/NIW/krZUESotkHt2kCCWsamNr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aadb9f1-ea1d-42cd-51b8-08dd917308b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:35:41.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5aToESeO7CzEd4lXr6X36uPIDahavTK0FJiXeOW0r+Fnr+lugupeSZwsfehYckl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

On 12 May 2025, at 12:16, Lorenzo Stoakes wrote:

> +cc Zi
>
> Hi Marc,
>
> I noticed this same bug as reported in [0], but only for a _very_ recen=
t
> patch series by Zi, which is only present in mm-new, which is the most
> unstable mm branch right now :)
>
> So I wonder if related or a coincidence caused by something else?

Unless Marc's branch has my "make MIGRATE_ISOLATE a standalone bit" patch=
set,
it should be caused by something else.

A bisect would be very helpful.

>
> This is triggered by the mm self-test (in tools/testing/selftests/mm, y=
ou
> can just make -jXX there) transhuge-stress, invoked as:
>
> $ sudo ./transhuge-stress -d 20
>
> The stack traces do look very different though so perhaps unrelated?

The warning is triggered, in the both cases, a pageblock with MIGRATE_UNM=
OVABLE(0)
is moved to MIGRATE_RECLAIMABLE(2). The pageblock is supposed to have
MIGRATE_RECLAIMABLE(2) before the movement.

>
> Cheers, Lorenzo
>
> [0]: https://lore.kernel.org/linux-mm/ef5f6776-b405-48e8-9fa9-c56af392b=
c4f@lucifer.local/#t
>
> On Mon, May 12, 2025 at 04:18:06PM +0200, Marc Hartmayer wrote:
>> Hi all,
>>
>> In a QEMU/KVM guest with 2 vCPUs, when running a test that
>> enables/disables a vCPU by writing 0 and 1 to the sysfs
>> `/sys/devices/system/cpu/cpu1/online` in a endless loop and doing some=

>> `dd` operations (block size of 1MB) in the guest in parallel, I
>> sometimes see the kernel warning:
>>
>> "page type is 0, migratetype passed is 2 (nr=3D256)"
>>
>> The first time this happened was after the warning was added with comm=
it
>> e0932b6c1f94 (mm: page_alloc: consolidate free page accounting").
>>
>> Below is a "beautified" (via `decode_stacktrace.sh`) kernel stack trac=
e
>> (note: it's a self-compiled kernel using the debug config + Linux
>> v6.15-rc5 + an unrelated patch on top):
>>
>> ```
>> [   31.079925] page type is 0, passed migratetype is 2 (nr=3D256)
>> [   31.079967] WARNING: CPU: 0 PID: 512 at mm/page_alloc.c:668 expand =
(mm/page_alloc.c:668 (discriminator 2) mm/page_alloc.c:1576 (discriminato=
r 2))
>> [   31.079974] Modules linked in: essiv authenc dm_crypt encrypted_key=
s loop pkey_pckmo pkey diag288_wdt watchdog rng_core ghash_s390 prng aes_=
s390 des_s390 libdes vmw_vsock_virtio_transport vmw_vsock_virtio_transpor=
t_common vsock virtio_console vfio_ccw mdev vfio_iommu_type1 sha512_s390 =
sha256_s390 vfio sha1_s390 sha_common sch_fq_codel drm i2c_core drm_panel=
_orientation_quirks nfnetlink autofs4 ecdsa_generic ecc
>> [   31.080051] Hardware name: IBM 2964 NC9 702 (KVM/Linux)
>> [   31.080055] Krnl PSW : 0404f00180000000 000003339b22f52c expand (mm=
/page_alloc.c:668 (discriminator 10) mm/page_alloc.c:1576 (discriminator =
10))
>> [   31.080064]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:=
3 PM:0 RI:0 EA:3
>> [   31.080071] Krnl GPRS: 0000033380000004 0000000000000005 0000000000=
000030 00000333ffffffff
>> [   31.080075]            0000000000000005 0000033380000005 0000000000=
000100 0000000000000008
>> [   31.080080]            000003339cf5e290 00000229260c99d8 ffffffff00=
000008 000002a8827cc000
>> [   31.080084]            000003ffb7d50b58 0000000000000008 000003339b=
22f528 000002b39be17240
>> [ 31.080095] Krnl Code: 000003339b22f51c: c02000936173 larl %r2,000003=
339c49b802
>>
>> Code starting with the faulting instruction
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [   31.080095]            000003339b22f522: c0e5ffe40e37        brasl =
  %r14,000003339aeb1190
>> [   31.080095]           #000003339b22f528: af000000            mc    =
  0,0
>> [   31.080095]           >000003339b22f52c: a7f4ff49            brc   =
  15,000003339b22f3be
>> [   31.080095]            000003339b22f530: b904002b            lgr   =
  %r2,%r11
>> [   31.080095]            000003339b22f534: c03000933a81        larl  =
  %r3,000003339c496a36
>> [   31.080095]            000003339b22f53a: c0e5fffdaad3        brasl =
  %r14,000003339b1e4ae0
>> [   31.080095]            000003339b22f540: af000000            mc    =
  0,0
>> [   31.080123] Call Trace:
>> [   31.080126] expand (mm/page_alloc.c:668 (discriminator 10) mm/page_=
alloc.c:1576 (discriminator 10))
>> [   31.080132] expand (mm/page_alloc.c:668 (discriminator 2) mm/page_a=
lloc.c:1576 (discriminator 2))
>> [   31.080137] rmqueue_bulk (mm/page_alloc.c:646 mm/page_alloc.c:1592 =
mm/page_alloc.c:1762 mm/page_alloc.c:2315 mm/page_alloc.c:2368)
>> [   31.080142] __rmqueue_pcplist (mm/page_alloc.c:3090)
>> [   31.080147] rmqueue.isra.0 (mm/page_alloc.c:3128 mm/page_alloc.c:31=
59)
>> [   31.080153] get_page_from_freelist (mm/page_alloc.c:3687)
>> [   31.080158] __alloc_frozen_pages_noprof (mm/page_alloc.c:4971 (disc=
riminator 1))
>> [   31.080164] alloc_pages_mpol (mm/mempolicy.c:2303 (discriminator 1)=
)
>> [   31.080170] alloc_frozen_pages_noprof (mm/mempolicy.c:2374)
>> [   31.080176] allocate_slab (mm/slub.c:2454 mm/slub.c:2618)
>> [   31.080182] ___slab_alloc (mm/slub.c:2672 mm/slub.c:3858)
>> [   31.080187] __slab_alloc.isra.0 (mm/slub.c:3948)
>> [   31.080193] kmem_cache_alloc_noprof (mm/slub.c:4023 mm/slub.c:4184 =
mm/slub.c:4203)
>> [   31.080199] alloc_buffer_head (fs/buffer.c:3033)
>> [   31.080204] folio_alloc_buffers (fs/buffer.c:938)
>> [   31.080212] create_empty_buffers (fs/buffer.c:1697)
>> [   31.080217] __block_write_begin_int (./include/linux/pagemap.h:1025=
 fs/buffer.c:2134)
>> [   31.080222] iomap_write_begin (fs/iomap/buffered-io.c:825)
>> [   31.080228] iomap_write_iter (fs/iomap/buffered-io.c:952)
>> [   31.080234] iomap_file_buffered_write (fs/iomap/buffered-io.c:1033 =
(discriminator 1))
>> [   31.080240] blkdev_write_iter (block/fops.c:690 block/fops.c:755)
>> [   31.080246] vfs_write (fs/read_write.c:592 (discriminator 1) fs/rea=
d_write.c:684 (discriminator 1) fs/read_write.c:664
>>  (discriminator 1))
>> [   31.080251] ksys_write (fs/read_write.c:737)
>> [   31.080257] __do_syscall (arch/s390/kernel/syscall.c:125 (discrimin=
ator 2))
>> [   31.080262] system_call (arch/s390/kernel/entry.S:263)
>> [   31.080268] INFO: lockdep is turned off.
>> [   31.080272] Last Breaking-Event-Address:
>> [   31.080275] __s390_indirect_jump_r14 (arch/s390/lib/expoline.S:12)
>> [   31.080284] Kernel panic - not syncing: kernel: panic_on_warn set .=
=2E.
>> [   31.080294] Hardware name: IBM 2964 NC9 702 (KVM/Linux)
>> [   31.080297] Call Trace:
>> [   31.080300] dump_stack_lvl (lib/dump_stack.c:122)
>> [   31.080305] panic (kernel/panic.c:372)
>> [   31.080310] check_panic_on_warn (kernel/panic.c:247)
>> [   31.080315] __warn (kernel/panic.c:751)
>> [   31.080321] report_bug (lib/bug.c:176 lib/bug.c:215)
>> [   31.080327] monitor_event_exception (arch/s390/kernel/traps.c:227 (=
discriminator 1))
>> [   31.080333] __do_pgm_check (./arch/s390/include/asm/irqflags.h:48 (=
discriminator 1) ./arch/s390/include/asm/irqflags.h:86 (discriminator 1) =
arch/s390/kernel/traps.c:347 (discriminator 1))
>> [   31.080338] pgm_check_handler (arch/s390/kernel/entry.S:334)
>> [   31.080344] expand (mm/page_alloc.c:668 (discriminator 10) mm/page_=
alloc.c:1576 (discriminator 10))
>> [   31.080349] expand (mm/page_alloc.c:668 (discriminator 2) mm/page_a=
lloc.c:1576 (discriminator 2))
>> [   31.080353] rmqueue_bulk (mm/page_alloc.c:646 mm/page_alloc.c:1592 =
mm/page_alloc.c:1762 mm/page_alloc.c:2315 mm/page_a
>> lloc.c:2368)
>> [   31.080359] __rmqueue_pcplist (mm/page_alloc.c:3090)
>> [   31.080364] rmqueue.isra.0 (mm/page_alloc.c:3128 mm/page_alloc.c:31=
59)
>> [   31.080369] get_page_from_freelist (mm/page_alloc.c:3687)
>> [   31.080374] __alloc_frozen_pages_noprof (mm/page_alloc.c:4971 (disc=
riminator 1))
>> [   31.080380] alloc_pages_mpol (mm/mempolicy.c:2303 (discriminator 1)=
)
>> [   31.080385] alloc_frozen_pages_noprof (mm/mempolicy.c:2374)
>> [   31.080390] allocate_slab (mm/slub.c:2454 mm/slub.c:2618)
>> [   31.080396] ___slab_alloc (mm/slub.c:2672 mm/slub.c:3858)
>> [   31.080401] __slab_alloc.isra.0 (mm/slub.c:3948)
>> [   31.080407] kmem_cache_alloc_noprof (mm/slub.c:4023 mm/slub.c:4184 =
mm/slub.c:4203)
>> [   31.080412] alloc_buffer_head (fs/buffer.c:3033)
>> [   31.080417] folio_alloc_buffers (fs/buffer.c:938)
>> [   31.080422] create_empty_buffers (fs/buffer.c:1697)
>> [   31.080427] __block_write_begin_int (./include/linux/pagemap.h:1025=
 fs/buffer.c:2134)
>> [   31.080433] iomap_write_begin (fs/iomap/buffered-io.c:825)
>> [   31.080438] iomap_write_iter (fs/iomap/buffered-io.c:952)
>> [   31.080444] iomap_file_buffered_write (fs/iomap/buffered-io.c:1033 =
(discriminator 1))
>> [   31.080449] blkdev_write_iter (block/fops.c:690 block/fops.c:755)
>> [   31.080455] vfs_write (fs/read_write.c:592 (discriminator 1) fs/rea=
d_write.c:684 (discriminator 1) fs/read_write.c:664
>>  (discriminator 1))
>> [   31.080460] ksys_write (fs/read_write.c:737)
>> [   31.080465] __do_syscall (arch/s390/kernel/syscall.c:125 (discrimin=
ator 2))
>> [   31.080470] system_call (arch/s390/kernel/entry.S:263)
>> [   31.080476] INFO: lockdep is turned off.
>> ```
>>
>> Any ideas?
>>
>> --
>> Thanks in advance,
>>
>>  Marc
>>
>>


--
Best Regards,
Yan, Zi
