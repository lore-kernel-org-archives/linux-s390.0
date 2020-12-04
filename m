Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgLDD12 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 22:27:28 -0500
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 5/5] block: remove the request_queue to argument request
 based tracepoints
Date: Fri, 4 Dec 2020 03:26:40 +0000
Message-ID: <BYAPR04MB49652797046268186CCD404286F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201203162139.2110977-1-hch@lst.de>
 <20201203162139.2110977-6-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>

On 12/3/20 08:26, Christoph Hellwig wrote:=0A=
> The request_queue can trivially be derived from the request.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
> ---=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
