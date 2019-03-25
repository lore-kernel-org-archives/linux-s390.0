Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com> <20190321080133.GB3916@osiris>
In-Reply-To: <20190321080133.GB3916@osiris>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 25 Mar 2019 15:41:40 +0900
Message-ID: <CAK7LNAR0JxvKOEOE6-SvFWzAueZL0qb6XaANDud0pVa_Ew3NWg@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190325064140.bbec7NcOko51oZr_myHT2Yrm0XKuTZiR7sBWYtxBsq0@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,


On Thu, Mar 21, 2019 at 5:02 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Wed, Mar 20, 2019 at 03:20:27PM +0900, Masahiro Yamada wrote:
> > Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> > CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> >
> > The idea is obviously arch-agnostic although we need some code fixups.
> > This commit moves the config entry from arch/x86/Kconfig.debug to
> > lib/Kconfig.debug so that all architectures (except MIPS for now) can
> > benefit from it.
> >
> > At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> > for MIPS was complex to me.
> >
> > I tested this patch on my arm/arm64 boards.
> >
> > This can make a huge difference in kernel image size especially when
> > CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> >
> > For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
> >
> >   dec       file
> >   18983424  arch/arm64/boot/Image.before
> >   18321920  arch/arm64/boot/Image.after
>
> Well, this will change, since now people (have to) start adding
> __always_inline annotations on all architectures, most likely until
> all have about the same amount of annotations like x86. This will
> reduce the benefit.


If people start to replace inline with __always_inline here and there,
yes, the difference will be reduced.

Perhaps, we might end up with fixing dozens of places or so,
but I guess we would still get benefit.


> Not sure if it's really a win that we get the inline vs
> __always_inline discussion now on all architectures.


This feature is not x86-specific.

I prefer "do it for all arches or don't do it at all"
instead of the half-baked state.

If we force inlining for the 'inline' marker
there is no point of having __always_inline.


-- 
Best Regards
Masahiro Yamada
