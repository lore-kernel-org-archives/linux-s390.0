Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <CAK7LNAQvvCVsQtd9ZYkechOSCg4HAeZFaNXCgaBbWWxBYXOgaQ@mail.gmail.com>
 <CAK8P3a1P812avY8reSSguYB0jPzgjs+30dSJpKZCnWwzyLoSVQ@mail.gmail.com> <CAK7LNARatcRQ2u0JhiZHx4qU+mzS=SUv-kj7F-7-Vx--RFX5tw@mail.gmail.com>
In-Reply-To: <CAK7LNARatcRQ2u0JhiZHx4qU+mzS=SUv-kj7F-7-Vx--RFX5tw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Mar 2019 11:25:33 +0100
Message-ID: <CAK8P3a1QQeK1cBN2O8=p+zceQ7tw-ovYtWq6sBeavDucDWA7Lg@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190325102533.AbN6qGOaZyiwwKlH0ZqjQovDP-evqusUbGVx7tbTYQk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 25, 2019 at 8:55 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, Mar 25, 2019 at 4:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Mon, Mar 25, 2019 at 7:11 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > I do not know why to reproduce it,
> > > but is "__init __noreturn" more sensible than
> > > "__always_inline" here?
> >
> > It's in a header file, so it has to be 'inline'. We could make it
> > static inline __init __noreturn,
>
> Yes, I like 'static inline __init __noreturn'
>
> > but I don't see an advantage over
> > __always_inline there.
>
> __always_inline takes away the compiler's freedom.
>
> I'd like to leave it up to the compiler where possible.

Ok, fair enough.

      Arnd
