Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011059.outbound.protection.outlook.com [52.103.14.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFA361976;
	Mon, 10 Aug 2026 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338017; cv=fail; b=XPqlnmdUZvsi+WJnY9MPxdRIQO2zE0nO+u9XXP5l6qImKbhQjZ8OoHC8oKYaC4zB8s3s4Zantw8yzeXxVXS1EBinko6c7HRLvRffWdA6nKhcPUHG8REhi5LNG2CFo6rg2LR+um8FnE2YfmCSVQ9L8RFgnCWdvfq+XtCbgzK5ugc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338017; c=relaxed/simple;
	bh=r+tOW0dlkGvbHUyTJmUHbj5z7PpLWNb/m42k1pJwA18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNiCn5LZ5z3ScYbJ6sO7JKN5W46xLCSJF9NSFOKlQ2nAkqCgu90ifTKzJCaDZSTyEkRnvSp8eMnUbM6rbBNs4PWpeDxZH5yEQ5lbkTZqSQAHLABonvEqitcKLDpSHMSRgN1er7TdoRrWt3AsN9bOxouKnZrc2GbTBm5VkhCz7SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Pr6XfXqn; arc=fail smtp.client-ip=52.103.14.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Pr6XfXqn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X55ynUGcTNQGacflLUM9OkWYXl6Z71Gq+wT9ErSB8O8CtnRSW/bFGAI0v4OuSmv4OQBc6rnemWpIybG7ezoRYVace5/Qt98zmmHUH8uGaoL9XdD/eibTo/cEdE15/l3OMOU5zh9beUyuex80NcrFa5ktqg3yLzivtA/oG3S4iboOlFwzNC2gWCZHFIK8LcZLw7vY2mkJts/W/FgeqBje+RwAwtY2B3JPQA2SFH8qHuj/fxU5qpGZMPTF0AYhStck1TKLk7Ve1+Y0hNv7b0fN1h+hbMHYXbhVLFkY6Gv9HgE7UtHAeMSHfiplMzPOZ+NaCWE4Bkyk7UKV/LT3ecGyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+tOW0dlkGvbHUyTJmUHbj5z7PpLWNb/m42k1pJwA18=;
 b=PPrr2Kupzl/RRX4aEwkNuDSTuqrYtpeyyB9BQxTPMu4UeA921sWovoiTw9E8tZDunn19+yWQk+B8atIVbrfBdmqmRuxDqvfskP8u01dX9vrCBQwoLNkx//7uH6CBXCDv++k9j7N26+PttwBUAyPJpOwx+DwPOISJOr8+7bs5aiIkyludaYwaSMYW3+W0B/EYQ4IDrPMxDN2UAy44l8TWXyVZ3Erhw17k0Pi+KsY9W+UsZ+K8RC3F2Y+5GXd3W/nCngrxxZP7hHuQrXvMNpt2sowoNO1SEyTEX3FeYlCrC4282bEQW8VCabbFEl6sLOi4oSbLacmBTbrDtk2CFgeAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+tOW0dlkGvbHUyTJmUHbj5z7PpLWNb/m42k1pJwA18=;
 b=Pr6XfXqnEe1J5vzkPWqVH/n9lRyHaaf64DMLir+jsidGlha+m+9LQFGIPTtfQ/sjAGgRGCkH5birj497z4rt01Mig8I3I2BNUJUvEZm/Hai1rsEq4KxPZbXaS9HHFbylo004EH+4JQ6bTd4qdFwBtJd2aWuIkjrD9u8etPT/DVXKK2861MetA2ylNTso8dUP3t7rRD1wVZL0kvp9r8mWfNrI9e5ttXPVqUK7jtdwDWSpY8QS5LjJPIuLOVBsUdbEXskFq9ASwpSK0jEjPqf5DBuJ/wNHqriGXiIBkjTxhtdjlga99WeFuXRHw1AqpDK/W7GzXPk5THMYarpU+vkchw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 05:00:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 05:00:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, Will Deacon <will@kernel.org>, Mostafa Saleh
	<smostafa@google.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Marc Zyngier <maz@kernel.org>, Steven
 Price <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan
 Williams <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Thread-Topic: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Thread-Index:
 AQHQ/bqDg0msWFk5/Dcr61MVx8koPAJINRKoAP0XsJ0Bkx2iTwD7jPhAAZh6ceICvguQ97ZdtOvA
Date: Mon, 10 Aug 2026 05:00:12 +0000
Message-ID:
 <SN6PR02MB4157484EFDE3315744021D5BD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
 <yq5awlu1yfn0.fsf@kernel.org>
In-Reply-To: <yq5awlu1yfn0.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7564:EE_
x-ms-office365-filtering-correlation-id: edbd6ceb-a1a2-4ea6-4b14-08def69c42c8
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|51005399006|24021099003|25010399006|13091999003|31061999003|8062599012|15080799012|8060799015|37011999003|19110799012|440099028|3412199025|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8lrtsuMDxbYfbUqwV9lWMF+YaFgYtNEmgGmPcNy1BvNMjtxCb/KbkVIPS09a?=
 =?us-ascii?Q?PHkNHRrfRm1DMFAzjSFRUEvUZVeNdCeDhfFDgKc3uWKxK/GoWrNrca9QJUfQ?=
 =?us-ascii?Q?g8xHuXMkD8/QScvX+wt6pgbM9RPsr0VGMHQOvOTnUomK40ah36vvIfKZxwUl?=
 =?us-ascii?Q?JtJSJT7Z8kyMfPswOjy86CG6oF6gX73T+ViLQhOhogGQl5WQta37krILAZiD?=
 =?us-ascii?Q?eXySDR9G0A7MFRiDMRleCPWLkEk+2mDnWRlHTUZIRLrjWGL2DGXKrkhlLv71?=
 =?us-ascii?Q?rD8trqzNaUkHF4ADL2V5qiLLdwYrBVboCOkxUaqtzZJsakLN79aSF49ZtJXt?=
 =?us-ascii?Q?NQCUbEDaJA6nexz5eQG0FSiE9vnUmlfMBEkdPT5Dw6m4GZhAVDDFUL8q2DZH?=
 =?us-ascii?Q?gyEucWIrLfOZHQn5UxrIw50CkSkazrHVhYd4VSYOvrqatauJxrblKbcf6pmi?=
 =?us-ascii?Q?GX9Iz46ByOzjYCLZb+8CZgwXf14HsB4Cep0sPCW8pqVQ6O1dgN5JVkOpdExC?=
 =?us-ascii?Q?V4xNxydeT3iljbG+jvU/Ygdk8xk/hmx7aTze/dqUq9clTTuuyAjJUsJBojrK?=
 =?us-ascii?Q?BxqIuEGYbNDoOTMqcXLP4Qrh/IMuJzu4qPrICTqSQVeuUNxTYyz40oC69afL?=
 =?us-ascii?Q?GHrCV3R9yG9lzG9hfZrmNxPpz0W8C4Qbz11a8KbKXyYR0429Eq0rDquSfpWc?=
 =?us-ascii?Q?G9l6vkm6+uR/mNw3N5q1pfG8GlrO4VcDqG3Q1iB+z+oHPRu5+EMkN4TD3CqX?=
 =?us-ascii?Q?nQ1+dIQQ1dMYDgoHIv6ysiVtl6Fa5anq1Gt6xIALavkG6bVrBdPSOMr6NK3L?=
 =?us-ascii?Q?VIERPKeWXs+WEHyhVjDeu8pN4eLzjk5KEqaEMNFAozWVp9A+P/1/qn1DVlQF?=
 =?us-ascii?Q?jRYRfpTpnD8Z6tFvj/UJ2+zwWbAD1hDOSOst35S0W9zrvB9YRVr6i9OB9jXu?=
 =?us-ascii?Q?0TjYne19bmPiDUtc/sOKEN91/zX8/s9Z/d5tes/L7J/b6cfb85wbukbceW9v?=
 =?us-ascii?Q?UCygG1rR3/TOUdsspT74vBC5MZejF9Xn6OyS1SvvMnrrb9E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?36W6v0eB2Q9ZVcYPfbK0AzAazUd6NEKd00mEMX6n5oLx+EtP5cSgreV4tJ/Z?=
 =?us-ascii?Q?oWo30wi5xvIVXyxGRRABiHP6zr7Zo5XSCkaf/dEn+emtVPlFyK+KyiSk4dv4?=
 =?us-ascii?Q?rvzdOTkYamt4Dsn5X3UiUZCB1CubbwtgwPnxf7paHWB4lWyFzEEM4TG8jX3g?=
 =?us-ascii?Q?F9lwsoyTHDw20PVmjcZnuyIExFncBEQCLhp1ZUDdRuFavxkfVv2O0AsDvDPm?=
 =?us-ascii?Q?uerHeFmz3Xt0W9b2RMX/oTMm8g93uT799IjE+cBgPu/Wtcekh5XJluyYYFmT?=
 =?us-ascii?Q?WNFp4jsE/fykwhS+q04XdjxSib1eyH37yewJ838Ma7qJY7KVXP4xy/gs6voQ?=
 =?us-ascii?Q?dGMow40oymCmjZG51Q9x+sPItGNXpxOYrpXysuhkwYybLPYY/ISk/mva8YTy?=
 =?us-ascii?Q?NTxorWpIRO6Ophnu4dE/F/G7OL9jZ3WrL0s1eCtFKTlnQ2YHh/UIhOel35wh?=
 =?us-ascii?Q?PhrX1RxCxzx0wbOSQo8iqrwm8OpMUrKtgfEpLVK1yK/cBMkfDe0iCq4l1YEk?=
 =?us-ascii?Q?8nNt4ExnX8CroWQpq9gIz6wq/HWVyIeSV7eVfJOnQr9dTh+p3T/tNr8pt6ss?=
 =?us-ascii?Q?L/7b/elnYua4OyXURp9OeynJFPnydc+IdnX0uYEZh+6CPaSbGFV85FQz4PXk?=
 =?us-ascii?Q?3r8zqPrZgDEXTQ0iJvNFVpDzHIu/6RqMKJpxySENH9s782ma2LZuxmqRKbwj?=
 =?us-ascii?Q?99rv5Bj0ViyRfKulvWz/hlwF7rxMvrCOtlGZaJYP2xxO5RTfYctbEESzjR1Z?=
 =?us-ascii?Q?1QYtY/gdGg0vTfQUmQwUa3mKw/Gkez4xoBKzwQ32DOMdBWnbdeO4J49ZK7u4?=
 =?us-ascii?Q?7QRvFyFWXgPKj0KgSBM28bYTHEgEx5YxQAwOzCm0BKZWL3fyhcCy+B9A0QlW?=
 =?us-ascii?Q?ulvr7mbaSiRHReAW7SmkfQJBKiHzsq3Pgb0hj7KkKvXKqJV+4wSW4xFNX9FL?=
 =?us-ascii?Q?CWx2fj78TEhdwqRsBDHTQjEbryeb63bSQAhdjvXltCGfC2y462YHAOXwmHQq?=
 =?us-ascii?Q?y0zUme5ALxu4O3YVCUv4e+gfl3T2AYKLePYIuwILxFXnyodbB3C5EwMQCTbe?=
 =?us-ascii?Q?SxC8C7CYBq5S6hn1CqyETORZ/ToyD3elgvGhLIMhi6ynxaPVoumYwi4zRbuM?=
 =?us-ascii?Q?yOkzucSM4wJ1FgUxclJbchk9xeItWHhrJVROfceNB1bJBX4Q87cwRFbw3NM8?=
 =?us-ascii?Q?QTGj/Q0iBGBnUK9cT3jOEkTPv2hS5PlUX9xHaXRkyv0XmbpWTQKgOmeqhSAO?=
 =?us-ascii?Q?n5fXfArmS1G3/YDmiQm0PsPdgSMRKAlcglv2SIaJh6ljKyZ3Q4LpD1zJcnXA?=
 =?us-ascii?Q?mxZmNlx25oKMSJLXRuC2BlrqCNUQeN9GoPVz0MsdZLG5WswByJyisrNCjwK4?=
 =?us-ascii?Q?DS02GOE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edbd6ceb-a1a2-4ea6-4b14-08def69c42c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 05:00:12.8738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7564

From: Aneesh Kumar K.V <aneesh.kumar@kernel.org> Sent: Friday, August 7, 20=
26 11:01 AM
>=20
> Jason Gunthorpe <jgg@ziepe.ca> writes:
>=20
> > On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> >
> >> > I was under the impression that there is a possibility of using swio=
tlb
> >> > instead of restricted-dma-pool with pKVM.
> >>
> >> Yes, that patch enables swiotlb as a possibility for protected guests
> >> but with your patch we avoid shrinking the swiotlb buffer even when
> >> restricted dma pools are being used and that's a waste of memory.
> >
> > I also thought we switched pkvm to use CC-like swiotlb as part of the
> > alignment in this rework? Mostafa ?
> >
> >> > If that is not the case, then we could change:
> >> >
> >> > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> >> >
> >> > to
> >> >
> >> > !is_realm_world() &&
> >>
> >> Perhaps, or you could just pass the swiotlb=3D option if the defaults =
don't
> >> work for you. Can you give more details about the slots exhaustion you=
're
> >> seeing under CCA?
> >
> > We see badness with swiotlb too, it basically doesn't work out of the
> > box if you have to use it 100% for real devices. It easily runs out
> > of memory.
> >
> > Auto tuning to higher levels makes sense to me, but I'd rather the
> > core code handled adjusting its size to the estimated need, not arch
> > code.
>=20
> Agreed

Nobody has mentioned it on this thread, but arch code under x86 has
a heuristic for sizing the swiotlb for SEV-SNP and TDX. The heuristic is 6%
of guest memory, with a max of 1 GiB. See mem_encrypt_setup_arch().
The heuristic originally went into the 5.11 kernel nearly 6 years ago for
the original SEV support and hasn't changed since. See commit
e998879d4fb79, which doesn't give much of an explanation. I don't
think this is necessarily a good heuristic -- it tends to waste a lot of
memory, but there are also a few cases where it isn't enough memory.
After a few years of experience with SEV and TDX, nobody seems to
have tried to come up with something better, so maybe it's not all that
bad.

No doubt the heuristic should move into common code so CCA, SEV,
and TDX all use the same one.

Michael
