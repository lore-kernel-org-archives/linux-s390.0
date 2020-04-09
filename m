Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26035 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILd2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 07:33:28 -0400
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 05/10] block: remove the disk argument from
 blk_drop_partitions
Date: Thu, 9 Apr 2020 11:33:25 +0000
Message-ID: <SN4PR0401MB3598977E7D85FA660AD5A4519BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-6-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> -int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)=
=0A=
> +int blk_drop_partitions(struct block_device *bdev)=0A=
>   {=0A=
>   	struct disk_part_iter piter;=0A=
>   	struct hd_struct *part;=0A=
>   	int res;=0A=
>   =0A=
> -	if (!disk_part_scan_enabled(disk))=0A=
> +	if (!disk_part_scan_enabled(bdev->bd_disk))=0A=
>   		return 0;=0A=
>   	if (bdev->bd_part_count || bdev->bd_openers)=0A=
>   		return -EBUSY;=0A=
> -	res =3D invalidate_partition(disk, 0);=0A=
> +	res =3D invalidate_partition(bdev->bd_disk, 0);=0A=
>   	if (res)=0A=
>   		return res;=0A=
>   =0A=
> -	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);=0A=
> +	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);=0A=
>   	while ((part =3D disk_part_iter_next(&piter)))=0A=
> -		delete_partition(disk, part);=0A=
> +		delete_partition(bdev->bd_disk, part);=0A=
>   	disk_part_iter_exit(&piter);=0A=
=0A=
I would have probably added a local 'struct gendisk *disk' variable, but =
=0A=
that's personal preference I guess.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
