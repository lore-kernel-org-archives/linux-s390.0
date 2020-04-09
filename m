Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21772 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILaW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 07:30:22 -0400
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 03/10] block: cleanup hd_struct freeing
Date: Thu, 9 Apr 2020 11:30:19 +0000
Message-ID: <SN4PR0401MB3598FDA8DB67BE8337A4C16B9BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-4-hch@lst.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> -	struct hd_struct *part =3D container_of(to_rcu_work(work), struct hd_st=
ruct,=0A=
> -					rcu_work);=0A=
> +	struct hd_struct *part =3D=0A=
> +		container_of(to_rcu_work(work), struct hd_struct, rcu_work);=0A=
=0A=
That looks like an unneeded white space only change=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
