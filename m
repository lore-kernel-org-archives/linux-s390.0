From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 01/10] Add support for GCC-4.5's __builtin_unreachable()
 to compiler.h
Date: Fri, 11 Sep 2009 08:58:28 -0700
Message-ID: <4AAA73A4.9010601@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com> <1252627011-2933-1-git-send-email-ddaney@caviumnetworks.com> <200909111633.00665.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <200909111633.00665.mb@bu3sch.de>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org, linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Mike Frysinger <vapier@gentoo.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, uclinux-dist-devel@blackfin.uclinux.org, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Koichi Yasutake <yasutake.koichi@jp.pana>
List-ID: <linux-s390.vger.kernel.org>

Michael Buesch wrote:
> On Friday 11 September 2009 01:56:42 David Daney wrote:
>> +/* Unreachable code */
>> +#ifndef unreachable
>> +# define unreachable() do { for (;;) ; } while (0)
>> +#endif
> 
> # define unreachable() do { } while (1)
> 
> ? :)

Clearly I was not thinking clearly when I wrote that part.  RTH noted 
the same thing.  I will fix it.

Thanks,
David Daney
