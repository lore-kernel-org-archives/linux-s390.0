Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42060 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgDJMUV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Apr 2020 08:20:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id x66so1860988qkd.9
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2020 05:20:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200410054544.GA17923@lst.de>
Date: Fri, 10 Apr 2020 08:20:17 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CC1C981-47F1-4C4D-A4D7-B6411D716A2F@lca.pw>
References: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
 <20200410054544.GA17923@lst.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



> On Apr 10, 2020, at 1:45 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Please try this patch:

It works fine.

>=20
> ---
> =46rom f42fb98cc627f9b960fd5b9a3a229da5c5dcf54a Mon Sep 17 00:00:00 =
2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 10 Apr 2020 07:14:13 +0200
> Subject: block: fix busy device checking in blk_drop_partitions again
>=20
> The previous fix had an off by one in the bd_openers checking, =
counting
> the callers blkdev_get.
>=20
> Fixes: d3ef5536274f ("block: fix busy device checking in =
blk_drop_partitions")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/partitions/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a0a829d8416..bc1ded1331b1 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, =
struct block_device *bdev)
>=20
> 	if (!disk_part_scan_enabled(disk))
> 		return 0;
> -	if (bdev->bd_part_count || bdev->bd_openers)
> +	if (bdev->bd_part_count || bdev->bd_openers > 1)
> 		return -EBUSY;
> 	res =3D invalidate_partition(disk, 0);
> 	if (res)
> --=20
> 2.25.1
>=20
