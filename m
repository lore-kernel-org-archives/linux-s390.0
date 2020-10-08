Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729770AbgJHOiI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:38:08 -0400
Date: Thu, 8 Oct 2020 16:37:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 07/10] s390/dasd: Fix operational path inconsistency
Message-ID: <20201008163756.3d1443b9.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-8-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-8-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  8 Oct 2020 15:13:33 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> During online processing and setting up a DASD device, the configuration
> data for operational paths is read and validated two times
> (dasd_eckd_read_conf()). The first time to provide information that are
> necessary for the LCU setup. A second time after the LCU setup as a
> device might report different configuration data then.
>=20
> When the configuration setup for each operational path is being
> validated, an initial call to dasd_eckd_clear_conf_data() is issued.
> This call wipes all previously available configuration data and path
> information for each path.
> However, the operational path mask is not updated during this process.
>=20
> As a result, the stored operational path mask might no longer correspond
> to the operational paths mask reported by the CIO layer, as several
> paths might be gone between the two dasd_eckd_read_conf() calls.
>=20
> This inconsistency leads to more severe issues in later path handling
> changes. Fix this by removing the channel paths from the operational
> path mask during the dasd_eckd_clear_conf_data() call.
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 3ff7b532a5bf..3273b26b25b0 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1034,6 +1034,7 @@ static void dasd_eckd_clear_conf_data(struct dasd_d=
evice *device)
>  		device->path[i].cssid =3D 0;
>  		device->path[i].ssid =3D 0;
>  		device->path[i].chpid =3D 0;
> +		dasd_path_notoper(device, i);
>  	}
>  }
> =20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
