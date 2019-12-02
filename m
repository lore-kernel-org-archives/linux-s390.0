Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfLBLNl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Dec 2019 06:13:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2BCD6m040720
        for <linux-s390@vger.kernel.org>; Mon, 2 Dec 2019 06:13:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wm6g87x8j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Dec 2019 06:13:37 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 2 Dec 2019 11:13:35 -0000
Subject: Re: [kvm-unit-tests PATCH v2 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1574945167-29677-1-git-send-email-pmorel@linux.ibm.com>
 <1574945167-29677-5-git-send-email-pmorel@linux.ibm.com>
 <442f3d30-e61f-e884-096e-6ed47b4c6d7e@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 2 Dec 2019 12:13:32 +0100
MIME-Version: 1.0
In-Reply-To: <442f3d30-e61f-e884-096e-6ed47b4c6d7e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xbdsg3TlufOH4nygJTfxXfMRXignmMzuq"
Message-Id: <53c076ee-0b16-b990-b6d7-22903b8892b4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xbdsg3TlufOH4nygJTfxXfMRXignmMzuq
Content-Type: multipart/mixed; boundary="eBSANhQmkXr9IRXHxP0nSFCVBCMcMlO4K"

--eBSANhQmkXr9IRXHxP0nSFCVBCMcMlO4K
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/29/19 1:03 PM, David Hildenbrand wrote:
> On 28.11.19 13:46, Pierre Morel wrote:
>> To serve multiple times, the function get_clock_ms() is moved
>> from intercept.c test to the new file asm/clock.h.
>=20
> I'd probably call this "tod.h" instead. Nevermind.

time.h / timing.h?
I'm planning on adding cpu timer functions somewhen next year...

>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
>=20



--eBSANhQmkXr9IRXHxP0nSFCVBCMcMlO4K--

--Xbdsg3TlufOH4nygJTfxXfMRXignmMzuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3k8dwACgkQ41TmuOI4
ufgs/RAAqBv5kh9OriUqyavYoAZGhrcsV6ICb4vAfwzw2xuqWWYe1gMaKLhFBD4e
Yj564cFcEjLnA8mXflUd2el6sP06CIO8bMN2eoFTnwjovenKppvvVuN0SncAXAfe
OKgAJUnwHHEvMaX6HuCxlT3eWen6pdd6iI4DRCe6ygFptkJdOW9HdTbTB+/ToXdB
KkPaVL9wKQjT3bnXQ3eh+VhEXgcNigW2D0Ddwh3nY0U2yIXfIidT5rkFopWVroOU
m9lnm8J3dwF0JTvDyq3cvmcXfNozfDqS+nEc/ofyFhKjZRkXM5umTXC96/pOVdJK
KMJI9feJkuTkzaT4Tfy5sa+QrR7Zo2CLFytM9LFL4Zn5ZPl8mRydEh8TwfC/W/Ol
ViNS8IZpVHAgN7ZiTjPtlPtXrWGwf6O/qDBER4MCkkiwJ1aiN49HBMNiphu40Jss
xMP9wGaUbvFev8Ry0C1rSogPxcjRThFCfPcCVJvhI0ol7ulogoxYABVZR0GHpS3k
iy5onSgQ2Vbcz7dVjWEaFTnq9tXgVDe79L9V4tnomxgdym8xcaLy0Y2qUaNmxD1r
HeRFXg+Ptulm2vLKrhDdYWF8F4D4icQfEfjPDvw/Vja6DSo2mShBh7uMPNnAGjKg
rsbA/a4TrKq6eI1x97KVW5HGRjn+P1A8DHpAxrRCUmDyd/YEd9Y=
=JoGx
-----END PGP SIGNATURE-----

--Xbdsg3TlufOH4nygJTfxXfMRXignmMzuq--
