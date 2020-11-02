Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgKBLaK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 06:30:10 -0500
MIME-Version: 1.0
References: <20201031085810.450489-1-hch@lst.de> <20201031085810.450489-6-hch@lst.de>
In-Reply-To: <20201031085810.450489-6-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Nov 2020 12:30:05 +0100
Message-ID: <CAOi1vP_-GydZpwuR2DWpNmz2N2Wf7MHDbXudLB=t5xuEEq3Y=w@mail.gmail.com>
Subject: Re: [PATCH 05/11] rbd: implement ->set_read_only to hook into
 BLKROSET processing
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block <linux-block@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On Sat, Oct 31, 2020 at 10:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Implement the ->set_read_only method instead of parsing the actual
> ioctl command.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 41 ++++-------------------------------------
>  1 file changed, 4 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f84128abade319..37f8fc28004acb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -692,12 +692,9 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
>         put_device(&rbd_dev->dev);
>  }
>
> -static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
> +static int rbd_set_read_only(struct block_device *bdev, bool ro)
>  {
> -       int ro;
> -
> -       if (get_user(ro, (int __user *)arg))
> -               return -EFAULT;
> +       struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
>
>         /*
>          * Both images mapped read-only and snapshots can't be marked
> @@ -706,47 +703,17 @@ static int rbd_ioctl_set_ro(struct rbd_device *rbd_dev, unsigned long arg)
>         if (!ro) {
>                 if (rbd_is_ro(rbd_dev))
>                         return -EROFS;
> -
>                 rbd_assert(!rbd_is_snap(rbd_dev));

If you repost, please leave this empty line.

>         }
>
> -       /* Let blkdev_roset() handle it */
> -       return -ENOTTY;
> -}
> -
> -static int rbd_ioctl(struct block_device *bdev, fmode_t mode,
> -                       unsigned int cmd, unsigned long arg)
> -{
> -       struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
> -       int ret;
> -
> -       switch (cmd) {
> -       case BLKROSET:
> -               ret = rbd_ioctl_set_ro(rbd_dev, arg);
> -               break;
> -       default:
> -               ret = -ENOTTY;
> -       }
> -
> -       return ret;
> -}
> -
> -#ifdef CONFIG_COMPAT
> -static int rbd_compat_ioctl(struct block_device *bdev, fmode_t mode,
> -                               unsigned int cmd, unsigned long arg)
> -{
> -       return rbd_ioctl(bdev, mode, cmd, arg);
> +       return 0;
>  }
> -#endif /* CONFIG_COMPAT */
>
>  static const struct block_device_operations rbd_bd_ops = {
>         .owner                  = THIS_MODULE,
>         .open                   = rbd_open,
>         .release                = rbd_release,
> -       .ioctl                  = rbd_ioctl,
> -#ifdef CONFIG_COMPAT
> -       .compat_ioctl           = rbd_compat_ioctl,
> -#endif
> +       .set_read_only          = rbd_set_read_only,
>  };
>
>  /*
> --
> 2.28.0
>

With that nit,

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
