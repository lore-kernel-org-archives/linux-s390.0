Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022134.outbound.protection.outlook.com [52.101.101.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7E3ED124;
	Wed, 27 May 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879197; cv=fail; b=cUcwbBl0zwhNazVQ42qP+KWFYB6QYTJDGxLOOsCvjkPZLaVSM4AI+64aiC+FhB9hq8XPR0PjtC1vUcxj5crwWMQgc2Ae+Iu6exz9J3UNrD0ylAITPTuCv4KscgN5xnMxMat1JqR9eQjhts1jh75omZUqyjiw2GfmMBla7K2k6Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879197; c=relaxed/simple;
	bh=rwOUK9KzcSX40JXiMyFgAQ79BdJfTMYQUXgDRqWkg2s=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Y+hAnm59qy5YTJNO1aEZS80uKtmaVr4jvpXukovVmf7nbfbeQMqyfRcaEmNk4r7E2RVTfSPyoCewAcxs/rlHSs9hDswnqE17xKF0OzzyD4i09uGMl6Ns84GUBVwlH58OGIrAz7gnJEzyOkuCsNsFJqOtpJmIf65p+L44WP0hRSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SRTO6o7Y; arc=fail smtp.client-ip=52.101.101.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SRTO6o7Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC6nki9aIu57A1cS9yvKQGIoqOseIeF3OD7+gsRn13PKGr3P29tGKIKNpIEUgD9Vbt9QgulufHRVAZK+p8So646RQDfDx6F651GDZ3eoLkE4AVCCfCu9rvtmleNY6uWOeY+HuBqmw1imqREPuUdDiqO6af9Nl72XM+E+MLSf1+rvlpHJPgVvmWdDqEtn4ZdAKKHnMJSQ02rKXSk4RFirTMXkCsCxCfqmvVkHnxyNasQSr9guJDUhFA4y6KaR/2+Q2CPn2cVkDZSB6OqzTCxY5nTF+dPc5E7PIjUyYtyHZh+cXUekGtoMkN5nX9OPqnegBxSGt4K5ot9HJmwe34XeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOcv+X8R7E00nVTm8FwCMsNAyl9IR4fv7fJ0XhhspQU=;
 b=WSFXxpwPbXJElJGXhzsehLRTWzQ7WnmTxQZwLqGXtm+iaD2aMe+VA1tzJD3TNvVYQD5ujIOLQHbbvjW388crcNIpPvDeyrW9rySfET0bliptfGM3xnswJrzzveyNgetx53XcImauST9aIULd/AOpD3+BfzcDvI9MdvJ0y+zdM3UYjDRNDcpQaPVaEJd75T9bx1xqPMC/3K+VNA6L9+QpmXYTKVAKyJx/W13v++4uQ+dQk6jGVLZrmRVFbDfsvYSiGt9j1ro4Bk90Du3Rj6uIY0KCgoTYpLiqe3ILqarOq8d9cOZsD2qn0sUnNFuGsDUMlI64GwWZBr25t73KyYvKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOcv+X8R7E00nVTm8FwCMsNAyl9IR4fv7fJ0XhhspQU=;
 b=SRTO6o7YDoe+YgEOFktKtySFrffzMWUmSkipxIxsyhFdJ5SoAZNWM7xuJNZnTBSxavJy3KtGdII4QeQBgGj3K9bv7eLlXBr2q58kJMTMwy2frdvey0gx2C41GcV0D5QworhNFgOrrYS11tvP/5Txz+BY44u98te+MlrelB6OGfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2570.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:53:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:53:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 11:53:10 +0100
Message-Id: <DITEIKBF8WWY.FAJEEBSV71OZ@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Boqun Feng" <boqun@kernel.org>
Cc: "Jan Polensky" <japo@linux.ibm.com>, <gor@linux.ibm.com>,
 <agordeev@linux.ibm.com>, <ojeda@kernel.org>, <peterz@infradead.org>,
 <jpoimboe@kernel.org>, <jbaron@akamai.com>, <aliceryhl@google.com>,
 <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <rostedt@goodmis.org>,
 <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
 <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
In-Reply-To: <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0065.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2570:EE_
X-MS-Office365-Filtering-Correlation-Id: 4035a4bc-393b-4da0-347e-08debbde2536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|22082099003|18002099003|3023799007|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	qrLw3Hij6F4amCmQF9095uJj6uPAInQAal8ITQpGxlatRB+cYcFK5EWuxYsDQaku6Pd6Zrwmyl6VSJDg9JYoh/Nob5Et3Wq4STnm8KxLUkEGpVJfQh5Jb1B9ls18zyuh6PnG3MU4sw6+d4PSaQenY6w7xQHcqVEDnvdmjp//XK39iqR7+ZBvHg3ADdsUveFpCdeGhpumX22yCi1rcvVSdi6nckzKJ4wM0dgirBQJ/jtc8qjzx5toT7AI7J9Jwx67eu/ZV0N0tmvCFpiwb5d9SokKwqO1bsIRVbehsb4BEMKHhEdk5eT1cRdyK6MrVSWFwP9h/2BaZYuQZI5ngcy/NJD+ZRMM9VZpd4MwCzAZYd/hs59ehrpyE2sUPK/aDfNRBQ0ysJGFv+6YXNk6BHUs3H6mX64Zipnrun/oZ6m3PFXp2INJvIXAYlYWytQNN1pMGHkDaGaQeUS5F4iiaoE5NMGi6/ubtp3BXE2zflLiWm2LZOiWnISTINpdVXKYsRKF/7yLoJ8uav8D9uKsu3BuEq1gwBevGYHXUMerza3bnRWJZbnFnWkS06/eERz39yLP2PUVTtg6W4IXsqgzIrfQSVBiGGodn4cOFtrW7axS18RtdwyY0kBGO73h4VTWkg4MTLtgnxcLKsdvLVVEiicHaMrrUkhiyjqqy7MJwJhqt8hWHmj9N2onv/IYuxJj6pzt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlQxQ0lSc2tKb0hoNlpQdU1EZFk4aEpNMm14Tloxb0VnaUViVVBsYnYza2xk?=
 =?utf-8?B?d0xBU29HckExN1lGbTBWeFUvYVpGeTJWTFhuSzBoZUhYaC82TUptR2xUNXR4?=
 =?utf-8?B?NFB4aWtOOG5IZ1FLcHdHUVpkOGF1NTdud2RBbm84SXVYWVZXbERVMVo1d3NZ?=
 =?utf-8?B?WmMrRGE3SlpaaWNta2hiOHhMYUVvbjFac3MvREU0cHFGaUpzbmhHQWtZTnE5?=
 =?utf-8?B?U3ZzYTZBUjR1K0x1WGRSRUFlQ2FVM0dzV3Q2V3pJTWxPRTdkYXZLeW1TNStV?=
 =?utf-8?B?VHErY25mSUtzL0cxUXBKTU5JWWJZK1I4MFppU3J0bDNPNnJRaWp2bUpPa2lr?=
 =?utf-8?B?MlNacTk0aTZmOFBGSmpTQ2xGb2puT3lsVFhWelVGcnJpUDlTTmFxUEJmZzZP?=
 =?utf-8?B?NU5GRklyOUgvbFhjcUVwSkkzS3NhQWZqM2V4T1YyQ05wY1FoSG01bVU4NDgv?=
 =?utf-8?B?ZzRuTnBTZGFGak9sQU1UTFhsZEI2WktMZGpxWVdlUWIyL1prWExMNHBQZW9Y?=
 =?utf-8?B?MUt5b1Q4WEdtUUd4Tzg2QnNvZHJ5S3hDTTlXb3haZ1ZNRzAvb2RHYVQ5aWl4?=
 =?utf-8?B?OE1MRVdmakJEU3F0MEp1cFhaYUpMMEFPeFFSN2VldFl3UDN2cFUvNEJlYTdZ?=
 =?utf-8?B?U2JxT29OWXpVTHZXUmRFb3FXK0hWOVJzODlQc1k3UEZSbjQ0cVZoeU5UWW9M?=
 =?utf-8?B?bDh2ZUVjc1o2VjJwZWExZkFpTUpvMWJOcFpXR21TWXFZb0xlUE9JZ2U3RHFo?=
 =?utf-8?B?VlJZcklCOEwwZW9VYjRJMUxqclc3YnB2bW1wandpN0xUVGhsL1kyTjRmZCti?=
 =?utf-8?B?VnVqNVc5Y1JaT2Zxb24wdnNpNzg0RDYvaCtmcjhPMmphNFBnRE1MRU9wMzlu?=
 =?utf-8?B?Y2MrRGF2K3lraHA1SnRMSng2c0dTY1dzSHo3N21mQVRiNVVPeEIrM3gyVGI3?=
 =?utf-8?B?YlE2dEl2a0ppZUd5V3BvNWY4VS81cFNmOEFKbTBxaTJJcVZ3c2wzVkpFR3lK?=
 =?utf-8?B?SGZMbmxkRGtTdTYxdVRnZmk5ZWpqY3p5KzFiOWl6QXFJeFRIUExpREtRQ3Zy?=
 =?utf-8?B?TURpSGNuRTF6U2NUcHBlODh5TzgzMlByVnU0SjZRb3JmSlZsQ0dTRzBRSlQ4?=
 =?utf-8?B?dVZMRWZPblA0N0cveWxaUTVhb0ZaVzVQVzRPdkh2aExmV2hHeWhqUklCaWNr?=
 =?utf-8?B?L01Mc2ZidHh1R2Y5Z09YWWxHWTlDVVRTanRDcFZkREFhN2EveXFXM0h1QUJh?=
 =?utf-8?B?a3lzVmhETDI2YzBNZHFBbDNiWWw4eWhRREo3WHlnb3ZScGszOTUwZDRpMEJM?=
 =?utf-8?B?cjZMSkprTnZTeG5zcnpHR2ptQXplNlRML3V4dFJqa3l0QUFBQjk1eW1LbDRV?=
 =?utf-8?B?MHdKZUNZemFuVy9IMTRBeU9jS0lEcjRTeXBudzhkd0FHOHBJcktndHB2Smd3?=
 =?utf-8?B?ek9QMTkzby9mSlJ5SkRKL2UrYkN1NGRJNXE5ZkMzanlxODdLVlZYeGphaEJB?=
 =?utf-8?B?SGZ0eWN1ckFZL1p5OC95UlBCOTlFWFJtYlo5QTBmUmVTQzZMVytGbFlMbWdm?=
 =?utf-8?B?RzZEalBkVmJJeXZ3Z2MrRjZ3UW5FL0ZycWdzdUw5K0kzRlZ3VXZEK1hOSXAz?=
 =?utf-8?B?bXJRY0V4c0xySk1nQ0FRL0d5dWc2bVVzSmdOUmc2TFAveDNwOVRIRENWazBM?=
 =?utf-8?B?eENobnpwSnNuZGFmN25uV2xEU1BtZjBJcWtsNXF3eFF0U2JBR1JVMnJOU1FN?=
 =?utf-8?B?SkhHZVJrcWhBZXNsT281TkZYRjVnaWkwczZoSE9jeHpRcS9Pd09JeTNMcEh5?=
 =?utf-8?B?cW94RHowZE9nQ2Nqb3VyVUVTNTVQbkVOc1R5NkJ6cTRlRnJPSm1vRDlvdVdY?=
 =?utf-8?B?amtoeEJPQWdNMm5sSk9QOUJOQnFEZEkyOGZaeG9JRnFMTGZvM0EyS0ovcnNa?=
 =?utf-8?B?OUpoRkxFUkpFWDVWNVFYZGtOSVdyUjNMbTRCUTRKajBPMkRsOUZJY2pjb2tY?=
 =?utf-8?B?UlRkSm9XVHVNZGwraTRKR1lCelIrd05zR3YwaExMV2JpY1lDaytUOVF1SXFn?=
 =?utf-8?B?TUQ1NWI3cFo1emFnMDIrUTBzS0hKRVRmc0N4eWY0cEVDclVrdW1Qa0lWSEhH?=
 =?utf-8?B?QTNDTElDN013ZGx6MzVCUVBiUk5oWjJ0NlhhS2paOXBacTFmQUJLZHdCanZn?=
 =?utf-8?B?YkxPWFVrSjJNaExyYmphMlNxcWh5aEZPYmIyWU1TdkZXZEVsY2VHSFYyWE9h?=
 =?utf-8?B?M0kwbTZGUmhXeVNDNlNhbGNFajdybGM1YW5HMnFtK042UFc5Z2VZZ0trcjBN?=
 =?utf-8?B?VHlVOFFUNW5vVGI3WlBNeGcrcjhvcE1CaVQ1UkUrK1Nkd0s4N2EwUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4035a4bc-393b-4da0-347e-08debbde2536
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:53:11.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwm0c5U71Pv+KTyM2KiOBXVe4GTW9cxxyQoR0Y4v/88MdY1ohzRPcTQbw1nIAMhtcCqRqL3P9HpPzTlJFMZNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2570

On Wed May 27, 2026 at 11:08 AM BST, Miguel Ojeda wrote:
> On Tue, May 26, 2026 at 6:13=E2=80=AFPM Heiko Carstens <hca@linux.ibm.com=
> wrote:
>>
>> An Ack from you would be appreciated, even though you made it already
>> clear that this series looks ok.
>
> I did a quick `LLVM=3D1` test and booted it in QEMU. That worked and I
> could see the KUnit tests, though we get the:
>
>   warning: unstable feature specified for `-Ctarget-feature`: `backchain`
>
> But I assume you are OK with that for now (and if you are, then
> avoiding a custom target is worth it, I would say).
>
> I also found a couple bits: in a KASAN build, I got [1] -- Cc'ing
> Boqun in case he is interested:
>
>   [    5.323670] ok 5 rust_allocator
>   [    5.324134]     KTAP version 1
>   [    5.324194]     # Subtest: rust_atomics
>   [    5.324251]     # speed: normal
>   [    5.324367]     1..8
>   [    5.332184]     # atomic_basic_tests.speed: normal
>   [    5.332356]     ok 1 atomic_basic_tests
>   [    5.340797]     # atomic_acquire_release_tests.speed: normal
>   [    5.341054]     ok 2 atomic_acquire_release_tests
>   [    5.344127]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [    5.344584] BUG: KASAN: stack-out-of-bounds in
> rust_helper_atomic_i8_xchg+0xb2/0xc0
>   [    5.345283] Read of size 4 at addr 001bff7ffdbefcf0 by task
> kunit_try_catch/142
>   [    5.345493]
>   [    5.346499] CPU: 2 UID: 0 PID: 142 Comm: kunit_try_catch Tainted:
> G                 N  7.1.0-rc4-00009-g60c6b4b89923 #10 PREEMPTLAZY
>   [    5.347065] Tainted: [N]=3DTEST
>   [    5.347124] Hardware name: QEMU 8561 QEMU (KVM/Linux)
>   [    5.347323] Call Trace:
>   [    5.347408]  [<001bfffffcb9c6b0>] dump_stack_lvl+0x80/0xa0
>   [    5.347663]  [<001bfffffcb90846>] print_report+0xd6/0x310
>   [    5.347784]  [<001bfffffd596e08>] kasan_report+0xe8/0x110
>   [    5.347895]  [<001bfffffde5a042>] rust_helper_atomic_i8_xchg+0xb2/0x=
c0
>   [    5.347983]  [<001bfffffde917fe>]
> _RNvNtNtNtNtCseBLeUu9QniM_6kernel4sync6atomic9predefine5tests36kunit_rust=
_wrapper_atomic_xchg_tests+0x5be/0x4f90
>   [    5.348088]  [<001bfffffdf59e50>] kunit_try_run_case+0x150/0x3d0
>   [    5.348194]  [<001bfffffdf60500>]
> kunit_generic_run_threadfn_adapter+0x90/0x130
>   [    5.348257]  [<001bfffffccf9fde>] kthread+0x33e/0x410
>   [    5.348309]  [<001bfffffcba122e>] __ret_from_fork+0x9e/0x3c0
>   [    5.348357]  [<001bfffffec96faa>] ret_from_fork+0xa/0x30

Looking at the functions and the test case I don't understand how this coul=
d
happen. Could be a miscompilation?

Perhaps it'll be useful to provide rustc and Clang/LLVM versions so it can =
be
investigated.

>   [    5.348531]
>   [    5.349184]
>   [    5.349261] The buggy address belongs to a vmalloc virtual mapping
>   [    5.349620] The buggy address belongs to the physical page:
>   [    5.350145] page: refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x791f
>   [    5.350563] flags: 0x1ffff00000000000(node=3D0|zone=3D0|lastcpupid=
=3D0x1ffff)
>   [    5.351563] raw: 1ffff00000000000 0000000000000000
> 001b913b001e47c8 0000000000000000
>   [    5.351694] raw: 0000000000000000 0000000000000000
> ffffffff00000001 0000000000000000
>   [    5.351808] page dumped because: kasan: bad access detected
>   [    5.351912]
>   [    5.351989] Memory state around the buggy address:
>   [    5.352240]  001bff7ffdbefb80: f2 f2 f8 f8 f8 f8 f8 f8 f2 f2 f2
> f2 f8 f2 f2 f2
>   [    5.352338]  001bff7ffdbefc00: f8 f2 f2 f2 f8 f8 f2 f2 f8 f2 f2
> f2 f8 f8 f8 f8
>   [    5.352428] >001bff7ffdbefc80: f8 f8 f2 f2 f2 f2 f8 f2 f2 f2 f8
> f2 f2 f2 01 f3
>   [    5.352553]                                                         =
     ^
>   [    5.352762]  001bff7ffdbefd00: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00
>   [    5.352862]  001bff7ffdbefd80: 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00
>   [    5.352976]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I also tried a GCC one without KASAN/KUnit, and got:
>
>   error[E0425]: cannot find function `memchr` in crate `bindings`
>        --> rust/kernel/str.rs:857:38
>         |
>     857 |         let ptr =3D unsafe {
> bindings::memchr(buf.as_ptr().cast(), 0, f.bytes_written() - 1) };
>         |                                      ^^^^^^
>         |
>        ::: rust/bindings/bindings_generated.rs:20572:5
>         |
>   20572 |     pub fn memcmp(s1: *const ffi::c_void, s2: *const
> ffi::c_void, n: usize) -> ffi::c_int;
>         |     -----------------------------------------------------------=
---------------------------
> similarly named function `memcmp` defined here
>         |
>
> So we likely want a Rust helper here in `rust/helpers/`.

#if !defined(CONFIG_KASAN) && !defined(CONFIG_KMSAN)
#define __HAVE_ARCH_MEMCHR	/* inline & arch function */

So it looks like you're either going to hit the sanitizer, or the build err=
or :)

Best,
Gary

>
> Up to you which configs you want to support initially and how clean
> you want everything to be, of course, so:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> I hope this helps!
>
> Cheers,
> Miguel


