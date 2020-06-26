Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728683AbgFZHxJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Jun 2020 03:53:09 -0400
Subject: Re: [PATCH v2 0/2] s390: Add API Docs for DIAGNOSE 0x318 and fix rst
References: <20200625150724.10021-1-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <1c737c33-24e3-82c5-a514-3931e6f9bb5a@linux.ibm.com>
Date: Fri, 26 Jun 2020 09:53:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200625150724.10021-1-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ms35jRd0TPvx7oMlttJBslfaZq6dLGTq6"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ms35jRd0TPvx7oMlttJBslfaZq6dLGTq6
Content-Type: multipart/mixed; boundary="0a4vBZZE3h9P6sG4TWnhjJZjvAJhes9ms"

--0a4vBZZE3h9P6sG4TWnhjJZjvAJhes9ms
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/25/20 5:07 PM, Collin Walling wrote:
> Changelog:
>=20
>     v2
>=20
>     =E2=80=A2 Reworded patch 1 doc text
>=20
>     =E2=80=A2 Added "Introduced in commit..." for rst fix patch
>=20
>     =E2=80=A2 Added r-b's (thanks!)
>=20
> Adds documentation for the s390-specfic DIAGNOSE 0x318 instruction, as
> well as fixes some missing rst symbols for the neighboring entries.
>=20
> Suggested-by: Cornelia Huck <cohuck@redhat.com>

thanks, applied

>=20
> Collin Walling (2):
>   docs: kvm: add documentation for KVM_CAP_S390_DIAG318
>   docs: kvm: fix rst formatting
>=20
>  Documentation/virt/kvm/api.rst | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20



--0a4vBZZE3h9P6sG4TWnhjJZjvAJhes9ms--

--Ms35jRd0TPvx7oMlttJBslfaZq6dLGTq6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl71qV0ACgkQ41TmuOI4
ufhujhAAkJ0dxtwLTvboDRrmHcYYQHIPcxXMScS1zOBW0AScNun7VtjvFUTdE2fT
vsdEVtHD05z2uVSLruMl4sDMMjDH3jyLabP0UEhdmSWyVe10sLDpMcro62lHEbE4
vp1VrTPI9YquUPUaHNECVGJ7jinWR60ERf+ZcruXc7WzhdLfvR6e1X+VR/9SiheL
AyJ3gQpcTXu7f845y2fNXyVjrZIZnLwRPibNP+tiWS1nKp99A23UvwwtZevGYKGw
9O+bBpcqr4uiyDCS5s7Oh6wa9V2Y9OPtA9j5D9h5smb5rOM+AO/EWxleOP2KL/7g
KAD5uh8iwTRWj/S4dt3qblShE1RR91KqMPwj+jO+73XHJUyGl6l53wV9L3hAagyL
guXqe1ciXu/Hu63L06tDcroiM88kvJyswLxwBZFEM+q8p+khAdHccSgsT2AN4QMX
kpo3vLgDdj9Mk1u126ei5dW0g1xla8jGP45zILhsoyWkPp5/j+LpxeOBP5D1x6dW
R4fbAINSkdhDfd2rJMunSSkRvsf5Ch49Aq0knDq/KxIjsR6EY5x3RgfmOaXMSYAV
hHKQDlB9sek8sVSQE9kRzwfNV1DWtsdlcMLBxCQFExYdCBeucCTJaNHCFoTdpL/B
8IB/klBsiwTnbpcuBwXvh9Cj5fSXE/DSjVyxMKTmMOaQk1d7jpA=
=apDD
-----END PGP SIGNATURE-----

--Ms35jRd0TPvx7oMlttJBslfaZq6dLGTq6--
