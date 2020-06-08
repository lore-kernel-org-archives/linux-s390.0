Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgFHMDS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 08:03:18 -0400
MIME-Version: 1.0
References: <1591611829-23071-1-git-send-email-agordeev@linux.ibm.com>
In-Reply-To: <1591611829-23071-1-git-send-email-agordeev@linux.ibm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jun 2020 15:03:05 +0300
Message-ID: <CAHp75VcFdrvNMj0TL8ZHxShqqGDM31Hy8vitmn9HOPjZ6f9uYw@mail.gmail.com>
Subject: Re: [PATCH RESEND2] lib: fix bitmap_parse() on 64-bit big endian archs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Mon, Jun 8, 2020 at 1:26 PM Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> Commit 2d6261583be0 ("lib: rework bitmap_parse()") does not
> take into account order of halfwords on 64-bit big endian
> architectures. As result (at least) Receive Packet Steering,
> IRQ affinity masks and runtime kernel test "test_bitmap" get
> broken on s390.

...

> +#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)

I think it's better to re-use existing patterns.

ipc/sem.c:1682:#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)

> +static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
> +{
> +       maskp += (chunk_idx / 2);
> +       ((u32 *)maskp)[(chunk_idx & 1) ^ 1] = chunk;
> +}
> +#else
> +static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
> +{
> +       ((u32 *)maskp)[chunk_idx] = chunk;
> +}
> +#endif

See below.

...

> -               end = bitmap_get_x32_reverse(start, end, bitmap++);
> +               end = bitmap_get_x32_reverse(start, end, &chunk);
>                 if (IS_ERR(end))
>                         return PTR_ERR(end);
> +
> +               save_x32_chunk(maskp, chunk, chunk_idx++);

Can't we simple do

        int chunk_index = 0;
        ...
        do {
#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
               end = bitmap_get_x32_reverse(start, end,
bitmap[chunk_index ^ 1]);
#else
               end = bitmap_get_x32_reverse(start, end, bitmap[chunk_index]);
#endif
        ...
        } while (++chunk_index);

?

-- 
With Best Regards,
Andy Shevchenko
