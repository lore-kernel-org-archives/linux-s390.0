Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190415083605.2560074-1-arnd@arndb.de> <20190415083605.2560074-4-arnd@arndb.de>
 <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com>
In-Reply-To: <CAKwvOd=761wDZ-g-E7kqOFCftH=CONpzc52WU0-ZQztZ3U=x4w@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 23 Apr 2019 10:05:50 +0200
Message-ID: <CAK8P3a2_Rkz3y662mxKTva_rrzHpOQ9fQ+pedenWCZCehxgxPw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 22, 2019 at 7:52 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:

> > @@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
> >  extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
> >
> >  static inline void
> > -codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
> > +codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
> >  {
> >         if (nr-- <= 0)
> >                 return;
>
> There are many call sites of ASCEBC which is defined in terms of this
> function. Do they all use `char*`?  grep shows an explicit cast to
> `unsigned char*` in drivers/s390/char/tape_std.c for example.

Generally speaking, the kernel is full of Wpointer-sign warnings, that's why
this warning is disabled in the top-level Makefile by default. My patch fixes
the ones in the s390 boot code that is not built with those default flags, but
I made no attempt to fix the rest of the kernel.

Fun fact: on most architectures, 'char' is signed, but on s390 and 32-bit
arm it is unsigned. The compiler treats 'char', 'unsigned char' and
'signed char'
as three distinct types here for that reason.

> > diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> > index cc0947e08b6f..f3a637afd485 100644
> > --- a/arch/s390/include/asm/lowcore.h
> > +++ b/arch/s390/include/asm/lowcore.h
> > @@ -128,7 +128,7 @@ struct lowcore {
> >         /* SMP info area */
> >         __u32   cpu_nr;                         /* 0x0398 */
> >         __u32   softirq_pending;                /* 0x039c */
> > -       __u32   preempt_count;                  /* 0x03a0 */
> > +       __s32   preempt_count;                  /* 0x03a0 */
>
> This change is less obvious. Do you still have the warning for that
> this hunk fixes?

I can't find it now, but there are multiple users that would cause
this, like:

static inline void preempt_count_set(int pc)
{
        int old, new;

        do {
                old = READ_ONCE(S390_lowcore.preempt_count);
                new = (old & PREEMPT_NEED_RESCHED) |
                        (pc & ~PREEMPT_NEED_RESCHED);
        } while (__atomic_cmpxchg(&S390_lowcore.preempt_count,
                                  old, new) != old);
}


      Arnd
