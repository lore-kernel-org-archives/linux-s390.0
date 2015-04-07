Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150406145048.GC2703@infradead.org>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
	<1428218688-4092-2-git-send-email-ming.lei@canonical.com>
	<20150405161241.GB16886@infradead.org>
	<CACVXFVP-rokGRrMus_QXju+MVzFPTaFC45oZBe2PEBfbid8nmQ@mail.gmail.com>
	<20150406145048.GC2703@infradead.org>
Date: Tue, 7 Apr 2015 10:11:53 +0800
Message-ID: <CACVXFVNHpUyM3QYUKCxvhx9N2ec0=pcLY2snCt-BOX_dqZtTHw@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: export blkdev_reread_part()
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 6, 2015 at 10:50 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Apr 06, 2015 at 12:40:12AM +0800, Ming Lei wrote:
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
> It's just a few fairly trivial checks, so 'm not really worried about
> it, especially given that blkdev_reread_part isn't called from a fast
> path.

OK, considered that common users don't have any privilege
on block devices at default in most distributions, so they can't
do DoS by running ioctl(RRPART) with this change.

I will change to this style in v1.

Thanks,
Ming Lei
