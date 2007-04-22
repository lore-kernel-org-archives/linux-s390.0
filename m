Return-Path: <linux-kernel-owner+w=401wt.eu-S965496AbXDVHuV@vger.kernel.org>
Subject: Re: [PATCH 2/8] Kconfig: unwanted menus for s390.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <200704220232.10219.arnd@arndb.de>
References: <20070420113248.GC3738@skybase>
	 <200704220110.54587.arnd@arndb.de>  <200704220232.10219.arnd@arndb.de>
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 22 Apr 2007 09:50:32 +0200
Message-Id: <1177228232.8046.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2007-04-22 at 02:32 +0200, Arnd Bergmann wrote:
> I just saw that we already have an option like that, with a slightly diff=
erent
> name.
>=20
> arch/s390/Kconfig contains
>=20
> config NO_IOMEM
>         def_bool y
>=20
> and lib/Kconfig contains
>=20
> config HAS_IOMEM
>         boolean
>         depends on !NO_IOMEM
>         default y

Now that is a good idea, I should be able to replace quite a few !S390
with HAS_IOMEM. It much better reflects WHY things don't work.
Just !S390 is so negative ..

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
