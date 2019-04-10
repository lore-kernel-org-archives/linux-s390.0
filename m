Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-12-arnd@arndb.de>
 <20190410155513.1609f1a1@mschwideX1>
In-Reply-To: <20190410155513.1609f1a1@mschwideX1>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 Apr 2019 20:55:27 +0200
Message-ID: <CAK8P3a0xg+-w5KVx5ti_354qKHTNES78eyRaRCQUnnRx33sDfQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] [PROBABLY WRONG] s390: void '0' constraint in
 inline assembly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 3:55 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Mon,  8 Apr 2019 23:26:25 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
> > index 700c650ffd4f..84c59c99668a 100644
> > --- a/arch/s390/include/asm/processor.h
> > +++ b/arch/s390/include/asm/processor.h
> > @@ -262,7 +262,7 @@ static __no_kasan_or_inline unsigned short stap(void)
> >       register unsigned long r4 asm("6") = (unsigned long)(arg5)
> >
> >  #define CALL_FMT_0
> > -#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
> > +#define CALL_FMT_1 CALL_FMT_0, "d" (r2)
> >  #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
> >  #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
> >  #define CALL_FMT_4 CALL_FMT_3, "d" (r5)
>
> This is (slightly) wrong. %r2 is used as the input register for the first argument
> and the result value for the call. With your patch you force the compiler to load
> the first argument in two registers. One solution would be to CALL_FMT1 as
>
>         #define CALL_FMT1 CALL_FMT_0
>
> It still is not optimal though as for CALL_FMT_0 the "+&d" (r2) indicates an
> input but CALL_ARGS_0 does not initialize r2.

Ok, thanks for taking a closer look!

> I am thinking about the following patch to cover all cases:
> --
> From 91a4abbec91a9f26f84f7386f2c0f96de669b0eb Mon Sep 17 00:00:00 2001
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date: Wed, 10 Apr 2019 15:48:43 +0200
> Subject: [PATCH] s390: fine-tune stack switch helper
>
> The CALL_ON_STACK helper currently does not work with clang and for
> calls without arguments it does not initialize r2 although the contraint
> is "+&d". Rework the CALL_FMT_x and the CALL_ON_STACK macros to work
> with clang and produce optimal code in all cases.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

I did another build test to confirm that your patch works fine with clang
as well, looks good to me.

      Arnd
