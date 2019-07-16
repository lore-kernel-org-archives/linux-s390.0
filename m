Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:39044 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbfGPPTz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jul 2019 11:19:55 -0400
From: Petr Tesarik <PTesarik@suse.com>
Subject: Re: [PATCH] s390: enable detection of kernel version from bzImage
Date: Tue, 16 Jul 2019 15:10:32 +0000
Message-ID: <20190716171019.0313d3d9@ezekiel.suse.cz>
References: <your-ad-here.call-01563228330-ext-8076@work.hours>
        <patch.git-94e9726bbfe5.your-ad-here.call-01563228538-ext-5706@work.hours>
        <20190716123006.2d426ec8@ezekiel.suse.cz>
        <your-ad-here.call-01563282698-ext-9575@work.hours>
In-Reply-To: <your-ad-here.call-01563282698-ext-9575@work.hours>
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
        boundary="Sig_/QOVQTxMmYG2vTcfhSUNHucV";
        protocol="application/pgp-signature"
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Philipp Rudo <prudo@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Raymund Will <rw@suse.com>

--Sig_/QOVQTxMmYG2vTcfhSUNHucV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jul 2019 15:11:38 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Tue, Jul 16, 2019 at 10:30:14AM +0000, Petr Tesarik wrote:
> > On Tue, 16 Jul 2019 00:12:19 +0200
> > Vasily Gorbik <gor@linux.ibm.com> wrote:
> >  =20
> > > Extend "parmarea" to include an offset of the version string, which is
> > > stored as 8-byte big endian value.
> > >=20
> > > To retrieve version string from bzImage reliably, one should check the
> > > presence of "S390EP" ascii string at 0x10008 (available since v3.2),
> > > then read the version string offset from 0x10428 (which has been 0
> > > since v3.2 up to now). The string is null terminated.
> > >=20
> > > Could be retrieved with the following "file" command magic (requires
> > > file v5.34):
> > > 8 string \x02\x00\x00\x18\x60\x00\x00\x50\x02\x00\x00\x68\x60\x00\x00=
\x50\x40\x40\x40\x40\x40\x40\x40\x40 Linux S390 =20
> > > >0x10008       string          S390EP   =20
> > > >>0x10428      bequad          >0   =20
> > > >>>(0x10428.Q) string          >\0             \b, version %s   =20
> > >=20
> > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com> =20
> >=20
> > This looks great! Much cleaner than the original approach.
> >=20
> > Thank you,
> > Petr T =20
>=20
> Then I'll add
> Reported-by: Petr Tesarik <ptesarik@suse.com>
> Suggested-by: Petr Tesarik <ptesarik@suse.com>
> if you don't mind and try to queue that for 5.3.

Oh, sure, please add these lines and go ahead.

Thank you again,
Petr T

--Sig_/QOVQTxMmYG2vTcfhSUNHucV
Content-Type: application/pgp-signature
Content-Description: =?unknown-8bit?q?Digit=C3=A1ln=C3=AD?= podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl0t6NsACgkQqlA7ya4P
R6d7Xwf+JNE4QIkYg1+FqAdL+wSIawGHgDsRlLflNNiFUtSyXFP6YQ2QiNVZkW6u
IAI8Q9hexXcHBcPttgIxoc7spvMxWnsUnfdy75BlyeUIpmArKUeoWyOoA4CycAuo
MIBwcXWkLv59+7VrZYCSHuquMjtRisnYLj7iwGshjLjlrT4BCfwboJozfGvjRDDB
1fbPen/3fnYtACRZWZ6lXrWHo+q0qdnGzi3Q3MtDRRgcn2NvMGk43V2Qf/KGJ7kf
WDpkJqqcLUS2yq9By7X6m3Exx/AimjomPgSJv43qJnHRKeRkCePX8g/0l0JcZxi3
FKC3BMjzl1UEuf1YZ2UwubO+6YvuNg==
=YyiZ
-----END PGP SIGNATURE-----

--Sig_/QOVQTxMmYG2vTcfhSUNHucV--
