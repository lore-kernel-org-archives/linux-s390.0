Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020143.outbound.protection.outlook.com [52.101.196.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E663382CD;
	Tue, 19 May 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205539; cv=fail; b=NoQmqlEUJ2QzA5wb4UkjDEkvTVlOwRdAcdfgktLHKfla41x449c1pNA7Weqx2b9A0MlnFjzLCRHXekGJ4eiX0coPfWm3B61iRiTkPhA1TsYcLhemrLcxdgQwPetMlb/uH9SUvhJAk2XE+MhMCMQocLZ1WWvha8rIIrQ/49d5uuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205539; c=relaxed/simple;
	bh=DyyHZME4Ga4laMsk6duOhd5mEcavs3cEqUB5WWeRbDQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=AD/YBYL75iL6PfRgMhnY9ZE+wMGQlcNb+3s4D3oESpyAL0OxQOFK5iiGIiWuyOrtFWqSUL4XywErxTERWUfcbSPH7DlRgnI0t9Q7+WkLo/RTjpUG+WcuNQWZdb0Tsvt6/NNNOnT/xyaZx4yzvuOEv5d42f8x18QhEryIJR1gIqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LCEsBOBl; arc=fail smtp.client-ip=52.101.196.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LCEsBOBl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aop4jpgNwrNM3hsdQIgk3Vnpu8L7A847A2FWBVN/HcqNmuGjSQ0q98Pjj0nODjYEsX1dZwPYqvltfzR4p1hOlybqTMXu+lJEZ86RrMI7JGLL7Q6tXmXK+WfWzkZ8mM6ozYdrEzePoIkofPJA78n0Fzqww5vO/bcIRPE3S9S0KWM1MPxKiKTYQcRJBaR5QD0uvyAYYea7SEFAUAESJbsp/z+jYAw7VR9KOdIvgMFJ0QiomaaPCsZ+F4FJ1LT89ie0hygIOieYBT5gXVPS3TXAuKbc3bjCZnizeJqobc/szwGQpXgDEAlUP+7sqQYefZEJl1C9E5QNzjET0XLVA1SdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tm4v1RSYzS33Ym9OGWItQVzu5ul4z3vpcxwDv7GFAco=;
 b=kkPr3c+qPem5XrO0Ziz4fbHnG6shCUVYXfVcgPGAudqUxk02sOxSA3f694R8ubIZeQ5UH8r2DsKVYCyaY7hgccRvKzJl2NRkpluX8o+mx4ZXun2zWC/WQuMrrowq3SpnuuTqhdF+75usvMr+kDiH60DtUy+LaLGVbICq0IJIt0rIiYuOeQQXTGwB8U9gP55pSp68/U5XMps2/IMoVSFVQf/NCjn6VVDe5JWcxpJdvtm2upQupsqQY9Gcrrj/R16yLMPD/ZRE4A3BDJEOKqykBo/v6vZkbIsafdnRNdR4G/s1JBs+VGwwRKIis7iyjKsYHjZu++5D4f5lUI9pbAh3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tm4v1RSYzS33Ym9OGWItQVzu5ul4z3vpcxwDv7GFAco=;
 b=LCEsBOBlQZ9eQpg03s9soLEmC674fWY+UJ8B7q7iMBkx21zB5LsivV9mYcoXjJgSHOyfeBcoq5EzkWhav/3sC6CzIdKscS/dEeuImjagpBEBNp0K9+gNjzjDS5r8x1v0N+xJx4E3o8UKxxQvVREQ7dz3h+a8Xk2nmFnLclyO0Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3419.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 15:45:34 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 15:45:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 16:45:33 +0100
Message-Id: <DIMRQ2FA569H.3V1LI6U897MPU@garyguo.net>
Cc: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] s390: enable Rust support
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, <hca@linux.ibm.com>,
 <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260519151215.1611802-1-japo@linux.ibm.com>
 <20260519151215.1611802-5-japo@linux.ibm.com>
