Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16282 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726993AbgGUNMB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jul 2020 09:12:01 -0400
Subject: Re: [kvm-unit-tests PATCH v13 0/9] s390x: Testing the Channel
 Subsystem I/O
References: <1594887809-10521-1-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <3000fa45-2273-5ca3-f4fd-2aac5edf7c5a@linux.ibm.com>
Date: Tue, 21 Jul 2020 15:11:53 +0200
MIME-Version: 1.0
In-Reply-To: <1594887809-10521-1-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZyXOvTUTP9Fn6MPQEiv8Tq2eVqjiFlluY"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, drjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZyXOvTUTP9Fn6MPQEiv8Tq2eVqjiFlluY
Content-Type: multipart/mixed; boundary="y3JPpbATEgTWNhs3bOFLoYwFC1heqkXvP"

--y3JPpbATEgTWNhs3bOFLoYwFC1heqkXvP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/16/20 10:23 AM, Pierre Morel wrote:
> Hi All,
>=20
> This new respin of the series add modifications to
> - patch 9: s390x: css: ssch/tsch with sense and interrupt
> Other patches did not change.
>=20
> Recall:
>=20
> Goal of the series is to have a framework to test Channel-Subsystem I/O=
 with
> QEMU/KVM.
>  =20
> To be able to support interrupt for CSS I/O and for SCLP we need to mod=
ify
> the interrupt framework to allow re-entrant interruptions.
>  =20
> We add a registration for IRQ callbacks to the test program to define i=
ts own
> interrupt handler. We need to do special work under interrupt like ackn=
owledging
> the interrupt.
>  =20
> This series presents three tests:
> - Enumeration:
>         The CSS is enumerated using the STSCH instruction recursively o=
n all
>         potentially existing channels.
>         Keeping the first channel found as a reference for future use.
>         Checks STSCH
> =20
> - Enable:
>         If the enumeration succeeded the tests enables the reference
>         channel with MSCH and verifies with STSCH that the channel is
>         effectively enabled, retrying a predefined count on failure
> 	to enable the channel
>         Checks MSCH      =20
> =20
> - Sense:
>         If the channel is enabled this test sends a SENSE_ID command
>         to the reference channel, analyzing the answer and expecting
>         the Control unit type being 0x3832, a.k.a. virtio-ccw.
>         Checks SSCH(READ) and IO-IRQ
>=20
> Note:
> - The following 5 patches are general usage and may be pulled first:
>   s390x: saving regs for interrupts
>   s390x: I/O interrupt registration
>   s390x: export the clock get_clock_ms() utility
>   s390x: clock and delays calculations
>   s390x: define function to wait for interrupt
>=20
> - These 4 patches are really I/O oriented:
>   s390x: Library resources for CSS tests
>   s390x: css: stsch, enumeration test
>   s390x: css: msch, enable test
>   s390x: css: ssch/tsch with sense and interrupt
>=20
> Regards,
> Pierre

Thanks, picked

>=20
> Pierre Morel (9):
>   s390x: saving regs for interrupts
>   s390x: I/O interrupt registration
>   s390x: export the clock get_clock_ms() utility
>   s390x: clock and delays calculations
>   s390x: define function to wait for interrupt
>   s390x: Library resources for CSS tests
>   s390x: css: stsch, enumeration test
>   s390x: css: msch, enable test
>   s390x: css: ssch/tsch with sense and interrupt
>=20
>  lib/s390x/asm/arch_def.h |  14 ++
>  lib/s390x/asm/time.h     |  50 ++++++
>  lib/s390x/css.h          | 294 +++++++++++++++++++++++++++++++++++
>  lib/s390x/css_dump.c     | 152 ++++++++++++++++++
>  lib/s390x/css_lib.c      | 323 +++++++++++++++++++++++++++++++++++++++=

>  lib/s390x/interrupt.c    |  23 ++-
>  lib/s390x/interrupt.h    |   8 +
>  s390x/Makefile           |   3 +
>  s390x/css.c              | 150 ++++++++++++++++++
>  s390x/cstart64.S         |  41 ++++-
>  s390x/intercept.c        |  11 +-
>  s390x/unittests.cfg      |   4 +
>  12 files changed, 1060 insertions(+), 13 deletions(-)
>  create mode 100644 lib/s390x/asm/time.h
>  create mode 100644 lib/s390x/css.h
>  create mode 100644 lib/s390x/css_dump.c
>  create mode 100644 lib/s390x/css_lib.c
>  create mode 100644 lib/s390x/interrupt.h
>  create mode 100644 s390x/css.c
>=20



--y3JPpbATEgTWNhs3bOFLoYwFC1heqkXvP--

--ZyXOvTUTP9Fn6MPQEiv8Tq2eVqjiFlluY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8W6ZkACgkQ41TmuOI4
ufiyRw/+MB+u0jg5fpYEgzxYMkkT6Gs/42LqNsXgI6csqK15E0qTpp0gCT8TRBuw
YMr6zNQd3SR2umnz6SG2WdfzNe66lpNlpUK14Y6ajT455haufascmAOj2dGNc4F/
4owWLz/nqYWAV02pVH0WxvQadZ+c+jrxYpwNsSGe+NsyTL1pqPfIgsfwM0tY0+KH
U6WIEjCpe8rTOXDR9y3kAnOGY1ymAf4SA61PKlYEr1xdFfN+y4IYv/UOBaR6F7jM
LCJre+d262ibUETC+n/JYdBpuKefhUponX1M38wjnXlzwHR9Oy2oHmzYkWLpLG8B
gbI1oT3a4s2yWj1e8tcuy4vRWJ89nvejmh4w4ON8rrb4sYVpsWwDsfaM1XlFmRFK
IgvoRaPURD1Y0lrORGdZimBHGQnsOOotfGyt/p5f5ZSK8tTj8odxhP+sjIF6xpI3
Dpei24kEl3Kf6eOsqeUgdNrD6qcZkYe7ShCQJqzkTT9AC24BS/65bEvOO5YGSgao
HtJVo88HigLWuMJLA3dyOL77TRY4vXZD1uI+/xHcT2+NXOi8CtM3th3E2ZSkLw8w
lTWJ1RF1B/SCtrTdugQyN1IUHV6HajuUCi4GBCvdTofl8n/+/3Pi41pBPRDHB4wZ
PKmqLdX8tsowl8HcWCjaWhUPMOUGQDc1AbgLHJDjr9uUS6Cz8uw=
=CjRC
-----END PGP SIGNATURE-----

--ZyXOvTUTP9Fn6MPQEiv8Tq2eVqjiFlluY--
