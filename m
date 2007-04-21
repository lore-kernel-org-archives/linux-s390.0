Return-Path: <linux-kernel-owner+w=401wt.eu-S1753831AbXDUXUO@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] Kconfig: silicon backplane dependency.
Date: Sun, 22 Apr 2007 01:19:32 +0200
References: <20070420113505.GH3738@skybase>
In-Reply-To: <20070420113505.GH3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200704220119.32729.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com
List-ID: <linux-s390.vger.kernel.org>

On Friday 20 April 2007, Martin Schwidefsky wrote:
>=20
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>=20
> Make the "Sonics Silicon Backplane" menu dependent on the two buses
> it can be found on.
> Goes on top of git-wireless.patch.
>=20
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: John W. Linville <linville@tuxdriver.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>=20
> =A0drivers/ssb/Kconfig | =A0 =A01 +
> =A01 files changed, 1 insertion(+)
>=20
> diff -urpN linux-2.6/drivers/ssb/Kconfig linux-2.6-patched/drivers/ssb/Kc=
onfig
> --- linux-2.6/drivers/ssb/Kconfig=A0=A0=A0=A0=A0=A0=A02007-04-19 15:24:40=
.000000000 +0200
> +++ linux-2.6-patched/drivers/ssb/Kconfig=A0=A0=A0=A0=A0=A0=A02007-04-19 =
15:55:44.000000000 +0200
> @@ -1,4 +1,5 @@
> =A0menu "Sonics Silicon Backplane"
> +=A0=A0=A0=A0=A0=A0=A0depends on PCI || PCMCIA

No, this doesn't look right. There are other devices that come with
SiliconBackplane but are not PCI or PCMCIA style devices.

I'd make this 'depends on MMIO' as well if you add that option.

	Arnd <><
