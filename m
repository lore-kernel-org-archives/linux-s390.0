Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64421 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbhAYNxl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Jan 2021 08:53:41 -0500
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 02/10] dcssblk: remove the end of device check in
 dcssblk_submit_bio
Date: Mon, 25 Jan 2021 13:52:20 +0000
Message-ID: <SN4PR0401MB3598F6894E3789B7D3FCB7679BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210124100241.1167849-1-hch@lst.de>
 <20210124100241.1167849-3-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
