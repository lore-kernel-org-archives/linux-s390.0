Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@canonical.com>
Subject: [PATCH 0/6] block: reread partitions changes and fix for loop
Date: Sun,  5 Apr 2015 15:24:42 +0800
Message-Id: <1428218688-4092-1-git-send-email-ming.lei@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jarod Wilson <jarod@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, nbd-general@lists.sourceforge.net, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Fabian Frederick <fabf@skynet.be>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

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
introduces blkdev_reread_part_nolock() for fixing loop's AA lock issue.
Then ioctl_by_bdev(BLKRRPART) in loop, nbd and dasd is replaced with
blkdev_reread_part(). In the last patch, trylock in __blkdev_reread_part()
is replaced with mutex_lock, and some analysis is provided about the conversion.


[1], https://lkml.org/lkml/2015/1/26/137
[2], https://lkml.org/lkml/2015/3/31/888

Thanks,
Ming Lei
