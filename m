From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/7] Remove errors building drivers/DRIVERNAME
Date: Wed, 26 Sep 2018 09:05:04 +0200
Message-ID: <CAMuHMdXaAuHdCK8aeRucefn_GwkM-uYdFArOBPHD2gM5bdNRwg@mail.gmail.com>
References: <20180926015147.GA14862@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926015147.GA14862@WindFlash>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: leobras.c@gmail.com
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, oprofile-list@lists.sf.net, Parisc List <linux-parisc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

Hi Leonardo,

Thanks for your patch series!

On Wed, Sep 26, 2018 at 3:51 AM Leonardo Brás <leobras.c@gmail.com> wrote:
> This Patchset changes some driver's Makefile to allow them building
> using the command 'make drivers/DRIVERNAME', if compatible.

Please note that running "make drivers/DRIVERNAME" assumes that you know
exactly what you're doing. In the normal build process, you should just run
"make".

> The changed drivers would return error if the above command was run
> on them, after an x86 allyesconfig.

That is expected, as the DIO, NuBus, and Zorro buses, and PA-RISC and
S390 specific drivers are not supported on x86.
That is also the reason why you cannot enable support for them when configuring
your kernel.

If you want to enable e.g. NuBus support, you have to configure a kernel
for m68k/Mac, and (cross)compile it.

At https://mirrors.edge.kernel.org/pub/tools/crosstool/, you can find cross
compiler binaries for download.  Altermatively, your Linux distribution may
provide cross compiler packages.

> The main reason of this patchset is to allow building lists of
> drivers looking for warnings and errors to be fixed.

We already have COMPILE_TEST for that.
If you want to increase compile coverage, please look into adding
"|| COMPILE_TEST" dependencies to subsystems and drivers that still lack it,
and (if needed) modifying the code to make the result build.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
