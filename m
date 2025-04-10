Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1331EDA28;
	Thu, 10 Apr 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308979; cv=fail; b=KfYBCaTeAAhCCQhVHJC0I81qb/0tNh0ARvr+0R8lg4//9X8bGfEM5IAKqzG8GV/4MKPoa2fh2VcL3cInEO/+XeGCpWp/oKcy3S8lP3jdBdYme/GvT6tQJYRygsfuzu247C36evkr/ZU5cy17emCL5gKvaJaweTy9FPjoJ8CmiH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308979; c=relaxed/simple;
	bh=cFH7NXjf7CDk1JhXteSd8GkJ7n1BY38hrjRUGsYEEDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XreRYGOMQBlvGnzHvNEl9bzmGUvx4cJVE0rPFwsFpFK1HLPQOaHqH6/vtcUMXStXPfq/zP6jMe0rA/ALbIHZx3V3e/lQPF/9crkd2zLEj8FO2B0WCf+rd5LA5qsd+MDYdUPHOfVqdn5RlG1fzc7W6/N0OHSHEoajAATquwf4xwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYMKB6hj; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYMKB6hj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lhk8zT5OAhV5jQ//G1dQiGIGeEMMhdjbw34LPqe9dJ2rvIG49eNVNHdNC63NWyMvk7JNpVZEK7sfauc+bF8ZOWTzWF2/OioPs3wgi9OB2qlsK6cUnv8sJTdY+Djs/WO2T1cMjIXhzBRecjbjzyUHQ9t8f2hACMyQqRiwprSyX2w+r1RVjHHHa2cYJyjTcWZyq5Xk9vyvD1d7gjpvxgepWdIOAdPaL9Ypm/WzjzlbtWgMCElXhoQ4EAgYOtnIXLw6/FGWDwwyUQW/bEhncUlaKkmYIgQJrK90TEZjCY643jaTME3T0c7mPe5oeO7Sxknp+OGHYlDIb4M4VhvYpRZ4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy6uXE3MAyaRN/+uuTOYpKb7uc+bMfTV0PsTtLudlio=;
 b=joJ8upQEk797SLKKqtip51gPix2Xr+MNDPAvB8bqGsMh76+G4DGlvG4I5heUqr0ZFvn56DGS1K+WgrF9m6C2W4I9IqN9TzGKMYJNTZGCrURsHrQ49bPprpaKvbRLN9GBKHpXIXMjnDfkceA5blhdP7/k9qnoPPil0BHMWLmJnCQM2z8Y3bBUZy16gGo3lumCa8d/S9kmc8tdg7NIzy39I96nVMiPcknK/gSaFN/QCvz06iofxSRZipHsBXa6buROM3cX/q/uwO8CH1SseLQvohs0GRk7NR1URbw6QZAEWeS6fvG+gnAxb/JbXvKzhQj6nq2Fj4yf+sMbFXg0ziTX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy6uXE3MAyaRN/+uuTOYpKb7uc+bMfTV0PsTtLudlio=;
 b=AYMKB6hjuGyqNCp3HDFkDCn79/bRQQKsLUF6joxwS8WcKFBTCpuc7xoVuU82XQ9AXgNkvT+pIUZYkdxzcVacfO2ATlBCf8taSTl+S1IGvIlD6Vfxa4MOMRwW7lTB3JBQ/5IbjvDe/lxc0C7iWJ29PdB72diz6/7UQKsAKb1dWw/ND6T7opwuFFsuh4Pax8HK1JBO9epSjckmzv8XJpZMr/CXtOJ4Zbk99tEIn+0ezhMCNbLXMxMeKtdQd5HtuUMAeRwMU/xyJGzwEVK58Y2Jeebe1NPOjObS4HOwIQSDo+USruer6VFXPnBfjI8vkl1V6mByReqS2PseabLzyhPCnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.35; Thu, 10 Apr 2025 18:16:13 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 18:16:13 +0000
From: Zi Yan <ziy@nvidia.com>
To: nifan.cxl@gmail.com
Cc: willy@infradead.org, mcgrof@kernel.org, a.manzanares@samsung.com,
 dave@stgolabs.net, akpm@linux-foundation.org, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, will@kernel.org,
 aneesh.kumar@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 linux-s390@vger.kernel.org, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] mm: Introduce free_folio_and_swap_cache() to replace
 free_page_and_swap_cache()
