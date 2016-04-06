From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Wed, 6 Apr 2016 08:51:50 +0200
Message-ID: <CAMuHMdUUkaYVZ3-Jh6o1b++R=yFBg7siQt+A+TqqXRSa953CAw@mail.gmail.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Pinski <pinskia@gmail.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Nathan Lynch <Nathan_Lynch@mentor.com>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Yuri,

On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.com>=
 wrote:
> This version is rebased on kernel v4.6-rc2, and has fixes in signal s=
ubsystem.
> It works with updated glibc [1] (though very draft), and tested with =
LTP.
>
> It was tested on QEMU and ThunderX machines. No major difference foun=
d.
> This is RFC because ILP32 is not tested in big-endian mode.
>
>  v3: https://lkml.org/lkml/2014/9/3/704
>  v4: https://lkml.org/lkml/2015/4/13/691
>  v5: https://lkml.org/lkml/2015/9/29/911
>
>  v6:
>  - time_t, __kenel_off_t and other types turned to be 32-bit
>    for compatibility reasons (after v5 discussion);

Reading this sparked my interest, so I went to the links above...

What makes you think these "applications that can=E2=80=99t readily be =
migrated to LP64
because they were written assuming an ILP32 data model, and that will n=
ever
become suitable for a LP64 data model and will remain locked into ILP32
operating environments" are more likely to be fixed for y2038 later, th=
an for
LP64 now?

We're already closer to the (future) y2038 than to the (past) introduct=
ion of
LP64...

These unfixable legacy applications have been spreading through x32 to
the shiny new arm64 server architecture (does ppc64el also have an ILP3=
2 mode,
or is it planned)? Lots of resources are spent on maintaining the statu=
s quo,
instead of on fixing the real problems.

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
