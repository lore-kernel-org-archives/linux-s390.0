Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgLAQzM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 11:55:12 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: store a pointer to the block_device in struct bio (again)
Date: Tue,  1 Dec 2020 17:54:15 +0100
Message-Id: <20201201165424.2030647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

Hi Jens,

this series switches back from storing the gendisk + partno to storing
a block_device pointer in struct bio.  The reason is two fold:  for one
the new struct block_device actually is always available, removing the
need to avoid originally.  Second the merge struct block_device is much
more useful than the old one, as storing it avoids the need for looking
up what used to be hd_struct during partition remapping and I/O
accounting.

Note that this series depends on the posted but not merged
"block tracepoint cleanups" series.

A git tree is also available:

    git://git.infradead.org/users/hch/block.git bi_bdev

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/bi_bdev

Diffstat:
 arch/m68k/emu/nfblock.c             |    2 
 arch/xtensa/platforms/iss/simdisk.c |    2 
 block/bio-integrity.c               |   18 +-
 block/bio.c                         |   31 +---
 block/blk-cgroup.c                  |    7 
 block/blk-core.c                    |   99 ++++++-------
 block/blk-crypto-fallback.c         |    2 
 block/blk-crypto.c                  |    2 
 block/blk-merge.c                   |   17 +-
 block/blk-mq.c                      |    2 
 block/blk-settings.c                |    2 
 block/blk-throttle.c                |    2 
 block/blk.h                         |    9 -
 block/bounce.c                      |    2 
 block/genhd.c                       |  261 +++---------------------------------
 block/partitions/core.c             |   31 ----
 drivers/block/brd.c                 |    8 -
 drivers/block/drbd/drbd_int.h       |    4 
 drivers/block/drbd/drbd_req.c       |    2 
 drivers/block/null_blk_main.c       |    2 
 drivers/block/pktcdvd.c             |    4 
 drivers/block/ps3vram.c             |    2 
 drivers/block/rsxx/dev.c            |    2 
 drivers/block/umem.c                |    2 
 drivers/block/zram/zram_drv.c       |    2 
 drivers/lightnvm/pblk-init.c        |    2 
 drivers/md/bcache/debug.c           |    2 
 drivers/md/bcache/request.c         |   39 +++--
 drivers/md/dm-bio-record.h          |    9 -
 drivers/md/dm-raid1.c               |   10 -
 drivers/md/dm.c                     |   14 -
 drivers/md/md-linear.c              |    2 
 drivers/md/md.c                     |   10 -
 drivers/md/md.h                     |    6 
 drivers/md/raid1.c                  |    6 
 drivers/md/raid10.c                 |   12 -
 drivers/md/raid5.c                  |    2 
 drivers/nvdimm/blk.c                |    4 
 drivers/nvdimm/btt.c                |    4 
 drivers/nvdimm/pmem.c               |    4 
 drivers/nvme/host/core.c            |    6 
 drivers/nvme/host/lightnvm.c        |    3 
 drivers/nvme/host/multipath.c       |    6 
 drivers/nvme/host/rdma.c            |    2 
 drivers/s390/block/dasd.c           |   26 ---
 drivers/s390/block/dcssblk.c        |    6 
 drivers/s390/block/xpram.c          |    2 
 fs/btrfs/check-integrity.c          |   10 -
 fs/btrfs/raid56.c                   |    7 
 fs/btrfs/scrub.c                    |    2 
 fs/direct-io.c                      |    2 
 fs/f2fs/data.c                      |   12 -
 include/linux/bio.h                 |   18 +-
 include/linux/blk_types.h           |    3 
 include/linux/blkdev.h              |   20 --
 include/linux/genhd.h               |   21 --
 kernel/trace/blktrace.c             |   16 +-
 mm/page_io.c                        |    2 
 58 files changed, 251 insertions(+), 556 deletions(-)
