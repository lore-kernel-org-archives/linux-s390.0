Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190415083605.2560074-1-arnd@arndb.de> <20190415083605.2560074-4-arnd@arndb.de>
 <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com> <CAK8P3a2_Rkz3y662mxKTva_rrzHpOQ9fQ+pedenWCZCehxgxPw@mail.gmail.com>
In-Reply-To: <CAK8P3a2_Rkz3y662mxKTva_rrzHpOQ9fQ+pedenWCZCehxgxPw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 23 Apr 2019 11:21:28 -0700
Message-ID: <CAKwvOdmrOdzb3N3oNZL1kKYYSKzrVR+Opc7af9cYDL9cd2QpOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 23, 2019 at 1:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 22, 2019 at 7:52 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
>
> > > @@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
> > >  extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
> > >
> > >  static inline void
> > > -codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
> > > +codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
> > >  {
> > >         if (nr-- <= 0)
> > >                 return;
> >
> > There are many call sites of ASCEBC which is defined in terms of this
> > function. Do they all use `char*`?  grep shows an explicit cast to
> > `unsigned char*` in drivers/s390/char/tape_std.c for example.
>
> Generally speaking, the kernel is full of Wpointer-sign warnings, that's why
> this warning is disabled in the top-level Makefile by default. My patch fixes
> the ones in the s390 boot code that is not built with those default flags, but
> I made no attempt to fix the rest of the kernel.

Right, sorry, I forgot about that.  This patch looks good to me.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fun fact: on most architectures, 'char' is signed, but on s390 and 32-bit
> arm it is unsigned. The compiler treats 'char', 'unsigned char' and
> 'signed char'
> as three distinct types here for that reason.

I think I recall reading about that in:
https://www.amazon.com/ARM-System-Developers-Guide-Architecture/dp/1558608745
(I'll try to dig it up and post what the explanation was).

-- 
Thanks,
~Nick Desaulniers
