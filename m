Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH RFC 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-3-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 9 Aug 2018 07:39:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-3-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LI2TuzwusZUfbWhWtfdlLoJD2Q4qAdZ4v"
Message-Id: <c45051e1-7079-d401-25c7-5abe018b3473@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LI2TuzwusZUfbWhWtfdlLoJD2Q4qAdZ4v
Content-Type: multipart/mixed; boundary="UcYEAsPsCSOLKUeJ8YlGsRIxrVibcp0Mu";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <c45051e1-7079-d401-25c7-5abe018b3473@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] KVM: s390: introduce and use KVM_REQ_VSIE_RESTART
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-3-david@redhat.com>
In-Reply-To: <20180807125131.3606-3-david@redhat.com>

--UcYEAsPsCSOLKUeJ8YlGsRIxrVibcp0Mu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.2018 14:51, David Hildenbrand wrote:
> When we change the crycb (or execution controls), we also have to make =
sure
> that the vSIE shadow datastructures properly consider the changed
> values before rerunning the vSIE. We can achieve that by simply using a=

> VCPU request now.
>=20
> This has to be a synchronous request (=3D=3D handled before entering th=
e
> (v)SIE again).
>=20
> The request will make sure that the vSIE handler is left, and that the
> request will be processed (NOP), therefore forcing a reload of all
> vSIE data (including rebuilding the crycb) when re-entering the vSIE
> interception handler the next time.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--UcYEAsPsCSOLKUeJ8YlGsRIxrVibcp0Mu--

--LI2TuzwusZUfbWhWtfdlLoJD2Q4qAdZ4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJba9OFAAoJEBcO/8Q8ZEV5r64QAKbsDqYeCxoubtvgqJt0xjfJ
vDzBt3E7/8+P3UoLFQnerBwWpWuWT6XsIr9ET4cR6Lrc5kfhsPAt5izSJvX86UB8
XX1vKOHfToChMmsFzDtX70N1UEEGTwqMsOJK/X2dIg0dca8VL3hcM3/KIGTHSUbb
+wnc+Xu+YP88gfox/YYIH6mam/frqvv7nlQ+iLSzPDrs4gnOep2K2hrIou9klufW
+NSszVGnXO1IN/g33LtL39Q1YdrxRamUnEXn9d5vAOYYbkttpkPMjQVSpWe8KxGe
+NNoPACCuIw72TvDfmY/0LaD9CeGuoJXC21jUmWwm5pT4K0YvKQWspiN5gcXhW3T
ZGqYQPGz+rFrTALpAldUSD6SCQ8fD0Etn5Zx84hZJtPfy7PezpCOYRojIiDsE7Jh
nt3PNxJFascSBiKUxSdq2xOVxQ736fQcfSAltNFHLjZUXeM7OrHLsS60le/OOesq
+u65cR43aSH0498S7nbyfy6z4ZXNoDxHUMrUmN4kMxOMrNWM8B+aRi4XqMWD1Obb
L7Y52S8Lvw6QJ6clPB3/nwJzcv7tADST30rjiK0gwxrN0Y+CkjRazVfJr/SwCGpq
BXv1JG2r3FbwpZ7pxEc/1oFSdMnbzszftijPHX9Qk1FtgVv2wHRmRkD85HsloA7/
OyyoBBogqlMiP+XXvLX7
=vxzf
-----END PGP SIGNATURE-----

--LI2TuzwusZUfbWhWtfdlLoJD2Q4qAdZ4v--
