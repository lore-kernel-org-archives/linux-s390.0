Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbgHKHS2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Aug 2020 03:18:28 -0400
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Ultravisor guest API test
References: <20200810173205.2daaaca1.cohuck@redhat.com>
 <20200810154541.32974-1-frankja@linux.ibm.com>
 <20200810175015.23b7fcf7.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <a72a494c-0f7d-b4aa-1767-72b5ecd57930@linux.ibm.com>
Date: Tue, 11 Aug 2020 09:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20200810175015.23b7fcf7.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qiXJYt1g92oZeQ68Il2KdGoXjUxMPN7ZL"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qiXJYt1g92oZeQ68Il2KdGoXjUxMPN7ZL
Content-Type: multipart/mixed; boundary="p6CPQPXxsbNrBTO6cJTYtxZ3xfheOBmsk"

--p6CPQPXxsbNrBTO6cJTYtxZ3xfheOBmsk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/10/20 5:50 PM, Cornelia Huck wrote:
> On Mon, 10 Aug 2020 11:45:41 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Test the error conditions of guest 2 Ultravisor calls, namely:
>>      * Query Ultravisor information
>>      * Set shared access
>>      * Remove shared access
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm/uv.h  |  74 ++++++++++++++++++++++
>>  s390x/Makefile      |   1 +
>>  s390x/unittests.cfg |   3 +
>>  s390x/uv-guest.c    | 150 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  4 files changed, 228 insertions(+)
>>  create mode 100644 lib/s390x/asm/uv.h
>>  create mode 100644 s390x/uv-guest.c
>=20
> Acked-by: Cornelia Huck <cohuck@redhat.com>
>=20
Thanks!


--p6CPQPXxsbNrBTO6cJTYtxZ3xfheOBmsk--

--qiXJYt1g92oZeQ68Il2KdGoXjUxMPN7ZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8yRjwACgkQ41TmuOI4
ufjlsA/9EnCyDusGamiEDzLhF/1EGnBHcYK6HNPKXJIOdbuk1gLJLnHkiosD7sR4
jgzc7tzTss2wXI2YouhjXNrSDaGVMGa6hPrAX+X+IUd23A2hIsJnD4koNAixOtXh
a5RKQ6hICOth83AWJAfl0ZJnH/lZux98DD4vrWigYhIG7SFrTt0V1pl8DAxzUPOP
fCpYkjh6gwTAvGC+XuVh79z6ZkRF7btqmEWIyNzIjiPt2ltUvJT6ZohPewtmYeiV
aGaZEJEw5r9rOFbRxb6mj6E337h9fVWCGaTFnHXf5PbJmaJSLLtLtdP+hSoJtQ9o
Neemd3Sv7mDEQalEc6p4mSaLhgrUtQ5GO+qJXXlwblhIihwKqUtWeGX1o0rffec3
Dt0aN19eesNtGINbI92hX3LQQd2WRjS3x0r1YZGdi3LDuNUPIsd/K9zpQeS4T4QA
JqBd40qjwojzWLPvgzrqThpSz2PblQeXOM9MQzSgQ8Ga6oIqP9HyMeSHOrFm9Q1T
rVGyvjg83XMXW9EmdgyEX+amKfsyXwZXvXdGg/fe6JvLs45dJKVMZFStGXNl2Twn
JwuRZAtr1GDfXdFrlmNa2HZ/WUdhFxOHYEOFRzvtsEwkkTlvpdsTUsFEBJu4CqHo
8H/oQro/eh062oKI5Lm1TAbLr13uZYGM/qA+ZX36P8/FHpJPgbs=
=Juxt
-----END PGP SIGNATURE-----

--qiXJYt1g92oZeQ68Il2KdGoXjUxMPN7ZL--
