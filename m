Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021119.outbound.protection.outlook.com [52.101.76.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE547CC96;
	Thu,  8 Oct 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451234; cv=fail; b=VgKrDqLs+n7QhMn1/6lmWYxNZUH6uOA1h67/ScsWc4pr8pXFA+I3coTBKKgb0JGHsnSn5wsMeG1cMsiHo+56KC1fzyPTcMStL+e7dZjmP2q+0eNEZwxwS+hsB0rVYYwi4vzI7Nufy+vDD+v8GcI3vx3C7EUZS40lg+kpI8mmxB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451234; c=relaxed/simple;
	bh=wtvnzL/Kn0HI0k7QQxqspt8rc8xVg1usSxpWUAewq9U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tu+sVqz8WH5P3FdkywXKoLFCBcJcbL6HOi1zUWrXS+gFZPBYFbES+MWJXtccsSlc6XyMlLO+9RyAq0g54y95PnkJaSTZeetS1Zj6UEcGfhRqUnJnhY9lh3AgVObYhvf8apfHbR3GyKNbz0Se6m7Qvfj765jylDEI2rzqn2N3bhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=INuFnRN8; arc=fail smtp.client-ip=52.101.76.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="INuFnRN8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWYCaXyqJi4ZWPF6qGx6PPahhWGHET64lXKc47FBjG7p2ybmlaSw3rSqwcUE/w6495DBBi00Msx1Pad4CqMHlQlVM/qJIb43Q5vas6TnhUz2FdJfY3o6B2lwCryb05C+irQEX9CK9zOP4PCPwtgggpydvj9tiGz5gFS6IjMBwPI6bAh3/u5LsJOt+jF5jWza6nAnQNwx7cGLV5HlOz3lAZgm2cs+gOYRAbkzrFUX7971nLmSWo/Vtm1aZx2dKuksQVEeWsAvwcOHAAlC2BAH2vckuGtUVDeqtRen6KsZsXENvEjTjnymAkIWFVRdV6NxSVMk43cdlaX24bz4xvnycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nChlZmlrvLWslmoho1/5aTc9r9JcLlsuI9ltEi1anog=;
 b=EWlQpJR1KYsOvtPjPBUbxCi4oXSmjhItlg/0F5aiUdQvXqIqDoCkmDk8i9oy4P1UZrVAO50NbeQ2qOyuzNSviNYashd2A8Iio0MztmgBkxQtH8DrkGsak+6QUS5bTPwAObwhg6jYu7nAYFdphTRQNywuypUTYJT/jkCyrJ9wD715p9Nijg4YPW7QZCwJmjdD5lPzVTSrr5yeqR3JkVu02DcEbyuv9s+t7ECmIaAbzjrAq85WOSi50rlHBNq4tuWFkqH6xfbV3WD7KshbsfI9ufAaE4aHcWpvGYL5/aaP+AGRDHan8ZnF+AtHymELnX+JmRaqAwL9nnBZoN4FVLBWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nChlZmlrvLWslmoho1/5aTc9r9JcLlsuI9ltEi1anog=;
 b=INuFnRN8HZTZOmhztmeE+FWSg1C4ii9V9BgUPQhgDJ8RNd+LGyBWi29rZlGXHvH4Z0GZukAbrrEUd0nzmbqjHKg79DgHWjVgSQ0gc4YaqpMmpuSQB1UaoPfWU4gZjqGOATUuLN7KeBByoJkt4/4D6lM0ztbm/o5DPbwPmtuEgBaTMP0iptchQ/0h5NNjuKKvSwcf3Zc7zJKLoWCgKKhqaM0rYpC5qZi9c5buiMvfMK5GC5lkxReIkyvtUoaD2PFCY5fggNJ/0O0fl7QtbwSDi8zqAFCsedpUclVBHil2D/RLwqNrbjWzjN+WTGlLd8zLfiUjSYM5paTFCQs0O7ZJJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB1086.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:20:17 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:20:17 +0000
Message-ID: <c24fc419-7bee-4fe4-be12-9aa378d49af1@gaisler.com>
Date: Thu, 8 Oct 2026 11:20:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: samuel.holland@sifive.com, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831054331.625505-9-anshuman.khandual@arm.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260831054331.625505-9-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::11) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB1086:EE_
X-MS-Office365-Filtering-Correlation-Id: 83646bf6-eeda-498e-e234-08df251d5e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NC/qpKPoxiyUAIaFboaEX4yQJbeZ+vmHWvsqeQ5kGT8l7X9fcYqp9eBx5WDlxiVvR0L+48Kj8haTuGmN+ee23fz3oSbjQL0jDYSXa+8gvblI86UZZh4H3rc1iI63OnAtUl/Bc29s8THJfx5bFeLN0emAE2uZAHoMFHy90APywhP9Z8AjykGKVGL0t0c2nvMe3PsGovHxRyjauii+CaAg7FIwI2CS/HOCQfII4YJSPtE4I0SRp+V6w4RmvmGuzeCsqZSrWw82tVXGVw0nRXYEEjprr2bBi/k2erOTWX+ty2uFPb9NPtUYLqYJ9PHu+KDHk4Q/vhMUK3yGm+xZ+4lHwTIkrPlcoR9I3RrI4QZlUmJ2jnb0OByBCKTN6WeW3SPL7RUqYcLSHKhK7REebKrFE0KT0iexUictJu2Fnotxo5BB3aWPdM5djXsume4Uu/+LrZgrVePGx8jVXrq7s0fx3tDDa8Its7qN4Q+p0W/zrq+NcYe8ULVC7XRuOjK0vRn8IJYPzelV1nlbTqr5dOdn1l7Ngd1FRLzsM1A/gAKUICvJl7+yqtc729F6ZYuOPgHw3w2EZKjndGEXmpox7kfKl6X1HCrim3tkhks2tAZ3SktjZtPITkfZDdVBJ/FfT8XA3Aw4kbnTbKOULc4nRgbN9ElLoKLj3Wvavjhkq2aZS/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qnc4WTMwaVBFYzJqcExMa05CL2Z6N2lPTHJIWHJ6RkNtSjQ4YTA2YWhOWHNP?=
 =?utf-8?B?c3h4MGNyVWpGRXAxYkV5a0VycHRMZmJ4cENISm5EeHF6NFR4U0grNHpzVFNw?=
 =?utf-8?B?SitEcWRXSExhV2gvMW5hZUQweld3N2JSdVEyZGRDckVZMXZ5SlNzSklhcmk5?=
 =?utf-8?B?VEt1RHBCbXFKb0lDcVBwRXdFOHRDUTNqemh4TFExRnJhM0ZzTTR2N0JVYlZ1?=
 =?utf-8?B?VlA1YXo4RHIrbFRpa2QxeFM0VWJwVzQ1WGlaQmdBTFhnK1VLaHllLzdqSFNL?=
 =?utf-8?B?WE9BWUlhaHJKZkNPd0kvZ2U5TEZTUWZHOHVtMTduYW1wdUlaTTIxeFFmU3Qw?=
 =?utf-8?B?QWxmQ1NNSHgraGRsb1pkbmVORHF2eDF0bUFWTjBiNXFzZDczRDZ5R2xqdFRR?=
 =?utf-8?B?Kzhmc3ArU25pcDQyUEpkekh5RmxrVnV0TFVCajVUN2czMGc4UGFqZEx2SEpl?=
 =?utf-8?B?NVVVcjBRaFoxb24wVmZrTVBOR2FoYnRaUFpZSmxXcnVvV2w5TzEzaVgzODNh?=
 =?utf-8?B?eWdPV0J4ekp4bkVpdGUxY2RLYTRSWGZqSUlwVHNRdlFyMVEwNTZLcVQ3dlh4?=
 =?utf-8?B?UGdtOGNwb2g0d2MwQ0Y3ajRUVWRMc1dIbnRsVTFpSTJtclZzNFFPc255cnhQ?=
 =?utf-8?B?TU5abWFjbjBrS25UU01WMzhjdU9VZTZuVUpaQ2xBSHBSOWlGejFWK3RLaldG?=
 =?utf-8?B?RkJERVNnbHJnWFZTUkxTVjBlVTJ1d1JNdmkwUWhROHZtMUM2dlJJeHQyRmdl?=
 =?utf-8?B?UW5MU0cySjFHWUpkZ1RQSTA3SE82Rlczb1hqakhiVi80U3cxT2swK0t5OVcw?=
 =?utf-8?B?UjkyekRsR0JuZTk3QWZuR0RwYjV1SUNUbnNwaFBOQjA1TEdKWFRRRTNNNyt0?=
 =?utf-8?B?Y2YrTmZralIvNllYNG1aKzRONTJrZWYvTFFBbjg1S0lEcmZ3amo4UVMwWTZ6?=
 =?utf-8?B?Sm1VZXc4aStLMWx4dE9PWElQZlg4eXhaRGMwcHlVWFlJNE53NXh2ejl3NVZH?=
 =?utf-8?B?Y0dyaVc0bm9xVXpDV00ySWtnT1AzSElIQTJieHlKTys2a1ZpRDdUVElIKzBw?=
 =?utf-8?B?Yk9sRWlTQTlKeUZpQUYydnIvazY3ZjVBYXkzZXdZWjAxRlYrYXAxKy9PU2gr?=
 =?utf-8?B?UFo1U0hFSGRzUUZwYmFmalNmVTBrNHVmTmVSVVEwUGFxL0VlWHVCL3dIMFhN?=
 =?utf-8?B?ajNyNDJwblBVbjRDR1dvVHpuNEx6VUk5MldTY0ptMEgrNUZVUlRCd3kzMlB6?=
 =?utf-8?B?bnNBb1lya3pVd2g1YzJwVFpHNzUrRlJEVHdyMGg0dDBQck9zL0w0SGRjcC9S?=
 =?utf-8?B?NHM3L0RyU3hIaWl6QnFzbEcwZ3NwWG1uc0FsOGg4citQTTFRTWdKdEdORi9R?=
 =?utf-8?B?WEwySCtxUDBxYkRmMzhmNHVSVWR5SjgzeEt1WFN3U3lVKzdZY2k2UzBURmda?=
 =?utf-8?B?YXUvTFo3c0EvTVNnR0dieTh2VzRrWGJCY0prTWc0Z04vWXpJbFFVcjZLc3hF?=
 =?utf-8?B?WDRBbUFkbzBTMzMzcnIxTGlJTW9QOW1zVU5HSkc4NFNkLzczV3hYTUtzcjRY?=
 =?utf-8?B?WitCZ1g3SzNjbXFONGNDWEcxWlUyR0piM2p6dThwQlREaXFzWDhoYlc5Unlk?=
 =?utf-8?B?dWpjRk00c25DQW9ITEVTU0ZITDRJSm50MWZoeGNFRjlVZzlqZXBxVmIwbnFL?=
 =?utf-8?B?bnRRakpsRC82V3R4ZzBRbGl0aEtBM1A0UlduY2xCUUp5Q05VVXNpNFgxM0tS?=
 =?utf-8?B?U0loRGpFckpUUElXTkRSV01VV3hXN3F0QXBOMjRxWUJYY0V6QTdEZThMZDEv?=
 =?utf-8?B?SU04Y0VqU21ydmNCS3VMOXNQK2psemZXRHk4UDZPOFpvcmV6eFlndi9ocm9v?=
 =?utf-8?B?eXRVampFMmZvNVBQSCsxVGxkbXVCcENac0RGOXhnMldaVmhaelhlcXB0dnB3?=
 =?utf-8?B?RFdack1RQVdGVU94RWxQQXBsdlNrd0pTRkVneVFVRXZybnM0ZUVLMHYyRDVC?=
 =?utf-8?B?UkVKb0h2Qk13VVNiOXNkUWs1RHpKd2UvU2lRVlgvRnU5VlJ3ell6czZPN1Bk?=
 =?utf-8?B?d2VHdDZVUTdaYWIrYkdmYXFmNktSQjhyNWVlRHNOZ2c3RTJyL3puSm40V2lQ?=
 =?utf-8?B?RnJwQjhzRnp0bUZVeWx0bUxVN0E3NlJadU9oOGFDOGNRbFVjdzRxNjl4ek8v?=
 =?utf-8?B?UzFka04xY01xUEV4TmRoc29xUEcydDM1Z05kNWhmMjl3OVhHTnJDUVJ5WGth?=
 =?utf-8?B?cFFId1A1RHJEbitNS012U2x6NTcwM0gvbk9rekpFYVZZbG4zYS84elM5b2lY?=
 =?utf-8?B?d3N0d0dNS3h1RWRYR0NLUmFaeVVVWlByVURvc3JuTFh1SHp2SkxtSVpGZUE5?=
 =?utf-8?Q?yjjhfEohdeTOoAqE=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83646bf6-eeda-498e-e234-08df251d5e2c
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:20:17.5038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BZfB4EAaSFJ84qYftmRVMohK/eymk8QLHXJzzFm4elUHya77EOOlIY25xck2qu/+rvHfHMgpADg5257wP54q4lxf3y+8uFBxp0svqv6SU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1086

