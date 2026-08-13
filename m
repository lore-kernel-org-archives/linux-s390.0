Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010007.outbound.protection.outlook.com [52.103.13.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242C2471CF8;
	Thu, 13 Aug 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639837; cv=fail; b=iavhhss1pq8d9HD7dS1wCRUyUBJokhf8ZDu9unk/dmd2iIAqMoozuTLhp4S3rsCVYlx662SVi0E6xQFvzYiYI4RY5Zl6aRiYbnKViaHe+u2CVEElaIGrZkJ2ZENUbWsSS/PiBUU1yav44HLS9xoZUT3oVgCBfwdjUBRp+L18Auc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639837; c=relaxed/simple;
	bh=VJOqKFRybWOCZbFFEQzNLnLfFSqbPUu3RgThQ+DYU/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/ZfiFY5Z0BNmVIIOzh2kNmNF1L2mtPFzguaNukJoWvReWvhyC5wWOUqRxlqytJSVB/B7BTvzXmr7+gbp9JrAHYd+6yx5K7kmQ0NwRj75S7TCU1wqZ5US+F651xChC+7ghQSqlixSJNGhfqBrn7LH4dZ8VNrs8n9GvxnxApHjLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=c/jvbjQH; arc=fail smtp.client-ip=52.103.13.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="c/jvbjQH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFnshT+OWTDHuVL+7Lt1qAsWwL4pNdEz6ONIL11jDuJ4PUWkzkR8citmdDceTeouBZp81DPDcdUOzAsx/6zm2J/zWsu3b81W/+26HudPUwWHm9Qo5/QwkAqOv+UR9Ew/q6wxpSTYpHlaQIdxKHaN6pYkJTqy0Iv3IbxV7jQeu+9zg+oQUod8jGQbOAK+WY8yEGHMZ5ebBr764TW6KPhJKk4XiD5dqdvLd0fR02fijRCzaZAEOR6vL65X4Dq2+Wb/XVbSpk/00A5SCGSKEfEfLwBcQY/dpHvtmJ8WrJTKmrXWTGDdwP+fN5RHGrHO96Voq8heqZAJxFKSIHIE3XX30w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs4P8vDNTUNtmD/TEiy4Yz1UhbnETWDibx19uQq+C8Q=;
 b=f6eXM4o2Q2d63kgImN7cU64aCDUzXWxmiGoPv9pieHhlCnqQMPoXYlWzi+Qd82H0UFlJltZP/SyEprHxJJ1JxX9K9Sf+cO6Tc1CAl1FWMhDv+m0fjHRNYH6VkpKV3PKUDaQ3rAOXcb22GfCOPYNVKvsPyBoD3Y1gVateRgiSYakp0vNqY0YKz4jpZCh2QEJKfvX5SBzu0XWTCltH77ywFtJMKFVXx2nCwTAIvdqZc8TUjYjqZb7xnttuXFz6h0uRHHX6isigbVDomU9zMJvLjXItQtqisXuExVYOI5pMNKH4mpdvqmsN+Tfu0pAiv5I4RDZs43737ciTL/NRVevwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs4P8vDNTUNtmD/TEiy4Yz1UhbnETWDibx19uQq+C8Q=;
 b=c/jvbjQHJO2A44eSk3XIpOYBMNwHCSHQS7xLEd2Ux7QuMBWhnmRW2aDCrEnXTlGIQcTfBevmAhBALQn/ooIWnevGk5H7BVJkmpS7fna11bpBYEVS2tJ97Y9AXa5eGTjLiflN4S6s4jFtSkvZaGy8mK+VTJnEKZIzIXuNNYH4gXNQbTWqsSbHrrgA+Ti/yo+ZZlDKiH225xToS9DSDOClwURZw6RU6GMScPLyezqNDY9uUCMyttgOYFFhFNaQIZJqWfps/YFe9q8v2LQ8apyj4yzXs4FIVHS83c4eUDnsE0BQ5U+mnUc6p8kqTY3Sw3Hq1j8ItMKHcw7WsBGb5Inkhw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8083.namprd02.prod.outlook.com (2603:10b6:208:35c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 16:50:29 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 16:50:28 +0000
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
	<aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH v2 2/2] dma: swiotlb: Initialize and size shared
 default pools for memory encryption
Thread-Topic: [RFC PATCH v2 2/2] dma: swiotlb: Initialize and size shared
 default pools for memory encryption
Thread-Index: AQFMX0hXOwboEy4POyg7moK7+petGgFejaX5t7LIybA=
Date: Thu, 13 Aug 2026 16:50:27 +0000
Message-ID:
 <SN6PR02MB4157842A03CBC29155F1673CD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
 <20260813102521.1367737-3-aneesh.kumar@kernel.org>
In-Reply-To: <20260813102521.1367737-3-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8083:EE_
x-ms-office365-filtering-correlation-id: 7f757abe-79f3-45e5-dc78-08def95afaad
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|15080799012|8062599012|25010399006|19110799012|31061999003|8060799015|37011999003|13091999003|55001999006|41001999006|24021099003|40105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M9yz9AbZ1LjrXNG7vYtSAUfu26nMVj31n5apLy+t5HdgM569/5zw9EAFuYQY?=
 =?us-ascii?Q?cyNuxtgiYce0XnofhhGFaUXrnZ6js5WyA4YddINc8kvelN3gzK7eyi4gKXI3?=
 =?us-ascii?Q?XPoNvoXrNLyhi0GQeFlL/ooYeH/K1ju1poJK3EtcU+fwGTu/+O4CwAAWzc0g?=
 =?us-ascii?Q?sOOxEaXBBxv7kgEnmwClv6J6kF8LEdgTbWmsQRrmpzjpFipyqQdKF9l1Lwar?=
 =?us-ascii?Q?REJQur9vWq1gVEzJAS7p7nqitKNV56DpHxnaGVgCL//lhr7uF+ypbp8zjDRf?=
 =?us-ascii?Q?+JaI26gxvOxTcyJAx+pi00nOI3RqUUONz01ZdWruVdiB9y7Yp88Ifn5NKPbz?=
 =?us-ascii?Q?4OWTJXFFTnykMwXjileAOwRuKf8v2MaOQXkzRl5Ac68t14ktULNMDrobMcDT?=
 =?us-ascii?Q?oxoBYThcIpAbc8PIYFYeh1oiH8uWROEP6me0n1G1weBg4+6JsGN6/8npslYx?=
 =?us-ascii?Q?nGGBpuQIsuVyUKQR138Q5/HzawY64NIL8xgYrs3dDvov+ckrCBYQU7uoSnPA?=
 =?us-ascii?Q?xPqacCooKkIxhVpbGuP472yJNlbWv9Pj/KwbWGy8kx3EdF+sk7qaKBmQIGCY?=
 =?us-ascii?Q?8+cRV89KPYCMFAGdOW4Z3avz5k31MX2z/vpW6pHs3E/98e41O1OJR+z8bHBe?=
 =?us-ascii?Q?SsmterNrqAATaZXaL5H5b8tSrvSujpp2t6IBYmwOipsiXDV9AGsg0fBQnOVD?=
 =?us-ascii?Q?QstyD6K20rk0kzUH3IuSMiwpeScB7okR7mWivQ3Nbdsa3g3ylkqVuSlHfgHR?=
 =?us-ascii?Q?IugSh6i7MCptOTQts9Fnhg0e+r+gNq9pn7TCKQCSpv3QjrGkaJ3kvhowOvZp?=
 =?us-ascii?Q?W4eocdtUhedCGrEA+y8DVG31SjzOX2Rx3VMmilwNDw6L2q0LxkBZ+tfcJ4ga?=
 =?us-ascii?Q?0yE+KdqtkKto/ARZg2kUU0oARipg46N2XeCvLVHqYClru/5D8WQeHLgCvtpM?=
 =?us-ascii?Q?UUCpsQTeFFcLF5tqeolS3MYr0CCmKAqzDSldMs8SohpvJHPZ8grKI+3PDBfd?=
 =?us-ascii?Q?11ma2uBLCHBh88NChnqlcmtPu9eU9Kv5dpi1E185sIqjzJL7JduWXzkq4Cld?=
 =?us-ascii?Q?QmG9OmKV?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zwmv4irhY8F9+Hef9zuGDPRDdG+eAS+0TVNayNN35AJ65zPpOCaBa38H9us6?=
 =?us-ascii?Q?S121//mU52byhPON1i53KzNnX6uixPY7ImYfFuxY6URjjzPlwL+RQK+Vu547?=
 =?us-ascii?Q?XGjz5cR8xQlzYxc3Yb7hV3JkmMrX1WyW5i5WMU84TxMi+WiMde8AKBjDInc5?=
 =?us-ascii?Q?rLM1tYDE+KxLGQHSsJ22XfDSjjjzpFEdfTZbj4lbYXkypWRK4B946NKq/dCi?=
 =?us-ascii?Q?4Zx6znQGnmZoXdA9YwYqiwclc8InopBFRN5lGgYaK4UWRwfI3XTfS2lzqKai?=
 =?us-ascii?Q?Bob7M3rKTIgz1MIKnPME+mOBFsmOnGQW0gxxvfe9DWIn4tmMkSmuvzURqj/Z?=
 =?us-ascii?Q?arqulKQoBmFXHdYWQF2wQ6QINo+i0AVkGByKje5ZrJC68O6uOoJMJx0iYKsm?=
 =?us-ascii?Q?623x3RV8AQWJJ0aYd3HfX4LOix31j7auzD9JmYxSvXU/ZXuxs4PF7ktePdIc?=
 =?us-ascii?Q?zhU8BO11RBxrZ12nD4ezXbnLQPtiuA4IHsrIATRq3JiMgS24/y0H7YyrHytd?=
 =?us-ascii?Q?wYMSUgPRLkNDqlVqtdi32FLWm6iulb28tQJcJSXheNmuYqyswSxxTJhsRxQE?=
 =?us-ascii?Q?UzfFuzGl1szAdqxkxngM47cVYrqh3wT5F274KGF/xmR4Pl8fxVkDqS/OlTPq?=
 =?us-ascii?Q?omap8HQRjAjhrkzSEZ2S2T88y7RQ7PzA+8XHKZDmIjPJJr+0RcOpUQaUJToA?=
 =?us-ascii?Q?zxzoWexEnXMjVaJ8rjQhgUYJQT8j++qt8ybbRwATh5FFBuE3VeivApnbV25G?=
 =?us-ascii?Q?3a7+v3ZSj2Nh2cmfDtNje8t9/e9EHZ2TWgw4movz8uAMpiHPp9Q3qwUCl4Fm?=
 =?us-ascii?Q?5xQhCQEZ9AoIM2TTgUesx28EpXHCzyWZ0zMN4PJB5mYZ4ETYfnQUcZRv/KEm?=
 =?us-ascii?Q?OSTLvyXqSzeeS6EicYK7/oZO/2qRev7lPlReXVfU5wzt7gpUsq3YddDJfyT3?=
 =?us-ascii?Q?AaagkYf37AumcplytqI662o50rIZUv79jkBfRFpKX2/4tMaiOd8TYnoJ+SMx?=
 =?us-ascii?Q?nSgfhOVX8xOjuvOlYI1VrVnw91MGwa/kH9wci6GL6uhUROMEj5D9QnkaFNq2?=
 =?us-ascii?Q?thec3dHIPEUA4uDUKQTxtLSFAkXJlN/06zJROZD0BC/cr1821vIWyyaKly4S?=
 =?us-ascii?Q?/RDaFzibRIjnvfmkuwOPNpahr7f9rC54xJZmF4yVwTPXKVLLJZr2JIWYM58v?=
 =?us-ascii?Q?1FRkwThatNoepB50OrFj/ZmUpHCIBlxOQEFVMSbREEHs2+ZUQcKov8lAlbwY?=
 =?us-ascii?Q?kaNR+yG/sxN9uSkcIR4oovrdJyfJIrA5lg5j0Q80WanI6Y8fIOmHG+yY4+ds?=
 =?us-ascii?Q?5GLqpxDLinOZu3FBuLi1E1oicf0jZCwtHkULZ9sqIBTy07mlPGA0IlIHzrR+?=
 =?us-ascii?Q?p4lwesY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f757abe-79f3-45e5-dc78-08def95afaad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 16:50:28.0197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8083

From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Thursday, Augu=
st 13, 2026 3:25 AM
>=20
> Systems with memory encryption require shared or unencrypted buffers for
> device DMA. Confidential guests may route all DMA through SWIOTLB, making
> the default pool too small for I/O-intensive workloads. Host memory
> encryption also requires a shared default pool when bouncing is needed,
> but does not require the guest sizing policy.
>=20
> Move the existing x86 sizing policy into the SWIOTLB core. Detect memory
> encryption before allocating the default pool so that it is initialized
> and marked shared even without DMA addressing limitations. Increase the
> pool size to 6% of guest memory, clamped between the default size and
> 1 GiB, only for confidential guests.
>=20
> The core can determine the confidential-computing requirement directly,
> so remove SWIOTLB_INIT_CC_SHARED and its architecture uses. Keep the
> pseries secure-guest setup before swiotlb_init() so that the pool is
> allocated with SWIOTLB_ANY and is not released later.
>=20
> A restricted DMA pool already supplies shared bounce buffers for its
> devices. Record its presence during reserved-memory initialization and
> avoid initializing or marking the default pool as shared solely because
> memory encryption is enabled.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/mm/init.c      |  6 +---
>  arch/powerpc/mm/mem.c     |  2 +-
>  arch/s390/mm/init.c       |  2 +-
>  arch/x86/mm/mem_encrypt.c | 28 ---------------
>  include/linux/swiotlb.h   |  2 --
>  kernel/dma/swiotlb.c      | 72 +++++++++++++++++++++++++++++----------
>  6 files changed, 57 insertions(+), 55 deletions(-)
>=20

[snip]

>=20
> +static void __init swiotlb_adjust_cc_attributes(void)
> +{
> +	unsigned long size;
> +	phys_addr_t total_mem =3D memblock_phys_mem_size();
> +
> +	/* Do not resize for host memory encryption. */
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;
> +
> +	/*
> +	 * For SEV and TDX and CCA, all DMA has to occur via
> +	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
> +	 * happen without changing device drivers. However, depending on
> +	 * the workload being run, the default 64MB of SWIOTLB may not be
> +	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
> +	 * I/O errors and/or performance degradation especially with high
> +	 * I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB using a percentage of guest
> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> +	 * memory is allocated from low memory, ensure that the adjusted
> +	 * size is within the limits of low available memory.
> +	 *
> +	 * The percentage of guest memory used here for SWIOTLB buffers is
> +	 * more of an approximation of the static adjustment which 64MB for
> +	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size =3D total_mem * 6 / 100;
> +	size =3D clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	swiotlb_adjust_size(size);
> +
> +	if (!IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC))
> +		pr_info("Consider enabling CONFIG_SWIOTLB_DYNAMIC for memory-encrypted=
 systems\n");

I'm not keen on this recommendation. The implementation of
SWIOTLB_DYNAMIC has two limitations that make it problematic for
large CoCo VMs. First, when swiotlb is unable to find sufficient space
in the default pool allocated at boot time, SWIOTLB_DYNAMC creates a
"transient" swiotlb pool that is allocated from the DMA atomic pool to
satisfy the immediate request. Growing the overall swiotlb is kicked off
asynchronously in the background. dma_unmap() frees the transient
pool and the memory is returned to the DMA atomic pool, but a spike
in swiotlb allocations in a big system still has substantial potential to
exhaust the DMA atomic pool. Then you get the same mapping failure
you'd get without SWIOTLB_DYNAMIC. The fundamental problem has
only been moved around.

Second, growing the swiotlb in the background adds a new pool, which
requires allocating contiguous physical memory. That's at most a
MAX_PAGE_ORDER allocation, so 4 MiB. The new pool is divided into
"areas" of minimum size 256 KiB so swiotlb allocations can proceed
in parallel under a per-area spin lock. 16 areas isn't too bad, but might
still have more contention than the original default pool, which, for
example, would have 64 areas on a 64 vCPU VM. But if memory is
fragmented, and you can only get 512 KiB, you'll have only 2 areas,
and substantially more contention. Contention for the swiotlb
spin lock at high vCPU counts has been shown to be a substantial
problem, which is why areas were introduced. But SWIOTLB_DYNAMIC
often can't preserve the parallelism in the dynamically added pools
because of the contiguous memory allocation limitations.

Net, in smaller CoCo VMs, there's some marginal value in
SWIOTLB_DYNAMIC, but that value diminishes as the VM gets
larger and more swiotlb parallelism is needed. And in either case,
there's still the potential of exhausting the DMA atomic pool due
to a spike in demand, in which case you haven't solved anything.

Michael
