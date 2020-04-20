Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42044 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgDTR0G (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 13:26:06 -0400
Date: Mon, 20 Apr 2020 19:26:04 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: more partition handling cleanups v2
Message-ID: <20200420172604.GA1562@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On Tue, Apr 14, 2020 at 09:28:52AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up more lose ends in the partitioning code.  It also
> removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.
> 
> Changes since v1:
>  - fix a brown paperbag typo in blkpg_do_ioctl
>  - fix a commit message typo

ping?  This is the first of a few series to eventually kill
ioctl_by_bdev, so I'd like to get things moving.
