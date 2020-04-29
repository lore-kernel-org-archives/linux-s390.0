Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgD2I5y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 04:57:54 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
From: Janosch Frank <frankja@linux.ibm.com>
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
 <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
Message-ID: <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
Date: Wed, 29 Apr 2020 10:57:47 +0200
MIME-Version: 1.0
In-Reply-To: <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JJmV7n0Z7pSiuoaW1kHEzigvZdLkQGjir"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JJmV7n0Z7pSiuoaW1kHEzigvZdLkQGjir
Content-Type: multipart/mixed; boundary="vZiWajRVpW8Er2C6gMF6UOrXRgiDzaxys"

--vZiWajRVpW8Er2C6gMF6UOrXRgiDzaxys
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 1:40 PM, Janosch Frank wrote:
> On 4/24/20 12:11 PM, David Hildenbrand wrote:
>> On 23.04.20 11:10, Janosch Frank wrote:
>>> Sigp orders are not necessarily finished when the processor finished
>>> the sigp instruction. We need to poll if the order has been finished
>>> before we continue.
>>>
>>> For (re)start and stop we already use sigp sense running and sigp
>>> sense loops. But we still lack completion checks for stop and store
>>> status, as well as the cpu resets.
>>>
>>> Let's add them.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  lib/s390x/smp.c | 8 ++++++++
>>>  lib/s390x/smp.h | 1 +
>>>  s390x/smp.c     | 4 ++++
>>>  3 files changed, 13 insertions(+)
>>>
>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>> index 6ef0335..2555bf4 100644
>>> --- a/lib/s390x/smp.c
>>> +++ b/lib/s390x/smp.c
>>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw psw)=

>>>  	return rc;
>>>  }
>>> =20
>>> +void smp_cpu_wait_for_completion(uint16_t addr)
>>> +{
>>> +	uint32_t status;
>>> +
>>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sigp or=
der */
>>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>>> +}
>>> +
>>>  int smp_cpu_destroy(uint16_t addr)
>>>  {
>>>  	struct cpu *cpu;
>>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>>> index ce63a89..a8b98c0 100644
>>> --- a/lib/s390x/smp.h
>>> +++ b/lib/s390x/smp.h
>>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>>  int smp_cpu_stop(uint16_t addr);
>>>  int smp_cpu_stop_store_status(uint16_t addr);
>>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>>  int smp_cpu_destroy(uint16_t addr);
>>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>>  void smp_teardown(void);
>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>> index 7462211..48321f4 100644
>>> --- a/s390x/smp.c
>>> +++ b/s390x/smp.c
>>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>>  	lc->prefix_sa =3D 0;
>>>  	lc->grs_sa[15] =3D 0;
>>>  	smp_cpu_stop_store_status(1);
>>> +	smp_cpu_wait_for_completion(1);
>>>  	mb();
>>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "pre=
fix");
>>>  	report(lc->grs_sa[15], "stack");
>>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>>  	lc->prefix_sa =3D 0;
>>>  	lc->grs_sa[15] =3D 0;
>>>  	smp_cpu_stop_store_status(1);
>>
>> Just curious: Would it make sense to add that inside
>> smp_cpu_stop_store_status() instead?
>>
>=20
> I think so, we also wait for stop and start to finish, so why not for
> this order code.
>=20

I've moved the waiting into the smp library and now the prefix check for
stop and store status fails every so often if executed repeatedly.

I've tried making the lc ptr volatile, a print of the prefix before the
report seems to fix the issue, a print after the report still shows the
issue but according to the print both values are the same.

I'm currently at a loss...


--vZiWajRVpW8Er2C6gMF6UOrXRgiDzaxys--

--JJmV7n0Z7pSiuoaW1kHEzigvZdLkQGjir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6pQYsACgkQ41TmuOI4
ufiF+hAAqxn+XBIYYlEar4mJAvJd796XVHNB5Uqdps58mglD7tGvQrHgmpvq66C6
EJAsQj7ppws7hiIOWTfWJ62ldcYXZez60gWpX1mU8baMLpFPndKg529r0lM/B4XC
6cvmOSuWsX6GdoNTCQ9tveeTOtm0Lh0OohwBhR4/oTv4Fn+m479xtdVAkFK/TsSt
ARpTFLLZmieQOX+ObKsNdkWpUdo2cr6lWtR2PaRAK81/7HbjaPML48K0FBnqiSPW
4fqOoh0qx4sTjngwel4PqRCvzYjiFYofXOxZWa0OFe85fg1Kjwv5WO+kVCanXtiH
mchRYm1dzX1I29tK7lWYTI/sntW/0CQlC6SK8awsg6FHIMWXg1XseYrW4GjGvTPs
AhiDMU9I0/xH1R43EP5nXN1I9DhTa8y7S5TE7eh02OjUDfauNhOKeJqveWQQIUiq
ifNbINv0C1G4WZ1vSwdSrRkD3PuKvFguW00Iftzhyl8doWzun6McsGWsX52AuDP1
BE+eFwOUcU//wdMu9D0DPpVVaqYbJeit+HHNJUAinrs95c855x6ZRKuc86i3msrB
Kj+IgbrtXEcyl9yZCBZHz2MgtMAUrNxoLNyIwoeOfNc950wBPlpkU0TgKH+bQv5c
yozXK8Vo/Bn0eJT+gpAVkIZvJhUuog7DqvVGVHSAVtTCFDsZ0Hs=
=evfa
-----END PGP SIGNATURE-----

--JJmV7n0Z7pSiuoaW1kHEzigvZdLkQGjir--
