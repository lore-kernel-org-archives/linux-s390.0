Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252DA399890;
	Fri,  7 Aug 2026 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122080; cv=fail; b=I1I/RKXBCJAglcJZoKGje0y6dO7NHEV4vmjRz9er2WDBy2iFFEV4vs0en9qBoDo5gbzY2qWNWginNkNybS1GhQfXC/zYDz1AhdjUShkafe0afHgqr92bkXPGMgDi+pyQwY84xH2Xj9A8teJ3QM+++WZcttip/L2RcnnFbonZD3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122080; c=relaxed/simple;
	bh=iQATLs94iixMMyAe2vmUAcz3aCIFqdfNTw3DDcRNiyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bPZ8jB4HAFUtXWvudM0NeLsTsfMihs1ogvywnjVTTxrlY3Tlu6zG1Pgrq5LCDE615paukYDzfyoLKVbP+Yqwk/sHeIaCfFNfspy/okmFRlGebmfJsRjQncrW0IzvuRRJG69ZetsLAt9aWsoCM829hwU7QR0nQO+zszToTMJc0Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3KS3WFY; arc=fail smtp.client-ip=52.101.61.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3KS3WFY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUumVAv/8f0bCx4HBs8PKdQj1WnFBkjLUZfU3Rv5jHwSmUHhBLcjViMhd49uGBjQLbBM+Je1j8snAdC/GYDqH2DK2KzCeFbcpBe83pK4ZrnwUOQvUUqljl460w1NaVF062PKRVqTCi//PHVJPYBVm9TBMGXe8F1tK5DjLC7//lzkWhX1ip+s4Gq5h+330Vre4qn5ZBBQAYON0tKC9iD9buRSxouknOL/yQi0QJAKvO8Tnfese4ns1JhSm5fwCApPdtwKol6OxNNqC/OX+5VWf2mxtNtGX1kobu5B8JvSb+P9V4VqadzWDk8FRiAPGkNxAH0kKzlRYx+4VM1SB5KcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKVLhd1nZ5h4b188dd5r7DRqSKQCAYkPGXkJXHWpxNw=;
 b=cgsLXWalWVYCBj71HcluYgAFV5o8exMPgznZdcTXBZSwaMA0zv5MdpY9BxIPYsMusj5XPEyehSgtpSH3+7vOYMlvSQvT3MGkSUFQKrKyzQS5MdLDMh4MNQKK+wfW5AFBuaSV2j9zmiA7GhUh7v8rCGs3Gt2A2P1K/PJTZF6WKUW4ZbOeoIrxsResoZqEm6Xp9VX5lPEeM6q0HQ4UEemwFGVNLPBfaR92oO/TN+fioiRdTk0if8ceAQS8DDVIbDCcJ3FUjko6tGi6bkpmOwrTYTjVzkKqzULLOVi/Tnlobu6AL0wP9VD56moHxuojIbvh1um+GsTRiMIX6Pder/WykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKVLhd1nZ5h4b188dd5r7DRqSKQCAYkPGXkJXHWpxNw=;
 b=n3KS3WFY4Pd+aS3n2h3p6gAmSZD0swLSMs1vBJcYHevSfHBIL6kot9eAAEKn4euM/ps/m9/8vMC86n449ZkzoJyisjDxBJ5mZIpZ7KL/Scw6jBWvRoh/iJZqleI/S+TkTnp6g03f9mytP+kJc8KWfDoBLSWytLfLb+m2cc9Dqe8LA0i3YQ4xxu8YGKg8a85WRcR6Up5zwBsOS/cArvUBzPet+IRm0/Q8aHBxUnVIh4KhhX9aCSH4llKsS8hkU96Q/gEGYXLyVu22qK0DOxjV6pfnLq+5J2FPP3TkAd+tkz1A3nAZCXEEG3ZcDGfPs6kmyDWf5JYAn5GfgAY7x/gEMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Fri, 7 Aug
 2026 17:01:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 17:01:06 +0000
Date: Fri, 7 Aug 2026 14:01:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
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
Message-ID: <20260807170104.GB158689@nvidia.com>
References: <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
 <anL9-OrDGqYQAWNV@google.com>
 <20260805123023.GO27883@nvidia.com>
 <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
 <20260807115500.GA158689@nvidia.com>
 <aefab683-598c-4cca-b5a0-c9081ccf9e1c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aefab683-598c-4cca-b5a0-c9081ccf9e1c@arm.com>
