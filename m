Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810436F8E9;
	Thu, 28 May 2026 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977677; cv=fail; b=e2R9b/3C8jaaH4p4Sf9LyW87ozJ6qoW4FGb/DencC5/Fo7o6pv1egWLuk4Ny5/5P8aclgHlNp/KidQ27Ry+NWFzZg1Z7LmUuqenPv62j5enQ1J8KQzyl5QpoVgtsXNFRcH5gopucfxnVxDOVEAEhm6GrulZK8uviXICue/0OK60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977677; c=relaxed/simple;
	bh=PJt6RFUohs3KcFBfF9BLR/UgOdkjm6A8ssp5984qihg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MUpkl8CFBjb4989Dzfdb1CpSqs7Uwg+9PQI1osOnsWwYvehI7oIJDECw8w53jnY3wLneJDaeF6uMdLFb2vZ2hOjSlKm6IQ1fOwXLXAbTCWWmHLrwSsLHrRSvPInjB7LxnVHOP7mwo0dmGQy9pv+H2tcWXe0FxDZgNPbjiEoVxrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=q6vYmmtu; arc=fail smtp.client-ip=52.101.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="q6vYmmtu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWmbR1h2wvrMLg6JC7Tvi5jU+TRLAMRsDqPZodDtXIU3Vul67oikOqa0YAEGs8YxcKqxWzk6Mc1sI7enloq3bEVpi42qUsgv2OvHpyMR1/I+C+07Jm8LLdYr+EKGYvhBKsTVyeb/aBGKzQX3o0P4vrOygfKtd7eEYiiBW+vlpEbKeJu5GFEv+dErXINZpBjMPd/mMOcB2tt5yO/H5fcd/ELo4SZIp00lGQgPRcH17mZ67yDCA9RG8INTkcbrdoN84qgH6CbXTMfWtYp9EePRb5v1MdeqLdj8+cjo3ZKjCViEM9az5QnKJvmCe8YMdlcgg3Jdv3qNgarOxcfe2JAIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8liK4269H3ApEO5jwCBzTO6llSqemJ3RNoDqNaysWfg=;
 b=YCNtBTdMmPnAJohIBLId0n1Kp7mIyv44Zt58xudWQQ7uFPR6dXKjog42fl4Zpsol0FnUu653tPuja4/V3pBpKmtOL03Mpe8lBKXEzzVnQBswEHwyw6C5RWdbvQonEbunM3TRGiwy6RFEy2W1/C3wIoctB9LFL1dJCmzyo8NCzzDQdcDTIPCV25WpLZOnoeRVeCdIJsydTjE2ngYM4t9YcBTfoZt978MeVHx6KYxNBYuBd9QMFj3zAlo2Bzc9f2vKWM8qb8y7q5MNJQ+jdg2HIWWT1P/fxGmDi16x+I2yteNEDtpAhQMxTdCZrfoSVukRinBfT1ITUahdKPM17EVH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8liK4269H3ApEO5jwCBzTO6llSqemJ3RNoDqNaysWfg=;
 b=q6vYmmtukGRsnoGrzmndOTtyKqOvymgN9/FBtSaPdIlsw2O98D1vau3108PVS1fnwcR/2zFNDV1f0xGD8UBtMTRZn9WxNOnizlI+f4MpdJb5t2W1Q6f4c9RmegwvoTYtgPHNUCYtH1uYEWYSpm9Vg88o+LDYJ/P30Qd79W1SfK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7605.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:14:31 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:14:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 15:14:29 +0100
