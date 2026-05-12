Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020118.outbound.protection.outlook.com [52.101.196.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250B3B1ED6;
	Tue, 12 May 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595711; cv=fail; b=KF58DX4fsricNgjseewYATfgM7UqLHIETyXH8Y5s+OQ2dZNjLusoiUbhrbqKnl+mBsFRhiBmIBmVr08SwQfrcgkDGhAijh+H3LiZv6EgMZbl0AwGirPKxHEh6ubunUtAlr6Zfz2tM9faSg5jG0TqRBxg3un8Vjp76ofZoMoIXlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595711; c=relaxed/simple;
	bh=MPFp+JPMEhiKwGBq154tJ6ro5h8rPV097gxGQFyrblk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WW5I+vRXRD71dysg3cDihv0XRY145CQ8iV3C1jP9w7Kmiekv6PDAfqjZBkAYpDpMGgTi/fu01aaiioVw/dzmKe918LbWng9Tv6p6hDisDANqorR2m7J5KpprV4zvfzV4csmWzhSiKoFoWyVWKtX/6JoUAgkmunTrCqjBA7I/tH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RWs84Hbv; arc=fail smtp.client-ip=52.101.196.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RWs84Hbv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EP2k8DjyxaZjY66L6X88UdK9Y9J0KFF55bpVVOsyJyCIjdBi+v9iZ4I+HpQ2dAos+ktnxpqALP6LyPl31RzENUa6HGsQ/K4Su4pgZwGo3qvsMCqN43gkpJy0VKed82hTvH4dhwCIW1pb/WSAkfj5GiuSNObcn4IZxKN6Y+aIdepf5Ft2hJd/hC5Ufy4MkDWJWMOhX7msdMTUWTo+311Kag6nNZbSFGRUAdciOLvYcm7FVXqG9c+cAmh9en9OGPWDLStDl1ENwZrZMFJdaCbbZtd2wydcE1Qu1OV+cp7PoMEfTmEKAhmoXDGgikBcTIVOwg89E+F16SdVNS36zBL48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d2clI3WFtEVxJNGYLb+kwxs19vVpu03YZoQ4e/r3G4=;
 b=zI66CRIOL+yV6NALsAEbkoajRP882hNT5IEjp4W/lgT7RneiBhUOzMnfuyWm50ZSFA87f8O9AhyOusHC1AAxslU1Py6uNhcAJuGWI9INbjnaF9TXd+VbLB5wvSMtCgXkLjqJtQ6c+owP66y9hIxxEPUUYSU7AM+i4ZRfrZUzkx6QkoczuR53A+stK0Vz4/HxenUsBVOHKh1O2x/6zDzX3MM3zcryLAKLmplsvBtifJl4zHMhEAEg04UZX/WuOjxrCJD7PUCHpe2RyKZfLpDeHJqq/soZchpDDYwcGR8r2IwrpzEyiTrhNh/8bQXw1VeVXfh+4gRw/NuONGhaUX3zNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d2clI3WFtEVxJNGYLb+kwxs19vVpu03YZoQ4e/r3G4=;
 b=RWs84HbviQCVuvMSCDsYG8btYw9pgyXrRfSqIl48MGdxaZL2yfGr2YUvdRWgNdj75gUUwH7f4eJCZzANUnboKSweBD8VvGFILJOSaFu84Pb4rYb2n/N7kW7ZRwKZ4FhWZuanZSX303t3uIB+dpsHVWtRM0lBgn/4kh4XBs92mLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5407.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:245::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:21:43 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 14:21:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 15:21:42 +0100
Message-Id: <DIGRK1QK7G8H.1W24QCDZ3V1AC@garyguo.net>
Cc: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] s390/jump_label: Implement
 ARCH_STATIC_BRANCH_JUMP_ASM and ARCH_STATIC_BRANCH_ASM macros
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, <hca@linux.ibm.com>,
 <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260512105920.2426293-1-japo@linux.ibm.com>
 <20260512105920.2426293-3-japo@linux.ibm.com>