In-Reply-To: <20260519151215.1611802-5-japo@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3419:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a43e48-7f0e-443b-de99-08deb5bdaa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016|4143699003|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yJEDldfXWjwwPOJrgL2Tb2EDyHRbd+d8S0v2gL6aBKPQ2muw9qGoH02Ct4yXO8VpN9FGiXrQaObhx4oft+7VubeJImiYlpJN+OPSeBCyQSTGPsUy5mOq6L4gCZWjmuUvD7tB+BXhavuuU+emsTEzRlgnD89UC1Z4EbBXfrugsjG2sk5NbllUMLLdl2Z2jVyJZxUE9bpkuPbthbteILlrZsuMcWxJDUYQU3sBVPDGRFYMdK47PEyMTQhMT2CWnQHjVLiLrNy50aoBgnMRkc3PchBs40eafulznkhfszCX34oSCq4+NR7MaUQNFlXgq8djCNIhEQAoYypgAegVZkBeEHdQMCLS5WTTBP0CZYNxIv17gHSKqhQZx5+bQUqMhFUkbHV1sejWMYPaHoiDaw8NsvdgRtc8gFjeMRkzymcVKStDPgdyRTah9OwkG/zwtEQYjpVbkmn5mo5T4zyqIqpVgfMOZ/IlWStbaEd9GL/Z188QsRP8lvava5bhP5cVnBERbBRDCUBZt4MDrrqwt9czIFjast8baB7fjHw9jRpxoA7U17ALJabruDEsaNV43gqQ24+hwB5YKBD4LLsevMx69P011vv9uWs3tnwuG1VJu5U2M4xuf8DNwKiN+DjUf0PvBcg/PA2rePv+tFBhUKx9FqHdOdXY8GRwBk1P+G4nHYA0E2He6W8K61bztpKXZVMU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(4143699003)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0hkd2xJL2JrYytQYUpVaGJPdWVQcE5TSjNlYVJnenhKdU1KMzczVTRCM09U?=
 =?utf-8?B?SUlsekg2Nkt5V1NVakJlZHc3MHdDZkdOU3JqQmRycVROcUtoQks2dTlzMXYz?=
 =?utf-8?B?THRrME16SUVSdHhjV1BBbjVDRmZJaktYRUxNa3RSclZwQVVzQjc3UEx5bGkx?=
 =?utf-8?B?ZEFhVzFRZnc3Z2JwVVlEYUlhc25NMnZtRVVlVzAyaDB1MCtMZitpMTdldkpP?=
 =?utf-8?B?czc5Tlp6cHpiUk9kMExtMC9SVTN0Z1dzTTVJcUJVTDB0eHVKY091UE9NQllK?=
 =?utf-8?B?bG1CcGlHc2FCQVFkQ2pUTVZWM2dPemJoaXBLRGRNeXYwOEtHOG51NHFaYnJn?=
 =?utf-8?B?R2dXeTg0ODVraElqN1JGaEJXZ2R6dkF3STN1MlQ4cFhYQnM4bUtNZk90YkhT?=
 =?utf-8?B?WWpZaCtYdTB5M0dydnN6em5GcmhSZGpxMFgxdTVub3lOY3NucHdWRjJJTHpW?=
 =?utf-8?B?S0R4a3RrcUdad2V2SS9HSjdoZWc5MjRqOXFDdmpiOFBzcUhVSTdZdm1qd2hC?=
 =?utf-8?B?OWloV2ZsQTNzRUUxSzU1bnVGVnUzZE9zR2NMYW9lK3FWVTc5Q1RuRnpHRlB1?=
 =?utf-8?B?MmRwU3RYVUJLN3VtdHFFR3lwdWxGZy9NeXUyR2MyUnFlQk1lT2szYVZVVy9N?=
 =?utf-8?B?dnZzQ2gwK3k4dyt3MTljeGUzcG02c2JYbEl0ZjU5TFlJckdxTWhkUmNZOEd4?=
 =?utf-8?B?N2hRNXhTR1puSjV3eS9WRzB3djNmWTZLOWNXMkFUTktDOEF3M3c3YUY1RE40?=
 =?utf-8?B?bTg5a1VLOUpRYzFudW0yUE04M2lsRWNuRnRyUndicXFFMWlWZmlqYU9BcFRi?=
 =?utf-8?B?ZVN2RGg1TDNiNlpld1QwUzRMeVhFdFNYUWZvRTRxcjF0OGVKeEJhcTVCck1C?=
 =?utf-8?B?NFJucCtaZWwzbDBRTC9INlJRbHdsa0IvRGtXclVteE9IMjdyUWFKSnlQM0dr?=
 =?utf-8?B?SlNncWQ3N1IxVWlnM0oyTTB6TEJtdG00cTJDUnE5ajlMRTNjR2ZDcjBOMzl1?=
 =?utf-8?B?clZVY09obTFMcU5GWUZuV0JHd2t3QUJUbHJOdTVhdjk0cXZuekRLR1lGSXl6?=
 =?utf-8?B?REtnd25FYVZOaUsvMis5VlhqYW1wa29aRmgvZVVPcDBWL2tsS1owcTlUb1d5?=
 =?utf-8?B?dlpDUUgyVnIyM1MwR2VjcTF5dDBabkdWbmhtTVBSa1ZHbXpCU1k5Rm5waVNi?=
 =?utf-8?B?S0Q2S0ZaaE5kQXUyWFR5WktxNXEzaVZ3VU1uaTlNczRpSjBkdkNKOWNkdXBU?=
 =?utf-8?B?YjVHRGxwd01icndVaVJacFIzanN6ay9tTGhXTE8xTzN0aC9lTDV6YzFmMTJC?=
 =?utf-8?B?YlNmeGhKb0g2RjhzT2xyanl4aGdVdUpxUU83SFBwZnErYS9mTFAxN3NtTlNN?=
 =?utf-8?B?cGhsdmpRaGRpY3dQNmp5MTBnQTU0N3VTZXpHVmVrTWNyWkg2L1MzYU93a1VW?=
 =?utf-8?B?Rzc1cEkxZmxkK2NFZkdwWVQ3RWx2cWFvR1RnWXVYaUtMK3ZzN0VoTXlURFlS?=
 =?utf-8?B?U0xTejMwak9EYWV5ZXMzd0Q0c2dnR1hxOFZLYVFXRzVjVDZzbEhPcWZUaGhF?=
 =?utf-8?B?bDR1ZGg1dTQxbjdhd00yQ0ZtZC8xbVBmU0VxWWRpZzE0elNQeXE3bFBGcGU1?=
 =?utf-8?B?bDY4V2F2WUNSeFFlNHJSNkNKNUdtSkpTVlRGVzlUWVRhbVZYN09SbXltUUw3?=
 =?utf-8?B?NklzdTZqZHZnWVNHSEdYdVhoQVBPa1NlVGR1NFdMNFdYWkZPRHpCaThhTFBF?=
 =?utf-8?B?eWpuTkROWlp3V21Cc0VFQ0d5ZWxuOHp6QjkyeEdaTVNicUpncDJ2TU1DUktZ?=
 =?utf-8?B?THFHRy9Yc1JhL2oxYVU0NVc4TCsvSjFrekExN0h5LzNXWVV4WHFBcGhoMkt0?=
 =?utf-8?B?ejhhV3pZRlgwS3FvR29NMVFkY2dKM2pKVGtrTW10bHZUMDhGek14VHVNNkh1?=
 =?utf-8?B?MXlZYlRCc0RJeE9SM05WaHJJcGlmSFdEbTd3QTlUZlRaSDErVHRVNkc3Mmk3?=
 =?utf-8?B?UTBuV1dLS2E5VlpHUWFLRDdiRnd3eDl3WUd5djZ1ejl4ZHBEdDduVUVXcTc0?=
 =?utf-8?B?aXVBRTUvK1hKL24yQ0g2Zk9iZHFuMHRrRFFUNmJGc1RBVjl0MUZFRXJLNktF?=
 =?utf-8?B?Rm5HdmpDd0k4Yk9mdDE1SDRkOS9UQVJ1L0dZTUJFSlVFT3RLT1dzTFptVGlk?=
 =?utf-8?B?WUhkZmRndXZqb1ovUkN3TElsNCtkVEUzUFB3Ty9GdEZIdGpqeVYzSnZ1dWNC?=
 =?utf-8?B?UHJic05ZTW5ORG9sbW9IUlRrYkVJMGZMbUNPWjlXUkx2WUpLaFJGRDI3TWxT?=
 =?utf-8?B?VHJIQXhLTm9QeTFyNHdQYmxMR0VFVnVVS1hkc1pGRGpNNW8yL2puQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a43e48-7f0e-443b-de99-08deb5bdaa19
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:45:34.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoZyYWvxGtS1FRwuYktZzxmipBtuTuqPUcafTrm+MxovK5tLYSS0LKcbezNJq126qy1U12quo1FbzjEJyQurAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3419

