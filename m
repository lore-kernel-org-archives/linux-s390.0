Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 23 Mar 2019 09:26:40 +0100
Message-ID: <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
In-Reply-To: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="Yes"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190323082640.ltmLCmYxUsV6j-KDQPevVuRfwGUVU5zmXsUfJMxX1Bg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mtd <linux-mtd@lists.infradead.org>, Ingo Molnar <mingo@redhat.com>, Paul Burton <paul.burton@mips.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Dave Hansen <dave@sr71.net>, linux-s390 <linux-s390@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
List-ID: <linux-s390.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> a écrit :

> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> I've added your patch to my randconfig test setup and will let you
>> know if I see anything noticeable. I'm currently testing clang-arm32,
>> clang-arm64 and gcc-x86.
>
> This is the only additional bug that has come up so far:
>
> `.exit.text' referenced in section `.alt.smp.init' of
> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o

Wouldn't it be useful to activate -Winline gcc warning to ease finding  
out problematic usage of inline keyword ?

Christophe

>
> diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
> index 201100226301..84b12e33104d 100644
> --- a/arch/arm/kernel/atags.h
> +++ b/arch/arm/kernel/atags.h
> @@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
>  const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
>         unsigned int machine_nr);
>  #else
> -static inline const struct machine_desc *
> +static __always_inline const struct machine_desc *
>  setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
>  {
>         early_print("no ATAGS support: can't continue\n");
