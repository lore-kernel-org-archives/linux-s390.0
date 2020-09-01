Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgIADSt (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 23:18:49 -0400
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 05/13] mm/debug_vm_pgtable/savedwrite: Enable
 savedwrite test with CONFIG_NUMA_BALANCING
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-6-aneesh.kumar@linux.ibm.com>
Message-ID: <0c1ba151-b5c4-27a4-d500-4f416d0beedc@arm.com>
Date: Tue, 1 Sep 2020 08:48:11 +0530
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-6-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> Saved write support was added to track the write bit of a pte after marking the
> pte protnone. This was done so that AUTONUMA can convert a write pte to protnone
> and still track the old write bit. When converting it back we set the pte write
> bit correctly thereby avoiding a write fault again. Hence enable the test only
> when CONFIG_NUMA_BALANCING is enabled and use protnone protflags.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/debug_vm_pgtable.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 28f9d0558c20..5c0680836fe9 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -119,10 +119,14 @@ static void __init pte_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  {
>  	pte_t pte = pfn_pte(pfn, prot);
>  
> +	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
> +		return;
> +
>  	pr_debug("Validating PTE saved write\n");
>  	WARN_ON(!pte_savedwrite(pte_mk_savedwrite(pte_clear_savedwrite(pte))));
>  	WARN_ON(pte_savedwrite(pte_clear_savedwrite(pte_mk_savedwrite(pte))));
>  }
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>  {
> @@ -235,6 +239,9 @@ static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>  {
>  	pmd_t pmd = pfn_pmd(pfn, prot);
>  
> +	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
> +		return;
> +
>  	pr_debug("Validating PMD saved write\n");
>  	WARN_ON(!pmd_savedwrite(pmd_mk_savedwrite(pmd_clear_savedwrite(pmd))));
>  	WARN_ON(pmd_savedwrite(pmd_clear_savedwrite(pmd_mk_savedwrite(pmd))));
> @@ -1020,8 +1027,8 @@ static int __init debug_vm_pgtable(void)
>  	pmd_huge_tests(pmdp, pmd_aligned, prot);
>  	pud_huge_tests(pudp, pud_aligned, prot);
>  
> -	pte_savedwrite_tests(pte_aligned, prot);
> -	pmd_savedwrite_tests(pmd_aligned, prot);
> +	pte_savedwrite_tests(pte_aligned, protnone);
> +	pmd_savedwrite_tests(pmd_aligned, protnone);
>  
>  	pte_unmap_unlock(ptep, ptl);
>  
> 

There is a checkpatch.pl warning here.

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
Saved write support was added to track the write bit of a pte after marking the

total: 0 errors, 1 warnings, 33 lines checked

Otherwise this looks good. With the checkpatch.pl warning fixed

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
