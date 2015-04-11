Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v2 0/7] block: reread partitions changes and fix for loop
Date: Sat, 11 Apr 2015 19:30:06 +0800
Message-Id: <1428751813-25199-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Guys,

Recently there are several reports about loop partition scanning
failure[1][2].

For loop, the root cause is one ABBA and one AA lock dependency
issue, and the two are fixed by patch 2 and patch 3 each.

Another reason is from the trylock in blkdev_reread_part(), which
may cause partition scanning failure too sometimes when another task
is holding the bd_mutex. In the discussion[1], both Tejun and Christoph
suggests to replace the trylock with mutex_lock in blkdev_reread_part(),
also Christoph suggests to export blkdev_reread_part.

Following the discussion, this patchset exports blkdev_reread_part(), and
introduces __blkdev_reread_part() for fixing loop's AA lock issue.
Then ioctl_by_bdev(BLKRRPART) in loop, nbd and dasd is replaced with
blkdev_reread_part(). In the last patch, trylock in blkdev_reread_part()
is replaced with mutex_lock, and some analysis is provided about the conversion.

V2:
	- only print debug message in case of error (7/7)
	- add tested-by, acked-by

V1:
	- introduce __blkdev_reread_part(), and use lockdep_assert_held()(1/7)
	- replace lo_open_mutex with atomic reference count, plus freezing queue(2/7)
	- add comment about detecting release path(3/7)
	- remove dead code in dasd(7/7)

 block/ioctl.c                   |   37 +++++++++++++++++++++++++----
 drivers/block/loop.c            |   49 +++++++++++++++++++++++++++++----------
 drivers/block/loop.h            |    2 +-
 drivers/block/nbd.c             |    2 +-
 drivers/s390/block/dasd_genhd.c |   19 ++++-----------
 include/linux/fs.h              |    3 +++
 6 files changed, 79 insertions(+), 33 deletions(-)


[1], https://lkml.org/lkml/2015/1/26/137
[2], https://lkml.org/lkml/2015/3/31/888

Thanks,
Ming Lei
