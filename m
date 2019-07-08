Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:51465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfGHLUh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 8 Jul 2019 07:20:37 -0400
Date: Mon, 8 Jul 2019 21:20:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Jul 4 -> conflict between s390 and
 driver-core tree
Message-ID: <20190708212030.4540f81b@canb.auug.org.au>
In-Reply-To: <e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com>
References: <20190704220945.27728dd9@canb.auug.org.au>
        <e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/E+fA_B45RM4/Jdz2PL=40nh"; protocol="application/pgp-signature"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>

--Sig_/E+fA_B45RM4/Jdz2PL=40nh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, 5 Jul 2019 10:59:01 +0200 Christian Borntraeger <borntraeger@de.ibm=
.com> wrote:
>
> Linus, Vasily, for your attention in the next merge window. (I would sugg=
est to apply
> belows fixup during the merge of whatever tree is merged 2nd).
>=20
>=20
> There is now a build conflict between the s390/features branch and the dr=
iver-core/driver-core-next
> especially between
>=20
> commit 92ce7e83b4e5 ("driver_find_device: Unify the match function with c=
lass_find_device()")
> and
> commit ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kerne=
l")

I have applied the suggested fix below to linux-next today and will
apply it to the driver-core tree merge from now on.

> Stephen, can you maybe add something like this to make linux-next build a=
gain
> on s390?
>=20
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 2c9fb1423a39..7e85ba7c6ef0 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -26,7 +26,7 @@
> =20
>  static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
> =20
> -static int match_apqn(struct device *dev, void *data)
> +static int match_apqn(struct device *dev, const void *data)
>  {
>  	struct vfio_ap_queue *q =3D dev_get_drvdata(dev);
> =20
>=20



--=20
Cheers,
Stephen Rothwell

--Sig_/E+fA_B45RM4/Jdz2PL=40nh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0jJv4ACgkQAVBC80lX
0Gzj2wgAireRW4yZvEvuHNIGpIEiUp8XMbmrYdVXI3lf9VSTOAleq7vsS4RgX9tl
0cLg6vbumKyUEB/3DPtQdSobmAaJ16+2jEzOpAl4JYCLprowO5KmT1WfcohiQEhu
HDyi598H17GAdV1vr6ME2jcp9GzPTJutoU9kTFww3ljAyl4TXs1lHuvqnF5xU61V
Er2LB0Ki1wcd7yV0B1+uS/bYdMaXQGRGMEWAzD6gTSZzgjE8L2N86FXlfMfw/kPZ
B4cEey5t7TtnnydGexQEcm7W6eiB93MamYowlUMck+GkAM9NOomQuS7j0AmDnxNy
xEng27jlup2og3xq/BYL5HJetvJFJw==
=Rczw
-----END PGP SIGNATURE-----

--Sig_/E+fA_B45RM4/Jdz2PL=40nh--
