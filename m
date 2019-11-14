Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNObb (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 09:31:31 -0500
Date: Thu, 14 Nov 2019 15:31:28 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] block: fix bdev_disk_changed for non-partitioned
 devices
Message-ID: <20191114143128.GA1591@lst.de>
References: <20191106151439.30056-1-hch@lst.de> <20191106151439.30056-5-hch@lst.de> <20191114140716.GI28486@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114140716.GI28486@quack2.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, Nov 14, 2019 at 03:07:16PM +0100, Jan Kara wrote:
> I'd just note that e.g. drivers/scsi/sr.c or drivers/scsi/sd.c already call
> revalidate_disk() on device open so it seems a bit stupid to call it again
> just a bit later. But that's not really a new thing, this patch just makes
> it universal.

That whole area is a bit of a mess, including how the whole
->revalidate_disk callback works, and how we have a complicated events
mechanism, but then also md as the only remaining user of the legacy
->media_changed method.  I have a few idea on how to sort some of that
out, but it's going to take a while.
