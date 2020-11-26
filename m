Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgKZIOD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 03:14:03 -0500
Date: Thu, 26 Nov 2020 09:13:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
Message-ID: <20201126091353.50cf6ab6.cohuck@redhat.com>
In-Reply-To: <4c65bead-2553-171e-54d2-87a9de0330e8@huawei.com>
References: <20201120074854.31754-1-miaoqinglang@huawei.com>
        <20201125170658.GB8578@t480-pf1aa2c2>
        <4c65bead-2553-171e-54d2-87a9de0330e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

On Thu, 26 Nov 2020 09:27:41 +0800
Qinglang Miao <miaoqinglang@huawei.com> wrote:

> =E5=9C=A8 2020/11/26 1:06, Benjamin Block =E5=86=99=E9=81=93:
> > On Fri, Nov 20, 2020 at 03:48:54PM +0800, Qinglang Miao wrote: =20
> >> kfree(port) is called in put_device(&port->dev) so that following
> >> use would cause use-after-free bug.
> >>
> >> The former put_device is redundant for device_unregister contains
> >> put_device already. So just remove it to fix this.
> >>
> >> Fixes: 86bdf218a717 ("[SCSI] zfcp: cleanup unit sysfs attribute usage")
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> >> ---
> >>   drivers/s390/scsi/zfcp_unit.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_un=
it.c
> >> index e67bf7388..664b77853 100644
> >> --- a/drivers/s390/scsi/zfcp_unit.c
> >> +++ b/drivers/s390/scsi/zfcp_unit.c
> >> @@ -255,8 +255,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 f=
cp_lun)
> >>   		scsi_device_put(sdev);
> >>   	}
> >>  =20
> >> -	put_device(&unit->dev);
> >> -
> >>   	device_unregister(&unit->dev); =20
> >>  >>   	return 0; =20
> >=20
> > Same as in the other mail for `zfcp_sysfs_port_remove_store()`. We
> > explicitly get a new ref in `_zfcp_unit_find()`, so we also need to put
> > that away again.
> > =20
> Sorry, Benjamin, I don't think so, because device_unregister calls=20
> put_device inside.
>=20
> It seem's that another put_device before or after device_unregister is=20
> useless and even might cause an use-after-free.

The issue here (and in the other patches that I had commented on) is
that the references have different origins. device_register() acquires
a reference, and that reference is given up when you call
device_unregister(). However, the code here grabs an extra reference,
and it of course has to give it up again when it no longer needs it.

This is something that is not that easy to spot by an automated check,
I guess?
