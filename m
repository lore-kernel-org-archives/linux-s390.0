Return-Path: <linux-kernel-owner+w=401wt.eu-S1753692AbXDUXLN@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8] Kconfig: unwanted menus for s390.
Date: Sun, 22 Apr 2007 01:10:54 +0200
References: <20070420113248.GC3738@skybase>
In-Reply-To: <20070420113248.GC3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200704220110.54587.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Friday 20 April 2007, Martin Schwidefsky wrote:
> diff -urpN linux-2.6/drivers/char/ipmi/Kconfig linux-2.6-patched/drivers/=
char/ipmi/Kconfig
> --- linux-2.6/drivers/char/ipmi/Kconfig=A02007-02-04 19:44:54.000000000 +=
0100
> +++ linux-2.6-patched/drivers/char/ipmi/Kconfig=A02007-04-19 15:49:55.000=
000000 +0200
> @@ -3,6 +3,8 @@
> =A0#
> =A0
> =A0menu "IPMI"
> +=A0=A0=A0=A0=A0=A0=A0depends on !S390
> +
> =A0config IPMI_HANDLER
> =A0 =A0 =A0 =A0 tristate 'IPMI top-level message handler'
> =A0 =A0 =A0 =A0 help

I think I made this comment the last time we discussed this topic, but don't
remember the exact outcome.

I would prefer to not have 'depends on !S390' but rather 'depends on MMIO',
because that is what really drives stuff like IPMI: they expect the device
to be reachable through the use of ioremap or inX/outX instructions, which
don't exist on s390.

While it's unlikely that another architecture has the same restriction,
it expresses much clearer what you mean.

In drivers/Kconfig, you can then simply add a

config MMIO
	def_bool !S390

There are a few exceptions though, that I think should not depend on MMIO:

> --- linux-2.6/drivers/dma/Kconfig	2007-04-19 15:24:33.000000000 +0200
> +++ linux-2.6-patched/drivers/dma/Kconfig	2007-04-19 15:49:55.000000000 +=
0200
> @@ -3,6 +3,7 @@
>  #
> =20
>  menu "DMA Engine support"
> +	depends on !S390
> =20
>  config DMA_ENGINE
>  	bool "Support for DMA engines"

I'd leave the menu enabled. If the DMA engine infrastructure becomes more w=
idely
used, you may want to add an implementation for s390 using milicoded instru=
ctions
like xor-string or copy-page.

> diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-patched/drivers/inpu=
t/Kconfig
> --- linux-2.6/drivers/input/Kconfig	2007-02-04 19:44:54.000000000 +0100
> +++ linux-2.6-patched/drivers/input/Kconfig	2007-04-19 15:49:55.000000000=
 +0200
> @@ -3,6 +3,7 @@
>  #
> =20
>  menu "Input device support"
> +	depends on !S390
> =20
>  config INPUT
>  	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMB=
EDDED

Probably leave this as !S390. One could imagine channel-attached input devi=
ces
or the idea of intepreting a terminal as an input device, but no driver cur=
rently
does and probably never will.

> diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-patched/drivers/isdn/=
Kconfig
> --- linux-2.6/drivers/isdn/Kconfig	2007-02-04 19:44:54.000000000 +0100
> +++ linux-2.6-patched/drivers/isdn/Kconfig	2007-04-19 15:49:55.000000000 =
+0200
> @@ -3,6 +3,7 @@
>  #
> =20
>  menu "ISDN subsystem"
> +	depends on !S390
> =20
>  config ISDN
>  	tristate "ISDN support"

Same here, actually there was an IBM 2216 ISDN adapter with channel attachm=
ent,
but I don't think anybody wants to add a driver for that one.

> diff -urpN linux-2.6/drivers/misc/Kconfig linux-2.6-patched/drivers/misc/=
Kconfig
> --- linux-2.6/drivers/misc/Kconfig	2007-04-19 15:24:35.000000000 +0200
> +++ linux-2.6-patched/drivers/misc/Kconfig	2007-04-19 15:49:55.000000000 =
+0200
> @@ -3,6 +3,7 @@
>  #
> =20
>  menu "Misc devices"
> +	depends on !S390
> =20
>  config IBM_ASM
>  	tristate "Device driver for IBM RSA service processor"

Maybe just leave the menu open, all drivers in it are already depending on =
PCI
or similar and someone might add a driver that does work on s390 here.

> diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-patched/drivers/ne=
t/phy/Kconfig
> --- linux-2.6/drivers/net/phy/Kconfig	2007-02-04 19:44:54.000000000 +0100
> +++ linux-2.6-patched/drivers/net/phy/Kconfig	2007-04-19 15:49:55.0000000=
00 +0200
> @@ -3,6 +3,7 @@
>  #
> =20
>  menu "PHY device support"
> +	depends on !S390
> =20
>  config PHYLIB
>  	tristate "PHY Device support and infrastructure"

Also depends on !S390, not MMIO. A future network adapter might give you ac=
cess
to the phy device through other means than MMIO.

> diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-patched/drivers/rtc/Kc=
onfig
> --- linux-2.6/drivers/rtc/Kconfig	2007-04-19 15:24:39.000000000 +0200
> +++ linux-2.6-patched/drivers/rtc/Kconfig	2007-04-19 15:49:55.000000000 +=
0200
> @@ -3,6 +3,7 @@
>  #
> =20
>  menu "Real Time Clock"
> +	depends on !S390
> =20
>  config RTC_LIB
>  	tristate

Applications might actually want to use the RTC interface to access the sys=
tem time
or get accurate timers, but the rtc drivers are all very dependant on eithe=
r MMIO
or I2C. Not sure what would be best here.

	Arnd <><
