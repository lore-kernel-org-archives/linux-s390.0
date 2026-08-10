Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77803ED5DA;
	Mon, 10 Aug 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374522; cv=fail; b=DLLJK9AFjCZ1h10E9D7lJkyVbVWiRblF0NHSIyBZcZNLyFo8FwHdkUkSd0/rZNdRyB24LJV9/97kJ5Ly9G087oqquMruxpmX3hNt293QU01NNOCT+AKVEqECofs9vuRH6ohGfj2nWefu0yXW0i2XeKbysWNZ8vLZIOwPblCOOck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374522; c=relaxed/simple;
	bh=FmFxmbFo0Ym9vHFI9/qwO8/BPa4X9Z4lp0a95tghn6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lZCjiYy3vDYfbrfC/51dLlidE5ziTAtDWlf/hDBdlOLZyoI1H/L122rM2dedTDR80LxbjM3a46yvGFQkyo6FDu46ftVm1Rkq0hBPKwdx1/JE/E7lsYsop2oIyNj+9w9T1pdsBA/cDwDID/dDlhVwazOPvjPdJBY4Nzy7BH5BNAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UYuO1NSt; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UYuO1NSt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfI3wjvlQUinxUOQE9tqyCv3m0YWl5KC008NguLNEYcwl6RL8s+LPsmr25n6PdANHd7m8SvwHAFMLbKpPi7FvUoqcBcr/TU+FsbHkicwTijQFagFv1NsJBP6PYkvLo5YcR3AkcYSM7CeSXZYPDIA3xh/RiJG21fSRKZ4Ab6MJDMG7k69x4rRYQH/Oi7aACyF+u8qYJTRH7p50rl7g/4Mh88oI3vGwC0RR+A0q7lM4S8XbmZzwBR0Fle6KafqCYGvXiPIF3ozVX+S8mWWFyfHErItR5rW4OXSOtra3JxbAua+u9/uP2WMJWk3ed9dGymlEzCIo6oRieRewqQot96PJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTMkqBJQt9s46QcMVTug+4LBbYOBeafH6lRM81xpMnI=;
 b=BJwbjvOcVaVjwegHI5ZaQ2q9DnVfBKPRHwRWdzvuDv4I6mIlwctTxHCLDWIfXnWhmE/r32tDsGKIDgn2zqaFh3tNhCGSKB/Uq29tDksTwss9xdjLdefIqH5FH8tkVMNoYpc5OelU51P0itv3MO3p73dW1bqf1ykpEVbV+/LZopzOKRrFOI23oocDnMMbsAXcdVigrchf8mVBA4bQg6tyBqLxpBYtquCRzpfwqvzoIKW1kiSOtNIcuENOMJl0XnS1Yy3e/gfuhoGUb/OEiDf5KUoV0bLxFW986xweTCpX591hGyJ5wtNcKwa4IOMBgSU4lwJGbaLa6zolot5ie7AbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTMkqBJQt9s46QcMVTug+4LBbYOBeafH6lRM81xpMnI=;
 b=UYuO1NStcjXud8hOvCqBoJJIt6EhVl5A/eKycas6Cue2i+4ie6u2PB8OzztwCMeAoepzVrlu4eF2PyRC3hD+P7KCnrqDHuRy+oineIzr3DBi8TBFNAapIJYgvn2nFY8MP8LQGUPuy3G6Y2UA9vnEqgKL1fczd/JEib9fAbOc/iWllFvAsRTa6KDRdkY5j383LB1HAlGzJVhghv6i3hFB3rQmF0GKidmcCetZF6PqlZSOd5+rROR5jue3cv4RdrRqYTQNqvBckK6k5207CqvTrJfv5c02qk8LCuc652IeuBJ9jjH1YXHZe2i+IeNHHAvQMBDOs8wScH3QIM+1h5yQ8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:08:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:08:34 +0000
