Return-Path: <linux-kernel-owner+w=401wt.eu-S1753895AbXDVAcX@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8] Kconfig: unwanted menus for s390.
Date: Sun, 22 Apr 2007 02:32:09 +0200
References: <20070420113248.GC3738@skybase> <200704220110.54587.arnd@arndb.de>
In-Reply-To: <200704220110.54587.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200704220232.10219.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Sunday 22 April 2007, Arnd Bergmann wrote:
> I would prefer to not have 'depends on !S390' but rather 'depends on MMIO=
',
> because that is what really drives stuff like IPMI: they expect the device
> to be reachable through the use of ioremap or inX/outX instructions, which
> don't exist on s390.
>=20
> While it's unlikely that another architecture has the same restriction,
> it expresses much clearer what you mean.
>=20
> In drivers/Kconfig, you can then simply add a
>=20
> config MMIO
> =A0=A0=A0=A0=A0=A0=A0=A0def_bool !S390

I just saw that we already have an option like that, with a slightly differ=
ent
name.

arch/s390/Kconfig contains

config NO_IOMEM
	def_bool y

and lib/Kconfig contains

config HAS_IOMEM
	boolean
	depends on !NO_IOMEM
	default y

You should probably just use one of these two to disable any driver that
uses ioremap or similar.

	Arnd <><
