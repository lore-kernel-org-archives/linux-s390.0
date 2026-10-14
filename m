Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550747DF8C;
	Wed, 14 Oct 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962855; cv=fail; b=jTMCkVibMRezsrbQ26ckYwZIgRnjtozIJCefn2iDKFeOkmqv1ssP3tD/ggCNyNd5nO4EZFEH3nIZY6NI+iahuHzDGshc5PmxWl2GzrkWRS0UeT6EQSmzBuuh1LyRn9OjlDWQs34bOUms93LINKoelOCvn6v0ujkLe09perUPBo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962855; c=relaxed/simple;
	bh=43sbg2HA9VtZ6AM6yqlC2cG6cbs8uvO9skesdZnFmBs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tE+W3ZMf3kLAjj0fliTu6cUKQUmZH2AW54ChotN4ahreSlitx2jCAxTNy4+9wxfrEPIYiLk6dWE9G8dN2GRrjqncfcwOQJT02ksWu+uIw4uusIsJV8WSnG54vlLatx4QOrPx72cnkBZkufmqizvWI9Z7ZSKYPaKkJ2aa+Ysk/+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sAFOQ5PX; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sAFOQ5PX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FISzAHiyNbFXskWG/Ho8O80P7g35WBz16PT4/am950CgFDmdHqgRRvhedZDNRhdkYv28T23UNg7oXsXvjpXFeFp56GimBLpvTn4F2t7JrNqMlcEQOApIcYSrN2zMkTHHCb8o+c40x4gKRMhpYmulRN8r/S2c5IGmG0MBLZJUFlhB5IyoLXl9Q1zAsh0RqRYlS5FJf9M50LfF5gp+1qVW14xgWX0R/E0RD0qGQSVh7Q9A6tOBbmBjHUFFKjUDSEBS0xdEBIZ9GY+++HC+2ZtvbpA36+/xNpSZGgyITkb7fvjKDvybzsVus4C/MprWBKxSDUngK1D1Lj5G6DA9WTVB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdegQbfVYb7rxAdhJuisV8UafP7vtVKjc+m8LO/6j2g=;
 b=pu6QGJoh/56Lb1POVcPzfnJEIfJr0wus/q0S8WmhKbkN+62J+KhwPPqnJ3LGAJIEIwJlg0vGUobIS5NJmh2N9TOW2ue9hyn2Z674roWq0B8bn5xrxrKwdtOwt6yrIy3qVWzIM2L0xyv0D11hFVtOwW5T0wNsv7FnFlbxGWFbEVsXa4pA8Ss4XiPwhfVRU7JV0rkEUvPehLFtlBVzSiDmG6zDbRIES3uf7xFSgqZIjCw6koTdb0CnlrZbg4Xjf/NAr1aka8Zo6bpBFjEohmRxqtG7eXO00vkZyY5VlG1zpyZt+/Rr7GNwt5/qewZ0MODMA/1Inc9cOcxB8NoTZQGVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdegQbfVYb7rxAdhJuisV8UafP7vtVKjc+m8LO/6j2g=;
 b=sAFOQ5PXqZaWSun2nl3bjv0V6n8jV+j3ysNCff7Myus6Ss6iIUMhY0DRMHPlKq3NgGbEG47gVVAELNy3xE5OF7lBSYxBHiYVpOzAGhmV1kN71ZOZwF6s2sbOcNRvN6hRTDq8BkIfKO+Rg0fxN3CQnVR8k6mQsDkEfyqHVZdf8m0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:27:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 07:27:18 +0000
Message-ID: <4154bb7d-c97a-402b-979a-0f49d7a02c53@amd.com>
Date: Wed, 14 Oct 2026 09:27:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] Compiler Attributes: Add
 __require_explicit_initialization macro
