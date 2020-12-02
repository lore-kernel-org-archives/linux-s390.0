Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387806AbgLBWza (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 17:55:30 -0500
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 2 Dec 2020 17:54:45 -0500
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/9] block: store a block_device pointer in struct bio
Message-ID: <X8gbNeczmbhF8ZEW@mtj.duckdns.org>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201165424.2030647-4-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 05:54:18PM +0100, Christoph Hellwig wrote:
> Replace the gendisk pointer in struct bio with a pointer to the newly
> improved struct block device.  From that the gendisk can be trivially
> accessed with an extra indirection, but it also allows to directly
> look up all information related to partition remapping.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
