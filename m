Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Apr 2015 09:42:27 -0400
From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 1/6] block: export blkdev_reread_part()
Message-ID: <20150406134227.GC14217@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428218688-4092-2-git-send-email-ming.lei@canonical.com>
 <20150405161241.GB16886@infradead.org>
 <CACVXFVP-rokGRrMus_QXju+MVzFPTaFC45oZBe2PEBfbid8nmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVP-rokGRrMus_QXju+MVzFPTaFC45oZBe2PEBfbid8nmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 06, 2015 at 12:40:12AM +0800, Ming Lei wrote:
> On Mon, Apr 6, 2015 at 12:12 AM, Christoph Hellwig <hch@infradead.org> wrote:
> >> +/*
> >> + * This is exported as API for block driver, can be called
> >> + * with requiring bd_mutex or not.
> >> + */
> >> +int __blkdev_reread_part(struct block_device *bdev, bool lock)
> >>  {
> >>       struct gendisk *disk = bdev->bd_disk;
> >>       int res;
> >> @@ -159,12 +163,14 @@ static int blkdev_reread_part(struct block_device *bdev)
> >>               return -EINVAL;
> >>       if (!capable(CAP_SYS_ADMIN))
> >>               return -EACCES;
> >> -     if (!mutex_trylock(&bdev->bd_mutex))
> >> +     if (lock && !mutex_trylock(&bdev->bd_mutex))
> >>               return -EBUSY;
> >
> > Please don't add funtions that do conditional locking, instead move
> > all the code into blkdev_reread_part_nolock, and then wrap it:
> >
> > int blkdev_reread_part(struct block_device *bdev)
> > {
> >         if (!mutex_trylock(&bdev->bd_mutex))
> >                 return -EBUSY;
> >         blkdev_reread_part_nolock(bdev);
> >         mutex_unlock(&bdev->bd_mutex);
> > }
> 
> Yes, it is more clean, but with extra acquiring lock cost for the
> failure cases, especially when we replace trylock with mutex_lock().

I was working on a version of this myself over the past few days, I
actually removed blkdev_reread_part() entirely, renamed
fs/partition-generic.c::reread_partitions() to __reread_partitions(), then
moved the locking from blkdev_reread_part() into a new reread_partitions()
that wrapped around __reread_partitions(). Same difference, I guess.

> > Please also add a lockdep_assert_held to blkdev_reread_part_nolock to
> > ensure callers actually do hold the lock.
> 
> Good point!

Looks like fs/block_dev.c::__blkdev_get() is the only thing that would be
calling the _nolock variant of whichever route, as it handles bd_mutex
acquisition within __blkdev_get().

As an aside, there's a piece of that function that could be worth
duplicating over into loop.c as well:

        if (bdev->bd_invalidated) {
                if (!ret)
                        rescan_partitions(bdev);
                else if (ret == -ENOMEDIUM)
                        invalidate_partitions(disk, bdev);

Might this possibly be put to use to help with the problem commit
8761a3dc1f07b163414e2215a2cadbb4cfe2a107 was trying to solve?

-- 
Jarod Wilson
jarod@redhat.com
