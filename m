From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 06/11] MIPS: mark __fls() as __always_inline
Date: Tue, 23 Apr 2019 12:23:35 +0900
Message-ID: <CAK7LNAQjQKu9GFyCyDJsQcyQjbeSGoJJPJV8YEtSXuV9JDqhqQ@mail.gmail.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
 <20190419094754.24667-7-yamada.masahiro@socionext.com> <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7wUsygTo=AN_giku_X6_a4mQWdJL48RoVbVB4hBqkZSKkP0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Apr 20, 2019 at 12:45 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> Hi,
>
> On Fri, Apr 19, 2019 at 12:06 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> > place. We need to eliminate potential issues beforehand.
> >
> > If it is enabled for mips, the following errors are reported:
> >
> > arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
> > sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
> > sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
> > arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined references to `mips_gcr_base'
>
> Tested with success on ppc32/G4. But on CI20 (ci20_defconfig from
> master), I get:


Thanks for the test!

OK, I saw this error for ci20_defconfig.

I inline'd __ffs() to fix it
and sumitted v3.

Thank you.



>   MODPOST vmlinux.o
> mipsel-linux-gnu-ld: arch/mips/kernel/traps.o: in function
> `addr_gcr_err_control':
> /home/mathieu/tmp/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:169:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld: arch/mips/mm/sc-mips.o: in function
> `addr_gcr_l2_pft_control':
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> /home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> undefined reference to `mips_gcr_base'
> mipsel-linux-gnu-ld:
> arch/mips/mm/sc-mips.o:/home/mathieu/linux/linux/ci20/../arch/mips/include/asm/mips-cm.h:246:
> more undefined references to `mips_gcr_base' follow




-- 
Best Regards
Masahiro Yamada
