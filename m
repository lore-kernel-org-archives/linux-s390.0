Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C826ED46;
	Wed,  5 Aug 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933031; cv=fail; b=Qr2LzVKdvrv0G4GR0A9pCqkcTjRfeUb5xXZEBjNZct35qDNJ3CzQNSWMlG+1CBETJAo7Kd0zZ2mcXiN4MrE+fUZ4oEaYRxBGWNQrrTYSjXyLuCHES/mGLhDXUKV956KxR26sXrJt3kwrgZBAZiwHFKl/Rl2VerQQGwMXqT5goUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933031; c=relaxed/simple;
	bh=QTnLIjfA6T8toPS72sYvz72PXPXYr+HxZS3UJtNuWJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SkRs42s6dXQPngX6y2b87o8rJi31nEF9Nqphw/v0vmgCfnl3nFbCIJ4Qrr4KggBOEbYENyg0sf/4jzn6TVTpRMKGhFU8onuJPkXCIJcLNl3V6TgaCjVeUXecFQocskNjxidKHmSO64Ud55zvfQJnyWPk0r4s6bCEjLETmkcaXhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MKDGdRlK; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MKDGdRlK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHg7Pqy25T1EHcgljCMLNjJuRPyEm5Tm8xIwNQxi154dmvQaxxwQ5Sfk5Zr1bu+HYKYwn30v6FBIPFAAkSsohBd9qXxRaHAvXuyqtx0FuYmPa4wemPCRkMiuDAv4D86/ViFBDd94eZtEOpbSvAhMWFvPukWS9jGgvFXdgQUhd0/dsxzN94k1pfZeEa+x1iFAZliadFZaGTFhxfNaBZRSvX1v5v6HQGTPxA9h5YoLx/q3TV2/n0GU/MDYB0hsOWYKTaZs9VkoHoAY2Oq5BRHm4HQ1jV46GhoNcGtSdLgqNJLgp/bZm6Ve7PtRBJuhZyzzDjA2floBpGsApbNHKdIxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox2xbRLxNvdqpJFmgdEJg4jzYCu9Zb10QHH/V8E5mn0=;
 b=J5cAUlCPGO7XGnJjd968I77MnrobAxioxdSRBUM5FQpspKNsY/6F5pwSbUFD5rFdgyHQb3+ytihLz2wLViZ7x2vRY3oMf23x667ReFqT2GL+6uYN39bVg/ZGxR2eUBHDnFswYEE0ctM4M45IXJVTtM/d4XFTc7JynvGy/UUwtFusAZhQKajz5FTuwvAK1SVxv0DbbMYwqhuMTXyWgNTcKZIfYlZhF1eLyWoTo3PzfumItM5XN424YDKpl46axijZo0Zn8beaVzEhOt/wGX5qk6o2FwGjMlhTp184TXde4VAAYIJeb+QUbqxlpRfVbaVLD4vD0lBzUeQIwTsn6tckgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox2xbRLxNvdqpJFmgdEJg4jzYCu9Zb10QHH/V8E5mn0=;
 b=MKDGdRlKhEgo7F2ULcO8dm44E0sNuHGjxPBIwyFLQU51nhvBCS7veG5Oa9Crj4LQJikt0LL1cTsw7dI/yJ1D+nnUuX0dfww+k4pznjZVeYtphfNfTCKan3kwMp2HXXZHPY9rgKauD2BHGoq1CBUbRT443eI1iJCAQHGh0erBq2fj6BxFyOHVghOyphLqgTVwbicP8ZMNW6vxUdgZIexCsT9XDv71/3SDrPZQ4KU1cUJleAvSEJg3CKz5BuynnJExBgY/o5tfWUsG1HhmeYisGrZUDGBXEwwmadQ94+nVV26w9rXznT7FiaayOsIWZdyqFSV6R8L6hnD78fexmViTbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by EAYPR12MB999132.namprd12.prod.outlook.com (2603:10b6:303:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 12:30:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 12:30:25 +0000
Date: Wed, 5 Aug 2026 09:30:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <20260805123023.GO27883@nvidia.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
 <anL9-OrDGqYQAWNV@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anL9-OrDGqYQAWNV@google.com>
X-ClientProxiedBy: YT4PR01CA0449.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|EAYPR12MB999132:EE_
X-MS-Office365-Filtering-Correlation-Id: 693df1b0-8bad-4c1b-433e-08def2ed530c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wtpreoMMSbMNkvVIQRVqvnZb64uPO/ftJxH026TyI2TzinjsLqw7pGLDEkAypUGJMmAcdbM2IY90FmH6YKekynfqyKGced4hUOuk9RfrciCspsz4NQJFTPsrpRl5z8AE+5yP7EfQEaHeDyVbP+mAexfUnm5PpXvtZ/vYMp/Th7N5r3q88w81hqhFqqWLuWxkXirkQvjH8GAhF2BjYZvOfAkjTJvGvqCSBheB05I/rJwAmuXhNMGSkBqD3gq4sLcuq5Xx8WOeOs5fu4zM6HE5ciMtyWNJZHXeyehPBcbaSyjngsvB5CWNz3umZ0gkaEw85yIuFxzWr+Ez8+J2ReLWnHOVbzCtZ/U0snRYGtVQKTFVTCP9NIQN2aumWCfasdKIILrze0GTmHp/SzOEc0Y/o7oYPSpJAq2LjRsZqGwRKMGE6pPWbEhfRrktnXm+Kej8dAV5Dd/YnExy1kJB3mkBEd9UE1MUqYCIZxDxhZP5FRAMX02KCbiP4y/Os86P5SG3d5iUCLFcX1fNlj8a7Duq2Uo8e54Lv18GMX7lhsMFgC0SJVk9tA91SAQrucfnwnkeCBy4rrQM9+3cMMVN4jUFO33344zWFqI3oEQRFdMI0B5rtI1sFZMTJdxfncy/3yqov9rEQaTCL06DYaZ9fwTE862u/SLRfklyfilqlxzi2i8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhdvWWGfiwCzol3+AUKdUWMHHE4HWALFFNYMRE+RmFsR/2v0ODtmAbuAIrmW?=
 =?us-ascii?Q?++YuY5qxNSSGbhCE/uUqv1Zjre7UVbCER/qCW06WVTAImbxzFOP7BV0KHQju?=
 =?us-ascii?Q?vBuuCfhcl9vk3TVlXgbCJikyf4g9V69eZfKjeyHVYKjZCQUP6/96b9u2FrXy?=
 =?us-ascii?Q?EXkfC4LFf5h/97MPvBYj7HtXF/lW1Q72gmOXNPYUUYwmlNK9oLOBnS7uvtqg?=
 =?us-ascii?Q?+9KvvEN5Ap8UTSJxNyrcCyGm39bMV9f+msR9ieDkLSkEwZirn70aGektH7ul?=
 =?us-ascii?Q?Wir3QQsAufage7I47Xnxol6uEKRuCWyQo+2FxZlDl5rw2r35ZPHJzrhABDSV?=
 =?us-ascii?Q?nQ2OCr0uTwo+hd/CCA4BfENcsgXUNGDKNwyQ7C3yl6AVihvvU9oomRTSES9X?=
 =?us-ascii?Q?66CnYKuSc1TmuRXXaxtdf0f/mhsJh1NEeXxqP4MiLGub8FrdlDQaQsHiGo+O?=
 =?us-ascii?Q?bhE21Pn2LEjbrTVyZhtQYWw/xUiQ27AwYXKFS6KLOi/xawx4KlV19LK6o09U?=
 =?us-ascii?Q?0OigRMbjTxpbvEY6mHKRjOdc7fd1VW36PnM/JQ/4AobFA8EXl7IjJJ8oJmhV?=
 =?us-ascii?Q?QL/SE2wISFBJucIPsPumh62swZWFbj1Fl8HpiqfcbKc22jCeXnz5rnSngtrY?=
 =?us-ascii?Q?WoBioRTvqcEmBlOOsmPDMelFg3yqC+Hac9lKhr5B22c89P/v+2inJGhvUP5S?=
 =?us-ascii?Q?TadWy/uYUATQIbDhMBEoMQjgqmCoFoJ1e8Qa0S2TorUtCaAOfxHdnzpCYVaz?=
 =?us-ascii?Q?RZMm4pEJsbUuFwg1bUQs9cBjvAKqkvAwY18LtVIML/wLcCoxfog1FNJr1Xe7?=
 =?us-ascii?Q?0JI1ywQNQRuAJV1IEVNgJPIQVSJuc1MUxS5qDkD9HV69GKczAk+g38sa+vHx?=
 =?us-ascii?Q?7naYCd1KdDssmBcCL0e8DBr+kz9RgjbAu0hkP6JZFDht1PxbaZnshp2T1Ws2?=
 =?us-ascii?Q?j/an/bIzYWCs+GSsxmf4saCwUi9Qwt8p5ctqftcc2iOzU/aZNffGSWdcTWop?=
 =?us-ascii?Q?hHoCgzOarMuljYizaEyWVXAwzvBmaSwEJ5eLXxQWtjdDXDhqOyRSOiHP40+Z?=
 =?us-ascii?Q?mAeIZzTGQiNsNHrnaZrtgaLMMAClk2eSvN8qtLC48WvM0x4bk+GT/ZXv5HOm?=
 =?us-ascii?Q?Tww27yTLgyTCRHtucU4XbLgBxbeBTg3aKaF/Uf9nYBABBxbgSsCji7sMIcBR?=
 =?us-ascii?Q?o4qUUXOIGSAxDKY+DMqaxfQgQl0eouNSDdO9e1ZZ/OZicVV4bph6Tf7hnZHA?=
 =?us-ascii?Q?udQOE0V7OSTJEZRzRCfYATnyQCS9qkpkdk5QUs9F/EwcX35CHWxZfQ+l+tlQ?=
 =?us-ascii?Q?0UZqvFtnxhnoZECLAfOBTeVsBry1Lj7JEU0528cPZ/kWNRlbzMhRA5N6cFwb?=
 =?us-ascii?Q?91eIDW939hdE1zKt68NPqswU9YUPZ22jYJnFHhEwF/cBJmLMrCcRRlSAZ6PC?=
 =?us-ascii?Q?LYmutjcySr/n1pfCMmLcm1UCc4MsRx+SBQprC0bweGx8CULgSFYOQfF2KkXV?=
 =?us-ascii?Q?GgEcXTpWlUS5nX+VfBOVL/aKhyCJPJat0mgs8o4M/8RFCwZ92jeuLNiYIN/t?=
 =?us-ascii?Q?obhA4NG10RZeFaZB1rDR7JO4ZV8nObjNY8u8u8QBZLN4xX/gy+IEY9VXuTpr?=
 =?us-ascii?Q?6gyMbpy3WJ73qzF1SmH3e+HP/KeeY0iFDWjUEobitwCrGyJa5+3m+wtNrdKp?=
 =?us-ascii?Q?PKWjgiFUGpIO8Gn1hniVAlB7vMjyz+JRtEViMNPoGPScTyYfWmA0iRXChWL2?=
 =?us-ascii?Q?6a91FZ2B/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693df1b0-8bad-4c1b-433e-08def2ed530c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 12:30:24.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnEE0VCiRX+7FvTKRW2hbsqeIdcBOCg9gwb9qK8aHHGB4wwY9TBKfnxLggJ3Y/Xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999132

On Wed, Aug 05, 2026 at 09:10:16AM +0000, Mostafa Saleh wrote:
> On Tue, Aug 04, 2026 at 11:20:32AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 29, 2026 at 06:12:38PM +0530, Aneesh Kumar K.V wrote:
> > > There is a possibility that we may support io_tlb_mem with cc_shared =
> > > false in the future. As a result, only swiotlb_map() knows which type of
> > > bounce buffer was used, making it the only place where the attributes
> > > can be updated correctly.
> > 
> > Yeah, +1, the attribute should be changed at the same effective place
> > the source memory is changed away from what the DMA API user
> > provided. Only the thing providing the new memory (eg swiotlb) should
> > know its properties.
> 
> I will keep the conversation here instead of 2 threads.
> 
> That seems like a big leap, I'd be worried about devices that operate
> on confidential data that should not be shared/decrypted.

That seems like something very differnt.

> One example for this which exists in pKVM (this part is not
> upstream yet) is non coherent devices that require bouncing but they
> still want to keep the data private. In that case ideally they get
> an encrypted SWIOTLB pool, but it's always better to fail than to use
> a decrypted pool behind it's back.

We don't have any API for a DMA API caller to signal 'must be
confidential'. If we want to add one it would be a flag to check
before changing the physical address in swiotlb.

As defined today the DMA API expressly copies from private to shared
memory, that is baked into it's design and not a bug.

My expectation is all these cases have to be solved by setting up the
swiotlb properly so it provides suitable bounce buffers. Yes, this
means we will eventually need both private and shared swiotlb pools.

> I have not been following the work on T=1/T=0 devices, but IIRC, they
> required some complexity to handle their stage-2 as these modes will
> be emulated differently (for CCA, RMM vs untrusted host).
> I was thinking that it might be easier to represent those to the
> guest kernel as 2 separate devices (bounded to different groups...)
> where one is trusted and the other is not, and that way the DMA-API
> can have strict rules about memory sharing.

No way! That's would be a giant disaster for the driver model.

Each struct device will have a flag that shows if it is in T=1 or T=0
state. The flag can only change while a driver is not bound, and
changing the flag will update the DMA API configuration.

A T=1 device should have the same issue as you point out for pkvm, it
really needs to have a private SWIOTLB pool.
 
> Otherwise, SWIOTLB does not seem like the right place to me, as it
> does not understand the context the device is operating in, and the
> DMA-API should deduce that from the flags passed.

It is exactly the right place because it is the one supplying the new
memory. Context is irrelevant, the flag only describes what the new
memory actually *IS*, and swiotlb knows 100% if the new memory is
shared or private.

For your issue it would be appropriate to add a debugging check that
the new memory is not incompatible with the expected policy. eg a T=1
device getting decrypted swiotlb memory is a bug in swiotlb setup that
should be caught. But that's a debugging check, we expect the swiotlb
to have selected the right kind of memory by construction. This isn't
done yet since this series doesn't even yet support a T=1 device..

Jason
