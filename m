Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgLCMrO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 3 Dec 2020 07:47:14 -0500
Subject: Re: [PATCH 2/5] block: simplify and extended the block_bio_merge
 tracepoint class
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <168a66f3-326f-6cb5-3153-e7ab75e332a6@suse.de>
Date: Thu, 3 Dec 2020 13:46:30 +0100
MIME-Version: 1.0
In-Reply-To: <20201130175854.982460-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org

On 11/30/20 6:58 PM, Christoph Hellwig wrote:
> The block_bio_merge tracepoint class can be reused for most bio-based
> tracepoints.  For that is just needs to lose the superflous and rq

'and rq' ?
Do you mean 'q and rq'?

> parameters.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c             |   2 +-
>   block/blk-merge.c            |   4 +-
>   block/blk-mq.c               |   2 +-
>   block/bounce.c               |   2 +-
>   include/trace/events/block.h | 158 ++++++++---------------------------
>   kernel/trace/blktrace.c      |  41 +++------
>   6 files changed, 48 insertions(+), 161 deletions(-)
> 
Otherwise:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