On Tue May 19, 2026 at 4:12 PM BST, Jan Polensky wrote:
> Enable building Rust code on s390 by wiring the architecture into the
> kernel Rust infrastructure.
>
> Add s390 to the Rust arch support documentation, provide the s390 Rust
> target and required compiler flags, and set the bindgen target for
> arch/s390. Adjust the Rust target generation and minimum rustc version
> gating so the s390 setup is handled explicitly.
>
> The Rust toolchain uses the "s390x" triple naming for the 64 bit target.
>
> Rust support is currently incompatible with CONFIG_EXPOLINE, which
> relies on compiler support for the -mindirect-branch=3D and
> -mfunction_return=3D options. Therefore, select HAVE_RUST only when
> EXPOLINE is disabled.
>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  Documentation/rust/arch-support.rst |  1 +
>  arch/s390/Kconfig                   |  1 +
>  arch/s390/Makefile                  | 29 ++++++++++++++++++-----------
>  rust/Makefile                       |  1 +
>  scripts/generate_rust_target.rs     |  2 ++
>  scripts/min-tool-version.sh         |  6 +++++-
>  6 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arc=
h-support.rst
> index 6e6a515d0899..ce9804b8226c 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -19,6 +19,7 @@ Architecture   Level of support  Constraints
>  ``arm64``      Maintained        Little Endian only.
>  ``loongarch``  Maintained        \-
>  ``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
> +``s390``       Maintained        \-
>  ``um``         Maintained        \-
>  ``x86``        Maintained        ``x86_64`` only.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..26951781d74d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -248,6 +248,7 @@ config S390
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_RETHOOK
>  	select HAVE_RSEQ
> +	select HAVE_RUST if !EXPOLINE
>  	select HAVE_SAMPLE_FTRACE_DIRECT
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>  	select HAVE_SETUP_PER_CPU_AREA
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 297976b41088..8e1239668f8c 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -35,25 +35,32 @@ KBUILD_CFLAGS_DECOMPRESSOR +=3D $(if $(CONFIG_DEBUG_I=
NFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR +=3D $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call=
 cc-option, -gdwarf-4,))
