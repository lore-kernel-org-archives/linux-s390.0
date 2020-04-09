Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:47668 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDIMCm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 08:02:42 -0400
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 02/10] block: pass a hd_struct to delete_partition
Date: Thu, 9 Apr 2020 12:02:40 +0000
Message-ID: <SN4PR0401MB3598AEB9E6A034AEE87A606E9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-3-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> All callers have the hd_strut at hand, so pass it instead of doing=0A=
Nit: hd_struct=0A=