Message-Id: <DIUDF8QHISMW.3JL1TE1G7VBQQ@garyguo.net>
Cc: <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Boqun Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
 <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <ahhLT-fFx2lUi_FV@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <ahhLT-fFx2lUi_FV@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-ClientProxiedBy: LO4P123CA0465.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ceaff5-f4b8-441e-4a6a-08debcc36ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xtG2ssKSkiao8E0fx7d57kAeei3A2gCh2B6J6YHYSBbDcYUmwlk5eYevL+Pu7isCI3MHdDb0/swPFg+Q8Cycq6eWkXq7wPsOXNUuf23pqdQgzoN2Mw/y/fBLSAFBACcNVE6CjNAw+FX+p8j4ezRexfw31u7H/Z7aW+0/PvR6pDrzk5EmG2fFJCY9AQkJXx+hXQWv0JuVg8WMLNQSZW4S3hQJuIhqTDAtdoRF+Dr/EjU2WuI/O+35b4VqFPfRaiZUMUm/xiWQHCDyU5RAITyqH7XsoxgrvF3YRbczpNxHcxskCmLLejANRTb/OE+rEkAvuW8BR+GdB3eRhjipu4wdN/RGrqLqYfHiGS0yT62wuWos49s/rFBy2knG+5PfLJ1w5+aDFgYPAVcJxjUdue+k7idKejECxJKpCAdcKSavUqqIwt+vsoTNu6IyOyZRUMYVf0MoO1KYC/kj1xXqdu/1GTgmLWGPH2n1rhpgVw9dVViCi86DhnuXGmwh1rIU9qSeHmFj7zWtqQFAHCNUfN6Ot9puhnAF957sHhNhLeWedPD49FTvgb4lxGq6euaHOs59YOsFJjISlRwsliKQWafLTE/QZIV2V/vClXHrooEcAAo1WFEE5hyDh3xm0t923htA5pnj8QdvuDb5ZcnuPm1KLmxLAZo3rLnkgNY9hSV9o2zSFHbc89vNlHMezlWXLAfK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDhCNXFmOGJ3NW80elBkU0Vaa0IrS2VKL1YxYysyQUo4NmJRQWo5YVY2aFlt?=
 =?utf-8?B?ZTFvdHU1b0VuQUJZWlN3R1BWWmRIK3E3MVNGdzByU1lWVzBMSDIwNXQ1cFNi?=
 =?utf-8?B?MS9BZWdOek5TdGh4WEFwb0RPa3M2Q1FuOTUyeWQ5OXRTWlVCeXRuTzdLQjdz?=
 =?utf-8?B?SWZWb0s5U0pKMTc0UTRiZVVVL2NMeVFpUDU0aDJMOGRuRW90dWNCTGtSOGpu?=
 =?utf-8?B?bTBad29oNFE2ZC9yYWRsMWtPZmdJaDBpME50YlFPaUJ4VWFvTzRWNjZTVktj?=
 =?utf-8?B?Y0J6dHg0OXg5ZzdQSlBOTHVkeUtibkZaL3htL2dXVGJ4WVlLb01wWElyTklD?=
 =?utf-8?B?Mk9LZDRDL0hjODFtRE8rajlKTTNVUUZMNU1IM3U3VjB2WnRmYkJqVGwrMzQ0?=
 =?utf-8?B?ZVR1RjJYajA0NGlCWDY0ZkIzQ1d5NjFLcmVXQTJwWlBZa3VIZmY5NERCaUda?=
 =?utf-8?B?ZlVRYkN6N1ZyajVvMWxNdUIwR0M2eTlPbE1lYjZZMTRETHpodFUrSWRLYWxw?=
 =?utf-8?B?R01JREd6Y0w5cUhNeUlVTHFraXdLMVlhRjBCcGVuZ24xWS9XSldudm14OGMz?=
 =?utf-8?B?RGMxUDAxaGlCQUEvTnF5TzQ5bXBmQXVGUm1VSWs1OE1uUlBnVVNycEVua3BX?=
 =?utf-8?B?Vm9mUXdtZVc2T1BYbEdRTGN5b0hlRDZDOXhJUVVzZVc2Ymdob3laWThvS2RN?=
 =?utf-8?B?RklnMis5UlBnRlFsaGZONkU1RTlUV0R1a2szWWFrek1PdGtpNml2Vys0NDRR?=
 =?utf-8?B?T21CRStHWXBLa2JHNDZ1TmRxTHpUSG9MNUxocDd4YnF2S211alhYZDZQRjUw?=
 =?utf-8?B?U2V5V2phNHZzT2JzYnJFYjlmekJnUGNxTjlnTFpMYVhSS3hTMkdNR0FQRjFy?=
 =?utf-8?B?ejVJK3VvNmtySS9vckZTNlZ3Q2ZmMWt6Z3VZLzBvdmV4d0ZxbmFMY3hYWFFq?=
 =?utf-8?B?NlV4Y3V5NGc1Y1p0Y3NISzkrV2ZCR0J2WnZjTzk3WkwzUHZtSHd5UU9zS2Ft?=
 =?utf-8?B?UlJpdGVIRDB3K0E1dlZlT3NUMTJTVTRyeTNocVdOZUtVS1BwcEZkVUdPUHZu?=
 =?utf-8?B?VHlqT0FSTnVkbjhxNHdlUTZSc003clZDVWQ0djRQNEY5K0lpM21IZmhiR3Ry?=
 =?utf-8?B?N1dYaEoxSExWUUYvN1Nrc1JHZW92UUdBWXR4SjFHeFA4ZUNVc2FzVUhmV1gv?=
 =?utf-8?B?K09VNDlPUmxxeDZ6TDlGVG1PNkpjbVY0L2xaMWNnR1VzeEw1UjNQeWVsOEgy?=
 =?utf-8?B?UlBMeEUvQzJjSjNsWkc4ZUY3TmZxcjI0ZHVzZk1CQ0llZTJzVUpZaW5tQWxI?=
 =?utf-8?B?RWQ1SUJVYkhJUGhPM08wbFJPTXYxbmZzblk5OEpkOHhLSExhYnJqM2pSNGFq?=
 =?utf-8?B?YVBXT3dtV290YkpDS3dkSUR4Ymp2WGtWbUhSUDd1aW13cHMvZzlpN09BaXFM?=
 =?utf-8?B?eGhvSTY1QkFUVXA5MFVkRzNtbkN1ZVdFdE9tYWVGZUtNOTNFTHVvOWhuclNM?=
 =?utf-8?B?cDcveDJlTXhtOWtpSE1uNDNaSi9iTTVFeWtEZ2Q1b3hKVE5VVzRNMG9qN1RE?=
 =?utf-8?B?S0d3bCtzd2U4UTNsNkZ2UUE0WlBla0tBOCtkU0pRL0RnS3VQck1xNExqRkJh?=
 =?utf-8?B?cjBBczZwVDRDcU84TFExczR1ZU1GQXZlVnNNbkpKNkRNQWg0SHJ1bDlmRVRz?=
 =?utf-8?B?dC9tS1h4QzU0WEtTUzFTTnhTSmdUdnpYVXVSbU1UejA5SWR1SlA2ZnlYRzVG?=
 =?utf-8?B?ckFGRHN3ak1hVjVnYmxaUUp1U0xmRi81WjEzeFk5TC8yRUZnRFVFeHJWSXBx?=
 =?utf-8?B?YWYwVnlNSHdqRXdRM29POENHZGNzUzdnQjBBWklFSDN4Y3pNc0pReG0wV3dm?=
 =?utf-8?B?WDZGRWtFcXZTT0hzWWFGOWphMUhjYjR3Q0I5RndOdGkzcFRBWW4rejFkRXMx?=
 =?utf-8?B?Z0NUT0FvU2VYc255c21MSVpWWm1qTXRWNHFlcUFldnFvdDdxMlN4MDQrVXZp?=
 =?utf-8?B?eFlDNW9ud0x1SGdWYTRwMm5jUlQrQ3NoN1NqQmNvbEMyejliNDUrUWxvbnQ0?=
 =?utf-8?B?QjByaGlLVmlkZmFCdUdsSGJqU0wzR2pZYXFXQ1lwZ3lEellIdzRLcW80bVpW?=
 =?utf-8?B?REJUR3ZaSmVjSUtwalZyc1RMMnRzNEZubDVLSGpCU0s5QkFPa1BsSm5WbmdL?=
 =?utf-8?B?SFhTSTZmMWI1N0hSbEFCclhrYjVkeUFzNUc5NVNQUWNlSENDV3dxZVM5ZUpL?=
 =?utf-8?B?VUsrSzgvRy9kU09LdGRDdGJoN1p5dlN0K2c0S3RFT3ZyMGlzdzZubGlxd2Vv?=
 =?utf-8?B?ZGEyUUZCNmhSQVAvZlhITU5jcGdqNi9NT2x3ZnlqS1FyQlplQmtjdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ceaff5-f4b8-441e-4a6a-08debcc36ef9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:14:30.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p+ofBVNYuAj+Dhlc2+domMcpx4iXvh2Aj/WZppVe1KOCCaKwumonMDc5IYDaJhuI9zdn2f6KG1pB6HSdjZfWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7605

