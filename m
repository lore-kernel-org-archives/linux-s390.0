From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RESEND PATCH v3 09/11] powerpc/mm/radix: mark
 __radix__flush_tlb_range_psize() as __always_inline
Date: Mon, 29 Apr 2019 17:35:53 +0200
Message-ID: <40b48947-b80e-7971-376d-52b594e26d17@c-s.fr>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-10-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423034959.13525-10-yamada.masahiro@socionext.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Mathieu Malaterre <malat@debian.org>
List-ID: <linux-s390.vger.kernel.org>



Le 23/04/2019 à 05:49, Masahiro Yamada a écrit :
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.

How did you identify the functions requiring __always_inline as this one 
? Just by 'test and see if it fails', or did you have some script or so ?

Here the problem is that one of the parameters of the function are used 
as "immediate" constraint for the inline assembly, therefore requiring 
the function to always be inline.

I guess this should be explained in the commit log and I'm wondering how 
you ensure that you did identify all functions like this.

Christophe

> 
> If it is enabled for powerpc, the following error is reported:
> 
> arch/powerpc/mm/tlb-radix.c: In function '__radix__flush_tlb_range_psize':
> arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't match constraints [-Werror]
>    asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>    ^~~
> arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
>    - split into a separate patch
> 
>   arch/powerpc/mm/tlb-radix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 6a23b9ebd2a1..a2b2848f0ae3 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -928,7 +928,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
>   	tlb->need_flush_all = 0;
>   }
>   
> -static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
> +static __always_inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
>   				unsigned long start, unsigned long end,
>   				int psize, bool also_pwc)
>   {
> 
