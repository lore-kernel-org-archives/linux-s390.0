Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88C30CD95;
	Thu, 19 Mar 2026 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943970; cv=fail; b=ebAR10L4VVsn2s901qViwqnfbqvnmUVGy+7bQmnIuUoOXn3g+Y1X97NAXHF7ay4wOZo73eIPmpqfeN2YZGf7H4SPY24w8bfAybL54oJXGvI1v8uygNXbRsYu2omIXXCIu0zlxIUYE3JzOgHiu3VBccMdFysIK2sqmenuoabGJhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943970; c=relaxed/simple;
	bh=icUDI9TZBZ6pqLMwgmxlJ8c4YlWwmTVQ/R0Cy00WLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iJaq11uWkgKC8afV0Dt1XUDjVKvneH/1SIQubxcJz0EjXeqQqI22PrVvCxTcHmAyDOagV+jbMs8ND/m7CcbzqtQJND6FBS9nIrw0bdcUyGjIqZrY+/BGN9evGhNh6PQJ45QcrCUERb8A9z7z3swSLTAsM0eid6LRJU7POlVFso4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K7Syrept; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K7Syrept"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR0zem9alsDj/Ujgj7zNS385n1IrStVvSTUdtAtYgV0uflRg2GVha3VVHaa8+pa1gs1e4AHW2sMi2Vt2lDQKec5jDYSVlSzAmL+8J+pGSRXH6ayoC3VRfw6nA8ZYXAzG1Or8SD21fBkf/5tKOsKvnvHrMnYlFYFBE/1F2bqarRhVgphxgJbyKmT2Dkyu3ZU4A/BXDIjMDzR4QT4N0LMNMdAryutC4FKEHzCA4/KH+bk41BRDesXsnWjpIRopWmW+OFcUsNTD3LcXDjKAxOtoYzHmNgm52nWzFYKe7mka7iJA/j7xdV/cK56k7ry1dW3dxtywBCvQ0uM3dwRIxDudwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Frntg9uDgEAc6cVx36FrJGMLCU932plAnTmmiInIle4=;
 b=CUCSKYacWnCYwrChUhm9zZYcbNaq+1QWAGnhDYtirMl0n30E1v62mOIqUa2qfU8rZakj+0O5HDJR2R8Q1WWNC0Zm3xRQAGz7nQWkKl0skfVdjRcD7pVhtiEP7BPH3EJ6sZaUwlHgH5pAJ80FwiUR+q7XA/bum3yQH78wBAb38EAFSEzGeBHQv/2BbZvxztk7ufvwAEK7AvZdqtQrDP9drB2z4pfsR+1aMDegzOdTOeFBN+SGIm7AhzkFV4xxkKJe8YDTtKTIcmJLBEgq2d641sNbV0QYi/Wxcrk1JCu3SF3hLt8cGBs0jkRlb/VoIkp8jb4T0X0McUxRN/sAPxUzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Frntg9uDgEAc6cVx36FrJGMLCU932plAnTmmiInIle4=;
 b=K7SyreptjJTfI5KoskseCojy1evGBY1xUdLlRRtZqsFl8Vl8DkFE4ElOiy4pEIhFSEQeSAvz78jyFCNT6IphtI332XUE0u/5zfHDbmidrVULjYfHl29uH2t4czt/C4itR96CnJMIl95ZheKGcyRKI5dq7OrCqHz54dVyURFCmyUPzwrrNviKBh4+y9oQuThQcxqMb5WlJFuIVw0iFptDC78FLBamQgy4sTVvOIvsaFcVi6JVlRXRDhZRYl36GtngaI/gASx5yN93S6RxKl0NBa+VO7YThvZo8/DIPx2M05IKR5XNu9lj6p0Y9YuMpU2jxsYUjIKloAzp/cPVHcrtUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 18:12:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 18:12:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Date: Thu, 19 Mar 2026 14:12:23 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <1559C268-444B-4A64-A0B8-21B2FE49A5E2@nvidia.com>
