Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgLCMns (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 3 Dec 2020 07:43:48 -0500
Subject: Re: [PATCH 1/5] block: remove the unused block_sleeprq tracepoint
References: <20201130175854.982460-1-hch@lst.de>
 <20201130175854.982460-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d7222f62-3bcc-e9a2-55b2-58c83ca08556@suse.de>
Date: Thu, 3 Dec 2020 13:43:04 +0100
MIME-Version: 1.0
In-Reply-To: <20201130175854.982460-2-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org

On 11/30/20 6:58 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/trace/events/block.h | 18 ------------------
>   kernel/trace/blktrace.c      | 22 ----------------------
>   2 files changed, 40 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
