Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 17 May 2019 09:07:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: mark __cpacf_check_opcode() and
 cpacf_query_func() as __always_inline
In-Reply-To: <20190517065424.24453-1-yamada.masahiro@socionext.com>
References: <20190517065424.24453-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190517090735.6906c2fa@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 17 May 2019 15:54:24 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> was not enough to make sure to meet the 'i' (immediate) constraint for the
> asm operands.
> 
> With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> with gcc 9.1.1:
> 
>   In file included from arch/s390/crypto/prng.c:29:
>   ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
>   ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
>     170 |  asm volatile(
>         |  ^~~
>   ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
> 
> Add more __always_inline to force inlining.
> 
> Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Added to our internal tree and I will add it to s390/linux soon. Thanks.

Do you have a Kconfig patch in the works to enable OPTIMIZE_INLINING?
Otherwise we could just add it.

> ---
> 
>  arch/s390/include/asm/cpacf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
> index f316de40e51b..19459dfb4295 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -177,7 +177,7 @@ static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
>  		: "cc");
>  }
> 
> -static inline int __cpacf_check_opcode(unsigned int opcode)
> +static __always_inline int __cpacf_check_opcode(unsigned int opcode)
>  {
>  	switch (opcode) {
>  	case CPACF_KMAC:
> @@ -217,7 +217,7 @@ static inline int cpacf_test_func(cpacf_mask_t *mask, unsigned int func)
>  	return (mask->bytes[func >> 3] & (0x80 >> (func & 7))) != 0;
>  }
> 
> -static inline int cpacf_query_func(unsigned int opcode, unsigned int func)
> +static __always_inline int cpacf_query_func(unsigned int opcode, unsigned int func)
>  {
>  	cpacf_mask_t mask;
> 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