In-Reply-To: <20260512105920.2426293-3-japo@linux.ibm.com>
X-ClientProxiedBy: LO2P265CA0511.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: b45351f9-fd62-4aa5-40ad-08deb031ca59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	7yYsQOIrxfNNv5kRQJC76wp6StSNt5HdqRsDG36TKfM3+AtDMcsocP3stYJfRutUeLj9/kYTt43Ib5Z1NQTW9Dggpd7tTXgYiczOtNu+4cYyGgnec6uTpfoyqj0FpTenB/qPFIzifUVHHk7bCR6n7nzmBZllUTD5x/7SfsTs1PtUqEBQqR4IjTjp3vNuh1sc8KPi0sBLIWkREoYNGjzRfyT3FsS3aRwSRNWL7PZz+PJV27FZaSX1/Q5OjK2I67480Kc6qfbEwsbVPHd563O0Fj7OoNvVMnYQ95SoN7tlIrr7C2UAQVSbVBq7XTtgfAgM3AFBkMm49aCyu0Je4qk1iNFKlhMp2wPGYyIZVW31LKJex6Q9ZYsnV+FsRdXF3GaddEc24+D2sd/brg5J/j0b2zzWpobZ9VuVOFcEyiwADsk7W1uhY3xaemj66U1Gd7F/1BdTH/o4o54M9TnxwYha4F5VHtdARTqz/5/xwTLQfY2C3ISZgIWaIKPeq8zGSx/MivITxF4UmTzNc7JYHP8otlXBNfrsoYkafH56YFcAZ0Q+gBwQMY2EUh4eUzWG+Pg1rMjBdjzMDNEK1+J4viOnT//+sVFDKTfxXNO6NoX3bhV9sczY/ivdVWcALRYeh9TOJ7RD4iUhq+YC5mSGt/VQH7GlV8ZQqlKjKOtCGSD7kqG+c6SmgOIFIteZWlN654qQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlJtM3hpemZ2empkNzllN3ZxUEVzaWJuN0xhNlBIVCs4Y2xlT0RkbEhmM2xK?=
 =?utf-8?B?ZC9wMDB5U0tLcWsyL0F0TTQ5alQwR3NzUVlaTE5QL2w1K1VhSXZEV05pSExK?=
 =?utf-8?B?bE1RY0s2c1hldUF2ZkFubmFZVmFFdEx4Qi9kTXJEZnlWRDdHOFVRMkUvWmRW?=
 =?utf-8?B?azhtcXJTZUNJdTBIa1UrcDhnTk5IeXNld2krK0tTQTM2SjBFRW14dlYvYmpw?=
 =?utf-8?B?UVVMWDRkK04wZFpIZFQ5c2pnZlpxRU9TN1lycExYeGtpcEx2Mjhudzh3dnpi?=
 =?utf-8?B?ckd4V25SZlpkaTdZaDhJYTR6eEpYZ0d0RXk2UklsZFNlazdhNys4N1ZQUDJK?=
 =?utf-8?B?dTg1NDgzWHlhZWZnSURncElTK21BVHptT2kwUkQvczVqME5ESFB6UWtVN0g4?=
 =?utf-8?B?aC9HVHlYMnBPZmk2UnQrclhvdzd4b2lUWmllZlhRTGdPSnM4ZW1yQnRpaThE?=
 =?utf-8?B?NGpRcTBBdnZ6ZHR5MDNwOGkzZGhNY2VKWUFuQ3JvL2pySHJVV0ZSY3J3UEFL?=
 =?utf-8?B?UjNtblNiSjlvWEt0R0djcmlxWDg0Zk9JUVNNRVFtc1pEYUMyZjJsUWtIY2NW?=
 =?utf-8?B?TUNyVDhCeWJWYSsxQmJLSFNKeGZGd1B1SGFIViszTDMvZ1ZYZUlLUEVnMlR3?=
 =?utf-8?B?OUhoRjljWFBQSTZ3VnhJM0ZibkhzT0V1OHR2VkRCOG1nYkxOWGZqQ1I0M2p2?=
 =?utf-8?B?R0F1SjVyQjVmMVkvQTJmcGh0OWhMNGNYalpJS0hiSVhRaWY3RmxFSEo2V0pl?=
 =?utf-8?B?Sks5TkRCdmMrWHJ5TWlZczIzalNJV0F5cldtRFJ4OE8rK2RMZCtMaTViL1pz?=
 =?utf-8?B?OVE2U1h6RHB3MjcyaHhhWmpKVGVsTjZMNG9lcEFxNndZeTFqcjlpV1VabEJW?=
 =?utf-8?B?b1NDaDB2RUE5ZHlKd05zU0lTVklLTkJFYUNvQnRUTmxsOEpYT1JUT05QK0I4?=
 =?utf-8?B?akZVSFNWeW1NbE9MaGVvNEFuckNzeGl4OWZjRmlHLzNBNCs1Y003SnZjT3JZ?=
 =?utf-8?B?S3I5Nm14c3hSSzJ6S0U5MlFFNTNEN0VVb3pTQTUrQTYrZHMyVlJ1Smp0M3RM?=
 =?utf-8?B?V2hhSUttKzY0N1lPU0lBRDFCQWhQa0owZDJSSjVJM3I5bjJUc2oxOUNwc2xh?=
 =?utf-8?B?dlFvV2ZxV3JOaGNuRTlPa29kancxa2xKcFc4TCs2MkgyZ2ZNbkRUdGMrOG1h?=
 =?utf-8?B?QXJDcWw4TnEvYnZkazk1ZVhhcy9yMWxsRCsxWXRnWFh5T29iVHlkOUpCcG5W?=
 =?utf-8?B?UGJkemFkVFh6enpLQmp2SFZVTUp4L1dEWldDT1hDZU9NVjNpa2N5UXRNckEz?=
 =?utf-8?B?K2RhVVBaT20zVWdsT0s1bXd3QWNPdjk0SDQzc2QzRU9UNEdLWHhTWDIrRFZI?=
 =?utf-8?B?Q0Z5Tm0rYVJGZS90VHFubTZhejVTbS8wTE01MVNPZjh1UEt4UGhFOHdJd3Mx?=
 =?utf-8?B?Sm43SGVJbDVtbzgvMmJCQXJzYkRDN3BzOElXRkUzSnlPTEY0aWJqS1Zuekt1?=
 =?utf-8?B?bGh0c3JaVHJ2OGl2OTR2amE1TFA2NkNpNW1ST2JkOEhBVk1xVEVOYU1sRUVi?=
 =?utf-8?B?bUExQkhWSTAxZkVxOWhaZWhKYjM1MGt2eHdVRFNIVEF2enJsa0pUVDJHSDNr?=
 =?utf-8?B?amlZM3ZDZ1RwcEI3WnVqcFV0MUd5cFUzVS82akw3N3dxRlhqaGFqSmg3c3Q3?=
 =?utf-8?B?Uk94S2hSZStPN2M4ZEpHMndtbDUxNG9zcU5jSWViR1lqQXR1dVRWTlI5N1Ro?=
 =?utf-8?B?N3VrR1NSdTIyS1hMbkFUNnppSENOemdvNkVaRlkrZXJpOVNXa1UzYmMweVJO?=
 =?utf-8?B?TjY1aUt5c3ErLzZhWmdiYXpzVzRuLzR5SnNEWDVvOTZrMXZtRjJ1a1Z1ZUVs?=
 =?utf-8?B?MVdrRWhCai9xSkJxZ3hWUEdOR2MzYkRsQ01aSmxTbnNXWWEzQktzT3JPakVZ?=
 =?utf-8?B?UHJteU52bGE4WldycGt2ZVpZdUN6dHpwNmNJSmxJWGZXR3ZBY3pxV0VTTmJH?=
 =?utf-8?B?QXhMeWk0d3huMnVYZEU3SHpBaitPUHV6T2trSE9oUy8waFFabUozOWE0MG8x?=
 =?utf-8?B?NHBrYWdBL2xEZGFEcktTQTdqREpsSk8zZG9ESkhMQ3V4RGRZNjhiZ1dTQnA1?=
 =?utf-8?B?S3h3TWJxem11c0xncE5jNllYOTBlU0RubkMvUDBxWk5FR3JYcnZ5ZDRZamdG?=
 =?utf-8?B?TWtXQ3NwUnVaSHFhRnp0KzAvOVlOckRkanJ4SHlNY2JBa21YS0dNVXBQQ3Az?=
 =?utf-8?B?bW9qRFArYXUxV0oxWVdCcm9hZ0Jab0NhK3RLam5TVlZQcXBSWHNPb09XSUxK?=
 =?utf-8?B?TWJEQmZrN1Nma2dVbURjenY3ckF2ZWJYV3ZyMjdWNHVkc1ZoK013QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b45351f9-fd62-4aa5-40ad-08deb031ca59
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:21:42.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ09GWpzKdcXPfxW4RIedHFtyuKBb7vM9GuDv3XSYFyWUWlIL/1pF/BevXdOqwBGWmlR8mTXjv3wrtIpOrgLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5407

