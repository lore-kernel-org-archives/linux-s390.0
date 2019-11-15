Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfKOKIy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:08:54 -0500
Subject: Re: [PATCH 6/7] block: move clearing bd_invalidated into
 check_disk_size_change
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-7-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <71fc0a5b-ad15-3041-9ea8-8e37b398931d@suse.de>
Date: Fri, 15 Nov 2019 11:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <20191114143438.14681-7-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/14/19 3:34 PM, Christoph Hellwig wrote:
> Both callers of check_disk_size_change clear bd_invalidate directly
> after the call, so move the clearing into check_disk_size_change
> itself.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
