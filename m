Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 8 Apr 2015 12:52:31 -0400
From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH v1 0/7] block: reread partitions changes and fix for loop
Message-ID: <20150408165230.GL14217@redhat.com>
References: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428508384-29008-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 08, 2015 at 11:52:57PM +0800, Ming Lei wrote:
> Hi Guys,
> 
> Recently there are several reports about loop partition scanning
> failure[1][2].
> 
> For loop, the root cause is one ABBA and one AA lock dependency
> issue, and the two are fixed by patch 2 and patch 3 each.
> 
> Another reason is from the trylock in blkdev_reread_part(), which
> may cause partition scanning failure too sometimes when another task
> is holding the bd_mutex. In the discussion[1], both Tejun and Christoph
> suggests to replace the trylock with mutex_lock in blkdev_reread_part(),
> also Christoph suggests to export blkdev_reread_part.
> 
> Following the discussion, this patchset exports blkdev_reread_part(), and
> introduces __blkdev_reread_part() for fixing loop's AA lock issue.
> Then ioctl_by_bdev(BLKRRPART) in loop, nbd and dasd is replaced with
> blkdev_reread_part(). In the last patch, trylock in blkdev_reread_part()
> is replaced with mutex_lock, and some analysis is provided about the conversion.
> 
> V1:
> 	- introduce __blkdev_reread_part(), and use lockdep_assert_held()(1/7)
> 	- replace lo_open_mutex with atomic reference count, plus freezing queue(2/7)
> 	- add comment about detecting release path(3/7)
> 	- remove dead code in dasd(7/7)

I tinkered with the atomic replacement and added the lockdep assert on my
end as well, and have been testing. My end results were nearly identical
to this, and testing for my particular use case still looks good.

For the set:

Tested-by: Jarod Wilson <jarod@redhat.com>
Acked-by: Jarod Wilson <jarod@redhat.com>

Thanks much!

-- 
Jarod Wilson
jarod@redhat.com
