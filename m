Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3613655EE;
	Tue, 12 May 2026 23:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628844; cv=fail; b=QJA7HOmwIe80ox/BhjOw9iL+v2g3w+cAs2UG8Xr+IL8640Ipe+qX8XDas+L00Zfjj3P7jvCGEpTfRIwqjrO7BW/Jfz9JC4VJW/QD+NRbpX9fvUjGrwi3dMVniTcIRcKqdN4H3C99d0UEDaswgd2IyvxiZ+x5uhxpn0/i9qOTe9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628844; c=relaxed/simple;
	bh=euPMJhiNMvqyqAKdn+7k1mF8kADoqbI89kFx+NQycRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVqJhJpfrCRol1LItDPMt02OGiceuAgxlWl/3+lcsDjmnZ2ep3qZGwOFb4YLV6IfC2kD67UATHzVizSePG27/JeHPnoflfRHcYsXzxH96lJI0KJY62tff+pK0ENj8EluLfjt1YKlVpMZsgzKaaLeOnbwBO/Dmdy3dFaCH+Qqm1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oRm0uUkU; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oRm0uUkU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwsdeK97FGx4XUGnq7gWQhmzXU8AnyhJaTQlEgjsUsTrE8gr8Yp7HR4wvYPDkTiSaOz0w2pLwGmog8OCg8QJg8u0GMdb/417+7NuHvtEMJAMyMQ2OYqsGbmqKUkPdizX3brSBnSiHptdjIhBaXsWwqoASt519LWAuph5ghgNXkXWuFZAQDXwSr39OtrjZO3xeuMS7cBBh0Ogav28jIMOrOuCz6tUqlj1YBpzkocO2ZGPdDyXnEdnaKgv78MrRB1HJWcAxdMNCQzYRs2kBQodbvk5cYQqm/fcjgo9YQ4uxOFohLzT4z9kosoewvQyLUFtAgpgvP02c8HyvLqaUUow7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euPMJhiNMvqyqAKdn+7k1mF8kADoqbI89kFx+NQycRw=;
 b=H3ATrJ0+UZAuBTsGKsjpcwkYGfjE/BQbH0zF8ONFBQo9OQQYu7w5i/ExH9SkDH4LNkAuFWYiyVg7TeGhAYtg2FLFuCYhcAR54zQx+fj/124XR+YL43565VGHPrgtWekbxpxDDH4dXr46m0nFBHQRVEm/vhPpFncTf9IaAvEavkshZy6UAgZoe6YjTuDx4JY5RnQpb2oOgjovgU3bN668E6LVRffRb5x52ndiF/DIrcPMYf1Z+/kwhu6CQ3iTsB3dhdse2cEqe5RH8eZre4JttHed9vA009TjFbvNaowxz+VoVZNyNOxMXpj+YBaA8IkBLzXaw7FtSofFWNjqDetWPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euPMJhiNMvqyqAKdn+7k1mF8kADoqbI89kFx+NQycRw=;
 b=oRm0uUkUiuVUgse60AtCQl0ZOsA/oKd2LOK3BBr2oxvB3JR1yK0RuJyhwr6aDXox9fHE/LNpBeqtIKhf17vtC0bZHIZVSYLtCjmzSVhb4u8ReV6Xiqtiuw6olhAHUnH05uYXbbHIfNqxpMOUzWYhcQ2STFXEN0aCrI/zfNzx70orpUtltj1hN/PUyPqt/+L5qJ3kRf6NsivVYVw9gKNgwoqduXUqvAi7NeZMtISQ1nJtTPrygVviLiWSL4a8prUJATBGY/lDb0RQi2qpT1/EpThN+filBigSu9gUXRRoGjP4wFv8Q137idfjQ9G29dDbuC3xMWcC/WF8PwXfsVQXBQ==
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 23:33:55 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 23:33:55 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Boqun Feng <boqun@kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
	<peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan
 Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne
	<shorne@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd
 Bergmann <arnd@arndb.de>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Ada Couprie Diaz
	<ada.coupriediaz@arm.com>, Lyude Paul <lyude@redhat.com>, Sohil Mehta
	<sohil.mehta@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, Sean Christopherson <seanjc@google.com>, Nikunj A
 Dadhania <nikunj@amd.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <ynorov@nvidia.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-openrisc@vger.kernel.org"
	<linux-openrisc@vger.kernel.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel
 Fernandes <joelaf@google.com>
