Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011001.outbound.protection.outlook.com [52.103.1.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380A3BE144;
	Tue,  2 Jun 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410286; cv=fail; b=svv9DMQhLrjvOA7HWQYlKGOsC8eFe8jg26l3wXfjUJCM8w/lQiyS94xV/3rVKZm5Skp70xcMfVpIai153Wm6IMl0Cn7JOdKT3G4JpHgpWwQbvJVVT1laSiiDcQ4yBbpksc1rzyaWaxoCdxJp4q8rIaT/PilN+ScX7WMhYZHg6qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410286; c=relaxed/simple;
	bh=+UnpUnaY8UrATtU2t2E6RG4xZvcZyo6LZSXccd0avik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T7sOlii01H/bQGhWw+v16BkMERc5EOrM+F7nokM/jlwk4EXaPZXHo/lAByvxqi2VWmUWxOd6E2gE0hkNrEsc+1S3l2UDIHSNPRdu6mt39ac3GPbNBnIIFrQ79BfAXy7i3sGz3sW+aYRuEsfM8GuUDxzmOmJQbDFEOelqP5xBY/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JELa3IOQ; arc=fail smtp.client-ip=52.103.1.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JELa3IOQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBC033oA9MPG1vtI4+LptIJCefcQ/pINudkC3nFOT0fSih/IB5u/K4Lcn9prGhTeJpMwQ1qNZG1Hy18WMPu3WPI380RXqMVvg1jNVU3kaMBwkH86zMhcIBDzgJrTnnOy9bStxQSoYHGXm/lR2tb1LGntMh5EAWttwR8LI/R4WiPjw+ixeOqh/ADTqyfjsgDq3Gv9hrWWVGg9AcN0s9tLmDaB7rDgXMLdobQfC90y8TdHOW0fnv3YpSZBoZkH2Z++Y3wzGbyQGwa4Jv3V3txtiyQ/6xML4cU/s7zDR+nS3u3m4uIubli0drAR27sj3apc0YPE07UBENo8iCdBxl8xZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VniBiCCvYeTRsch0Z+wguVQDokgskI/0HVYhOI9nXlk=;
 b=wL1bDkNburTMBBqHAL/QfjIX8forsowDPZWMzDjPo+xr6dMog9boLwxphu6p49sQYjoRbBccgVTEsSiBDCN0qAr+x/mMwn45lVPe4CFH0E2G7aob24XGWDeYmcYI/zBw1jrvalLFPStjolVogcQaWFSI3dLTAmXTLoiIHlaAcAVVMV2BKIPOgnsVXGmAPqPRfs0d1cbEKgoTNNRWfYObWciomukdtnygVhHIYduaAttmAPmh6hiNPPiba6pkOcak7Mjjkms9zdFAwFylWw3apLqwuzJC1HesFEPYjqa/kCrSZSHTg8TCFy4ffRSk3K9HBxE6HwihssyZBcxZp5pnLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VniBiCCvYeTRsch0Z+wguVQDokgskI/0HVYhOI9nXlk=;
 b=JELa3IOQSZ41stzKB+oh4OB8qtcrkAGO1ASrPezCN6QBNa5fFKqtjQklz01zyzZA5qy4EwWYi1XaNogke8sYWVcnZsJcHrXEz1UIwPO0s3ThSHHAW0vJyKTV3hMd+t5trPpD6twKyoY23kk7NROJzufC/jIswFiA0rN1KSFwS73jlo037OBKpLUoqHP8sub8SXO9rNbN0BipTLWzefTwL89zs+gF/DQmjpB0wI0CiWFAo7svFfEIJsyXT1ZJVx8Nz6FXmOOoK1liECfAt0OvTI6ZdHav9xdKkIuZxWJSGmeKu2vsmQddqC0WkV2uQ1PTe4SCWVWjLGY/39DXIx7mEQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA1PR02MB9494.namprd02.prod.outlook.com (2603:10b6:208:3f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:24:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 14:24:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
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
Thread-Index: AQHp6tfu5DGfxW+HBL9src0vNhss0QGjMATQtfypCTCABxNTgIAAi4fg
Date: Tue, 2 Jun 2026 14:24:40 +0000
Message-ID:
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
In-Reply-To: <yq5afr35sciu.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA1PR02MB9494:EE_
x-ms-office365-filtering-correlation-id: f04ac679-8342-4fa0-c472-08dec0b2af26
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|13091999003|37011999003|8060799015|51005399006|15080799012|12121999013|19101099003|31061999003|41001999006|440099028|3412199025|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JfXcuCE9SVQbW7c0ZKHSuAAPiV68XlWtLXAPE/YfMoCMoe3GPJVk/thU4hAz?=
 =?us-ascii?Q?VTWDKbXPp1YuxM+RceAJ4fsOVJ9Nvtgd2xUa+seWhizCLU6fxkzz4hzLVs+7?=
 =?us-ascii?Q?BWSnDi+kVPKAD3Yw3su8nl6a6aANIMGIOSLDuMYyQBd/ZX+l0fknaJiD7w72?=
 =?us-ascii?Q?RttW4b0o5LsRdE29aDFb/dPoEjy3bScOvRe8ZkhFHcmfGfJLV3b68kG1xTPw?=
 =?us-ascii?Q?vJlrZB6SIEdhGhp7kF8bA94xvs5iKbjW3rCLb+TVD/x96nZ7g3UWsc2Rwd0E?=
 =?us-ascii?Q?8F2USFsP07VSdR3xB4NvGoyHpo5MQIO3K4mav00uVKPdoR+8/TA5jGyyVGOX?=
 =?us-ascii?Q?mDc1cI8HFpMdbt1/ZeSaevsdnvmNhqOyaNo5EK8kVU2s3zlz1cefXd0/Ldh9?=
 =?us-ascii?Q?953KqSDpWyY3JyhPKL0fHeghVhxskxxQHFLEcxseSuSyCEKwdXS9+2O2nPIh?=
 =?us-ascii?Q?Hh2wBazEBO2ffE/WyxmcBKHgOHlTear57Q+iS0lHznReLj35RhNeueEsqprW?=
 =?us-ascii?Q?7YQ/g4WKXNaUFdEyluAo5m8CKHmgDLnH9g8Ybtjv9hlYytbkd5v2cjZfHgjv?=
 =?us-ascii?Q?3JaLFM/SIMvV8YZangXScYMte7kD+LE6QhLkResx7ZAuDfnLLBlNhAhlLWCj?=
 =?us-ascii?Q?vRdj+/aX3fjb2n6hOJ2I0TMlk+GihhlD/XvpmwocTYrJFrJ20XOGl+ZD0F3q?=
 =?us-ascii?Q?N2wjMSoLS2QYiq2jdHC76tvYp0eftgqOsCkoDKAscQNyZCVYicZthkFspfnN?=
 =?us-ascii?Q?IgHVxG4dP282REzIOKJVbx5Nro3q20OOxr+SdFaOwm3O3BAtB7NegnkQrBYe?=
 =?us-ascii?Q?VaaqBbkvKo6RikokmWoy9+ZDjW1iktjagDmz678P9MJArWmqnQrYPcz7nRHI?=
 =?us-ascii?Q?RWovAArzCcHmLZRgVt1bCGto4NOzWDrmm+4yfN2iIOemUHsELPi/h6Oj7Zjx?=
 =?us-ascii?Q?YIbQt1Hq6QXNdBMwYipbG5D6QTZ9HxnO+rlnKvGykq9r9J71IsfMpT3ayJu9?=
 =?us-ascii?Q?eZndAPT3O7PNO3VgDW88yXwfCYZOydNQkS0BlCd0MAMAR0kVOJG1rMvv/qvA?=
 =?us-ascii?Q?G3X9uVDixXvAU82sMKrQDqqC2oDNhahw0E+Y3NKI2BFcNhPxWy4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QJFSkC6L/BO/GF2jjDeJyFEFNSCCpXecuWZ9sSp5Uh73GwxqItc9Ypwe7xjM?=
 =?us-ascii?Q?1ZjRf5oFRZLd8+HTMoWCugLOCBDUOvmIpbsNpeCXkSA8WapzU62QS163FXLn?=
 =?us-ascii?Q?ImKZ1vujDR/8TNK5v95N9x8OaSpSDhcIvaUXO1+inkwObZe8HQhPD/DtRI93?=
 =?us-ascii?Q?RIKTh1KqkiwDvWbkLi5vMe1g3046Hz/AHK5WAySW1zQmqAInnnnZxQWDLM7d?=
 =?us-ascii?Q?dZqBtNxgs7fFUGyAY7d5upJiAj//XoPSbGtWchWxMCOQ2P58Iobqf9atzyFs?=
 =?us-ascii?Q?PCCQLaaDohuX9o4mExzN9oOKpCvw7GkI8Ex0rOIlCrEE0lFgVKiKGHxJy6ns?=
 =?us-ascii?Q?48F/oIsNSwQsiwZTcE/KpKCGXdUMJhteJJDuP8odfkevtrQi+kq2coNmJyZS?=
 =?us-ascii?Q?Bs3r7slgh1pHvVbkyCbNnj6q8PctBGWVfRmYYOB/vbie9H28xix3AoT0LwZd?=
 =?us-ascii?Q?gUIl1VZj4Mkrcb9yMMGJC/4XQ1cPDn5Wb2MFibkf02r0Cv7PUy/IRZgzfBD2?=
 =?us-ascii?Q?IaHmTg+MNeYlG82ZcQHvUHv0qVJznZIHdgpa6lD9UdKw9yqnRYRhy+b/BAWM?=
 =?us-ascii?Q?f+kbyGkdQllA9u0tzzoUHxptsDQ6Qo/AsHqeRea5hTLrfA4VmyvuDzZM5X/X?=
 =?us-ascii?Q?aRwGVt1RJJyRjI+i6YLNj91OrABEqlEVW40Cm5JNhLLbLHEVL4TAfMiAk651?=
 =?us-ascii?Q?2BYW7RRIUmmgTqMj1UAIRScCBmPYiELrLQ8XGQIrfZEqSJbQIoDprrtnevJa?=
 =?us-ascii?Q?iIETSZF87IfrzXhmWujW16z50jvcYoJjeWBcz9zOQ23Z1lrNP51GBMRk1vH9?=
 =?us-ascii?Q?K1Zvep2fX03rcDr4lrTy6gQlb4mkNUzmhkFRElv5G3Eii/Yc105guXCiHkFZ?=
 =?us-ascii?Q?i7l/sDw4qcmWxKkbH4ssRRVqhhdCcyhmKni0U/TCZblRmU2XRpvQHuLyHKdO?=
 =?us-ascii?Q?Lj6dcqxO06NKdHkP77hsODk5CkV6zIqW/kauOiezD0D8pNCGSg7sCYQRSpnd?=
 =?us-ascii?Q?H4J1bxMET1b3Yo4flUNwJLD2R4FpvGbT9GLvvS5GLTCFMsiVGe1NhzO87hem?=
 =?us-ascii?Q?VKQWPiRg0up2ech7nFUD5KRMSN8ZeS8o4+SvpOPc6VQ6ob1ovPjhCVYfgWLi?=
 =?us-ascii?Q?YmOBII05PnhcYX8IZJ7LIat3IGauJy+72Wute9vLUhcdi6+AltiDI1WXoxQg?=
 =?us-ascii?Q?6T+PnP6lD44UdtG28XeUZosxIkzghf2Q6WSSvP+1cp0pRtZ/BJw0mYA2o6aJ?=
 =?us-ascii?Q?sOVX7v3Fs4U3amAKeZMt+10+dqiE/hvkpEY4R+dnv581jugxm9WiqxNK5krR?=
 =?us-ascii?Q?s0WQkujSZoQuqw/ctaGLHh8E54trfs0IGa9rmfDvW27xKzlIekiNUXP1sIL5?=
 =?us-ascii?Q?FXV+uIEkAWxw4mP1zvCJwab2JIpAEMySFBImasH/Ed7MG38lsI1nQz07RaEw?=
 =?us-ascii?Q?7V+rYJy1otM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f04ac679-8342-4fa0-c472-08dec0b2af26
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 14:24:40.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9494

From: Aneesh Kumar K.V <aneesh.kumar@kernel.org> Sent: Monday, June 1, 2026=
 11:05 PM
>=20
> Michael Kelley <mhklinux@outlook.com> writes:
>=20
> > From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>Sent: Thursday, M=
ay 21, 2026 9:28 PM
> >>
> >> Teach the atomic DMA pool code to distinguish between encrypted and
> >> unencrypted pools, and make pool allocation select the matching pool b=
ased
> >> on DMA attributes.
> >>
> >> Introduce a dma_gen_pool wrapper that records whether a pool is
> >> unencrypted, initialize that state when the atomic pools are created, =
and
> >> use it when expanding and resizing the pools. Update dma_alloc_from_po=
ol()
> >> to take attrs and skip pools whose encrypted state does not match
> >> DMA_ATTR_CC_SHARED. Update dma_free_from_pool() accordingly.
> >>
> >> Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path s=
o
> >> decrypted swiotlb allocations are taken from the correct atomic pool.
> >>
> >> Tested-by: Jiri Pirko <jiri@nvidia.com>
> >> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> ---
> >>  drivers/iommu/dma-iommu.c   |   2 +-
> >>  include/linux/dma-map-ops.h |   2 +-
> >>  kernel/dma/direct.c         |  11 ++-
> >>  kernel/dma/pool.c           | 167 +++++++++++++++++++++++------------=
-
> >>  kernel/dma/swiotlb.c        |   7 +-
> >>  5 files changed, 123 insertions(+), 66 deletions(-)
> >>
> >
> > [snip]
> >
> >> +static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_=
gen_pool *dma_pool,
> >> +		size_t pool_size, gfp_t gfp)
> >>  {
> >> -	struct gen_pool *pool;
> >>  	int ret;
> >>
> >> -	pool =3D gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> >> -	if (!pool)
> >> +	dma_pool->pool =3D gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> >> +	if (!dma_pool->pool)
> >>  		return NULL;
> >>
> >> -	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
> >> +	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NU=
LL);
> >> +
> >> +	/* if platform is using memory encryption atomic pools are by defaul=
t decrypted. */
> >> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> >> +		dma_pool->unencrypted =3D true;
> >> +	else
> >> +		dma_pool->unencrypted =3D false;
> >
> > I'm curious about the name of the "unencrypted" field in struct dma_gen=
_pool,
> > and similarly in Patch 7 of the series for the swiotlb struct io_tlb_po=
ol and
> > struct io_tlb_mem. Up through v3 of this series, you used "decrypted", =
but
> > starting in v4 switched to "unencrypted".
> >
> > To me, the above "if" statement has some cognitive dissonance in that i=
f
> > CC_ATTR_MEM_ENCRYPT is false (i.e., a normal VM), "unencrypted" is set
> > to false. But I think of memory in a normal VM as "unencrypted" since i=
t
> > was never encrypted. A similar "if" statement occurs in your swiotlb ch=
anges.
> >
> > Two related concepts are captured by the field:
> > 1) Is some action needed to put the memory into the unencrypted state,
> > and to remove it from that state? This applies when assigning memory to=
 the