Date: Mon, 10 Aug 2026 12:08:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, Ankit Agrawal <ankita@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20260810150832.GB291736@nvidia.com>
References: <amnRB98ZZIysHuM3@google.com>
 <yq5acxw6dl1d.fsf@kernel.org>
 <20260804142032.GC27883@nvidia.com>
 <anL9-OrDGqYQAWNV@google.com>
 <20260805123023.GO27883@nvidia.com>
 <0ce2249d-3a64-4889-b455-0e8fddcc7282@arm.com>
 <20260807115500.GA158689@nvidia.com>
 <aefab683-598c-4cca-b5a0-c9081ccf9e1c@arm.com>
 <20260807170104.GB158689@nvidia.com>
 <21813ccf-96e5-4a7e-a3b3-aaaec7e0d23c@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21813ccf-96e5-4a7e-a3b3-aaaec7e0d23c@arm.com>
X-ClientProxiedBy: BN9P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c3074-2f7d-4508-1307-08def6f13f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|6133799003|56012099006|11063799006|5023799004|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5NWOmwa5QDOPJPrYa6vESgXutAFxpZRya7cEKG1lPk0hflaERSlnk7fSMhR+UERDchL1bu/Bd3AtrzJUUcWskJ0h6nwW6AzUD2kwog84NbUeTybj26Tl39azRW6fnAwFIIopPbEEAjGEFmQq1jG8/viWhIHospqVSeDcNCo8kFgbFUAlgkNF2arQs5rQEjVT/Xbrx7HbITjN5qFrlEi/99XyAc05lnL+NFO2SfJINBHpK/jsDkfX6Dl0oCXjM3NYWFCzV1WfP+oTKBdG5oIxPSyXp7J65CWtfuGM5JBTP2MONqY7eIM+DeNIIBgP+orvN/Vwbv+G2CwLsnzdJmtI8GA57hiB0ymwbM1rKNws3yxviklrhbV43rZ2qkinP4gjvc7Nnj0mIn09P+VC5Tn8mkP+OmMbSjfdljZXZT0M1E0UPVRP1fkCNDwDXbgNpYPoppXjDD7F9ELAF7BAFopyRjbViJg7XWZfzkI04zUIsnaEiySkMSq9aX0HjEbQ73Ijz3JPGMPYTaaQ5Ig5LMRNMpcotkkwwHPvkOxNziOAZW+CvklzxwHRPA7xAhYRPRpRAA3S9ouIHNtTWoyrOho1Je4DmmvtYSPgNyPuZAAj0M/xM1YnCFfeCXjMvpR0w9QX24bgiTvvsRpsB1BLCB0/UNwMoiCMF53OhporU/5+E3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(6133799003)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9VFo97/UYiJYpqCbzj9rqTc0NiIxjvY5KdVegHINZg9MEOD2aulwaP9MXvJg?=
 =?us-ascii?Q?URWeBCXGJR+qFlB3zNX6NuHEJQ34nZ+z9ZfAhABWutRjXGpZlT02AcKMmrVo?=
 =?us-ascii?Q?86FDeIzhQxw0JGCJ/fVPjEKeXbmFEaS90J9AzS470df5/8ya+/Qc/5mVXuGO?=
 =?us-ascii?Q?fZXdfzBFzySbhu07nEOgS6nks9PrWSULRqxo9BU3LxZEiS1tM/bg77XgsMyI?=
 =?us-ascii?Q?R1XPxCD0zw8/HsyRaOXtT84GP0JKCm9sMPju54WNGHbElZEfIaJBcyfW6LHP?=
 =?us-ascii?Q?dat2xCyRYBIjPaHRL8RT2fwq0fCJX7elTavZj9fSoxGp5IdpqlFethESHYF7?=
 =?us-ascii?Q?TqKqeAxvKC0MJbPeTIAQ+elFJLXZWyBsCz76/B/9FkuMVRoL3tMUx+TfKuhI?=
 =?us-ascii?Q?5JFNU9LQ/frWNzTuzO6lgSjLYwxxkCZ47s0dk0otDSrsPsZPDzJWvlbwL7L5?=
 =?us-ascii?Q?tKuaG3PR/3D+fSD0KnjzIOWOyt+6hranGdiHNDnpDSpak4ybofD+3DP6b7RR?=
 =?us-ascii?Q?yDgrRSHCAelChC0llLU5xKWzYbAUtXUoELfiHraH2Vwr94rdzsRzS2DRkAmt?=
 =?us-ascii?Q?EuKoT3antS6LWcSN1wV0gBriQWjQ3deKgFTCtdpzk1ciWvp/Y2TmWY1ubsJT?=
 =?us-ascii?Q?bARz+98SRwNAd7Tfpfu3Mgb5+s6I2e15OsEvaPLwkFCrO3vcUc/p+U9OwuYG?=
 =?us-ascii?Q?jWUSsfU5rpzExwDLm04RGN/xtWxLVxNfeHc0nQ+MxgqOdJ0aTeidBM6lxyGC?=
 =?us-ascii?Q?Xz6kqK6j/0inCkqJtjjsKdd6d7mttf98eD6weP91OWc+gZqRXuJNnmsEkx2q?=
 =?us-ascii?Q?zOs+L3FE+Zovi3OfCdEbsjoWrF1qy2EXKJEIuI7JE+rs+Sva9gFmCWV6R9Wa?=
 =?us-ascii?Q?isxmmY059ELL7Y6QEBQnyPGkS4u07p0S44zY5KuTAXayhwJ9V/eYSvVIJg41?=
 =?us-ascii?Q?62y2jUrosXoDrkO0FU/BWofN3c2nr2LgSOT/F3V9Ve6ZHZhHtfIiIChbzafv?=
 =?us-ascii?Q?S8tW6D1Yjd0vGR73TN/JLvK4eLzgzBEi+KpQto4GzbVi8/AGBMWmlE9n/z+c?=
 =?us-ascii?Q?xLEuIeYozZgDb9pdc/LIHrjat8NKx4//kGyy1QJyYou0LfsnvUrfrSxZitlp?=
 =?us-ascii?Q?KHTgpM3g9A0rpmntSsLHkqx0HyzghS7j5A60nOQxKJJdKdkkBzR4VqitVCPK?=
 =?us-ascii?Q?AV7YQJmQtGdiRtsEx0MMzmDPaqChEPx30x2M099zSdIsC5XJJJUZKLvXw7ZC?=
 =?us-ascii?Q?O4r98mYfaVofngrLe7LKXgCmqnFvdsvn2TJVhV0PUEl9wRRpxst3PLk2Dyxu?=
 =?us-ascii?Q?lM+CcdC0uJ9LI7Uvd/Be5QWxgofOvgnoVH8/oIj9stRVDn65KbiDaaGCjiZB?=
 =?us-ascii?Q?cuwFGd2yKDZv3DcDWCRTYEirNSFvZJuZKPQJwv7tEE1cWQw+gqzbwtHx/MDR?=
 =?us-ascii?Q?jV7DZMgrjWmDeY67LiDzeynR8xZve0ZxJpzv6UakyrUoT51ffgV2XYsU99g3?=
 =?us-ascii?Q?OeaVk3+2SmEyWckkLmQKYo06cc9nid2Rj2+xBMhsTL/GXE9VP637fy2KBGBA?=
 =?us-ascii?Q?DR3ekuY0x/wBbwmWphPu/34qukpeP312klC2xEkQbbN49TSxFq3rL04Y7FVW?=
 =?us-ascii?Q?aP42+rdC77cQvd8WWu1jR3moavFShb22rExa+B91N4ep/anb0SLfFwAt+mhm?=
 =?us-ascii?Q?+MM8hcUDzLLveGRxdF82HSg9oHPtoOtueGQKzVZsDEhYS6Ia?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c3074-2f7d-4508-1307-08def6f13f4c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:08:34.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uplBCrKUARnmSvgLConuNQ66qy7fkGGmqFR5LglvCiJ9j7Jl1r59Ee5MrbX5lqq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350

