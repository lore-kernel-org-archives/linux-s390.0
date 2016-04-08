From: Andrew Pinski <pinskia@gmail.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Thu, 7 Apr 2016 19:49:33 -0700
Message-ID: <CA+=Sn1kx1UumTYHa8AE-XAUNiSXTd5zoDxae1LL5YczC_VXe_w@mail.gmail.com>
References: <20160407121838.GA22098@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160407121838.GA22098@angband.pl>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Nathan Lynch <Nathan_Lynch@mentor.com>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 7, 2016 at 5:18 AM, Adam Borowski <kilobyte@angband.pl> wro=
te:
> On Wed, 6 Apr 2016, Geert Uytterhoeven wrote:
>> On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.c=
om> wrote:
>>>  v6:
>>>  - time_t, __kenel_off_t and other types turned to be 32-bit
>>>    for compatibility reasons (after v5 discussion);
>
> Introducing a new arch today with y2038 problems is not a good idea.
> Linus said so with appropriately pointy words in 2011.

This is the third time we had this discussion on time_t for ILP32.  I
had originally it as 32bit, then Catalin suggested I change it to
64bit and then Arnd (with his work for 2038 issue on 32bit arch) said
ILP32 should match all other 32bit targets and the other 64bit time_t
be fixed by the current work he was working on.  Now you are
suggesting we change it again.
Arnd can you please comment more on why we want 32bit time_t instead
of the 64bit one?  I Know there was some POSIX (or was it C90)
violation but I suspect there is an easy way to workaround this inside
the kernel but the discussion to move over to 32bit time_t was already
made by the time I started to look into that.

>
>> What makes you think these "applications that can=E2=80=99t readily =
be migrated to LP64
>> because they were written assuming an ILP32 data model, and that wil=
l never
>> become suitable for a LP64 data model and will remain locked into IL=
P32
>> operating environments" are more likely to be fixed for y2038 later,=
 than for
>> LP64 now?
>
> Such broken applications already have plenty of bogus architecture de=
tection
> code so you need porting anyway...

I don't disagree here; just see below ...

>
>> We're already closer to the (future) y2038 than to the (past) introd=
uction of
>> LP64...
>>
>> These unfixable legacy applications have been spreading through x32 =
to
>> the shiny new arm64 server architecture (does ppc64el also have an I=
LP32 mode,
>> or is it planned)? Lots of resources are spent on maintaining the st=
atus quo,
>> instead of on fixing the real problems.
>
> As an x32 (userland) porter, I can tell you that time_t!=3Dlong _did_=
 cause
> non-trivial amounts of work.  But that work is already done (at least=
 in
> Debian), so you might as well benefit from it.

There is actually private code out there which uses timespec and
timeval to pass time over the wire; yes I know bad coding style and
all but they did it that way.  This is code which was working for x86
and we are porting it to ARM64; a data center code by the way; not
some networking code even.  This means they have not ported the code
to fully 64bit yet and they might never.

Thanks,
Andrew

>
>
> --
> A tit a day keeps the vet away.
