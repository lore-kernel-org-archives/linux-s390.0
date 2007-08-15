From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 15 Aug 2007 10:10:25 +0000
Subject: Re: [kj] is_power_of_2 in drivers/s390/block/dasd_int.h
Message-Id: <20070815101025.GB16551@osiris.boeblingen.de.ibm.com>
In-Reply-To: <1187009639.7273.6.camel@merlin.linuxcoe.com>
References: <1187009639.7273.6.camel@merlin.linuxcoe.com>
To: linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 13, 2007 at 06:23:59PM +0530, vignesh babu wrote:
> Replacing n & (n - 1) for power of 2 check by is_power_of_2(n)
> 
> Signed-off-by: vignesh babu <vignesh.babu@wipro.com>
> ---
> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
> index aeda526..d427dae 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -53,6 +53,7 @@
>  #include <linux/genhd.h>
>  #include <linux/hdreg.h>
>  #include <linux/interrupt.h>
> +#include <linux/log2.h>
>  #include <asm/ccwdev.h>
>  #include <linux/workqueue.h>
>  #include <asm/debug.h>
> @@ -456,7 +457,7 @@ dasd_free_chunk(struct list_head *chunk_list, void *mem)
>  static inline int
>  dasd_check_blocksize(int bsize)
>  {
> -	if (bsize < 512 || bsize > 4096 || (bsize & (bsize - 1)) != 0)
> +	if (bsize < 512 || bsize > 4096 || !is_power_of_2(bsize))
>  		return -EMEDIUMTYPE;
>  	return 0;
>  }

Added to our patch queue. Thanks.
