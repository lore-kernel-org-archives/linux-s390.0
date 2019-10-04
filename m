Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387771AbfJDJBH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Oct 2019 05:01:07 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x948bZYb057690
        for <linux-s390@vger.kernel.org>; Fri, 4 Oct 2019 05:01:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ve1er3t64-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 04 Oct 2019 05:01:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 4 Oct 2019 10:01:03 +0100
Subject: Re: [PATCH] s390/mm: fix -Wunused-but-set-variable warnings
References: <1570138596-11913-1-git-send-email-cai@lca.pw>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 4 Oct 2019 11:00:59 +0200
MIME-Version: 1.0
In-Reply-To: <1570138596-11913-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <41a54dc6-65ed-49dd-2925-4bed10af511a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@lca.pw>, heiko.carstens@de.ibm.com, gor@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 03.10.19 23:36, Qian Cai wrote:
> Convert two functions to static inline to get ride of W=1 GCC warnings
> like,
> 
> mm/gup.c: In function 'gup_pte_range':
> mm/gup.c:1816:16: warning: variable 'ptem' set but not used
> [-Wunused-but-set-variable]
>   pte_t *ptep, *ptem;
>                 ^~~~
> 
> mm/mmap.c: In function 'acct_stack_growth':
> mm/mmap.c:2322:16: warning: variable 'new_start' set but not used
> [-Wunused-but-set-variable]
>   unsigned long new_start;
>                 ^~~~~~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Thanks applied. 
> ---
>  arch/s390/include/asm/hugetlb.h | 9 +++++++--
>  arch/s390/include/asm/pgtable.h | 3 ++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index bb59dd964590..de8f0bf5f238 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -12,8 +12,6 @@
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
>  
> -
> -#define is_hugepage_only_range(mm, addr, len)	0
>  #define hugetlb_free_pgd_range			free_pgd_range
>  #define hugepages_supported()			(MACHINE_HAS_EDAT1)
>  
> @@ -23,6 +21,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  			      unsigned long addr, pte_t *ptep);
>  
> +static inline bool is_hugepage_only_range(struct mm_struct *mm,
> +					  unsigned long addr,
> +					  unsigned long len)
> +{
> +	return false;
> +}
> +
>  /*
>   * If the arch doesn't supply something else, assume that hugepage
>   * size aligned regions are ok without further preparation.
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 36c578c0ff96..19c2cf001df3 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1269,7 +1269,8 @@ static inline pte_t *pte_offset(pmd_t *pmd, unsigned long address)
>  
>  #define pte_offset_kernel(pmd, address) pte_offset(pmd, address)
>  #define pte_offset_map(pmd, address) pte_offset_kernel(pmd, address)
> -#define pte_unmap(pte) do { } while (0)
> +
> +static inline void pte_unmap(pte_t *pte) { }
>  
>  static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
>  {
> 
