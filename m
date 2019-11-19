Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56943 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727212AbfKSQxD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Nov 2019 11:53:03 -0500
Date: Tue, 19 Nov 2019 17:52:53 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 05/10] vfio-ccw: Introduce a new schib region
Message-ID: <20191119175253.3e688369.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-6-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-6-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:15 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> The schib region can be used by userspace to get the SCHIB for the
> passthrough subchannel. This can be useful to get information such
> as channel path information via the SCHIB.PMCW.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - Clean up checkpatch (#include, whitespace) errors
>      - Remove unnecessary includes from vfio_ccw_chp.c
>      - Add ret=3D-ENOMEM in error path for new region
>      - Add call to vfio_ccw_unregister_dev_regions() during error exit
>        path of vfio_ccw_mdev_open()
>      - New info on the module prologue
>      - Reorder cleanup of regions
>=20
>  drivers/s390/cio/Makefile           |  2 +-
>  drivers/s390/cio/vfio_ccw_chp.c     | 75 +++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_drv.c     | 20 ++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 14 +++++-
>  drivers/s390/cio/vfio_ccw_private.h |  3 ++
>  include/uapi/linux/vfio.h           |  1 +
>  include/uapi/linux/vfio_ccw.h       |  5 ++
>  7 files changed, 117 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/s390/cio/vfio_ccw_chp.c
>=20

> diff --git a/include/uapi/linux/vfio_ccw.h b/include/uapi/linux/vfio_ccw.=
h
> index cbecbf0cd54f..7c0a834e5d7a 100644
> --- a/include/uapi/linux/vfio_ccw.h
> +++ b/include/uapi/linux/vfio_ccw.h
> @@ -34,4 +34,9 @@ struct ccw_cmd_region {
>  =09__u32 ret_code;
>  } __packed;
>

Let's add a comment:
- that reading this region triggers a stsch()
- that this region is guarded by a capability

?
 =20
> +struct ccw_schib_region {
> +#define SCHIB_AREA_SIZE 52
> +=09__u8 schib_area[SCHIB_AREA_SIZE];
> +} __packed;
> +
>  #endif

Seems sane; but I need to continue reading this and the QEMU series to
see how it is used.

Oh, and please update Documentation/s390/vfio-ccw.rst :)
