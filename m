Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C74734F0;
	Fri,  7 Aug 2026 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103719; cv=fail; b=fA4O8LzvG5AHt1GNvwxjddbUrb+Rw/D0aSi1rxnQCliIRUrefiE1OokYS0VNlMxrZ6S5LdEGyO8OG5R/xPwOGapaMXvzfNv7oq0eDMVnU53mQVtEPkEdQPSkuaDxVaSe2KNU7hXrJnfBDF5owhKGIhYTqWYeW/dglZ3D0Wpiw08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103719; c=relaxed/simple;
	bh=7+pMBo0D1oPqug1R2vw22mv/rSGkcVmV9LIozQQ8ivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WaYnVCmKXZqotzwHYhPK1MUVdcv6PXBZ7ZBkWzlBV+/z0Dv2juhBzwS6p+ZQN6jd6Ez7ERLSEaVh/pfxNGYcVPLQeh5tLFZ1MzsgZzl5gd9d//NbN7ITeSOx5nrYj7R7iDlhpn4JojQwAP1R7Z8FM6jPalSJ0xZGtCkBJAgq8C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qg/8qO+X; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qg/8qO+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xP+DfLo53U1h6y3er8JKdZEG5ni8I+dnFpgGSWIFJZI5jQP8rOpURpgw7YA+1rMYcO1zvhPgYGuG/P9GrsjJaQ9ZojUdacbLsC6oGI/8XzBdYZm15boV5fsnCBTzkZB0euPL4JqAtFq7fyMZPlJfsEDRMEOhhqWNG1L+vD+1fkXGFLESmIZ4lBKVYy2Z/VXYdjDWO9Szl80drKWhlIgMK89ZDMBBJYTmDx50/oArfd9cAhojzx6UHnqmTjDd6IA2BihOADN3JCN6+RnPdZv2AeWq5wTp/KxuhdfEgbh5F1+S4QZgHzLCCLc/Mx2SL9csoCDZHVGJ6X8wBQhWYiiznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBmiU527J7THNfS6lpBzEB9bAjO2Wf5lzjTwg6I5bfI=;
 b=WHkulhLJi99DeZwkHpkTpek/hFJ7IXDS1OvG4/CLsG8lsGJwyIZVkes+tdgLqDIwGQwGG5sXz3tFsE74iltPJslvjds7z4JRFuKyqXgPgAh8UTX8jSDBX4lUWgOySN7qMGHRM5+0ALuOi3KbH0SAHu+8BNBRNgM/LU8bpeIu/gv38HBL0e68VT3mU8b3GdrQmFDJIxrnlSM4KYkGIXFyi/9eW3JAwDlsBagg+mG1Lv9tACNCO8Ey4DfH8xxK1I7s7kIw8mIBXjXkjXIUVceiWQ+gVzVnFcaOY7WMV6kd4pnCWA1lvU9CuM6/xOpmXYioHhbY/I8Hc6Il9p4sdARdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBmiU527J7THNfS6lpBzEB9bAjO2Wf5lzjTwg6I5bfI=;
 b=qg/8qO+XdV0UXEAAxQH8MduZgFgS0SmXnxoAE1MVZ+/K3KFCQrGcce9DEmg0icpJ6RGYpABfH4GE4T+cgitHxS43l5lwN/CpQuFNEUHhQsN5EnWlbhPB+hkevzn4aWO2FwmvUIUXfXaIbFRxwogxhafSbvOjduCVUACO1nES0cQ+Odn7LsItFoLnPZZVnG1CBcTV0KqCxgJG0KXamP+opJHgeHCY571Wl44+l4mnzLC/JQBB4vdUB94mSaC0Pc3l3CDRiW4tTFs9GE4QzOufkw8vDmzdiUQwGv6R2mCkM5GRqm7aK7FUsvOWblr6xtT0kUQ7lUYlgqioVYlUI1t6Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 11:55:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 11:55:02 +0000
