Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592534AAE3;
	Thu, 19 Mar 2026 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928772; cv=fail; b=lHNpAHlVbDOH4G7XTrUfQ8vDClzjy2NqnUIly2jHOySKbALuDfc8ogZwuC1iBhUMT+s87A7OQqm+FYQN38QJnN5fnvv+JxmkxaGgPm9mf/iNsCAEromjhQvvZRb7a3kNyblqSswddCCdJ2tN42clhe0ewxI4vPr5XJHHMo0cn+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928772; c=relaxed/simple;
	bh=trn2bPK6qmblMArF2dYCeYY2RQivPCIzIaQgEKqpedc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bb57ZfW7sKZ3xDD87SFNXueTcvw4GWe7+AtHn/A+aq7LWmnM/V6GVC8fL4I8EGkHhse4Inex8mTA2efHEw9rGtbNdMvu5ItGrDyVovaXRer/0pU/sLT6sIflQhs/dalYKDmwusV0KZvg/BZ6tbqSsmLhy9jO43PrxPaGT5+3g6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j6FPaD9L; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j6FPaD9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyCPddHBpr/Y2iMT1U3I1QwupvK8vhimsBXSjzWatFjcXESkUcbHhGEMDRgIP6je/mnhIf46oYqc5L48nKTCJdVWKfd9n8lITxxin2jV/VBmEFnAvrTWgN52io8bKT6QT6WcLsRYAuXdFPVKbcUgvAkWehZiZSQ5t6WESsjnPTw05WBgJbt7kfLkU0qpAAyc7J7kdj95DFbVNpmEctCBXAY8/ZE1ClMKzA5pKfXT4rYADt3EpjPu6gwOYyWCen1yQS7bDdeEPS/FDbJGm7ctuLlkeYJueSLyKo6FyYRCdfVGjeUqx6Js5jUMrxTG4YyTr+Kteimw0EuUf7n7o60eVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbnkeDegTtGlpTl1DhG+dvN17k89G4cK3h8wfBQ49co=;
 b=qRp6rYx4wfSQjX8KmMOjkEI32nhk8OMKGMFoxq37nwO8mu/qewOctfrIlvoR6lkFSw/hhwpHLBudhZoFovB6CDlvYRI7kyqmZFVtRZMHKdckeiHUad7jt3Jw7ZZaTiRQYhwuUdrHpmA0RtZUD6GxFYARG2U5NCZR9dz1XNH7XrtnqLgOmgvQP2uEfsRPWJ+ioJnee+diUSStUlBER25iYqdeJnk/TUUl25lZKD9q0Ot7hfgCBl0BGsCm3kCfg9vM6AKjOV+7lokvkugYpJEdL8z2HrEf0lmHpaV8FgqAIDSc6KMRiBB1mFzqQrEuOyRiTWZlEpADl5824Nl1WVSBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbnkeDegTtGlpTl1DhG+dvN17k89G4cK3h8wfBQ49co=;
 b=j6FPaD9LqzF2X5OC7OOAOT11uqNUS2ZY2UM9cd4p26XX+FAAYCblOAXAQAzuArpZh/bHpUQr5X4kmq2WU5XySL2Z49GycUotGaFUbFHuBBx5Kowkthw3sgMRO1ckB+50wT2gv57mj2unR7L3XvsqwR0mPdd1E5b+8Ye0wBcOVWXy62Tfap2P25pLoq7rgOouxlGhv0L5Z44q9ng9ZctOBHz/vGnShrZETA1JtiGUBhhdOmz/sfzjJ+bXoVoCHJE8hBGiQLnoC8gsUgNZnt2pK2vJHvfOmYKq657wx0xOf06vqmprpisI/orY8IkMP/ayMDaNkVp+INm5PuEAzjW7pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB999108.namprd12.prod.outlook.com (2603:10b6:806:4a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 13:59:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 13:59:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
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
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Date: Thu, 19 Mar 2026 09:59:18 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <3149685B-963F-473E-ABF8-916D41AEB4B7@nvidia.com>
In-Reply-To: <20260319-config_migration-v1-1-42270124966f@kernel.org>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB999108:EE_
X-MS-Office365-Filtering-Correlation-Id: 960d6495-a2fb-460c-b6a1-08de85bfbb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yI4d3EWY+nRTmA2sUUBMYPx8nuD7Cf/jY1FbW0brj0jrlQg9kqDPTxdHFV8bMcJJ7Qq+Lt8gNLu7AkOjrFZAsItiNTN/L0s8U52/7aiCshLIKh0x+i5TWRxqYhCBh4ErsO6PaY0QMfgJ0cGWlcGB8hDAV9A77M9QdT5c97LUye9T4p2OVRfjC/BaDhO8aSQBdpWbxKqxT/VMcKyQF90qSmPhpLn7IS9Dn6emzf/MwAkJcNXCyrcl0D3coLEGU9crp/Ud1muQVM8vvo6JT+T1/n3alY/cGf6Tyj6toTL6lxPktsO1g58IAnGvRJUY9QDCx8mQD11E8KeP8K6ux2SARLilCnxHxSrdozw8WEoSUff8i+E5sWmKVgx88jsvubyFkRqDWo/yGwM0/PPNHfC+vLchaoDet0ijKXN3Xx5+n6KyitlTYLXjdaaZTU+IvR1/eVfeLyQNYuUcd4adfdh2NteTiO7nNQ6pj4uJXl22eeMGnuVsG+eETH9SZioc90+ImbTw3Lau8i8gggKVrz8lD30cZdZ/TCjLnrOkqk2nE7rrhSiNHA8WVePXpMKVn3DScJ5gaKD2MGXIKsx0LNLAigWBUmaSqM19wNt18DXNZmkffpKkhbx0DRatjXWV516/baRQEW8fHrPamvNJMtwSbiCpqwgNn0sCjW1PpFKqtsHKpn/czx3NU5YElH2F0WyFWxS3F0lmY1O0iKnWdeeUIt2pgCHQ/+jKv8lqOxi1R0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWlr7GM+Qbe0UFhRvCRS74i8dyqXLFtZDvTFrYS4/pEoD6CQFenMMKcr21VN?=
 =?us-ascii?Q?RbdXpEhSxiOEq0xESYH/YYfGwmZ5K5qfzjWXUOPzTuNfjQra/3DcYXsYOmQo?=
 =?us-ascii?Q?yApb6a8RKEMmfSgGWk6kkQ2ZOsQU7Zdw8d+ILzk3N/WXrcj4fzjWDvxhMbXq?=
 =?us-ascii?Q?6PZMpstQHjHmK/OrOQUqkTMWc5VbcfIqLglxqTbv3yS1LgrzlNlGhqmj4DdJ?=
 =?us-ascii?Q?5Fv9RSvOfFQ7GEKTUOPiVMq/E0IW4LoD7iJeaFcUBsDD4x95hgP2MRl+A9vY?=
 =?us-ascii?Q?GDL5uPd/L8hFjgE9c1A4ELTHias2DtvaOAYrZVQ+sWq/St7IK4Z1chFV3Bsu?=
 =?us-ascii?Q?IZU1pZsZ2uVh1ll3U+XllSTwILnzM0YPKmkNTIqKBSRMnTxd2h5dgZzpMiOj?=
 =?us-ascii?Q?2gmpuOdpbN5BlwmM6Jd//hihcEysiT9a/4JpBQj2DyLRcxCG0huQ77AvTXv/?=
 =?us-ascii?Q?riZMZooBLIaUUaQ4oLrpjH9O5BGoj1NjV4v9ghaeEUEe97D2G5p9iRiNjwD3?=
 =?us-ascii?Q?2fbvo9VBQAFuoYCHYaaYQSAHoulJhSLQe6In+eErXuyWE6A7htrUoNMfj3Y9?=
 =?us-ascii?Q?IsDDHqu+m9zXWvp3/hP07RRNjqjCWwG/ARbH4oJnsykhJaUNCrn47oXmx6Uz?=
 =?us-ascii?Q?N1qCh80j618E5hKGscqfdBgirQEJOk/7JVTxSTkbHLbh0u6/DByiSy4V6OW+?=
 =?us-ascii?Q?xbVpFouUbU3SFRVJyFVNVJTE01ox0oK9FetGQ1fxGXrWoaqfsO55tQCmyjp+?=
 =?us-ascii?Q?+jXy3816CvKr4pMvFST11s5KZCkn9qRUXbkdKpK4xBVFsZT5PebH3hWhklej?=
 =?us-ascii?Q?077Cr0CX1Ip/Ht02tHFk1gVx2FMohBCIOVzmboXbvl+HubukHYd9+lSrkcfm?=
 =?us-ascii?Q?5bsbOFPtQZp7CH4U1z6ZuxfJ2L4cCOaPRo6I2ZIppGQZ4WrnXpHbKPczOQ3s?=
 =?us-ascii?Q?bUckdlHpB9w0Pq2bUmon/Z6JIVLhEq3O/tEymtgGYIPN+24jaiwPnob8fUrx?=
 =?us-ascii?Q?IwUo80XL+DqT0ZGJX1Xstm4d/Q/YaC+3waf+sNYrg+9pABEKJAI/38kqgN/V?=
 =?us-ascii?Q?Jl+6+EUmuNzlEQ96SRom7aRSwzhyMKOExFFiQPS2FTibDEfevb0xiVm7IMLh?=
 =?us-ascii?Q?Blo185ZAc2erN7Ex8frktjkYHdO56DRmw8t81kLz3DbcHOuAOpkOu1wi9puv?=
 =?us-ascii?Q?1Ymnn2xqCnxSiPd08tm/plWft2NBoevmNwNsGK+vluCNbb9JtupIbkhCZOPP?=
 =?us-ascii?Q?rJxmuQRLuqQ+/v63Hzu9v2lMA9SISwL/sIGXmlDJuyOOQGJuAgo/mr8JdvXN?=
 =?us-ascii?Q?KidOvh9xWT9I0CvAf5PdVw/NNZMtjkA5QfeeJY+jK2X1Yjdk3dHqCbXmHl13?=
 =?us-ascii?Q?QHCBu+allyoV8WQEV8ArQuxEzaq/m2ve1LcdBa1VzNWTulYgk7a5s35zNsdm?=
 =?us-ascii?Q?VuTJgco1In8mza/jHbd+smurlC+o9pvOQDwWW0ZL+nPN4hqwImbmB1yT/Ihs?=
 =?us-ascii?Q?7ce33QXVYWbFj4X9USu3xLMaNilq7QdbfKvzWUi+wKSCO5siYZCx92EObNjx?=
 =?us-ascii?Q?e7LHj0TgEaL5tgTiOHD013XsiN+pVLhmsqjkRpbKf7e3PWEL86aoFJL+f03v?=
 =?us-ascii?Q?mTNFnz0O5CM/nJPjRXWgA/8387JGjSJara+8STF2CGLvgyENdw4VBnCNRoAs?=
 =?us-ascii?Q?lMk658LAYNW5uXKfhgQGr7AZOac5Lm7nB6kPf3erSJsM8MowJwpFYEqIR4qv?=
 =?us-ascii?Q?iQ7Xy2L7jw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960d6495-a2fb-460c-b6a1-08de85bfbb91
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:59:27.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywYTzJGDYYjf6VoPyKO85bKBKhFdsBcSPj+10+PyWKiYnq2whU44+Z1zL3/dQtBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999108

On 19 Mar 2026, at 4:19, David Hildenbrand (Arm) wrote:

> All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
>
> For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> CONFIG_CMA and CONFIG_COMPACTION already do).
>
> We'll clean up CONFIG_MIGRATION next.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/arm64/Kconfig     | 1 -
>  arch/loongarch/Kconfig | 1 -
>  arch/powerpc/Kconfig   | 1 -
>  arch/riscv/Kconfig     | 1 -
>  arch/s390/Kconfig      | 1 -
>  arch/x86/Kconfig       | 1 -
>  mm/Kconfig             | 9 +++------
>  7 files changed, 3 insertions(+), 12 deletions(-)
>
Makes sense to me.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
