Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36915 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbgJGKjj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Oct 2020 06:39:39 -0400
Date: Wed, 7 Oct 2020 12:39:36 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 2/2] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20201007103936.GA24327@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com> <20200519142259.102279-3-sth@linux.ibm.com> <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c815b8a-7d77-5c69-9191-d09cc433f5ff@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, hch@lst.de, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:34:17AM +0200, Christian Borntraeger wrote:
> 
> On 19.05.20 16:22, Stefan Haberland wrote:
> > The IBM partition parser requires device type specific information only
> > available to the DASD driver to correctly register partitions. The
> > current approach of using ioctl_by_bdev with a fake user space pointer
> > is discouraged.
> > 
> > Fix this by replacing IOCTL calls with direct in-kernel function calls.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> > Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> > Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
> FWIW, this broken the ibm-partition code for virtio-blk, when CONFIG_DASD=m.

What are the symptoms?
