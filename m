Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:54179 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJ3LhI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 07:37:08 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 5/6] powerpc: Mark archrandom.h functions __must_check
In-Reply-To: <20191028210559.8289-6-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net> <20191028210559.8289-6-rth@twiddle.net>
Date: Wed, 30 Oct 2019 22:37:01 +1100
Message-ID: <87v9s6bh2a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>, linux-arch@vger.kernel.org
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

Richard Henderson <richard.henderson@linaro.org> writes:
> We cannot use the pointer output without validating the
> success of the random read.

You _can_, but you must not. </pedant>

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/archrandom.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
> index f8a887c8b7f8..ee214b153a71 100644
> --- a/arch/powerpc/include/asm/archrandom.h
> +++ b/arch/powerpc/include/asm/archrandom.h
> @@ -6,17 +6,17 @@
>  
>  #include <asm/machdep.h>
>  
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>  	return false;
>  }
>  
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>  	return false;
>  }
>  
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>  	if (ppc_md.get_random_seed)
>  		return ppc_md.get_random_seed(v);
> @@ -24,7 +24,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
>  	return false;
>  }
>  
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>  	unsigned long val;
>  	bool rc;
> -- 
> 2.17.1
