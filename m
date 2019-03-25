Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com> <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
In-Reply-To: <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 25 Mar 2019 15:44:06 +0900
Message-ID: <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190325064406.Sy4QiZlcdR7Q9JVbjrKLBRw22bADCW9_-Wn93qDD7KE@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Christophe,


On Sat, Mar 23, 2019 at 5:27 PM LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
>
> Arnd Bergmann <arnd@arndb.de> a =C3=A9crit :
>
> > On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> I've added your patch to my randconfig test setup and will let you
> >> know if I see anything noticeable. I'm currently testing clang-arm32,
> >> clang-arm64 and gcc-x86.
> >
> > This is the only additional bug that has come up so far:
> >
> > `.exit.text' referenced in section `.alt.smp.init' of
> > drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> > `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
>
> Wouldn't it be useful to activate -Winline gcc warning to ease finding
> out problematic usage of inline keyword ?


Yes, it is useful to find out
which function is causing the error.
Thanks for the tip.




--=20
Best Regards
Masahiro Yamada
