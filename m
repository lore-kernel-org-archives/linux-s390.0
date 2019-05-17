From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RESEND PATCH v3 04/11] s390/cpacf: mark scpacf_query() as __always_inline
Date: Fri, 17 May 2019 13:23:55 +0900
Message-ID: <CAK7LNAST5y9Khg0BBz6W0mekPpuLPwWa9nPvvVENidWhHZ-avw@mail.gmail.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-5-yamada.masahiro@socionext.com> <aa73f81d-5d5a-a1d2-5239-3e8eb1278ec4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aa73f81d-5d5a-a1d2-5239-3e8eb1278ec4@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-s390 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mathieu Malaterre <malat@debian.org>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 17, 2019 at 8:01 AM Laura Abbott <labbott@redhat.com> wrote:
>
> On 4/22/19 8:49 PM, Masahiro Yamada wrote:
> > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > place. We need to eliminate potential issues beforehand.
> >
> > If it is enabled for s390, the following error is reported:
> >
> > In file included from arch/s390/crypto/des_s390.c:19:
> > ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query':
> > ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
> >    asm volatile(
> >    ^~~
> > ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
> >
>
> This also seems to still be broken, again with gcc 9.1.1
>
> BUILDSTDERR: In file included from arch/s390/crypto/prng.c:29:
> BUILDSTDERR: ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query_func':
> BUILDSTDERR: ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
> BUILDSTDERR:   170 |  asm volatile(
> BUILDSTDERR:       |  ^~~
> BUILDSTDERR: ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'
>
> I realized we're still carrying a patch to add -fno-section-anchors
> but it's a similar failure to powerpc.


Christophe had already pointed out potential issues for "i" constraint,
and I have fixups in hand:

See
https://lkml.org/lkml/2019/5/3/459


My plan was to send it after all of my base patches
were merged.

This s390 cparf.h is included in the TODO list.

Will fix soon.

Thanks.

-- 
Best Regards
Masahiro Yamada