In-Reply-To: <e166588e-036c-4fa3-81fc-d7aca9f02c29@kernel.org>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
 <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
 <e166588e-036c-4fa3-81fc-d7aca9f02c29@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2914a4f3-c499-4769-2ec5-08de85e31810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	x0vjK8tQDS84MULlAEJFVmItsXbuZutLT/ZGczdZwMPOT1jiIgQo/o4ZM/GZuLphdgsB5DJ8UnLC3KLnAMqRrGjs/IKxuvwJAr8R2TXYKTbHNTJzb5j6/Fje68mvWalOw+34XteEUgFjE1igP+eXfCxJidTaqcF8//h8MitHjRtPZmVSg9d88eQD49F/fC6CQY0oPv8bz6E3pv5yqhH20EWGz4F478SU/QT+hv/JqNMhTKoRigdQUyvjjce2ouRQmfcRyWYutoQ/iBrnDqH0h+pRpMFtJwuvkJULYlwNl+zeNFUjWh8kqjr4XkDZtNmITQ9RJGVb9FUOiRkPOHu0lEOaSRhY9EBEsNUptPh+Yj/x+ycJbLCUcphGMx21H222QW4Q/Hcr+J5twLjM2Pypa0de/LHlBTw45b4euMcrEsGV7S/StdEv0B3NSjGAxxgDnAF85QYMa2ro+1qTXXUV8kzrAtpS//oz8/w3wfU7RkPnoo8w6mOzKBdz8uWdIxSC/y0lzrJ3ub0JDnylY0NatwZR8OaS3yoeLdC3zyhg4RcquCV3gSJwnu9xm74lejwtSYLbLMDOqPh52eS1wICI1xWVuOch+X58DBzFG5ejmuRCtgWQKwBfdcO9+VJanPiq1t2dMTo7Xwj30Sc6KKG17GiCm1+x6IwcDn/OQFcQ7eHVQrgvikFX4+uz6wAFOKQwzqpdopvsyu7P/KycGNsWR11TMszvtJDzwzatslMy/N0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMHMUoNQ3MS3Q69v3mcA2Fkzm2TSYw6G+L1FAQc3D3kRr2xKGqWyGrYfuNsx?=
 =?us-ascii?Q?/FQvR+Fp/Tj92dmTFZvvaBa8k7Sj1QWzy+nDUXTGZj0eNQLtwVO/Hg6+WfqY?=
 =?us-ascii?Q?y9KQ57Nyw6m7m72oqewmJvR/aOnp/IA6zeRUiDmtGjSnk0v4QUQrIZcHMPzi?=
 =?us-ascii?Q?QwS9r5t+Z1JpHppIy+VbnskT1mnpY1av37vCB5XHNXiWnRMnxtYR/cGRGwlz?=
 =?us-ascii?Q?70i2pm8B/Q1FvIi3Ekj76Yg0SbUokY1PYx+Pzn+okrfX10GP4EbD6HMHGqq7?=
 =?us-ascii?Q?6ZZoW8lmxhImwdh69qzFCVasPHBiHlVctHO/euVAqaEjcvGaCI9aMMh/LJF+?=
 =?us-ascii?Q?9qtMlzonG8ZMnwEtoQHjG/qWn8ggIb3AfE8MB1j4ywsgfeuKnjJtBK6qFyJW?=
 =?us-ascii?Q?iNqv/ZQCV+PuBAvpv3svx7Yg736fR7wRguY1w+k1kroHZcKH2Wty/rpKjOs0?=
 =?us-ascii?Q?SjphdndhnJBH0LJt3io6nB5/j4jp21Skh93Yf4OsrNW6xlnpiP9Z/przoVZy?=
 =?us-ascii?Q?+c6Qz7hXiEbYgqDH9Mge0R2YgZY8cMxCFa+AekpIEnH3PYZKKIWodYYTwJee?=
 =?us-ascii?Q?NNh+t9ZF7QtavYSLasGXBSxhADWkOqtAOIHyLDMwIbzFMXW+gWZkfAexOxJG?=
 =?us-ascii?Q?Z+Zsseh4twR6FacyMvhN3XIgpMAWF94PeJqdqNdbeKR81TrP7qA77dPM0PJh?=
 =?us-ascii?Q?ks4ZxELf/lca5W8D7dFCv5r965FR10xh+Aans5C1DB2M/Gb2bxWWOQv4XtrF?=
 =?us-ascii?Q?HDnW1lV45VCVHS+s0qcPauSMrgFW6aNKIqQctYsEj6BQVy9tULl6Sn6xwCHd?=
 =?us-ascii?Q?RQVhdMmwPWnt7uzREmKG34sD2SifKExxp0OKdVN65kFdc4PeyTEF+FbzbOOX?=
 =?us-ascii?Q?iLFA3aUniuDLHFlj3JOgJ1UEgp+oWZNPiL9ej7cQKgljrF5TJQ9W3Wao9yEy?=
 =?us-ascii?Q?xDRTtVjXQYC/aBe6nBzK3MQmBcNU2Z5GnUA1T5TCRmE7OMJLTj8G6ai6riMZ?=
 =?us-ascii?Q?yJNyHb+YM6C3eesHIwo+M5wZQCS9vhtcAHxvnTdWwvGniWgmxLmd/YaPn2wA?=
 =?us-ascii?Q?fDukww5OPCl7hNjJ2wmb8KC5UNwVhbjc4z8BRlkfpr5mv5BtJCTeWSS9Cm5s?=
 =?us-ascii?Q?tGEvehINcj6Fj2hspZbX5jX+pUFRAADq5LZ31zeK7H5hA/WMJ3V0YnwsRKF8?=
 =?us-ascii?Q?OxpDZNLB6X+C8AZyPgWGU9H085Bn01EXUWDVOPMN6say2+s0P6tK4PT4Vyw9?=
 =?us-ascii?Q?A+0kTCfaXFYIWCBwB9BKsU6PADQwXtWOOvbOoMxCpAPwKciEiVO/MSWIxqZ3?=
 =?us-ascii?Q?E9heb8wY2mtDtYOa8xb2c/zG715kg3ubl36FmbVLiGtQqAr9VieBBA2wJ+9I?=
 =?us-ascii?Q?r2BmE346JPacQKxd87gZeV+KBBLEiJNoujrDxKrzB9GqAF3rU6RYt3s5NsUz?=
 =?us-ascii?Q?P6mvo/CA9TfBnkDcysDIsTTQFKuzvUwGQ653FUYaGo2R7miuKQl1A+fuWYgA?=
 =?us-ascii?Q?9QvTrAd/t0RoqYWhJoNC70rGO48YYPLFVDAss4jS4fdzqDXjQz979fbBCrRG?=
 =?us-ascii?Q?5Caw/VlKUfw/Spi63TUqkvcwF44TXRcQXrHiou7+rpqYkd3scCTcTv1FBsiI?=
 =?us-ascii?Q?UExnjr6vIQDXjPSihuFcuLNvM/HjWr+sJ6QbLfhMdMcPVNV1oqgC1NVstwxL?=
 =?us-ascii?Q?KuJjmUWT4mtvnx+/Pp7fbK2WtDgvYS8HFVB9PoMvItOFVHhyoc30yfCQ4lmn?=
 =?us-ascii?Q?Xu9k9eyqGw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2914a4f3-c499-4769-2ec5-08de85e31810
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 18:12:34.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c34imI866VQA9+i3C2vgHyioo9/YTsvfsDoBfUr9ipUAYxxVWusAiwik46MAaWnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

On 19 Mar 2026, at 14:08, David Hildenbrand (Arm) wrote:

> On 3/19/26 16:24, Gregory Price wrote:
>> On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
>>> All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
>>> select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
>>> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
>>>
>>> For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
>>> and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
>>> CONFIG_CMA and CONFIG_COMPACTION already do).
>>>
>>> We'll clean up CONFIG_MIGRATION next.
>>>
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>
>> HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
>> this up.
>
> On a long cardrive today I was wondering: do we still need a separate
> MEMORY_HOTREMOVE

You mean merge HOTREMOVE into HOTPLUG? I wondered the same. Is there
a reason to only have HOTPLUG without HOTREMOVE?

>
> Now we'll have
>
> config MEMORY_HOTREMOVE
> 	bool "Allow for memory hot remove"
> 	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
> 	depends on MEMORY_HOTPLUG
> 	select MIGRATION
>
> I'll try to get rid of that HAVE_BOOTMEM_INFO_NODE shite next.
>
> Then it's really just MIGRATION and some sprinkled
> CONFIG_MEMORY_HOTREMOVE. Not a lot of code.



Best Regards,
Yan, Zi
