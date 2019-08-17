Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfHQFhb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 17 Aug 2019 01:37:31 -0400
Date: Fri, 16 Aug 2019 22:37:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 4/6] crypto: sha256 - Use get_unaligned_be32 to get
 input, memzero_explicit
Message-ID: <20190817053728.GD8209@sol.localdomain>
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816211611.2568-5-hdegoede@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-crypto@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 11:16:09PM +0200, Hans de Goede wrote:
> Use get_unaligned_be32 in the lib/crypto/sha256.c sha256_transform()
> implementation so that it can be used with unaligned buffers too,
> making it more generic.
> 
> And use memzero_explicit for better clearing of sensitive data.
> 
> Note unlike other patches in this series this commit actually makes
> functional changes to the sha256 code as used by the purgatory code.
> 
> This fully aligns the lib/crypto/sha256.c sha256_transform()
> implementation with the one from crypto/sha256_generic.c allowing us
> to remove the latter in further patches in this series.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  lib/crypto/sha256.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
> index b8114028d06f..09a435d845fc 100644
> --- a/lib/crypto/sha256.c
> +++ b/lib/crypto/sha256.c
> @@ -14,7 +14,7 @@
>  #include <linux/bitops.h>
>  #include <linux/string.h>
>  #include <crypto/sha256.h>
> -#include <asm/byteorder.h>
> +#include <asm/unaligned.h>
>  
>  static inline u32 Ch(u32 x, u32 y, u32 z)
>  {
> @@ -33,7 +33,7 @@ static inline u32 Maj(u32 x, u32 y, u32 z)
>  
>  static inline void LOAD_OP(int I, u32 *W, const u8 *input)
>  {
> -	W[I] = __be32_to_cpu(((__be32 *)(input))[I]);
> +	W[I] = get_unaligned_be32((__u32 *)input + I);
>  }
>  
>  static inline void BLEND_OP(int I, u32 *W)
> @@ -201,7 +201,7 @@ static void sha256_transform(u32 *state, const u8 *input)
>  
>  	/* clear any sensitive info... */
>  	a = b = c = d = e = f = g = h = t1 = t2 = 0;
> -	memset(W, 0, 64 * sizeof(u32));
> +	memzero_explicit(W, 64 * sizeof(u32));
>  }
>  

There's also an unaligned access in sha256_final() which needs to be fixed.

- Eric
