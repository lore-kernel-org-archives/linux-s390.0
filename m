Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbgGUPDS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jul 2020 11:03:18 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-3-frankja@linux.ibm.com>
 <78da93f7-118d-2c1d-582a-092232f36108@redhat.com>
 <032c1103-3020-9deb-a307-70ded3bdb55e@linux.ibm.com>
 <1aa0a21c-90c9-0214-1869-87cc60a46548@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <acc2a56c-6157-32e1-f305-48bf5a2a285d@linux.ibm.com>
Date: Tue, 21 Jul 2020 17:03:10 +0200
MIME-Version: 1.0
In-Reply-To: <1aa0a21c-90c9-0214-1869-87cc60a46548@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u7U639BBQ74xPdb9CAu8iB2AHT1kwGUHV"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u7U639BBQ74xPdb9CAu8iB2AHT1kwGUHV
Content-Type: multipart/mixed; boundary="Wvdzmrcl8JRHAyP3IaW3IyoU8rLvWcqrY"

--Wvdzmrcl8JRHAyP3IaW3IyoU8rLvWcqrY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/21/20 4:28 PM, Thomas Huth wrote:
> On 21/07/2020 10.52, Janosch Frank wrote:
>> On 7/21/20 9:28 AM, Thomas Huth wrote:
>>> On 17/07/2020 16.58, Janosch Frank wrote:
>>>> If a exception new psw mask contains a key a specification exception=

>>>> instead of a special operation exception is presented.
>>>
>>> I have troubles parsing that sentence... could you write that differe=
ntly?
>>> (and: "s/a exception/an exception/")
>>
>> How about:
>>
>> When an exception psw new with a storage key in its mask is loaded fro=
m
>> lowcore a specification exception is raised instead of the special
>> operation exception that is normally presented when skrf is active.
>=20
> Still a huge beast of a sentence. Could you maybe make two sentences ou=
t
> of it? For example:
>=20
> " ... is raised. This differs from the normal case where ..."

When an exception psw new with a storage key in its mask is loaded from
lowcore a specification exception is raised. This behavior differs from
the one that is presented when trying to execute skey related
instructions which will raise special operation exceptions.

>=20
> ?
>=20
>  Thomas
>=20



--Wvdzmrcl8JRHAyP3IaW3IyoU8rLvWcqrY--

--u7U639BBQ74xPdb9CAu8iB2AHT1kwGUHV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8XA64ACgkQ41TmuOI4
ufh9WhAArrT4uX5FyttMPMtoYWT6pmpM7tM02OTGn8KZBCzoMKdbK0Kr3ilr9GA4
QcEWRoro6CtirEQ1oo4MbY6hRbA7Ve3g2tHyb42GVaRGK6j4F/frAL1RfrS6V0PB
E7eRtjSdDX5gknHbVHgqPYYE1zvLz6pCEekDCJBh62i7u6OI8Lz8FCIddRP4nSVO
aJQTdZR/mxbQPbc1q2YZFl+Vp1fF0UMXmNWTy10LGR+FgYmQv2XWPSvVKGo0vKTf
7fPEZmeGj+du8BXZ1HJa+9mZd6MssG0fraRsotUejb3E7Bay2qh3TJlEfAoAJxix
iMK5GLisOE+hlumGNftcwz2XGow2bZB9kWRDVx5WZCCp9KdnF4JIy0i7MNWWzbct
9xBuUVOcJWgMfEXcGqC+giZG8xJokz7ZY7XKP9tVAeV0IQrksjaHAGD71eAMH7Qr
m0DHa5Fau0H+Ovv213R/lhq7ph2JPUsRYdZDnRjj/51+/JZqP5TESUXg/OrdZkL6
4hBlAv1Gf7Oz52GnHa+fWPiki7sIVBUQxtl8ds3n+/Of1N4ALDWg6OiaujUbo72F
wmD9KhnGx0s5azJS/qaQRSjrynpggD7qe89iMXQbRDkh9z5EYQKLluL/EdjAiQa8
P94nPHEJBt+aUkjZcMD0KXxh7eM96JrsPp+PNV8C0aNFby04eos=
=8XTg
-----END PGP SIGNATURE-----

--u7U639BBQ74xPdb9CAu8iB2AHT1kwGUHV--
