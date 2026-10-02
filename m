Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE9486BA7;
	Fri,  2 Oct 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938911; cv=fail; b=kfozhMTeC0n/zxo4t0uhF51Mca+rtRv4fPyVtRWcAYmu+kdZnGRzb0REjPxoItoac0YIpRZlqwG77tR9mBaXzHgk3jsgb+sAYC6aM+1oxcSEDXIP7fDZPHttGgpCn275eKDV4Jez4JUdzaflMc9VTBd98C3HMHzG6i0gD3D89UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938911; c=relaxed/simple;
	bh=LmmI66uKukPOXCXZetQxEcVT/YNgbBNUDO56whAhdQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYcNuqIifctWVMZ1+FU0QynRpTMHS1tGxHDF/lIIKt7mP6sCbERCQMIjdNsxSS9T6mB08l2h+waP+tJ+oMjgLIJ8AeulPbgfmlT+GyhYc/jmSj4otMgOTe/3K3rMDtZmBFO9RiykP5y9bD4p/Yj+2Kv55Gg2mNHmEsmGU1KXXgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=UDstsHVJ; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="UDstsHVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHXKy+jcJeOdenYV0w4L2KPdi2qN1OsWTc6quwwUvUQRQALyi8gH98tL91bzrMVbqdF4U5E5sWyt3LwoNffE5vlHWnPhIxCn0XTvn8k0bkfD9by7EFZjXfSUF5fLyRoSkuBlhM3y+j9tnyqeQ5b8HYoU+fzVX+r7j7QB7uJrxFozzVQt0mWvYPjNu0q3HPPRAK/HhQEp92sAamEZKG7Myaai1JlEM3bU+abeu6kODBOI24jxzhjBDZbkJ8eKRp2YFhB76cch0ohS66PR+LqR7VpyyJ5Qc+PUPj/mgbFJqe/QgHf2Y83N+UlzE3EaCbTEJu1c7+RZ0p5BYRxT1FVkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmmI66uKukPOXCXZetQxEcVT/YNgbBNUDO56whAhdQY=;
 b=S+29zlzLKtVao12Hh2UEXh9LU0Ddv/BnpCXwRM/dBAjd68IyEZqvsk8ryEKqATk2k+iWVhuv1ng2gteoIjfol60IjaRqzn5aau+TesMi0N2IEIqZsiA+jG6XgP8GaBCfqE1Rch/ROWj/fXtzNxgD2TUGr1Gd34OxefEw7YziAqBnNOrdWwFEg1vrZxbwBAxhJ+BhCNkGxRPgNPaiuVTyAyhMAEgbWaIrmSPAJe11NU0dKEBBujNaQVNnj7XaIXw4DowDSgD06BbAdqYf7SNiM9IXvYp/2QXLzMf03Hv6EDqtY19XdYBmgig+OfXFWzeUkkDkvQAI6F90p3JTYQEdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmmI66uKukPOXCXZetQxEcVT/YNgbBNUDO56whAhdQY=;
 b=UDstsHVJlhvtQzVIrBT6dvcgxMRemtR1SNX4BSIMX9SfjsR0q0zknxnh28ATcrvwHytJg0W6Gn/iSwARNp4YtQi1k+DjJ5XZ4bAocb5N04u1qPE2aMPwZHR9es6/OU/AAVb9NibjgQdCHieZuwzkKyYojo2QkZI7BXl8MI0UsYlXvQWTqh/xMn0J61ac404i3vME5oZojx/rxTC1PdvbIMZSEm35qBPmK3sTH4xKzNpPoUmZyX30WFgNivm9rT/YnvM+rOJdLhgQdzQWRNU5H5Vnj845XN8xLFWYp73bO5UuYR93fYmaqZCX04S1yozzjvkFjm+kjBbHP4q50Ucn6w==
