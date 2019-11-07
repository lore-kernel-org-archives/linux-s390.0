Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbfKGJj4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 04:39:56 -0500
Subject: Re: [PATCH 1/5] block: refactor rescan_partitions
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e22bf69f-cec6-5d27-3c4c-9423ece2b6eb@suse.de>
Date: Thu, 7 Nov 2019 10:39:53 +0100
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-2-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/6/19 4:14 PM, Christoph Hellwig wrote:
> Split out a helper that adds one single partition, and another one
> calling that dealing with the parsed_partitions state.  This makes
> it much more obvious how we clean up all state and start again when
> using the rescan label.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partition-generic.c | 176 +++++++++++++++++++++-----------------
>  1 file changed, 96 insertions(+), 80 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
