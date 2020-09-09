Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIA4B (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 8 Sep 2020 20:56:01 -0400
MIME-Version: 1.0
References: <20200903054104.228829-1-hch@lst.de> <20200903054104.228829-5-hch@lst.de>
In-Reply-To: <20200903054104.228829-5-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 8 Sep 2020 17:55:48 -0700
Message-ID: <CAPhsuW62Cd329s-LUR9uQVcFvn4pbOj7H0434P7zwRhbNVScgA@mail.gmail.com>
Subject: Re: [PATCH 4/9] md: don't detour through bd_contains for the gendisk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, Linux Doc Mailing List <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org, drbd-dev@lists.linbit.com, linux-ide@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

On Wed, Sep 2, 2020 at 10:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> bd_disk is set on all block devices, including those for partitions.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c | 2 +-
>  drivers/md/md.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 3f33562d10d6f5..5a0fd93769a70e 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8444,7 +8444,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>         idle = 1;
>         rcu_read_lock();
>         rdev_for_each_rcu(rdev, mddev) {
> -               struct gendisk *disk = rdev->bdev->bd_contains->bd_disk;
> +               struct gendisk *disk = rdev->bdev->bd_disk;
>                 curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
>                               atomic_read(&disk->sync_io);
>                 /* sync IO will cause sync_io to increase before the disk_stats
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index f9e2ccdd22c478..2175a5ac4f7c68 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -551,7 +551,7 @@ extern void mddev_unlock(struct mddev *mddev);
>
>  static inline void md_sync_acct(struct block_device *bdev, unsigned long nr_sectors)
>  {
> -       atomic_add(nr_sectors, &bdev->bd_contains->bd_disk->sync_io);
> +       atomic_add(nr_sectors, &bdev->bd_disk->sync_io);
>  }
>
>  static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
> --
> 2.28.0
>
