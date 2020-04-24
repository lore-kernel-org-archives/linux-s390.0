Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgDXLkj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 07:40:39 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
Date: Fri, 24 Apr 2020 13:40:32 +0200
MIME-Version: 1.0
In-Reply-To: <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1dtVzlnF2uFlVWdwk4H55XyK6gJkJS1ED"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1dtVzlnF2uFlVWdwk4H55XyK6gJkJS1ED
Content-Type: multipart/mixed; boundary="tovXjwoxTzPIZOfSeoIVFjG4X6a1xCpIg"

--tovXjwoxTzPIZOfSeoIVFjG4X6a1xCpIg
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:11 PM, David Hildenbrand wrote:
> On 23.04.20 11:10, Janosch Frank wrote:
>> Sigp orders are not necessarily finished when the processor finished
>> the sigp instruction. We need to poll if the order has been finished
>> before we continue.
>>
>> For (re)start and stop we already use sigp sense running and sigp
>> sense loops. But we still lack completion checks for stop and store
>> status, as well as the cpu resets.
>>
>> Let's add them.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  lib/s390x/smp.c | 8 ++++++++
>>  lib/s390x/smp.h | 1 +
>>  s390x/smp.c     | 4 ++++
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index 6ef0335..2555bf4 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw psw)
>>  	return rc;
>>  }
>> =20
>> +void smp_cpu_wait_for_completion(uint16_t addr)
>> +{
>> +	uint32_t status;
>> +
>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sigp ord=
er */
>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>> +}
>> +
>>  int smp_cpu_destroy(uint16_t addr)
>>  {
>>  	struct cpu *cpu;
>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>> index ce63a89..a8b98c0 100644
>> --- a/lib/s390x/smp.h
>> +++ b/lib/s390x/smp.h
>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>  int smp_cpu_stop(uint16_t addr);
>>  int smp_cpu_stop_store_status(uint16_t addr);
>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>  int smp_cpu_destroy(uint16_t addr);
>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>  void smp_teardown(void);
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 7462211..48321f4 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>  	lc->prefix_sa =3D 0;
>>  	lc->grs_sa[15] =3D 0;
>>  	smp_cpu_stop_store_status(1);
>> +	smp_cpu_wait_for_completion(1);
>>  	mb();
>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "pref=
ix");
>>  	report(lc->grs_sa[15], "stack");
>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>  	lc->prefix_sa =3D 0;
>>  	lc->grs_sa[15] =3D 0;
>>  	smp_cpu_stop_store_status(1);
>=20
> Just curious: Would it make sense to add that inside
> smp_cpu_stop_store_status() instead?
>=20

I think so, we also wait for stop and start to finish, so why not for
this order code.


--tovXjwoxTzPIZOfSeoIVFjG4X6a1xCpIg--

--1dtVzlnF2uFlVWdwk4H55XyK6gJkJS1ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6i0DAACgkQ41TmuOI4
ufhOixAArb9ADQysyIKH++SOnhOCz1mVzhon0t6G6Ca5WJYZd2g74NMzBA7mOw6u
Qwv5Ma5iztVNQs8QM+U0v8UMVh8sIL5Vbi3MosfKo7GVAZmQ1/M9Qje//qEK2TNJ
uhMtC0hCzW1NsS1bywDZVplJLfkIq7KXk6GkhBgVdS+mP83nkdH/yVNlz/4V5xVZ
YOv3enjPTtu6KdXI0WG9mjJ1LcBpZIMlzHqafaBb6sE1wGV5x/LI2dZjqiITV3Jt
VF6FfqP2l3sIahT5V0B0UKRCHZcNYugilHLDQAksHQJWdhnMXsDb+6Szd8r6Xut8
DdE2DYyqxHfDiAI0sa1mdnjLm2iCdL5Wurg0O+/IJTbrVPChU43zCY38+p6QVIoj
WXlBn4wjtSBR8NeACDT+QyCtpmWNH954AovZtJ7fhQXZ91j4BfItQ3M5GCrLjY/t
FArNe/t0FdWTeqBdGc9BmUGGMA83cHtAmh4F8vROqsp4FD8OPPn3z/OdH3Af/qfp
I+TkB4ureO6jaK4Zg9+aHusjeCs87RwOtOdD8nJMwkT/0uuLO51PutoX+Gm5Coyv
Z0vu8yJoo4mYoM2vzY1RXSkbLpXw9BvvHjCKwRDbEEh4PirUq0udKXIxMgh1dc4P
pQurCyXyeIolx8F/lZ4RUG4sw9qbxPJHiFSZ0Mfyip0pf6FcGi4=
=xwZW
-----END PGP SIGNATURE-----

--1dtVzlnF2uFlVWdwk4H55XyK6gJkJS1ED--
