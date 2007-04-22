Return-Path: <linux-kernel-owner+w=401wt.eu-S965494AbXDVHxa@vger.kernel.org>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704220119.32729.arnd@arndb.de>
References: <20070420113505.GH3738@skybase>
	 <200704220119.32729.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 22 Apr 2007 09:53:43 +0200
Message-Id: <1177228423.8046.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2007-04-22 at 01:19 +0200, Arnd Bergmann wrote:
> > diff -urpN linux-2.6/drivers/ssb/Kconfig linux-2.6-patched/drivers/ssb/=
Kconfig
> > --- linux-2.6/drivers/ssb/Kconfig       2007-04-19 15:24:40.000000000 +=
0200
> > +++ linux-2.6-patched/drivers/ssb/Kconfig       2007-04-19 15:55:44.000=
000000 +0200
> > @@ -1,4 +1,5 @@
> >  menu "Sonics Silicon Backplane"
> > +       depends on PCI || PCMCIA
>=20
> No, this doesn't look right. There are other devices that come with
> SiliconBackplane but are not PCI or PCMCIA style devices.

Yes, Michael already told me about that. The current solution is to use
!S390, could we use HAS_IOMEM instead ?

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