Subject: Re: [PATCH 02/11] preempt: Track NMI nesting to separate per-CPU
 counter
Thread-Topic: [PATCH 02/11] preempt: Track NMI nesting to separate per-CPU
 counter
Thread-Index: AQHc3qIiou69WCoI8k2riB2rRCHrE7YKnBwAgAAwBICAADCqAIAAFYod
Date: Tue, 12 May 2026 23:33:55 +0000
Message-ID: <AEF2F57C-4120-4F2E-9063-EF314F787104@nvidia.com>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260508042111.24358-3-boqun@kernel.org>
 <20260512123048.6666343f@gandalf.local.home>
 <6b2a38fb-1828-43bf-8059-fca8f703e179@nvidia.com>
 <agOm0iiqrqPWXQPO@tardis.local>
In-Reply-To: <agOm0iiqrqPWXQPO@tardis.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6486:EE_|DSSPR12MB999237:EE_
x-ms-office365-filtering-correlation-id: 1caaf789-9b41-4abc-1226-08deb07eeee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 uOi9IIV8Z9qEfujB26fZVBc8OLDWLnDTV5DeQaKijTZD7v62Bo0f0irWsMcXrlrCAymSKcrVl6HBCvQ284JpGmbzK4FA7XVM9aDMkz6JGRq711hcB3VXCZEqEr0MfhfQWfHca29Tuk7Fju/NmK2Q0J2Ne2KStehEyKkqtS8tiFqLjztaGWkRnaEjczpNLL2jYlprAe879Z0frZTG3nROFxtiDZZn5wCTPuuNMjCfw3V1R4gSa6ZgVro5CXeAnVf0WRQwAQupraeufRJBNFAKpq4BBHA2XV6uhzL1+hdpIOBe0bPQGgAxaTOcg8K2E2dxzgh1tdQbAMqrWgsWu5mM9Qq9VWK96bMbNFBRJdvB+KeQoQ2/XB7L6vp9M4rSxB6fGLKNRzzi66sHmS5FzN1UySOaye1W6/+t0SvIOaD67KCnV1jhxD06Lom3CLDh2lLk/5zGoUPw7BEbc1KQkz+y4R3viYD5/BivnpBnWJDvUZWQsMk9a4RP8JWgaLD2q64klpbM56D9Fb9O3rS7FwXrZ2kms7NTGEexSzBJKCY5Y0lPqjqH6z1xVpo02RdbJp6yV3hWemEsU86qcHJvQqSMq38IVawHIuCgyqNCSlu2M3ur75EBcDRMx4geltzNs/z8HwS7S3quGdCL9Cz0Y3IYfWlw3g7o/HQtNuTwdwyxfhUKLMxQ3GkDHuS5jegE3HUHV5knMe/TjMfok5vnCfKHiUtbfSRBMksrs240lwdauRna88FoKpFhpo+gGZiONuHN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0RqWE1QcEpCQWdYT2xpTllieFBMYUkrUjFLMkVYU21xSG1QcklyRDBTUTJC?=
 =?utf-8?B?bW9wVHpPN01KeWtDTHM4RHFNcllBY2tFVmw4NUV0L3AwNjZFTm8wUWZFL0l1?=
 =?utf-8?B?N1BKWExtM1lEc2ZFeDlyTG1ObXhoMC91alBqczJsWEk2d0h2djJwTERqRm9a?=
 =?utf-8?B?c1lhakZoT1FjYXM5TDdraUs0RVZMWGp5a3duT0dsWTRvbGFqOFY3d1NqT2ht?=
 =?utf-8?B?UHQycGNtK2lFeVprNG53Z2I0RUQ5L3VUZlk1aGZ1ajRTa2o1blc4MXBNTEtW?=
 =?utf-8?B?ay9QbkVKR2xGWk5oVWU1R0pUQVkwdkMxREdadGpYZ20wWW9qRnpBVEg2OTRr?=
 =?utf-8?B?aU1UVUFJQ1kwdjgzeGl3QmtnbERhVUZVQUwxd01RM21DMGUxNlA2QWxERkxj?=
 =?utf-8?B?NTlwb1E4RkhZN3RZd2RJL1VjNWFNMCsybFhvbXBUUUpVaEN2R2NtZTNJYmRx?=
 =?utf-8?B?cW04ZWFVTUYwaHJBaWJTRWlaTDltVGxFdEllYnBKb1gvNGhDM2pwS1kvQ1RT?=
 =?utf-8?B?S0FMeDhLam8vVUt4ZGJmdmJxK2ZSeVNUQ0h1NGRwVjQ2Z2xZUVVmbkJIdnpw?=
 =?utf-8?B?Q0tKU01VUExkemg0c0FZcERwK3Q0SStqQzhZWFl5TGlleXZCWTRpNnJEajRv?=
 =?utf-8?B?YnFRK25vS1BndjJyS2NYSlJGamxyeXMvejRuekVYcjRsUXNhVW9GK3FaWTlx?=
 =?utf-8?B?bHFIcHRHdVRhNlNxMjVQQjYxNjJqWVFXaEcxbTRDVlF2V2tjSzVjQTBWaC9P?=
 =?utf-8?B?bUNqU0pPOWZZaE81TEV3SjVpZEtkYjJFeHFqWEJYMVBHQzA2d1BUdVBVN3FD?=
 =?utf-8?B?SkN5bXRnODlFb1lUUmlQa0NUWE1pMDFhWkZTL0RuQUw0czA4Z1JMMDZ6UlZx?=
 =?utf-8?B?QjN1Yk1MUHkwdHN1U1FwREtxTFRGWXVGUVFvMUI2TmYrenpuRVcwUTBnNnJL?=
 =?utf-8?B?ZFJVcW42Wno3amE1ak5KaXM2WVVUa3J5NHFxbnZlWmlnV3NIVHB1SDkxOXE0?=
 =?utf-8?B?MldEcWovRmpJa29QRk8yVWhhcDlJRjFrU3N1SFlGOGVJcXd4TWVNd3A3M2xu?=
 =?utf-8?B?S042K2FDV2gra3dyaEdveEFFLytrOEZ4R2dPNTNpU2R1WGFyU2hnVVFhaVVO?=
 =?utf-8?B?SW52OUs4VDZwZGhKL1BqTEViRVZXZ1JOQ3hrWGhHenN3MmJrMjVkTWY3ZzZ1?=
 =?utf-8?B?c1M5eUJ4eXJzeExYUXpyWWQzWDYrQjh4L2dtdkhyUnhyY1hIUCtQYW5lSUJE?=
 =?utf-8?B?Tkxldm9vTzFjb1Y2MWZvMVJ5T0xEMk1qM0ZNTFdnYThpTUZIb3JNd0diMzFv?=
 =?utf-8?B?dWs5aGk2RVJqZUpCWFEvRVZJbmx1OUlRckVBUEl0ZXlpUGNXWGQzWFRqVFQ3?=
 =?utf-8?B?d3B4Q3VFOUtmdGdpcE5LbVVUcVlTUGwydk5VZHNhL2Z1c0M4a3paZHgzdURG?=
 =?utf-8?B?VC95RWtUZnpMd3ZIY0U3eFA3cEs1NXFCaWo5eFJMV1YxYzZjd01rS3BPRlBQ?=
 =?utf-8?B?cENhaTlqUFM3QXdDelFtL3ZEZnUreTN6bVljVzZ5ajZ6bXcrVTZpTmoxdUF3?=
 =?utf-8?B?UTV4QzF3UEZsVXcyMUZaWk9tWGlyTXFsZTJic0MwU0N1SW9ER3hVRWR6eFBx?=
 =?utf-8?B?SnpsWnUxK1M5NTlwbkFkUldsVFlTZ2hXT2tETDh0YmlHdmZIZmp3WllkZXdj?=
 =?utf-8?B?SDBJeXdVQllNOEJ4eGRLRGQxaVNXaWtHeDBNcDJQNURicUtQdEQzSUJ3OHVI?=
 =?utf-8?B?SjdFeDVVYnRHUllIVzc4L3ZzNnR0Uk9ZcDNDSS9RRzVnWHpFMHI0M2FIeDB0?=
 =?utf-8?B?Zm5nZ3A4d1BZRncxc0d2TUdHNUNqZkU4MEZQWTVVS2JTcUJTd0NSK3cvRndQ?=
 =?utf-8?B?SW8yODRZYk9Gd2YyZVcwRmZmcW5yeGlENUVlbHJzQWlURmMvRHk1ZmFMR2ht?=
 =?utf-8?B?VC95OEpnelZQa1owL0dGMW4zZFVDVktadUliK21OMTQvd0lCY20vZy9YU05B?=
 =?utf-8?B?a2NuaGVjRHlqVmFNQkc3QTVOMHZCK2FsVnJSNmpLWHRRb0VQbm93QW90cG1Z?=
 =?utf-8?B?bDArYko3bng5ZHVRVHN4Njh3N0kxTkdPbGZyV2ZORGl5N0NaSjVILytHSlQ3?=
 =?utf-8?B?TXd0QXNRMlB6N3Q3OG0wbWpwRXhGbWZjL0FKVy91eExPMWFjQy9wVG9ORHVF?=
 =?utf-8?B?K3lQYlBMNWRudzNRZ004c1VNKzk4ZFFqeHZpeVMwZGNlTkJEek4xN2RFSlJS?=
 =?utf-8?B?L1Y3TURRSTJTM2FLYnZ1QkdaZllQKzEwaGhzWGUybXBKWHZUSU05OXhvVHR3?=
 =?utf-8?B?RHhtT2ZXeFhmaUhQQUQ2VS9XcnF0akY4QzNOR0RGdkJGV0dTeU14a2xkNi9r?=
 =?utf-8?Q?Eo8V37YXaDhPoEnWcUxfE1VcaSJdEl2l1paHSg56xIJBW?=
