Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150408180056.GM14217@redhat.com>
References: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
	<1428508384-29008-8-git-send-email-ming.lei@canonical.com>
	<alpine.LFD.2.11.1504081924120.1757@denkbrett>
	<20150408180056.GM14217@redhat.com>
Date: Thu, 9 Apr 2015 09:06:16 +0800
Message-ID: <CACVXFVPDjY2VAkRLYrvdfnhh6qiMb8iSNJxu_1RJTX2i=YH0NQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] s390/block/dasd: remove obsolete while -EBUSY loop
From: Ming Lei <ming.lei@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jarod Wilson <jarod@redhat.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org, Stefan Weinhuber <wein@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Apr 9, 2015 at 2:00 AM, Jarod Wilson <jarod@redhat.com> wrote:
> On Wed, Apr 08, 2015 at 07:32:24PM +0200, Sebastian Ott wrote:
>> On Wed, 8 Apr 2015, Ming Lei wrote:
>> > From: Jarod Wilson <jarod@redhat.com>
>> >
>> > With the mutex_trylock bit gone from blkdev_reread_part(), the retry logic
>> > in dasd_scan_partitions() shouldn't be necessary.
>> >
>> > CC: Christoph Hellwig <hch@infradead.org>
>> > CC: Jens Axboe <axboe@kernel.dk>
>> > CC: Tejun Heo <tj@kernel.org>
>> > CC: Alexander Viro <viro@zeniv.linux.org.uk>
>> > CC: Markus Pargmann <mpa@pengutronix.de>
>> > CC: Stefan Weinhuber <wein@de.ibm.com>
>> > CC: Stefan Haberland <stefan.haberland@de.ibm.com>
>> > CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
>> > CC: Fabian Frederick <fabf@skynet.be>
>> > CC: Ming Lei <ming.lei@canonical.com>
>> > CC: David Herrmann <dh.herrmann@gmail.com>
>> > CC: Andrew Morton <akpm@linux-foundation.org>
>> > CC: Peter Zijlstra <peterz@infradead.org>
>> > CC: nbd-general@lists.sourceforge.net
>> > CC: linux-s390@vger.kernel.org
>> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
>> > ---
>> >  drivers/s390/block/dasd_genhd.c |   13 +++----------
>> >  1 file changed, 3 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
>> > index 2af4619..189ea2f 100644
>> > --- a/drivers/s390/block/dasd_genhd.c
>> > +++ b/drivers/s390/block/dasd_genhd.c
>> > @@ -99,9 +99,8 @@ void dasd_gendisk_free(struct dasd_block *block)
>> >  int dasd_scan_partitions(struct dasd_block *block)
>> >  {
>> >     struct block_device *bdev;
>> > -   int retry, rc;
>> > +   int rc;
>> >
>> > -   retry = 5;
>> >     bdev = bdget_disk(block->gdp, 0);
>> >     if (!bdev) {
>> >             DBF_DEV_EVENT(DBF_ERR, block->base, "%s",
>> > @@ -118,14 +117,8 @@ int dasd_scan_partitions(struct dasd_block *block)
>> >     }
>> >
>> >     rc = blkdev_reread_part(bdev);
>> > -   while (rc == -EBUSY && retry > 0) {
>> > -           schedule();
>> > -           rc = blkdev_reread_part(bdev);
>> > -           retry--;
>> > -           DBF_DEV_EVENT(DBF_ERR, block->base,
>> > -                         "scan partitions error, retry %d rc %d",
>> > -                         retry, rc);
>> > -   }
>> > +   DBF_DEV_EVENT(DBF_ERR, block->base,
>> > +                 "scan partitions error, rc %d", rc);
>>
>> Could you please change that to only write the debug message in the error
>> case. Other than that, both dasd patches look good.
>
> D'oh, absolutely. Ming, do you want me to send an updated patch 7 along in
> reply here, or do you want to handle it and/or repost the entire set?

I will handle that, and will add your guys' acked-by and tested-by too,
but need to take a while for looking if there are further comments.

Thanks,
Ming Lei
