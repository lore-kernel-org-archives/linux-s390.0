Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732361AbfJWIp5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Oct 2019 04:45:57 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9N8gkfM191451
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 04:45:56 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vthw8brvq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2019 04:45:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 23 Oct 2019 09:45:54 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix selftest malloc check
References: <20191023084017.13142-1-frankja@linux.ibm.com>
 <b5363884-7360-ffc4-b572-f1942cbfae20@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 23 Oct 2019 10:45:49 +0200
MIME-Version: 1.0
In-Reply-To: <b5363884-7360-ffc4-b572-f1942cbfae20@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jT7wo9zRWold95waudiD65jTHKRtPcoi0"
Message-Id: <cce26d3f-83d5-09e8-7a22-de37a2d117dc@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jT7wo9zRWold95waudiD65jTHKRtPcoi0
Content-Type: multipart/mixed; boundary="EZTlrxLGW1b7r8cA3Hc9Pumdt2Xv1jrsZ"

--EZTlrxLGW1b7r8cA3Hc9Pumdt2Xv1jrsZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/23/19 10:41 AM, David Hildenbrand wrote:
> On 23.10.19 10:40, Janosch Frank wrote:
>> Commit c09c54c ("lib: use an argument which doesn't require default
>> argument promotion") broke the selftest. Let's fix it by converting
>> the binary operations to bool.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   s390x/selftest.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/s390x/selftest.c b/s390x/selftest.c
>> index f4acdc4..9cd6943 100644
>> --- a/s390x/selftest.c
>> +++ b/s390x/selftest.c
>> @@ -49,9 +49,9 @@ static void test_malloc(void)
>>   	*tmp2 =3D 123456789;
>>   	mb();
>>  =20
>> -	report("malloc: got vaddr", (uintptr_t)tmp & 0xf000000000000000ul);
>> +	report("malloc: got vaddr", !!((uintptr_t)tmp & 0xf000000000000000ul=
));
>>   	report("malloc: access works", *tmp =3D=3D 123456789);
>> -	report("malloc: got 2nd vaddr", (uintptr_t)tmp2 & 0xf000000000000000=
ul);
>> +	report("malloc: got 2nd vaddr", !!((uintptr_t)tmp2 & 0xf000000000000=
000ul));
>>   	report("malloc: access works", (*tmp2 =3D=3D 123456789));
>>   	report("malloc: addresses differ", tmp !=3D tmp2);
>>  =20
>>
>=20
> See
>=20
> https://lore.kernel.org/kvm/CAGG=3D3QUdVBg5JArMaBcRbBLrHqLLCpAcrtvgT4q1=
h0V7SHbbEQ@mail.gmail.com/T/
>=20

I completely missed that patch and only looked for fixpatches on the
list -_-

If possible CC me if something like this turns up, so I don't have the
CI flashing red lights at me unexpectedly :)



--EZTlrxLGW1b7r8cA3Hc9Pumdt2Xv1jrsZ--

--jT7wo9zRWold95waudiD65jTHKRtPcoi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2wEz0ACgkQ41TmuOI4
ufjMRBAAlg9CMRZomW7loO/dsDFhAQCsNa2bZ6Ddng2op8UoFIxc9Q7YT2qIREFd
JKe0MnKvxgjhlonRgquONHTJdWJXEnH+UG0nGFUIp6R9qPNOy+dXSQWUPEw1HNpc
54P7b6MEpMAae5rR/3RoMajBl8suo3gYT7r0Of+ZUX/IPtQP/eJd/wmZyW9dlL6S
1gsMQf9hckD1KBigPS6FB+ZDT9NMCOtezyPBwAZqcl3gzO0YJCoCChQMeiiHOHbe
fr++Vk2TUAhXH1MgzgIlzVm4ZTXHOAJaTjXWoC9b8GXmb7J0iHAcXPirBhSYjFC3
d1+3Tn3k/2MGW80/Y/vQ3v2tpCjvfLsNismNx1BouBtzrJNgP5QDHVqCofXxTqgE
8gILHYScq4eWVBmMLRxCOZDrlloKTk3bMrzy7qrG2V2HxzQgyd4ew5HQBkSxInBE
8FmnjtOBWlL0P5TtkYRxfFzZRkVIIkYfA50pvEJFqWsFO2pL0lEuB1DFRCFdG3Bk
xZePLZUy059/VxFXymuPItpGqQhQZGHR6Dk1UAx9i/TmFVThBJitHgwqbbWuff3Y
EwSE0jRFli14d4wafs5y4qaTU1CcVNdNvbyazZBLsWnWRZW+67JNFJt0b+084TEF
Mcm5OuMHpnMBa4L1av/GdTAl1Yl2xh+0twq9Fb//Xp/FUOL+VRk=
=C9dP
-----END PGP SIGNATURE-----

--jT7wo9zRWold95waudiD65jTHKRtPcoi0--
