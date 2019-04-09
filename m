Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 9 Apr 2019 09:30:49 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
Message-ID: <20190409163049.GA2046@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-3-arnd@arndb.de>
 <20190408220312.GA18333@archlinux-i9>
 <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a39NqQOp+0=WYuWh0UmpH=kEFLKyymNYm8DH-0gx9XaaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, linux-s390 <linux-s390@vger.kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 09, 2019 at 08:43:09AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 9, 2019 at 12:03 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Apr 08, 2019 at 11:26:16PM +0200, Arnd Bergmann wrote:
> > > The purgatory Makefile does not inherit the original cflags,
> > > so clang falls back to the default target architecture when
> > > building it, typically this would be x86 when cross-compiling.
> > >
> > > Pass --target=s390x-linux to all compilers that understand
> > > this option.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/s390/purgatory/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> > > index ce6a3f75065b..3a14b968cec3 100644
> > > --- a/arch/s390/purgatory/Makefile
> > > +++ b/arch/s390/purgatory/Makefile
> > > @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
> > >  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
> > >  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
> > >  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> > > +KBUILD_CFLAGS += $(call cc-option,--target=s390x-linux)
> > >  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
> > >  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
> > >
> > Would
> >
> > ifdef CONFIG_CC_IS_CLANG
> > KBUILD_CFLAGS += --target=s390x-linux
> > endif
> >
> > be a little clearer (and save a cc-option call)?
> 
> Fine with me as well. Actually I noticed later that we need the same
> thing for arch/s390/boot/Makefile and arch/s390/boot/compressed/Makefile
> in some form, so maybe we should drop this one for now and find
> a solution that works for all three of them. The boot stuff is the one
> patch I did not send, since I did not think I had a good solution there,
> just one that happened to make it build.
> 

It did just occur to me that we added the --target and --gcc-toolchain
flags to a clang specific variable, CLANG_FLAGS, that has already been
used by powerpc in commit 813af51f5d30 ("powerpc/boot: Set target when
cross-compiling for clang"). I assume that could be used here?

Nathan

> > Otherwise, makes sense.
> >
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> 
>  Thanks,
> 
>        Arnd
