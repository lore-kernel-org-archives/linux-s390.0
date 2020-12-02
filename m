Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLBXXQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Dec 2020 18:23:16 -0500
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 2 Dec 2020 18:22:06 -0500
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 9/9] block: use an xarray for disk->part_tbl
Message-ID: <X8ghnnEfBZWG+nLr@mtj.duckdns.org>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201165424.2030647-10-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org

On Tue, Dec 01, 2020 at 05:54:24PM +0100, Christoph Hellwig wrote:
> Now that no fast path lookups in the partition table are left, there is
> no point in micro-optimizing the data structure for it.  Just use a bog
> standard xarray.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

-- 
tejun
