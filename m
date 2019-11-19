Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728447AbfKSRRi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 12:17:38 -0500
Date: Tue, 19 Nov 2019 18:17:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 06/10] vfio-ccw: Introduce a new CRW region
Message-ID: <20191119181726.440dd30d.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-7-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-7-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:16 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> This region can be used by userspace to get channel report
> words from vfio-ccw driver.

I think this needs a bit more explanation; this is for channel report
words concerning vfio-ccw devices that are supposed to be relayed to
the guest, IIUC?

>=20
> We provide space for two CRWs, per the limit in the
> base driver (see crw_collect_info()).

That rationale seems a bit sketchy.

As far as I know, current systems provide at most two crws chained
together for an event (one for the ssid + one for the subchannel id in
case of a subchannel event, one crw for other events); and that's the
reason why we provide space for two crws (unless there's something
upcoming which would need three crws chained together?)

>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - Clean up checkpatch (whitespace) errors
>      - Add ret=3D-ENOMEM in error path for new region
>      - Add io_mutex for region read (originally in last patch)
>      - Change crw1/crw2 to crw0/crw1
>      - Reorder cleanup of regions
>=20
>  drivers/s390/cio/vfio_ccw_chp.c     | 53 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 20 +++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     |  4 +++
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  include/uapi/linux/vfio.h           |  1 +
>  include/uapi/linux/vfio_ccw.h       |  5 +++
>  6 files changed, 86 insertions(+)
>=20
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index 826d08379fe3..d1e8bfef06be 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -73,3 +73,56 @@ int vfio_ccw_register_schib_dev_regions(struct vfio_cc=
w_private *private)
>  =09=09=09=09=09    VFIO_REGION_INFO_FLAG_READ,
>  =09=09=09=09=09    private->schib_region);
>  }
> +
> +static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private=
,
> +=09=09=09=09=09char __user *buf, size_t count,
> +=09=09=09=09=09loff_t *ppos)
> +{
> +=09unsigned int i =3D VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REG=
IONS;
> +=09loff_t pos =3D *ppos & VFIO_CCW_OFFSET_MASK;
> +=09struct ccw_crw_region *region;
> +=09int ret;
> +
> +=09if (pos + count > sizeof(*region))
> +=09=09return -EINVAL;
> +
> +=09mutex_lock(&private->io_mutex);
> +=09region =3D private->region[i].data;
> +
> +=09if (copy_to_user(buf, (void *)region + pos, count))
> +=09=09ret =3D -EFAULT;
> +=09else
> +=09=09ret =3D count;
> +

Can userspace read the same crw(s) multiple times? How can it find out
if there's something new in there?

> +=09mutex_unlock(&private->io_mutex);
> +=09return ret;
> +}
> +

(...)

> diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.=
h
> index 7c0a834e5d7a..88b125aad279 100644
> --- a/include/uapi/linux/vfio_ccw.h
> +++ b/include/uapi/linux/vfio_ccw.h
> @@ -39,4 +39,9 @@ struct ccw_schib_region {
>  =09__u8 schib_area[SCHIB_AREA_SIZE];
>  } __packed;
>

I think this one wants an explaining comment as well.
 =20
> +struct ccw_crw_region {
> +=09__u32 crw0;
> +=09__u32 crw1;
> +} __packed;
> +
>  #endif
