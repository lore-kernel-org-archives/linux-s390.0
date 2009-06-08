Return-Path: <linux-kernel-owner+w=401wt.eu-S1756728AbZFHPUo@vger.kernel.org>
Date: Mon, 8 Jun 2009 08:35:01 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 01/38] pm: Move nvs routines into a seperate file.
Message-ID: <20090608063501.GC1444@ucw.cz>
References: <20090604161847.513682672@de.ibm.com> <20090604161859.713228968@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090604161859.713228968@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2009-06-04 18:18:48, Martin Schwidefsky wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> The *_nvs_* routines in swsusp.c make use of the io*map()
> functions, which are only provided for HAS_IOMEM, thus
> breaking compilation if HAS_IOMEM is not set. Fix this
> by moving the *_nvs_* routines into nvs.c, which is only
> compiled if HAS_IOMEM is set.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  include/linux/suspend.h |   18 ++++--
>  kernel/power/Kconfig    |    4 +
>  kernel/power/Makefile   |    1 
>  kernel/power/nvs.c      |  131 ++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/swsusp.c   |  122 --------------------------------------------
>  5 files changed, 147 insertions(+), 129 deletions(-)
> 
> Index: linux-2.6/kernel/power/nvs.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/kernel/power/nvs.c

Ideally, filename would be a bit more descriptive. 

> @@ -0,0 +1,131 @@
> +/*
> + * Routines for NVS memory handling
> + */

If you copy&pasted code, you need to copy&paste copyright notices, too.

> --- linux-2.6.orig/kernel/power/Makefile
> +++ linux-2.6/kernel/power/Makefile
> @@ -7,5 +7,6 @@ obj-$(CONFIG_PM)		+= main.o
>  obj-$(CONFIG_PM_SLEEP)		+= console.o
>  obj-$(CONFIG_FREEZER)		+= process.o
>  obj-$(CONFIG_HIBERNATION)	+= swsusp.o disk.o snapshot.o swap.o user.o
> +obj-$(CONFIG_NVS)		+= nvs.o
>  
>  obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o

CONFIG_NVS is definitely not descriptive enough. C_HIBERNATION_NVS?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
