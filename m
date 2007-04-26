Return-Path: <linux-kernel-owner+w=401wt.eu-S1754435AbXDZBHi@vger.kernel.org>
Date: Wed, 25 Apr 2007 18:06:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Message-Id: <20070425180611.25c563d4.akpm@linux-foundation.org>
In-Reply-To: <200704260232.06909.arnd@arndb.de>
References: <20070423141123.GA21174@skybase>
	<20070425143011.57247c1d.akpm@linux-foundation.org>
	<20070425172447.1576c399.akpm@linux-foundation.org>
	<200704260232.06909.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mb@bu3sch.de, linville@tuxdriver.com, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thu, 26 Apr 2007 02:32:06 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 26 April 2007, Andrew Morton wrote:
> > It would be neat if someone could create and maintain a new
> > scripts/spot-common-mistakes. =A0Feed it a unified diff and it would co=
mplain
> > about newly-added code (and only newly-added code) which has busted
> > whitespace, adds new semaphores, adds new kernel_thread calls, etc, etc.
>=20
> http://patchstylecheck.googlecode.com/svn/trunk/patchstylecheckemail.pl
> Might serve as a starting point for this. It doesn't have any semantic
> checks right now, but I guess they can be added.
>=20

	print "Your patch is now worthy to be reviewed by a real person\n";

heh.  Yes, that looks like an ideal starting point.

Methinks it should do `exit 1' if anything was detected.
