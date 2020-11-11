Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39098 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgKKH6F (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Nov 2020 02:58:05 -0500
Date: Wed, 11 Nov 2020 08:58:02 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: block ioctl cleanups v2
Message-ID: <20201111075802.GB23010@lst.de>
References: <20201103100018.683694-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103100018.683694-1-hch@lst.de>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

Jens, can you take a look and possibly pick this series up?

On Tue, Nov 03, 2020 at 11:00:08AM +0100, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series has a bunch of cleanups for the block layer ioctl code.
> 
> Changes since v1:
>  - drop the patch to return the correct error for unknown ioctls in mtip
>  - add back an empty line in rbd
>  - various spelling fixes
---end quoted text---
