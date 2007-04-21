Return-Path: <linux-kernel-owner+w=401wt.eu-S932768AbXDUG2V@vger.kernel.org>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704202245.43806.mb@bu3sch.de>
References: <20070420113505.GH3738@skybase>
	 <200704202245.43806.mb@bu3sch.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Sat, 21 Apr 2007 08:28:33 +0200
Message-Id: <1177136913.25034.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2007-04-20 at 22:45 +0200, Michael Buesch wrote:
> This is wrong. SSB does not depend on PCI or PCMCIA.
> SSB can (and does) stay very well on its own feet and
> can be the main system bus.
> Most Linksys WRT routers work that way. They have no
> PCI bus, but a SSB bus instead.
>=20
> Nevertheless, I'm not sure what your problem really is.
> Does a s390 machine exist with a B44 card? I doubt it.
> So what about the following: We simply add
> a DEPENDS ON !S390 to both SSB and B44.
> I really thing that is the right fix for this.
> The patch above is clearly not, as it breaks things for
> embedded devices without PCI or PCMCIA bus.

Ok, thanks. I will change the patch accordingly.

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
