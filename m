Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Apr 2015 19:32:24 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 7/7] s390/block/dasd: remove obsolete while -EBUSY
 loop
In-Reply-To: <1428508384-29008-8-git-send-email-ming.lei@canonical.com>
Message-ID: <alpine.LFD.2.11.1504081924120.1757@denkbrett>
References: <1428508384-29008-1-git-send-email-ming.lei@canonical.com> <1428508384-29008-8-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 8 Apr 2015, Ming Lei wrote:
> From: Jarod Wilson <jarod@redhat.com>
> 
> With the mutex_trylock bit gone from blkdev_reread_part(), the retry logic
> in dasd_scan_partitions() shouldn't be necessary.
> 
> CC: Christoph Hellwig <hch@infradead.org>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Tejun Heo <tj@kernel.org>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Markus Pargmann <mpa@pengutronix.de>
> CC: Stefan Weinhuber <wein@de.ibm.com>
> CC: Stefan Haberland <stefan.haberland@de.ibm.com>
> CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
> CC: Fabian Frederick <fabf@skynet.be>
> CC: Ming Lei <ming.lei@canonical.com>
> CC: David Herrmann <dh.herrmann@gmail.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: nbd-general@lists.sourceforge.net
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  drivers/s390/block/dasd_genhd.c |   13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
> index 2af4619..189ea2f 100644
> --- a/drivers/s390/block/dasd_genhd.c
> +++ b/drivers/s390/block/dasd_genhd.c
> @@ -99,9 +99,8 @@ void dasd_gendisk_free(struct dasd_block *block)
>  int dasd_scan_partitions(struct dasd_block *block)
>  {
>  	struct block_device *bdev;
> -	int retry, rc;
> +	int rc;
> 
> -	retry = 5;
>  	bdev = bdget_disk(block->gdp, 0);
>  	if (!bdev) {
>  		DBF_DEV_EVENT(DBF_ERR, block->base, "%s",
> @@ -118,14 +117,8 @@ int dasd_scan_partitions(struct dasd_block *block)
>  	}
> 
>  	rc = blkdev_reread_part(bdev);
> -	while (rc == -EBUSY && retry > 0) {
> -		schedule();
> -		rc = blkdev_reread_part(bdev);
> -		retry--;
> -		DBF_DEV_EVENT(DBF_ERR, block->base,
> -			      "scan partitions error, retry %d rc %d",
> -			      retry, rc);
> -	}
> +	DBF_DEV_EVENT(DBF_ERR, block->base,
> +		      "scan partitions error, rc %d", rc);

Could you please change that to only write the debug message in the error
case. Other than that, both dasd patches look good.

Thanks,
Sebastian

> 
>  	/*
>  	 * Since the matching blkdev_put call to the blkdev_get in
> -- 
> 1.7.9.5
> 
> 