Date: Fri, 7 Aug 2026 08:55:00 -0300
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
Message-ID: <20260807115500.GA158689@nvidia.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
 <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
 <anL9-OrDGqYQAWNV@google.com>
 <20260805123023.GO27883@nvidia.com>
 <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: e9af5cdc-52dc-411a-1f4e-08def47ab67e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xbQd0L89H8XoXqKeFtE202UqZkFIyHYYR/0xKbAnhxMeTnvg0mjcVXgZij6WgsZijYVriqiH8xNkMpQt/OvhizoNNJTepZGUdvjoRVSOmzipPje6FN3tZYN3pZ7Y2rRcVDly963VaOqNh+Ttk5RRWaNzI7ODJgdMD68512ZJ+FFKMM1rEVXy0eoMVAfeoHf3t7alnOkjQpCPWMUYqCbK/R5F6cekuyZ7bHBXlcJOfbOZVf7zMp21qjkJ1EnBK4eJNZVNPmSitV3D3w4F7vFimIKy1ppusw5AebgCkqxX7Or0c+bfsetLXC/mDB+O0F8Rwqi95btJh76QjOmuoHO9jfxg8dcoJ9dSVJQeiJNwobp3sXB7XTWwiEtm9q+4qsalT4Xpmhe0bEnp5r825WtWiYtHpeNJsHkYnJ73lZU9+Lsk9uRi2cRUwdRjN2+4+XF4KoW0qeOLJJj7PRXmKXl/1Sl4e+eTCTegPkVdSs8aeXstaG9GvbAhwcNhD10MzBWrjjcAm7VdgerFME19luf439ql38CB859PmYy1dkLx97mPEGWz6G6mSU3IKIuwoqWalrzpQ7Myh3IV/O/+aBDe6Zj67PfX725rnOwbUZqmRNotPgUYvqoqNH3KN6Jm+2KHXgnFV8KP7axXOaWO17wS1FLZJKCC5KpyCOhm9isW1ho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bO3ZZXnubLz/+SmN2/usIWMBUKD3XznyuYs2CYG2oRzWK7iFSQjVOI6TjRU8?=
 =?us-ascii?Q?uSKoAZ+jhhOhH9f1pkPDznOYES30lNBlR99laEKARSwSVNaOIQ6ARwBc5e1p?=
 =?us-ascii?Q?xOX1rLDTO7/IEL+M7YfDt8IZI5Co0/T/zP8hzkGATViXGw7xhpHje9CcaG+u?=
 =?us-ascii?Q?+wLAzCRX3dw+NZn9QyUJ+zeA4dGldRBEhErb+69GcnoWkykBZnoVt/1+V/bb?=
 =?us-ascii?Q?BqXi5d7njFE07pH0uUxSmxiB+gtMhEa/ppwYDiEBLa1yZlnw1ah4CFIUtVKG?=
 =?us-ascii?Q?OzTemz9ZmQWxG9KIoG2Xf7WDyZqIP4PazG7RPZwDDjlAEAfuD0INtBRKphXB?=
 =?us-ascii?Q?duzF0RMxxnHcbu/zYIHePz8MfMrlvDxW/s5JDNZQGW5OQOg+wX1nC1UaVoOg?=
 =?us-ascii?Q?wGd+5wa6dZ3ZhJ06K24gddX2InBGFT4sws5YOJ/5AMLTDJ6YRp6O4sVA6SRN?=
 =?us-ascii?Q?L3CX74JVIOJ56Jn4LLVdRPRO71XTfQM1dL5CsayNcYlllALjSXh4WyN4xrPG?=
 =?us-ascii?Q?x+/eOdrwB7FDJLqwzVY1JGUiY2LF60rijclgZqQUBKNhqB+Lwf/wVknt6SE0?=
 =?us-ascii?Q?ddki3nPT72ojdrqjUA+vI7BBQQr0HLYHyADwT/LfVtWhzPeyUeDc7r/k8cNi?=
 =?us-ascii?Q?0XwzRb6WMlzN6LP+N1YhnAZoRG71oeHdP053WF03RnmtGhf6DecncL13CGMK?=
 =?us-ascii?Q?MzGs+auagCV9KC8SE7yqjFkqSFuQpakEYIAVRcscja3gKeG9nUJ8kLIxC2iB?=
 =?us-ascii?Q?QjS1TnlVV56hUzMs83Ziyg2V3IcLDmbE42mTp6uzEuuBHxiC+aELNm7GYFFi?=
 =?us-ascii?Q?kIhrQt0aEJ0OanUt/VYrBW3K5MmPifAefbmv9yTrc9GMSmeAdujSKrXfNA46?=
 =?us-ascii?Q?uDEGnJ4IY5pP7O0KOM/u/RCdcL9wwDxklfcyhTsnHnCaOUef3TBJuJ/tM9d7?=
 =?us-ascii?Q?y10zqn8KGZNFdgeSkesEyIy5NVDR3vWf3M7JpYhtPDiGUPYysT0+kt4s1n3a?=
 =?us-ascii?Q?7scIdjYNnY/hbbkdHLDScj4/tI/PEpaSnRujfQDINl9ftuCl/xzu0Gj/oqj9?=
 =?us-ascii?Q?sFpPvt71/1mUTeKZOQU0J/TgeUYYIeR0wBk7Fx8nL/3T7oJ3bggqepX8e7yq?=
 =?us-ascii?Q?gy8rjTKeEvmUVWUotvMkcbblwPPoHP8KTkMWJcqqRO74BETGCuJAxkuoOc6U?=
 =?us-ascii?Q?RkNk8A/GbHONygtFdtCY6d5PPW67cjlvFTehPdvE8YoDXcSEA+GdVVkT7SJ6?=
 =?us-ascii?Q?Q+jfklICxuoFQlOGzxnre9pUhksRWVlaY4iYxpetc5XDn4vscIOIb5QTvjq8?=
 =?us-ascii?Q?kyJy9J2TQ8/olqpj7cWrIIm5omwSuHyJsfBJzMe9/XmB3ePvbcB36B0uc3sF?=
 =?us-ascii?Q?y8MJBT8DK6MoTJY7O1fBFcoY1eq7K2RScM3DboOg6l73yWv87JYp4UsdKGC1?=
 =?us-ascii?Q?Lk11i+vfovj4rhAcH8a9FJJm/y9Xrn6GVb5fLFO4q1Gy1aSxdYBg08D6LOGp?=
 =?us-ascii?Q?/pA5oOdilsYMhPCaoVvjlLJAaMRd/6W5Bb/NKP9D7Zry/gN2tGJwlnEggrmS?=
 =?us-ascii?Q?TzVEw+G9fsk6mzvGYB7S146Ub4/ZUm7cIE9odrTkFVLtlJa7C3k/2AGIlEzz?=
 =?us-ascii?Q?qK4i9LetVZP72gGWe+Kul1mUDgoM2UgIM56lVssQAxeNAIwmL6P9ZXnPziVg?=
 =?us-ascii?Q?mnzFoN2qdrmnEVvI4o7RZGJ+cpbhZpUPR9uftzjTy4Ah2PYz+MMynXtA/Aor?=
 =?us-ascii?Q?N5dfo4vESA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9af5cdc-52dc-411a-1f4e-08def47ab67e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 11:55:02.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pRUIC2X8wbPDDTrnFBiTffTloIMZCjnZXiBsiyrZAsZOHGa/K8NG/UhNVjtwzrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

