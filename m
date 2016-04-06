From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Wed, 6 Apr 2016 15:29:24 +0300
Message-ID: <20160406122924.GA21527@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <CAMuHMdUUkaYVZ3-Jh6o1b++R=yFBg7siQt+A+TqqXRSa953CAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUkaYVZ3-Jh6o1b++R=yFBg7siQt+A+TqqXRSa953CAw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Pinski <pinskia@gmail.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Nathan Lynch <Nathan_Lynch@mentor.com>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Geert,

On Wed, Apr 06, 2016 at 08:51:50AM +0200, Geert Uytterhoeven wrote:
> Hi Yuri,
>=20
> On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.co=
m> wrote:
> > This version is rebased on kernel v4.6-rc2, and has fixes in signal=
 subsystem.
> > It works with updated glibc [1] (though very draft), and tested wit=
h LTP.
> >
> > It was tested on QEMU and ThunderX machines. No major difference fo=
und.
> > This is RFC because ILP32 is not tested in big-endian mode.
> >
> >  v3: https://lkml.org/lkml/2014/9/3/704
> >  v4: https://lkml.org/lkml/2015/4/13/691
> >  v5: https://lkml.org/lkml/2015/9/29/911
> >
> >  v6:
> >  - time_t, __kenel_off_t and other types turned to be 32-bit
> >    for compatibility reasons (after v5 discussion);
>=20
> Reading this sparked my interest, so I went to the links above...

Great! I'll add you to CC than.

>=20
> What makes you think these "applications that can=E2=80=99t readily b=
e migrated to LP64
> because they were written assuming an ILP32 data model, and that will=
 never
> become suitable for a LP64 data model and will remain locked into ILP=
32
> operating environments" are more likely to be fixed for y2038 later, =
than for
> LP64 now?
>=20

It was written by Philipp, not me:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/337350=
=2Ehtml

I'm not the author of this, and I don't think so. Maybe just because I
didn't see all that legacy nightmare, as Philipp does...

Chris Tyler shares relatively common point of view in his video from
Linaro Connect:
https://www.youtube.com/watch?v=3DQsVLsw_LrJ0

Briefly, we need it (mostly) for compatibility and (then) for performan=
ce.
Maybe Prasun can share more details and examples.

> We're already closer to the (future) y2038 than to the (past) introdu=
ction of
> LP64...
>=20

This is not about Y2038 at all. In fact, current version doesn't fix
Y2038 problem, as we decided finally.

After v4 and v5, it was spread discussion about what ilp32 should do,
and what not. Finally we decided to be not like aarch32, and not like
lp64, and don't fix any issues specifically, but be standard compat
format, as much as possible. So, any improvements and fixes applied
to generic compat will be applied to ilp32 with minimal efforts.

> These unfixable legacy applications have been spreading through x32 t=
o
> the shiny new arm64 server architecture (does ppc64el also have an IL=
P32 mode,
> or is it planned)?

I don't think this is the question you really don't know the answer.
Almost everywhere shiny arm64 comes with old and ugly aarch32 IP core.
If no, like ThunderX, people really worry about that. And for me,
configurable option in kernel sources is better tradeoff than billions
transistors in every chip on market. So Cavium here is more
future-oriented than many others...

The other example is ACPI. We have nice and cute device tree, don't we?
Does it make sense to vendors?

> Lots of resources are spent on maintaining the status quo,
> instead of on fixing the real problems.
>=20

I think, compatibility is one of real problems. Aarch32 is hardware
solution, and ilp32 is software one.

Yury.

> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>=20
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
>                                 -- Linus Torvalds
