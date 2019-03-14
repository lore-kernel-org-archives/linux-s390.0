Return-Path: <SRS0=dG1z=RR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
In-Reply-To: <20190307132015.26970-5-alex@ghiti.fr>
References: <20190307132015.26970-1-alex@ghiti.fr>
 <20190307132015.26970-5-alex@ghiti.fr>
Date: Thu, 14 Mar 2019 11:22:42 +0530
MIME-Version: 1.0
Message-Id: <87va0movdh.fsf@linux.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mike Kravetz <mike.kravetz@oracle.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-s390.vger.kernel.org>

Alexandre Ghiti <alex@ghiti.fr> writes:

> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
> ---
>  arch/arm64/Kconfig                           |  2 +-
>  arch/arm64/include/asm/hugetlb.h             |  4 --
>  arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
>  arch/powerpc/platforms/Kconfig.cputype       |  2 +-
>  arch/s390/Kconfig                            |  2 +-
>  arch/s390/include/asm/hugetlb.h              |  3 --
>  arch/sh/Kconfig                              |  2 +-
>  arch/sparc/Kconfig                           |  2 +-
>  arch/x86/Kconfig                             |  2 +-
>  arch/x86/include/asm/hugetlb.h               |  4 --
>  include/linux/gfp.h                          |  2 +-
>  mm/hugetlb.c                                 | 57 ++++++++++++--------
>  mm/page_alloc.c                              |  4 +-
>  13 files changed, 44 insertions(+), 49 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 091a513b93e9..af687eff884a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -18,7 +18,7 @@ config ARM64
>  	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> -	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
> +	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index fb6609875455..59893e766824 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -65,8 +65,4 @@ extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>  
>  #include <asm-generic/hugetlb.h>
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static inline bool gigantic_page_supported(void) { return true; }
> -#endif
> -
>  #endif /* __ASM_HUGETLB_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> index 5b0177733994..d04a0bcc2f1c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
> @@ -32,13 +32,6 @@ static inline int hstate_get_psize(struct hstate *hstate)
>  	}
>  }
>  
> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> -static inline bool gigantic_page_supported(void)
> -{
> -	return true;
> -}
> -#endif
> -
>  /* hugepd entry valid bit */
>  #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
>  

As explained in https://patchwork.ozlabs.org/patch/1047003/
architectures like ppc64 have a hypervisor assisted mechanism to indicate
where to find gigantic huge pages(16G pages). At this point, we don't use this
reserved pages for anything other than hugetlb backing and hence there
is no runtime free of this pages needed ( Also we don't do
runtime allocation of them).

I guess you can still achieve what you want to do in this patch by
keeping gigantic_page_supported()?

NOTE: We should rename gigantic_page_supported to be more specific to
support for runtime_alloc/free of gigantic pages

-aneesh


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
