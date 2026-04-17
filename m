Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010016.outbound.protection.outlook.com [52.103.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A222F01;
	Fri, 17 Apr 2026 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404702; cv=fail; b=LSNKK8Xyy30wdmI7rElGtKdefQ4qd3to2Qev3bhO9ZnN/6L5otZXQGNr+NxaEuUy3Q49FyBnbvA7eB4i0zoVzJYMBTuixXWynJZ1OYJanU04g6IPdHTlrr9C9GWNxENF0n9tu4PYm096Y+RgW2ahNHUPOmEmMrtgk2Mkgs4hG9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404702; c=relaxed/simple;
	bh=wJaOlaJj53ZgGQVOaSQrsfwwTgmMJiZ9yjDxghuVj4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2vFhf4qKhuKckiVIInN482bE7HDjGNCuNT9cnNs7K5RzKcZ6OlODmFm6tkV6IIhH3V4N+bXjRwJcq7VW8fRU9wT8NMCEUugjWdWL/SAu77Zzrxxa82+gh9QGMxl5Ykt4A6viTnTkvc0A/CYix2GBTofWQTNn6Z+amvSIAChA60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fpjndqOH; arc=fail smtp.client-ip=52.103.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fpjndqOH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUzj595+8i48x8QnSFNSc6qZj69/8WvriXWSdU7VCvLIBiaQuSoTIc3DZbWeVcwq40NcwZJ/BcnYE0DN8OlfRsib+g1tEPlfRv+vMIWzOUxhRgC0N4eH5ySjzQACEmkFVME7svmZuKQbAR7HL6y529nXqpal99vyFk+5zjP7KGF0eAdjVUHU7Oxs45eSfpHtvvC9gu8O9suzknX/ICoRXstzwEMo6s5Kv+H+7OSH6rr9zzzVuiPqhHRwSWsdXkvdfM9dIMDBHO28TWOaRCEAXGMDFZBxvMYu6SVAVUJbxmjVG7pRajXG924cIOBhq/1KBIWl53o2mJh/f75CzCKF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJaOlaJj53ZgGQVOaSQrsfwwTgmMJiZ9yjDxghuVj4k=;
 b=lTPar8cJ9XcsxoK8hQByOQpfUxGiiINJOIWWrFxvUsszhyd1h8QQ1IXgY3GHQbZLetmJxXQS/3d8nYLYoaMQrWw9lutbZz+0YztZpNTuJNwBbaVmBd+j4VGKmp+1uAfvYM72j2BMkEQBAdYQ2YdkU60sP4sVI7Wn7muX4ES6TsnEblOteYEqITEjiaSJCkEhKdos0CZ3oxmZOloxldwwBYn0wVCxRhTnM+p6z6poRrXFu1jXu7wAcBsGNivM/JyoumiXqkoXVy7pmVkxUbG25E4FQfQ0NbVc/44jQvnDj5mrZepaTFrWuC2g1nlbH3A3yyd637AKUKiHdtRV5qv45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJaOlaJj53ZgGQVOaSQrsfwwTgmMJiZ9yjDxghuVj4k=;
 b=fpjndqOHLnUNP97iXhw748TKqcxrRvvJJVK34/TtF4nQ9NMvs81MqnJhk4m6PMXPs5npOUVfC1bBcttPsOLk+lVxWqNOyif1e5lJ+yNo33wPOzPXlKTKlCr7PKxEu6Z2mWMEW0TCTr0uEU+eoHFfjjqIJcmHGFHRWi3njjnS1IB1nMKR4HurIFR4FICOevjnV2iU12pmu0uRBD4N/+VsVHBm4FdSIh/inkulHXreCMLnDy1tYH+Rccz509fNfLCEoPY6/83WR+y8uZCjVwb1LtqzOL+uZs7DDK7VVw8VgQaRw0BWNpB7fPGwfBIIKDH2fhV0I/lPwW1LW+raG8CveA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYZPR01MB7826.ausprd01.prod.outlook.com (2603:10c6:10:176::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 05:44:55 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 05:44:55 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>
CC: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Farhan
 Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] KVM: s390: pci: fix GAIT table indexing due to
 double-scaling pointer arithmetic
Thread-Topic: [PATCH] KVM: s390: pci: fix GAIT table indexing due to
 double-scaling pointer arithmetic
Thread-Index: AQHczLo0DLf/mBenZ0y9H6NwINzCurXhqlkAgABvhACAAKaAAA==
Date: Fri, 17 Apr 2026 05:44:55 +0000
Message-ID: <DFE3F654-DC1D-4D0D-9665-16A06038275F@outlook.com>
References:
 <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <b1f22f3a-398e-4ce6-8092-aff9c9aaaf9f@linux.ibm.com>
 <f029675e-7b96-4d51-bd79-595e322eb135@linux.ibm.com>
In-Reply-To: <f029675e-7b96-4d51-bd79-595e322eb135@linux.ibm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|SYZPR01MB7826:EE_
x-ms-office365-filtering-correlation-id: 230517ba-7d3c-4f7c-c662-08de9c447424
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|8062599012|51005399006|19110799012|12121999013|8060799015|15080799012|22091999003|24121999003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eb0tJYwe/QGeI7YT+7oX5gKm29qzFC/2AIuLcSaGy/U1Q7KFo7c2amXzzhDE?=
 =?us-ascii?Q?ANIhJUkz7qSQwdDcu4OKTlSEiuXpuvtq7/apZiAnE0gsNrSf0UtDxwETd5eL?=
 =?us-ascii?Q?seem6cQrCl4zphNdk7ODzSaBfl02am3QA6kIjAEAI0VInBxrXZmVdEGnWwHa?=
 =?us-ascii?Q?5jGQJUi+2qoq5ME5p/0GEgtjErOMfqKpoueZmNMHsMcQ9VcSLJMYqJxD9BTS?=
 =?us-ascii?Q?BFsGymCkkZjtlH4dpwleK1jaX/n8PdJkjs91IqPT52T0R7JVcvIMNsDVuVz5?=
 =?us-ascii?Q?6/jVmqMUzPhKBSpz95wz6Wg30gCph32gJUpGz21WfyqaKd9LM26TFMo+up7S?=
 =?us-ascii?Q?3UdN/XMrOGWsTOOj6bdqJNAzJ5QmEMV05caM5VQfGQj67cub2E/Y4psDKBvH?=
 =?us-ascii?Q?pYqPPhXznmcLKR5FVYIpbFxZolsNJb79RS7iSJi1TNGbcR3sLESA7p9BS05K?=
 =?us-ascii?Q?ra0NmR42v80Lzn7pzHM8sri0gen2+93FpTSbQrCHo2zCsvgJzBEM+YAIcFfJ?=
 =?us-ascii?Q?TdQ3qgdhMbEG8bWQI1keBkWnNl6/1TPawnRpVktxTRKoiHoWrQibHOPxODdf?=
 =?us-ascii?Q?PEb2VCn2Yo4aS68cZwP/yoOE11+13mNrX8vvqNssqtB9byajNIAi1yV/2t8r?=
 =?us-ascii?Q?Yhx/wRNCZfPCFxzt+A3HmekPgBY5uxA1dnsy5Ec9EpnZnY9wvNGc7/XlOpNA?=
 =?us-ascii?Q?iixrIsjPovZI/NT5wJEnNQrtLstbEquBXETrbVTCdncpdc4Mzi6bGHUW87Gm?=
 =?us-ascii?Q?p2EL6KAmzUQWF9UupVkKCRhWIR2LiKBCG7rycBn6ONcKH7kpagxD7oMnRlbC?=
 =?us-ascii?Q?Y6tHgt2ka8btIwMZd88bYbroJSng3f/ueJQJnFq45/URFibeeoVaW4PPN/91?=
 =?us-ascii?Q?1HD98XcaLpagoaPDryNyrQoaUpiMl2O71zyWIPafx+35doqTTivJNimnWg2p?=
 =?us-ascii?Q?zyDOnUycY+dUzBmolAPJv2HyFIz2BppYBeWx5Jp5/TNuQDLf4wQTuLfkaLhA?=
 =?us-ascii?Q?TRcK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vtpae4nuDG9k4UvwJMyjfw0jov1/+6r59KNU7Y+taBEU3ShT0zhqesbfaXIe?=
 =?us-ascii?Q?2rn6lMCffvkC6ab90YuZWmIW9ZNIBO3pgFCgMyxx9+elohzPd+1bNyom7xqZ?=
 =?us-ascii?Q?EmqKtQRQOhBYWMI7oNlmim+w6aA4WLZinmsh86jWOgPeGYvUf8OYUVLovlYn?=
 =?us-ascii?Q?GmN3xcbQCr20QzOnUpqIOkpwS0+dlEteprzqRbc2SQaa/F160XRcdYHCyWOm?=
 =?us-ascii?Q?YPpWRLady6P/3yYgDxbD1lY/61Ktbqs2RQmh/aMkGlW5xR5qsWkuKvkppwXI?=
 =?us-ascii?Q?Ko/Zn2fZqyep4O2RckcnBY7xvixHwUuL7SgGExM8GG4uvh36ix20uDzSKcug?=
 =?us-ascii?Q?fXKvrcSntHOEqPvaIcj6vnmiwLjqRL6FfUFMa9hBfZt0n4p2R5d9DNhSBURj?=
 =?us-ascii?Q?w2bOZ+PpjRBIeLnXK3R2ES8B0Snw3JJ+tx3Pc7JaQkxHYpyKYtNjbIFgxk0F?=
 =?us-ascii?Q?bBc+f8Bo2VidUC3OMwKKOSpWIOepRw3krEE4yyo6E4kL29jqYHq3GQKwB39o?=
 =?us-ascii?Q?t+jDm2T0HvkCjNDgZYCEJqVjBZNqAPn/2e//4P+B77EYldVU+Bkw0nyL6BEy?=
 =?us-ascii?Q?LToEk11iYE1u4N+ERMZKYQVs7rsRGvuX68g76UKHDJGdDN3LGMdrP1xwsJVX?=
 =?us-ascii?Q?5/+pda4ivZioPxcPZ8FeQFqfXbVMv5r8x9ApvWxvMiTV6SVO4Yo+Rx3TsJ0l?=
 =?us-ascii?Q?GckiAZ8Wep6obxegj2T/WSDVk4T05ZzeMnE2cNAFGT9aIVDzsJZtuzmUXRld?=
 =?us-ascii?Q?oydTcleMwU3Ni9Tlg0bfShSKog118J0crbZZANrxrjlU9yqVPworyZcnK8Yv?=
 =?us-ascii?Q?CoH8roLttGrmACgQqqA8henmz8j76Sif5mmgiMaLVELHz9mUIwezDlcvUF6E?=
 =?us-ascii?Q?pLbvVyF4n5TMreisv3PvDy3IPj64XM60GZc5LpAQWnzzKjhdy81NrnZjxPiN?=
 =?us-ascii?Q?/WGVVGx1/2P/IuiIjjMX5m8umOuG/SXCWPKLb3HhaBKH+2v2Vg42A3YfnzR/?=
 =?us-ascii?Q?5GMMrikYpXfzoyLOokSKPl0Bs5T48t42MIk/sb5i1mp1IC1mXimoCajZMYJx?=
 =?us-ascii?Q?+cTUZ9wl8FVY26ISqZi0PwZMoz4Fkc2UwYqgjXTUXf+nSsIJH56R9inJFOcO?=
 =?us-ascii?Q?hnIL3JOK9JmWEJdJW91NNd9ATkC0wgoxEYd1xnm4Z/YSnPh33BDmAIgdTXmz?=
 =?us-ascii?Q?488mXvY+NRKMmsEsblPbbEvggW4SzIDlhQfgKvEuvc1SMb6onYjzfgO5GX7A?=
 =?us-ascii?Q?dmpMuQRg7GQXTYP6jqXdkXIRgiynLKgPsG+QZQzKPsmY2Rc0oAufw6gJAB5m?=
 =?us-ascii?Q?cFsHwJ4JAYXGzPXfae1RZz4rIKTpWs184MZIG0dFTM7txZahUjH55y1cZ5P+?=
 =?us-ascii?Q?FkDwZcNf3Hyj7ZVQ54S8uKXEgtJv+BdGqqdjibnEx7yiWTXqrw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E385B3B6418334B8B8FBD22ADB560E3@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 230517ba-7d3c-4f7c-c662-08de9c447424
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 05:44:55.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZPR01MB7826

Hi Christian, Matthew,

Thanks for the review and testing.

On Thu, Apr 16, 2026 at 03:06:56PM +0200, Christian Borntraeger wrote:
> Out of interest, was this found by static code checking or AI by any chan=
ce?

Yes, it was found with the help of an LLM, and we verified the issue
manually.

Thanks,
Junrui Luo=