To: Ian Rogers <irogers@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Viresh Kumar <viresh.kumar@linaro.org>, David Teigland
 <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, gfs2@lists.linux.dev,
 xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org,
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-2-irogers@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e289b2-7011-4388-a159-08df29c493bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|11063799006|4143699003|261009221227099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BdC3OWiE215+NFZJKX+JRn/yJtBkqqprUiCnha4t5KMYNF49oIdBwAYRi5wxOcsQ1sWQH+Qhcl4te21euxRgP1H6RqN89sZG6HVaDYD4lL2fu0hEDDbHTekwYfAypN6i+nPVzQSsA6X+Vtoo9I9xRUPkm+gLkaxVm9rWOVoTjJY23USSMb8FH4Ooxjzf2etLU/BBQ8fUb1nSJ0K/P0jWBishZQfDFNNz5EjjJg9ctul7zw3+GPOw8GGQGeZiet1XePOj8QRwfzr9frlFox1TqNtjDFhJz284KRYInuJl0MYYQMF40w4dlgakZ49HD3bzByLpck+pm8LlBt15XNve8CrL0vK/dRKYBKTOtaF8Y/XTGyslLZTFAiTri3kSAciGuzY54FOobZa75FW0gxOIAYoyPQnslbORp0TeD8ylPOzXP1Dq49CH890BlZhnce0wHsE4pMmwodrs6LruRZindtAYO8j0CkvFQZ2/zfaBcZn9ZaJAj7xK9hmmss4PHSWvxQNg7vS/mhu2GCWQO9mZQ/9EAWJndH7EUbtk8PV+tNL5eVdIqjwXb7hOC/clRHNoZHBgWsN4CgMLZdtLT4egUf6pLiIRKfWSgWPboNWevc5zXrv2F0dsvwll6dIys/yY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1I0S1dyeTBoWFhsbzNHS3RoVVNISG44WThsVENqZEF6WlpDWlp3WmZkY3hY?=
 =?utf-8?B?cUhHTmN1bXg1VlM2QWFyYnVEaUNqN3lzZzFWVUNyM1NUZXlxTTNrR3U5bEZa?=
 =?utf-8?B?a2d5YmphWEwvQzN4enNyWi9EQkVuVzltYjhEdXBqbEFWRGh6ZmFqTlBJeExC?=
 =?utf-8?B?RWo1WmRhQldMSkNKSHF1MVEzbm1oQmV0dVhDMk9vN2xqeEw4OGdYa1pNMlpI?=
 =?utf-8?B?MkgzSjZwYkhUSHE2QkNMYkhFWFladWxmZFY0MllLUllUbmRlaGhWemJ6cXk1?=
 =?utf-8?B?K01FRzQwOUJsTnNIRXB6S1ZtMjhyb1RJZVRKUnNkbXVPL2FNaVpKQncydVox?=
 =?utf-8?B?U1lWbG1IY1V1d1BSSEUwZHUycW9KblhQL2pLUjgyQTJjU29nYTU1VUlvbzhx?=
 =?utf-8?B?RHA5eHErWEI5b0xoWk9jSE81M296QlozSnBkYnB5dTVqU0c0TzczbUM2MFNr?=
 =?utf-8?B?bUZETjJiTDM5c2p1WWtTbHJlaXQrb2lUYVdJZEgrc29MRllzbGhzNlJDMWIv?=
 =?utf-8?B?T3RJQVhjUFE0dVRSWE9NenlMWjVhdVlSaWRGdlJyS0o5RnFhbmxCWUpmbFN4?=
 =?utf-8?B?bGlDTEJxQ1gweWJrdm5OdEJqT2tzejlRVlArdzI5bks2MU5JTmRxS3pQY2pi?=
 =?utf-8?B?YndQRHhSNDJjWmZkYUlkemxha0pxSVFocTlxMzhMSVE2dFdOOGRocTNTTDE1?=
 =?utf-8?B?eVlzWEpLaHVTdWtjeE83eGQwY01KeFdvSVNwVG1pWnpOWUhnN1lLUG4vendI?=
 =?utf-8?B?bWFRSEM1UWpJd3JwQm05M3FLRFBkdjFuZTN5ZXFpTjJ4eEpzb2Y2K3ExVThX?=
 =?utf-8?B?eS9OVzFWQ3I1T3BrbmpYeFNFVWMwQk55cVhnQWNJQUN2SzBpK2owTVM5RHdn?=
 =?utf-8?B?KzVRbjYwc1VQQzlxRWRzVXAwWk1kOEh5R2dYSmNtUlFaOGRTdGRpemZjMEto?=
 =?utf-8?B?UHI4bzV6NE1FdFdUMnBjZDJrVWIwb3ZLSWw5c2tiVWpvWnFHcXp1dE15c25q?=
 =?utf-8?B?RVV1NlNRY2N1b3hndUNyTmM2YlVyOHZiVVZtT1o3ckNHSW1PcVVtS0p0dEI2?=
 =?utf-8?B?a0VxWWQzc2czNlpDZTFZay83emgvejZoclVJK2k2Rnhpa0FOMXQxam84OUwr?=
 =?utf-8?B?ZUJyNmxDMXNJTTEvT1hHdDRVUjhHT1ZmblBTVzY0aVVadFpFSFJrN0JIRDVY?=
 =?utf-8?B?ZCsrMW9KRmZVTXcwK3hucVNpSFAxTDh3cllwV0lhR2wrR0xNWGY2bkFIeTF0?=
 =?utf-8?B?MjVlajA2VllCSUowcGNQa1QxcmhFL1FlNGptQThjelUwTmRwaUVoNTFoYWJv?=
 =?utf-8?B?WUdtaXlKSE9jd3J2eVhkRFVsSFZORkhWZ2J1enZ5T3FMZldNYWk0YS9tQllE?=
 =?utf-8?B?ZkdibW4yZ1VGWVh0K3p2Q3E3RVBndll3RWNrN2QvUEt5ZFcyU3RKWVZWbHZv?=
 =?utf-8?B?VS9iVDA1VTRTVkFjWkEzVTU1VzFINXJWTW1aUnp0Y1gxSnNibHpZSUtzYkhm?=
 =?utf-8?B?eGkrcnhWZ21sbWcrU3E2S1dsZkFhVGxmY1YvU29kbnFBUlRXUVh3UkhXbDB2?=
 =?utf-8?B?bVpFWUdrY2t3dTFJbE5qRmFjTVplZncreXNNQ3lIZitWQmdrdVk1QytpZVRF?=
 =?utf-8?B?MVptMXlxbERhb3pQUk4zcTBDZU5yL091bmFvbDlnQ1JnNDhUaE1FSWw2NU5Y?=
 =?utf-8?B?bFV0QTliYmlMdTZoWU9ZUnBvK242aERMSnlKVTdjZGwwTUVUeHVmTUJRczZt?=
 =?utf-8?B?ejVReSt1UUEzaXFMdmZHOWpHQmdkNzZDdzRpUkRLSml5UitoWS9MNGJpMllo?=
 =?utf-8?B?S05SUm1WUVNlM2oxdEJvUDdYYkw4cVVOZEFsSFp1NElRWjJlb2hiRXlFVXZm?=
 =?utf-8?B?S3hJK2RHUmpWMHBjZmNQNGFyWURERzc4dDhqYlBNcDZzSXVzZTdKbkRYLytp?=
 =?utf-8?B?bjE1U3pYNFRxQ3pCeURKdTlKYjlDMjdFcVZ1MmRXYWFYSGNjc202NjNvaFc5?=
 =?utf-8?B?bWhwMFgwZFFvalcvK29tRXN1ZTRwUUprMlludG84VWFYNE9manVFTlRLdG95?=
 =?utf-8?B?UlVRbGZzeE8yazFjcjRXTHZiK1hwSVAxV3RFVGFsYlIvUHpjODR3WW9WVGFT?=
 =?utf-8?B?a0xJcGpSdXBpSFdtajBOUVc5NTV5MElDSUpnMEpOalFUbnMrcElYeHVEcUlh?=
 =?utf-8?B?V0NEenIyLzJtUFVrcHJiN2VIQW9zK3RLcWVpRWo4ejltVW9oWE8rU2xuVjIv?=
 =?utf-8?B?N1hUZUNFTDU1N01SUnhyV1BXZ1JGallORXRRZ3NocUFkbE9zVkcwNGNIMVND?=
 =?utf-8?Q?hrqF6gI8LVp4KZy4bx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e289b2-7011-4388-a159-08df29c493bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 07:27:18.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPCX3t4rIs/vo7QVV+VbzZJKjMFIcuzUma/vpFm4ZHQP4jkDSIXRKWx/DcFcaCPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557

