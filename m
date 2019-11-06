Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfKFRYr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 6 Nov 2019 12:24:47 -0500
Date: Thu, 7 Nov 2019 02:24:39 +0900
From: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191106172439.GA29853@redsun51.ssa.fujisawa.hgst.com>
References: <20191106151439.30056-1-hch@lst.de>
 <20191106151439.30056-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106151439.30056-3-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On Wed, Nov 06, 2019 at 04:14:36PM +0100, Christoph Hellwig wrote:
> A lot of the logic in invalidate_partitions and invalidate_partitions

One of these should say 'rescan_partitions'. Otherwise, patch looks good.
