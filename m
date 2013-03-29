From: Tim Blechmann <tim@klingt.org>
Date: Fri, 29 Mar 2013 11:29:11 +0000
Subject: Re: sound/pci/lx6464es/lx6464es.c:557:2: error: implicit declaration of function 'ioport_unmap'
Message-Id: <51557B07.1070404@klingt.org>
In-Reply-To: <20130329015630.GA9085@localhost>
References: <20130329015630.GA9085@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------enig2NTJKVKUPKROLOJLNTBDN"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NTJKVKUPKROLOJLNTBDN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,

> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux ma=
ster
> head:   9064171268d838b8f283fe111ef086b9479d059a
> commit: 02bec490450836ebbd628e97ec03f10b57def8ce ALSA: lx6464es - drive=
r for the digigram lx6464es interface
> date:   3 years, 11 months ago
> config: make ARCH=3Ds390 allmodconfig
>=20
> All error/warnings:
>=20
>    sound/pci/lx6464es/lx6464es.c: In function 'snd_lx6464es_free':
>    sound/pci/lx6464es/lx6464es.c:556:2: error: implicit declaration of =
function 'iounmap' [-Werror=3Dimplicit-function-declaration]
>>> sound/pci/lx6464es/lx6464es.c:557:2: error: implicit declaration of f=
unction 'ioport_unmap' [-Werror=3Dimplicit-function-declaration]
>    sound/pci/lx6464es/lx6464es.c: In function 'snd_lx6464es_create':
>    sound/pci/lx6464es/lx6464es.c:984:30: error: 'DMA_32BIT_MASK' undecl=
ared (first use in this function)
>    sound/pci/lx6464es/lx6464es.c:984:30: note: each undeclared identifi=
er is reported only once for each function it appears in
>>> sound/pci/lx6464es/lx6464es.c:1020:2: error: implicit declaration of =
function 'ioport_map' [-Werror=3Dimplicit-function-declaration]
>    sound/pci/lx6464es/lx6464es.c:1020:26: warning: assignment makes poi=
nter from integer without a cast [enabled by default]
>    sound/pci/lx6464es/lx6464es.c: In function 'snd_lx6464es_probe':
>    sound/pci/lx6464es/lx6464es.c:1094:2: warning: 'snd_card_new' is dep=
recated (declared at include/sound/core.h:304) [-Wdeprecated-declarations=
]
>    cc1: some warnings being treated as errors

i'm not really familiar with the s390 architecture. are the specific
functions declared in a different header or are they not available at
all? in the second case, i'd suggest to disable this driver on this
architecture, as it seems highly unlikely that anyone is going to use
this hardware on this architecture (it would not surprise me, if i'm the
only user of this hardware on linux)

cheers,
tim



------enig2NTJKVKUPKROLOJLNTBDN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EAREIAAYFAlFVewcACgkQMLNj2qIwZ4X5rgD+Ma7RsI0cIKOv733tPfBf/2SL
x1gXC4Uc+/zztNhn/hsBAJPNmMBIeU5aMJW+FrEYG61WZPCfVuRhbIHvDZELSWNJ
=uPxJ
-----END PGP SIGNATURE-----

------enig2NTJKVKUPKROLOJLNTBDN--
