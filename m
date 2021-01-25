Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729845AbhAYO4v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Jan 2021 09:56:51 -0500
From: Stefan Haberland <sth@linux.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
 <20210118165518.14578-2-sth@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: Fix inconsistent kobject removal
Message-ID: <7e7051ac-dbe2-2951-2362-1bc9e7a8dfc6@linux.ibm.com>
Date: Mon, 25 Jan 2021 15:55:58 +0100
MIME-Version: 1.0
In-Reply-To: <20210118165518.14578-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>

Hi Jens,

small question.
Do you plan to include the fix still for 5.11 or with the merge window
for 5.12?
The faulty patch was included in the 5.11 merge window.

Best regards,
Stefan

Am 18.01.21 um 17:55 schrieb Stefan Haberland:
> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>
> Our intention was to only remove path kobjects whenever a device is
> being set offline. However, one corner case was missing.
>
> If a device is disabled and enabled (using the IOCTLs BIODASDDISABLE an=
d
> BIODASDENABLE respectively), the enabling process will call
> dasd_eckd_reload_device() which itself calls dasd_eckd_read_conf() in
> order to update path information. During that update,
> dasd_eckd_clear_conf_data() clears all old data and also removes all
> kobjects. This will leave us with an inconsistent state of path kobject=
s
> and a subsequent path verification leads to a failing kobject creation.=

>
> Fix this by removing kobjects only in the context of offlining a device=

> as initially intended.
>
> Fixes: 19508b204740 ("s390/dasd: Display FC Endpoint Security informati=
on via sysfs")
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
>  drivers/s390/block/dasd_eckd.c   |  3 ++-
>  drivers/s390/block/dasd_int.h    |  2 +-
>  3 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd=
_devmap.c
> index 16bb135c20aa..03d27ee9cac6 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -1874,18 +1874,26 @@ void dasd_path_create_kobjects(struct dasd_devi=
ce *device)
>  }
>  EXPORT_SYMBOL(dasd_path_create_kobjects);
> =20
> -/*
> - * As we keep kobjects for the lifetime of a device, this function mus=
t not be
> - * called anywhere but in the context of offlining a device.
> - */
> -void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> +static void dasd_path_remove_kobj(struct dasd_device *device, int chp)=

>  {
>  	if (device->path[chp].in_sysfs) {
>  		kobject_put(&device->path[chp].kobj);
>  		device->path[chp].in_sysfs =3D false;
>  	}
>  }
> -EXPORT_SYMBOL(dasd_path_remove_kobj);
> +
> +/*
> + * As we keep kobjects for the lifetime of a device, this function mus=
t not be
> + * called anywhere but in the context of offlining a device.
> + */
> +void dasd_path_remove_kobjects(struct dasd_device *device)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < 8; i++)
> +		dasd_path_remove_kobj(device, i);
> +}
> +EXPORT_SYMBOL(dasd_path_remove_kobjects);
> =20
>  int dasd_add_sysfs_files(struct ccw_device *cdev)
>  {
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_e=
ckd.c
> index 3caa1ee5f4b0..65eb87cbbb9b 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1036,7 +1036,6 @@ static void dasd_eckd_clear_conf_data(struct dasd=
_device *device)
>  		device->path[i].ssid =3D 0;
>  		device->path[i].chpid =3D 0;
>  		dasd_path_notoper(device, i);
> -		dasd_path_remove_kobj(device, i);
>  	}
>  }
> =20
> @@ -2173,6 +2172,7 @@ dasd_eckd_check_characteristics(struct dasd_devic=
e *device)
>  	device->block =3D NULL;
>  out_err1:
>  	dasd_eckd_clear_conf_data(device);
> +	dasd_path_remove_kobjects(device);
>  	kfree(device->private);
>  	device->private =3D NULL;
>  	return rc;
> @@ -2191,6 +2191,7 @@ static void dasd_eckd_uncheck_device(struct dasd_=
device *device)
>  	private->vdsneq =3D NULL;
>  	private->gneq =3D NULL;
>  	dasd_eckd_clear_conf_data(device);
> +	dasd_path_remove_kobjects(device);
>  }
> =20
>  static struct dasd_ccw_req *
> diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_in=
t.h
> index 3bc008f9136c..b8a04c42d1d2 100644
> --- a/drivers/s390/block/dasd_int.h
> +++ b/drivers/s390/block/dasd_int.h
> @@ -858,7 +858,7 @@ int dasd_add_sysfs_files(struct ccw_device *);
>  void dasd_remove_sysfs_files(struct ccw_device *);
>  void dasd_path_create_kobj(struct dasd_device *, int);
>  void dasd_path_create_kobjects(struct dasd_device *);
> -void dasd_path_remove_kobj(struct dasd_device *, int);
> +void dasd_path_remove_kobjects(struct dasd_device *);
> =20
>  struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
>  struct dasd_device *dasd_device_from_cdev_locked(struct ccw_device *);=