On 2026-08-31 07:43, Anshuman Khandual wrote:
> There are no more users left for any pxd_ERROR() either in generic MM or in
> the platform MM. Hence all these platform macros along with their generic
> fallback could be dropped across the tree.
> 
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
...>  /*
>   * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
>   * are !pte_none() && !pte_present().
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index f89b1250661d..5a5f54a090f5 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -40,9 +40,6 @@ void load_mmu(void);
>  unsigned long calc_highpages(void);
>  unsigned long __init bootmem_init(unsigned long *pages_avail);
>  
> -#define pte_ERROR(e)   __builtin_trap()
> -#define pmd_ERROR(e)   __builtin_trap()
> -#define pgd_ERROR(e)   __builtin_trap()
>  
>  #define PTRS_PER_PTE    	64
>  #define PTRS_PER_PMD    	64
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 0837ebbc5dce..44d1333065a6 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -96,16 +96,6 @@ bool kern_addr_valid(unsigned long addr);
>  #define PTRS_PER_PUD	(1UL << PUD_BITS)
>  #define PTRS_PER_PGD	(1UL << PGDIR_BITS)
>  
> -#define pmd_ERROR(e)							\
> -	pr_err("%s:%d: bad pmd %p(%016lx) seen at (%pS)\n",		\
> -	       __FILE__, __LINE__, &(e), pmd_val(e), __builtin_return_address(0))
> -#define pud_ERROR(e)							\
> -	pr_err("%s:%d: bad pud %p(%016lx) seen at (%pS)\n",		\
> -	       __FILE__, __LINE__, &(e), pud_val(e), __builtin_return_address(0))
> -#define pgd_ERROR(e)							\
> -	pr_err("%s:%d: bad pgd %p(%016lx) seen at (%pS)\n",		\
> -	       __FILE__, __LINE__, &(e), pgd_val(e), __builtin_return_address(0))
> -
>  #endif /* !(__ASSEMBLER__) */

Perhaps a bit of a pity to lose the printing of the address of the pxd
that a number of architectures did before this series, but i have no
strong opinion.

Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Cheers,
Andreas

