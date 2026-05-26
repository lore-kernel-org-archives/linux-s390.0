Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013076.outbound.protection.outlook.com [52.103.7.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5AB3B637E;
	Tue, 26 May 2026 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779769860; cv=fail; b=sxEf21fdPTLZWmZjYOk1r2kzNCxSEkvZEB2lBFqiMibGm9fiqNSvem0SYuXQoWBJ8C6r2Z7BG8kYPwHpzH/KZhrWPZIwXcVRPRuhSYueEF3ISErDRgJcQtPet3Wg5bxGrRr1gdS2UuALV/a/rYLIB3ARkrLMl8ltC50C84LX9Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779769860; c=relaxed/simple;
	bh=WB7Z7CwABDWMFUIBuPKLN0ME+jH9JTruXe6+BU+i+8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcHvgms0CBHnFsqQrZB8iK7Z3c+kSayqCd64YifqgC9ebvjEoI9QQW1/q64NHvcWgCdyopGp6/3KHN9c7pNYAq8vDONl4h8pZs1kwIdwFp1vFlivCYb1u9huKdkW2Ck7bAGHpnTz9FC3yEnJCkTHULruhYZyNfb6REKIHXrvP6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sy0oB93k; arc=fail smtp.client-ip=52.103.7.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sy0oB93k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAkEJgncpFvDou3PKEMZf5dOjiUdSQh3JC6vUj8EhxqW7lTmSHLGA8gJIljlyKGiAE7UYieJYcLjdXG1hVUsl4cA2sKT0YdVruMKndJo59/Q/M768tBGl3Hvbhx5bX4Qh5AgCPQunSVB+sr6fRQO3F75C5hONVBRAsFdd3+F1Am6WpW04N0kRZRB6uzTkNgmv91rCI9F4A5QPIw9Yo7OdXZZVyUkCT1Cs19YzfmSYwlDYIXPueAqCqE0H0aWYWRan2ZWOto3V1XIYez1nqh9GC/bZJXZYY58gSDRdetfj92iUeAcmr/c1evrh0JmB/ipsHUta6HQnsm8hqk2cIVf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB5n4HIcBR1Ydw8PIc+kYAsDnU4G964CODu4WBoU95A=;
 b=lVL86d2vW9vUQ+fiEgdt2yIysiMctLDEYxaqcWFyFdOI5LyxCEtPCaYg1Hsd0Ur5ExLbKY5p8OQodZJCdNPOtuIRKyTCEZUK+aap6WrApgiAcQBsfzJAwRXrHYhd1ilpk4MJLPTVq5ZSK5+5HVHtP/CspmOT+h/OyLcfT3cvb7A8KB/fbevd2I4OiS7OR0sDYzu51KKA0pSYDlMwwkhtr/LoIuZ3Nr2g5HW/rvHkaiG79XVkDp8hjM62SSF8HDtX1caz358W+jPVFoSthQAzGfR82KzNj3qnNmYmrc2OuRGC4tT241J5QQc7XXvQjdsZaFv2VIM7l80qK4Mfke33DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB5n4HIcBR1Ydw8PIc+kYAsDnU4G964CODu4WBoU95A=;
 b=sy0oB93kWmfbT4Dzqkp+vW9s2lQtyTwRVK/qz4GVgVn0WbzqZfbN+a5uozCs57LyYBeEppLvIVVkTym/qm+pnO5PI9GCl8pMDz2gC5BUZ1gPdZsQKlJBqCv6xEYfU0ft7TvktG1ueOy4kAeoff5fsGhBkXk/VLV/FPw9PYgLjPkpop5yZyvnjwnvW5G7zq3CxvD/SEH5U80b8DqgcgsE/ze5TsUinUPjgrOv/wIILuzxjOnzuVUL5foEKhRnkd+1yoeUroNVOmJnPCD5Sa1O5eDgu5Y5VIQjkUy/P4H3ZiLEZoIJLoK9s0/YPc4X8QmXna0AUExrFrLUymPJhZfJtg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DSVPR02MB11591.namprd02.prod.outlook.com (2603:10b6:8:3ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 04:30:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 04:30:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Jiri
 Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy
	<aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Thread-Topic: [PATCH v5 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Thread-Index: AQHp6tfu5DGfxW+HBL9src0vNhss0bYFtf7w
Date: Tue, 26 May 2026 04:30:53 +0000
Message-ID:
 <SN6PR02MB415710407D87B1A36974D765D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DSVPR02MB11591:EE_
x-ms-office365-filtering-correlation-id: 06e8a270-a8cc-45eb-bb49-08debadf92cf
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|13091999003|19110799012|31061999003|15080799012|37011999003|41001999006|8062599012|8060799015|51005399006|19101099003|3412199025|440099028|102099032|12091999003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OP13b3uYRKwk33PW49bUy1FqFI+LMg4cV6DX4yUfXGx4EVO/wHQh9A2vLSBL?=
 =?us-ascii?Q?UoMD9VWVsIbLeYZzMLT4J/3Yod9zEJsltfswFWphGnGRnGn47lSARUVDkpzc?=
 =?us-ascii?Q?U2Y8oN3dR/OODJUrAegm0DfJV0zHrX3pff1U86WiTribAKMHF9PVvWZKaDNM?=
 =?us-ascii?Q?2d1rxjBZnf4ptgotByygw0Tffb/2F/2fMUunve9pLs8YtItxGo/uUswH9eby?=
 =?us-ascii?Q?P8gMDPLqY8GXphDKhEzNFHjZfNx7sQ++UPH3O4X5QPtpExWtb9SzD8q/bJsm?=
 =?us-ascii?Q?6Ea6dnQ8JZxrKD9cZ0YHOPe365J8ClMhEUn3VcYgZL1vIaLdK5pp1KbcWQTp?=
 =?us-ascii?Q?pEtD7lg2BrY4gnPE1gU4uAe9uHuEirryt6Z4R3HCHrkm6pXzSJaWtwGNJYad?=
 =?us-ascii?Q?SBJdcJbxjt8s1IkbTc1U82oYM3ZtpWXKZGD/2/QDIR/G3AZ9q+n4dLTFP/cY?=
 =?us-ascii?Q?N4ob6pNN03eI3SrthfIUNDjFMS4cDo0uRTbC6DS4APJSlvwJ/6NufSuuLNwF?=
 =?us-ascii?Q?ljPcM1eu47RQL+9jfqmU7EXao6Wib79nkS46hiGb2D2HmKguDrckEYDYVMfp?=
 =?us-ascii?Q?DUXvvAfeyhOUzd7lqg3f2sjHd4SNYdq6AgNKkuLACcc6KhpLKnVz8hsxvd2z?=
 =?us-ascii?Q?i2dtDwDSvAMikMC8Tk0wtCcqYtddjiA0JvFI4F5NEYXutbJcN2+3bCNc8fuY?=
 =?us-ascii?Q?yXfPXudoS+oUEkcqinSUWA8nOmIXRYCSRLJ2+8QYb8+uShfrRDkie0eYRqLH?=
 =?us-ascii?Q?UXjdbVZlH2PLBR7ZQvxQn35Pu86yb4DXFPNgiCnL03ZGMwhZIQ1e2yPBc7wC?=
 =?us-ascii?Q?lBX746ALkrrl9Y3mFyDRlv8nvxfkCcXsF4OeybDigip15xsQgWlTc16xRchd?=
 =?us-ascii?Q?pzPBoZzMJSLKEMHr8FLNWmYqqtV5/m90LAFGKxtGn6ATocdPUHZFB58dDL1g?=
 =?us-ascii?Q?H3/OTk+87IL5JwFmNgWsu3gSGGAlKQKu2IQ/ZKFIghOms15Qmcf9Sa5x4/dY?=
 =?us-ascii?Q?F8fW09WOXv+3tWvilBKwhtotwKHXHtrKsA04Q9/vD0nPcqjI/n7jur7Ssyvw?=
 =?us-ascii?Q?aTRAB3vJvcp/ftZHwE5eaTkanROzxDlBR6pXT1wCiZXbTl120qQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vnx4KQpFC/JdGl13E8oJSg7/l5CW8OxQL3xRC77MhyEARiqN4Ry1XyZgkzuL?=
 =?us-ascii?Q?eZFp5uVerOH9AAIYOhvF05MJEPR/vn0FC9biKrXJwgD4DICMiR8U1LjnEnpU?=
 =?us-ascii?Q?DtcCGy4T/uVZLkfGnrCsLkI6+JNvtFA+dIRqayULktnwCW7P/vs54g3aRR9O?=
 =?us-ascii?Q?oX8NTnXzJNvVJivAnqbj8C7Nj0eMpOSR/mRLxfrUClxv9XuVVd51sD0ZhfN3?=
 =?us-ascii?Q?N0qhFA/BHfwa8XPl96LKOfsPp7FRjOdS41qdXvw4C4Q250AdjlZrY1d91Hq2?=
 =?us-ascii?Q?PHKtuXNRWg/HZ5+eP5Ifoq48nJbkCC6CS73EQCYvsnRKC3SFEbEu0RgoFpco?=
 =?us-ascii?Q?YSfmKFa6Lpdd3YT+hyWomIqrlZCQv8DwC3kR8HrUutVKvoHQlgsJvEVsKLG5?=
 =?us-ascii?Q?KL3FPGlul0/vQ/WDkWE+TPfq9o7vdv3EZMjxna9ymW7qkPkb04dY7L5qMIZb?=
 =?us-ascii?Q?4uR/OU6gRtXp4DK2hK14LAm1FDghkYJMC0U8n8rm3qAmFqm/8VX7AwG3fius?=
 =?us-ascii?Q?qlZdwkok6wUhlBxJ9YYbPuOYucBzRk/fl+lUuxSD8Y1QjKl9m/pE4QnH7b4N?=
 =?us-ascii?Q?1f9pWXLc1+QoKDvjzwuwvWeC/yGQt6EUxF6U2Y2catGKvi13b3m01U1SKwiJ?=
 =?us-ascii?Q?wtQKi4ywX7rctjUzlizr8WKQiLfYzY1ltsSTjAlncpYDCFptn6oQilBTb9HC?=
 =?us-ascii?Q?ftveVBPfpvBN2XG4+c5M1W9TueR67wf0+pi1TkOU3RIUh2jvAAScRKb7yXRr?=
 =?us-ascii?Q?ZZ4A1NIpo80Zujcn97Rts26fP9iarCkh4RVBNpa8B41iU1qjnyhn+Ko+uA6/?=
 =?us-ascii?Q?Z2l0tLoOC0WHZ90D1rwoNk7lXScdSggKqO/s+wQBMZ6hVkFMvjRaaqchCNTa?=
 =?us-ascii?Q?sy1fNzeVK0H8za+VlEhk7c+fzXdrzi+uFhT83DrILH4O9ELpHZMSgcfhg2rR?=
 =?us-ascii?Q?2zrhrV9Wby3SDkNjdtrKMSxuKQN8muQ3qp+nPLr41alS3GAFWv9B/fNoQsy4?=
 =?us-ascii?Q?NYRvNTHQtiA9QJl3yPH29rUVUynd3D7IKX1snpFvX3txt2eUfJSKC3zWnugp?=
 =?us-ascii?Q?VN0+luJ/pUpfgpwS7QT4QQG+Ffr+sEL78WrmlHAELuTwGjKlTkHsXzEmLcJZ?=
 =?us-ascii?Q?aFIER0jpAw4qyuAVy0XjBWAis0FJzzStF/kJrp3VwmK+RLUXaqZbqdF+bazZ?=
 =?us-ascii?Q?2XTvZhvVFEbH7rRkFLscj6ordiGPYlGsunEvO2zTW7SUFHi48W01rya/MXDd?=
 =?us-ascii?Q?VpTqiagYv6jXW/iKDb9Ek9Jwb8JA5egJKSplpeCkXlpL8R6bUeY06Nw/D2pt?=
 =?us-ascii?Q?p5hugC3LVcgppmdjQF9jy5mWzKkqAzEEcxft9oegKqocv4tJTneYUgfIXyxt?=
 =?us-ascii?Q?3RyUQ6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e8a270-a8cc-45eb-bb49-08debadf92cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 04:30:53.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11591

From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Thursday, May =
21, 2026 9:28 PM
>=20
> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> are handled consistently.
>=20
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.
>=20
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - propagates DMA_ATTR_CC_SHARED through the dma-direct alloc/free
>   paths
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes
> - passes DMA attributes down to dma_capable() so capability checks can
>   validate whether the selected DMA address encoding matches
>   DMA_ATTR_CC_SHARED
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   DMA_ATTR_CC_SHARED and fall back to swiotlb when a shared DMA request
>   cannot use the direct mapping, which lets arm64 and x86 CCA guests stop
>   relying on SWIOTLB_FORCE for DMA mappings
> - use the selected swiotlb pool state to derive the returned DMA
>   address.

[snip]

>=20
>=20
> Aneesh Kumar K.V (Arm) (20):
>   [DO NOT MERGE] arm64/coco: Add pKVM as a CC platform
>   [DO NOT MERGE] s390: Expose protected virtualization through
>     cc_platform_has()
>   dma-direct: swiotlb: handle swiotlb alloc/free outside
>     __dma_direct_alloc_pages
>   dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
>   dma-pool: track decrypted atomic pools and select them via attrs
>   dma: swiotlb: pass mapping attributes by reference
>   dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
>   dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
>   dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
>   dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
>   dma-direct: set decrypted flag for remapped DMA allocations
>   dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
>   dma-pool: fix page leak in atomic_pool_expand() cleanup
>   dma-direct: rename ret to cpu_addr in alloc helpers
>   dma-direct: return struct page from dma_direct_alloc_from_pool()
>   iommu/dma: Check atomic pool allocation result directly
>   dma: swiotlb: free dynamic pools from process context
>   dma: swiotlb: handle set_memory_decrypted() failures
>   dma: free atomic pool pages by physical address
>   swiotlb: Preserve allocation virtual address for dynamic pools
>=20
>  arch/arm64/include/asm/hypervisor.h           |   6 +
>  arch/arm64/include/asm/mem_encrypt.h          |   3 +-
>  arch/arm64/kernel/rsi.c                       |  12 -
>  arch/arm64/mm/init.c                          |  17 +-
>  arch/powerpc/platforms/pseries/svm.c          |   2 +-
>  arch/s390/Kconfig                             |   1 +
>  arch/s390/mm/init.c                           |  16 +-
>  arch/x86/kernel/amd_gart_64.c                 |  30 +-
>  arch/x86/kernel/pci-dma.c                     |   4 +-
>  drivers/iommu/dma-iommu.c                     |  15 +-
>  drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c |   5 +
>  drivers/xen/swiotlb-xen.c                     |   8 +-
>  include/linux/dma-direct.h                    |  20 +-
>  include/linux/dma-map-ops.h                   |   3 +-
>  include/linux/swiotlb.h                       |  20 +-
>  kernel/dma/direct.c                           | 275 +++++++++++++-----
>  kernel/dma/direct.h                           |  47 +--
>  kernel/dma/mapping.c                          |  16 +-
>  kernel/dma/pool.c                             | 221 ++++++++++----
>  kernel/dma/swiotlb.c                          | 270 +++++++++++++----
>  20 files changed, 717 insertions(+), 274 deletions(-)
>=20

I tested the series in a linux-next20260518 kernel, running in an
Azure VM on the Hyper-V hypervisor. The physical processor is Intel
XEON(R) PLATINUM 8573C with TDX memory encryption in use, so
this is a Linux CoCo VM. The VM has the usual VMBus synthetic disk
and network devices provided by Hyper-V, plus two PCI NVMe devices
that are directly assigned to the VM. I did basic smoke tests in the
VM, including reading and writing the NVMe devices. The swiotlb is
used as expected for DMA transfers to/from the synthetic and NVMe
devices. The NVMe driver does dma_alloc_coherent() to allocate
memory for control structures that must be decrypted. I did "unbind"
on the NVMe devices, and then rebound them so the dma allocations
would be freed and then reallocated. All looks good.

I'd like to try the same tests in a CoCo VM based on AMD SEV-SNP,
but I need to get quota for that VM size in Azure, and I don't know
how soon that can happen.

So as described above,

Tested-by: Michael Kelley <mhklinux@outlook.com>
