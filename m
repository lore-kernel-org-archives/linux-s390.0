Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1428474226-27386-2-git-send-email-jarod@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
	<1428474226-27386-1-git-send-email-jarod@redhat.com>
	<1428474226-27386-2-git-send-email-jarod@redhat.com>
Date: Wed, 8 Apr 2015 22:50:56 +0800
Message-ID: <CACVXFVOQH_tNdBtgNH8UhLan304cSacRTzqvvRhndLauexTvaw@mail.gmail.com>
Subject: Re: [PATCH 1/7] block: export blkdev_reread_part() and __blkdev_reread_part()
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jarod Wilson <jarod@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 8, 2015 at 2:23 PM, Jarod Wilson <jarod@redhat.com> wrote:
> This patch exports blkdev_reread_part() for block drivers, also
> introduce __blkdev_reread_part(), a lockless version.

Generally the term of lockless is used when lock is avoided,
and that isn't the case of __blkdev_reread_part(), because
bd_mutex is definitely required here.

>
> For some drivers, such as loop, a reread of partitions can be run
> from the release path, and bd_mutex may already be held prior to
> calling ioctl_by_bdev(bdev, BLKRRPART, 0), so introduce a lockless
> path for use in such cases.
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
> CC: Mike Galbraith <bitbucket@online.de>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: nbd-general@lists.sourceforge.net
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  block/ioctl.c      | 26 +++++++++++++++++++++++---
>  include/linux/fs.h |  3 +++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 7d8befd..64a4fcb 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -150,21 +150,41 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
>         }
>  }
>
> -static int blkdev_reread_part(struct block_device *bdev)
> +/*
> + * This is an exported API for the block driver, and will not
> + * acquire bd_mutex, leaving it up to the caller to handle
> + * any necessary locking.

Actually, the function is introduced and should be used in case
that bd_mutex has been held already, such as clearing fd in
loop release().

> + */
> +int __blkdev_reread_part(struct block_device *bdev)
>  {
>         struct gendisk *disk = bdev->bd_disk;
> -       int res;
>
>         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
>                 return -EINVAL;
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EACCES;
> +
> +       return rescan_partitions(disk, bdev);
> +}
> +EXPORT_SYMBOL(__blkdev_reread_part);
> +
> +/*
> + * This is an exported API for the block driver, and will
> + * acquire bd_mutex. Make sure you aren't calling it with
> + * bd_mutex already held, or we'll return -EBUSY.

Strictly speaking, it should be "Make sure you aren't calling it
with bd_mutex already held in current context".

> + */
> +int blkdev_reread_part(struct block_device *bdev)
> +{
> +       int res;
> +
>         if (!mutex_trylock(&bdev->bd_mutex))
>                 return -EBUSY;
> -       res = rescan_partitions(disk, bdev);
> +       res = __blkdev_reread_part(bdev);
>         mutex_unlock(&bdev->bd_mutex);
> +
>         return res;
>  }
> +EXPORT_SYMBOL(blkdev_reread_part);
>
>  static int blk_ioctl_discard(struct block_device *bdev, uint64_t start,
>                              uint64_t len, int secure)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f4131e8..11398e3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2245,6 +2245,9 @@ extern struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
>  extern struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode,
>                                               void *holder);
>  extern void blkdev_put(struct block_device *bdev, fmode_t mode);
> +extern int __blkdev_reread_part(struct block_device *bdev);
> +extern int blkdev_reread_part(struct block_device *bdev);
> +
>  #ifdef CONFIG_SYSFS
>  extern int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
>  extern void bd_unlink_disk_holder(struct block_device *bdev,
> --
> 1.8.3.1
>
