Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Apr 2015 11:27:48 -0400
From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 1/7] block: export blkdev_reread_part() and
 __blkdev_reread_part()
Message-ID: <20150408152748.GJ14217@redhat.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
 <1428474226-27386-1-git-send-email-jarod@redhat.com>
 <1428474226-27386-2-git-send-email-jarod@redhat.com>
 <CACVXFVOQH_tNdBtgNH8UhLan304cSacRTzqvvRhndLauexTvaw@mail.gmail.com>
 <20150408150325.GJ5029@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150408150325.GJ5029@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ming Lei <ming.lei@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 08, 2015 at 05:03:25PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 08, 2015 at 10:50:56PM +0800, Ming Lei wrote:
> > > +/*
> > > + * This is an exported API for the block driver, and will not
> > > + * acquire bd_mutex, leaving it up to the caller to handle
> > > + * any necessary locking.
> > 
> > Actually, the function is introduced and should be used in case
> > that bd_mutex has been held already, such as clearing fd in
> > loop release().
> > 
> > > + */
> > > +int __blkdev_reread_part(struct block_device *bdev)
> > >  {
> > >         struct gendisk *disk = bdev->bd_disk;
> > >
> 
> 	lockdep_assert_held(&bdev->bd_mutex);
> 
> is an excellent means of avoiding that comment and verifying its
> actually true :-)

Ah, yes, that was actually suggested by Christoph as well, I was too hasty
shoving something back out the door on multiple counts.

> > > + */
> > > +int blkdev_reread_part(struct block_device *bdev)
> > > +{
> > > +       int res;
> > > +
> > >         if (!mutex_trylock(&bdev->bd_mutex))
> > >                 return -EBUSY;
> 
> Is that really needed? It seems rather poor form.

It goes away later in the series and gets converted to a straight
mutex_lock().

-- 
Jarod Wilson
jarod@redhat.com
