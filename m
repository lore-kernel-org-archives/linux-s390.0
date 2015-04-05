Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 5 Apr 2015 09:12:41 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/6] block: export blkdev_reread_part()
Message-ID: <20150405161241.GB16886@infradead.org>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428218688-4092-2-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428218688-4092-2-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> +/*
> + * This is exported as API for block driver, can be called
> + * with requiring bd_mutex or not.
> + */
> +int __blkdev_reread_part(struct block_device *bdev, bool lock)
>  {
>  	struct gendisk *disk = bdev->bd_disk;
>  	int res;
> @@ -159,12 +163,14 @@ static int blkdev_reread_part(struct block_device *bdev)
>  		return -EINVAL;
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EACCES;
> -	if (!mutex_trylock(&bdev->bd_mutex))
> +	if (lock && !mutex_trylock(&bdev->bd_mutex))
>  		return -EBUSY;

Please don't add funtions that do conditional locking, instead move
all the code into blkdev_reread_part_nolock, and then wrap it:

int blkdev_reread_part(struct block_device *bdev)
{
	if (!mutex_trylock(&bdev->bd_mutex))
		return -EBUSY;
	blkdev_reread_part_nolock(bdev);
	mutex_unlock(&bdev->bd_mutex);
}

Please also add a lockdep_assert_held to blkdev_reread_part_nolock to
ensure callers actually do hold the lock.
