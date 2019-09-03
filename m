Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfICK6W (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 3 Sep 2019 06:58:22 -0400
Subject: Re: [kvm-unit-tests PATCH v3 4/5] s390x: STSI tests
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-5-frankja@linux.ibm.com>
 <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
 <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <57f0dc1f-b610-5008-9869-14ce12caed04@redhat.com>
Date: Tue, 3 Sep 2019 12:58:12 +0200
MIME-Version: 1.0
In-Reply-To: <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U4Hg9xWCMZZRL4o3yFh0uKFWTYxwD81Us"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U4Hg9xWCMZZRL4o3yFh0uKFWTYxwD81Us
Content-Type: multipart/mixed; boundary="SU2hSD3LdPHMkrMTwIcKnvjL2Gh8uEgGi";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Message-ID: <57f0dc1f-b610-5008-9869-14ce12caed04@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v3 4/5] s390x: STSI tests
References: <20190826163502.1298-1-frankja@linux.ibm.com>
 <20190826163502.1298-5-frankja@linux.ibm.com>
 <72cc113e-63a2-d389-d1fb-b0b9e84fc863@redhat.com>
 <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>
In-Reply-To: <1416cb79-09b6-8067-041f-16522860cd88@linux.ibm.com>

--SU2hSD3LdPHMkrMTwIcKnvjL2Gh8uEgGi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/09/2019 12.53, Janosch Frank wrote:
> On 8/30/19 2:07 PM, David Hildenbrand wrote:
>> On 26.08.19 18:35, Janosch Frank wrote:
>>> For now let's concentrate on the error conditions.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
> [...]
>>> +static inline unsigned long stsi_get_fc(void *addr)
>>> +{
>>> +	register unsigned long r0 asm("0") =3D 0;
>>> +	register unsigned long r1 asm("1") =3D 0;
>>> +	int cc;
>>> +
>>> +	asm volatile("stsi	0(%3)\n"
>>> +		     "ipm	%[cc]\n"
>>> +		     "srl	%[cc],28\n"
>>> +		     : "+d" (r0), [cc] "=3Dd" (cc)
>>> +		     : "d" (r1), "a" (addr)
>>
>> maybe [addr], so you can avoid the %3 above
>=20
> Sure, maybe Thomas can also fix that on picking for the previous patch?=


Yes, I can do that.

>>
>>> +		     : "cc", "memory");
>>> +	assert(!cc);
>>> +	return r0 >> 28;
>>
>> I think I'd prefer "get_configuration_level()" and move it to an heade=
r
>> - because the fc actually allows more values (0, 15 ...) - however the=

>> level can be used as an fc.
>=20
> The rename works for me, but that's currently used only once, so why
> should it go to a header file?
>=20
> I though about starting lib/s390x/asm/misc-instr.h if we have enough (>=
=3D
> 2) instruction definitions which are shared.

Let's keep it here until we need it in another file, too - then we can
still move it to a header instead.

 Thomas


--SU2hSD3LdPHMkrMTwIcKnvjL2Gh8uEgGi--

--U4Hg9xWCMZZRL4o3yFh0uKFWTYxwD81Us
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1uR0QACgkQLtnXdP5w
LbU2QBAAl9mQq1Bid6irF8bZ0X6iMTsI6QtS/1/QFBE7qrxUiNlqoZG/nfKBdQjN
4fA24EqqGRJDZYfBk04ZOyTgaJtSp01/bCfkU/C/ODXTACL0pCfOF/5nuXGj2Gmr
JtFGDVqcHj30POEpAH3qGQDw9WNUFvPZYXUjCfNJVRLYmIduTCuXazeZr+YUNKHi
Xza3mKGi+FZvZnKfJaR61F+HNt5fLGWM4objmGZlj6akWBRMqDXdHkvtxvkLe6Xw
SO3VV4uqhoZS4xCagcpTBMh8uBxzyJDB/lD64rdUO0xfrOTYuDq2JGDHEPpAT1e6
Vxor5zSzRYzRkS9Jz4XuOucxM2vfmdoCO2zgPcqGG3tJUa4XJhcL1koCObAvVm15
4lnFVHFgQHlCaSOuCvMAW3rL/MvPfiGZ3nD5KypuFGQuLXvVDryfzGC2JOXiTWRc
pPl/zDy2AcUtEEocIuKmrCm55eVVL9ZpU7hnLcxfrLWf/kSjspAftFQeT4reC63j
5Yrub7CH5qGt6tEMFdXDzc76FTdIcVOnwwT9033CpmkHsvPA7wyI8xgiFHUBSvaD
DQCz1jlGbdVMUeeVOeYFRtKk+5JX/bZF46mWlYZjD14SXhNCEwXORPF/Loy3UK4y
/Galp9PA2sTTtzPyTlT49zFyibCwvkKneODvhPjV68W6g7kvaIU=
=dzoS
-----END PGP SIGNATURE-----

--U4Hg9xWCMZZRL4o3yFh0uKFWTYxwD81Us--
