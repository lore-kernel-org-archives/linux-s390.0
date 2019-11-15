Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbfKOKGV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:06:21 -0500
Subject: Re: [PATCH 3/7] block: move rescan_partitions to fs/block_dev.c
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <eb60ac31-bd20-0969-8796-414eb6e6f570@suse.de>
Date: Fri, 15 Nov 2019 11:06:18 +0100
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-4-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/14/19 3:34 PM, Christoph Hellwig wrote:
> Large parts of rescan_partitions aren't about partitions, and
> moving it to block_dev.c will allow for some further cleanups by
> merging it into its only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  block/partition-generic.c | 37 ++-----------------------------------
>  fs/block_dev.c            | 38 ++++++++++++++++++++++++++++++++++++--
>  include/linux/fs.h        |  2 --
>  include/linux/genhd.h     |  4 ++--
>  4 files changed, 40 insertions(+), 41 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