On Mon, Aug 10, 2026 at 03:18:03PM +0100, Robin Murphy wrote:

> Cool. So in fact that puts us in an interesting position for now where
> non-CoCo "untrusted" (i.e. external) devices should have IOMMU translation
> forced on by default, while CoCo "unaccepted" devices (i.e. those which do
> have a mechanism to transition into a T=1 or equivalent state) should *not*
> try to use an associated IOMMU, on the assumption that it may only work for
> T=1 traffic. All the more reason to sort these abstractions out so we can
> make the right distinctions clearly :)

I think the guest flow works out fairly logically:

1) At boot the IOMMU core always setups blocking translation. No more
   auto-attaching paging or identity domains at probe time [optional,
   but default on for CC guest]
   * This means devices that can have their DMA disabled do
   * Additionally T=1 capable devices have their T=1 DMA blocked by
     the CC platform itself. eg RMM is to leave the T=1 STE set to
     blocking at VM boot until commanded otherwise.

   Aside from CC this also goes hand in hand with DRTM support in the
   kernel where we do want to carry over the DMA access block from the
   secure launch until the system, ideally via userspace policy, has
   approved the device.

2) Before probing a driver we synchronize the TDISP state, IOMMU
   and configure the DMA API:
    a. If no iommu, then DMA API is in physical
    b. If both device and IOMMU same-T then DMA API follows IOMMU configuration:
         - DMA API is physical if IOMMU configuration is identity
         - DMA API is dma-iomu if paging
         - IOMMU sets the proper domain for the DMA API, removes the
           blocking
    c. If device and iommu have different T state then assume no iommu
       and DMA API is physical
