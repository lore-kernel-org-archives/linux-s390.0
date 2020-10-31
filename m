Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgJaVdI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Oct 2020 17:33:08 -0400
MIME-Version: 1.0
References: <20201031085810.450489-1-hch@lst.de> <20201031085810.450489-2-hch@lst.de>
In-Reply-To: <20201031085810.450489-2-hch@lst.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 31 Oct 2020 22:32:56 +0100
Message-ID: <CAFLxGvzXaM8gKF5ffG6dgNaCuTV_g7uozoMiPPHtkmte2CY_bQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] mtd_blkdevs: don't override BLKFLSBUF
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, Vignesh Raghavendra <vigneshr@ti.com>, linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>, linux-block@vger.kernel.org, Song Liu <song@kernel.org>, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, Stefan Haberland <sth@linux.ibm.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> BLKFLSBUF does not actually send a flush command to the device, but
> teard down buffer cache structures.  Remove the mtd_blkdevs
> implementation and just use the default semantics instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
