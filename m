Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011031.outbound.protection.outlook.com [52.103.12.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59F35A39D;
	Tue, 26 May 2026 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764221; cv=fail; b=JaEMRzdjQogXLPCQODJbv4IPLuMw2glGhoDYixc/V4+CPklpTYFNlczlgEov5Nri41awrOXY7+/PtGLvfW69qXAvzRzd8J6bkFjdL+lAXqkS04nVVtVVVSOVwZuuJG7sWGcu7L5qB2+2N+jjowaGR8S6l3i6jjCZ5OjiqO3BFFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764221; c=relaxed/simple;
	bh=EfJ8AMt+P9PRBW+H1JqIi1Hqiy6XLFpikNIAOsqPPsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M8CAAbZsYDcNpRlz97/uiUIrs6JoejY7whKvDqY/03i1/DMgt7wUktvlLGS8ZF0loMFJtMM5Tz4WZw0LDnLu45r7BIvzqt6p3IaiokgvU4TX8jpdMg5ZHLKt+DCsPpwf1ZyUgL+WZ4BInEYLLLSaMqK3Psx8SE+AfYZ8VJKZnXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XKW1tuip; arc=fail smtp.client-ip=52.103.12.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XKW1tuip"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG+HV4rBvsgaGFQFYvLTC8IymqY85LGwBCf9GhKyUBpEYT9rYgSmYQgPZRbQ17epxgc3O6BTZzXadwy3EEd65Sr1Jv9qZHvDqbQhp2wMyanTOgiA529L1qXtEXt8o93kTpnYv/ikWjI/UzRy4xdu/Dm2ub90fgRA0q17e+GOnffrNlS75kEQHBVjYnF0zLV1pQ4Y9KvXEAHUKOGaupfEouAnGyo5kG1da0uFM7SkO/ShSdCtvV0h/fzn+eqKPdIskzGq8Lc/v3BMtAbL7iW/AuYQWuDyEMQMtsJ2esj19yYCeHCXJxh06AYc2o+qWSU3iV6/A4je9efkpRfbB5wCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yei1BelLDSnmx+IXXDFXNeTDPXNmUmksZlj66ZIIwrk=;
 b=KG1DcY0r4gE9+s/e5/R5DM+ydpegUNmI6LQkciytGRJM0dmhdBWyaF8ScpMphwXl+dWpwEdjiGRuglxBz5mHiIdZK/rxz57W7vUNdAe2wL10sZElvEEhAgGnYNjIw25BwoLI3gU8G9Prn3Ab2uQgXtx9sCYCgbSL4bcaHPNfFz9BilueE5nv4T2vwA2AXA872ePWqp0XMoxXEizWWKsxTzBiE+oztWCI1xWM2g/9yHy9QKxHPGMTbEGEZH/fzW1oyB8nVToyfaKH1+nrSk8G+wmRVInekRTO01bNAqTR0gNir6OIr96zZSiXVAzHMwHMcw2/zqdq45eY0O6hoz5ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yei1BelLDSnmx+IXXDFXNeTDPXNmUmksZlj66ZIIwrk=;
 b=XKW1tuipNMOt7J/YR4p+r3x2p3lcvrLFx5MxpaKZ7YCjmQlZbFVioXJgUJu27iRkgx28LZwK2vjPIQF/SefBpJpv03C5l/6n8ZK0IgQzrM9u5K83uNtAKGWW8OXbUf7QTsFpEY4eY/WxVCtgLFbde0mCFK6ce/rii7hYgnDKispi336/Gbzzi5OaaJUhKoGA+l89fjaY0Olfvej/sj2utwi5mjOMAx0+E/oiOeIQQhRby8OVYWoUFVdXpSUv2cX/9XFa9izF19ux4shy0/JkFLyLGzD7bwrbJgTuCKk8xkW6KNYvcsC24NocAYSao3b+pWrw74L15Wmuq0dCfPubnQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9515.namprd02.prod.outlook.com (2603:10b6:610:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:56:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 02:56:57 +0000
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
Subject: RE: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Thread-Topic: [PATCH v5 10/20] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Thread-Index: AQHp6tfu5DGfxW+HBL9src0vNhss0QGHKPZ9tflmFZA=
Date: Tue, 26 May 2026 02:56:57 +0000
Message-ID:
 <SN6PR02MB41574064D14D4A2734222C51D40B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-11-aneesh.kumar@kernel.org>
In-Reply-To: <20260522042815.370873-11-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9515:EE_
x-ms-office365-filtering-correlation-id: aed58040-491f-4983-3c2d-08debad27362
x-ms-exchange-slblob-mailprops:
 9IecXKUgicAz80qrkIsT6kQ0LfhDX2IsWcHQciuYMUrut1JD3mUof57j+ZGnz3BDMJ33pcptrtsNfB1nR5NzG/s8HcaJ99skL679uM847K4aPKuukd9hq3M/QGNNUT+gWarbgXaFClQoghn7unFfS20gn9iH0a97AqGKT/G52fCZ1OUtc3JMcT9Eb8jp7tICa4ma69YE0khDkXYePCpbheB1p5sEZzPldLqSb5NOPNAoz5lScx9/CO58e+Rf6oY3s5klNgj0ws8BG+m6T+dum4SriqLLEOLE6LkHuocLzTQV8tUt8VQSKz8BiNNWgyWIjcUESY8CAPTUo9oNnmhp4EjC+gmA5VtQNVSEK+HJ+9C+ZyLpDioVNcQGZNYdMNTSdhAnsHMFNCZvYKw+f1EOUffAGlnCDI/8TYySm1gmjPN1M0o3Kz/iypldtmkd6Q1+umdZSw61CuMAPBj1Hxs2ZzgzmbyFWAA91YLq/tBdyKu8V8o6YnUDi0CJ4NEwyr1xwwU1ZiW2UTwwpB1cBMRiHMEYhioqnobRnI2CdpLC0UHQkdJ+RnvxU4QDcuhcl3vZwWsZeSy8i/W1Kfq8JjmmEIihMAyA1eeLLm1Me0XOSeBOm23XTLehBrWNjkHtBSIkDj6DNxFqq5qMhVhB3a94VlosU9U7b+kev4mPLh6nvQRTmllmLhdtkxr7sPfKMojxxMN0AHrOX37kF2UwpM/EXJZHdczFym/bGVhpl5pnmcpTyN2lUTKYDg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|13091999003|19110799012|15080799012|41001999006|8060799015|31061999003|19101099003|37011999003|440099028|3412199025|102099032|52005399003|41105399003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wWB0OS3byDqi33lC1+iWyKK/RZkm0JEYuQ9LJJtYNkAQ1C9reKc/yTlmbkjm?=
 =?us-ascii?Q?Y80O5F6uJL4my0BPcvFejtwh7miiM8VIQd7tmWxZBljqM65D2MnYLC4kkKO9?=
 =?us-ascii?Q?Aq1Mz+DVaIFM6vsedPIQ+dvFyouY4hljpCXyYW9Fy+Hcm7vVZWXp5k6beKMs?=
 =?us-ascii?Q?Sx6jcGlcwSZWS8pK7MC4o7f+m7dNvP5bFSW3hVClYYseASlxUoiY1q/Swoj2?=
 =?us-ascii?Q?r1pOp6JAivGauJWOG1Xe85wVZqy0OALOAcHBxcl8hSOYID3StdLFKy5Do6n0?=
 =?us-ascii?Q?TeRP8W0FQR+kA6IRX4YeyzIedbWjzffOSHjIKBLq6Kij3M3MQ0V7xMHA+MC3?=
 =?us-ascii?Q?oPTCLWsokBPJxmlHqkRCNKrD0xUIM5/hv7d+huGxrlgVKRwwfLktU3Hr3Njt?=
 =?us-ascii?Q?Lt20zR/8VVItaHRpKoJut1fqu7LCHoNha6DrXmV0a69BsyktcHWwQJ5mOdGI?=
 =?us-ascii?Q?ca46Rd4Ws9FJJ/q+Vdo54DwQX8gqM6oG5mFFXcrB+xMyR5kOAzJj8O3kgIHY?=
 =?us-ascii?Q?yUb47U0LQp85Kj1SOO+xM2DfmZgOuWMAYuyeVm1RUNEGeMJmEPVytxN9GzcU?=
 =?us-ascii?Q?B3zW5GnHYfmTtH/CjjwOwOERxEkYpspNIgXa8gGQEohevN9maOReIoq2P7af?=
 =?us-ascii?Q?EuSga42HI4g27XigYdzvb/EGTErQiZZNx+ehkoi2db00W0Cwuf9BjJHXiyYm?=
 =?us-ascii?Q?eaVumrmYoiaDvQIg0Cc8O2K1kP3VbU9c+weyMWNKKiGSL1FqZjcfBlORxwqp?=
 =?us-ascii?Q?jZKOjPx4sz2tflbifeRBBIgFhLeADR2SwkGkmytt7mrx86ZP65UfJEJPut8M?=
 =?us-ascii?Q?wzb6WNKswCbVsQ6bXrLcNSo7S9V5o3edvvg9G7UCn5k5EPOZaaEXCWyN3qwx?=
 =?us-ascii?Q?5hxGLJE3w5X8/mVEvMncHAJCKnRedTkJdF2L4joMIBuFzbgkGbtuFsoR7dOE?=
 =?us-ascii?Q?+J7MqvelWt2dwDT0MpPvsocw8k9PfkstPMEPuE8HgTHk213mOr/zdqONFfgL?=
 =?us-ascii?Q?NEONvMup4eAqbbtVyeKU/CdUm0Xly+qrPv5XfO2GsRsk4+SwXA36qoEfAgnf?=
 =?us-ascii?Q?1hwxUD4w?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+WL8doa3bPYcMGNLrhVm7RIh+tVU9VosFxep9HwWXQbVnNwQKLX3iDEP6glH?=
 =?us-ascii?Q?UpBfxKevdgKE/FoCwKX7g+0q6mMCGeD8GUPJ/YS1V6rxF0Rbb+2iLDdJb85c?=
 =?us-ascii?Q?7+PUj801lEqJU/7JSnXQZSV35RH8ejHSkRwZ3g5IDc8MEAdL627Kf2Ah0MPA?=
 =?us-ascii?Q?YPvuTvfLGXtsjvDYCqK88PMMrL7iTAZiHGVCKjBtPiutHlMNg/Zw935r/hWR?=
 =?us-ascii?Q?BarlghhAhEkAgqnKa0enIG3IeLNoDQK5Ry1VTk+xj27NhbSWPXzy/Hv252WF?=
 =?us-ascii?Q?FClpVvpgJB1ka9+vMj4DaL33n2erj0Lee38N6LFwgJGmQJdqgpRMFDLjuSvU?=
 =?us-ascii?Q?54VKzXklGcA4CZwYkr/zk4/n/sOHP+jhgX2vesKDAnPfawjuO6SR4/JdNxXC?=
 =?us-ascii?Q?sEqmW6JhduUt8a5vYqXvTSsmS4ln1fzfY7DAVSXk0+GtFHvGcddUhvGg9zep?=
 =?us-ascii?Q?qO03/WZq49Pr322ZB7keqiDRugIodaOV7V7WO+e6jn1b+xtShLpAjYSWDiVp?=
 =?us-ascii?Q?RJPdz02DCHPH35oUn9k6oGjeUM9xLRTtoaZr18IwEs+HZvWMM4XJ/OSNB53w?=
 =?us-ascii?Q?jK0a2uA45aouvhPzXDV7sd0B+Clf4XMLb0PBjkWq+7WF9gXdNp1jz5xKPb9/?=
 =?us-ascii?Q?6ZFY42NtGv6G1nqZcQWbcZ+nmIDji2qCx0PoPxS+iHI7ykurtwYsmXhITDRX?=
 =?us-ascii?Q?HIpMawfNvRMmj6MMKohpODli29ijx8CULyE5u7ifsmneYUYkiwx9P1k2w+LB?=
 =?us-ascii?Q?eiQ3fksHNTBxE3ACB+HkUyvVHPJ9eUshIUMTMNiESQA+XO0QGNrLGXY52vA8?=
 =?us-ascii?Q?5c767j2+9SEb8G7GitX6ZThhCTVni4vaZme0dJnqGG2FFo69hhb12BMC37dU?=
 =?us-ascii?Q?zIJUsltdZfc+GogtTSW18YFK7qSmmjvl/Tq2RDtyhjVvGkc9So/nN2fz9fMj?=
 =?us-ascii?Q?S5rbJn60emyuJ/cDuo6X6UztH2UNpGrzO9cW+AlypNHXRoK4FmqG8Z2hAJch?=
 =?us-ascii?Q?cj1MWr4iS4K/pdVPinbfejsh0j1bQhB4ZZSyKOm+uUFG1tHYzNuFXnsROxWg?=
 =?us-ascii?Q?B08Q77cj/myMc48JGdwMa8AVrnL/jir7Ukv20LIGBPFdi1+a8zpGumRVGFms?=
 =?us-ascii?Q?ELnZ5DhQjWxuG/bDOWujcldLbqLOZX8rFW7FRULI52g84IYUItjMaMYiiUng?=
 =?us-ascii?Q?wUb4QdOTywlbvhpawLmg5zmJp+PTgJK10RCmlAmzG7OH9D7MahMNwGm4pdoj?=
 =?us-ascii?Q?hpvye+5wpmYodthV4KW7U96iX5u3nSRYN46aCYQUhb4vOHgLpcy1bUJRYxnj?=
 =?us-ascii?Q?SdSavEY2PFUhe7+FJ5GvXX1rsIW32A2X/Fd25mkGi03cVUgLrPjttfQHLyiT?=
 =?us-ascii?Q?2UjobOY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aed58040-491f-4983-3c2d-08debad27362
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 02:56:57.4661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9515

From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org> Sent: Thursday, May =
21, 2026 9:28 PM
>=20
> Teach dma_direct_map_phys() to select the DMA address encoding based on
> DMA_ATTR_CC_SHARED.
>=20
> Use phys_to_dma_unencrypted() for decrypted mappings and
> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
> but the source physical address is still encrypted, force the mapping
> through swiotlb so the DMA address and backing memory attributes remain
> consistent.
>=20
> Update the arm64, x86, s390 and powerpc secure-guest setup to not use
> swiotlb force option
>=20
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
> Changes from v3:
> * Handle DMA_ATTR_MMIO
> ---
>  arch/arm64/mm/init.c                 |  4 +--
>  arch/powerpc/platforms/pseries/svm.c |  2 +-
>  arch/s390/mm/init.c                  |  2 +-
>  arch/x86/kernel/pci-dma.c            |  4 +--
>  kernel/dma/direct.c                  |  4 ++-
>  kernel/dma/direct.h                  | 45 +++++++++++++++-------------
>  6 files changed, 31 insertions(+), 30 deletions(-)
>=20
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index c1b223e7cc8e..a087ac5b15f7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -340,10 +340,8 @@ void __init arch_mm_preinit(void)
>  	unsigned int flags =3D SWIOTLB_VERBOSE;
>  	bool swiotlb =3D max_pfn > PFN_DOWN(arm64_dma_phys_limit);
>=20
> -	if (is_realm_world()) {
> +	if (is_realm_world())
>  		swiotlb =3D true;
> -		flags |=3D SWIOTLB_FORCE;
> -	}
>=20
>  	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb)
> {
>  		/*
> diff --git a/arch/powerpc/platforms/pseries/svm.c
> b/arch/powerpc/platforms/pseries/svm.c
> index 384c9dc1899a..7a403dbd35ee 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -29,7 +29,7 @@ static int __init init_svm(void)
>  	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
>  	 * otherwise.
>  	 */
> -	ppc_swiotlb_flags |=3D SWIOTLB_ANY | SWIOTLB_FORCE;
> +	ppc_swiotlb_flags |=3D SWIOTLB_ANY;
>=20
>  	/* Share the SWIOTLB buffer with the host. */
>  	swiotlb_update_mem_attributes();
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index ad3c6d92b801..581af1483c42 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -163,7 +163,7 @@ static void __init pv_init(void)
>  	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
>=20
>  	/* make sure bounce buffers are shared */
> -	swiotlb_init(true, SWIOTLB_FORCE | SWIOTLB_VERBOSE);
> +	swiotlb_init(true, SWIOTLB_VERBOSE);
>  	swiotlb_update_mem_attributes();
>  }
>=20
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 6267363e0189..75cf8f6ae8cd 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -59,10 +59,8 @@ static void __init pci_swiotlb_detect(void)
>  	 * bounce buffers as the hypervisor can't access arbitrary VM memory
>  	 * that is not explicitly shared with it.
>  	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> +	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>  		x86_swiotlb_enable =3D true;
> -		x86_swiotlb_flags |=3D SWIOTLB_FORCE;
> -	}

With this patch removing SWIOTLB_FORCE from four places in
kernel code, there are no remaining places where it is set.
The test of SWIOTLB_FORCE could be removed from
swiotlb_init_remap(), and its definition could be deleted
from include/linux/swiotlb.h.

Michael
