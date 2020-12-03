Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729814AbgLCHMj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 02:12:39 -0500
Date: Thu, 3 Dec 2020 15:10:55 +0800
From: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/9] block: store a block_device pointer in struct bio
Message-ID: <20201203071055.GA633702@T590>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-4-hch@lst.de>
 <20201203063941.GA629758@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203063941.GA629758@T590>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Thu, Dec 03, 2020 at 02:40:04PM +0800, Ming Lei wrote:
> On Tue, Dec 01, 2020 at 05:54:18PM +0100, Christoph Hellwig wrote:
> > Replace the gendisk pointer in struct bio with a pointer to the newly
> > improved struct block device.  From that the gendisk can be trivially
> > accessed with an extra indirection, but it also allows to directly
> > look up all information related to partition remapping.
> 
> The extra indirection is often done in fast path, so just wondering why
> you don't consider to embed gendisk into block_device? Then the extra
> indirection can be avoided.

oops, that is only possible for disk, and indirection is still needed
for partitions.


Thanks,
Ming
