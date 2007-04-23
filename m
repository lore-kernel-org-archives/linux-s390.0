Return-Path: <linux-kernel-owner+w=401wt.eu-S1161458AbXDWL1l@vger.kernel.org>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704231322.36970.arnd@arndb.de>
References: <20070420113505.GH3738@skybase>
	 <200704221146.11439.mb@bu3sch.de> <1177327011.5984.10.camel@localhost>
	 <200704231322.36970.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 23 Apr 2007 13:27:56 +0200
Message-Id: <1177327676.5984.12.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Buesch <mb@bu3sch.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2007-04-23 at 13:22 +0200, Arnd Bergmann wrote:
> > The current Kconfig code does not check all select statements if they
> > can be enabled before allowing the config option that does the select.
> > So the rule for using select statements is that the depends line of the
> > config option that selects another config option needs to be at least as
> > restrictive as the depends line of the selected option. Hence I'll add
> > the HAS_IOMEM depends to B44 as well. Okay ?
>=20
> Isn't B44 already behind a WIRELESS or IEEE80211 or similar option that
> can't be selected on s390?

No, the option can be found in drivers/net/Kconfig under menu "Ethernet
(10 or 100Mbit)".

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
