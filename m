Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Apr 2015 07:50:48 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/6] block: export blkdev_reread_part()
Message-ID: <20150406145048.GC2703@infradead.org>
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
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 06, 2015 at 12:40:12AM +0800, Ming Lei wrote:
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

It's just a few fairly trivial checks, so 'm not really worried about
it, especially given that blkdev_reread_part isn't called from a fast
path.
