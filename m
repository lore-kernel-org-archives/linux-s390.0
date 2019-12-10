Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46231 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJfg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Dec 2019 04:35:36 -0500
Subject: Re: [PATCH v2 1/4] mm: define MAX_PTRS_PER_{PTE,PMD,PUD}
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-2-dja@axtens.net>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <50ac061a-caa9-ed4e-c9a4-1f86bb0552bd@gmail.com>
Date: Tue, 10 Dec 2019 20:35:22 +1100
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-2-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com, christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com



On 10/12/19 3:47 pm, Daniel Axtens wrote:
> powerpc has boot-time configurable PTRS_PER_PTE, PMD and PUD. The
> values are selected based on the MMU under which the kernel is
> booted. This is much like how 4 vs 5-level paging on x86_64 leads to
> boot-time configurable PTRS_PER_P4D.
> 
> So far, this hasn't leaked out of arch/powerpc. But with KASAN, we
> have static arrays based on PTRS_PER_*, so for powerpc support must
> provide constant upper bounds for generic code.
> 
> Define MAX_PTRS_PER_{PTE,PMD,PUD} for this purpose.
> 
> I have configured these constants:
>  - in asm-generic headers
>  - on arches that implement KASAN: x86, s390, arm64, xtensa and powerpc
> 
> I haven't wired up any other arches just yet - there is no user of
> the constants outside of the KASAN code I add in the next patch, so
> missing the constants on arches that don't support KASAN shouldn't
> break anything.

I would suggest limiting this to powerpc for now and use

#ifndef MAX_PTRS_PER_PUD
#define MAX_PTRS_PER_PUD	PTRS_PER_PUD
#endif

style code in KASAN. It just keeps the change surface to a limited
value, till other arch's see value in migrating to support it.

> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h       | 3 +++
>  arch/powerpc/include/asm/book3s/64/hash.h    | 4 ++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 7 +++++++
>  arch/powerpc/include/asm/book3s/64/radix.h   | 5 +++++
>  arch/s390/include/asm/pgtable.h              | 3 +++
>  arch/x86/include/asm/pgtable_types.h         | 5 +++++
>  arch/xtensa/include/asm/pgtable.h            | 1 +
>  include/asm-generic/pgtable-nop4d-hack.h     | 9 +++++----
>  include/asm-generic/pgtable-nopmd.h          | 9 +++++----
>  include/asm-generic/pgtable-nopud.h          | 9 +++++----
>  10 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index d9fbd433cc17..485e1f3c5c6f 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -41,6 +41,7 @@
>  #define ARM64_HW_PGTABLE_LEVEL_SHIFT(n)	((PAGE_SHIFT - 3) * (4 - (n)) + 3)
>  
>  #define PTRS_PER_PTE		(1 << (PAGE_SHIFT - 3))
> +#define MAX_PTRS_PER_PTE	PTRS_PER_PTE
>  
>  /*
>   * PMD_SHIFT determines the size a level 2 page table entry can map.
> @@ -50,6 +51,7 @@
>  #define PMD_SIZE		(_AC(1, UL) << PMD_SHIFT)
>  #define PMD_MASK		(~(PMD_SIZE-1))
>  #define PTRS_PER_PMD		PTRS_PER_PTE
> +#define MAX_PTRS_PER_PMD	PTRS_PER_PMD
>  #endif
>  
>  /*
> @@ -60,6 +62,7 @@
>  #define PUD_SIZE		(_AC(1, UL) << PUD_SHIFT)
>  #define PUD_MASK		(~(PUD_SIZE-1))
>  #define PTRS_PER_PUD		PTRS_PER_PTE
> +#define MAX_PTRS_PER_PUD	PTRS_PER_PUD
>  #endif
>  
>  /*
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 2781ebf6add4..fce329b8452e 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -18,6 +18,10 @@
>  #include <asm/book3s/64/hash-4k.h>
>  #endif
>  
> +#define H_PTRS_PER_PTE		(1 << H_PTE_INDEX_SIZE)
> +#define H_PTRS_PER_PMD		(1 << H_PMD_INDEX_SIZE)
> +#define H_PTRS_PER_PUD		(1 << H_PUD_INDEX_SIZE)
> +
>  /* Bits to set in a PMD/PUD/PGD entry valid bit*/
>  #define HASH_PMD_VAL_BITS		(0x8000000000000000UL)
>  #define HASH_PUD_VAL_BITS		(0x8000000000000000UL)
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index b01624e5c467..209817235a44 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -231,6 +231,13 @@ extern unsigned long __pmd_frag_size_shift;
>  #define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
>  #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
>  
> +#define MAX_PTRS_PER_PTE	((H_PTRS_PER_PTE > R_PTRS_PER_PTE) ? \
> +				  H_PTRS_PER_PTE : R_PTRS_PER_PTE)
> +#define MAX_PTRS_PER_PMD	((H_PTRS_PER_PMD > R_PTRS_PER_PMD) ? \
> +				  H_PTRS_PER_PMD : R_PTRS_PER_PMD)
> +#define MAX_PTRS_PER_PUD	((H_PTRS_PER_PUD > R_PTRS_PER_PUD) ? \
> +				  H_PTRS_PER_PUD : R_PTRS_PER_PUD)
> +

How about reusing max

#define MAX_PTRS_PER_PTE  max(H_PTRS_PER_PTE, R_PTRS_PER_PTE)
#define MAX_PTRS_PER_PMD  max(H_PTRS_PER_PMD, R_PTRS_PER_PMD)
#define MAX_PTRS_PER_PUD  max(H_PTRS_PER_PUD, R_PTRS_PER_PUD)

Balbir Singh.
