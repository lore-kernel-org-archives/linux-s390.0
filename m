Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfK3Vto (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 30 Nov 2019 16:49:44 -0500
Date: Sat, 30 Nov 2019 13:49:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/7] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191130214942.GA676@sol.localdomain>
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114143438.14681-3-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Hi Christoph,

On Thu, Nov 14, 2019 at 03:34:33PM +0100, Christoph Hellwig wrote:
> A lot of the logic in invalidate_partitions and rescan_partitions is
> shared.  Merge the two functions to simplify things.  There is a small
> behavior change in that we now send the kevent change notice also if we
> were not invalidating but no partitions were found, which seems like
> the right thing to do.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioctl.c             |  2 +-
>  block/partition-generic.c | 38 ++++++++++++++------------------------
>  fs/block_dev.c            |  5 +----
>  include/linux/genhd.h     |  4 ++--
>  4 files changed, 18 insertions(+), 31 deletions(-)
> 

Mainline is broken for me because systemd-udevd spins forever using max CPU
starting at boot time.  I bisected it to this commit.

I'm not an expert in this code, but the following patch fixes it:

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 6b9f4f5d993a..b0eebd7580ab 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -599,7 +599,8 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
 		 * Tell userspace that the media / partition table may have
 		 * changed.
 		 */
-		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
+		if (invalidate)
+			kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 		return 0;
 	}


Do you have any better suggestion, or should I just send this as a formal patch?

- Eric
