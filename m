From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 2/7] drivers: nubus: Avoids building driver if CONFIG_NUBUS
 is disabled
Date: Wed, 26 Sep 2018 16:45:28 +1000 (AEST)
Message-ID: <alpine.LNX.2.21.1809261515090.639@nippy.intranet>
References: <20180926015218.GA14964@WindFlash>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926015218.GA14964@WindFlash>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Sep 2018, Leonardo Bras wrote:

> Avoids building driver if 'make drivers/nubus/' is called and
> CONFIG_NUBUS is disabled.
> Avoids building proc.o if CONFIG_PROC_FS is enabled but
> CONFIG_NUBUS is disabled.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  drivers/nubus/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
> index 6d063cde39d1..827301c4a84f 100644
> --- a/drivers/nubus/Makefile
> +++ b/drivers/nubus/Makefile
> @@ -2,6 +2,6 @@
>  # Makefile for the nubus specific drivers.
>  #
>  
> -obj-y := nubus.o bus.o
> -
> -obj-$(CONFIG_PROC_FS) += proc.o
> +obj-$(CONFIG_NUBUS) := nubus.o
> +nubus-y := bus.o
> +nubus-$(CONFIG_PROC_FS) += proc.o
> 

Did you build this for m68k? It doesn't link for me.

  MODPOST vmlinux.o
drivers/nubus/bus.o: In function `nubus_device_release':
bus.c:(.text+0xd0): undefined reference to `nubus_func_rsrcs'
bus.c:(.text+0xe0): undefined reference to `nubus_func_rsrcs'
bus.c:(.text+0x118): undefined reference to `nubus_func_rsrcs'
bus.c:(.text+0xc2): undefined reference to `nubus_func_rsrcs'
drivers/nubus/proc.o: In function `nubus_devices_proc_show':
proc.c:(.text+0xa): undefined reference to `nubus_first_rsrc_or_null'
proc.c:(.text+0x1c): undefined reference to `nubus_next_rsrc_or_null'
drivers/nubus/proc.o: In function `nubus_proc_rsrc_show':
proc.c:(.text+0x190): undefined reference to `nubus_seq_write_rsrc_mem'
drivers/nubus/proc.o: In function `nubus_proc_add_rsrc_mem':
proc.c:(.text+0x24c): undefined reference to `nubus_dirptr'

Patch 4/7 (drivers/zorro) also causes 'undefined reference' errors. I 
didn't test the others.

-- 
