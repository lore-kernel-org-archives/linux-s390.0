Return-Path: <linux-kernel-owner+w=401wt.eu-S1161373AbXDWLQi@vger.kernel.org>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704221146.11439.mb@bu3sch.de>
References: <20070420113505.GH3738@skybase>
	 <200704220119.32729.arnd@arndb.de> <1177228423.8046.5.camel@localhost>
	 <200704221146.11439.mb@bu3sch.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 23 Apr 2007 13:16:51 +0200
Message-Id: <1177327011.5984.10.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2007-04-22 at 11:46 +0200, Michael Buesch wrote:
> > > No, this doesn't look right. There are other devices that come with
> > > SiliconBackplane but are not PCI or PCMCIA style devices.
> >=20
> > Yes, Michael already told me about that. The current solution is to use
> > !S390, could we use HAS_IOMEM instead ?
>=20
> I'd think either should be fine.

I will use HAS_IOMEM then. The oddity with the select statement still
exists though. I have to add the "depends on HAS_IOMEM" to SSB and B44.
If I just add it to SSB then the config option for B44 exists for s390
and you can enable it. The select statement will then enable SSB as well
(.config contains CONFIG_SSB=3Dy for allyesconfig). This is in
contradiction to the depends statement since HAS_IOMEM=3Dn on s390.

The current Kconfig code does not check all select statements if they
can be enabled before allowing the config option that does the select.
So the rule for using select statements is that the depends line of the
config option that selects another config option needs to be at least as
restrictive as the depends line of the selected option. Hence I'll add
the HAS_IOMEM depends to B44 as well. Okay ?

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
