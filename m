Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59290 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732104AbgGaLbK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 07:31:10 -0400
Subject: Re: [kvm-unit-tests GIT PULL 00/11] s390x patches
References: <20200731094607.15204-1-frankja@linux.ibm.com>
 <dfce14f4-5e7b-9060-6520-06e7dd69cfa4@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <524d5b00-94ec-da47-601a-a5909e3ed63e@linux.ibm.com>
Date: Fri, 31 Jul 2020 13:31:01 +0200
MIME-Version: 1.0
In-Reply-To: <dfce14f4-5e7b-9060-6520-06e7dd69cfa4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="O8U22nfIlLSsTpMloR4PrYOR3Bz699fZH"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, thuth@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O8U22nfIlLSsTpMloR4PrYOR3Bz699fZH
Content-Type: multipart/mixed; boundary="uDD1PaZ1NzEVmO5Z34EMAKySGjKGpLvGs"

--uDD1PaZ1NzEVmO5Z34EMAKySGjKGpLvGs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/20 12:31 PM, Paolo Bonzini wrote:
> On 31/07/20 11:45, Janosch Frank wrote:
>>   https://github.com/frankjaa/kvm-unit-tests.git tags/s390x-2020-31-07=

>=20
> Pulled, thanks.  FWIW you may want to gitlab in order to get the CI.
>=20
> Paolo
>=20

Hey Paolo, that repository is hooked up to travis already:
https://travis-ci.com/github/frankjaa/kvm-unit-tests/builds/177931162

I'll consider it if it has any benefit.
@Thomas: Are there differences in the CI?


--uDD1PaZ1NzEVmO5Z34EMAKySGjKGpLvGs--

--O8U22nfIlLSsTpMloR4PrYOR3Bz699fZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8kAPUACgkQ41TmuOI4
ufhjEBAAvgnvYklX9gRFeZT90EgLtMGZ78r4I3WggkwIlW0su4P9ORfsQhYnzWAP
yLavkAVywXGIIVWI32Gj6Iv1zinBrpH51J2V8ZeRf+nWvmPJKnv1fPti0vkIMmGR
nJnSnKbWBwL+BmAtIze8XECQII15URdeckfWO9VEOSTRQ6uZssy2qBCjbTxYt6Vt
v/fhGy/XFztOml2fF5W49bYJsxtNLIvBRWa/vJUQ4XGrCWRygDSm6RuTt1MUT4Qy
9oB3fE0V91AkhBrhRa9tkm+vluQylpUUvsFBFWLi5vT6yrU3yaxFEbL0YmdcaShm
LQxEJ2/O8Rkvj5ma9BO7xQwYj5xtM3/deBv+VlSLnIFxHql+cSaknVokkxc8IiFh
op9hXJFGYvhlW3EhCH/S3vacWUJuJB4e5z4J4aEfOpoJ//P+52n8qbJZtUbiqpDw
BA6dmhuEufvPEqW0w/3yGY19fjcg0dhqmFi7Tksnx0/oxWDtabZr8/41drQlb8Re
PgVHtuaiMUYrOKMQuWky8i0mRcQKAVVwe02kszVtMHcewbHHDrWH20mBfkEpnd2y
s9GY5u6afVYO1xNmlaDrxCRgXLPtMw53Zg7IYm/uRo7GkVpYgVz4DDIcUqUfMACg
8IJqE7FvcG/5klJjeaR+s74r2nipyw/Gf4YMHb4+ZeIUkPEydSE=
=FCIC
-----END PGP SIGNATURE-----

--O8U22nfIlLSsTpMloR4PrYOR3Bz699fZH--
