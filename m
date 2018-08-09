Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-2-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 9 Aug 2018 07:38:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-2-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kcz2sLgfm4jIbtJq1XcrqZtzPQdGv4GvC"
Message-Id: <baab41cb-46fe-9335-9481-5fdb35b6f7e3@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kcz2sLgfm4jIbtJq1XcrqZtzPQdGv4GvC
Content-Type: multipart/mixed; boundary="EQ9E38gnVc3AMZClXlVXFj4VlAsXZ7lnv";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <baab41cb-46fe-9335-9481-5fdb35b6f7e3@linux.ibm.com>
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-2-david@redhat.com>
In-Reply-To: <20180807125131.3606-2-david@redhat.com>

--EQ9E38gnVc3AMZClXlVXFj4VlAsXZ7lnv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.08.2018 14:51, David Hildenbrand wrote:
> VCPU requests and VCPU blocking right now don't take care of the vSIE
> (as it was not necessary until now). But we want to have VCPU requests
> that will also be handled before running the vSIE again.
>=20
> So let's simulate a SIE entry when entering the vSIE loop and check
> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will the=
n
> detect that the SIE (in form of the vSIE execution loop) is running and=

> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
> therefore the vSIE interception handler, allowing it to handle VCPU
> requests.
>=20
> E.g. if we want to modify the crycb of the VCPU and make sure that any
> masks also get applied to the VSIE crycb shadow (which uses masks from =
the
> VCPU crycb), we will need a way to hinder the vSIE from running and mak=
e
> sure to process the updated crycb before reentering the vSIE again.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Finally found some time:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

As the first user will be AP, I guess the patches will be queued with
them. Thanks for helping out :)


--EQ9E38gnVc3AMZClXlVXFj4VlAsXZ7lnv--

--Kcz2sLgfm4jIbtJq1XcrqZtzPQdGv4GvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJba9NXAAoJEBcO/8Q8ZEV5I2gP/AhhzDUWI/0AXCS3GQUH24q5
Vr2UDGO30f++Of4ZGbCNzyJ5mAKRGRf3QVJsGbC8oqHjyi2D7k3DpoKjI9l8wUIY
X7p0+wWJhOEAOP0pPBpCbNqUkWQegmHSsYucbVt/rNnMzMkGxlT17CY7xtL9pKC1
YPLqwNiEtqcMbSq6/qvMo4EAGUVIdnhsx+8XtYXQzYtvnHKy8ue5V3H04gn7YaRW
zMfBVg51S5khCfQdxsae81r1QYVxlWwwtN+ujfnSS9YtEfY9P+zP1zieOB1LAgc6
qYqYtnbF3gEqdIt80ojMtCPvCYcgIy9fflHlvqf23IsPMjADcjzxfGJeqc7IVUaF
/FTv0JZ7PIWPy0eSjLY5IokWwSPeWlv1Gkjl0Ram+kRgJ3XHJ6xXwMg9YlO5C9IH
d+AN2u/L8/7a4keF49jwa/0L8kK2/I8hk7pIsgNav9Ebsv/xV40CVejTywH1Hqsl
Zcvi0oEOVd/IpfEbD9VqGyRO8HIWE2NPmEcoCi8hNX3VT3t2QihbYnQBq5cAkIN1
UKj5z4HRhWUgFdBfVWlAT4DIYkSQezwnJye3ELrOIRvvRHUwOIKllvMg8upHiEFB
ykP4usICgHFBZRnxpjzVmgGqwrhX/cAUwZbrs/bjKe9rGxcAUgJVKC+11tUK4KGq
MCVU0DzVSaOSi8X/w256
=C6OM
-----END PGP SIGNATURE-----

--Kcz2sLgfm4jIbtJq1XcrqZtzPQdGv4GvC--