X-ClientProxiedBy: BN9PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:408:112::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 3197774e-aa91-4af5-08dd-08def4a5782e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|11063799006|4143699003|22082099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TmTctxJNrEvbadwM6ehviUBJp/fprcKz4yw2emMklxX0Ap7wVavsomoXwkIDxa7GeDSMgmPVY38T3c50nG5hb7dl1LomTvlapYwoXzlFkgIyRnzpRdQY7A67NEsZ/qafoybQZE1xUru9ZFzUNUAUj/AX7m1C2mdvrPa1o+7vqpf2ce/7LQCMTaRG40rL1JojObwOWhyI+9qwXo1ITS9RjcU7khWHT8/zMOzM1ZnuIdbr6U2zVc3wNOPGqKy8EgoJS0EvuLOGC1M9xmjygHiZ7DFO6raCgGVmSC97n5F7IfRImWUaOFRoiU9TlRkGiTZ+gtzswoBKnI1aX6rwAZ5efv4WHA5AAEI+QzNjs+5rw/xhhp/+r6IlDrXAxLoYGRReGSS2UN2PcqzBYu498Hih2+TG6crt51Uj59CVNjX+iaX0jEJF/qKQ34GetUuMHhqfnkZ66XckpZ5meJSyl7fgVcJltipHf7DeEEiuPuSpgFCjn9w9Xx+LPcl5+/7ym18KXbydndhIMmrJS8N+PThjViWSJzRbNOJU5H2firAXUNal6HzUGYe/EvQle1BwOaJLYqYy2QLhqSH8ptQ4TzgA1c+y+P9+ares7UGD7bUEZjW6+arT44zkxPfrlL80v/0U9Qr85yRF3WE9ff9+xnQqMEUpG/OtXBITO53z609KBIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(11063799006)(4143699003)(22082099003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxVGUP1tf9Xo8j0QmRgguvkRJ8zU6l6TNIdQLIkIvii0vssXiWiIOWN8AVUd?=
 =?us-ascii?Q?zg8f/QqMcuNCiwdfmGOAWNX5FHzuuqYZ66oNGkzsbSLxNbRLERucAkfzOVcA?=
 =?us-ascii?Q?gwuc1I9okwGW50MtsWeCyrjIkbGpqrdXJ8eLzmDKWs0KMdyxWaWCLEixQk8Q?=
 =?us-ascii?Q?tLINT3rSZpGze3h5BxExlJ6jr2sdsCKeLPeAgXG2CmSgiJQM2m5TunMloQVM?=
 =?us-ascii?Q?UhfYl4tDW3b7YZhC6pYZMV5I5Z4Wze4yOenDZD9mWUvk6k0ChyJPaBd+XChO?=
 =?us-ascii?Q?07ztJM1DM5TeP36ZCYwaxIeHmF6DMQOkHDATJZhhyWkEMVFk8str7qKv4PjF?=
 =?us-ascii?Q?i2LB+Wfxwb26VtR+7k9hIr5wkHtRFAeuJCobIwaxMwbgrOfJBGeSgn3YaLP4?=
 =?us-ascii?Q?HHkdrBBEfzgxL4JTBIKY87ql4U7gh/A0IZf3r1MPJAc2yph45y9tMDydixnt?=
 =?us-ascii?Q?u1a7mc9kLiSwtkrYY1Lg+CMNVDJkQkVTEUFGdMbkVGi2ttFiJUJCZ4fjvWhe?=
 =?us-ascii?Q?kAklRsLEu+HD68Wzg3T3oN647/q0Z/ptW+IWprXR+rKMb2Ue05zepHFw/sVG?=
 =?us-ascii?Q?9a+gAmmZDgE50yJ1a9colMi5KJH3SFNPfAJwu4cdznTg+QzVAFGxwsuYGgkn?=
 =?us-ascii?Q?G2gG2rTZRTQib0K5cI3IaPb7rAHlGxp6WhkQVdov0SIb/e2eu+FSPg/rozJR?=
 =?us-ascii?Q?toq0350DAdEX15v2JkRfo38g0yYRq9G//tJo9+ivoRMm7RxDMCGK5AqNtzGz?=
 =?us-ascii?Q?ZaLyLuKqWGqAmXNnPpSUhLe0ZxMmF1rtcTz5VmpxOw0hkNdpsq880nW6ZURl?=
 =?us-ascii?Q?xL+KL8NO7oiiv78DAkgtr8bi45Oy9RZcEgl+3uVrzRMklB3XNjwbw0DDIUUw?=
 =?us-ascii?Q?ac4bTUbnqbLhDMaTGVinFqHXidSQJx8C4hwBfLU+SDY1PRVOaWi3jpLUoUdw?=
 =?us-ascii?Q?QXJVKXdAZ8/5s6F5nQMI7o9JKl53J22AxCZmZXgfRKNzIScaMTQdZn44wmLY?=
 =?us-ascii?Q?kPEAjqtY1dVVctnd6Iu/fnG/WXRTwcwncBOChCvh/3PC8cKrGyuOCsS+fQw+?=
 =?us-ascii?Q?sxu36v101WcCn240A9zf1i53edVjw1QDzcnsvovVczTNy573GdhTxjnpZt83?=
 =?us-ascii?Q?CIoYb/nO1GQXStJjLZFZ3WQ6wOUnoCRJQw+Kg1Lxe0gvDMd8tLucLP5VMDCU?=
 =?us-ascii?Q?lejeRYbAl+opHg/fd8VylK9y7gzdM8NJNnkJVQDBLetwbVU7GQTMY8BvbkJ/?=
 =?us-ascii?Q?fGenVHbCer/vsCAtfTs3beY6tIhxz0oWnyrMzgV7uk9W0lufSYqXhabpGQLl?=
 =?us-ascii?Q?yLfpdf4r0fXhiprx4dvUxRnupyhZIviEA3xorAvwuTLbHxbjIUat6HmCmrlv?=
 =?us-ascii?Q?Bas/IxgCLIQ95u7qvQ+zaydSB1OWGAgW9tUxKMdJYXWp+6MmpQTX/EzejFqf?=
 =?us-ascii?Q?Q/2HsUpw3dqgUPAC01wO6lL3woRFTN59nBVqmeG3MRao9sJIyJLxlH+2SD2p?=
 =?us-ascii?Q?W0JqKaC3jlutcE1Yp/vVzoMqNAoVmia1s7u6k+TVyacamJHFOAqlhO+agu0p?=
 =?us-ascii?Q?vgOp/mbJpAAA34Rvu7edVK2Xz3+a9ul2TtOrJ41+eA97+hUhhyLeq/avuB6X?=
 =?us-ascii?Q?FDtkfa9jwKFQRgv9VQHgeoWr/GmZRdVdhbVY6ZcCWnNHXE9vGtUWtClj05ie?=
 =?us-ascii?Q?23w5/XZtDC8YsRd53/qoFnCYZ8BqK9jK0wZCbOMsVxAs1kMXOJn8lW4pShrH?=
 =?us-ascii?Q?IKBuE4+22A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3197774e-aa91-4af5-08dd-08def4a5782e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 17:01:06.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyBUpASbiSJd5Hs5s+e0CZXGjcECJ2aiyh6J6cRnwCWS1TVyi95Yr3eB2zAypUxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944

On Fri, Aug 07, 2026 at 04:54:35PM +0100, Robin Murphy wrote:

> > We will need to teach GIC to understand if/when the device uses a T=0
> > translation for MSI and then use a shared physical address for the ITS
> > IOVA instead of getting an IOVA translation from the iommu. The
> > hypervisor will setup the S2 for the T=0 SMMU translation to be
> > identity with all shared memory and the ITS page will be shared
> > memory.
> 
> IIRC, for MSI or unlocked MSI-X it should look and work pretty much exactly
> like regular VFIO, as everything can be mediated by the VMM and host kernel.

Right

> > Presumably in future we will have HW to handle a T=1 ITS page access
> > and some way to negotiate with devices if they should use a T=1 path
> > for MSI or not.
> 
> Locked MSI-X would be a pain right now as we cannot intercept the Realm
> programming the MSI-X cap with a doorbell address and EventID value decided
> by the ITS driver in the Realm guest, so we'd somehow have to sniff those
> values out of the VMM's vITS emulation then try to configure an equivalent
> NS LPI to match, or have a hook in the ITS driver that knows when it's in a
> Realm and do some RSI handshake to proxy-allocate NS MSI vectors on the host
> and pass the real values back into the Realm.

Yes, we'd need to move to a model where the guest programs MSI
directly and we learn the configuration required to emulate through
the vGIC, not through MSI trapping. This broadly is the "righter" way
to do interrupt routing but it will be hard to get there, if ever.

> I'm still hoping we (both CCA and possibly Linux in general) can get away
> with just refusing to support Locked MSI-X without GICv5, as once we have
> proper Realm MSIs with direct injection then all the problems go away (or at
> least become much smaller RMM problems that remain invisible to the host -
> the one "big" problem being that the RMM has to begrudgingly implement an
> entire GIC driver since it now has its own whole GIC to look after).

Yeah, I'm fine with this, if GICv5 can allow direct MSI-X programming
then great.

Devices are going to need some way to negotiate if MSI-X is locked, and
if MSI is T=1 or not, I don't know if PCI has something for that
already..

> > There won't be a vSMMU attached to the T=0 instance at all, it is just
> > wired to be bypass.
> 
> If that's all anyone will ever want then it does allow some degree of
> hackery like mirroring the whole of Realm S2 in an equivalent NS IOMMUFD
> domain, then forcing IOMMU_DOMAIN_IDENTITY for unaccepted devices within the
> guest. However I was under the impression that folks want to make meaningful
> use of devices while still in their untrusted pre-acceptance state (but
> maybe still switch them later), so it seems almost inevitable that
> eventually someone says "actually, we would like S1 vSMMU for untrusted
> scatter-gather as well..."

So far almost all VMs today don't use vIOMMU at all, the ones that do
are using it for things like PASID (or interrupt remapping on x86),
not for translation. The cases where a vIOMMU is deliberately needed
for translation seem to be mostly around SVA and PASID which isn't
going to meaningfully work out of the box on a T=0 device.

My prediction is this is fine. 

At least it is sufficiently hard to make two parallel vSMMU's
controlling the same PCI device, and to make the ITS routing also
somehow work right, that it isn't worth doing at this point when there
is so much other more basic stuff to get done.

I imagine the ACPI might someday gain a description of the T=0 vSMMU
in a way that is invisible to todays Linux and a future Linux could
understand how to juggle the two iommu drivers for the same struct
device, somehow.

Regards,
Jason
