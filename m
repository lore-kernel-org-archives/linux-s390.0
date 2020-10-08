Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729833AbgJHOn5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 10:43:57 -0400
Date: Thu, 8 Oct 2020 16:43:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 08/10] s390/dasd: Display FC Endpoint Security
 information via sysfs
Message-ID: <20201008164348.0e640045.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-9-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-9-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  8 Oct 2020 15:13:34 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> Add a new sysfs attribute (fc_security) per device and per operational
> channel path. The information of the current FC Endpoint Security state
> is received through the CIO layer.
>=20
> The state of the FC Endpoint Security can be either "Unsupported",
> "Authentication", or "Encryption".
>=20
> For example:
> $ cat /sys/bus/ccw/devices/0.0.c600/fc_security
> Encryption
>=20
> If any of the operational paths is in a state different from all
> others, the device sysfs attribute will display the additional state
> "Inconsistent".
>=20
> The sysfs attributes per paths are organised in a new directory called
> "paths_info" with subdirectories for each path.
>=20
> /sys/bus/ccw/devices/0.0.c600/paths_info/
> =E2=94=9C=E2=94=80=E2=94=80 0.38
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> =E2=94=9C=E2=94=80=E2=94=80 0.39
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> =E2=94=9C=E2=94=80=E2=94=80 0.3a
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 fc_security
> =E2=94=94=E2=94=80=E2=94=80 0.3b
>     =E2=94=94=E2=94=80=E2=94=80 fc_security
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 109 +++++++++++++++++++++++++++++++
>  drivers/s390/block/dasd_eckd.c   |  30 +++++++++
>  drivers/s390/block/dasd_int.h    |  68 +++++++++++++++++++
>  3 files changed, 207 insertions(+)

(...)

> +/*
> + * As we keep kobjects for the lifetime of a device, this function must =
not be
> + * called anywhere but in the context of offlining a device.
> + */

Works for me :)

> +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +{
> +	if (device->path[chp].in_sysfs) {
> +		kobject_put(&device->path[chp].kobj);
> +		device->path[chp].in_sysfs =3D false;
> +	}
> +}
> +EXPORT_SYMBOL(dasd_path_remove_kobj);

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
