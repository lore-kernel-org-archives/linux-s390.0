Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727591AbgKFTRB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Nov 2020 14:17:01 -0500
Date: Fri, 6 Nov 2020 20:16:32 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH, RFC 11/10] block: propagate BLKROSET to all partitions
Message-ID: <20201106191632.GB76682@imap.linux.ibm.com>
References: <20201106140817.GA23557@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106140817.GA23557@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org, martin.petersen@oracle.com

Christoph Hellwig <hch@lst.de> schrieb am Fri, 06. Nov 15:08:
> 
> When setting the whole device read-only (or clearing the read-only
> state), also update the policy for all partitions.  The s390 dasd
> driver has awlways been doing this and it makes a lot of sense.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested on s390, works fine for me. Thanks.
