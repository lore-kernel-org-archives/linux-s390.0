Return-Path: <linux-kernel-owner+w=401wt.eu-S965540AbXDVIJ6@vger.kernel.org>
Subject: Re: [PATCH 2/8] Kconfig: unwanted menus for s390.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704220110.54587.arnd@arndb.de>
References: <20070420113248.GC3738@skybase>
	 <200704220110.54587.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 22 Apr 2007 10:10:08 +0200
Message-Id: <1177229408.8046.21.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2007-04-22 at 01:10 +0200, Arnd Bergmann wrote:
> > --- linux-2.6/drivers/dma/Kconfig	2007-04-19 15:24:33.000000000 +0200
> > +++ linux-2.6-patched/drivers/dma/Kconfig	2007-04-19 15:49:55.000000000=
 +0200
> > @@ -3,6 +3,7 @@
> >  #
> > =20
> >  menu "DMA Engine support"
> > +	depends on !S390
> > =20
> >  config DMA_ENGINE
> >  	bool "Support for DMA engines"
>=20
> I'd leave the menu enabled. If the DMA engine infrastructure becomes more=
 widely
> used, you may want to add an implementation for s390 using milicoded inst=
ructions
> like xor-string or copy-page.

If we ever add an implementation for s390 we can rmeove the depends line
again. The current situation is that we don't support it.

> > diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-patched/drivers/in=
put/Kconfig
> > --- linux-2.6/drivers/input/Kconfig	2007-02-04 19:44:54.000000000 +0100
> > +++ linux-2.6-patched/drivers/input/Kconfig	2007-04-19 15:49:55.0000000=
00 +0200
> > @@ -3,6 +3,7 @@
> >  #
> > =20
> >  menu "Input device support"
> > +	depends on !S390
> > =20
> >  config INPUT
> >  	tristate "Generic input layer (needed for keyboard, mouse, ...)" if E=
MBEDDED
>=20
> Probably leave this as !S390. One could imagine channel-attached input de=
vices
> or the idea of intepreting a terminal as an input device, but no driver c=
urrently
> does and probably never will.

We don't have support and it is VERY unlikely we will get it. I would
prefer to hide the menu.

> > diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-patched/drivers/isd=
n/Kconfig
> > --- linux-2.6/drivers/isdn/Kconfig	2007-02-04 19:44:54.000000000 +0100
> > +++ linux-2.6-patched/drivers/isdn/Kconfig	2007-04-19 15:49:55.00000000=
0 +0200
> > @@ -3,6 +3,7 @@
> >  #
> > =20
> >  menu "ISDN subsystem"
> > +	depends on !S390
> > =20
> >  config ISDN
> >  	tristate "ISDN support"
>=20
> Same here, actually there was an IBM 2216 ISDN adapter with channel attac=
hment,
> but I don't think anybody wants to add a driver for that one.

Without a driver is it mute to have the menu.

> > diff -urpN linux-2.6/drivers/misc/Kconfig linux-2.6-patched/drivers/mis=
c/Kconfig
> > --- linux-2.6/drivers/misc/Kconfig	2007-04-19 15:24:35.000000000 +0200
> > +++ linux-2.6-patched/drivers/misc/Kconfig	2007-04-19 15:49:55.00000000=
0 +0200
> > @@ -3,6 +3,7 @@
> >  #
> > =20
> >  menu "Misc devices"
> > +	depends on !S390
> > =20
> >  config IBM_ASM
> >  	tristate "Device driver for IBM RSA service processor"
>=20
> Maybe just leave the menu open, all drivers in it are already depending o=
n PCI
> or similar and someone might add a driver that does work on s390 here.

This is a border-case. Someone might add a driver that actually works.
Currently it is an empty menu.=20

> > diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-patched/drivers/rtc/=
Kconfig
> > --- linux-2.6/drivers/rtc/Kconfig	2007-04-19 15:24:39.000000000 +0200
> > +++ linux-2.6-patched/drivers/rtc/Kconfig	2007-04-19 15:49:55.000000000=
 +0200
> > @@ -3,6 +3,7 @@
> >  #
> > =20
> >  menu "Real Time Clock"
> > +	depends on !S390
> > =20
> >  config RTC_LIB
> >  	tristate
>=20
> Applications might actually want to use the RTC interface to access the s=
ystem time
> or get accurate timers, but the rtc drivers are all very dependant on eit=
her MMIO
> or I2C. Not sure what would be best here.

If we ever come up with an implementation for RTC we can remove the
depends statement again. Until we do it is another empty menu.

Thanks Arnd for the review.

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
