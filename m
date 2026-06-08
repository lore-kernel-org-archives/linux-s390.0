Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020093.outbound.protection.outlook.com [52.101.195.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8CA3DD503;
	Mon,  8 Jun 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943114; cv=fail; b=WigoNPmSU7KvyexWTvtIhdxQPMA6KAH3udR/b1nWH0omaEVIbJf5oXzQXMIW7/5EcSFQWvQM0diMZO3Hhcl408lfVs7laTNayTnx3DNokmqE8IOGzxgKjho2xP+uSrEF6Q07g6UAUl+1OmsdSVLZmYE9eAb1BZLVTz4aGqmNxhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943114; c=relaxed/simple;
	bh=8RYQsMriQKqMUF3BHPxWRBdOM8W1E4IKPkLyCZBqaag=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Q3rIcZFid1A2J/+DNGDYzG68GpXEVTi/fKA23e/2GFa+psVKA56pKqbWHv7nh48g1v+z+qmWbC6Ze1WxAcJhvZQAjW7AfHB6oNPHWuT7l31BMkl/6mAwVHpnAAyXENDqvq92pgBxmzt8a33iNeKzOJDp3c7RtbId5REJkO/jChs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JSHQ7qwc; arc=fail smtp.client-ip=52.101.195.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JSHQ7qwc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgw6CIrfu8yDJaXgNbGvVBpLVaB9r+G3w8wYl7BmVFyCWxD/Jp1w8X52gQ9ByWW7raqCesScSx4AzzkIKWQqBxGuLKfnQrhmXNrkkpPgz+Box/G4c8+P5/djybAzruWdom7CEK72/B4inn2TxyAbg+E59Pbdk3mpE77a7hjJcMjljzUqsCzIHqRnIuaaYBuXjsKDHNrBHMvTxTRqMo1XTdsHk4qiuhudyrKijaldq6IMh4xBEQVfUWAsvphhVMfxgoCmYL4Ar9r8n35g2B8HUbP/7H2JUMJjDjdP7UyiE2wvJJ5jDHCCcBSnVfgJ911aFni46O4FJvKzSiwOAt3ODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+6v+XjrcoEZB0NjylXSMgAaMx5gYnzGgLms2GFViuo=;
 b=ohFkq9AnyonIAOqRMfGf6AoaMqhIfAZGRHK6sUDr99gdfGLkNO550OrmNh6eFWyNp7IwSGHnyTyiLCcMyJZm5lfEh9ORf6xKUxiyOHjYnx1amDl8RPmWxZRIbvbbHyoeqN1DY3QKBud7ZTCGeYL+aFS89rKvVBJc4MPAulxzOQjCckJPqpnLkUMQCkPclSqIjHNUVf8+GdgDYMPIjFa0VlSq1zXYB2IiLsQVrgUesZ8K02BN5zEpcFvPtSdQypYClmRsvZBA1RXvc9bgIeuWIe2dzrekE5s6uBuUg3H5Hq9+rXV0snaIjc8x9hXIo8qgYehi8uz5AqiEGm8ojnuWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+6v+XjrcoEZB0NjylXSMgAaMx5gYnzGgLms2GFViuo=;
 b=JSHQ7qwczQbRa3lDuB2OYvCEF0eI33DUzs5Ff4yeLWybUz0reFBArkEDhSeBr7S3F72+IyuM6usfjhyMiqLeERE0LqWf2UH3uQ/W2oDqH6vkU3oooclj9Kaj9km79MgihsOyQJTlR9MschkHFy93lBiOK1TfdnbUd6cHo6j5FIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5236.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 18:25:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:25:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 19:25:06 +0100
Message-Id: <DJ3VN4EYXCUA.18YA9379UHT5Z@garyguo.net>
Cc: <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <rostedt@goodmis.org>, <ardb@kernel.org>, <linux-s390@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
From: "Gary Guo" <gary@garyguo.net>
To: "Jan Polensky" <japo@linux.ibm.com>, <hca@linux.ibm.com>,
 <gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <ojeda@kernel.org>,
 <peterz@infradead.org>, <jpoimboe@kernel.org>, <jbaron@akamai.com>,
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
In-Reply-To: <20260608181451.3734956-7-japo@linux.ibm.com>
X-ClientProxiedBy: LO2P265CA0142.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::34) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab39baf-075c-482d-2b75-08dec58b4480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|3023799007|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	UCwvwARbXNdTsAs9kmcjLWE3sis8xUFXxZj3LjWBp9t4+XCmKhIYKO97st89+eBFEUboev9L3RxgCWn40y8gw0PJM+nPHGudjALZ7t0yxlXMifvAMPaTOvCtyakI4aPEBhSsVvMu25tac2DbT6vMDtR1kuvZD6C+g5bTXeS2bVz1hcnoVeHR6AbGlDR6VQ7U+86nQCr5rFVP9XrFJEOJPCiC0enPNFnO8//VtAmxR5HvJPm7rgoFdtEmlFK1wEKO2M3430lLiHKl68JzWuJPmglAN6ZtNuobvj/wJ5ORTI/GMhKv6yyBfyf3/sdbNcN9dRj810h7p2uhHv6/hq1XKESYrL9tO2opHzYJp1YrnN8pEISld6wOQQo5sMGQT1OQ7AMod2mIuOEtBJUacpZ7AG6zwnANBrX/kEt0f+z13YZ1ObsQfy88MSfKoN+Rx2p2FBPiZbcFmWyWYDDIyool+22qZeQb7VnqaIOfYEjS/yjk5cnt7HSO3esLW4XoS21fFtPiQQeVzd1as1E4HIFrSLkdlaqeBDPfdxDskgHfNkNdlE/urmL7Jf/iJKbDiMoiOE6zRn0tLQnGPmphFU8co4RRdA8k8geHHn8fgmh3tY809W7sHYnlodkuMZ0QP/ummN/rJqR4n8ma9/e92bmjYeC+s/rNymDqIvmiK+TMSYmdp/do5HH6Sqik0/Zcaist
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVjejdqRlF5WmtLaVhTZFM4V2t5dHFnL0RJeGdwam1sOW84bUhpM1p3cTVH?=
 =?utf-8?B?QnVlWndsS0J5ZjlFS1VmTHRRRWhzd0NBSmtPZzA5MG4zOC9EcjJEUEpKWk90?=
 =?utf-8?B?MzVZaHF6UmNFZ2FMdXFkRndiUEROc21wN2lpUW1iUC9vVW1idzRnU1UrTk5p?=
 =?utf-8?B?RG01OCtDTlFaTDB2QnNMYVlJYmo3Z3dRU2paQkl1UFhJRVN3TnljU2w0STJD?=
 =?utf-8?B?ckhRRHhYYWFNamp0NFZRbDlvYWQ4TU14U1R5TVh6eEFlRVRsT3B3NWhkbTBs?=
 =?utf-8?B?K3NYZG1NZTVtQ3l5VWY1djYwSUtrelJaS2NqSEFDNS9jaStwaWxTSFFsNHUy?=
 =?utf-8?B?WmFlUGVVVkVHdTVBbDRydmtQQmhJVjVGRE9EZzBQQTY4aUo1TmovQWdFYVIz?=
 =?utf-8?B?aHI2cXZ4akZkN1ZrZGZpRFJwdGVscjlWRmJ5NENwUkxCaHErcUJoRGRRQmE0?=
 =?utf-8?B?K2d0WEE5b0RyR21uYUpnOXhnQ2xXWEFGcGlOMGFHR0s1YXFOMlpxa2M5Z2gr?=
 =?utf-8?B?T21sUERXYkY2czhNNXh6cFE2QkJpKzBRMGRaQ1hrNGJKeUlqUm1uQTlqVVk3?=
 =?utf-8?B?aW9nL0dqZ1ZJTnJpRC81WnFXMTYxc21ZejJsV3F5aElmYXo1L2pkUUtZVTFE?=
 =?utf-8?B?UzlGREszYXJBWTFrb1dEMStpNFNNZlljbnVLS1NCRWJmOXQ1OXh2MkppQ3pX?=
 =?utf-8?B?SFN6MThXZ3UrRnQ1dDNSWlJRbFE1UnkwUm5mYjNoM2Z5bytsS1NERVFWMi9Z?=
 =?utf-8?B?UmdCRXRZRVhYWnUwRndvZWtLelkvTDZlUS9FcktoaEk2ZG9oVVE5QUozemp0?=
 =?utf-8?B?ZFg5a2pRV1dnZzdBL01lRUZOREZzckhtbDBrbkxlRDdDdUhxclFxazVWUDBu?=
 =?utf-8?B?UDhZeWRSbWVCbTNBenNuMHlvVzhyTFRBODNQb0pIS3Q3bmwyUXlXb0hJWTIr?=
 =?utf-8?B?Wm5xd0lHWERmWUdoSEZ6T2x6NzVoWmZrSW03UGtGM0J1dDZEMmFHamMzL00r?=
 =?utf-8?B?VzdYNy9hVHBrTmlVcDgzS1FPU1hiVmJZUGltT3pFUkFOYVp0anhZeFN6Uy9r?=
 =?utf-8?B?TGV3Z1NuNHg5VmsybUxjWkNmMC9rWm8ra1o3cWVQMTJTWWRQbnlJSm5DWW10?=
 =?utf-8?B?djkxQ040cm5TZ2tLSGdRait4NHh1dDNVQm9pNlgxd0ZuYWxPN2NBYldzV0ZW?=
 =?utf-8?B?K00rWjhyOEJjNXZEbVNaUkhZdlhBUWsvWjI3cG5IUWJtd1NTSWZmakxtczYx?=
 =?utf-8?B?U3FPYWRlQ0UvY2luOUZPdEMxdHE3QzRPNFdLYmdnRHFPZUs5WlJYSmdKVnAw?=
 =?utf-8?B?c2NCUXVmejVzNStpdGxVQlRVUWVVZ2tBSjhPK3A3Yko1T0ZjVFhnck9neGow?=
 =?utf-8?B?WDJPaWc3TktZSlYyWG83RnlPMWU0Q0lFUW5kR2JmMExYZlN4NlFpYUU4aUNr?=
 =?utf-8?B?Wm1LODZ5R3FBYWU5U1laT0pJR1R2enQ5SzdvWS9QQUo3VGxDa3lCQXo2SHBE?=
 =?utf-8?B?NHFleU4vK3oxZEl1NTBLaFArRDUyMEo1QlYvTlg3TEd3bUJueW1zYU1ZSHow?=
 =?utf-8?B?Skk1YnhDTkNZWUN3eG5TTmVJQzQzR3Z4YmNodzYzYXQ1ZnVkVnJUblBYQ2tl?=
 =?utf-8?B?elRGc21SaTQ3YWFYVUNrL2pPN1U3cUhtaFVhM0RiWFJDWlBnMTJ0d3FEbW9Y?=
 =?utf-8?B?YlJlUVpLNXBmTVd1WmFZTTRWdVFkRkN2TjV5dTFCRXYzNnkxSUNkZzFoV1JE?=
 =?utf-8?B?RnIrZVJHZlFVVGJIdjRnbkdHZ3VLUHF2UzBxVWxuOWpyamJLK0Z2cUdBc3Bk?=
 =?utf-8?B?dVNlSEJnYkYxOEpFTTdUWWl3Tzg5TXlCWnd1aGtORGtyNTBCc2lPRUFQeGRB?=
 =?utf-8?B?cVp3eDNiRzQ2Q3VNcldFcFczN3dmdXdHRnZnWmtQeWcvNHdyNmhiQUtJUnR1?=
 =?utf-8?B?dkR3YkhJVkdlMDUxdzJhYWg0Mlc2QkVaOHdMc3h6bEJIQVZvZDdxb09reWVI?=
 =?utf-8?B?WVJpeGtOcVlEd3ZIOE1MNHM5NS9ybmVrS1V3Rk9SUDBpdzdiMFg5RmNlRXA1?=
 =?utf-8?B?TEx4dXhNVE1YSVVLRTQwZkswK0Mrcllwa21wSkFkV0VOcVViNHVIY1BncGtk?=
 =?utf-8?B?Rkt5U29kdS9jbHo3aWpLdTdjWHRQcm12dXlYVktjb0R1WHFZWk5Xd1l1UU5R?=
 =?utf-8?B?Zy9ack91WUtsVnNsT0l4Y0E0dTR6bFFlSVdBbTRUeEFEZWNnc3o2Q1NIb2tx?=
 =?utf-8?B?MkJScHp4K3hWVyttUVRrN1lkcFVvOFY1eUNTandnaHdwUWdkTDczcG43dVhN?=
 =?utf-8?B?Q01NaWMwZXIxOVQrKzVRMUZFUEtNNnRGK1I4a1RuVFNTNUxkbHl1Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab39baf-075c-482d-2b75-08dec58b4480
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:25:07.4735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W90Qe9ZrvvFXtQkwwysLwKTDsLJQbUHoBTaClkETNQOQa5GAN7+tWpRz8k/AqOfeU6aMjr/LVJzB6ESj6c8asQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5236

