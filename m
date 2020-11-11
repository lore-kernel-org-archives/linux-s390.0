Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:55940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKQxi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Nov 2020 11:53:38 -0500
Subject: Re: [PATCH, RFC 11/10] block: propagate BLKROSET to all partitions
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Message-ID: <yq1o8k3dei6.fsf@ca-mkp.ca.oracle.com>
References: <20201106140817.GA23557@lst.de>
        <yq1imacecwz.fsf@ca-mkp.ca.oracle.com> <20201111080334.GA23062@lst.de>
Date: Wed, 11 Nov 2020 11:53:02 -0500
In-Reply-To: <20201111080334.GA23062@lst.de> (Christoph Hellwig's message of
        "Wed, 11 Nov 2020 09:03:34 +0100")
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org


Christoph,

> I actually think your patch that goes further is the right thing to
> do, and I was going to look into something similar for a problem with
> hardware read-only namespaces in NVMe.  I think I'll take your patch
> as a starting point and will work from there.

Sounds good!

I still have the blktests in a branch. Will adjust and resubmit once you
post your rework.

-- 
Martin K. Petersen	Oracle Linux Engineering
