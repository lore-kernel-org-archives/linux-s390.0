Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 25 Nov 2020 18:06:58 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH] scsi: zfcp: fix use-after-free in zfcp_unit_remove
Message-ID: <20201125170658.GB8578@t480-pf1aa2c2>
References: <20201120074854.31754-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201120074854.31754-1-miaoqinglang@huawei.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org

On Fri, Nov 20, 2020 at 03:48:54PM +0800, Qinglang Miao wrote:
> kfree(port) is called in put_device(&port->dev) so that following
> use would cause use-after-free bug.
>=20
> The former put_device is redundant for device_unregister contains
> put_device already. So just remove it to fix this.
>=20
> Fixes: 86bdf218a717 ("[SCSI] zfcp: cleanup unit sysfs attribute usage")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/s390/scsi/zfcp_unit.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/s390/scsi/zfcp_unit.c b/drivers/s390/scsi/zfcp_unit.c
> index e67bf7388..664b77853 100644
> --- a/drivers/s390/scsi/zfcp_unit.c
> +++ b/drivers/s390/scsi/zfcp_unit.c
> @@ -255,8 +255,6 @@ int zfcp_unit_remove(struct zfcp_port *port, u64 fcp_=
lun)
>  		scsi_device_put(sdev);
>  	}
> =20
> -	put_device(&unit->dev);
> -
>  	device_unregister(&unit->dev);
> =20
>  	return 0;

Same as in the other mail for `zfcp_sysfs_port_remove_store()`. We
explicitly get a new ref in `_zfcp_unit_find()`, so we also need to put
that away again.

--=20
Best Regards, Benjamin Block  / Linux on IBM Z Kernel Development / IBM Sys=
tems
IBM Deutschland Research & Development GmbH    /    https://www.ibm.com/pri=
vacy
Vorsitz. AufsR.: Gregor Pillen         /        Gesch=EF=BF=BDftsf=EF=BF=BD=
hrung: Dirk Wittkopp
Sitz der Gesellschaft: B=EF=BF=BDblingen / Registergericht: AmtsG Stuttgart=
, HRB 243294
