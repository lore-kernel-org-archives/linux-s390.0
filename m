Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH1H4O (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 03:56:14 -0400
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Add storage key removal
 facility
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-4-frankja@linux.ibm.com>
 <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>
 <f0cddac0-a574-1aeb-69c6-b9d67f2dfd97@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b0349845-b759-2b28-7ba3-d3fbf6515dda@redhat.com>
Date: Wed, 28 Aug 2019 09:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <f0cddac0-a574-1aeb-69c6-b9d67f2dfd97@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lAkWFrPUpj7JIzAfSAVxW3cfqTXNRv8ND"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lAkWFrPUpj7JIzAfSAVxW3cfqTXNRv8ND
Content-Type: multipart/mixed; boundary="4Ug9b7HK1I31AlMdcC4gl1BOzabphiKlO";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <b0349845-b759-2b28-7ba3-d3fbf6515dda@redhat.com>
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Add storage key removal
 facility
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-4-frankja@linux.ibm.com>
 <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>
 <f0cddac0-a574-1aeb-69c6-b9d67f2dfd97@linux.ibm.com>
In-Reply-To: <f0cddac0-a574-1aeb-69c6-b9d67f2dfd97@linux.ibm.com>

--4Ug9b7HK1I31AlMdcC4gl1BOzabphiKlO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28/08/2019 08.26, Janosch Frank wrote:
> On 8/27/19 7:58 PM, Thomas Huth wrote:
[...]
>> Anyway, I've now also checked this patch in the CI:
>>
>> diff a/s390x/Makefile b/s390x/Makefile
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -25,7 +25,7 @@ CFLAGS +=3D -std=3Dgnu99
>>  CFLAGS +=3D -ffreestanding
>>  CFLAGS +=3D -I $(SRCDIR)/lib -I $(SRCDIR)/lib/s390x -I lib
>>  CFLAGS +=3D -O2
>> -CFLAGS +=3D -march=3Dz900
>> +CFLAGS +=3D -march=3Dz10
>>  CFLAGS +=3D -fno-delete-null-pointer-checks
>>  LDFLAGS +=3D -nostdlib -Wl,--build-id=3Dnone
>>
>> ... and it also seems to work fine with the TCG there:
>>
>> https://gitlab.com/huth/kvm-unit-tests/-/jobs/281450598
>>
>> So I think you can simply change it in the Makefile instead.
>=20
> z10 or directly something higher?

zEC12 seems to work, too:

https://gitlab.com/huth/kvm-unit-tests/-/jobs/281833366

 Thomas


--4Ug9b7HK1I31AlMdcC4gl1BOzabphiKlO--

--lAkWFrPUpj7JIzAfSAVxW3cfqTXNRv8ND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1mM5kACgkQLtnXdP5w
LbVwIBAAo0UyIwnQvKYm/yFMdni7unGlRLXkdtQhESAU+JClqh4NyRl1qd8Vlh77
1dl0lzfLfo2jcZvvzVD3qjgI72ie43R0tsgrZBsehz3kxPXFkHS+8Pj9SqXFnOy5
JfLTq4H0hVs0G4w5yO4FgctVbpAeQryLqrG95De6UfLkN0yRu/NfiFn2M14NUecB
PAzhiccJOl8BtnTCNik589AmSYw6E74Hi1qSUsjm+tgqd8GISLUMlQPamQOUVgTE
5cqbaqrJWFI6JHnSK0k5jKCmh/34uRtfHXdiecxhBfycJ+4QPTZe0ORSElNbCNXT
fystxZp9RhZLQeO+fi90pmN+ERApuC71ejIclsTlowmVbOhes6AMVaI7QS4w3mUn
mEY/jF1WlNAGuPUi67zk1dmfDHHyA5I+I2KaTDSVzaqA+B5nJiyXyVQz7MrKUwxW
7WHfyGiz9JxhMXxJhmSfyHD+Xqc/BE0aA1pBN8W/zHvOEkXJDqmWYZpH/OtP48WN
pTBYzxaIioGJRk2Re8/rLsKj4Y8SVd/rTR6TvYODNjzESyIXMI6LsM6TFzlE9kGG
cpemx4vvyMWTdR3L/gTMkIfew3ww01NX2K085hXpJJh/LatKdiCa+8khCCX7StSw
zXCXExe85994hjkSYk531BdEIf1o5DoMJLgVZRsgKr9ZB9lmbok=
=Io3o
-----END PGP SIGNATURE-----

--lAkWFrPUpj7JIzAfSAVxW3cfqTXNRv8ND--
