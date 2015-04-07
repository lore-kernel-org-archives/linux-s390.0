Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150406134227.GC14217@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
	<1428218688-4092-2-git-send-email-ming.lei@canonical.com>
	<20150405161241.GB16886@infradead.org>
	<CACVXFVP-rokGRrMus_QXju+MVzFPTaFC45oZBe2PEBfbid8nmQ@mail.gmail.com>
	<20150406134227.GC14217@redhat.com>
Date: Tue, 7 Apr 2015 10:43:53 +0800
Message-ID: <CACVXFVMzmFO8SfmNX2C6sSieF877w3LPs=tOOQ7xa3byOZUadQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: export blkdev_reread_part()
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jarod Wilson <jarod@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 6, 2015 at 9:42 PM, Jarod Wilson <jarod@redhat.com> wrote:
> On Mon, Apr 06, 2015 at 12:40:12AM +0800, Ming Lei wrote:
>> On Mon, Apr 6, 2015 at 12:12 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> >> +/*
>> >> + * This is exported as API for block driver, can be called
>> >> + * with requiring bd_mutex or not.
>> >> + */
>> >> +int __blkdev_reread_part(struct block_device *bdev, bool lock)
>> >>  {
>> >>       struct gendisk *disk = bdev->bd_disk;
>> >>       int res;
>> >> @@ -159,12 +163,14 @@ static int blkdev_reread_part(struct block_device *bdev)
>> >>               return -EINVAL;
>> >>       if (!capable(CAP_SYS_ADMIN))
>> >>               return -EACCES;
>> >> -     if (!mutex_trylock(&bdev->bd_mutex))
>> >> +     if (lock && !mutex_trylock(&bdev->bd_mutex))
>> >>               return -EBUSY;
>> >
>> > Please don't add funtions that do conditional locking, instead move
>> > all the code into blkdev_reread_part_nolock, and then wrap it:
>> >
>> > int blkdev_reread_part(struct block_device *bdev)
>> > {
>> >         if (!mutex_trylock(&bdev->bd_mutex))
>> >                 return -EBUSY;
>> >         blkdev_reread_part_nolock(bdev);
>> >         mutex_unlock(&bdev->bd_mutex);
>> > }
>>
>> Yes, it is more clean, but with extra acquiring lock cost for the
>> failure cases, especially when we replace trylock with mutex_lock().
>
> I was working on a version of this myself over the past few days, I
> actually removed blkdev_reread_part() entirely, renamed
> fs/partition-generic.c::reread_partitions() to __reread_partitions(), then
> moved the locking from blkdev_reread_part() into a new reread_partitions()
> that wrapped around __reread_partitions(). Same difference, I guess.
>
>> > Please also add a lockdep_assert_held to blkdev_reread_part_nolock to
>> > ensure callers actually do hold the lock.
>>
>> Good point!
>
> Looks like fs/block_dev.c::__blkdev_get() is the only thing that would be
> calling the _nolock variant of whichever route, as it handles bd_mutex
> acquisition within __blkdev_get().

I guess you forget __blkdev_put(), :-)

>
> As an aside, there's a piece of that function that could be worth
> duplicating over into loop.c as well:
>
>         if (bdev->bd_invalidated) {
>                 if (!ret)
>                         rescan_partitions(bdev);
>                 else if (ret == -ENOMEDIUM)
>                         invalidate_partitions(disk, bdev);
>
> Might this possibly be put to use to help with the problem commit
> 8761a3dc1f07b163414e2215a2cadbb4cfe2a107 was trying to solve?

I am wondering if the problem claimed in this commit exists in reality,
at least fdisk need to run reread partition first before adding partition.

- LO_FLAGS_PARTSCAN is set for both 'losetup -P' and max_parts
- if max_parts isn't set, GENHD_FL_NO_PART_SCAN is set, so user
can't reread partition successfully because of disk_part_scan_enabled().

If there is really the problem, it can be fixed by exporting
rescan_partitions or the approach in commit 8761a3dc
with not acquiring bd_mutex in release().

Thanks,
Ming Lei

>
> --
> Jarod Wilson
> jarod@redhat.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