> > pool, or freeing the memory in the pool.
> > 2) Is the memory currently in the unencrypted state? This applies when
> > allocating memory from the pool to a caller.
> >
> > It's hard to capture all that in a short field name. But I think I pref=
er "decrypted"
> > over "unencrypted".  The former implies that some action was taken. It'=
s a
> > little easier to think of a normal VM as *not* having decrypted memory.=
 The
> > memory was never encrypted in the first place, so no decryption action =
was taken.
> >
> > Throughout the kernel, "decrypted" occurs much more frequently than
> > "unencrypted".  We have set_memory_encrypted() and set_memory_decrypted=
()
> > that are "take action" names.  But we also have force_dma_unencrypted()=
,
> > phys_to_dma_unencrypted(), and dma_addr_unencrypted(). So it's a bit
> > of a mess.
> >
> >
> > But maybe there's more background here that led to the change
> > between your v3 and v4.
> >
> > Michael
>=20
> The current APIs, phys_to_dma_unencrypted() and dma_addr_unencrypted(),
> are the reason I changed the pool attribute name from decrypted to
> unencrypted. The rationale was that nobody actually decrypted the
> memory; the memory was already in an unencrypted state.
>=20
> In other words, the DMA pool did not contain encrypted content that was
> later decrypted. Rather, the DMA pool itself was in an unencrypted
> state.
>=20
> IMHO, set_memory_decrypted()/set_memory_encrypted() is the right naming
> because those APIs describe an operation that transitions memory between
> states. In contrast, the pool attribute describes the state of the
> memory itself, which is why I used unencrypted rather than decrypted.
>

Except that in a normal VM, the "unencrypted" pool attribute does *not*
describe the state of the memory itself.  In a normal VM, the memory is
unencrypted, but the "unencrypted" pool attribute is false. That
contradiction is the essence of my concern.

Michael
