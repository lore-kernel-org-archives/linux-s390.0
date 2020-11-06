Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgKFA7Q (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 5 Nov 2020 19:59:16 -0500
MIME-Version: 1.0
References: <20201103100018.683694-1-hch@lst.de> <20201103100018.683694-6-hch@lst.de>
In-Reply-To: <20201103100018.683694-6-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Thu, 5 Nov 2020 16:59:02 -0800
Message-ID: <CAPhsuW65Au-wJJo96KF0J3drdriCqHZ9Oa3=bfjfspV3tKByrg@mail.gmail.com>
Subject: Re: [PATCH 05/10] md: implement ->set_read_only to hook into BLKROSET processing
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, ceph-devel@vger.kernel.org, linux-bcache@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org

On Tue, Nov 3, 2020 at 2:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Implement the ->set_read_only method instead of parsing the actual
> ioctl command.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM!

Acked-by: Song Liu <song@kernel.org>
