Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbfKOKF5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:05:57 -0500
Subject: Re: [PATCH 2/7] block: merge invalidate_partitions into
 rescan_partitions
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <15ec0586-550b-2e98-d750-66f16b4f6bad@suse.de>
Date: Fri, 15 Nov 2019 11:05:54 +0100
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/14/19 3:34 PM, Christoph Hellwig wrote:
> A lot of the logic in invalidate_partitions and rescan_partitions is
> shared.  Merge the two functions to simplify things.  There is a small
> behavior change in that we now send the kevent change notice also if we
> were not invalidating but no partitions were found, which seems like
> the right thing to do.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioctl.c             |  2 +-
>  block/partition-generic.c | 38 ++++++++++++++------------------------
>  fs/block_dev.c            |  5 +----
>  include/linux/genhd.h     |  4 ++--
>  4 files changed, 18 insertions(+), 31 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
