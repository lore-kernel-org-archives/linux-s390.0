Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190517065424.24453-1-yamada.masahiro@socionext.com> <20190517090735.6906c2fa@mschwideX1>
In-Reply-To: <20190517090735.6906c2fa@mschwideX1>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 17 May 2019 17:47:05 +0900
Message-ID: <CAK7LNAQkcSdb=ky2Mb0A48tUpnkXfZmC1B+JwPjkhdGM+EZJdQ@mail.gmail.com>
Subject: Re: [PATCH] s390: mark __cpacf_check_opcode() and cpacf_query_func()
 as __always_inline
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Laura Abbott <labbott@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 17, 2019 at 5:09 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Fri, 17 May 2019 15:54:24 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > Commit e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
> > was not enough to make sure to meet the 'i' (immediate) constraint for the
> > asm operands.
> >
> > With CONFIG_OPTIMIZE_INLINING enabled, Laura Abbott reported error
> > with gcc 9.1.1:
> >
> >   In file included from arch/s390/crypto/prng.c:29:
> >   ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
> >   ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
> >     170 |  asm volatile(
> >         |  ^~~
> >   ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
> >
> > Add more __always_inline to force inlining.
> >
> > Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> > Reported-by: Laura Abbott <labbott@redhat.com>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Added to our internal tree and I will add it to s390/linux soon. Thanks.
>
> Do you have a Kconfig patch in the works to enable OPTIMIZE_INLINING?
> Otherwise we could just add it.

No.
It is up to you.


Thanks.


-- 
Best Regards
Masahiro Yamada
