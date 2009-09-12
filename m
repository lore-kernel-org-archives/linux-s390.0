From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
	to compiler.h
Date: Sat, 12 Sep 2009 09:22:43 +0200
Message-ID: <10f740e80909120022m72ad5ea7t692fba93cd3114e9@mail.gmail.com>
References: <4AA991C1.1050800@caviumnetworks.com>
	 <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com>
	 <200909111633.00665.mb@bu3sch.de>
	 <4AAA73A4.9010601@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <4AAA73A4.9010601@caviumnetworks.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: Michael Buesch <mb@bu3sch.de>, linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org, linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Mike Frysinger <vapier@gentoo.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, uclinux-dist-devel@blackfin.uclinux.org, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Koichi
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 11, 2009 at 17:58, David Daney<ddaney@caviumnetworks.com> w=
rote:
> Michael Buesch wrote:
>>
>> On Friday 11 September 2009 01:56:42 David Daney wrote:
>>>
>>> +/* Unreachable code */
>>> +#ifndef unreachable
>>> +# define unreachable() do { for (;;) ; } while (0)
>>> +#endif
>>
>> # define unreachable() do { } while (1)
>>
>> ? :)
>
> Clearly I was not thinking clearly when I wrote that part. =C2=A0RTH =
noted the
> same thing. =C2=A0I will fix it.

However, people are so used to seeing the `do { } while (0)' idiom,
that they might miss
there's a `1' here, not a `0'.

So perhaps it's better to use plain `for (;;)' for infinite loops?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-alpha" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