Received: from PA1PR07MB117361.eurprd07.prod.outlook.com
 (2603:10a6:102:54f::13) by DB9PR07MB9320.eurprd07.prod.outlook.com
 (2603:10a6:10:456::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:01:46 +0000
Received: from PA1PR07MB117361.eurprd07.prod.outlook.com
 ([fe80::1d89:eaf6:2e3:6d71]) by PA1PR07MB117361.eurprd07.prod.outlook.com
 ([fe80::1d89:eaf6:2e3:6d71%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:01:46 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Nathan Chancellor <nathan@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Thread-Topic: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Thread-Index: AQHdTTdfPnW7aHaOME+ati+VAetrsLbqHxgAgAAAdACAAADYgA==
Date: Fri, 2 Oct 2026 11:01:46 +0000
Message-ID: <b54cc713-9d48-46e0-b7ea-99f612d725a6@cs-soprasteria.com>
References:
 <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <179093852073.149722.832232613857480812.b4-ty@kernel.org>
 <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
In-Reply-To:
 <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR07MB117361:EE_|DB9PR07MB9320:EE_
x-ms-office365-filtering-correlation-id: edccf018-4b1c-4974-b675-08df20748cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|38070700021|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 YCZPEjgg+DUnOSmxwMDRgkPxiQViUVwqztF4KYpG4JMPvo14AO6aPvQZOxiie+erhAt0Kof5f7P7ko4aMooVFqah0Ql6l0Uin6usgY30oE+LMGAGP2602XMixcTYudjz31JXbE7qlRu7Ef/mtzsPNuGW8T4nfKw3b9xTvHGLx38EaJwE3in16pfDKwyPFdu17E8/WeglHY1n7VPnu9fZyw6LMn14auz6sFuCSvcJsLdArxdf2D4997qRDziKSYEY4B98OgnCNUH4SEe7L+n5XS7H0uBDLJqvwmWHAOIvCUwefyLc+sJKGCIZnWOgAwRU/M265bC4cv3jRfrGqAHiDlT9UnF5PeVXY79CUyKAe3zemV/bA2sd1uyEVkQlsYiFz0DBhpnPF1QAWTqIHXv6BwuwJV0jHGP3DzIvqizVqvtDB7fg2AcIgWvZ2DhXoIqosZqRNOEJ++6tnYJ/EkHyRz+cFFh5kKtFHVht42Yedjhg5/oj7BuJqUhc/HD3mKrz7A8SDkYbTCXOk4ayOnlEapwQRTmP5hrfJDn93MoSgyGBhJfYBzc5v2TNEYtnxVKwvamTjYa+A0JJPR2TdyE3gDSdfGQENHUcLd3nA/p+bgly0d/mre5x82BB1ZfZiXsAAbKRVnlEsAqQbtgmQkH3DBpgcYxn7b+rCO/mYnHD6J8fXKBdctEWC+lamm4az78iNDHnIKzHvZPHZTAyOtQ+vGWJmpzGFkRDmAKnRd5A914=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR07MB117361.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHNVRUp0Qy9xME5ldFl6QUpoUVhXT3hnVWFXb0VFdUtJT0Vkelk5azlkQ0RW?=
 =?utf-8?B?TFd6YUthS3BiNmJrMG1WRHRmVDdPdkxiT3QrT3VXcHVtTjYvSjVXSlpKbndF?=
 =?utf-8?B?eDcyVUYvVUxnVGZZTFFNVWpxM215K3d5NStyYmJIdDNLRWJzcVhaYXJTNERY?=
 =?utf-8?B?OXZmbmlqRFVqNjZ0ZnlkaC80ZTVDaUNMUkRKVTJueUoxVU9FY2wxZ3pxNk43?=
 =?utf-8?B?V3JaaUE2Z1lJSjlzczU2WWdUaDg4bHR5NWF2NVYwYU8xVDdIajh0NnpIT3dz?=
 =?utf-8?B?M2VKdGRLRFJjMzkxM2N6R0JjOS9DSHBkSG83MnBNbHNnTFZyc0RJay9lU1lZ?=
 =?utf-8?B?bVR1NFFvSWE5L0NwMjIxanVwcWM1TXdkckV6TFFFaHdOVnlUczNheFQ1bm5i?=
 =?utf-8?B?c3FMWER1cVgrVUVtcHVwWHZUeThxUFdvUklDeTgyckdONTAycUFFcE90dnRR?=
 =?utf-8?B?RFFraG5xeSsrd3ZkUmplaEowZWZ0bzk5NVV3bFo0NVp1KzU4VTB1MUJQaFJ0?=
 =?utf-8?B?ajUrSlhDUGlEV0RWTW5sZUtRRERSaHJmdk1OQWlhN2ZmOUpHanZKZFFrdG1L?=
 =?utf-8?B?TlRKVFh6VXFuZEFrM29JN0lDSzhpMlEzb0tjWnY0VldzT3BsVEt4cVRUT0sr?=
 =?utf-8?B?OVhaL0RwRE1IVnhITUF0QUE2d1VyOUg0Z1V5dDRXaDBvY0FoaDVORG9WcEpZ?=
 =?utf-8?B?NTkzMkhwQWNkc042UEtxUHU5ck9HRTB4b0NqTVhBUTVjRXdCazlNVHdMbjBO?=
 =?utf-8?B?VW9kY1pLWjVNcENXZnFmUVNZemtzczNqa01TbDg3cUREQ0RtV3JYMmJldC92?=
 =?utf-8?B?SWhzb3NZOFk5aXRhOStOUGhNNWgvSjk3Snh5Z2E4NVBhSVFrZGxVZ1JaZ1Ni?=
 =?utf-8?B?VG4zSndLWUFjQU5GVlkycjltdHluQThYZWVESS9yQ3dnT1hmRElKZDBXRWEx?=
 =?utf-8?B?YjkvZzM4Q1ByS0ZZVVVvd0MwRk5tOHJCZS8wYnVScVlmMzA3bXVKdGpmUytm?=
 =?utf-8?B?T3NvN3Ewckwzbm4rcUgyY0E4Q2ttQXV2cHVvTmF0UGNuMm42cm9YaFZnZzhs?=
 =?utf-8?B?ZldOT1Y2OGNjVlRQUjlMOU95alhKekZSR1JMb1ZZVWJKWU83alU1cG1aSDZD?=
 =?utf-8?B?Wm1GVmNTWlQ3M0h1MkZYelkzWnBpM1hmNk85NHNrcUpySHZRU0FDSm9RZitG?=
 =?utf-8?B?WkpGL21ES0tPRXd3MnNnZHZyNmRlUFY4NDhjUmtXRU1McG5FQ0lrU0Q2QjBK?=
 =?utf-8?B?d3NqeEhEYy9aRGJtWFhZN3BhSEtlMXNRZFJKQmRvMUh5Zk9oY2g2ci9pY29H?=
 =?utf-8?B?cmp5Z2g3bkhUL0lUSTRhZ0RWVlYySnJHZW80SDZtd2RSUE1IVktOQStkUHFD?=
 =?utf-8?B?dWJxWHQwZXIyMDM0TEluNURBZG9KdjQ4eGVKSTlIbkNmdjlFQ0FUb3lkYkRD?=
 =?utf-8?B?ODM0ODh0LzRZZlhvMFhFdVBKTENVcDVMRnBnU242NjEvbTFmV0xkMGhKY3FW?=
 =?utf-8?B?WjVLc2pYN1M2Y0I0a2YzcUZmV3p6TDBMVnF4ek5LeFlveXlyZXdWQkFnOW84?=
 =?utf-8?B?bm5OQUo3Q3Yzc05aYndMQk5veDF5eVRqRU5FWGMxNzF2L25nYUg2VjQrMnFn?=
 =?utf-8?B?bzBoZSs1dmtSQ0RQcjRkTW15bXlScDd5UTBsc3pRMGJONFR2OS85QTFmWnY1?=
 =?utf-8?B?d0NOZWpBTm96N2VXMjlWekprU1RGREhRM3ZIMzhvZ3dqeVFRZnZveFV6REFY?=
 =?utf-8?B?WHdGejF2WnpQUlYwRWxZRVJiSFcvYnRpYzhCSytDdFJxMXhwNHdCWG81dXBa?=
 =?utf-8?B?a0V6b0lKbTh4R1N0dlRZM3ZGSDdTWU81TkhacysrWTdOWDNzNFEwdHBiM3RD?=
 =?utf-8?B?UWRhVTBFT1pBTklxT0V6L3p6NU5aTU9MVWdmTG50TG9udk5jcU9samZ3N04x?=
 =?utf-8?B?QkFoeUliM21zUGJkQ3IrcGVYVzRRYlNZZDErM0xEckJBd3B5ZC9ZWHh3WU14?=
 =?utf-8?B?dXpxK2lyc2UrVzNzYmxBZWJYTEs0c0FLQWVQK3pTclNMRUNNcW5DTldYVzZ4?=
 =?utf-8?B?eDFkNVpReDZTV2lseFdZbE1HNnloZ0JPUFJjMGpNQ3RHVmVIRmJqUjZYSjRK?=
 =?utf-8?B?SFlTdEkrYzZObkJxenNkTTVaRUtvbWVuVlNDai9xZXZBdklwbWhOMkNhbjRa?=
 =?utf-8?B?Q0Q0S05Qck5wZDB4WGU2aFFwUElCUk42ekllOXFTaGo3RmJvRjB1MG84QThs?=
 =?utf-8?B?V283azBkSkpnNS9hV3NoRWdibi93NllFWGxXNjVndEl5eHl0RXBMOW90N1BK?=
 =?utf-8?B?emFtQ0ovZVE4UzJROUQvSVdRbk53aXQrbUN2KzFoaDZ5S0NPQzRPNGx3bjVI?=
 =?utf-8?Q?HGv3RlT9GJh0cGhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9738DA7486A724BB0C8DE445E360F4F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR07MB117361.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edccf018-4b1c-4974-b675-08df20748cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 11:01:46.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Yyv5+mv7hbEsb/NVpKRCTG4neM6AhAOsF8/5QmQRTpYeW2CBo8Q8LGC+/Zo/m4A4ZL5efhNyQan1Tq4kStvmtcNQan/hqQ6D9kzG9VVnhcOWk5qtlrmh0k+UqEo6Fx7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9320
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: PA1PR07MB117361.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DB9PR07MB9320.eurprd07.prod.outlook.com

DQoNCkxlIDAyLzEwLzIwMjYgw6AgMTI6NTgsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiBGcmksIE9jdCAyLCAyMDI2IGF0IDEyOjU34oCvUE0gQ2hyaXN0b3BoZSBMZXJveSAo
Q1MgR1JPVVApDQo+IDxjaGxlcm95QGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiBG
cmksIDI1IFNlcCAyMDI2IDIyOjQ2OjMyICswMTAwLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToN
Cj4+PiBBZnRlciBhIHJlY2VudCBjaGFuZ2UgaW4gTExWTSBbMV0sIGJ1aWxkcyB3aXRoIHRoZSBy
YW5kb20gdkRTTw0KPj4+IGltcGxlbWVudGF0aW9uLCBzdWNoIGFzIFBvd2VyUEMgYW5kIFJJU0Mt
ViwgZmFpbCB3aGVuIGNoZWNraW5nIHRoZSB2RFNPOg0KPj4+DQo+Pj4gICAgYXJjaC9wb3dlcnBj
L2tlcm5lbC92ZHNvL3Zkc28zMi5zby5kYmc6IGR5bmFtaWMgcmVsb2NhdGlvbnMgYXJlIG5vdCBz
dXBwb3J0ZWQNCj4+PiAgICBhcmNoL3Jpc2N2L2tlcm5lbC92ZHNvL3Zkc28uc28uZGJnOiBkeW5h
bWljIHJlbG9jYXRpb25zIGFyZSBub3Qgc3VwcG9ydGVkDQo+Pj4NCj4+PiBtZW1zZXQoKSBpcyBu
b3cgZ2VuZXJhdGVkIHdoZW4gemVyb2luZyBwYXJhbXMtPnJlc2VydmVkIGZvciBzb21lIGJ1aWxk
cw0KPj4+IGJlY2F1c2UgTExWTSBoYXMgYW4gb3B0aW1pemF0aW9uIChub3cgcnVuIGluIG1vcmUg
aW5zdGFuY2VzKSB0aGF0IGNhbg0KPj4+IHJlY29nbml6ZSBhdCBjb21waWxlIHRpbWUgd2hlbiBp
dCBpcyBhc3NpZ25pbmcgYSBzdGF0aWMgdmFsdWUgdG8gYQ0KPj4+IGNvbnRpZ3VvdXMgYXJlYSBv
ZiBtZW1vcnkgYW5kIHR1cm4gdGhhdCBpbnRvIGEgY2FsbCB0byBtZW1zZXQoKS4gQm90aA0KPj4+
IGNsYW5nIGFuZCBHQ0MgYXNzdW1lIG1lbXNldCgpIGlzIGFsd2F5cyBhdmFpbGFibGUgWzJdLg0K
Pj4+DQo+Pj4gWy4uLl0NCj4+DQo+PiBBcHBsaWVkLCB0aGFua3MhDQo+Pg0KPj4gWzEvMV0gcmFu
ZG9tOiB2RFNPOiBBdm9pZCBjYWxsIHRvIG1lbXNldCgpIHdoZW4gemVyb2luZyByZXNlcnZlZCBp
biBfX2N2ZHNvX2dldHJhbmRvbV9kYXRhKCkNCj4+ICAgICAgICAobm8gY29tbWl0IGluZm8pDQo+
IA0KPiBUaGF0J3Mgbm90IGZvciB5b3UgdG8gYXBwbHkuIEknbSBzZW5kaW5nIHRoaXMgdGhyb3Vn
aCBteSByYW5kb20gdHJlZSwNCj4gYWxvbmcgd2l0aCBhIGhhbmRmdWwgb2Ygb3RoZXIgdGhpbmdz
IEkgbmVlZCB0byBmaXguIEJ1dCBJIHdhbnRlZCB0bw0KPiBsZXQgdGhpcyBjb29rIGEgYml0IG1v
cmUuIEkgY2FuIGFkZCB5b3VyIHJldmlld2VkLWJ5IGxpbmUsIHRob3VnaC4NCg0KU29ycnkgSSBt
ZXNzZWQgdXAgd2l0aCAnYjQgdHknLCBJIGRvIG5vdCBpbnRlbnQgdG8gdGFrZSB0aGlzIHBhdGNo
IGluIG15IA0KdHJlZS4NCg==
