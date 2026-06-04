Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010005.outbound.protection.outlook.com [52.103.12.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71647CC67;
	Thu,  4 Jun 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581940; cv=fail; b=psmUGFAoogOsGuDNQ0cdKPey6s9AWRWnHJP7yi4+HplhQibj0DvkUDTmEaFaS0Qn0ntcrSi7UOAvb8O0UtyQBjhmlQKWyvdVMv69b1b3ZQZXcib4/YG0cnGY1V7pOnG8xr6A5Fk/vIUELZi/NYChw8Qg8XWUHi26yqOAaCP1uqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581940; c=relaxed/simple;
	bh=kGWl6fCA4AHAL0LsLihOcZq05hBc6DPkoeLepYn/pIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iYfQBZdbDlmEInqdt3GElNVQG1/o5Cft77bKKYnVR3TQhgWbumRx2n4x26qGN39affXl6xru8niUQLnJVeV6UqSNrbslFnq5MjASXYkwvU/hyWGGz5ao4XkFWt6EaiyfDElb4miUufe1EBnJw3Dodgudh0EXIjQFj2ICtVs2jWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=L86aRKID; arc=fail smtp.client-ip=52.103.12.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="L86aRKID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDQ89w4LCf9gb2RE9/uaK1aCA+Y/r/dBD3Rx52Spjbzf3DD3V5Fvzt9hmtOdTcl/XqzS+nwWleTgqdDdbZ6cSWxYUb0/Mn9b+ymsA6vxA/iFzYzTjkjWNPrCujbLyCTRUEQ8e3W1Tc3xyb3+K/f7MJuAfDajjjf0wZYLgZgtvt2PMLYn9HGczn9BPF8PJBbzCrD3sZ6iRu0PJ5wIK4WWB5t+rHgcA0JIr7nwnaJcmUC+czPdvY06djkyK7a3EAZdkw6blFC2dE5cO0oXXe8SV6guuZdO7FPeW5dKZ8PDLfP4rRiaivVOTyIKq7EtqaN6hE7jNPbmwhyALqp9226Zng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okbux3rK3OQBwN7csm0ykJnyvdY5GBjq7dyp5u3qLSU=;
 b=wceT+b9O2Rff5+YTLT9xcm4NH27/0gL0IrTqRTb/r9hCM4uvRRWGgTHUSa3EcVTbRlHpiqEBGv8G25Sh6dUp3DcIf17kTpdPKOTd7qVOA7q4QyTHoJauMc92v7M4TFI8nm2/y1OYTix3FhW2anjhigs3teNIZAk0r5SuOBn59DCcQq+9M+5q/PRv2JBVKqinoRFaJ0ls5cAi1/1E+VopVIdg1I7fp9BhyTMTH3S06ZQTJVxZhayZkVVR4VIwLzvVN6psNv0ZlCCRfR31lJyHYWp5VmxfVfORvC433G3L0jF4Sqhq6Uo/MHSFUjdA99knKLfVSIG0omWwifle48CBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okbux3rK3OQBwN7csm0ykJnyvdY5GBjq7dyp5u3qLSU=;
 b=L86aRKIDl/GqhSiANwPEpTn/kq60112lJpLH72LN6og4CookMCICkWcbJMXJGD8nat7lB7C5Z6DL1at1Ku3BS6+cirtWYwskQTih2QMa6utdgq8iof16ROKDlsVnbNSWefvoTwwUaAg0D1WCEGLFqw04/Ojs1BCpP83r8H0TGYXNlYKI7re8a+MZlxAJk+KB2ehWpepcpqyuJILkt9taBKf4QzN8WrOaaMk8U4qLb+wCRMrZXwSjiIHH+jS71iF1+BQH9rdiw7eNZdmdyVa75/9uHqFv4+u9JeGvQnWOox52F2oX3l95vN+O8MGGsGwvFd5wx/nOb91WdPNOXgm7bg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB9472.namprd02.prod.outlook.com (2603:10b6:930:71::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:05:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 14:05:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Michael Kelley <mhklinux@outlook.com>
CC: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
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
 AQHp6tfu5DGfxW+HBL9src0vNhss0QGjMATQtfypCTCABxNTgIAAi4fggACwGwCAAm86IA==
Date: Thu, 4 Jun 2026 14:05:35 +0000
Message-ID:
 <SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260603005454.GM2487554@ziepe.ca>
In-Reply-To: <20260603005454.GM2487554@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB9472:EE_
x-ms-office365-filtering-correlation-id: 810ce470-eb1e-4737-c3a6-08dec2425917
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15080799012|51005399006|19101099003|37011999003|8062599012|8060799015|13091999003|19110799012|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZGiFGkDWj57FMu840f0H846SezVXn+GpCaAcQX28p402GZ1NqeTE2X8xqfCD?=
 =?us-ascii?Q?Vjzws5JdRx4kCXZgZjWbujfG3uzVTFgfW5xD8V9MmEJyniAWFLwSamdaWQts?=
 =?us-ascii?Q?3DEHlqEMq209cNN2J4IxJr+0c1fR9hsa956LYlDWoBl6QidDJ1y7+TutmpRh?=
 =?us-ascii?Q?j60SOpmnXrhgJ9G23Ot4JpfEaQFDj7iJJa6qApyW5bG7NUol+sbpDOqvpUAO?=
 =?us-ascii?Q?VSeDJIx5ziGFDnGdcjgqlo0Zc1295EbUp3iuYfcDg4saScrsJVoCz4pEXfnz?=
 =?us-ascii?Q?ZTVFOOEFGWuZTwehCOaMx4aWHi1eDQUqhRv5R7FiR6LraMpFaSs+o+xQAud5?=
 =?us-ascii?Q?FIxI/J1s+j0l4naXGh4jjuGBOqEgS9abvKotkrmCl+2qlVR9aePfmi2rswzx?=
 =?us-ascii?Q?FFF/ehW709u4/Ed1MYkFCWDUEzTnbqA7nUJTxc5NmlBNwVRun3GOuqzRXvJ9?=
 =?us-ascii?Q?AIgyoAsey91PircZacYLCkxtLN01Q4LEsRwUiXIEXHb5dw7nq+QXc4IIhTpe?=
 =?us-ascii?Q?W4s67rgRuhqu8KJ6XvZJgYtfrV6iSPUwTJ7+wOJjtzTYRA3AYdrtoUMjNoZj?=
 =?us-ascii?Q?BsTyXOIJhnjaop57DARK/MeLBxfNc1rlvkjB8W/56a7pntll+s5IRALJmnAv?=
 =?us-ascii?Q?7+SYV27Dq4UW4Lq9KMD5gXcRSGQgc7o3FFD41knXbnhJ3i0Msz6zH5tWt+4N?=
 =?us-ascii?Q?e91Ym3kRv9Lcb/lD3zZwKWi8XqR2469jbVwmRrMnN/XhlwLkjX8MfXOKnvoY?=
 =?us-ascii?Q?nN03fTXMxiwCM9FMm2gRM4tjdBN/ubV33M+9YEHDxbExPgJhqqdNSQOpGc/f?=
 =?us-ascii?Q?8rPyeVZTkQ5hpnHUUT5GXY6dmKxtmAv120uYiluFpN01p/x8/Ltiha40ovHj?=
 =?us-ascii?Q?lRWl4O1zyNLT9QvDX0QPqvzKMhGCdeVwv3AG04xBsNzPttbVmVXdMzV5HhkZ?=
 =?us-ascii?Q?YFqvkTUj/OSnNAtbyw1OW5f6C4Gs7QjWRYlxviLk0EGH8hTR5EwUvMia5lw1?=
 =?us-ascii?Q?xCrD1dPHp87XDmPUmX2zP1cSZg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4EQy7lXQJNTfflP5XZ6fJxaOvf5bceIEuVrTyqs154+D5BBEfCoT8iboUyhZ?=
 =?us-ascii?Q?9ZW3UkaPQ3ViHQMZWyc8acylTi4AHTW+Ouu6Qm2lZBdB9jo8XOUZlzQ8yWhM?=
 =?us-ascii?Q?BK35QscyWnSwUoQXCt+9IhB/9iJEl0zw6xTUfVi14hVgbCuKcygctOCJgPa5?=
 =?us-ascii?Q?XbdnDDfwPtZf8FifrVhyJEHt7vBmX62csWe4yusaAyGdC1FjHReX/g9+MuR4?=
 =?us-ascii?Q?t4LbN2TiEFdjZKTIJrOkhE9fegXEcDMn0JdfEjqOX+3OncNvs97qQD+7i8eq?=
 =?us-ascii?Q?bmzpT90bSwtwmGblI51YfKeR1Ad9AC2lgu/ugfc0+B6Fk2y0Vown065AfVBD?=
 =?us-ascii?Q?4yzAgSs5d8P72UAUjyox8b4EBYp0iVff0sNem1esBdT3vfib9Gq/MAWErsdb?=
 =?us-ascii?Q?b/6JjalfT6x+HUv9YGEwC4y6GS3JUgaZYbSaH2UIioR+Q6EXrwBhecCGrR9C?=
 =?us-ascii?Q?bsCUm0+9h8pRnNRf1awG5vBYHCm85NjXD1MQicwLoma7obmvvt7ka3fF3Ctw?=
 =?us-ascii?Q?4okBcZFkBZSmJMluoSZ8I4yrNplgIt1OE2USMugTMV9Jx8xjQ9htD0O1ag7e?=
 =?us-ascii?Q?y+FZyfW2vnO4EaleyVdcMgKEt4KGBbsvEzp28TgdvgG1uDDSmQsLHgDZr7dg?=
 =?us-ascii?Q?kppPKdTNsd+lCOrurbVCLo/8mOSdEleG5Wv4FurLTT37fG/7XZ6DLLg4BCuL?=
 =?us-ascii?Q?JkrNc6T7l9AO84vcPUHcxc1GQ6vhUO4iRRDRQiR74dLLELpJOTxHVtMIr4up?=
 =?us-ascii?Q?l/B2VkqKvkoa3xL4HHA+7cejQC8ggvfIKqdqSFg7PTAFR1ecUodWszbjdYl0?=
 =?us-ascii?Q?V2HEN8sNYIMPuXoYrWvd/YK7vS+sfQERSdYExEzSkzLJbPCkypU44BqBkIsJ?=
 =?us-ascii?Q?eXEQouvYd9iFQZyOzW6bI460VTTXe5rbnqd+VBVKrTl6zujZ9kXPKVX8vGUY?=
 =?us-ascii?Q?6xPlqIda6rCIyBAviXizNMItP+JCUh/vN+W1MhYghwlrQSN394NvTvvqCr6D?=
 =?us-ascii?Q?vwLdQvtcBQCIXJPuFhDRRj6dtJfE+e334HzoUwCPnvRLhh7Pk3tP2Fpu72Yv?=
 =?us-ascii?Q?QH1IbBWb4FCkavtRSmVBKjIzN+djCmVik/i5sWkgKhL6PtamlwKeV/++ng8R?=
 =?us-ascii?Q?mhMJbi690eWwXrEhwXFvcsnE8vHy4UH4jJa7c12RVAkLrdWT7Ia9WHQt8FoJ?=
 =?us-ascii?Q?+wGzkVp+rrfx4AT3bpFy6mBNej46AoW06AIjnCp339695tgDJ3OmteDXy9zk?=
 =?us-ascii?Q?YrvxGh6qRzwOLqTZr4bk9ritF4oI5nKWW4LawTYDCp6I9K98prkGjRc3g/cX?=
 =?us-ascii?Q?EyUvw8ys3qwTW+5LhhYA/+DCZaLN8Djy1p0JJ9ViuFiO7tivY8rTWBvODOGE?=
 =?us-ascii?Q?+WHvfURyuqaLPcLj+CdjlmGOaBoNJZibkuG5AvZM4dNwaN+8nBrGHRsqwfmS?=
 =?us-ascii?Q?udkSVKblSAk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 810ce470-eb1e-4737-c3a6-08dec2425917
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 14:05:35.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9472

From: Jason Gunthorpe <jgg@ziepe.ca> Sent: Tuesday, June 2, 2026 5:55 PM
>=20
> On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:
>=20
> > Except that in a normal VM, the "unencrypted" pool attribute does *not*
> > describe the state of the memory itself.  In a normal VM, the memory is
> > unencrypted, but the "unencrypted" pool attribute is false. That
> > contradiction is the essence of my concern.
>=20
> I would argue no..
>=20
> When CC is enabled the default state of memory in a Linux environment
> is "encrypted". You have to take a special action to "decrypt" it.
>=20
> Thus the default state of memory in a non-CC environment is also
> paradoxically "encrypted" too.=20

The need to have such an unnatural premise is usually an indication
of a conceptual problem with the overall model, or perhaps just a
terminology problem.=20

Here's a proposal. The new DMA attribute is DMA_ATTR_CC_SHARED.
Name the pool attribute "cc_shared" instead of "unencrypted". Having
"cc_shared" set to false in a normal VM doesn't lead to the non-sensical
situation of claiming that a normal VM is encrypted. The boolean
"unencrypted" parameter that has been added to various calls also
becomes "cc_shared".  If "CC_SHARED" is a suitable name for the DMA
attribute, it ought to be suitable as the pool attribute. And everything
matches as well.

Michael =20


> "decryption" is impossible.
>=20
> Therefore the "unencrypted" state is a special state that only memory
> inside a CC VM can have. A normal VM can never have "unencrypted"
> memory at all, so having it be false in the pool is accurate as far as
> the APIs go.
>=20
> un-encrypted =3D true means "the memory in this pool was transformed with
> set_memory_decrypted()" - which is impossible on a normal VM.
>=20
> Jason

