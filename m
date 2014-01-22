From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 22 Jan 2014 18:30:29 +0000
Subject: Re: linux-3.10+: unable to boot 31bit builds
Message-Id: <201401221330.30404.vapier@gentoo.org>
In-Reply-To: <20140122075536.GA4202@osiris>
References: <20140122075536.GA4202@osiris>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--nextPart1423859.M7Oc5BVCEB"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--nextPart1423859.M7Oc5BVCEB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 22 January 2014 02:55:36 Heiko Carstens wrote:
> With all three patches within this thread s390 with CONFIG_64BIT=3Dn ipl's
> again, and the 32 bit native statfs64 syscall works as well.

indeed, with those in hand, my system now boots :)

> However I would strongly suggest to use CONFIG_64BIT=3Dy with CONFIG_COMP=
AT=3Dy
> instead for (now) obvious reasons ;)

this VM is meant for development, so if it helps catch bugs like this, i th=
ink=20
i'll keep it as-is.  thanks!
=2Dmike

--nextPart1423859.M7Oc5BVCEB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJS4A5GAAoJEEFjO5/oN/WBmdEP/iFnfTLmUtcifURlje231qBA
KOfEhcmMO+rP/Tno1xLgkPz1bMQcDWHG8ORLsfv61ZMJumzhqdjd0Xud3nH97iM9
2qMZljIzH+C+ppVSmvgRxkkK4dCX2jWTEavipz6FsUwzZaJJorfMybm/rDYli3Yh
dkgEAPUhjkYjmmzaoaudKugXtp3TOqiJccP14aIsX5C+vY4gWxSPjSh6yfWx/+C4
bVNQwGxM4MwXnjNQG8DY5Uze9X87E+FvAnXZtQa/omTC4zQxK0kqrJJZeoz+r/f8
lX2C0s1vifi0Q4LWbf7ONlioEkWFKy7GxwnbD84rxtpSYd9XdJGeT34NzJGfbR7I
ttXga3KOKV7Wgz+tvh5J3XE1v06KvbGFX3qz7EZi96A/OhReiYcHLArJ7Xj8F1Dy
vmnE3vyK10jO4nf/3jSI5XxC5Mv33j1D0o5HYgvbfACoU5jp17n7skfruwR6nTAL
uv1MTDeTiEUV1Kx720EjytrpwURQUYjl5F85kHXIIYDwmr0859dZJGmWXqCmQDHy
6AaU2NRVszk83qrZncPw3WFj2g6HKgE1SrN7V0Yb6Vv/k70zfe2Hw4QVqxWocWM6
T0aePeqOCJDdQ6QvutrJRnbTfGsk5yGTfu45OuG5h4gkJpvrN35fgaUhh4hAUW3K
sxsgPm65Fo4WPcQv7Jle
=/dvf
-----END PGP SIGNATURE-----

--nextPart1423859.M7Oc5BVCEB--
