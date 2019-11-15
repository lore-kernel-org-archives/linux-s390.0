Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727036AbfKOKHw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:07:52 -0500
Subject: Re: [PATCH 4/7] block: fix bdev_disk_changed for non-partitioned
 devices
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <74109dd8-3fa8-73d9-d663-32fce14c409d@suse.de>
Date: Fri, 15 Nov 2019 11:07:49 +0100
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-5-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/14/19 3:34 PM, Christoph Hellwig wrote:
> We still have to set the capacity to 0 if invalidating or call
> revalidate_disk if not even if the disk has no partitions.  Fix
> that by merging rescan_partitions into bdev_disk_changed and just
> stubbing out blk_add_partitions and blk_drop_partitions for
> non-partitioned devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioctl.c             |  6 ++----
>  block/partition-generic.c |  5 +++++
>  fs/block_dev.c            | 27 ++++++++-------------------
>  include/linux/genhd.h     |  1 +
>  4 files changed, 16 insertions(+), 23 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
