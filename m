Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHXHgk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Aug 2020 03:36:40 -0400
Subject: Re: [PATCH 2/3] block: fix locking for struct block_device size
 updates
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <73653f9e-2d39-48fb-9842-3a1851fb5bed@suse.de>
Date: Mon, 24 Aug 2020 09:36:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Justin Sanders <justin@coraid.com>, Josef Bacik <josef@toxicpanda.com>, Xianting Tian <xianting_tian@126.com>, linux-block@vger.kernel.org, dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org

On 8/23/20 11:10 AM, Christoph Hellwig wrote:
> Two different callers use two different mutexes for updating the
> block device size, which obviously doesn't help to actually protect
> against concurrent updates from the different callers.  In addition
> one of the locks, bd_mutex is rather prone to deadlocks with other
> parts of the block stack that use it for high level synchronization.
> 
> Switch to using a new spinlock protecting just the size updates, as
> that is all we need, and make sure everyone does the update through
> the proper helper.
> 
> This fixes a bug reported with the nvme revalidating disks during a
> hot removal operation, which can currently deadlock on bd_mutex.
> 
> Reported-by: Xianting Tian <xianting_tian@126.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/core.c         |  4 ++--
>  drivers/block/aoe/aoecmd.c      |  4 +---
>  drivers/md/dm.c                 | 15 ++-------------
>  drivers/s390/block/dasd_ioctl.c |  9 ++-------
>  fs/block_dev.c                  | 25 ++++++++++++++-----------
>  include/linux/blk_types.h       |  1 +
>  6 files changed, 22 insertions(+), 36 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
