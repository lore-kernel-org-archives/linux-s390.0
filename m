Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020130.outbound.protection.outlook.com [52.101.195.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EB3FCB29;
	Wed, 27 May 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882859; cv=fail; b=q750LZxDmvKDnWktF4hr/8bnLCC1VxoaCi6yVV4hePuYEbYI98GBzo8jmDCIrUySmePR7DYpAujpxe7baGLFOopeSq0Ofgm2kLkxk117KysZ8/8M3wgmztpspWaIWE6jZV28hSEsZDL482u4CPXOYiJCHacAhGRaRPKmkadgjaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882859; c=relaxed/simple;
	bh=7Wo7uqyzueAAmQaR6AmW+5uhxoHJ/rOJAW8/LbeX4Kk=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Ij9D+UQOdt556Uk5Htsi4KT2c5hjuLIUDb5NRNr4V4ETvIXs/tCMX8BZKD41FgPbfiwRDI2SUmUe1laTPRt348+aRNOWoKSyVIOeoRrNQPpCWlJeDrJIqogwyOxjSwukW0YBhgSa6YX5VsRZxZkqXqESxNgVwrSBLcbw1UNxFPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fpPkcfLb; arc=fail smtp.client-ip=52.101.195.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fpPkcfLb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtlQwigogwnz2SCIc3CGCqmChA9AvVVuDRySy0OQ+TpvywKGXoTFQDxPSLSQCekmUzu4q8mYRG9Mr0BzQKjCCUXheApkNPPuwkQiaxWsPEnPXk54XKGUYs0BgGBfgsc7oLXS6scJSGLPda8b82O2nJG5+zN6CS/eHz80lrrue3scyipX86y6m5sIqhtzCRkmxoSr/FdsvW4QID1eJv3oD5wEjSXJQjsv4S7B8o05XIzKPU//aYqwnlRAA/6NMJr9DlzEgYpp8VxXE9OfVQmgNOTDQPKtJ1EZ3MhDc0QG9XIrBRc6eH8pjBSRlqapaX/+MpIN80ezjizNoIfWBy1iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMAnj1o5Zf+X07LvE5pqjrOih95c44ksN7XyBgezMRA=;
 b=jvZYNsybQy3d59eNAg9xZB7KQqFlSsXvP9FB7XjsWcDOwJRxZIQfbvlnSPda9I8+GSmE/wTPyaOE/qZItDfRpiP+FwWGcEHKxPaiQdPGPyB+cUvmmsTQKlPzoR6I/QwNzeDfgdB4+iNXyoqDHU7X0soN2itzQbZCt3atpyAF3PPO/tid+LLIqFHpbbmO/lTUPA3vZYn9ZAobaNaTiGldlekRDwRSV7Q/tJXd2BqTmopvjVN1wtZAC9bOxWJIwPCa72JDa3DJ7R4w71qcSrGrHEXv8VMIzBbr9Sof2577sF/3cDyDbEA1LxLNFEvW0p3CmK2dc0KmOdPB04btcOMKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMAnj1o5Zf+X07LvE5pqjrOih95c44ksN7XyBgezMRA=;
 b=fpPkcfLbHetp+AsEjEOAXAmd1cZCY8NrdBFyL5sDlFj0MCX6VfDoBkSUm2uNV67vLFg4uCo730dtfEjslTZWoVE7+MTHhWfSSZj5VQXXvEcVZ9MVAcaGxbme/apygQ/9Oh4s+0iFSTq6ApJZXWRwFNlCP/GXQfRoU1bklXlNU/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2764.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:54:14 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:54:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 12:54:13 +0100
Message-Id: <DITFTAVVHTNQ.380OHUHGTOI6M@garyguo.net>
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
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2764:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a71afa-931f-4977-8183-08debbe6ac4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	V8HMg7OT0PzQwDnB1DkfGTVVA4bCFI0up9DNsA0YVEaxqGMhlpEIXek6zw9n9ZVTGiUwwnxUh+dezIwNd9TFdsX1aq3e+NEe8sXsufZXutvRXyplk5G9kBD4j30YsP2DIqfVnljScCnrfqTMUD+REtEK/7FOI5pXVsgYolePlcV8B3fo/oTwgekjLd6z0WAraPkML4yurR2Xy9OoVCe2uXddd/NGTnBZECoqr3AZPg4XdI9i1VxP3VjAL+jxALGLLL2ktuc+i8Gn3dVeYrCxgP2vPM+ett7rZPNRTuH9Gabwy8ABfmlAXutXPD9uX+3it6KKVgdEcxkB5gQe/CV4tGX7o3DBQFgfiJ3OuARkl4okuK3U4Qjxi8N4PMQJTnOvxbw6WK3f8g2vkIeh8CiVowMt92xx/P0tmncf9nsQDJ3uXFZcXqPA9YcjXx7Zk3m60X3xx1KTBL8XFFeZt6cZZt23cLwgFe/MKTvSsUn5jA53uSzccT+bOBPC8PDB/hhsF0M5etZ48SN+OIyXW1DJDMQGmywEpP2S07Nf80Qnaxd+SzaIe7LBAu3QL5QEK91l3uG8BuHHCSMRwGYbF+L+poiFK83L+Jsya2lIIV+ezyZw/E5BEf155l6wdHFl+zLwSMX2EKYr4SrDukvaxb86dyYHP8edoZQZvbeYnnmLCVvrhOQEfHTbUiQF1Z6D4nc9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2oxM3hGNEo1aUkrVmhMTjVwR2c0K2traWtUemNMelQ0WUJrMXZubkgxcXZ5?=
 =?utf-8?B?MkVZZ0NyVTlFMEgvTEhFSGtmSVFvKzNCcU5OZ0ZjZGp6NmxVNUJ1bnI4ejA4?=
 =?utf-8?B?MGl3QVNqeldQRWZIbWU0UzdBZU5CcHY2aXc5SlpBRXpiazZDazhvTWtJeTk1?=
 =?utf-8?B?dk0yVzdvcDZ2eHlRczRNUkhmV1pkOGErT3lPRW5ncS9WNVFVaTRDc3kyTjN6?=
 =?utf-8?B?M3N3alY3Rmx6cURsSmF3YmFNbW5BZnRSak80Qk5TcHpDZzRhMkVKc0lHbmhF?=
 =?utf-8?B?UUZBV0Z3alF3aWxvUG9mTEt5ZVV2VllsRUl4cHBQZWJ5cFlHUFdDa0ZhbE84?=
 =?utf-8?B?N094dUxsbTFtdlVkTzMyQ0VLRUJpV0dnTHR2c0tPajF4TElicVpRY2tGS2dX?=
 =?utf-8?B?S2JWNys1L25ydWFQaXF3MmF4bnJ5UEI3RzY2dDVKVEJxSk92TVh3STRhUER4?=
 =?utf-8?B?ZTV5R0hia1VGSUxYdzI4TGYySURWelJEVmJoRTRWS3lqN1VHQXM2c1I1SDk5?=
 =?utf-8?B?aDdET2ltbWI1VnBFUXlOZUNJQmF3Nkh6Z0VTWDJ5MmEwNVI0bUVlUk1nbytn?=
 =?utf-8?B?Y1hLakhlYU1uSllxOC82VWFKV3hRbWxmcjUyN1NWZGRlVEF5UlBYNDRheWQr?=
 =?utf-8?B?QjJ3eVFiZnBOUnRCYmpQWThaajMxbXN5UldrN2xacUUrOWptNmJKVktlYUhV?=
 =?utf-8?B?alVTYjE0SjV4b3hueVpjSkVwa0JLZjk5N0xVZ0dhT2xRK2ljbmlsdHpka1dZ?=
 =?utf-8?B?M281OVREZzRhSUJoVHBBeGd3UmtwL3ZuR0ZILzN5UUYyckRMUCsveGZ1MjA1?=
 =?utf-8?B?c3JHMEJSZXFXQ25GYkhTNFJ1eEgzYVV1YVlkN0ZsTm1KQW5pcEJMVFNtTlJo?=
 =?utf-8?B?Uy83c1pORHp1MHh3SFU5a0pVeDFlT1BQMHNVWVA5YmJRa2ZQbkRyMkt2OEVE?=
 =?utf-8?B?L2ZNdlR4bSt4eGt5REV0OUJZNHpWSnZGaC9qWmh4RFJBVEI3NU5ITkIrOU9D?=
 =?utf-8?B?M0hoYzZuZHJFY043ejZMK05aZm44RDJ6Sjd6NWVIb1N0ZkdBMkFJM3BKSkVZ?=
 =?utf-8?B?RDIrVHczdis2R3Mrek8yS0ZnSVQ1S3BJdHlHNU9kTm1NdVNQdlJIbUlPMVhT?=
 =?utf-8?B?Y2R3MFF0V1g2Uk9ZUVhFazhHTVVFOGRwbStUQXA2djY3SHNPNTRpeFRUT1M2?=
 =?utf-8?B?MlE2SGJiaTJDU2tLWTNXcHQrVEtrSHo4STljV2J1N3dPdkJXQUtzc05tZVlw?=
 =?utf-8?B?ajMvZG5RQnBwdmZldVZXT1hvMjdQemRwOTdGdWdaREFIWkd2ZlIvZWI3M1BI?=
 =?utf-8?B?TklqdW5WMEMvcDRKTW9IWWo2cVFMNHZ5UU9YZ2h5OGhDL0QyRHpObTM1NHA4?=
 =?utf-8?B?V0FwMGxsbkZITHgwOG0wWVFra3ZpWGd6TGtZcnNubFBXR3FWbTJTKzlLS2V3?=
 =?utf-8?B?aGxSNURNTEVVVDdOdWNFYUZCRGxtdnNkNmx5b3JqR3N6Z01abmpiVEhLMlRI?=
 =?utf-8?B?Q1I0eE9JMDV2RXpzRmZ5RjFGbmNFQVRrejA3bGJqTFM3RGphRVpNdExPbU9l?=
 =?utf-8?B?Nkw3UUt6TkcyQ1I3YlZnRENOTGxiWFphUWlLSmo0cXFZQ1Y1TXA1aWJwOWFx?=
 =?utf-8?B?NkNGZ0xJSmo2cmlWYkxXQlMzdjhxUVc1LytLUlBKZG1hOXI0VGRzaUo2L0p6?=
 =?utf-8?B?QW9YWjdOMnFMNm40K01NT1BpOHhwRmlyQVZpcGlSM2Y5WTBmYTR1bFlHN0I2?=
 =?utf-8?B?c1NHaXArdmNvcUNlZWF4b3Fyb0VxMGxoYURrZzRwRDF5bGs5TUppb0VCWHIx?=
 =?utf-8?B?N21WK2NWZTBSOTJ3aUZtU21jeStDdVU2TFdQOUZUVmdOUGpuRHF4Nk1Qc3Vy?=
 =?utf-8?B?K3piK1BMWlBDN3o4NVBmTFpQaXphODUwZU9FMHVhNGE5SUcvS25ZbHI0Tklq?=
 =?utf-8?B?cnBpUlc5MS9xS0Zld1M0UUZieTBIN1hheUJrMFFoSmFlM09tOXNNVTNBbWYy?=
 =?utf-8?B?eEhGeEp3djhKQ1lPKzdtVk83UHRvZXluRVVMOW9RNU5OZ3A3Qnl6VzNrK1Y0?=
 =?utf-8?B?K1dCNjZqaUFhNGdOZlBwRXNhL2pFeTd4bzZVcGM5SFZlR0EwdmVlOUZKRFVD?=
 =?utf-8?B?eElKYk4zTnRMZnVDTmhnRk16NnZoWnZidzIzMkw2UVFPNTNoSHlncDZ4emk2?=
 =?utf-8?B?TXp2T1h4aG40dmZqUGdZeG9aV1Z5RG5maW9rQTZaMVZvM1RITHVJUkZ2Y2tt?=
 =?utf-8?B?MU9ycFM4cy9XTWs1eUR2anN5ZjJGSndMVmFaUzZibDFuclJ1U0pMVzVCaWJr?=
 =?utf-8?B?Y1ppUnhxMEkvRDgrekJNdU1Cck1weWhDeVdKRVYxcXF5SUtFSjlPUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a71afa-931f-4977-8183-08debbe6ac4b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:54:14.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoJmgcvfJN9autDPLN0U8BQCZLXBy4hocmf5bbmUOAD2UsnC+uUoUM4Kt36mkDCR+FLluYsG4FRjqoNsxeiOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2764

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

The issue looks like an incorrect implementation of __arch_xchg1 and
__arch_xchg2 for s390. The `READ_ONCE` (and subsequent cmpxchg) causes a 4-=
byte
operations when only 1-byte can be touched.

The functions should either be re-implemented in assembly, or be marked as
__no_sanitize_or_inline.

Best,
Gary