On Fri, Aug 07, 2026 at 12:03:14PM +0100, Robin Murphy wrote:
> > Each struct device will have a flag that shows if it is in T=1 or T=0
> > state. The flag can only change while a driver is not bound, and
> > changing the flag will update the DMA API configuration.
> 
> I see we no longer seem to have the concern of devices in TDISP RUN state
> being able to send T=0 transactions other than MSI writes,

Right it was too complex and nobody needed it, so Linux will not
support T=0 through the DMA API on an T=1 device, and devices should
be designed to only send T=1 to the greatest degree possible.

If someone foolishly makes a device that works otherwise they will
have to take the difficult SW tasks of making it work.

> where GICv3 means the host is already going to have to be in on the
> game to some degree there anyway.

As I understand it:

We will need to teach GIC to understand if/when the device uses a T=0
translation for MSI and then use a shared physical address for the ITS
IOVA instead of getting an IOVA translation from the iommu. The
hypervisor will setup the S2 for the T=0 SMMU translation to be
identity with all shared memory and the ITS page will be shared
memory.

Presumably in future we will have HW to handle a T=1 ITS page access
and some way to negotiate with devices if they should use a T=1 path
for MSI or not.

There won't be a vSMMU attached to the T=0 instance at all, it is just
wired to be bypass.

> support in firmware bindings nor the IOMMU API itself to be able to describe
> a single device being associated with both the RMM's vSMMU for the T=1
> (Realm) VA space, and the NS VMM's vSMMU for the T=0 VA space, even
> if we

Right!

> did only have to care about using strictly one or the other at any given
> time based on device state. Having distinct struct devices is indeed clunky,
> but does at least reduce the problem to a currently-manageable one of the
> client driver having to wrangle them as a pair. 

So hard! A meaningful goal here is to have existing drivers largely
work unchanged in a CC world, so the device starts doing T=1 for
almost everything and the existing driver just works.

> (And FWIW when we do get there, I'd be inclined to make the default SWIOTLB
> the "private" one, so all the sharing/decryption stuff can be neatly
> partitioned off into the CoCo etc. special cases...)

Yeah
 
Jason