>  KBUILD_CFLAGS_DECOMPRESSOR +=3D $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-a=
rray-bounds)
> =20
> +KBUILD_RUSTFLAGS +=3D --target=3Ds390x-unknown-none-softfloat -Zpacked-s=
tack -Ctarget-feature=3D+backchain
> +
>  UTS_MACHINE	:=3D s390x
>  STACK_SIZE	:=3D $(if $(CONFIG_KASAN),65536,$(if $(CONFIG_KMSAN),65536,16=
384))
>  CHECKFLAGS	+=3D -D__s390__ -D__s390x__
> =20
>  export LD_BFD
> =20
> -mflags-$(CONFIG_MARCH_Z10)    :=3D -march=3Dz10
> -mflags-$(CONFIG_MARCH_Z196)   :=3D -march=3Dz196
> -mflags-$(CONFIG_MARCH_ZEC12)  :=3D -march=3DzEC12
> -mflags-$(CONFIG_MARCH_Z13)    :=3D -march=3Dz13
> -mflags-$(CONFIG_MARCH_Z14)    :=3D -march=3Dz14
> -mflags-$(CONFIG_MARCH_Z15)    :=3D -march=3Dz15
> -mflags-$(CONFIG_MARCH_Z16)    :=3D -march=3Dz16
> -mflags-$(CONFIG_MARCH_Z17)    :=3D -march=3Dz17
> +march-name-$(CONFIG_MARCH_Z10)   :=3D z10
> +march-name-$(CONFIG_MARCH_Z196)  :=3D z196
> +march-name-$(CONFIG_MARCH_ZEC12) :=3D zEC12
> +march-name-$(CONFIG_MARCH_Z13)   :=3D z13
> +march-name-$(CONFIG_MARCH_Z14)   :=3D z14
> +march-name-$(CONFIG_MARCH_Z15)   :=3D z15
> +march-name-$(CONFIG_MARCH_Z16)   :=3D z16
> +march-name-$(CONFIG_MARCH_Z17)   :=3D z17
> =20
> -export CC_FLAGS_MARCH :=3D $(mflags-y)
> +mflags :=3D
> +mflags +=3D -march=3D$(march-name-y)

