Return-Path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120827090354.GA5840@osiris.de.ibm.com>
References: <1346052196-32682-1-git-send-email-gaowanlong@cn.fujitsu.com> <1346052196-32682-6-git-send-email-gaowanlong@cn.fujitsu.com> <20120827090354.GA5840@osiris.de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] s390:block:fix up ENOIOCTLCMD error handling
From: Stefan Weinhuber <WEIN@de.ibm.com>
Message-ID: <OFA9F14DCC.A1DFDC50-ONC1257A67.0038C99B-C1257A67.003947D3@de.ibm.com>
Date: Mon, 27 Aug 2012 12:25:32 +0200
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: heicars2@linux.vnet.ibm.com
Cc: BOEBLINGEN LINUX390 <LINUX390@de.ibm.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-kernel@vger.kernel.org, "open list:S390" <linux-s390@vger.kernel.org>, mschwid2@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

heicars2@linux.vnet.ibm.com wrote on 2012-08-27 11:03:55:

[..]
>=20
> Thanks, but you missed the else path. I'm going to commit the patch=20
below
> unless Stefan has any objections:
>=20
> From dac16bd8b314dc6f3f4e6815feab199fdfc8cddd Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> Date: Mon, 27 Aug 2012 10:59:42 +0200
> Subject: [PATCH] s390/dasd: fix ioctl return value
>=20
> For unimplemented ioctls the dasd driver should return -ENOTTY.
>=20
> Reported-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c  | 2 +-
>  drivers/s390/block/dasd_ioctl.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/s390/block/dasd_eckd.c=20
b/drivers/s390/block/dasd_eckd.c
> index 40a826a..2fb2b9e 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -3804,7 +3804,7 @@ dasd_eckd_ioctl(struct dasd_block *block,=20
> unsigned int cmd, void __user *argp)
>     case BIODASDSYMMIO:
>        return dasd_symm_io(device, argp);
>     default:
> -      return -ENOIOCTLCMD;
> +      return -ENOTTY;
>     }
>  }
>=20
> diff --git a/drivers/s390/block/dasd_ioctl.c=20
b/drivers/s390/block/dasd_ioctl.c
> index cceae70..654c692 100644
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
> @@ -498,12 +498,9 @@ int dasd_ioctl(struct block_device *bdev, fmode_t=20
mode,
>        break;
>     default:
>        /* if the discipline has an ioctl method try it. */
> -      if (base->discipline->ioctl) {
> +      rc =3D -ENOTTY;
> +      if (base->discipline->ioctl)
>           rc =3D base->discipline->ioctl(block, cmd, argp);
> -         if (rc =3D=3D -ENOIOCTLCMD)
> -            rc =3D -EINVAL;
> -      } else
> -         rc =3D -EINVAL;
>     }
>     dasd_put_device(base);
>     return rc;
> --=20
> 1.7.11.5
>=20

The patch is looking fine to me, thanks.

Mit freundlichen Gr=FC=DFen / Kind regards
=20
Stefan Weinhuber
