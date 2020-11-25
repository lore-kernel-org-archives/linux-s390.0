Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731040AbgKYREX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 12:04:23 -0500
Date: Wed, 25 Nov 2020 18:04:09 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in
 zfcp_sysfs_port_remove_store
Message-ID: <20201125170409.GA8578@t480-pf1aa2c2>
References: <20201120074853.31706-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201120074853.31706-1-miaoqinglang@huawei.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, Nov 20, 2020 at 03:48:53PM +0800, Qinglang Miao wrote:
> kfree(port) is called in put_device(&port->dev) so that following
> use would cause use-after-free bug.
>=20
> the former put_device is redundant for device_unregister contains
> put_device already. So just remove it to fix this.
>=20
> Fixes: 83d4e1c33d93 ("[SCSI] zfcp: cleanup port sysfs attribute usage")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/scsi/zfcp_sysfs.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysf=
s.c
> index 8d9662e8b..06285e452 100644
> --- a/drivers/s390/scsi/zfcp_sysfs.c
> +++ b/drivers/s390/scsi/zfcp_sysfs.c
> @@ -327,8 +327,6 @@ static ssize_t zfcp_sysfs_port_remove_store(struct de=
vice *dev,
>  	list_del(&port->list);
>  	write_unlock_irq(&adapter->port_list_lock);
> =20
> -	put_device(&port->dev);
> -
>  	zfcp_erp_port_shutdown(port, 0, "syprs_1");
>  	device_unregister(&port->dev);
>   out:

Hmm, the placement of the put_device() is indeed strange, now that I
think about it. But just removing it and then having a dangling
reference also seems wrong - we do get one explicitly in
`zfcp_get_port_by_wwpn()`.

My first thought would be to move it after the `device_unregister()`
call, and before the `out:` label.


--=20
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
