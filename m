Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726350AbgGPLbO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 07:31:14 -0400
Subject: Re: [kvm-unit-tests PATCH v13 6/9] s390x: Library resources for CSS
 tests
References: <1594887809-10521-1-git-send-email-pmorel@linux.ibm.com>
 <1594887809-10521-7-git-send-email-pmorel@linux.ibm.com>
 <9d6f0445-9c13-c23b-6095-0699ad09be87@linux.ibm.com>
 <196f3522-1880-c178-6ddd-56dd2d0b5256@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <7eda888a-88e9-98fe-96ac-d6c7ee1160bf@linux.ibm.com>
Date: Thu, 16 Jul 2020 13:31:06 +0200
MIME-Version: 1.0
In-Reply-To: <196f3522-1880-c178-6ddd-56dd2d0b5256@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fWlOGvODajraoI6g99s02uchNg5Ws9GXg"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, drjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fWlOGvODajraoI6g99s02uchNg5Ws9GXg
Content-Type: multipart/mixed; boundary="gUhQZikOYNet80HRzcmvLHdQVoABaL10c"

--gUhQZikOYNet80HRzcmvLHdQVoABaL10c
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/16/20 1:27 PM, Pierre Morel wrote:
>=20
>=20
> On 2020-07-16 13:15, Janosch Frank wrote:
>> On 7/16/20 10:23 AM, Pierre Morel wrote:
>>> Provide some definitions and library routines that can be used by
>>> tests targeting the channel subsystem.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Acked-by: Janosch Frank <frankja@de.ibm.com>
>>> ---
>> [...]
>>> diff --git a/s390x/Makefile b/s390x/Makefile
>>> index ddb4b48..050c40b 100644
>>> --- a/s390x/Makefile
>>> +++ b/s390x/Makefile
>>> @@ -51,6 +51,7 @@ cflatobjs +=3D lib/s390x/sclp-console.o
>>>   cflatobjs +=3D lib/s390x/interrupt.o
>>>   cflatobjs +=3D lib/s390x/mmu.o
>>>   cflatobjs +=3D lib/s390x/smp.o
>>> +cflatobjs +=3D lib/s390x/css_dump.o
>>>  =20
>>>   OBJDIRS +=3D lib/s390x
>>>  =20
>>
>> I need to fix this up when picking because Thomas added vm.o after smp=
=2Eo.
>> Can I do that or do you want to rebase on my next branch?
>>
>>
>=20
> I can do it and respin, that will give me the occasion to suppress the =

> goto as demanded by Thomas.
>=20
> Is it OK?
>=20


I won't say no to other people doing my work :)



--gUhQZikOYNet80HRzcmvLHdQVoABaL10c--

--fWlOGvODajraoI6g99s02uchNg5Ws9GXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8QOnoACgkQ41TmuOI4
ufgt+A//bGDkGZFz7FbXWRF4d6XmtvAZRYARk4xTK07UleZNzkzKYZnDJbV7MXXf
66qXASEhBabYOBdal9FUNF1jPQkc0WonX400+5KL7VbVGBEog9zSFwzxG2+PabOY
6OpUPioxHuCurqWoHPPjvIbrHxQ5vaYf04kVXbAeGyATAtIkS89+UYWaMFDH8Cj5
+jkkcRmiy1mdcaNGPYXvS1vtIU6sSCcpHoBEQMqfk0yaVgfmPQ8C0MrYwSG5+csi
fSOdL1z+WnO0fP/HGS/aRmasxjXNuPf58JR0ysmcUc0TbzRPD/rSbUIo64XaLv1C
dP48eoNsLVCR4A5eCGahVUK6FgqId3fCVkLK/gqg4q9Bm2QQZ0XNJa52N87vEWSf
UR983W7vl1UW3Kq7khV0ZqakGhBKTlJOyMMkelCmtCz0VNP0AIlUW8uZq9WAfZ3N
pFBY7VZQGfyFZTX41OuuDS1uyrQiNq1pHwCoc6dtLqPysGOtgkRK8oBDVb4g/RNE
yVYpb6auTnWBnAxI8GVC2oTncMuEqv+7npvDPyPIO+VTLnY94cABEuvIya88fN5D
0zjPgDsfqyFXheR9BWOspOYIHZo5G1o/qrjV0t9omXhUk4zCXjc83QPmsCx0Ja85
fDSQTEFXFsn3HibyjcDkj8soLK9cXeqYTA7pXsXpuA/AD5THyZ0=
=i/KY
-----END PGP SIGNATURE-----

--fWlOGvODajraoI6g99s02uchNg5Ws9GXg--
