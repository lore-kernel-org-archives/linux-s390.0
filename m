Return-Path: <linux-block-owner@vger.kernel.org>
Date: Thu, 4 Jan 2018 04:38:03 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: loop: remove & invalidate partitions when
 detaching
Message-ID: <20180104123803.GA8437@infradead.org>
References: <20180104103924.8814-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180104103924.8814-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org, reddot.rocks@gmail.com, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 04, 2018 at 06:39:24PM +0800, Ming Lei wrote:
> When detaching loop disk, neither we remove loop partitions, nor
> invalidate them. This way may cause data loss, and often confuse
> people.
> 
> This patch fixes the above issue by removing & invalidating loop
> partitions in loop_clr_fd(),

Please add a comment explaining the call (e.g. the weird loop
case of keeping unbound devices around).

Also dasd seems to implement this functionality by iterating over
all partitions and then calling ioctl_by_bdev(bdev, BLKPG, ..) on
it.  Please switch it to you new helper assuming there is a good
reason to even do this to start with.  CCing the maintainers to
confirm that.

And while you'e at it split the block and loop bits into separate
patches.

> +void del_gendisk_partitions(struct gendisk *disk)

Add a comment explanining the function, please.

>  	struct disk_part_iter piter;
>  	struct hd_struct *part;
>  
> -	blk_integrity_del(disk);
> -	disk_del_events(disk);
> -
>  	/* invalidate stuff */
>  	disk_part_iter_init(&piter, disk,
>  			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
> @@ -714,7 +711,17 @@ void del_gendisk(struct gendisk *disk)
>  	disk_part_iter_exit(&piter);
>  
>  	invalidate_partition(disk, 0);
> +}
> +EXPORT_SYMBOL(del_gendisk_partitions);

EXPORT_SYMBOL_GPL, please.
