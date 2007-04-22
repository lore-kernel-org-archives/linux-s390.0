Return-Path: <linux-kernel-owner+w=401wt.eu-S965509AbXDVIB1@vger.kernel.org>
Subject: Re: [PATCH 3/8] Kconfig: unwanted config options for s390.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704220115.01532.arnd@arndb.de>
References: <20070420113310.GD3738@skybase>
	 <200704220115.01532.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 22 Apr 2007 10:01:41 +0200
Message-Id: <1177228901.8046.13.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2007-04-22 at 01:15 +0200, Arnd Bergmann wrote:
> > @@ -81,6 +82,7 @@ config VT_HW_CONSOLE_BINDING
> > =20
> >  config SERIAL_NONSTANDARD
> >  	bool "Non-standard serial port support"
> > +	depends on !S390
> >  	---help---
> >  	  Say Y here if you have any non-standard serial boards -- boards
> >  	  which aren't supported using the standard "dumb" serial driver.
>=20
> depends on MMIO

Depends on HAS_IOMEM.

> > @@ -822,7 +824,7 @@ config SGI_IP27_RTC
> > =20
> >  config GEN_RTC
> >  	tristate "Generic /dev/rtc emulation"
> > -	depends on RTC!=3Dy && !IA64 && !ARM && !M32R && !SPARC && !FRV
> > +	depends on RTC!=3Dy && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S=
390
> >  	---help---
> >  	  If you say Y here and create a character special file /dev/rtc with
> >  	  major number 10 and minor number 135 using mknod ("man mknod"), you
>=20
> ok.
>=20
> this one is bad in general and should probably be a select from the archi=
tecture,
> but that should not stop you from adding another architecture...

The disable extension would help here, but I never got anywhere with it.

> > @@ -878,6 +880,7 @@ config DTLK
> > =20
> >  config R3964
> >  	tristate "Siemens R3964 line discipline"
> > +	depends on !S390
> >  	---help---
> >  	  This driver allows synchronous communication with devices using the
> >  	  Siemens R3964 packet protocol. Unless you are dealing with special
>=20
> Does it build? I don't see a point disabling this one just because there =
are
> no users. Most architectures also don't have users for this one, but it
> doesn't hurt be able to build it using allyesconfig.

I'll try to build it.

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
