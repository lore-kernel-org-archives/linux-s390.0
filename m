Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgFIJk1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jun 2020 05:40:27 -0400
MIME-Version: 1.0
References: <1591634471-17647-1-git-send-email-agordeev@linux.ibm.com>
In-Reply-To: <1591634471-17647-1-git-send-email-agordeev@linux.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 9 Jun 2020 12:40:14 +0300
Message-ID: <CAHp75Vf1G6bpVvOHdG598o5oOZ3=S=ecsct-GhkyK0e+=FE_DQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib: fix bitmap_parse() on 64-bit big endian archs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Mon, Jun 8, 2020 at 8:47 PM Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> Commit 2d6261583be0 ("lib: rework bitmap_parse()") does not
> take into account order of halfwords on 64-bit big endian
> architectures. As result (at least) Receive Packet Steering,
> IRQ affinity masks and runtime kernel test "test_bitmap" get
> broken on s390.

LGTM (I would replace while loop, but it's style preference and one
can consider worse than infinite loop)

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Fixes: 2d6261583be0 ("lib: rework bitmap_parse()")
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Amritha Nambiar <amritha.nambiar@intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: "Tobin C . Harding" <tobin@kernel.org>
> Cc: Vineet Gupta <vineet.gupta1@synopsys.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  lib/bitmap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 89260aa342d6..80d26b183248 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -739,6 +739,7 @@ int bitmap_parse(const char *start, unsigned int buflen,
>         const char *end = strnchrnul(start, buflen, '\n') - 1;
>         int chunks = BITS_TO_U32(nmaskbits);
>         u32 *bitmap = (u32 *)maskp;
> +       int chunk = 0;
>         int unset_bit;
>
>         while (1) {
> @@ -749,9 +750,14 @@ int bitmap_parse(const char *start, unsigned int buflen,
>                 if (!chunks--)
>                         return -EOVERFLOW;
>
> -               end = bitmap_get_x32_reverse(start, end, bitmap++);
> +#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
> +               end = bitmap_get_x32_reverse(start, end, &bitmap[chunk ^ 1]);
> +#else
> +               end = bitmap_get_x32_reverse(start, end, &bitmap[chunk]);
> +#endif
>                 if (IS_ERR(end))
>                         return PTR_ERR(end);
> +               chunk++;
>         }
>
>         unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
> --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko
