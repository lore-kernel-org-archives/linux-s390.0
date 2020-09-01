Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgIADNe (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 23:13:34 -0400
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 01/13] powerpc/mm: Add DEBUG_VM WARN for pmd_clear
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-2-aneesh.kumar@linux.ibm.com>
Message-ID: <e90b9886-1fbf-eacc-5108-acc1af2cac59@arm.com>
Date: Tue, 1 Sep 2020 08:42:56 +0530
MIME-Version: 1.0
In-Reply-To: <20200827080438.315345-2-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>



On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
> With the hash page table, the kernel should not use pmd_clear for clearing
> huge pte entries. Add a DEBUG_VM WARN to catch the wrong usage.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 6de56c3b33c4..079211968987 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -868,6 +868,13 @@ static inline bool pte_ci(pte_t pte)
>  
>  static inline void pmd_clear(pmd_t *pmdp)
>  {
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && !radix_enabled()) {
> +		/*
> +		 * Don't use this if we can possibly have a hash page table
> +		 * entry mapping this.
> +		 */
> +		WARN_ON((pmd_val(*pmdp) & (H_PAGE_HASHPTE | _PAGE_PTE)) == (H_PAGE_HASHPTE | _PAGE_PTE));
> +	}
>  	*pmdp = __pmd(0);
>  }
>  
> @@ -916,6 +923,13 @@ static inline int pmd_bad(pmd_t pmd)
>  
>  static inline void pud_clear(pud_t *pudp)
>  {
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && !radix_enabled()) {
> +		/*
> +		 * Don't use this if we can possibly have a hash page table
> +		 * entry mapping this.
> +		 */
> +		WARN_ON((pud_val(*pudp) & (H_PAGE_HASHPTE | _PAGE_PTE)) == (H_PAGE_HASHPTE | _PAGE_PTE));
> +	}
>  	*pudp = __pud(0);
>  }

There are two checkpatch.pl warnings for this patch.

WARNING: line length of 105 exceeds 100 columns
#27: FILE: arch/powerpc/include/asm/book3s/64/pgtable.h:876:
+               WARN_ON((pmd_val(*pmdp) & (H_PAGE_HASHPTE | _PAGE_PTE)) == (H_PAGE_HASHPTE | _PAGE_PTE));

WARNING: line length of 105 exceeds 100 columns
#41: FILE: arch/powerpc/include/asm/book3s/64/pgtable.h:931:
+               WARN_ON((pud_val(*pudp) & (H_PAGE_HASHPTE | _PAGE_PTE)) == (H_PAGE_HASHPTE | _PAGE_PTE));

total: 0 errors, 2 warnings, 26 lines checked