Date: Thu, 10 Apr 2025 14:16:09 -0400
X-Mailer: MailMate (2.0r6241)
Message-ID: <C40778F7-6A22-4A0E-9566-9D3ACC697EA7@nvidia.com>
In-Reply-To: <20250410180254.164118-1-nifan.cxl@gmail.com>
References: <20250410180254.164118-1-nifan.cxl@gmail.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0325.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 900ed068-6711-44e7-cc94-08dd785bc6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ylmC62dJANimXmbV96AGo219sVQ+sHr0QwkHGFDOuOB1u2oPznVgzuy5mreC?=
 =?us-ascii?Q?lnlf+xrsUBuZQxxdQOuoX3Kzb9jRv29yqWSEfWcdd8iI4iBw8/MOO6uNVPcy?=
 =?us-ascii?Q?CxxG+bhGNA69SseGLaULCx0VPPqt5uKM+kGZ7G1wS9pBrUmQCYNXTRfJafIb?=
 =?us-ascii?Q?guh8rgUkiph5w55qGM6jY6DW/hw8zVCu5HmN+DP1ln5FUt3zJEZfGvSlRujU?=
 =?us-ascii?Q?63Z8mFZyzbOVIv/6pcjiIA3ICPg3KZ6Jts7jk3leQVlA0dNuedp6qOKVpahd?=
 =?us-ascii?Q?KhWjBAcpgpJvn6H0sFRPQBUzG/svIc2x7rVE+r3PoB+oOZ00kvwVdxCuzjSl?=
 =?us-ascii?Q?IZ7fN7UqzQ8pe7bF6QLe4NugjsOavlVW9RypdtRiAYeHnnfdhGvDY76hkQ5e?=
 =?us-ascii?Q?lm0P4EhhElCcGV4Y66NyHzfXv5v8QoBXwO/xMZyLHiXteVlfz13ZEaxD7D6t?=
 =?us-ascii?Q?YEskWaTESOjHF5Drb1Zo4c9XOmdIh8qr1U0HqCbAV1DXdRnva2Ra67j6xIPd?=
 =?us-ascii?Q?8lujDgNrlsJXHKVFglZF4XAJ1ZLQJEkePsjvNKP53tmv7O9RR99eXlDEk2YE?=
 =?us-ascii?Q?hI9rjybAMvKNaiEWvSol36UKLOSlZBe/sUdVS8k08H9Ge5vbdA2wBUjq9wp4?=
 =?us-ascii?Q?xum/PDxIaSBlfCUpwUq++kPESc7ed+NnKLu8j8jhGqqZgLcVcWPK/awniHMy?=
 =?us-ascii?Q?GM/rIRGrAe3UYhS787TxYgHZY6Ir7mWG3c0cd7cIyaMxsZPiIArQbajFLq8t?=
 =?us-ascii?Q?1dNbHBHlZdN4HTfo82f2+QEOGn9C2LAJg1s1vtsg/JZgcuwcBfWva9459Evp?=
 =?us-ascii?Q?whw4+NRNeR1moOykR5x+7qFL7S5wPfkq27bJiTYmigTUmUXsBjpFI/oVK6zI?=
 =?us-ascii?Q?NsFlShdialfSlZOdYvEKZLbC80LZuSMYaUaf755D071p7appSw1jxC5iOH8x?=
 =?us-ascii?Q?AfNUfVscimsebRP1BQzd6cLyu1cM0jEGN2DsRfNX2+hXldyewAJUhnqs/tst?=
 =?us-ascii?Q?WMn/GJcAnldLJJht8MZgbpXHSaiwJem0Xdnt+qZ7HZUS9fWpy2fV0OSUiOMv?=
 =?us-ascii?Q?9XrnJfLCzaPykqanh9AlQICbr9LVVLX47cU5wYw8mcm8UHib2azRUZkuYkfO?=
 =?us-ascii?Q?QyveSn/6s2BAKPBPWULtivB9Q4kfi4qNro/PLWnn9+Vh4oHHJ/t5w5AXpJdE?=
 =?us-ascii?Q?7Ul3HElsbjLPa/OTOp6ZfC96igarfih84f6WAKZHHnThLv/U8nK/N1SF5xNo?=
 =?us-ascii?Q?ltjmPfVOwN0T4iva8grlulYCRn+fvdGNqp1Oo63R8+orJhXWVaA8jlv0vyQf?=
 =?us-ascii?Q?rtCKeFPd46m6zYy5fyBDbcS6dqB6WKenNfwMHcgMzCWsfGxaZ8A6BlNlN+if?=
 =?us-ascii?Q?lPKbX/oVMBcQ398u+MuUuXiZm2q/espujfE/7OwHS7lnhRYfRa95Eu71fweP?=
 =?us-ascii?Q?okckk8NrgVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wz9cN6uYiBAQKrY3KG/dtWez/CdEIMk3/RKgvOgiEstqNGLRwOFlcRwd9gve?=
 =?us-ascii?Q?Vhs0W5aD9TPMc0qJZpGwezcD1zE2gf5wPaaxav1BHjxTlcGYsJEjN5t3n09a?=
 =?us-ascii?Q?TnhRxBe8+3bPLdoD8kQwwfLbUdIWpdmFGR6dXy3YmESqGYAaAbIIaK3kv1Dv?=
 =?us-ascii?Q?R7j8jPw7HlJW9ofWdzqoncHxXTKItDwwz6bnNHeE5hBxhu3Za2rc/6mQttah?=
 =?us-ascii?Q?IyOwoBBhZjpH/Ne5fOde8Iq93uWDeXPUjcU6iSH02v7UWoeaAcE3rIQ/yIuG?=
 =?us-ascii?Q?tuYxYHbxRZn6wzJ+oLaQBErQ3u0e16aN3mMNWQlkyXsKpjj+QK/DCGvXn32b?=
 =?us-ascii?Q?sZ86Gs8t3o/92AqvYVkVt0t9+IYfsz32TxR0/zfb/CwJGB7e85pJ70qUdf9V?=
 =?us-ascii?Q?eC0TXU5Ea6Fk/VTF04WoHWdAB5kgbuYn441j3lrS+vjUkqDefBWsMpXJCQrS?=
 =?us-ascii?Q?ttmqXz4Iz05NtCBZM0nE3Fbzy94Z+NdxBWcbjI9lrDjDX2gjMtsoHuQPcBSd?=
 =?us-ascii?Q?Gz8TrHObs5YfhzH8mNz6xE1yN9vJaenHSXiKjCkKgwFHVaOMgoJH0v+Jltih?=
 =?us-ascii?Q?2COj5VMrpcDllDSPcyrftZV0BMOSnkXpXFuD6SsUZGkGbdQFCbC60ngui5wU?=
 =?us-ascii?Q?XWDWb5JjNZu4oybbKDUtxT8vsXUMbc1E10/U9joP/697X0c3hoe5MHYoJQXh?=
 =?us-ascii?Q?TrlN9UTkkmrMnhum3gJUH5UaQjWKUjwXxE/l7RWGmtGou9ojUPy2wfH9TmnX?=
 =?us-ascii?Q?7SjfHrmrnkXxG7i+pKzGy1xYlp8nQ5Jush+ryMThf53UkOdsSbkqV5iusp3m?=
 =?us-ascii?Q?WPHiQCWIDmh3O7UY3TILrYaQt3lEQH2115AUykcVuPrT9+yVjd6HYO6xUdQp?=
 =?us-ascii?Q?4oCWfKT90T4i9C6xwMcbah+JpC6+EkGgHItbzhw7Nnwv7eOrCxeIPTH8b/Au?=
 =?us-ascii?Q?DOJ9YQWxw944D9PbGs+ygbgAkiZhkUsC8tUqdc/2hmNByoTRc/xXx4uPidCa?=
 =?us-ascii?Q?890PkcROJvIgH3a514XYlb7u2J9X3+h4hjKLGv2eDuWG84FyRlWySi6kNEUO?=
 =?us-ascii?Q?T+TJPE4n789920I9lrTNACmvObSRlHEij2XFd4exlhYrCepd/tmznPhNuysx?=
 =?us-ascii?Q?RWBBZxgAt4yNCdOTynoKrseLac6hHsCpBDlz5cwVNOmGGWi8D/7T3TZpAAV7?=
 =?us-ascii?Q?HaSjp1oSr9u1evgvL75fLapge07djmQxahdcdISSJcnXYVGThusAzzozg77I?=
 =?us-ascii?Q?xMg6f8L4rHquNXji7CELdZrmg07l2GnQWmFi62ZaKXEA7nzzLg4SpbOM7Z2y?=
 =?us-ascii?Q?Dj8quRfXQqQbhMSA48zWaLDzCLY9Kx6xC50F+6jgR7aq7Kkava1FtQz3h+YD?=
 =?us-ascii?Q?uP5GWKz4nijM5VAhSgexNLbpsgnz033XqN3t7OJmKO5Mc3YpcaPdNlRhxJXI?=
 =?us-ascii?Q?M7R6p1GNQMpafOFFF/1Knl/jDA3eUW6ypTHfRLW7w5j4Kw/HCfy5xGWfmOqz?=
 =?us-ascii?Q?YUOCvy6LjhyV2sGe4BIuGeAIQXqdTOH8N50LvLb9TGqpXWat87kXftqU4mTJ?=
 =?us-ascii?Q?DfrybbTV7EeIkyd6gWmjvhReK/38UW9xjxxgWnhF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900ed068-6711-44e7-cc94-08dd785bc6d7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:16:13.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VbtC54JCPGegL9RTiujk1vT3xciDKFurofwdqLQsax3zSpd0BDq22ZCSAZs2j2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

