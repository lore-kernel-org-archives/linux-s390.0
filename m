Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfK3WGn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 30 Nov 2019 17:06:43 -0500
Date: Sat, 30 Nov 2019 14:06:41 -0800
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/7] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191130220641.GA669@sol.localdomain>
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-3-hch@lst.de>
 <20191130214942.GA676@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130214942.GA676@sol.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On Sat, Nov 30, 2019 at 01:49:42PM -0800, Eric Biggers wrote:
> Hi Christoph,
> 
> On Thu, Nov 14, 2019 at 03:34:33PM +0100, Christoph Hellwig wrote:
> > A lot of the logic in invalidate_partitions and rescan_partitions is
> > shared.  Merge the two functions to simplify things.  There is a small
> > behavior change in that we now send the kevent change notice also if we
> > were not invalidating but no partitions were found, which seems like
> > the right thing to do.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/ioctl.c             |  2 +-
> >  block/partition-generic.c | 38 ++++++++++++++------------------------
> >  fs/block_dev.c            |  5 +----
> >  include/linux/genhd.h     |  4 ++--
> >  4 files changed, 18 insertions(+), 31 deletions(-)
> > 
> 
> Mainline is broken for me because systemd-udevd spins forever using max CPU
> starting at boot time.  I bisected it to this commit.
> 
> I'm not an expert in this code, but the following patch fixes it:
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 6b9f4f5d993a..b0eebd7580ab 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -599,7 +599,8 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
>  		 * Tell userspace that the media / partition table may have
>  		 * changed.
>  		 */
> -		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
> +		if (invalidate)
> +			kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
>  		return 0;
>  	}
> 
> 
> Do you have any better suggestion, or should I just send this as a formal patch?
> 

Actually this code was moved around more between the bad commit and mainline,
so the fix for mainline would be:

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ee63c2732fa2..69bf2fb6f7cd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1531,7 +1531,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		ret = blk_add_partitions(disk, bdev);
 		if (ret == -EAGAIN)
 			goto rescan;
-	} else {
+	} else if (invalidate) {
 		/*
 		 * Tell userspace that the media / partition table may have
 		 * changed.
