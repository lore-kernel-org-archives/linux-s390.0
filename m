Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
From: Joe Perches <joe@perches.com>
Date: Sat, 08 Feb 2020 12:17:20 -0800
In-Reply-To: <20200208141052.48476-1-natechancellor@gmail.com>
References: <20200208141052.48476-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Sat, 2020-02-08 at 07:10 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> of type 'const u8 *' (aka 'const unsigned char *') converts between
> pointers to integer
> types with different sign [-Wpointer-sign]
>                                   (char *) entropy, (char *) entropy,
>                                                     ^~~~~~~~~~~~~~~~
> ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> parameter 'src' here
>                             u8 *dest, const u8 *src, long src_len)
>                                                 ^
> 2 warnings generated.
> 
> Fix the cast to match what else is done in this function.
> 
> Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/862
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/s390/boot/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> index 5d12352545c5..5591243d673e 100644
> --- a/arch/s390/boot/kaslr.c
> +++ b/arch/s390/boot/kaslr.c
> @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
>  		*(unsigned long *) prng.parm_block ^= seed;
>  		for (i = 0; i < 16; i++) {
>  			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> -				  (char *) entropy, (char *) entropy,
> +				  (u8 *) entropy, (u8 *) entropy,

Why not change the function to take void *?

static inline int cpacf_kmc(unsigned long func, void *param,
			    u8 *dest, const u8 *src, long src_len)

vs:

static inline int cpacf_kmc(unsigned long func, void *param,
			    void *dest, const void *src, long src_len)

and remove the casts?
