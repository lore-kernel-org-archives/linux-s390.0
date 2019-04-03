Return-Path: <linux-doc-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 3 Apr 2019 08:36:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190402174636.15175-2-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0"
Message-Id: <39632665-8861-a386-a1c9-9ce9d081f868@linux.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0
Content-Type: multipart/mixed; boundary="foHmibD3CXfkRlupSVXWPePnqmUFC7JKg";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Collin Walling <walling@linux.ibm.com>, pbonzini@redhat.com,
 david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com
Message-ID: <39632665-8861-a386-a1c9-9ce9d081f868@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] s390/setup: diag318: remove bit check and refactor
 struct
References: <20190402174636.15175-1-walling@linux.ibm.com>
 <20190402174636.15175-2-walling@linux.ibm.com>
In-Reply-To: <20190402174636.15175-2-walling@linux.ibm.com>

--foHmibD3CXfkRlupSVXWPePnqmUFC7JKg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.04.19 19:46, Collin Walling wrote:
> Execution of DIAGNOSE 0x318 is fenced by checking an SCLP bit
> for the availability of hardware support for the instruction.
>=20
> In order to support this instruction for a KVM/QEMU guest, we
> would need to provide modifications to the SCLP Read SCP Info
> data, which will in turn reduce the maximum number of CPUs that
> may be provided to the guest. This issue introduces compatability
> and legacy concerns.

s/compatability/compatibility/

>=20
> Let's circumvent this issue by removing the bit check and blindly
> executing the instruction. An exception table rule is in place to
> catch the case where hardware does not support this instruction.

Great, another ESSA like instruction...
The sclp bit is still there but we can choose to ignore it for a spec
exception.

>=20
> While we're at it, let's condense the version code fields in the
> diag318_info struct until we can determine how it will be used.
>=20
> This modifies commit 4ad78b8651aacf26b3ab6d1e784952eb70469c43
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>


--foHmibD3CXfkRlupSVXWPePnqmUFC7JKg--

--UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcpFRsAAoJEONU5rjiOLn4m78P/jSthbC12i38yNCo6Zrs35Ox
tY8+so48VneY/3lNvqbKm9+jxDBLwGepY6C2MG3JTDt5ZW00vMmmydXloLS9Dz2N
cmLk4j0B3cBupaPKemzxuA74UpKEXmzPYuafia+ZF2nRnd9u4LhmQWXHhnOXqvIw
vQPRknEbtwMk3ioK4qx1PNhT9rm67oXXtJuC8vrzOZm0U7JTus3V9w4eM1AXzSCp
nN3JdpkMUj5tqrMz81p5oTqeOJzbcfbgqY8hrNXGGXk445ZIWFUNzsYTmsjExcdF
wgzUJIfZ+1SNCewg4VsULrqilriQDTbwGnD5Mol5ozR0dzBmLNjXh49mS4yG+kjX
Jasz+cwIk5CRCJfMe97imfeCL8Kpsm5QnhDFkk0gqLuqyAG1h7R9YmTDy14fcqAB
UhP5SDlYXz7Gt2XCX72R8rDdTExGX1sFPh3xLJeUFvcfIpECVQh/HQ+nf55AQPDS
OjdX5rXoCbsRlleNHM9y0FP2ASRtByJ15IvYuEyxIbRSiZa41beJMYcceG33Wa9p
K6Ej3GfACafZTpll/Pi6PETu7HgNEp3fQnjV1YN2ZWpvUGdhHvYWq9culc/6NGl4
CnAfwprndJLw0ymF+NjqpDPGpfEFYInCGC4luKb05dvq2UoVcx1TTCQ82f6PnYuV
1eL06BpUbRgdpk74VeBg
=ETJE
-----END PGP SIGNATURE-----

--UB33e5csoLqNTWPZZwpCH2ndUG8hV9Pn0--