On Thu May 28, 2026 at 3:03 PM BST, Jan Polensky wrote:
> On Wed, May 27, 2026 at 12:08:38PM +0200, Miguel Ojeda wrote:
>> On Tue, May 26, 2026 at 6:13=E2=80=AFPM Heiko Carstens <hca@linux.ibm.co=
m> wrote:
>> >
>> > An Ack from you would be appreciated, even though you made it already
>> > clear that this series looks ok.
>>
> [snip]
>> similarly named function `memcmp` defined here
>>         |
>>
>> So we likely want a Rust helper here in `rust/helpers/`.
>>
>> Up to you which configs you want to support initially and how clean
>> you want everything to be, of course, so:
>>
>> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>>
>> I hope this helps!
>>
>> Cheers,
>> Miguel
> Hi Miguel,
>
> thanks a lot for testing and for the Ack.
>
> The backchain warning is known. The KASAN report around the 1/2-byte
> xchg emulation and the missing memchr in some configurations look like
> separate follow-up patches rather than issues in this series, and I
> plan to address them separately.
>
> Best regards,
> Jan

The memchr problem is something that need to be addressed in the series, be=
cause
by introducing s390 into a mix you're turning a function that was previousl=
y
always externed to something that cna be `static inline` and need helpers.

KASAN fix can go separately.

Best,
Gary
