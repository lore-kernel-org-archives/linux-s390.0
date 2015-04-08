Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 0/7] block: reread partitions improvements
Date: Wed,  8 Apr 2015 02:23:39 -0400
Message-Id: <1428474226-27386-1-git-send-email-jarod@redhat.com>
In-Reply-To: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
References: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Jarod Wilson <jarod@redhat.com>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Markus Pargmann <mpa@pengutronix.de>, Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, Ming Lei <ming.lei@canonical.com>, David Herrmann <dh.herrmann@gmail.com>, Mike Galbraith <bitbucket@online.de>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, nbd-general@lists.sourceforge.net, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For loop, the root cause is one ABBA and one AA lock dependency
issue, and the two are fixed by patch 2 and patch 3 each.

Another reason is from the trylock in blkdev_reread_part(), which
may cause partition scanning failure too sometimes when another task
is holding the bd_mutex. In the discussion[1], both Tejun and Christoph
suggests to replace the trylock with mutex_lock in blkdev_reread_part(),
also Christoph suggests to export blkdev_reread_part.

Following the discussion, this patchset exports blkdev_reread_part(), and
introduces lockless __blkdev_reread_part() for fixing loop's AA lock issue.
Then ioctl_by_bdev(BLKRRPART) in loop, nbd and dasd is replaced with
blkdev_reread_part(). In the last patch, trylock in blkdev_reread_part()
is replaced with mutex_lock, and some analysis is provided about the
conversion.

This is a slightly reworked set from what Ming sent a few days ago,
based on Christoph's feedback. I've tested this out quite succesfully
in the scenario that prompted my first patch as well.


[1], https://lkml.org/lkml/2015/1/26/137
[2], https://lkml.org/lkml/2015/3/31/888

Jarod Wilson (3):
  block: export blkdev_reread_part() and __blkdev_reread_part()
  block: loop: fix another reread part failure
  s390/block/dasd: remove obsolete while -EBUSY loop

Ming Lei (4):
  block: loop: don't hold lo_ctl_mutex in lo_open
  block: nbd: convert to blkdev_reread_part()
  block: dasd_genhd: convert to blkdev_reread_part
  block: replace trylock with mutex_lock in blkdev_reread_part()

 block/ioctl.c                   | 34 +++++++++++++++++++----
 drivers/block/loop.c            | 60 ++++++++++++++++++++++++++++++++++-------
 drivers/block/loop.h            |  1 +
 drivers/block/nbd.c             |  2 +-
 drivers/s390/block/dasd_genhd.c | 22 +++++----------
 include/linux/fs.h              |  3 +++
 6 files changed, 90 insertions(+), 32 deletions(-)

CC: Christoph Hellwig <hch@infradead.org>
CC: Jens Axboe <axboe@kernel.dk>
CC: Tejun Heo <tj@kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Markus Pargmann <mpa@pengutronix.de>
CC: Stefan Weinhuber <wein@de.ibm.com>
CC: Stefan Haberland <stefan.haberland@de.ibm.com>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>
CC: Fabian Frederick <fabf@skynet.be>
CC: Ming Lei <ming.lei@canonical.com>
CC: David Herrmann <dh.herrmann@gmail.com>
CC: Mike Galbraith <bitbucket@online.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: nbd-general@lists.sourceforge.net
CC: linux-s390@vger.kernel.org

-- 
1.8.3.1