On Tue May 12, 2026 at 11:59 AM BST, Jan Polensky wrote:
> Rust static branch support needs the s390 jump label instruction sequence
> and __jump_table emission in a reusable form. The current implementation
> embeds the sequence directly in the C asm goto blocks, which cannot be
> shared with Rust.
>
> Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
> describe the brcl sequences for the likely-false and likely-true cases
> and to emit the same __jump_table entries as before. Switch the existing
> C helpers to use the new macros to avoid duplication without changing
> the generated code.
>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  arch/s390/include/asm/jump_label.h | 33 +++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/j=
ump_label.h
> index d9cbc18f6b2e..1f0114150786 100644
> --- a/arch/s390/include/asm/jump_label.h
> +++ b/arch/s390/include/asm/jump_label.h
> @@ -23,15 +23,25 @@
>   * We use a brcl 0,<offset> instruction for jump labels so it
>   * can be easily distinguished from a hotpatch generated instruction.
>   */

The comment looks out of place now, you probably want to move
ARCH_JUMP_TABLE_ENTRY above it.

Best,
Gary

> +#define ARCH_JUMP_TABLE_ENTRY(key, label, local_label)	\
> +	".pushsection __jump_table,\"aw\"\n"		\
> +	".balign	8\n"				\
> +	".long	" local_label "-.," label "-.\n"	\
> +	".quad	" key "-.\n"				\
> +	".popsection\n"
> +
> +#define ARCH_STATIC_BRANCH_ASM(key, label)	\
> +	"0:	brcl 0," label "\n"		\
> +	ARCH_JUMP_TABLE_ENTRY(key, label, "0b")
> +
> +#define ARCH_STATIC_BRANCH_JUMP_ASM(key, label)	\
> +	"0:	brcl 15," label "\n"		\
> +	ARCH_JUMP_TABLE_ENTRY(key, label, "0b")
> +
>  static __always_inline bool arch_static_branch(struct static_key *key, b=
ool branch)
>  {
> -	asm goto("0:	brcl 0,%l[label]\n"
> -			  ".pushsection __jump_table,\"aw\"\n"
> -			  ".balign	8\n"
> -			  ".long	0b-.,%l[label]-.\n"
> -			  ".quad	%0+%1-.\n"
> -			  ".popsection\n"
> -			  : : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label)=
;
> +	asm goto(ARCH_STATIC_BRANCH_ASM("%0+%1", "%l[label]")
> +		: : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
>  	return false;
>  label:
>  	return true;
> @@ -39,13 +49,8 @@ static __always_inline bool arch_static_branch(struct =
static_key *key, bool bran
> =20
>  static __always_inline bool arch_static_branch_jump(struct static_key *k=
ey, bool branch)
>  {
> -	asm goto("0:	brcl 15,%l[label]\n"
> -			  ".pushsection __jump_table,\"aw\"\n"
> -			  ".balign	8\n"
> -			  ".long	0b-.,%l[label]-.\n"
> -			  ".quad	%0+%1-.\n"
> -			  ".popsection\n"
> -			  : : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label)=
;
> +	asm goto(ARCH_STATIC_BRANCH_JUMP_ASM("%0+%1", "%l[label]")
> +		: : JUMP_LABEL_STATIC_KEY_CONSTRAINT (key), "i" (branch) : : label);
>  	return false;
>  label:
>  	return true;