Why not just

    mflags :=3D -march=3D$(march-name-y)

?

Best,
Gary

> =20
> -aflags-y +=3D $(mflags-y)
> -cflags-y +=3D $(mflags-y)
> +export CC_FLAGS_MARCH :=3D $(mflags)
> +
> +aflags-y +=3D $(mflags)
> +cflags-y +=3D $(mflags)
> +
> +KBUILD_RUSTFLAGS +=3D -Ctarget-cpu=3D$(march-name-y)
> =20
>  cflags-$(CONFIG_MARCH_Z10_TUNE)		+=3D -mtune=3Dz10
>  cflags-$(CONFIG_MARCH_Z196_TUNE)	+=3D -mtune=3Dz196
> diff --git a/rust/Makefile b/rust/Makefile
> index b9e9f512cec3..77460502f576 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -403,6 +403,7 @@ BINDGEN_TARGET_x86	:=3D x86_64-linux-gnu
>  BINDGEN_TARGET_arm64	:=3D aarch64-linux-gnu
>  BINDGEN_TARGET_arm	:=3D arm-linux-gnueabi
>  BINDGEN_TARGET_loongarch	:=3D loongarch64-linux-gnusf
> +BINDGEN_TARGET_s390	:=3D s390x-linux-gnu
>  # This is only for i386 UM builds, which need the 32-bit target not -m32
>  BINDGEN_TARGET_i386	:=3D i386-linux-gnu
>  BINDGEN_TARGET_um	:=3D $(BINDGEN_TARGET_$(SUBARCH))
> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_targ=
et.rs
> index 38b3416bb979..8f1df6819d0b 100644
> --- a/scripts/generate_rust_target.rs
> +++ b/scripts/generate_rust_target.rs
> @@ -256,6 +256,8 @@ fn main() {
>          }
>      } else if cfg.has("LOONGARCH") {
>          panic!("loongarch uses the builtin rustc loongarch64-unknown-non=
e-softfloat target");
> +    } else if cfg.has("S390") {
> +        panic!("s390 uses the builtin rustc s390x-unknown-none-softfloat=
 target");
>      } else {
>          panic!("Unsupported architecture");
>      }
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index b96ec2d379b6..296acf8f71aa 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -31,7 +31,11 @@ llvm)
>  	fi
>  	;;
>  rustc)
> -	echo 1.85.0
> +	if [ "$SRCARCH" =3D "s390" ]; then
> +		echo 1.96.0
> +	else
> +		echo 1.85.0
> +	fi
>  	;;
>  bindgen)
>  	echo 0.71.1

