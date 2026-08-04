Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020091.outbound.protection.outlook.com [52.101.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D76C8EB;
	Tue,  4 Aug 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846383; cv=fail; b=MfFjvPDE8IW6udCBRAT9NxbNyvyX6gZYGivHjzv/nmEY0bKzXfvo/msgJpJqy8+8J5edG2/BZN4M5BRB0bCaPnC+RwWOkNfex7Y1TfB1wqtTuEZD0ndFZ23ZxEg2azBM+mNZl9GJpax+uiH2IGuYGaqUa+G7DY25x6vKQpW54wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846383; c=relaxed/simple;
	bh=kArf0BlUa8IR80x0ogJilWrxe2BhfdcpetWnkZF13jo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=e9+b/ZSM642PhigdqOsgpV9DPwYQrgKkx1GBMph5Eki/Z4AS7FuEz0+LK7LddMV5kqC8nyYp+FaVbsKsqaLNtxBv3eYgP4AFUX9yRXrPwHqNOiamyr8HNe+YB3U99nE7XxMN2pCz+WkN6WIHSp/DKd/GuuNR/GftvBqO1TQVT6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LuR/NWec; arc=fail smtp.client-ip=52.101.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LuR/NWec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfGeN/pB4EWl6m/dvYkmhMWPuxmEXTsM0V8j4bewW+j39+xp7qZu3FMyYceklO7R9xtfvSY46uGD8fastxxRhtFWhx2p2itQJETIAVAH/Te+qhgvrsNh7daGEM2PovJBlYmnywGqK+Evh/I+9HrkujKplgCKT1Zo8tg4eA/KqeQM5kTIsqCzpqLpFouK7lheEHFiadjmWfOySozpWvHqyFviSVojiTd4tRuQrJQO4CwNEWnABD5geqouUMXs1c6XJgK6hP4ycAlXLotBrDBi9L1ija5KS8dbmVw9kuOKHhtIrV1H7f8DWKX5gbZEd+W/eYUDx3wmFnLXcO4csIt5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuVm4w897C33ZpcHCT0r92nLvIy869R6u8LTmKoW/Yc=;
 b=rV7LsNvvQ+ZS739ESM47WMKfL6gOQCKcKOIaaFrtKQjsO/tqra61PkGSDzBO9Z0hp3H2mtmWVLIfPdA0F3LDAEhfgO6/YFpj9WOehsQOBoUoSd0ICykY2noE2oouqGdxXRDIeCCRWJ6mRFJxeS+jdx7z7I7hzbPCjceJ3RzJOej+VDOB1hoIXapMhGwOHAikWbtcNHdQOGaruBWgVVg8aDt4HSpjc+AWjaG3sa+5V4RcvR/aSdzaVL/9uHmiJbWD0rfwKELd/bQuc3vS5v9upSUQ+80PaOjl/GZYqr06cDpCPUSVLH0m2/93auK2NOP5A0r0nXSkyRPEv8OarowjSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuVm4w897C33ZpcHCT0r92nLvIy869R6u8LTmKoW/Yc=;
 b=LuR/NWeczTnhDvQVNWB3i8An3A4ypHbXdbEEh8vCYPrngXF83U6NRmN0Pe/VWBjUPPH0zja8bDbhOqJzQ8W65/MuznsAMAvgH4y/mb24cyib9faoGAIrQnHRRlAcBgHArwELtMdiZmuW9jZ6uQYNcVoF0d54f758CVApYCWEWXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOVP265MB8726.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:489::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 12:26:18 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 12:26:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 13:26:15 +0100
Message-Id: <DKG5PF85ZIXM.258B3U2PN3P8Z@garyguo.net>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Niklas Schnelle"
 <schnelle@linux.ibm.com>, "Gerd Bayer" <gbayer@linux.ibm.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Vasily Gorbik"
 <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 <driver-core@lists.linux.dev>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 <linux-s390@vger.kernel.org>, "Linux-Arch" <linux-arch@vger.kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
From: "Gary Guo" <gary@garyguo.net>
To: "Arnd Bergmann" <arnd@arndb.de>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803180931.97202-1-ojeda@kernel.org>
 <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org>
 <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com>
 <DKG43HF7A2EN.PC1LBC0QUP93@kernel.org>
 <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
In-Reply-To: <f0e0c069-23eb-443a-800d-267cfe4c2aa2@app.fastmail.com>
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOVP265MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: c8874599-12c6-472a-fee4-08def22394c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|6133799003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e/9kLsAED6KuMW3e+QTDgY90Fhu1Hyb8XesLG83F+122POwAOxIE1XkJ1mNvs2GzenAmvQtwKV7at+GXtnifVKS5tqGiCYwxBMTAgfvk/kAXmtsJOExt+G/q+ase0wtU8hujPbkA1rIzkuP8Aj8IA7ewl2ZGvh7T505TirKOwIDlfizS/G74xua2E3HgI4HG1rC/htprE6R363qtac+/Grm1QLzVQrWXzp8/ennZp7v8nV5U5veRLl9vqSjdE9fT50FWiSDm3C3ld7/rUEv8UjNNjcfoAqHL4Qe6K0xOVmVI6ZDdYftoTyqTTRJuYxtqMpRfGCVOyojThdsiWUNy+N+7JZJh3sWZKr+EbV4+qpPz862WaHudrXXtDiyyshbrpLhU3+4PCMiRfOTNS3RIahhQrUYsztupvbACav0g1KCnNoGCQ1TfkM9weGmjmNuHUci2Py4KYnD0NA0wV2iB/kR+sGCjM+iHiSh65cYPXYQce7t44LQkevlGKTbPt30u5vPcirbjICpDyv6tmoDjwCyIOTM9HeaJthbBANBv/L5Mc39ZGeV+c5j8kbW9Uu3rlNz1GPTB8BB887fEpFTKd7jtZ+u6Cqy1b5kxiHEohATyBmeAHjn4Z3xKsk0AgeCV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGh4ZkxUSUxpWGdDUkU5SzhnVjUyVUhnR3AzWmpGY21VZEt6czBaKyszcnBQ?=
 =?utf-8?B?clljbmZTekFIeFZrQlJQUDB6QnNMajRrRjdNYjBQOVhLbmhRVWJPdzFFZHg2?=
 =?utf-8?B?cW1rYlhidi95M0t1OWprWFNPY3Y0OUplUGx0WmVvNlQySi8wb1NkYmN4VzEz?=
 =?utf-8?B?cDNFK1hpbWsrcEV2Q3VBdytac3pJTjJZOFFaak9aNnVOY3IxU3dxTm9SQyt6?=
 =?utf-8?B?MzFvcnJCOGFDLzI3eGtZQzkvMGhtamlIcVdqR3BHdEpOSERGUHRnQlV5MmFt?=
 =?utf-8?B?d0pKRkpVVUNHY1VPUTVrZ3hZZklhUDFRTHYwUTNFK2gydHRvYzQrdERQYkZ4?=
 =?utf-8?B?QXJraWpQMThaQzZUL2RMTjhLOFlDV3dsUXRZOXJOZk5kdlJVVVZ3Si9IbW5R?=
 =?utf-8?B?b0cvd2dtL3BzaVZ4T1ZrTmdRQ2NqZG52blBiR2VOQk43emQrOHoramJFZ0VV?=
 =?utf-8?B?SGw5ZW02UytPSVVibm12KzhKMUhsTUZCSUs2ZEl2U3F5a2tSR3Rva1h3U1Bi?=
 =?utf-8?B?d092eCszeGZIaGtqYm9LTTlaK0p2WWhNQmorNXZHVy9zaDdOYW9wSXJJak9p?=
 =?utf-8?B?NndnUzBVellsWmV4RTRpeDNXZ0loWVh2bWhLMWVpbzVodkhCdWJHSWoxbmhx?=
 =?utf-8?B?ZmtqUVNmNXVZR1QwRm05dVN6S0ZPZmo1SUF6TzdpT3haV2N0c1lrNUNWWmVk?=
 =?utf-8?B?NHB5M2tsVW4wWndsM3JEekJ6NFhrSXhpV2xYSlB0b1o4NWJYd0RKT3NKd3dl?=
 =?utf-8?B?VWJoMHg3ekY2WCtrTDg5UURDMENmckRwTmtyc0ZLQXRUWkg3bTZSUi9iUVJK?=
 =?utf-8?B?bXgwbzJ5NUhyK2hiQTRnTVFFUk5WdkovODI4cHdUaXZHVDhhYm95UmFOOXRN?=
 =?utf-8?B?b0hJaExSV2o2VVkrYzVNWW5HNXdOQUlvTTBoVEZIUTZwSzRpVWx1M2xVWjg3?=
 =?utf-8?B?RFFjVUJ3ZFI3S3RqZ3BqL2tPRTg5OS9DclovSHlGVGlNQVJWZlFxeUI3QTlG?=
 =?utf-8?B?Rngxc29SZkQ3VndOeXlSY0ZrbmllVnR1MlgyK1RsRlVaM1ZZbXV2dDBTb1pi?=
 =?utf-8?B?SENza2ZCTUxyaldGYnJxeDhteVhiKzFhQmptTG1Jai9BZnJLeDhBT3AvL01U?=
 =?utf-8?B?N2JUdEFCTit4ZHViQlowTy90NzNnNXdWY0xiMG4wVlMwUzFhREZQeVZOMERw?=
 =?utf-8?B?VDNabHMxMzJNR0xsRDdVWW1EMmpWemRwWWgrNk9XdHNiSGxEbFMzZXhqbkpF?=
 =?utf-8?B?ZTRCbWVHMnlZbUJ5cUNOOVhzSThhU0VHOE56dDd0WGo1dFY0SGNrdm9iVmRR?=
 =?utf-8?B?UmhYeG1rQUs2U2l6SXJ0dnNwc3V0YWRoQitVcGdmOURpVnoyUHJsaEFqSWg0?=
 =?utf-8?B?YzVsVVhSVnpPVTdER2czVFNmeFQ0Z3JTbDg3MEhrUUNPMXRtNXIvRU1XbFc5?=
 =?utf-8?B?Mmt0czliSjZUcUhNRW1QSDFaMGpOUFJQZVpRaUU0U2FQcHZOVVVDSVZJeEVi?=
 =?utf-8?B?Y2o3VUJGRDJMOWpvUXZaSEozUkxzaWpuWHAybkVhVTRJcHdPZ1Y3Y1R1OEI2?=
 =?utf-8?B?MjJieUdXalJSMlFQSWFJVDZTY3ZLQUIwdHhIWEpkSHZMRkR0MHJmWmJ4MCtw?=
 =?utf-8?B?K3VycjBwWmNKR2FFbUhpc0kxclY3NlhvMTBzajR1ZFRHaXZqbVlWSlRVMmpQ?=
 =?utf-8?B?Y0I3MGwzc2tjdE9wQWUxaTY2NlZ5YWFOWUhTV1JYQWU0UHFGZzBCUnQvem16?=
 =?utf-8?B?Z2Y5U3grcTB6cDZDZjNadk5qZWpBUlk2Vzl1MjF1ZC8xdnQ4Zy8rcHNoQkdn?=
 =?utf-8?B?WTgyeEJ3VkVtWHliSkpmVlA5TkFnM1BhWGE5WW4yS0xGbHBJS1p4VFJsOVFn?=
 =?utf-8?B?OGRZdzJOaVIvWmxBczJjbUpFY2wxMVY5MUo2Y1lvTlJNbnMxR2FYZDNzMS9j?=
 =?utf-8?B?Q0JHWXUrTlpINmZhRDRDTmRIUUdNMDB3eWhqbTRaRys3UmZrUnprVUJTR0NN?=
 =?utf-8?B?NGY5QVhDWmkvelRwQWV5YXF3c0ozOW5Pd0wxTFlVYldPbS9DV1VkYmpLYmJy?=
 =?utf-8?B?YlRIZzlRVjZodllkRGpjVW1RaitxdUFnOWErWUpkUzREZmNLQWk0cTY2WEZr?=
 =?utf-8?B?L2l1dTVNS3M1TUp6Vko4d2hNWFRKanVIcWFFV2RyckszbS82NzhPMWVJend2?=
 =?utf-8?B?VTRSWlI1TStIcGlDY240ZFdUbUJreUhlVkQvamk0cURUdlZ5eFk0b3MvOXBL?=
 =?utf-8?B?QkZ4SUNKUFlFM3pvSThPd1VzUGFsUEpsTXA3M0tUZUxJdHBQL0RDTzBURnRz?=
 =?utf-8?B?UHBYZ014SDZQQlBNVzZTK3lOZHM2Q1RwZEJVRktSZldZbURRMk95QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c8874599-12c6-472a-fee4-08def22394c6
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:26:17.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM58zK9sw/Wf33lTwNuTIqQ3BDmY4DZFGTYaR3fSO7kUtIjP/I5lHgR3a0e5z8yXRAhblQY627UX8NDZbrX0dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8726

On Tue Aug 4, 2026 at 1:02 PM BST, Arnd Bergmann wrote:
> On Tue, Aug 4, 2026, at 13:10, Danilo Krummrich wrote:
>> On Tue Aug 4, 2026 at 12:36 PM CEST, Arnd Bergmann wrote:
>>> On Tue, Aug 4, 2026, at 09:13, Heiko Carstens wrote:
>>>>
>>>>> I just sent out a fix [1]; the only annoying part is [2], but we shou=
ld change
>>>>> those doc-tests anyway. For the one in rust/kernel/io.rs we already d=
id in
>>>>> driver-core-next.
>>>>>=20
>>>>> [1] https://lore.kernel.org/driver-core/20260803200249.3494259-1-dakr=
@kernel.org/
>>>
>>> This looks like you still provide the rust version of ioremap(),
>>> turning what is supposed to be a link failure into a runtime
>>> error.
>>
>> Which is the standard for many core APIs, such as [1]. However, I do agr=
ee that
>> in this case the correct fix would be to have all architectures provide =
the
>> stubs rather than the Rust code.
>
> We have both types of interfaces in the kernel. For HAS_IOMEM and HAS_IOP=
ORT,
> the link failure is intentional, as it helps identify drivers that need
> a Kconfig dependency and are either unusable or potentially harmful if lo=
aded
> without this.
>
> Having empty stubs only really makes sense for things like LED support
> where a driver calling the interfaces can continue to work
> correctly when the interface is compile-time disabled.

We can still have link failures if we always provide the signatures, just d=
on't
provide implementation?

Best,
Gary

>
>> However, there's already a precedent for this in the kernel, e.g. in [2]=
. Of
>> course, it would be better to clean this up, but depending on whether th=
ere's
>> more architectures having this issue (I didn't check) that's separate fr=
om a
>> fix.
>
> arch/um is the only other one that does not always enable HAS_IOMEM,
> though most m68k targets don't have any support for ISA/PCI style
> MMIO or PIO and probably should not enable it in theory.
>
>> [2]=20
>> https://elixir.bootlin.com/linux/v7.1.5/source/include/linux/device/devr=
es.h#L115
>
> Right, we are definitely already inconsistent here.
>
>>> The simple change below would just extend that behavior to !PCI
>>> and make that consistent with CONFIG_PCI=3Dy on machines without
>>> actual PCI hardware. Of course any code that might rely on this
>>> is now a bug that likely never gets caught at build time.
>>>
>>> This still relies on implementing the __raw_* helpers as nop
>>> to have the same behavior as the PCI=3Dy version, as the generic
>>> version would just end up dereferencing the invalid pointers.
>>
>> As mentioned, I didn't check, but if this is the only architecture causi=
ng those
>> issues that'd be the better fix of course.
>>
>> However, IIUC, your patch below would make ioremap() and friends silenty=
 succeed
>> and only the accessors would prevent undefined behavior?
>>
>> In this case I still think ioremap() should just fail.
>
> In that case, it would make sense to also change the CONFIG_PCI=3Dy
> version to fail the same way when the address points outside of
> the PCI memory space range. The current version in
> arch/s390/pci/pci.c just falls back to generic_ioremap_prot(),
> which is what I would use here directly:
>
> void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>                            pgprot_t prot)
> {
>         if (!static_branch_unlikely(&have_mio))
>                 return (void __iomem *)phys_addr;
>         return generic_ioremap_prot(phys_addr, size, prot);
> }
>
> The two methods here (generic_ioremap_prot() and the cast)
> are machine specific to refer to two different ways that PCI
> devices can be accessed if present, but there is no case
> for PCI being unavailable altogether.
>
>        Arnd


