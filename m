From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 05 Dec 2011 08:43:41 +0000
Subject: Re: s390-tools: zipl build fails with binutils-2.21+ on s390
Message-Id: <20111205094341.1e513163@de.ibm.com>
In-Reply-To: <201112050247.24855.vapier@gentoo.org>
References: <201112050247.24855.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--Sig_//6hcgcnXhz9U7OgylfmUbA+"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--Sig_//6hcgcnXhz9U7OgylfmUbA+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Dec 2011 02:47:24 -0500
Mike Frysinger <vapier@gentoo.org> wrote:

> after upgrading our s390 systems (-m31) to binutils-2.21.1, we noticed th=
e=20
> s390-tools package failed in the zipl code:
>=20
> gcc -O2 -pipe -W -Wall -Wno-unused-parameter  -W -Wall -Wno-unused-parame=
ter =20
> -W -Wall -Wno-unused-parameter  -DS390_TOOLS_RELEASE=3D1.15.0-build-20111=
205 -
> DS390_TOOLS_LIBDIR=3D/lib/s390-tools -DS390_TOOLS_SYSCONFDIR=3D/etc -
> DS390_TOOLS_RELEASE=3D1.15.0-build-20111205 -DS390_TOOLS_LIBDIR=3D/lib/s3=
90-tools=20
> -DS390_TOOLS_SYSCONFDIR=3D/etc -DS390_TOOLS_RELEASE=3D1.15.0-build-201112=
05 -
> DS390_TOOLS_LIBDIR=3D/lib/s390-tools -DS390_TOOLS_SYSCONFDIR=3D/etc -I../=
include -
> D__ASSEMBLY__ -
> DS390_TOOLS_VERSION_EBCDIC=3D0xf1,0x4b,0xf1,0xf5,0x4b,0xf0,0x60,0x82,0xa4=
,0x89,0x93,0x84,0x60,0xf2,0xf0,0xf1,0xf1,0xf1,0xf2,0xf0,0xf5=20
> -c -o eckd2dump.o eckd2dump.S
> eckd2dump.S: Assembler messages:
> eckd2dump.S:708: Error: Unrecognized opcode: `larl'
> eckd2dump.S:708: Error: Unrecognized opcode: `larl'
> make[2]: *** [eckd2dump.o] Error 1
>=20
> Debian fixed this by adding -m64 to CFLAGS in zipl's boot/Makefile.  is t=
his the=20
> right way to go ?  if so, could we get this added to the s390-tools packa=
ge ?

No, the bug is in dumpcommon.S where the 31 bit code section uses larl. Tha=
t is not
a good idea as this instruction is not available on old machines (pre z900).

--=20
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


--Sig_//6hcgcnXhz9U7OgylfmUbA+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO3IQ9AAoJELvpdr8mrl3SWusQALAnmB9GD83W7ebTagErU8ym
VsR/7Efh2skiPkiFNsi1WoPBqHXT5j9t20maKLPgX12vdQkAWPajFYRkJ11Tsaka
zJiOw/blC2LFCmEv61wxwuK7lRVn8D1BQDXyzXJJl63LRPs3ccSI44IBLkD1iO4B
WZP7tuuTapw4evMa2HZ4gjo2P6UDDrJh+l0N7ODqauEoM33aLX8DqMnawvS8Ag2X
86Dl80LcQpab+DZ1vzCPVUm8e7sWg8vj6ZpNDAsQ4sm8xusiju71YhQwZiEoy3Dq
FLrFhP7Y/G8n7LT0eJTepzm3oM8YoARiDgiwDo9f7Sf7ST5pf9Vy9Y1yDUZhNxwz
81M0+wwpD8svxHcgDxCNrjCPE/rlIq2CW3D84UfTRjPBb5Epk2GYKomGaJnQdqfY
ZPj2H/3EQbYAD11cY0+1Z/OUmCsb+37KIO2xwNza1g12hDxcV2S5D1mwmhHPKKWj
FgYNaR1x7Klv4GqR2dyh67kSTaDCvORGl4SKiL5MwQN3VhlND+HuESraRHM2dYD9
EJClGhXN/Y+cqtCGtzXizlbzrBvUJIqPznJegh+XXdZ4MJnFw1J1p4U9i4YLuZOW
VWQ+xsl91zyKTrNEWRWwKDOKYtOI/MpXGjLy1koXbicBKOPgG+ddJuB4c4D8oDFq
Z4OC1cvRTgbklZ7GmiLe
=lCUb
-----END PGP SIGNATURE-----

--Sig_//6hcgcnXhz9U7OgylfmUbA+--
