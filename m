Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgLBXRH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 18:17:07 -0500
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 2 Dec 2020 18:15:57 -0500
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 8/9] block: remove DISK_PITER_REVERSE
Message-ID: <X8ggLXsNOCh6Mrj0@mtj.duckdns.org>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201165424.2030647-9-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 05:54:23PM +0100, Christoph Hellwig wrote:
> There is good reason to iterate backwards when deleting all partitions in
> del_gendisk, just like we don't in blk_drop_partitions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yeah, I was blindly keeping the iteration order. Can't find any explicit
explanation why it was that way. The reverse iteration there goes back to
the initial git import. But yeah, I can't think of any meaningful difference
which can come out of it.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
