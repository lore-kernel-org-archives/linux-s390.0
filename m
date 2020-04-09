Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29495 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDILVP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 07:21:15 -0400
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 01/10] block: refactor blkpg_ioctl
Date: Thu, 9 Apr 2020 11:21:13 +0000
Message-ID: <SN4PR0401MB35984BB0C3BC58C396E7E8739BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-2-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> +	case BLKPG_DEL_PARTITION:=0A=
> +		return bdev_resize_partition(bdev, p.pno, start, length);=0A=
=0A=
This needs to be BLKPG_RESIZE_PARTITION.=0A=
