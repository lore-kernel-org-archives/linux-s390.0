Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:56955 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTH0H (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 03:26:07 -0400
Date: Mon, 20 Apr 2020 17:25:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Tree for Apr 20
Message-ID: <20200420172559.7b6dc5f1@canb.auug.org.au>
In-Reply-To: <2d87a4f9-9d87-e929-9b03-31f92dad5ca6@de.ibm.com>
References: <20200420142610.390e5922@canb.auug.org.au>
        <2d87a4f9-9d87-e929-9b03-31f92dad5ca6@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nsiZCIx22N7QTYaG_qWGcT.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-s390 <linux-s390@vger.kernel.org>, Hadar Gat <hadar.gat@arm.com>

--Sig_/nsiZCIx22N7QTYaG_qWGcT.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Apr 2020 09:14:15 +0200 Christian Borntraeger <borntraeger@de.ib=
m.com> wrote:
>
> s390 defconfig still does not compile. While the media kconfig problem is=
 gone I now have
>=20
>   CC [M]  drivers/char/hw_random/cctrng.o
> drivers/char/hw_random/cctrng.c: In function =E2=80=98cc_trng_compwork_ha=
ndler=E2=80=99:
> drivers/char/hw_random/cctrng.c:334:49: error: =E2=80=98fips_enabled=E2=
=80=99 undeclared (first use in this function); did you mean =E2=80=98vdso_=
enabled=E2=80=99?
>   334 |  if (CC_REG_FLD_GET(RNG_ISR, CRNGT_ERR, isr) && fips_enabled) {
>       |                                                 ^~~~~~~~~~~~
>       |                                                 vdso_enabled
> drivers/char/hw_random/cctrng.c:334:49: note: each undeclared identifier =
is reported only once for each function it appears in
> drivers/char/hw_random/cctrng.c:335:3: error: implicit declaration of fun=
ction =E2=80=98fips_fail_notify=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>   335 |   fips_fail_notify();
>       |   ^~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
> Can we maybe make this driver depend on ARM?

Caused by commit

  a583ed310bb6 ("hwrng: cctrng - introduce Arm CryptoCell driver")

which has neglected to include linux/fips.h ...

--=20
Cheers,
Stephen Rothwell

--Sig_/nsiZCIx22N7QTYaG_qWGcT.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6dTocACgkQAVBC80lX
0Gy81gf/WJ4AlMZZfY9lStGjc/+IIXvqC9ZjIuTV7NNS21twzwLU0p65Dv3ARscH
nGIJKpCXvhMGjzrxbFJHCf4oBO+b3Q57hB2RXeCbuetpYkxFi/d8Z9zWjigALGwD
TKMuDQUjlsV0VPra0G/YV+Qsr3xjR6q61Zz1nldhehpYkkmlQwT77hxBuqJYOjWe
8PVao1gyoFcy3fWr6DXZRrlgRE/QTTAWoypQuGnCFg5iUgnlwXwXWE6AHnY4pxcP
BJAsu+uKgf+lKLHsVQqdFGBTHVptKwx00SLUxhoMS8TH73H1IndUlYKKfIIopHcy
zRBXR/Q65yhWhUj4X/pkrNJdDt1KhQ==
=mzcp
-----END PGP SIGNATURE-----

--Sig_/nsiZCIx22N7QTYaG_qWGcT.--
