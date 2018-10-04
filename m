From: Leonardo Bras <leobras.c@gmail.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Date: Wed, 3 Oct 2018 21:31:39 -0300
Message-ID: <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com>
 <1538118915.3593.4.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538118915.3593.4.camel@HansenPartnership.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Sep 28, 2018 at 4:15 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2018-09-27 at 23:08 -0300, Leonardo Br=C3=A1s wrote:
> > Avoids building driver if 'make drivers/parisc/' is called and
> > CONFIG_PARISC is disabled.
>
> Is that really a problem? The drivers/Makefile has this:
>
> obj-$(CONFIG_PARISC)            +=3D parisc/
> And you just overrode that by forcing the build.  It's not even clear
> we should refuse the build in that case; how would we know you don't
> have a legitimate reason for the override?
>

Sorry I did not explained my reasons earlier. I sent everybody involved an
e-mail explaining the full reason of this change.
(For reference it's here: https://lkml.org/lkml/2018/10/3/707)

> Signed-off-by: Leonardo Br=C3=A1s <leobras.c@gmail.com>
> > ---
> >  drivers/parisc/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
> > index 3cd5e6cb8478..80049d763aa0 100644
> > --- a/drivers/parisc/Makefile
> > +++ b/drivers/parisc/Makefile
> > @@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)          +=3D eisa.o
> > eisa_enumerator.o eisa_eeprom.o
> >  obj-$(CONFIG_SUPERIO)                +=3D superio.o
> >  obj-$(CONFIG_CHASSIS_LCD_LED)        +=3D led.o
> >  obj-$(CONFIG_PDC_STABLE)     +=3D pdc_stable.o
> > -obj-y                                +=3D power.o
> > +obj-$(CONFIG_PARISC)         +=3D power.o
>
> If we conclude the use case is legitimate, that's not enough: the two
> inner symbols are PARISC only but CONFIG_EISA isn't.

You are right.
It worked for my needs because I am only building the drivers, and not
linking them. But i believe doing something like I did in zorro/Makefile
would fix this all. (For reference, https://lkml.org/lkml/2018/9/28/150 )

If you agree, I will send the next patchset with this change.

Thanks for your help!

Leonardo Bras
