Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbgLCJdy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 04:33:54 -0500
Date: Thu, 3 Dec 2020 17:32:01 +0800
From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/9] block: store a block_device pointer in struct bio
Message-ID: <20201203093201.GC633702@T590>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-4-hch@lst.de>
 <20201203063941.GA629758@T590>
 <20201203071055.GA633702@T590>
 <20201203082951.GA15581@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203082951.GA15581@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Thu, Dec 03, 2020 at 09:29:51AM +0100, Christoph Hellwig wrote:
> On Thu, Dec 03, 2020 at 03:10:55PM +0800, Ming Lei wrote:
> > On Thu, Dec 03, 2020 at 02:40:04PM +0800, Ming Lei wrote:
> > > On Tue, Dec 01, 2020 at 05:54:18PM +0100, Christoph Hellwig wrote:
> > > > Replace the gendisk pointer in struct bio with a pointer to the newly
> > > > improved struct block device.  From that the gendisk can be trivially
> > > > accessed with an extra indirection, but it also allows to directly
> > > > look up all information related to partition remapping.
> > > 
> > > The extra indirection is often done in fast path, so just wondering why
> > > you don't consider to embed gendisk into block_device? Then the extra
> > > indirection can be avoided.
> > 
> > oops, that is only possible for disk, and indirection is still needed
> > for partitions.
> 
> I looked into that, but given that the block device is allocated as part
> of the inode we'd need to tell ->alloc_inode if we want to allocate the
> small inode without the gendisk, or the large one with it which doesn't
> work with the current interface.

I guess it could be done without fs code change, because now block device is
always allocated by bdev_alloc() since 22ae8ce8b892("block: simplify bdev/disk
lookup in blkdev_get"). And one manual inode allocation with a bit duplication
from new_inode_pseudo() should be fine:

	allocate big inode for disk, and small for partition
	inode_init_always(sb, inode);
    if (inode) {
            spin_lock(&inode->i_lock);
            inode->i_state = 0;
            spin_unlock(&inode->i_lock);
            INIT_LIST_HEAD(&inode->i_sb_list);
			inode_sb_list_add(inode);
    }

> Beause the hd_struct is gone we're
> still not using more structures in the I/O path than we did before.

Indeed, and block_device instance is often cached in IO path.


thanks,
Ming