x-ms-exchange-antispam-messagedata-1: Gca2OcdU+XSExQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caaf789-9b41-4abc-1226-08deb07eeee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 23:33:55.2790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XOMyp0b0/dB/z9ipTwg2oKxriX+qF7vuf8nWkwB/iOXD/CHDfVcT3TVXf8Ll/hJiaiI5IxqatBFe2fNsEMCMLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237

DQoNCj4gT24gTWF5IDEyLCAyMDI2LCBhdCA2OjE24oCvUE0sIEJvcXVuIEZlbmcgPGJvcXVuQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVHVlLCBNYXkgMTIsIDIwMjYgYXQgMDM6MjI6
MzlQTSAtMDQwMCwgSm9lbCBGZXJuYW5kZXMgd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDUvMTIv
MjAyNiAxMjozMCBQTSwgU3RldmVuIFJvc3RlZHQgd3JvdGU6DQo+Pj4gT24gVGh1LCAgNyBNYXkg
MjAyNiAyMToyMTowMiAtMDcwMA0KPj4+IEJvcXVuIEZlbmcgPGJvcXVuQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4+IA0KPj4+PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBudmlkaWEu
Y29tPg0KPj4+PiANCj4+Pj4gTW92ZSBOTUkgbmVzdGluZyB0cmFja2luZyBmcm9tIHRoZSBwcmVl
bXB0X2NvdW50IGJpdHMgdG8gYSBzZXBhcmF0ZSBwZXItQ1BVDQo+Pj4+IGNvdW50ZXIgKG5taV9u
ZXN0aW5nKS4gVGhpcyBpcyB0byBmcmVlIHVwIHRoZSBOTUkgYml0cyBpbiB0aGUgcHJlZW1wdF9j
b3VudCwNCj4+Pj4gYWxsb3dpbmcgdGhvc2UgYml0cyB0byBiZSByZXB1cnBvc2VkIGZvciBvdGhl
ciB1c2VzLiAgVGhpcyBhbHNvIGhhcyB0aGUgYmVuZWZpdA0KPj4+PiBvZiB0cmFja2luZyBtb3Jl
IHRoYW4gMTYtbGV2ZWxzIGRlZXAgaWYgdGhlcmUgaXMgZXZlciBhIG5lZWQuDQo+Pj4+IA0KPj4+
PiBSZWR1Y2UgbXVsdGlwbGUgYml0cyBpbiBwcmVlbXB0X2NvdW50IGZvciBOTUkgdHJhY2tpbmcu
IFJlZHVjZSBOTUlfQklUUw0KPj4+PiBmcm9tIDMgdG8gMSwgdXNpbmcgaXQgb25seSB0byBkZXRl
Y3QgaWYgd2UncmUgaW4gYW4gTk1JLg0KPj4+PiANCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBCb3F1biBG
ZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9lbCBGZXJu
YW5kZXMgPGpvZWxhZkBnb29nbGUuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMeXVkZSBQYXVs
IDxseXVkZUByZWRoYXQuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBCb3F1biBGZW5nIDxib3F1
bkBrZXJuZWwub3JnPg0KPj4+PiBMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjAx
MjEyMjM5MzMuMTU2ODY4Mi0zLWx5dWRlQHJlZGhhdC5jb20NCj4+Pj4gLS0tDQo+Pj4+IGluY2x1
ZGUvbGludXgvaGFyZGlycS5oIHwgMTYgKysrKysrKysrKysrLS0tLQ0KPj4+PiBpbmNsdWRlL2xp
bnV4L3ByZWVtcHQuaCB8IDEzICsrKysrKysrKy0tLS0NCj4+Pj4ga2VybmVsL3NvZnRpcnEuYyAg
ICAgICAgfCAgMiArKw0KPj4+PiAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9oYXJk
aXJxLmggYi9pbmNsdWRlL2xpbnV4L2hhcmRpcnEuaA0KPj4+PiBpbmRleCBkNTdjYWI0ZDRjMDYu
LmNjMDZiZGE1MmMzZSAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9oYXJkaXJxLmgN
Cj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9oYXJkaXJxLmgNCj4+Pj4gQEAgLTEwLDYgKzEwLDgg
QEANCj4+Pj4gI2luY2x1ZGUgPGxpbnV4L3Z0aW1lLmg+DQo+Pj4+ICNpbmNsdWRlIDxhc20vaGFy
ZGlycS5oPg0KPj4+PiANCj4+Pj4gK0RFQ0xBUkVfUEVSX0NQVSh1bnNpZ25lZCBpbnQsIG5taV9u
ZXN0aW5nKTsNCj4+Pj4gKw0KPj4+PiBleHRlcm4gdm9pZCBzeW5jaHJvbml6ZV9pcnEodW5zaWdu
ZWQgaW50IGlycSk7DQo+Pj4+IGV4dGVybiBib29sIHN5bmNocm9uaXplX2hhcmRpcnEodW5zaWdu
ZWQgaW50IGlycSk7DQo+Pj4+IA0KPj4+PiBAQCAtMTAyLDE0ICsxMDQsMTYgQEAgdm9pZCBpcnFf
ZXhpdF9yY3Uodm9pZCk7DQo+Pj4+ICAqLw0KPj4+PiANCj4+Pj4gLyoNCj4+Pj4gLSAqIG5taV9l
bnRlcigpIGNhbiBuZXN0IHVwIHRvIDE1IHRpbWVzOyBzZWUgTk1JX0JJVFMuDQo+Pj4+ICsgKiBu
bWlfZW50ZXIoKSBjYW4gbmVzdCAtIG5lc3RpbmcgaXMgdHJhY2tlZCBpbiBhIHBlci1DUFUgY291
bnRlci4NCj4+Pj4gICovDQo+Pj4+ICNkZWZpbmUgX19ubWlfZW50ZXIoKSAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4+Pj4gICAgZG8geyAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
Pj4+ICAgICAgICBsb2NrZGVwX29mZigpOyAgICAgICAgICAgICAgICAgICAgXA0KPj4+PiAgICAg
ICAgYXJjaF9ubWlfZW50ZXIoKTsgICAgICAgICAgICAgICAgXA0KPj4+PiAtICAgICAgICBCVUdf
T04oaW5fbm1pKCkgPT0gTk1JX01BU0spOyAgICAgICAgICAgIFwNCj4+Pj4gLSAgICAgICAgX19w
cmVlbXB0X2NvdW50X2FkZChOTUlfT0ZGU0VUICsgSEFSRElSUV9PRkZTRVQpOyAgICBcDQo+Pj4+
ICsgICAgICAgIEJVR19PTihfX3RoaXNfY3B1X3JlYWQobm1pX25lc3RpbmcpID09IFVJTlRfTUFY
KTsgICAgXA0KPj4+IA0KPj4+IEkgdGhpbmsgd2Ugc2hvdWxkIGtlZXAgdGhlIG1heCBuZXN0aW5n
IGZpeGVkIHRvIDE1LiBJZiB0aGlzIGRvZXNuJ3QgdHJpZ2dlcg0KPj4+IHVudGlsIFVJTlRfTUFY
LCBpdCBtYXkgdGFrZSBhIGxvbmcgdGltZSB0byBzZWUgdGhhdCwgYW5kIHRoZXJlJ3Mgbm8gcmVh
c29uDQo+Pj4gTk1JcyBzaG91bGQgbmVzdCBtb3JlIHRoYW4gMTUgYW55d2F5Lg0KPiANCj4gDQo+
IA0KPj4+IA0KPj4+IEp1c3QgYmVjYXVzZSB0aGUgY291bnRlciBhbGxvd3MgaXQsIGRvZXNuJ3Qg
bWUgdGhlIHN5c3RlbSBzaG91bGQgYWxsb3cgaXQuDQo+PiANCj4+IFRoYXQncyBmaW5lIHdpdGgg
bWUuIEJvcXVuLCBkbyB5b3Ugd2FudCB0byBtYWtlIHRoZSBvbmUtbGluZSBjaGFuZ2UgdG8gdGhl
IHBhdGNoPw0KPj4gDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGlzIG9uIHRvcCBvZiB5b3VyIHBh
dGNoPw0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaGFyZGlycS5oIGIvaW5jbHVk
ZS9saW51eC9oYXJkaXJxLmgNCj4gaW5kZXggY2MwNmJkYTUyYzNlLi5hNTlhMzNlMGY1Y2EgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaGFyZGlycS5oDQo+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvaGFyZGlycS5oDQo+IEBAIC0xMTAsNyArMTEwLDggQEAgdm9pZCBpcnFfZXhpdF9yY3Uodm9p
ZCk7DQo+ICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgbG9j
a2RlcF9vZmYoKTsgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgIGFyY2hfbm1pX2VudGVy
KCk7ICAgICAgICAgICAgICAgIFwNCj4gLSAgICAgICAgQlVHX09OKF9fdGhpc19jcHVfcmVhZChu
bWlfbmVzdGluZykgPT0gVUlOVF9NQVgpOyAgICBcDQo+ICsgICAgICAgIC8qIE1heGltdW0gTk1J
IG5lc3RpbmcgaXMgMTUgKi8gICAgICAgICAgICBcDQo+ICsgICAgICAgIEJVR19PTihfX3RoaXNf
Y3B1X3JlYWQobm1pX25lc3RpbmcpID09IDE1KTsgICAgXA0KPiAgICAgICAgX190aGlzX2NwdV9p
bmMobm1pX25lc3RpbmcpOyAgICAgICAgICAgIFwNCj4gICAgICAgIF9fcHJlZW1wdF9jb3VudF9h
ZGQoSEFSRElSUV9PRkZTRVQpOyAgICAgICAgXA0KPiAgICAgICAgcHJlZW1wdF9jb3VudF9zZXQo
cHJlZW1wdF9jb3VudCgpIHwgTk1JX01BU0spOyAgICBcDQo+IA0KPiBJIHdpbGwgbmVlZCB0byBh
ZGp1c3QgdGhpcyBpbiBwYXRjaCAjMTAgYXMgd2VsbCwgYnV0IHNob3VsZG4ndCBiZSBoYXJkLg0K
DQpNYXliZSA+PSBidXQgdGhpcyBzb3VuZHMgZ29vZCB0byBtZS4gVGhhbmtzIGZvciBhZGp1c3Rp
bmcgdGhlIHBhdGNoZXMuDQoNClRoYW5rcyENCg0KDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEJvcXVu
DQo+IA0KPj4gVGhhbmtzLg0KPj4gDQo=
