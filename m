Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43925 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgBHRMf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 12:12:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so1419271pfh.10
        for <linux-s390@vger.kernel.org>; Sat, 08 Feb 2020 09:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20200208141052.48476-1-natechancellor@gmail.com>
In-Reply-To: <20200208141052.48476-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Sat, 8 Feb 2020 17:12:21 +0000
Message-ID: <CAKwvOdm8-nL=BnTaCort+tAm27bkBzygmipZ7L3eBD4zvmyb8g@mail.gmail.com>
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Sat, Feb 8, 2020 at 3:11 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
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

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/s390/boot/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> index 5d12352545c5..5591243d673e 100644
> --- a/arch/s390/boot/kaslr.c
> +++ b/arch/s390/boot/kaslr.c
> @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
>                 *(unsigned long *) prng.parm_block ^= seed;
>                 for (i = 0; i < 16; i++) {
>                         cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> -                                 (char *) entropy, (char *) entropy,
> +                                 (u8 *) entropy, (u8 *) entropy,
>                                   sizeof(entropy));
>                         memcpy(prng.parm_block, entropy, sizeof(entropy));
>                 }
> --
> 2.25.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200208141052.48476-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
