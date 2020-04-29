Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgD2JhQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 05:37:16 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
 <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
 <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
 <8182df06-8190-001d-ad02-ae13fb99ec72@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <802601e1-0bc0-faba-b802-2b0e24e3d96b@linux.ibm.com>
Date: Wed, 29 Apr 2020 11:37:08 +0200
MIME-Version: 1.0
In-Reply-To: <8182df06-8190-001d-ad02-ae13fb99ec72@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8jclk4mYtRsZHXn2kDnAmH3atPsfA6eIG"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8jclk4mYtRsZHXn2kDnAmH3atPsfA6eIG
Content-Type: multipart/mixed; boundary="IBASGxB4aMxdlHjjPC7YrfMmVmD1AFU2y"

--IBASGxB4aMxdlHjjPC7YrfMmVmD1AFU2y
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/29/20 11:06 AM, David Hildenbrand wrote:
> On 29.04.20 10:57, Janosch Frank wrote:
>> On 4/24/20 1:40 PM, Janosch Frank wrote:
>>> On 4/24/20 12:11 PM, David Hildenbrand wrote:
>>>> On 23.04.20 11:10, Janosch Frank wrote:
>>>>> Sigp orders are not necessarily finished when the processor finishe=
d
>>>>> the sigp instruction. We need to poll if the order has been finishe=
d
>>>>> before we continue.
>>>>>
>>>>> For (re)start and stop we already use sigp sense running and sigp
>>>>> sense loops. But we still lack completion checks for stop and store=

>>>>> status, as well as the cpu resets.
>>>>>
>>>>> Let's add them.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>>> ---
>>>>>  lib/s390x/smp.c | 8 ++++++++
>>>>>  lib/s390x/smp.h | 1 +
>>>>>  s390x/smp.c     | 4 ++++
>>>>>  3 files changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>>> index 6ef0335..2555bf4 100644
>>>>> --- a/lib/s390x/smp.c
>>>>> +++ b/lib/s390x/smp.c
>>>>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw ps=
w)
>>>>>  	return rc;
>>>>>  }
>>>>> =20
>>>>> +void smp_cpu_wait_for_completion(uint16_t addr)
>>>>> +{
>>>>> +	uint32_t status;
>>>>> +
>>>>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sigp =
order */
>>>>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>>>>> +}
>>>>> +
>>>>>  int smp_cpu_destroy(uint16_t addr)
>>>>>  {
>>>>>  	struct cpu *cpu;
>>>>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>>>>> index ce63a89..a8b98c0 100644
>>>>> --- a/lib/s390x/smp.h
>>>>> +++ b/lib/s390x/smp.h
>>>>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>>>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>>>>  int smp_cpu_stop(uint16_t addr);
>>>>>  int smp_cpu_stop_store_status(uint16_t addr);
>>>>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>>>>  int smp_cpu_destroy(uint16_t addr);
>>>>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>>>>  void smp_teardown(void);
>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>> index 7462211..48321f4 100644
>>>>> --- a/s390x/smp.c
>>>>> +++ b/s390x/smp.c
>>>>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>>>>  	lc->prefix_sa =3D 0;
>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>  	smp_cpu_stop_store_status(1);
>>>>> +	smp_cpu_wait_for_completion(1);
>>>>>  	mb();
>>>>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "p=
refix");
>>>>>  	report(lc->grs_sa[15], "stack");
>>>>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>>>>  	lc->prefix_sa =3D 0;
>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>  	smp_cpu_stop_store_status(1);
>>>>
>>>> Just curious: Would it make sense to add that inside
>>>> smp_cpu_stop_store_status() instead?
>>>>
>>>
>>> I think so, we also wait for stop and start to finish, so why not for=

>>> this order code.
>>>
>>
>> I've moved the waiting into the smp library and now the prefix check f=
or
>> stop and store status fails every so often if executed repeatedly.
>>
>> I've tried making the lc ptr volatile, a print of the prefix before th=
e
>> report seems to fix the issue, a print after the report still shows th=
e
>> issue but according to the print both values are the same.
>>
>> I'm currently at a loss...
>=20
> Are you missing a barrier() somewhere?
>=20

Maybe, but the question is where?

There's already one before the report:
smp_cpu_stop_store_status(1);
mb();
report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "prefix");=





--IBASGxB4aMxdlHjjPC7YrfMmVmD1AFU2y--

--8jclk4mYtRsZHXn2kDnAmH3atPsfA6eIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6pSsQACgkQ41TmuOI4
ufi62Q//Qrrr2r9IqXzfJVOnMShi4PFek6mM8JMNK9ylKtqnimDUdWTdqdZ4HjsX
qX3EIglD5MxyY2q0Vgax+4mtE3zrMBhn1ayQEpBXvSJGs9svweBKuQ4afl6P1ALE
TMUfxCvtk8xB4ZxzIKKX4l+b6eVEZ7UKS7Aun2AC0xsr3VsOpK/BOWdXmUrk0YRG
YHwyFqYcvlH3yChnIlu10LS7ZRDT8RTb5dnR5MozHp2qGQZXbcx18JaOG3n2jHy2
pqy7ANN05CkNe0/mzsHkxX47YBRbzpsc220ZECjqbnqfxex+smBYG2CynN05Kipd
QzoAmmGGSCyrHaBKIGOyfo98+YisKKUWcugB5tX8gD/c2g/ZfT/Oke2qN+tsjMtN
zguekReHbsjr4XtOiQuN1QSg16s+uowjYngph+icHZj8wxnYp2oQZ9vnp6X17VyV
ORM1uWuXIHJwumr5pvIG+EV2DfBLBNxKZ/uNSDtMIFvF0GMaaCEs9XFKJueFVuqP
U3KJOshLTz6fYCpJ3Lb4ZYHxWuw5e6KRyvVZBUow2J8p/QuZc9t2bc3yc/5GNJBt
faUN6H5ZO/EAuYgF2D9huIh0HRiRJlhCoFZ1KvP6ZLaOM5C+sobUn8eLSm2a+hzs
7CmAuULRDzhcwq50xSk4TaybwQqw8IsNumy2OkdEw+LX6gQGYII=
=G+Q2
-----END PGP SIGNATURE-----

--8jclk4mYtRsZHXn2kDnAmH3atPsfA6eIG--
