From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Date: Tue, 26 Mar 2019 07:02:54 +0100
Message-ID: <686abdd5-863a-02ce-5ac9-f573208b8315@c-s.fr>
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
 <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
 <20190323092640.Horde.2lm4u26aZox5ialxuIRcYw2@messagerie.si.c-s.fr>
 <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQGifytZRQXcqma9VuvQPfL2w8NjzLRt7CxzFgvaMhyRw@mail.gmail.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Masahiro,

Le 25/03/2019 à 07:44, Masahiro Yamada a écrit :
> Hi Christophe,
> 
> 
> On Sat, Mar 23, 2019 at 5:27 PM LEROY Christophe
> <christophe.leroy@c-s.fr> wrote:
>>
>> Arnd Bergmann <arnd@arndb.de> a écrit :
>>
>>> On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>>>
>>>> I've added your patch to my randconfig test setup and will let you
>>>> know if I see anything noticeable. I'm currently testing clang-arm32,
>>>> clang-arm64 and gcc-x86.
>>>
>>> This is the only additional bug that has come up so far:
>>>
>>> `.exit.text' referenced in section `.alt.smp.init' of
>>> drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
>>> `exit.text' of drivers/char/ipmi/ipmi_msghandler.o
>>
>> Wouldn't it be useful to activate -Winline gcc warning to ease finding
>> out problematic usage of inline keyword ?
> 
> 
> Yes, it is useful to find out
> which function is causing the error.
> Thanks for the tip.
> 

I did a mass build on kisskb. Almost ok, see results at 
http://kisskb.ellerman.id.au/kisskb/head/203d912edf8dde291977c71aa64024065e197f79/

ps3_defconfig with GCC 5 fails 
(http://kisskb.ellerman.id.au/kisskb/buildresult/13742711/) with:

arch/powerpc/mm/tlb-radix.c:148:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:148:2: error: impossible constraint in 'asm'
arch/powerpc/mm/tlb-radix.c:118:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]

ps3_defconfig with GCC 4.6 fails 
(http://kisskb.ellerman.id.au/kisskb/buildresult/13742591/) with:

arch/powerpc/mm/tlb-radix.c:148:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:118:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]
arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't 
match constraints [-Werror]

randconfig with GCC 4.6 fails 
(http://kisskb.ellerman.id.au/kisskb/buildresult/13742698/) with:

arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'

Christophe
