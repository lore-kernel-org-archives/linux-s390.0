Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbgFHMpJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 08:45:09 -0400
Date: Mon, 8 Jun 2020 14:44:34 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH RESEND2] lib: fix bitmap_parse() on 64-bit big endian
 archs
Message-ID: <20200608124433.GA28369@oc3871087118.ibm.com>
References: <1591611829-23071-1-git-send-email-agordeev@linux.ibm.com>
 <CAHp75VcFdrvNMj0TL8ZHxShqqGDM31Hy8vitmn9HOPjZ6f9uYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcFdrvNMj0TL8ZHxShqqGDM31Hy8vitmn9HOPjZ6f9uYw@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Mon, Jun 08, 2020 at 03:03:05PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 8, 2020 at 1:26 PM Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> >
> > Commit 2d6261583be0 ("lib: rework bitmap_parse()") does not
> > take into account order of halfwords on 64-bit big endian
> > architectures. As result (at least) Receive Packet Steering,
> > IRQ affinity masks and runtime kernel test "test_bitmap" get
> > broken on s390.
> 
> ...
> 
> > +#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
> 
> I think it's better to re-use existing patterns.
> 
> ipc/sem.c:1682:#if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
> 
> > +static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
> > +{
> > +       maskp += (chunk_idx / 2);
> > +       ((u32 *)maskp)[(chunk_idx & 1) ^ 1] = chunk;
> > +}
> > +#else
> > +static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
> > +{
> > +       ((u32 *)maskp)[chunk_idx] = chunk;
> > +}
> > +#endif
> 
> See below.
> 
> ...
> 
> > -               end = bitmap_get_x32_reverse(start, end, bitmap++);
> > +               end = bitmap_get_x32_reverse(start, end, &chunk);
> >                 if (IS_ERR(end))
> >                         return PTR_ERR(end);
> > +
> > +               save_x32_chunk(maskp, chunk, chunk_idx++);
> 
> Can't we simple do
> 
>         int chunk_index = 0;
>         ...
>         do {
> #if defined(CONFIG_64BIT) && defined(__BIG_ENDIAN)
>                end = bitmap_get_x32_reverse(start, end,
> bitmap[chunk_index ^ 1]);
> #else
>                end = bitmap_get_x32_reverse(start, end, bitmap[chunk_index]);
> #endif
>         ...
>         } while (++chunk_index);
> 
> ?

Well, unless we ignore coding style 21) Conditional Compilation
we could. Do you still insist it would be better?

Thanks for the review!

> -- 
> With Best Regards,
> Andy Shevchenko
