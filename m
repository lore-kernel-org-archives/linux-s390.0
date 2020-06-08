Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1591611829-23071-1-git-send-email-agordeev@linux.ibm.com> <CAHp75VcFdrvNMj0TL8ZHxShqqGDM31Hy8vitmn9HOPjZ6f9uYw@mail.gmail.com>
In-Reply-To: <CAHp75VcFdrvNMj0TL8ZHxShqqGDM31Hy8vitmn9HOPjZ6f9uYw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 8 Jun 2020 15:08:22 +0300
Message-ID: <CAHp75Ve98sbs9do=vD7fk+iWWgTPfQ=8HT1Nh4ehBtdtp7joKQ@mail.gmail.com>
Subject: Re: [PATCH RESEND2] lib: fix bitmap_parse() on 64-bit big endian archs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Chris Wilson <chris@chris-wilson.co.uk>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <mszeredi@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Klassert <steffen.klassert@secunet.com>, "Tobin C . Harding" <tobin@kernel.org>, Vineet Gupta <vineet.gupta1@synopsys.com>, Will Deacon <will.deacon@arm.com>, Willem de Bruijn <willemb@google.com>

On Mon, Jun 8, 2020 at 3:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jun 8, 2020 at 1:26 PM Alexander Gordeev <agordeev@linux.ibm.com> wrote:

...

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

And moreover, we simple can replace bitmap by maskp here, and drop it
from definition block.

-- 
With Best Regards,
Andy Shevchenko
