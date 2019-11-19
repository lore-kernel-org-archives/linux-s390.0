Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35081 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727255AbfKSNAz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 08:00:55 -0500
Date: Tue, 19 Nov 2019 14:00:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 03/10] vfio-ccw: Use subchannel lpm in the orb
Message-ID: <20191119140046.4b81edd8.cohuck@redhat.com>
In-Reply-To: <20191115025620.19593-4-farman@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-4-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 15 Nov 2019 03:56:13 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> The subchannel logical path mask (lpm) would have the most
> up to date information of channel paths that are logically
> available for the subchannel.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - None; however I am greatly confused by this one.  Thoughts?

I think it's actually wrong.

>=20
>  drivers/s390/cio/vfio_ccw_cp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 3645d1720c4b..d4a86fb9d162 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -779,9 +779,7 @@ union orb *cp_get_orb(struct channel_program *cp, u32=
 intparm, u8 lpm)
>  =09orb->cmd.intparm =3D intparm;
>  =09orb->cmd.fmt =3D 1;
>  =09orb->cmd.key =3D PAGE_DEFAULT_KEY >> 4;
> -
> -=09if (orb->cmd.lpm =3D=3D 0)
> -=09=09orb->cmd.lpm =3D lpm;

In the end, the old code will use the lpm from the subchannel
structure, if userspace did not supply anything to be used.

> +=09orb->cmd.lpm =3D lpm;

The new code will always discard any lpm userspace has supplied and
replace it with the lpm from the subchannel structure. This feels
wrong; what if the I/O is supposed to be restricted to a subset of the
paths?

If we want to include the current value of the subchannel lpm in the
requests, we probably want to AND the masks instead.

> =20
>  =09chain =3D list_first_entry(&cp->ccwchain_list, struct ccwchain, next)=
;
>  =09cpa =3D chain->ch_ccw;
