Return-Path: <linux-kernel-owner+w=401wt.eu-S1161703AbXDXHwZ@vger.kernel.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20070423104534.51bac974.akpm@linux-foundation.org>
References: <20070423141123.GA21174@skybase>
	 <20070423104534.51bac974.akpm@linux-foundation.org>
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 24 Apr 2007 09:52:39 +0200
Message-Id: <1177401159.22970.3.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2007-04-23 at 10:45 -0700, Andrew Morton wrote:
> > Andrew: I plan to add patches 1-5 to the for-andrew branch of the
> > git390 repository if that is fine with you. The only thing that will
> > be missing in the tree is the patch that disables wireless for s390.
> > The code does compile but without hardware it is mute to have the
> > config options. I'll wait until the git-wireless.patch is upstream.
> > Patches 7-9 depend on patches found in -mm.
> >=20
>=20
> umm, OK.  If it's Ok I think I'll duck it for now: -mm is full.
>=20
> Over-full, really: I've been working basically continuously since Friday
> getting the current dungpile to compile and boot, and it's still miles aw=
ay
> from that.

I understand. I'll wait until -mm is a little bit smaller again. It is
just that someday I want to finish with the Kconfig cleanup, it has been
sitting on my harddriver for ages now.

--=20
blue skies,              IBM Deutschland Entwicklung GmbH
   Martin                Vorsitzender des Aufsichtsrats: Johann Weihen
                         Gesch=E4ftsf=FChrung: Herbert Kircher
Martin Schwidefsky       Sitz der Gesellschaft: B=F6blingen
Linux on zSeries         Registergericht: Amtsgericht Stuttgart,
   Development           HRB 243294

"Reality continues to ruin my life." - Calvin.
