Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Apr 2015 09:46:55 -0400
From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 5/6] block: dasd_genhd: convert to blkdev_reread_part
Message-ID: <20150406134655.GE14217@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428218688-4092-6-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428218688-4092-6-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Apr 05, 2015 at 03:24:47PM +0800, Ming Lei wrote:
> Also remove the obsolete comment.
> 
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
>  drivers/s390/block/dasd_genhd.c |    9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
> index 90f39f7..2af4619 100644
> --- a/drivers/s390/block/dasd_genhd.c
> +++ b/drivers/s390/block/dasd_genhd.c
> @@ -116,14 +116,11 @@ int dasd_scan_partitions(struct dasd_block *block)
>  			      rc);
>  		return -ENODEV;
>  	}
> -	/*
> -	 * See fs/partition/check.c:register_disk,rescan_partitions
> -	 * Can't call rescan_partitions directly. Use ioctl.
> -	 */
> -	rc = ioctl_by_bdev(bdev, BLKRRPART, 0);
> +
> +	rc = blkdev_reread_part(bdev);
>  	while (rc == -EBUSY && retry > 0) {
>  		schedule();
> -		rc = ioctl_by_bdev(bdev, BLKRRPART, 0);
> +		rc = blkdev_reread_part(bdev);
>  		retry--;
>  		DBF_DEV_EVENT(DBF_ERR, block->base,
>  			      "scan partitions error, retry %d rc %d",

Note: patch 6/6 in the series makes this whole while() loops pointless,
since the possibility of the -EBUSY return goes away.

-- 
Jarod Wilson
jarod@redhat.com