On Mon Jun 8, 2026 at 7:14 PM BST, Jan Polensky wrote:
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

Does `-Zretpoline-external-thunk`/`-Zretpoline` not work for s390? Rust wil=
l
throw a warning saying that it doesn't recognize this for the target, but i=
t
looks like it does generate target features
+retpoline-external-thunk,+retpoline-indirect-branches,+retpoline-indirect-=
calls
in LLVM IR.

Best,
Gary

>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  Documentation/rust/arch-support.rst |  1 +
>  arch/s390/Kconfig                   |  1 +
>  arch/s390/Makefile                  | 28 +++++++++++++++++-----------
>  rust/Makefile                       |  1 +
>  scripts/generate_rust_target.rs     |  2 ++
>  scripts/min-tool-version.sh         |  6 +++++-
>  6 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arc=
h-support.rst
> index 6e6a515d0899..4f980815e92a 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -19,6 +19,7 @@ Architecture   Level of support  Constraints
>  ``arm64``      Maintained        Little Endian only.
>  ``loongarch``  Maintained        \-
>  ``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
> +``s390``       Maintained        ``CONFIG_EXPOLINE`` must be disabled.
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
> index 297976b41088..8b712cd85fcd 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -35,25 +35,31 @@ KBUILD_CFLAGS_DECOMPRESSOR +=3D $(if $(CONFIG_DEBUG_I=
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
> +mflags :=3D -march=3D$(march-name-y)
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
> index 16f7e855e012..3bf296581a88 100644
> --- a/scripts/generate_rust_target.rs
> +++ b/scripts/generate_rust_target.rs
> @@ -260,6 +260,8 @@ fn main() {
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


