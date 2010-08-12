From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Latest git build failure on s390 - dma_get_cache_alignment()
Date: Thu, 12 Aug 2010 11:03:37 +0200
Message-ID: <AANLkTinnLY4LZ-3xbKEJVR3Qjw5xghRZ6i=tWfw8hJHH@mail.gmail.com>
References: <4C63A551.3040701@in.ibm.com>
	<20100812075532.GA7814@osiris.boeblingen.de.ibm.com>
	<20100812080701.GB7814@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20100812080701.GB7814@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sachin Sant <sachinp@in.ibm.com>, linux-s390@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 12, 2010 at 10:07, Heiko Carstens <heiko.carstens@de.ibm.co=
m> wrote:
> On Thu, Aug 12, 2010 at 09:55:32AM +0200, Heiko Carstens wrote:
>> On Thu, Aug 12, 2010 at 01:10:01PM +0530, Sachin Sant wrote:
>> > Latest 2.6.35 git (2.6.35-git11 : 5af568cbd...) fails to build
>> > on s390 with following errors :
>> >
>> > arch/s390/mm/fault.c:396: warning: frame size of 'do_protection_ex=
ception' is 264 bytes
>> > In file included from include/linux/dmaengine.h:26,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/linux/skbuff=
=2Eh:30,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/linux/icmpv6=
=2Eh:82,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/linux/ipv6.h=
:220,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/net/ipv6.h:1=
6,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/linux/sunrpc=
/clnt.h:25,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from include/linux/nfs_fs=
=2Eh:48,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from init/do_mounts.c:20:
>> > include/linux/dma-mapping.h:145: error: static declaration of 'dma=
_get_cache_alignment' follows non-static declaration
>> > include/asm-generic/dma-mapping-broken.h:73: error: previous decla=
ration of 'dma_get_cache_alignment' was here
>> > make[1]: *** [init/do_mounts.o] Error 1
>> > make[1]: *** Waiting for unfinished jobs....
>> > init/do_mounts_md.c: In function 'md_setup_drive':
>> > init/do_mounts_md.c:241: warning: frame size of 'md_setup_drive' i=
s 496 bytes
>> > make: *** [init] Error 2
>> > make: *** Waiting for unfinished jobs....
>> >
>> > The code in question was last changed via following commit
>> >
>> > commit 4565f0170dfc849b3629c27d769db800467baa62
>> > dma-mapping: unify dma_get_cache_alignment implementations
>>
>> Cc'ing linux-arch since the original patch got posted there as well.

Seems Sun3 suffers from this as well:
http://kisskb.ellerman.id.au/kisskb/buildresult/3022174/

<std_rant>
=46unny how these things never show up in linux-next...
</std_rant>

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
