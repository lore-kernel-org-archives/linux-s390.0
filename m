Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgLCMum (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 3 Dec 2020 07:50:42 -0500
Subject: Re: [PATCH 5/5] block: remove the request_queue to argument request
 based tracepoints
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d7798a1e-70b5-27bc-3bb9-e8d300907920@suse.de>
Date: Thu, 3 Dec 2020 13:49:59 +0100
MIME-Version: 1.0
In-Reply-To: <20201130175854.982460-6-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org

On 11/30/20 6:58 PM, Christoph Hellwig wrote:
> The request_queue can trivially be derived from the request.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c            |  2 +-
>   block/blk-mq-sched.c         |  2 +-
>   block/blk-mq.c               |  8 +++----
>   drivers/md/dm-rq.c           |  2 +-
>   drivers/s390/scsi/zfcp_fsf.c |  3 +--
>   include/linux/blktrace_api.h |  5 ++--
>   include/trace/events/block.h | 30 ++++++++++--------------
>   kernel/trace/blktrace.c      | 44 ++++++++++++++----------------------
>   8 files changed, 39 insertions(+), 57 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
