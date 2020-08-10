Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgHJPc0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 11:32:26 -0400
Date: Mon, 10 Aug 2020 17:32:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Ultravisor guest API test
Message-ID: <20200810173205.2daaaca1.cohuck@redhat.com>
In-Reply-To: <2b5634bf-c39b-13db-924a-5efcbaddb238@linux.ibm.com>
References: <20200807111555.11169-1-frankja@linux.ibm.com>
        <20200807111555.11169-4-frankja@linux.ibm.com>
        <20200810165004.02c4b5bf.cohuck@redhat.com>
        <2b5634bf-c39b-13db-924a-5efcbaddb238@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BC7o8XmTtcg=gn4V63ImQbZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

--Sig_/BC7o8XmTtcg=gn4V63ImQbZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Aug 2020 17:27:36 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 8/10/20 4:50 PM, Cornelia Huck wrote:
> > On Fri,  7 Aug 2020 07:15:55 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:

> >> +static inline int share(unsigned long addr, u16 cmd)
> >> +{
> >> +=09struct uv_cb_share uvcb =3D {
> >> +=09=09.header.cmd =3D cmd,
> >> +=09=09.header.len =3D sizeof(uvcb),
> >> +=09=09.paddr =3D addr
> >> +=09};
> >> +
> >> +=09uv_call(0, (u64)&uvcb);
> >> +=09return uvcb.header.rc; =20
> >=20
> > Any reason why you're not checking rc and cc here... =20
>=20
> Well, this is a helper function not a test function.
> Since I can only return one value and since I'm lazy, I chose to ignore
> the CC and went for the uvcb rc. That's basically also the answer for
> your following questions.

Maybe I'm just confused regarding the command execution here.

>=20
>=20
> Alright, I'll remove the helpers and execute those tests the hard way.

As a plus point, you see exactly what is being done.

--Sig_/BC7o8XmTtcg=gn4V63ImQbZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl8xaHUACgkQ3s9rk8bw
L69FERAAhu8U5akqpyGLZhJaIrjOXKQte1PYtnUL65iaytZFmcgRTQlMnhF7kI/1
5dQnLV04lvdTonCP8Aklxb4ozv+8ntGfBO9fpln/SQ6xehIJEhWfg0xDworVCVjt
3ncfBJiPKRWi4MM9iXgc92juz3CU33TrzX0PYrEsImiaHlUhApkdJi88msu+mMRn
DCyLqBufAik66LRqJDDWh5pCYK6QI2Of3RjKIVVKptpQ6WvZINm+G/YEr7sZel9Q
SZRqkPmjU8Y5RTuq3UWb0RcwhEtfYHB/u8yjbqMeVtEaT/7OTMfzCn8kBaNk1bj3
d0mpiUM2VhxCXS7jHL0oybsniFYJFXxEKM/RzEsIC1g5EQZbdsXlyQwYxP1Gx9k5
eBvbOVDNnT9Ab53hk2SJR/T50xN9caxnSAoXw6bISaeFMCmJtBPx6OlPLbZpqTl1
0KAsL7Xr0df2UQfRvMlIPgS1J4a4SA72UaBWa/HxdpVgxZrbLIh7+xxZh9F8128j
RBQg0GzNM3cs3nKGcoUVg9IJza3hTsYaxfl+l54AA0Uan6ARZ7EDUOGPL5JoXjly
5qYx5N6xuS07XbVul5Exd82LIq7V4bO+QmWt4OVWVvHrXtK6dV8910lDRZKgVE8K
QrzmQm6Iz5HtETgFdUhRukJ+qaP1xr8FbnsSag5+IvM2WBX/adY=
=SiD4
-----END PGP SIGNATURE-----

--Sig_/BC7o8XmTtcg=gn4V63ImQbZ--
