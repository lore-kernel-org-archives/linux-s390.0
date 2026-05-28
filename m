Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010021.outbound.protection.outlook.com [52.103.12.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38C409103;
	Thu, 28 May 2026 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992999; cv=fail; b=eMMs0Ppu+3Z/gitEpenalos6j1EVvl7e6XSIh3Z8QpnwPbQmU/lsQUox+eDyPOsXPNWMrQRWeJwFXPLek2P6sndhvO9uWk4QaEF+emX33wcOQ5H5CuYboY3ddBm+nquaVJth0Su0Lj0zVtjHIU2B1PqEzM2yTHpAUn2Lz+GprAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992999; c=relaxed/simple;
	bh=rKYDQw2JS+dDqkMGdiuFUrBQ+PcNUHKxiOZtvR2D47E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JtpUwMdK+NR3FXTXNBYKiCQhMWDGc3El3MLXh1K103fBNFDhOW6fVTpVcVPKayY96i1NXBvf+HRur5l0GxLbHZpSEeJvYEC0fPrFjpI/hzjmMNQ79IaDEJd4ENJWJ4423vhy4TKVdddIvSwgDTyCbMhdYhwsCmX1okNY94IEDjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bPZMau4G; arc=fail smtp.client-ip=52.103.12.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bPZMau4G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiG9mxL0AMfhSgcYowozehEp+juP2OFM90l3eeEfvj1VHjZW+AsBJb4xAmH4KLtpFNPSWYh7C/23GPEX7Sa3WguZQ1I9Vydt19aHvqmP0ssrxWv85QtMxPjpRDn/RpFjC2TxiR60Ce7/oR4vD+hRpiFAGztr+2oj3tOZzfZKJe5ECX9O6X0zVx/0TQAWCUxR/KK8xm7bIGqUx0g2QM/5YKSx60SZw7iQSeihIiNyIZ3mCKomrtDRaSvjnSNGReqUr+pQJbDD19NSgCn4t5lTwJLB0sc0BzsuZM0y3y3JG6+0qP67Q3X7IHE6zqxhuganSZlBdacpaj0oHt3cD8rwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmzRGnurAz6Xz3wlLcxonBCqfKIEUIDPrfHdVIvAqcs=;
 b=uDWEqeswW6O9zLQcsqXiE0F3EyOCx0nBWLFwEL81jY8luzwgVls081u6fUPFnSuO5w0EPg+3lNdnCeRoc9xNo3MGSJQ3Wn1Hg3Fq/mefztvrvmEHH+LFySQn/xeIhVlg351T/esrbLT/JaJ0MdhiHUhUZ9mltGfV49Hi9N0ceLJAfLE7gkrw3o1SfLjYD9zyPKf2KeCbx0MIQaJDDSyg3sNEwAMddRvOAzxNbKL+MH4R058RL+NNi9iKhuWk6TFzOMzPGwAJkbInRqAVs67TlAyS0KPO2h65AkO6hLZjVH+AMi9sClNcHyI4YOSw8SZddUq0LE3MeoSCTAkQvMPJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmzRGnurAz6Xz3wlLcxonBCqfKIEUIDPrfHdVIvAqcs=;
 b=bPZMau4Gjf8mac47yifOAkg/IlCJqPE6APipteN516S27dKLqkdVlCSLazvvmXhE4vckFhGMZkEmcmlXkW9Zt/Pa3OH6FG33OVaM/JgtaYtpJihdMz21IIqlC8LFQ8oeKcjU00480JrLeLzWGBDF5fnuae/OtPMFS87wma0Ac1YnpLxZbT83qX7eX7sIMy90gNXIEHINJxce/h5hW51I+CG03UzVavqFhSalplj1bNR4HLy+pzc6xfMVm29B9KINMCeDzgbQTN6kjNUgeDnV1d/1Jo5iGA6hms4PwGabBAqNpyNDA9yJhCzE+wN9MISUs6WLxiM6t9Q9Ev7B83rerQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB9571.namprd02.prod.outlook.com (2603:10b6:8:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Thu, 28 May 2026 18:29:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:29:51 +0000
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
	<svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Subject: RE: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Thread-Topic: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Thread-Index: AQHp6tfu5DGfxW+HBL9src0vNhss0QGjMATQtfypCTA=
Date: Thu, 28 May 2026 18:29:51 +0000
Message-ID:
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
In-Reply-To: <20260522042815.370873-6-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB9571:EE_
x-ms-office365-filtering-correlation-id: 0542c1d2-3909-4df7-ba5f-08debce71b2c
x-microsoft-antispam:
 BCL:0;ARA:14566002|19101099003|12121999013|37011999003|51005399006|41001999006|31061999003|8060799015|13091999003|8062599012|19110799012|15080799012|40105399003|3412199025|12091999003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uP5dnpJwt1kfLT9GEk89sr12pofUyzYkXvuB553Vd8g800b5BhSZEy+T9aqT?=
 =?us-ascii?Q?xTDYklr8nNNgm7QDzBwdoeqGggf2vgvzFD9M/J75gBQKjmGlhsbiXEwKo0AK?=
 =?us-ascii?Q?ku9nCHMjiJEKPH2xL4xRc7xIQRHbyUT6aH5Kp2rBqapeCDiv5mW6exU+fW5u?=
 =?us-ascii?Q?kRaFvFEy3/9zCnNnQLqNeZyc+4RWVeImuVmqfbxeLHg47l/PepbqPg0RVEnL?=
 =?us-ascii?Q?oEMKP82QwrN9DZxqfZf0s9RkHQZbETT3cOR/BZz5KeuAfWaJMQiX0rL5TjHb?=
 =?us-ascii?Q?x37dSZFmFpHCSo9G9qv3IqBIpeKBXpZtiAJu16L+4y7QKmdKWKF2ckTRi73J?=
 =?us-ascii?Q?vXV5tmLLB+PrBf8ycOgh84qsLOs6SP/8XtLIU6iDRzEbyhgQ/uezhTniLLss?=
 =?us-ascii?Q?HzrK8SZxrrSI/IkC2NGOjsKfs/FQVstNB68YyslbUIPS89AM4S43QKXgd6KO?=
 =?us-ascii?Q?lWZfsrO+2nfdOBNn3LCsAzKYZR2L3/Ki8TpUxpurQcv6wUvqca+g7hG4ZFbR?=
 =?us-ascii?Q?Y+w1tX7RlUAmJ8+NBUk8mbTKXSaAxsahcEWYuehjSN275xn3aJSc+iFNENjx?=
 =?us-ascii?Q?moVAYInLyONx/op4/8AFqIS/dyjnxL1RiiFQNhS1UfeggB8exnzoCkVUwVQU?=
 =?us-ascii?Q?45pYz6nPYfQTQ7m0duFbMJLICW8ux18Ex04s8R678FmuiqFueXCt2tSzYRk8?=
 =?us-ascii?Q?1plxF9d3+VAng4km6vsKx+MM06oHRqFuYXhPtXeUxetT2iRqzwBoIzNGit7V?=
 =?us-ascii?Q?RvUzfnxRje6mlJ6r7825TzZRItw0Z/dGX8aTA54niBST853P4mv4Uz3iIME7?=
 =?us-ascii?Q?hyI8ha/JkmB1XCRkQoKBsoHvgdSm7lyPCaj8yuGxitii40csg1tOWA/rlAlP?=
 =?us-ascii?Q?QE1ba3wi4f20F+tmnZ/J+32dfpGcAelsmWhvj+K7+Kf3p6+83idwk0gF7r7d?=
 =?us-ascii?Q?cf6LepHEsp4zCaYh4WsloXiAk2srMsAFsjOvmqmFVSAzXpf0QZWdVwd89TI1?=
 =?us-ascii?Q?jVKR1uopLz+R0M9BJOZgKzyREXieirjiyhbER83eLBMxg18xe6znTyuHh/0z?=
 =?us-ascii?Q?Au2kPNUh7868rOLmfG+HjNZ+zwv5FlCu6ESTtsxKjxAP5YSQ8r0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HQ0umdFbO8Wz8hLL3fjVC0BgTAuJ8yGsDWYeYe6Eyo4tQk3W/hAQI0cUw3lW?=
 =?us-ascii?Q?oyOeet3l8RoFkpvlFBPENQSKYIIFM3U0ERCW6Mf5JzGI8ba7RvZzAhU+an70?=
 =?us-ascii?Q?a6eG9qo0GczHie0y8Dnfnwrhf2fXUp3nbQU7MTII6+aYEF6sPQ48tJV4b1U4?=
 =?us-ascii?Q?OMRzYzwcYLv8cTId5PzTXxsCgpMmoWBtWxeF4tZRLkUVL5bfiBlgrfSsLF63?=
 =?us-ascii?Q?E7ibjx73MqCZqOjFz+z/JBAQMszHWcTmb31Y9TuHfz0ygB2Tp2n8oGOxzHau?=
 =?us-ascii?Q?k0FpBIEghV1TB++gK7FfrlbVu1vCwzCK/4ZeDimdm+4UvF7JN8vcRlAjTshw?=
 =?us-ascii?Q?fZv9yXIJUknU0YzhYAJIZe8AkH27X0p02BIb2/txsdmEuBZgyex+O4BgZ2N2?=
 =?us-ascii?Q?ogkr79TwABKhnwsFIq2tlJGdzUcAZulvnnP9yAgoRjO/NnOcpbOY4sdoMNe6?=
 =?us-ascii?Q?aycFCBXoNpSzj5TpwoOnCJuPMANkwM5MLB8Nj3e/4zDpL62hGudQuf4FFJ2t?=
 =?us-ascii?Q?rvr4oL2Dw5G8vRsvT9B7T8IaBapZOCExRJd3FTOtbM4M939VVJe1/JPfISUH?=
 =?us-ascii?Q?C5H7t58YsC45xeds9dyh3cfzJmdZBLpsDNeUopcCUbeYqF12dREFFSrYs/I+?=
 =?us-ascii?Q?eN8oGjwGYp69Z7W8CM6FbPTgA6NxtmOKxezo3hzALWSdLJCYKbCeDJ5qRlxZ?=
 =?us-ascii?Q?mu+g3mMloA72cTa54kg9JhYtH2JfUc8jgJecdeUjOSeUQH64kzDuBu47vi28?=
 =?us-ascii?Q?8iHgnBbD5nrEMkWTXQtjpJ5/iQEoLasMhCBi1KzH+1vTUPuW0U3SDMkdBsfR?=
 =?us-ascii?Q?7UT/CQctVK6B5sHgly17tWiBkXB9doiM8TGselzwaa0AB029tlUqSkxrnX/0?=
 =?us-ascii?Q?ZOtc0hutg6EZLmK3tO2g9zAbVf9KFUAdKt4szMDyra7xK8BdPZQF+OFJVGwE?=
 =?us-ascii?Q?qdcXBL9BcfC8H4kEceeTLyRrldPu3j981/9co/k2qbvuCTdCJ2QNPuV5fZs7?=
 =?us-ascii?Q?GYwl3VA1YkN5cNBlb9yPCVslhEPr6FrZLZxfDy38rA4lg7JsvEFr/+8CymEp?=
 =?us-ascii?Q?b4HLdHxTQmmMcY/il2vQTJvlPnH/zrtl1LKud3d3XURGbQ4GtcMAHgasaVqV?=
 =?us-ascii?Q?TEU5nAHhWp1A7fSTXS3pZXC1y8Poh7UEz55ckmTfsvY39ynZlMX4s3IoA7eN?=
 =?us-ascii?Q?aitqJh9uJ76y2WyQBO3PqYSWwjvrKtksjjRakgqlXvreqxobCc16RownJHPF?=
 =?us-ascii?Q?GAxWRYPJv82Xo8WnY7rxZG36cvykwhBhZd0kc86EWp96bcMhUEmOKhGUNCqH?=
 =?us-ascii?Q?TR6YdHYgJP6Q/0I+6fwmL8Od6GBEcDZc2JQIOwVrp9El4AU5X60ZB/xoZWE2?=
 =?us-ascii?Q?WTphGMc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0542c1d2-3909-4df7-ba5f-08debce71b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 18:29:51.2491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9571

From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>Sent: Thursday, May 2=
1, 2026 9:28 PM
>=20
> Teach the atomic DMA pool code to distinguish between encrypted and
> unencrypted pools, and make pool allocation select the matching pool base=
d
> on DMA attributes.
>=20
> Introduce a dma_gen_pool wrapper that records whether a pool is
> unencrypted, initialize that state when the atomic pools are created, and
> use it when expanding and resizing the pools. Update dma_alloc_from_pool(=
)
> to take attrs and skip pools whose encrypted state does not match
> DMA_ATTR_CC_SHARED. Update dma_free_from_pool() accordingly.
>=20
> Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path so
> decrypted swiotlb allocations are taken from the correct atomic pool.
>=20
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c   |   2 +-
>  include/linux/dma-map-ops.h |   2 +-
>  kernel/dma/direct.c         |  11 ++-
>  kernel/dma/pool.c           | 167 +++++++++++++++++++++++-------------
>  kernel/dma/swiotlb.c        |   7 +-
>  5 files changed, 123 insertions(+), 66 deletions(-)
>

[snip]
=20
> +static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen=
_pool *dma_pool,
> +		size_t pool_size, gfp_t gfp)
>  {
> -	struct gen_pool *pool;
>  	int ret;
>=20
> -	pool =3D gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> -	if (!pool)
> +	dma_pool->pool =3D gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!dma_pool->pool)
>  		return NULL;
>=20
> -	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
> +	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL)=
;
> +
> +	/* if platform is using memory encryption atomic pools are by default d=
ecrypted. */
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +		dma_pool->unencrypted =3D true;
> +	else
> +		dma_pool->unencrypted =3D false;

