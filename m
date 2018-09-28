From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Date: Fri, 28 Sep 2018 09:15:15 +0200
Message-ID: <1538118915.3593.4.camel@HansenPartnership.com>
References: <20180928020816.11251-1-leobras.c@gmail.com>
         <20180928020816.11251-4-leobras.c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928020816.11251-4-leobras.c@gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>, lkcamp@lists.libreplanetbr.org
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Finn Thain <fthain@telegraphics.com.au>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit

On Thu, 2018-09-27 at 23:08 -0300, Leonardo Brás wrote:
> Avoids building driver if 'make drivers/parisc/' is called and
> CONFIG_PARISC is disabled.

Is that really a problem? The drivers/Makefile has this:

obj-$(CONFIG_PARISC)		+= parisc/ 
And you just overrode that by forcing the build.  It's not even clear
we should refuse the build in that case; how would we know you don't
have a legitimate reason for the override? 

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/parisc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/parisc/Makefile b/drivers/parisc/Makefile
> index 3cd5e6cb8478..80049d763aa0 100644
> --- a/drivers/parisc/Makefile
> +++ b/drivers/parisc/Makefile
> @@ -24,5 +24,5 @@ obj-$(CONFIG_EISA)		+= eisa.o
> eisa_enumerator.o eisa_eeprom.o
>  obj-$(CONFIG_SUPERIO)		+= superio.o
>  obj-$(CONFIG_CHASSIS_LCD_LED)	+= led.o
>  obj-$(CONFIG_PDC_STABLE)	+= pdc_stable.o
> -obj-y				+= power.o
> +obj-$(CONFIG_PARISC)		+= power.o

If we conclude the use case is legitimate, that's not enough: the two
inner symbols are PARISC only but CONFIG_EISA isn't.

James
