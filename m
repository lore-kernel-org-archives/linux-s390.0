Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgK3SBt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Nov 2020 13:01:49 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: block tracepoint cleanups
Date: Mon, 30 Nov 2020 18:58:49 +0100
Message-Id: <20201130175854.982460-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org

Hi Jens,

this series cleans up the block layer tracepoints by removing unused
tracepoints or tracepoint arguments and consolidating the implementation
of various bio based tracepoints.

Diffstat:
 block/blk-core.c              |    4 
 block/blk-merge.c             |    8 -
 block/blk-mq-sched.c          |    2 
 block/blk-mq.c                |   10 -
 block/bounce.c                |    2 
 drivers/md/dm-rq.c            |    2 
 drivers/md/dm.c               |    5 
 drivers/md/md-linear.c        |    3 
 drivers/md/md.c               |    5 
 drivers/md/raid0.c            |    4 
 drivers/md/raid1.c            |    7 -
 drivers/md/raid10.c           |    6 -
 drivers/md/raid5.c            |   15 +-
 drivers/nvme/host/multipath.c |    3 
 drivers/s390/scsi/zfcp_fsf.c  |    3 
 include/linux/blktrace_api.h  |    5 
 include/trace/events/block.h  |  228 +++++++++---------------------------------
 kernel/trace/blktrace.c       |  126 ++++++-----------------
 18 files changed, 125 insertions(+), 313 deletions(-)
