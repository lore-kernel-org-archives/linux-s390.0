Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011028.outbound.protection.outlook.com [52.103.12.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1C379ECD;
	Thu,  4 Jun 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589923; cv=fail; b=pxEfsKcxS5rdTjRlWgnYYEen0S7a70QtY/rwq2qpaovnRH03C04jmeW4p8F8qiWIbzUcY3foaVgdinoshWGD+vmS0MsNpxVruJ77ImOD6eXEfT877XUzx+xvX1S3MRo6nmwufb/fjwclws3hV7xMZOw1b5msL0676OMq7fNDA58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589923; c=relaxed/simple;
	bh=wUglpKPCiKvSwQM0dgI7bJkSUNH4Gxe0QSSxpsfHO4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tIQawzZJUNtps38P5lOrNWYUvLZYZhgA9ScWP8ORUCWrlYXe/P5QDLSnl/fmcI46HWsgaOIWwZhkHRotflcDgnlB0x8aXiacpnhu8eKlo28zEOXautMb72wrAI1QpQdqcCEvBXC61K5kzdpfajFSrkqjaCdzE+OrK3Rb36z487U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QEsyy5ST; arc=fail smtp.client-ip=52.103.12.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QEsyy5ST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rWXZdQKo4hJMOTrXishfCKjc/nKF67nngFABsfQ7N8XbPWqiqZmLp1Q/XdOd7TjK1t2lHESCn6c9FfYuBDhr87nWzW4ERsID6Jt/uR1ZFMxv7g2nF4rMy0BTUXJa4nFNVRxk3ad+p6RHbKy+u6QSMAU5/9hgfHKEosS6Ryjql6zdzNGaWYX4csg9bFdLcnKAhy5fkNVjJ0mQk1/gNBQoZ6X/ShzkxDqXzrL097lqt5jFDcw1JWWUELLf7A6y7BV/p/p4JERdOe+BRRndOw1xbsU5hLjNEqPgxf/GHCTHTqKW2WjpoEeQZsnpNCsdiA9PIUI+4lM+AX+FssgiYFHbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pezjpO9+d2P8Jxi67k+0WdnFKmVMdVIaxj9+26sZtmk=;
 b=pnQGPaSL2jvxVJ5UvCPtW1aUQCr6vJTsPJqexVA3qrCTD9UHrsGYMOSbc4Ht8TBgjVDUnzC2g4W1ySlxbYWinNoy0P5zxWtxOxEReHPGaPrE0RtN31thbMfQ1dl6n2n57e0MbL+y9KglbyOA3Ef4YkAAbj38t/6ndsOcWIjzk/c/aeNo3GjKUPNFA/CRD4i4+LqQKA4lkJ2gNHEXdFLqTgnomme0Wiq8IwV+bZ9wlfmZsWwc/88Tc2tzgdj5KoipiHIzsAJiDvu3dZ4u2QFtecYyRuqErkh5774wPCcyBQI5ICkqyf0OwxdzhScHSOXchzx58k95E4eS81BrxXF3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pezjpO9+d2P8Jxi67k+0WdnFKmVMdVIaxj9+26sZtmk=;
 b=QEsyy5STVBXHUTvkxS0Pkupr45Kjd1ydaf++Kt6bTb+30MAy7lKhAQzww7ZNUwagcJ1khnoKEf/IgZC40skCAZPtT22gxpbODnvziXkriodAGH6W4DDgvGHiwAzmztvgfad649P0IhKPC+nTwfZA9JEl+OGozhwP6qyXHZDXcr+ZMIRAbfUIzPppfQ3t4aq3PfCuEkAAvIxaXsnu35GjDtd2zNvMNs612UgS1xPWUc8CNkUM/u71Wu9JUTccwwd16HOBEw6+O2F2YhqFlFAcwkcYGBDzpgsTg5pu5dgZIl+F8baI0EH6z6Ba+phX16lUe1soLgY+Z2ni531vuRucOQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8223.namprd02.prod.outlook.com (2603:10b6:408:155::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 4 Jun 2026
 16:18:38 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 16:18:38 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, Jason Gunthorpe <jgg@ziepe.ca>, Michael Kelley
	<mhklinux@outlook.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
 Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>, Petr
 Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald
 Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Thread-Topic: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Thread-Index:
 AQHp6tfu5DGfxW+HBL9src0vNhss0QGjMATQtfypCTCABxNTgIAAi4fggACwGwCAAm86IIAADo0AgAAWnpA=
Date: Thu, 4 Jun 2026 16:18:38 +0000
Message-ID:
 <SN6PR02MB4157BC5B3C824962F091996BD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5apl26qrof.fsf@kernel.org>
In-Reply-To: <yq5apl26qrof.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8223:EE_
x-ms-office365-filtering-correlation-id: 89785a9b-79f0-4673-b6e5-08dec254ef75
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|51005399006|41001999006|19101099003|37011999003|8062599012|8060799015|13091999003|19110799012|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D4uhAPljiDenAI7OEsqFIHYInh2zOm3D9PmrebIMbwbBc0+CqmmhJ1Q9OmiN?=
 =?us-ascii?Q?CeqMKQZwJOWl4dhAFEwKLvaBHTF0bzuOlb2rOQQnS/IFuCuPbs5HNNEyuPv4?=
 =?us-ascii?Q?/nTqiNnXwU6n4WFucwbkSlV1U7bj2o7pWdT5/P8d84Lst1rjAHPkaxeiGua/?=
 =?us-ascii?Q?iJaMl4+E5Vlh+xbwX5jpsWs+qvGMuRCSo83Q/0168CGEeVRIe2Cnv1/kmhQj?=
 =?us-ascii?Q?Ba+CkFMnIm28o2tGEpHl3LUTcW6JpD1p74dFRB67gIFZQycl9s3fU2XyCSY8?=
 =?us-ascii?Q?uO2wtvAyrvts6J5aXMug0KPI++/VZp+d5WPGRUchp0jK4JobiPy6ZPSQq3VM?=
 =?us-ascii?Q?GDVkBR3+o3mE0M1wGsRTTzTUolTwW2VVMAKRwukvIS+belcxtlSIfj25GLJc?=
 =?us-ascii?Q?APrSSoprgZfSJ68QDujTHNrMWzDBDsaBlhNB7jCJ4eGzn+MRDQEnC82vtMsJ?=
 =?us-ascii?Q?I+Sqjcuj1DiREgZbSTymIZ+OKUw3Py5pUEz/yBMkqvj3JJor/satBrIaDt6c?=
 =?us-ascii?Q?fx4lT+zZzWxiEj/KnPsWszbRqedcvevh3biWZLalxNZIO7mcRDqD82m6qqml?=
 =?us-ascii?Q?sO4Hd/4nWDEugqmO+j8vMbHKYLEzRqqZK8yNEg4g2Oo7RQsr/NY7GoXkIwuS?=
 =?us-ascii?Q?J80SV/7ZxVwSLLPUriXQIVR8y5MtVIbZHRZFsfMCh4lIaTpNpQ4Fhd/Nhr5h?=
 =?us-ascii?Q?RN6ZdV9HESu/K2J3C2X8L97k/IM48ZYnJ0Br/mXDdPQnCm2XPdl7gwC91PnC?=
 =?us-ascii?Q?qwEgM5jwZUCm68BvQ3tID6PbQL/X2LDxiY6SJphQSgToTSD3jUvDS1jxpkFy?=
 =?us-ascii?Q?FLtCa3MuNz3T5OGARxZQkDYWvuQAAUpZop/lR9zIHEsp6M1eR9P+L9dy0vnt?=
 =?us-ascii?Q?njL143WcxT2H9/F5YUDS5dLLvF4lUmz6zkb/p7+LEtE1N05KQXez4pxEO+48?=
 =?us-ascii?Q?E/+nXOlJjUpXOMsHoV598vtXe6Ok/pRr2yiqzYGg2u2FkdVnbW8zWh5B+LD7?=
 =?us-ascii?Q?5bj/i9SuOPcLE1XRoHtXV22AEy5sBxQpg5PipD3Bu29BbRfm1H5jPF9dbLaw?=
 =?us-ascii?Q?fw4pwnMs?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o5CKLdFLdk7QdVeX2xmXhggqcLyDjfknKQUFld1YseSWQCBEcl4XbSnZhfj2?=
 =?us-ascii?Q?9OkiuV5HYdTOOE5GSAQKKRLkgl0mrnP3ZrGQ2ub1bElQlf30vQQjO0aD3C1s?=
 =?us-ascii?Q?seN3cEBjT2G/Yqo+yXjMq7JrFoeaWWFojyg9DCVMnUZEbsdJfp018XhMKSP0?=
 =?us-ascii?Q?EPcksS9UN1ESuBG0AToEQ92xf38l+dMBoYpd0ixLFpzAHZDXEigPWqyGQJmf?=
 =?us-ascii?Q?27kjzPKx6j25B7glpv5IgYFwwCbYs93/pQaNuQKUyIfk47zBfa+HdTPeGY25?=
 =?us-ascii?Q?BwO4SC+za/3lrBYcaFoN1E5G/Vv8AUugKBuOgNrz1LbxFaHn31nvJWckMyXr?=
 =?us-ascii?Q?y2smu5rmWLcbo6m7EDcZoNoAzqGTC+URWIq+kpq1/aSykzG1JWSGf05AR3w8?=
 =?us-ascii?Q?9AENSBShDTjHS6JNaTMEoklrRqY651ASrmQ+coQnMeIOYuqOR9wUvqxAw4W8?=
 =?us-ascii?Q?renNustQl/s543nMsxRKTl7XTCOf/PkNbiKfWGgch/UE114L6sAsuQOR+Lee?=
 =?us-ascii?Q?vsPQy4Hqjm5le/N3wjpoUOGkHAbHjc0kDm07c3T5VdKlXeQrpu8788lJ+o4K?=
 =?us-ascii?Q?UWkMWjb3VqSy+91kBOD4sOdCutCX6CiaHsGcJAsyUugEPUCHO1MfWwZAOGc/?=
 =?us-ascii?Q?C8MrQpm/BwUOaoqRuYJtQx7P/0AmBUNFjgC3oPwupoViyp08ZWv1lwMVDeLx?=
 =?us-ascii?Q?rtoBlogiI1SFbfvnPHkVMflzbSXt7LQvdOn/E1svrRTs/1g89Zh40WjjU1VL?=
 =?us-ascii?Q?dXGQo1baQC8YfEtxo+qJbbtTODhVQS2iQ1wTPJgcXG9AuP6YfAs1n/tO1+iM?=
 =?us-ascii?Q?cZa1ZSqv99evBDReHHgHMS/yMt5qVoZgGcrsU1RYotvH1oFebtu0mjvp5oCj?=
 =?us-ascii?Q?ErYhs4HaWnIw2FlXNr7iEQeujoKEjhUN2UXuZNjG6A+Lz3En8kLjkFazm6YQ?=
 =?us-ascii?Q?YYkSarDTC9F0AQtPb/fwzj5aVEhqx1T1dE2HGDbYrJ16gPsczvJwgE4iyq/X?=
 =?us-ascii?Q?LXsGnurr962YFwbba4XUZ6DI8QClUITrVermGug7BIqoMvQFZh6we3UoR2U2?=
 =?us-ascii?Q?LFJRk+d43/8j/j+2mvUttc9s6phfgW2LbYipOeNBTOtkWOHKgzR38mDz57y0?=
 =?us-ascii?Q?u8u73tdcis/tDR8ICcIbYRmNErEkBzZz00FLw4Wi//HcZPsKQ1ASHV9FSLgQ?=
 =?us-ascii?Q?vRH4xoqtjgsC5I/b2SCxEEnDaVR5nJ2rKx5jyCWaJFwNBWc8LW0N/wUjShmG?=
 =?us-ascii?Q?5YKsowxN64cquoC5mJe1Rz/Cda+bypoMHCKuVRqdWhDUt6jW7cJA9E1BwikP?=
 =?us-ascii?Q?GC/iganXydZvXVb/CGw26jZMHeQLVdLVWEW14cOvncQCjCRnSYnJ4ItbPhIi?=
 =?us-ascii?Q?wyFSIfJIDAbCFU7MByxDSbp6l0S5UPF/93KU+H2P0IJ2c6JjtnWXsvw/gbjI?=
 =?us-ascii?Q?GP42+vqRzKI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89785a9b-79f0-4673-b6e5-08dec254ef75
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 16:18:38.3662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8223

From: Aneesh Kumar K.V <aneesh.kumar@kernel.org> Sent: Thursday, June 4, 20=
26 7:58 AM
>=20
> Michael Kelley <mhklinux@outlook.com> writes:
>=20
> > From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 P=
M
> >>
> >> On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
> >>
> >> > Except that in a normal VM, the "unencrypted" pool attribute does *n=
ot*
> >> > describe the state of the memory itself.  In a normal VM, the memory=
 is
> >> > unencrypted, but the "unencrypted" pool attribute is false. That
> >> > contradiction is the essence of my concern.
> >>
> >> I would argue no..
> >>
> >> When CC is enabled the default state of memory in a Linux environment
> >> is "encrypted". You have to take a special action to "decrypt" it.
> >>
> >> Thus the default state of memory in a non-CC environment is also
> >> paradoxically "encrypted" too.
> >
> > The need to have such an unnatural premise is usually an indication
> > of a conceptual problem with the overall model, or perhaps just a
> > terminology problem.
> >
> > Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
> > Name the pool attribute "cc_shared" instead of "unencrypted". Having
> > "cc_shared" set to false in a normal VM doesn't lead to the non-sensica=
l
> > situation of claiming that a normal VM is encrypted. The boolean
> > "unencrypted" parameter that has been added to various calls also
> > becomes "cc_shared".  If "CC_SHARED" is a suitable name for the DMA
> > attribute, it ought to be suitable as the pool attribute. And everythin=
g
> > matches as well.
> >
>=20
> That is better. It would also simplify:
>=20
> 	if (mem->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHARED))
> 		return NULL;
>=20
> to
> 	if (mem->cc_shared !=3D !!(attrs & DMA_ATTR_CC_SHARED))
> 		return NULL;
>=20
>=20
> I already sent a v6 in the hope of getting this merged for the next
> merge window. Should I send a v7, or would you prefer that I do the
> rename on top of v6?
>=20

I would advocate for a v7 with the rename, vs. a separate follow-on
patch to do the rename, just to reduce churn. But I don't know what
the tradeoffs are in trying to hit the next merge window. If a follow-on
patch is more practical from a timing standpoint, I won't object.

Michael

