From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Wed, 14 Feb 2018 12:19:27 +0100
Message-ID: <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dHutdACJUctLGqWBsHQwOYH7ofzWWmUxg"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dHutdACJUctLGqWBsHQwOYH7ofzWWmUxg
Content-Type: multipart/mixed; boundary="ELWNiTIw3Ofn234BAntywWT0mSJjwPjQX";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
In-Reply-To: <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>

--ELWNiTIw3Ofn234BAntywWT0mSJjwPjQX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.02.2018 11:42, David Hildenbrand wrote:
>=20
>>>>> That's interesting, because the SIE can now suddenly work on these
>>>>> PGSTEs, e.g. not leading to intercepts on certain events (like sett=
ing
>>>>> storage keys).
>>>>>
>>>>> How is that intended to be handled? I assume we would somehow have =
to
>>>>> forbid the SIE from making use of the PGSTE. But that involves clea=
ring
>>>>> certain interception controls, which might be problematic.
>>>>
>>>> Well, cmma is disabled and storage keys should only be a problem, wh=
en
>>>> the pte is invalid without the pgste lock, which should never be the=

>>>> case for split pmds.
>>>>
>>>
>>> Are you sure? Because the SIE would suddenly stark working on guest
>>> storage keys stored in the PGSTE if I am not mistaking? So I would
>>> assume that there would have to be some kind of a sync.
>>>
>>> But I don't have any documentation at hand, so i can't tell :)
>>>
>>
>> The pgste lock is that sync and as the gmap is the only way to get to
>> the pte, we don't have any ptes invalid without the lock. Also
>> set_guest_storage_keys will find a (userspace) pmd and do a hardware
>> sske, like it is supposed to.
>=20
> What happens according to the documentation in the following cases:
>=20
> The HW has the storage-key facility enabled and a SKEY operation (ISKE,=

> RRBE, SSKE) hits a huge page:
>=20
> a) Generates an intercept
> b) Uses the real machine storage key (as there are no pgste)
>=20

b, this is an implicit RCP bypass (same goes for fc=3D1 r3 entries). This=

might be even independent of the SKF if I'm not mistaken.


--ELWNiTIw3Ofn234BAntywWT0mSJjwPjQX--

--dHutdACJUctLGqWBsHQwOYH7ofzWWmUxg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahBtJAAoJEBcO/8Q8ZEV5CeMQAIoi203C8XPyqBn/K42qp06h
bWyPmXsESJ3wNZaYRKebcN5z6XOHBi2mwEGAN8JLhe+jcVaEGd+fvQiSUI8wrx/9
acuzk0VgZQPVlr8VpWYwbPnjsH6+3VQ8s1mCHoTXkXtqCq3Cq6xk01VYJRzi21+2
xdDbXLovv1kf6+JC5anIkUuznx3JOeR1XEpvAtm1RH12ctYCwzCKzqRBbCXq9Ow7
sDOlL/5Qq8tdexReThVE9b2cZmJ3DIdKncNjyzzc3UVmgYawl4in/O7iZ0wYqYg+
k7wyUeIll4p7YG2EGErmdpD+w/N/vYo3KMjT82QTWpTinv9iBuXPRnbysZAyC8uE
T8tfi95m5HY2u+rZgPYlgc7DE0Td8VYKjEoPesle0uTo7RaoiUHD9W7WcP2y6F1g
a9I/dj1198tgPfoMdsMx5bvl5Jep6NaGFXKys1DmcqcuebLCFR2qdv/qyPv9iJoR
sO4p7RDq1sqypOe5GfjCdH7XpDx0AH538d7uWY2kdQ5siNyUYDZA9BhCZ8j2dYvW
E8+Kubn0bdT9nnIswIuZPWQN2rh0jo2faJZsEphZK1tHNJA+TnbITe307lA2eKgJ
nVCUUAF04LEpu8+RE2d2qbMgNy+PIwfCUAdWxxG8zYQYFECpN9b8DsfMAGpGdKM4
YNhl3wUQ6FCHFhPAVdgL
=ARQK
-----END PGP SIGNATURE-----

--dHutdACJUctLGqWBsHQwOYH7ofzWWmUxg--
