Return-Path: <linux-kernel-owner+w=401wt.eu-S1753695AbXDUXPS@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/8] Kconfig: unwanted config options for s390.
Date: Sun, 22 Apr 2007 01:15:01 +0200
References: <20070420113310.GD3738@skybase>
In-Reply-To: <20070420113310.GD3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704220115.01532.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Friday 20 April 2007, Martin Schwidefsky wrote:

> diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
> --- linux-2.6/drivers/char/Kconfig	2007-04-19 15:49:51.000000000 +0200
> +++ linux-2.6-patched/drivers/char/Kconfig	2007-04-19 15:50:50.000000000 +0200
> @@ -6,6 +6,7 @@ menu "Character devices"
>  
>  config VT
>  	bool "Virtual terminal" if EMBEDDED
> +	depends on !S390
>  	select INPUT
>  	default y if !VIOCONS
>  	---help---

ok

> @@ -81,6 +82,7 @@ config VT_HW_CONSOLE_BINDING
>  
>  config SERIAL_NONSTANDARD
>  	bool "Non-standard serial port support"
> +	depends on !S390
>  	---help---
>  	  Say Y here if you have any non-standard serial boards -- boards
>  	  which aren't supported using the standard "dumb" serial driver.

depends on MMIO

> @@ -774,7 +776,7 @@ config NVRAM
>  
>  config RTC
>  	tristate "Enhanced Real Time Clock Support"
> -	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !SUPERH
> +	depends on !PPC && !PARISC && !IA64 && !M68K && (!SPARC || PCI) && !FRV && !ARM && !SUPERH && !S390
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you
> @@ -822,7 +824,7 @@ config SGI_IP27_RTC
>  
>  config GEN_RTC
>  	tristate "Generic /dev/rtc emulation"
> -	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV
> +	depends on RTC!=y && !IA64 && !ARM && !M32R && !SPARC && !FRV && !S390
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you

ok.

this one is bad in general and should probably be a select from the architecture,
but that should not stop you from adding another architecture...

> @@ -878,6 +880,7 @@ config DTLK
>  
>  config R3964
>  	tristate "Siemens R3964 line discipline"
> +	depends on !S390
>  	---help---
>  	  This driver allows synchronous communication with devices using the
>  	  Siemens R3964 packet protocol. Unless you are dealing with special

Does it build? I don't see a point disabling this one just because there are
no users. Most architectures also don't have users for this one, but it
doesn't hurt be able to build it using allyesconfig.

	Arnd <><
