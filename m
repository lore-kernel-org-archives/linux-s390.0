From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 15 Aug 2007 10:12:14 +0000
Subject: Re: [kj] is_power_of_2 in drivers/s390/cio
Message-Id: <20070815101214.GC16551@osiris.boeblingen.de.ibm.com>
In-Reply-To: <1187009705.7273.7.camel@merlin.linuxcoe.com>
References: <1187009705.7273.7.camel@merlin.linuxcoe.com>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 13, 2007 at 06:25:05PM +0530, vignesh babu wrote:
> Replacing n & (n - 1) for power of 2 check by is_power_of_2(n)
> 
> Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
> ---
> diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
> index 8633dc5..c00ebf4 100644
> --- a/drivers/s390/cio/device_fsm.c
> +++ b/drivers/s390/cio/device_fsm.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/jiffies.h>
>  #include <linux/string.h>
> +#include <linux/log2.h>
> 
>  #include <asm/ccwdev.h>
>  #include <asm/cio.h>
> @@ -1129,7 +1130,7 @@ device_trigger_reprobe(struct subchannel *sch)
>  	sch->schib.pmcw.isc = 3;
>  	sch->schib.pmcw.csense = 1;
>  	sch->schib.pmcw.ena = 0;
> -	if ((sch->lpm & (sch->lpm - 1)) != 0)
> +	if (!is_power_of_2(sch->lpm))
>  		sch->schib.pmcw.mp = 1;
>  	sch->schib.pmcw.intparm = (__u32)(unsigned long)sch;
>  	/* We should also udate ssd info, but this has to wait. */

This changes the path taken if sch->lpm == 0. Therefore NOT applied.