On 10/14/26 00:39, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to indicate that a field must be initialized explicitly by the
> user when the object is constructed. When an aggregate initializer or
> uninitialized variable omits an annotated field, Clang emits a
> -Wuninitialized-explicit-init warning (enabled by default).
> 
> Add the __require_explicit_initialization macro to
> include/linux/compiler_attributes.h (which is included by
> include/linux/compiler_types.h and include/linux/compiler.h) so kernel
> structs with error-prone initialization (such as mandatory callbacks or
> cleanup handlers) can enforce explicit initialization at compile time,
> as discussed at the Linux Plumbers Conference.

Oh yes please! That is so nice to have, I have like halve a dozen use cases for this in the stuff I'm maintaining just of hand :D

I'm not an expert for compiler interaction so I can't really review this patch, but please leave me a note when that is merged.

Thanks a lot for that,
Christian.

> 
> Also teach Sphinx (Documentation/conf.py), kernel-doc
> (tools/lib/python/kdoc/xforms_lists.py), and checkpatch.pl about the new
> attribute macro.
> 
> Link: https://lpc.events/event/20/contributions/2392/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  Documentation/conf.py                 |  1 +
>  include/linux/compiler_attributes.h   | 11 +++++++++++
>  scripts/checkpatch.pl                 |  1 +
>  tools/lib/python/kdoc/xforms_lists.py |  1 +
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 5ab26ce89daf..3e5cb9ca0970 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -203,6 +203,7 @@ c_id_attributes = [
>      "__noreturn",
>      "__packed",
>      "__pure",
> +    "__require_explicit_initialization",
>      "__section",
>      "__always_unused",
>      "__maybe_unused",
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 476c4c560d17..60522ab80c5a 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -322,6 +322,17 @@
>   */
>  #define __pure                          __attribute__((__pure__))
> 
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-explicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_explicit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-section-function-attribute
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-section-variable-attribute
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8a7787d228a6..4a3ae6b0100a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6871,6 +6871,7 @@ sub process {
>                                 "noreturn"                      => "__noreturn",
>                                 "packed"                        => "__packed",
>                                 "pure"                          => "__pure",
> +                               "require_explicit_initialization" => "__require_explicit_initialization",
>                                 "section"                       => "__section",
>                                 "used"                          => "__used",
>                                 "weak"                          => "__weak"
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index e3dda2fe8a53..32066fbbe763 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -36,6 +36,7 @@ class CTransforms:
>          (CMatch("CRYPTO_MINALIGN_ATTR"), ""),
>          (CMatch("__private"), ""),
>          (CMatch("__rcu"), ""),
> +        (CMatch("__require_explicit_initialization"), ""),
>          (CMatch("____cacheline_aligned_in_smp"), ""),
>          (CMatch("____cacheline_aligned"), ""),
>          (CMatch("__cacheline_group_(?:begin|end)"), ""),
> --
> 2.56.0.385.gd3acb90ef8-goog
> 

