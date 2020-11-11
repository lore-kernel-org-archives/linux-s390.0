Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKKIDq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Nov 2020 03:03:46 -0500
Date: Wed, 11 Nov 2020 09:03:34 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC 11/10] block: propagate BLKROSET to all partitions
Message-ID: <20201111080334.GA23062@lst.de>
References: <20201106140817.GA23557@lst.de> <yq1imacecwz.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1imacecwz.fsf@ca-mkp.ca.oracle.com>
List-ID: <linux-s390.vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On Tue, Nov 10, 2020 at 11:38:22PM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > When setting the whole device read-only (or clearing the read-only
> > state), also update the policy for all partitions.  The s390 dasd
> > driver has awlways been doing this and it makes a lot of sense.
> 
> For your amusement, here's my attempt at addressing this from a while
> back. Can't remember exactly why this stranded, I even wrote blktests
> for it...

I added you to the Cc list because I had a vague memory that you were
looking into this area a while ago.

I actually think your patch that goes further is the right thing to do,
and I was going to look into something similar for a problem with
hardware read-only namespaces in NVMe.  I think I'll take your patch
as a starting point and will work from there.