I'm curious about the name of the "unencrypted" field in struct dma_gen_poo=
l,
and similarly in Patch 7 of the series for the swiotlb struct io_tlb_pool a=
nd
struct io_tlb_mem. Up through v3 of this series, you used "decrypted", but
starting in v4 switched to "unencrypted".

To me, the above "if" statement has some cognitive dissonance in that if
CC_ATTR_MEM_ENCRYPT is false (i.e., a normal VM), "unencrypted" is set
to false. But I think of memory in a normal VM as "unencrypted" since it
was never encrypted. A similar "if" statement occurs in your swiotlb change=
s.

Two related concepts are captured by the field:
1) Is some action needed to put the memory into the unencrypted state,
and to remove it from that state? This applies when assigning memory to the
pool, or freeing the memory in the pool.
2) Is the memory currently in the unencrypted state? This applies when
allocating memory from the pool to a caller.

It's hard to capture all that in a short field name. But I think I prefer "=
decrypted"
over "unencrypted".  The former implies that some action was taken. It's a
little easier to think of a normal VM as *not* having decrypted memory. The
memory was never encrypted in the first place, so no decryption action was =
taken.

Throughout the kernel, "decrypted" occurs much more frequently than
"unencrypted".  We have set_memory_encrypted() and set_memory_decrypted()
that are "take action" names.  But we also have force_dma_unencrypted(),
phys_to_dma_unencrypted(), and dma_addr_unencrypted(). So it's a bit
of a mess.

But maybe there's more background here that led to the change
between your v3 and v4.

Michael