2b) For T=1 capable devices this is the moment we tell the CC platform
    to permit DMA

3) The DMA API configuration follows per-device flags:
    - Using IOMMU: Use dma-iommu not physical
    - Using T=0/1: Replaces 'force dma unencrypted'. Ie T=0 uses
      swiotlb to get CC shared memory.
    - adversarial: Replaces pdev->trusted/etc. Causes IOMMU and
      SWIOTLB to bounce buffer partial pages.
      Causes iommu to prefer paging not identity.

4) After removing a driver we restore the IOMMU back to blocking. The
   CC platform is told to block DMA again, if it can.

If we ever do decide to support dual iommu then #2 would be the point
we swap the iommu control between the T=0/1 iommu.

> (And while untrusted vIOMMUs for purely-untrusted devices in CoCo
> environments would be pretty straightforward as well, I guess we might need
> some sort of acceptance status for trusted vIOMMU devices themselves?
> Hmm...)

That should fall into the overall plan for device acceptance. We want
the kernel to have a small policy of devices it would accept prior to
the initrd. Untrusted versions of iommu (and others) should not auto
probe.

The initrd can then decide if it wants to probe the untrusted
iommu. Probably it does not right now since we haven't done any
security analysis on the SMMUv3 being operated by a hostile
hypervisor. ARM should be OK here, a modular SMMUv3 will achieve this
trivially. x86 will have a harder time.

Userspace will run its acceptance flow and figure out what drivers to
bind. Along the way userspace will record what it is accepting in a
measurement log.

So, lots of little steps along the path. I imagine various series
something like:

- Basic version of #1 and #2 to generally defer opening DMA till
  probe
- TSM APIs to support setting T=1 and doing the evidence suff
- T=1 flag for devices supported by IOMMU and DMA API, replacing force
  dma unencrypted
- Userspace driven policy control over device binding
- General trust level concept, including an "adversarial" trust level
  which will trigger various auto configuration and mitigations
- tsm_mr improvmements
- adversarial T=1 devices, eg SWIOTLB still bounce buffers but has to
  support a private pool

Regards,
Jason
