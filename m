Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727852AbgHKHbk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Aug 2020 03:31:40 -0400
Subject: Re: [kvm-unit-tests PATCH v2 0/3] PV tests part 1
From: Janosch Frank <frankja@linux.ibm.com>
References: <20200807111555.11169-1-frankja@linux.ibm.com>
Message-ID: <8ba7de43-8195-9492-e973-1474cd75933c@linux.ibm.com>
Date: Tue, 11 Aug 2020 09:29:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200807111555.11169-1-frankja@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v1wZa1O4xnNrXARbCuZXaPDVNQZPq5XfV"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v1wZa1O4xnNrXARbCuZXaPDVNQZPq5XfV
Content-Type: multipart/mixed; boundary="P3brhPKYLoiYnSsMc5aC4gmvVjX2BmL6m"

--P3brhPKYLoiYnSsMc5aC4gmvVjX2BmL6m
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/7/20 1:15 PM, Janosch Frank wrote:
> Let's start bringing in some more PV related code.
>=20
> Somehow I missed that we can also have a key in a exception new
> PSW. The interesting bit is that if such a PSW is loaded on an
> exception it will result in a specification exception and not a
> special operation exception.
>=20
> The third patch adds a basic guest UV call API test. It has mostly
> been used for firmware testing but I also think it's good to have a
> building block like this for more PV tests.
>=20
>=20
> GIT: https://gitlab.com/frankja/kvm-unit-tests/-/tree/queue

Picked the series onto:
https://gitlab.com/frankja/kvm-unit-tests/-/commits/next

>=20
>=20
> v2:
> 	* Renamed pgm_int_func to pgm_cleanup_func() and moved the call to han=
dle_pgm_int()
> 	* Added page allocation to UV test
> 	* Cleanups
>=20
> Janosch Frank (3):
>   s390x: Add custom pgm cleanup function
>   s390x: skrf: Add exception new skey test and add test to unittests.cf=
g
>   s390x: Ultravisor guest API test
>=20
>  lib/s390x/asm/interrupt.h |   1 +
>  lib/s390x/asm/uv.h        |  74 +++++++++++++++++
>  lib/s390x/interrupt.c     |  12 ++-
>  s390x/Makefile            |   1 +
>  s390x/skrf.c              |  79 +++++++++++++++++++
>  s390x/unittests.cfg       |   7 ++
>  s390x/uv-guest.c          | 162 ++++++++++++++++++++++++++++++++++++++=

>  7 files changed, 335 insertions(+), 1 deletion(-)
>  create mode 100644 lib/s390x/asm/uv.h
>  create mode 100644 s390x/uv-guest.c
>=20



--P3brhPKYLoiYnSsMc5aC4gmvVjX2BmL6m--

--v1wZa1O4xnNrXARbCuZXaPDVNQZPq5XfV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8ySMgACgkQ41TmuOI4
ufgeURAAxt6i14y23K/04ATfEcjepJdVVKyygae687fkwSXYP4Aelp3biKXUpXKo
pNJ2dUFMhSYpMLO7ibCPLJKCmDPw60Yhr3eqqsdBC1JqtEJihGhbYRX23s1rYh/Z
YIgW+oEySvnTHzUA1H1F/1TzacxvFkvjMSHzt/qNwKVCKpYfLbxPKeQQ5kHU+BxY
ETQbSR/DqCQL8X5dXcLteXhR4eEfHt9VGnAuMYNwZuTM8LdV/osfI9v4X+rP9n6f
3PqRbcHUX3e72Ll6yeun/moC2ARCa64xHFh/RTTwz7C4Z/bEIb2xUsMTlse0HY3A
PQcDCLHOLV4SKrKUaheP+bQ9sNQQXusPNYqeKpTsNCRc5Tm23CxC6iBBWAHRYtTX
T09uBlCjUo/g+Kyc21JlxTib0DeFqoXQH06Zx55u2BeX4mRVFFIoOkf2S6wkxoNy
sLGmPgRJYwYX6qPVI5M+1aIzJjubIzyfRtkH4q7KyADr9l+tILYvfEDc6b2ZMQuX
3oTzzgwC4x+TgItkLQh05symeT+N5FD6cCJ6JgSGJLncVlltmrfRwBdSeo/lCxcC
CZ/G9U2lBjdoPYhceki9SjuWOS5Idu3mw+lgaUYsf4WPrTa3iVzfLPVLE/p6+N4w
U4WV2KHSrEK+bRsrDAP/ctNQv8RfAC7d64lzfdL3VbTGW/HymHw=
=8U8B
-----END PGP SIGNATURE-----

--v1wZa1O4xnNrXARbCuZXaPDVNQZPq5XfV--
