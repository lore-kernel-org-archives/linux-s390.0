Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:47987 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbfHTQee (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 12:34:34 -0400
Subject: Re: [PATCH v2 2/2] powerpc: support KASAN instrumentation of bitops
References: <20190820024941.12640-1-dja@axtens.net>
 <20190820024941.12640-2-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <cb205dfa-bdea-8320-5aae-9d5d5bd98c91@c-s.fr>
Date: Tue, 20 Aug 2019 18:34:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190820024941.12640-2-dja@axtens.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Daniel Axtens <dja@axtens.net>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com, Nicholas Piggin <npiggin@gmail.com>



Le 20/08/2019 à 04:49, Daniel Axtens a écrit :
> The powerpc-specific bitops are not being picked up by the KASAN
> test suite.
> 
> Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
> headers. They require that arch-specific versions of bitop functions
> are renamed to arch_*. Do this renaming.
> 
> For clear_bit_unlock_is_negative_byte, the current implementation
> uses the PG_waiters constant. This works because it's a preprocessor
> macro - so it's only actually evaluated in contexts where PG_waiters
> is defined. With instrumentation however, it becomes a static inline
> function, and all of a sudden we need the actual value of PG_waiters.
> Because of the order of header includes, it's not available and we
> fail to compile. Instead, manually specify that we care about bit 7.
> This is still correct: bit 7 is the bit that would mark a negative
> byte.
> 
> While we're at it, replace __inline__ with inline across the file.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com> # clear_bit_unlock_negative_byte
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

Now, I only have two KASAN tests which do not trigger any message:

	kasan test: kasan_alloca_oob_left out-of-bounds to left on alloca
	kasan test: kasan_alloca_oob_right out-of-bounds to right on alloca

Christophe

> 
> --
> v2: Address Christophe review
> ---
>   arch/powerpc/include/asm/bitops.h | 51 ++++++++++++++++++-------------
>   1 file changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 603aed229af7..28dcf8222943 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -64,7 +64,7 @@
>   
>   /* Macro for generating the ***_bits() functions */
>   #define DEFINE_BITOP(fn, op, prefix)		\
> -static __inline__ void fn(unsigned long mask,	\
> +static inline void fn(unsigned long mask,	\
>   		volatile unsigned long *_p)	\
>   {						\
>   	unsigned long old;			\
> @@ -86,22 +86,22 @@ DEFINE_BITOP(clear_bits, andc, "")
>   DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
>   DEFINE_BITOP(change_bits, xor, "")
>   
> -static __inline__ void set_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_set_bit(int nr, volatile unsigned long *addr)
>   {
>   	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
>   
> -static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_clear_bit(int nr, volatile unsigned long *addr)
>   {
>   	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
>   
> -static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
> +static inline void arch_clear_bit_unlock(int nr, volatile unsigned long *addr)
>   {
>   	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
>   
> -static __inline__ void change_bit(int nr, volatile unsigned long *addr)
> +static inline void arch_change_bit(int nr, volatile unsigned long *addr)
>   {
>   	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
>   }
> @@ -109,7 +109,7 @@ static __inline__ void change_bit(int nr, volatile unsigned long *addr)
>   /* Like DEFINE_BITOP(), with changes to the arguments to 'op' and the output
>    * operands. */
>   #define DEFINE_TESTOP(fn, op, prefix, postfix, eh)	\
> -static __inline__ unsigned long fn(			\
> +static inline unsigned long fn(			\
>   		unsigned long mask,			\
>   		volatile unsigned long *_p)		\
>   {							\
> @@ -138,34 +138,34 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
>   DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
>   	      PPC_ATOMIC_EXIT_BARRIER, 0)
>   
> -static __inline__ int test_and_set_bit(unsigned long nr,
> -				       volatile unsigned long *addr)
> +static inline int arch_test_and_set_bit(unsigned long nr,
> +					volatile unsigned long *addr)
>   {
>   	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>   }
>   
> -static __inline__ int test_and_set_bit_lock(unsigned long nr,
> -				       volatile unsigned long *addr)
> +static inline int arch_test_and_set_bit_lock(unsigned long nr,
> +					     volatile unsigned long *addr)
>   {
>   	return test_and_set_bits_lock(BIT_MASK(nr),
>   				addr + BIT_WORD(nr)) != 0;
>   }
>   
> -static __inline__ int test_and_clear_bit(unsigned long nr,
> -					 volatile unsigned long *addr)
> +static inline int arch_test_and_clear_bit(unsigned long nr,
> +					  volatile unsigned long *addr)
>   {
>   	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>   }
>   
> -static __inline__ int test_and_change_bit(unsigned long nr,
> -					  volatile unsigned long *addr)
> +static inline int arch_test_and_change_bit(unsigned long nr,
> +					   volatile unsigned long *addr)
>   {
>   	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
>   }
>   
>   #ifdef CONFIG_PPC64
> -static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
> -						volatile unsigned long *addr)
> +static inline unsigned long
> +clear_bit_unlock_return_word(int nr, volatile unsigned long *addr)
>   {
>   	unsigned long old, t;
>   	unsigned long *p = (unsigned long *)addr + BIT_WORD(nr);
> @@ -185,15 +185,18 @@ static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
>   	return old;
>   }
>   
> -/* This is a special function for mm/filemap.c */
> -#define clear_bit_unlock_is_negative_byte(nr, addr)			\
> -	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(PG_waiters))
> +/*
> + * This is a special function for mm/filemap.c
> + * Bit 7 corresponds to PG_waiters.
> + */
> +#define arch_clear_bit_unlock_is_negative_byte(nr, addr)		\
> +	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(7))
>   
>   #endif /* CONFIG_PPC64 */
>   
>   #include <asm-generic/bitops/non-atomic.h>
>   
> -static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
> +static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
>   {
>   	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
>   	__clear_bit(nr, addr);
> @@ -215,14 +218,14 @@ static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
>    * fls: find last (most-significant) bit set.
>    * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>    */
> -static __inline__ int fls(unsigned int x)
> +static inline int fls(unsigned int x)
>   {
>   	return 32 - __builtin_clz(x);
>   }
>   
>   #include <asm-generic/bitops/builtin-__fls.h>
>   
> -static __inline__ int fls64(__u64 x)
> +static inline int fls64(__u64 x)
>   {
>   	return 64 - __builtin_clzll(x);
>   }
> @@ -239,6 +242,10 @@ unsigned long __arch_hweight64(__u64 w);
>   
>   #include <asm-generic/bitops/find.h>
>   
> +/* wrappers that deal with KASAN instrumentation */
> +#include <asm-generic/bitops/instrumented-atomic.h>
> +#include <asm-generic/bitops/instrumented-lock.h>
> +
>   /* Little-endian versions */
>   #include <asm-generic/bitops/le.h>
>   
> 
