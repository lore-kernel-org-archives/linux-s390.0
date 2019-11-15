Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47648 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfKOKIY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:08:24 -0500
Subject: Re: [PATCH 5/7] block: remove (__)blkdev_reread_part as an exported
 API
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <01ea27d7-9b0d-2001-843e-bbb06b610f83@suse.de>
Date: Fri, 15 Nov 2019 11:08:21 +0100
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-6-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>

On 11/14/19 3:34 PM, Christoph Hellwig wrote:
> In general drivers should never mess with partition tables directly.
> Unfortunately s390 and loop do for somewhat historic reasons, but they
> can use bdev_disk_changed directly instead when we export it as they
> satisfy the sanity checks we have in __blkdev_reread_part.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>	[dasd]
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  block/ioctl.c                   | 35 +++++----------------------------
>  drivers/block/loop.c            | 13 +++++++-----
>  drivers/s390/block/dasd_genhd.c |  4 +++-
>  fs/block_dev.c                  |  7 +++++++
>  include/linux/fs.h              |  2 --
>  5 files changed, 23 insertions(+), 38 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
