Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38785 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKCATq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Nov 2020 19:19:46 -0500
From: James Troup <james.troup@canonical.com>
Subject: Re: [PATCH 06/11] md: implement ->set_read_only to hook into BLKROSET processing
References: <20201031085810.450489-1-hch@lst.de>
        <20201031085810.450489-7-hch@lst.de>
Date: Tue, 03 Nov 2020 00:19:34 +0000
In-Reply-To: <20201031085810.450489-7-hch@lst.de> (Christoph Hellwig's message
        of "Sat, 31 Oct 2020 09:58:05 +0100")
Message-ID: <87y2jjpa09.fsf@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Song Liu <song@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> @@ -7809,6 +7778,36 @@ static int md_compat_ioctl(struct block_device *bdev, fmode_t mode,

[...]

> +	 * Transitioning to readauto need only happen for arrays that call
> +	 * md_write_start and which are not ready for writes yet.

I realise you're just moving the comment around but perhaps you could
s/readauto/readonly/ while you're doing so?

-- 
James
