Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCUJA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 15:09:00 -0500
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 3 Dec 2020 15:07:45 -0500
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/5] block: remove the request_queue argument to the
 block_bio_remap tracepoint
Message-ID: <X8lFkSc2nZtbfibs@mtj.duckdns.org>
References: <20201203162139.2110977-1-hch@lst.de>
 <20201203162139.2110977-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203162139.2110977-5-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>, Hannes Reinecke <hare@suse.de>

On Thu, Dec 03, 2020 at 05:21:38PM +0100, Christoph Hellwig wrote:
> The request_queue can trivially be derived from the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
