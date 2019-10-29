Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46080 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfJ2IVR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Oct 2019 04:21:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so12531605wrw.13
        for <linux-s390@vger.kernel.org>; Tue, 29 Oct 2019 01:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191028210559.8289-1-rth@twiddle.net> <20191028210559.8289-2-rth@twiddle.net>
In-Reply-To: <20191028210559.8289-2-rth@twiddle.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 29 Oct 2019 09:21:03 +0100
Message-ID: <CAKv+Gu9iW341X8FLBedO1Lhr0H-XcA7jDp3bh3nQh7f7N_M0eA@mail.gmail.com>
Subject: Re: [PATCH 1/6] random: Mark CONFIG_ARCH_RANDOM functions __must_check
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Kees Cook <keescook@chromium.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, 28 Oct 2019 at 22:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We cannot use the pointer output without validating the
> success of the random read.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-arch@vger.kernel.org
> ---
>  include/linux/random.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/random.h b/include/linux/random.h
> index f189c927fdea..84947b489649 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -167,11 +167,11 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
>  #ifdef CONFIG_ARCH_RANDOM
>  # include <asm/archrandom.h>
>  #else
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>         return 0;

For symmetry with the other cleanups, you should probably change these
into 'return false' as well

>  }
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>         return 0;
>  }
> @@ -179,11 +179,11 @@ static inline bool arch_has_random(void)
>  {
>         return 0;
>  }
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>         return 0;
>  }
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>         return 0;
>  }
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