On 10 Apr 2025, at 14:00, nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
>
> The function free_page_and_swap_cache() takes a struct page pointer as
> input parameter, but it will immediately convert it to folio and all
> operations following within use folio instead of page.  It makes more
> sense to pass in folio directly.
>
> Introduce free_folio_and_swap_cache(), which takes folio as input to
> replace free_page_and_swap_cache().  And apply it to all occurrences
> where free_page_and_swap_cache() was used.
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  arch/s390/include/asm/tlb.h |  4 ++--
>  include/linux/swap.h        | 10 +++++++---
>  mm/huge_memory.c            |  2 +-
>  mm/khugepaged.c             |  2 +-
>  mm/swap_state.c             |  8 +++-----
>  5 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index f20601995bb0..e5103e8e697d 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -40,7 +40,7 @@ static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>  /*
>   * Release the page cache reference for a pte removed by
>   * tlb_ptep_clear_flush. In both flush modes the tlb for a page cache page
> - * has already been freed, so just do free_page_and_swap_cache.
> + * has already been freed, so just do free_folio_and_swap_cache.
>   *
>   * s390 doesn't delay rmap removal.
>   */
> @@ -49,7 +49,7 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>  {
>  	VM_WARN_ON_ONCE(delay_rmap);
>
> -	free_page_and_swap_cache(page);
> +	free_folio_and_swap_cache(page_folio(page));
>  	return false;
>  }

__tlb_remove_page_size() is ruining the fun of the conversion. But it will be
converted to use folio eventually.

>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index db46b25a65ae..9fc8856eeed9 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -450,7 +450,7 @@ static inline unsigned long total_swapcache_pages(void)
>  }
>
>  void free_swap_cache(struct folio *folio);
> -void free_page_and_swap_cache(struct page *);
> +void free_folio_and_swap_cache(struct folio *folio);
>  void free_pages_and_swap_cache(struct encoded_page **, int);
>  /* linux/mm/swapfile.c */
>  extern atomic_long_t nr_swap_pages;
> @@ -522,8 +522,12 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  	do { (val)->freeswap = (val)->totalswap = 0; } while (0)
>  /* only sparc can not include linux/pagemap.h in this file
>   * so leave put_page and release_pages undeclared... */
> -#define free_page_and_swap_cache(page) \
> -	put_page(page)
> +#define free_folio_and_swap_cache(folio)	\
> +	do {					\
> +		if (!folio_test_slab(folio))	\
> +			folio_put(folio);	\
> +	} while (0)
> +

Like Matthew pointed out in another email, the test is not needed.

Otherwise, it looks good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
