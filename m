Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64444 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407026AbgDNIMQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 04:12:16 -0400
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 07/10] block: don't call invalidate_partition from
 blk_drop_partitions
Date: Tue, 14 Apr 2020 08:12:12 +0000
Message-ID: <SN4PR0401MB3598938F35E3F588626B25D79BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414072902.324936-1-hch@lst.de>
 <20200414072902.324936-8-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
