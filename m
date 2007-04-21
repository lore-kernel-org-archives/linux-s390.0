Return-Path: <linux-kernel-owner+w=401wt.eu-S1753566AbXDUWuc@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/8] Kconfig: refine depends statements.
Date: Sun, 22 Apr 2007 00:50:23 +0200
References: <20070420113228.GB3738@skybase>
In-Reply-To: <20070420113228.GB3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200704220050.24089.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Friday 20 April 2007, Martin Schwidefsky wrote:
> diff -urpN linux-2.6/drivers/auxdisplay/Kconfig linux-2.6-patched/drivers=
/auxdisplay/Kconfig
> --- linux-2.6/drivers/auxdisplay/Kconfig=A0=A0=A0=A0=A0=A0=A0=A02007-04-1=
9 15:23:55.000000000 +0200
> +++ linux-2.6-patched/drivers/auxdisplay/Kconfig=A0=A0=A0=A0=A0=A0=A0=A02=
007-04-19 15:49:17.000000000 +0200
> @@ -6,6 +6,7 @@
> =A0#
> =A0
> =A0menu "Auxiliary Display support"
> +=A0=A0=A0=A0=A0=A0=A0depends on PARPORT_PC
> =A0
> =A0config KS0108
> =A0=A0=A0=A0=A0=A0=A0=A0tristate "KS0108 LCD Controller"

I would guess that this actually depends on PARPORT, not PARPORT_PC.

The rest of this patch looks good.

	Arnd <><
