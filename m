Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60489 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726351AbfKSMsT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 07:48:19 -0500
Date: Tue, 19 Nov 2019 13:48:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 02/10] vfio-ccw: Register a chp_event callback
 for vfio-ccw
Message-ID: <20191119134809.75ba276b.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-3-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-3-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:12 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> Register the chp_event callback to receive channel path related
> events for the subchannels managed by vfio-ccw.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - Add s390dbf trace
>=20
>  drivers/s390/cio/vfio_ccw_drv.c | 44 +++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 91989269faf1..05da1facee60 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -19,6 +19,7 @@
> =20
>  #include <asm/isc.h>
> =20
> +#include "chp.h"
>  #include "ioasm.h"
>  #include "css.h"
>  #include "vfio_ccw_private.h"
> @@ -257,6 +258,48 @@ static int vfio_ccw_sch_event(struct subchannel *sch=
, int process)
>  =09return rc;
>  }
> =20
> +static int vfio_ccw_chp_event(struct subchannel *sch,
> +=09=09=09      struct chp_link *link, int event)
> +{
> +=09struct vfio_ccw_private *private =3D dev_get_drvdata(&sch->dev);
> +=09int mask =3D chp_ssd_get_mask(&sch->ssd_info, link);
> +=09int retry =3D 255;
> +
> +=09if (!private || !mask)
> +=09=09return 0;
> +
> +=09if (cio_update_schib(sch))
> +=09=09return -ENODEV;

It seems this return code is only checked by the common I/O layer for
the _OFFLINE case; still, it's probably not a bad idea, even though it
is different from what the vanilla I/O subchannel driver does.

> +
> +=09VFIO_CCW_MSG_EVENT(2, "%pUl (%x.%x.%04x): mask=3D0x%x event=3D%d\n",
> +=09=09=09   mdev_uuid(private->mdev), sch->schid.cssid,
> +=09=09=09   sch->schid.ssid, sch->schid.sch_no,
> +=09=09=09   mask, event);

If you log only here, you're missing the case above.

> +
> +=09switch (event) {
> +=09case CHP_VARY_OFF:
> +=09=09/* Path logically turned off */
> +=09=09sch->opm &=3D ~mask;
> +=09=09sch->lpm &=3D ~mask;
> +=09=09break;
> +=09case CHP_OFFLINE:
> +=09=09/* Path is gone */
> +=09=09cio_cancel_halt_clear(sch, &retry);
> +=09=09break;
> +=09case CHP_VARY_ON:
> +=09=09/* Path logically turned on */
> +=09=09sch->opm |=3D mask;
> +=09=09sch->lpm |=3D mask;
> +=09=09break;
> +=09case CHP_ONLINE:
> +=09=09/* Path became available */
> +=09=09sch->lpm |=3D mask & sch->opm;
> +=09=09break;
> +=09}

Looks sane as the first round.

> +
> +=09return 0;
> +}
> +
>  static struct css_device_id vfio_ccw_sch_ids[] =3D {
>  =09{ .match_flags =3D 0x1, .type =3D SUBCHANNEL_TYPE_IO, },
>  =09{ /* end of list */ },
> @@ -274,6 +317,7 @@ static struct css_driver vfio_ccw_sch_driver =3D {
>  =09.remove =3D vfio_ccw_sch_remove,
>  =09.shutdown =3D vfio_ccw_sch_shutdown,
>  =09.sch_event =3D vfio_ccw_sch_event,
> +=09.chp_event =3D vfio_ccw_chp_event,
>  };
> =20
>  static int __init vfio_ccw_debug_init(void)
