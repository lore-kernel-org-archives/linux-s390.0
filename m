From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 05 Dec 2011 18:55:20 +0000
Subject: Re: [PATCH] zipl: Do not use larl for 31 bit code
Message-Id: <201112051355.21528.vapier@gentoo.org>
In-Reply-To: <1323110414.13642.6.camel@br98xy6r>
References: <1323110414.13642.6.camel@br98xy6r>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--nextPart3879648.5j58r6OZdd"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--nextPart3879648.5j58r6OZdd
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 05 December 2011 13:40:14 Michael Holzheu wrote:
> On Mon, 2011-12-05 at 10:44 -0500, Mike Frysinger wrote:
> > On Monday 05 December 2011 09:19:39 Michael Holzheu wrote:
> > > Hi Mike,
> > >=20
> > > You reported a zipl build problem for 31 bit:
> > > http://marc.info/?l=3Dlinux-s390&m=3D132307473025493&w=3D2
> >=20
> > > The following patch (for s390-tools-1.15.0) should fix this problem:
> > it fixes most of them, but seems there's still one left :)
>=20
> Ok, try this one:

we've got a winner :).  thanks!

>>> Installing (1 of 1) sys-apps/s390-tools-1.15.0
=2Dmike

--nextPart3879648.5j58r6OZdd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO3ROZAAoJEEFjO5/oN/WBfJkP/0d7nHfGqAWtU6+m9bA9Tu+N
NVROKOFFq+fVfQyALQFff8WL0X4D6jYGQWUPUJaJcghqjM5rl5L/59nZWSay587I
ElIm3eBJEik4gpoIDt7cCBsrlcZTgooIWo42gRkPwA2izHY9zg8EhURVyRhw3y2x
mQuI2p0sgrQzw2BK99QQaXvSYVPYAxfarlZQiTfCaPpWCtaiMOXKnlen0UEzKzhY
Wufg0Um8oXxqgp4XfjhLEs8sS0oUNnjImojW2NdfglaN0qJLafjJp5VpD6nbD4ZA
3ONaWUMZcrWBpujdjqE56CcphHB0QMYGNgEx40A3FEwXOKXV7J+28CGdMcASfaOi
rC07/Jq+XxCZYNoz7hvxuIbm+iQA8AaHYaO3R6Y4QjMCAhy9UxnrrgIm34/O2AUZ
tXqpkiT0Tq7SIF+vQWs13cfFjiabWxi6P2hTC2kzJOTNjcR5dPIpdA3Av3+WYvIA
HYEjS/hX7MdK9EeDIAXsrOLdqRAY7djYfijFTvvEW65s2rBqOzYwaaFt8uxXdcDU
JYmGrsr+09K3dWou4h5K3TUvHB8rGH5gi2F4Faoy7kpilrufR3YJ2oWHA3mR66aN
TiLkgD3cOOnPncP5QbeM63FcyrFlg4+CHYPIH0Olo+u2BAoumgUOc6/5j7m7zHzm
SxxYfQVUrlxSBvn04KAP
=1pE9
-----END PGP SIGNATURE-----

--nextPart3879648.5j58r6OZdd--
