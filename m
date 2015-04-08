Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150408150325.GJ5029@twins.programming.kicks-ass.net>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
	<1428474226-27386-1-git-send-email-jarod@redhat.com>
	<1428474226-27386-2-git-send-email-jarod@redhat.com>
	<CACVXFVOQH_tNdBtgNH8UhLan304cSacRTzqvvRhndLauexTvaw@mail.gmail.com>
	<20150408150325.GJ5029@twins.programming.kicks-ass.net>
Date: Wed, 8 Apr 2015 23:28:25 +0800
Message-ID: <CACVXFVN9Zdv77wVsTa5OxKz43u5z8L8vMMVTXhjtap2fTYsBwg@mail.gmail.com>
Subject: Re: [PATCH 1/7] block: export blkdev_reread_part() and __blkdev_reread_part()
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jarod Wilson <jarod@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 8, 2015 at 11:03 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 08, 2015 at 10:50:56PM +0800, Ming Lei wrote:
>> > +/*
>> > + * This is an exported API for the block driver, and will not
>> > + * acquire bd_mutex, leaving it up to the caller to handle
>> > + * any necessary locking.
>>
>> Actually, the function is introduced and should be used in case
>> that bd_mutex has been held already, such as clearing fd in
>> loop release().
>>
>> > + */
>> > +int __blkdev_reread_part(struct block_device *bdev)
>> >  {
>> >         struct gendisk *disk = bdev->bd_disk;
>> >
>
>         lockdep_assert_held(&bdev->bd_mutex);
>
> is an excellent means of avoiding that comment and verifying its
> actually true :-)

Exactly, and it has been added in my local tree, :-)

>
>> >         if (!disk_part_scan_enabled(disk) || bdev != bdev->bd_contains)
>> >                 return -EINVAL;
>> >         if (!capable(CAP_SYS_ADMIN))
>> >                 return -EACCES;
>> > +
>> > +       return rescan_partitions(disk, bdev);
>> > +}
>> > +EXPORT_SYMBOL(__blkdev_reread_part);
>> > +
>> > +/*
>> > + * This is an exported API for the block driver, and will
>> > + * acquire bd_mutex. Make sure you aren't calling it with
>> > + * bd_mutex already held, or we'll return -EBUSY.
>>
>> Strictly speaking, it should be "Make sure you aren't calling it
>> with bd_mutex already held in current context".
>>
>> > + */
>> > +int blkdev_reread_part(struct block_device *bdev)
>> > +{
>> > +       int res;
>> > +
>> >         if (!mutex_trylock(&bdev->bd_mutex))
>> >                 return -EBUSY;
>
> Is that really needed? It seems rather poor form.

The trylock will be replaced with mutex_lock in patch 6.

>
>> > -       res = rescan_partitions(disk, bdev);
>> > +       res = __blkdev_reread_part(bdev);
>> >         mutex_unlock(&bdev->bd_mutex);
>> > +
>> >         return res;
>> >  }
>> > +EXPORT_SYMBOL(blkdev_reread_part);
