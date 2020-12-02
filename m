Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgLBXGb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 18:06:31 -0500
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 2 Dec 2020 18:05:21 -0500
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/9] block: use ->bi_bdev for bio based I/O accounting
Message-ID: <X8gdscx01GT9vJyp@mtj.duckdns.org>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201165424.2030647-6-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 05:54:20PM +0100, Christoph Hellwig wrote:
> Rework the I/O accounting for bio based drivers to use ->bi_bdev.  This
> means all drivers can now simply use bio_start_io_acct to start
> accounting, and it will take partitions into account automatically.  To
> end I/O account either bio_end_io_acct can be used if the driver never
> remaps I/O to a different device, or bio_end_io_acct_remapped if the
> driver did remap the I/O.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
