Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3128 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbgD2LWE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 07:22:04 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
 <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
 <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
 <8182df06-8190-001d-ad02-ae13fb99ec72@redhat.com>
 <802601e1-0bc0-faba-b802-2b0e24e3d96b@linux.ibm.com>
 <5ef08433-10fd-ccca-eb13-5a93bd462c4c@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <cca03b19-4008-78c8-0528-e928b013b715@linux.ibm.com>
Date: Wed, 29 Apr 2020 13:21:55 +0200
MIME-Version: 1.0
In-Reply-To: <5ef08433-10fd-ccca-eb13-5a93bd462c4c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AFkMIbYYyPMjYuJis6b3AjhZG5e2ItJvQ"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AFkMIbYYyPMjYuJis6b3AjhZG5e2ItJvQ
Content-Type: multipart/mixed; boundary="8Fu9ttuanlOsX3VIhRL4kTXL8NKMGftkD"

--8Fu9ttuanlOsX3VIhRL4kTXL8NKMGftkD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/29/20 11:55 AM, David Hildenbrand wrote:
> On 29.04.20 11:37, Janosch Frank wrote:
>> On 4/29/20 11:06 AM, David Hildenbrand wrote:
>>> On 29.04.20 10:57, Janosch Frank wrote:
>>>> On 4/24/20 1:40 PM, Janosch Frank wrote:
>>>>> On 4/24/20 12:11 PM, David Hildenbrand wrote:
>>>>>> On 23.04.20 11:10, Janosch Frank wrote:
>>>>>>> Sigp orders are not necessarily finished when the processor finis=
hed
>>>>>>> the sigp instruction. We need to poll if the order has been finis=
hed
>>>>>>> before we continue.
>>>>>>>
>>>>>>> For (re)start and stop we already use sigp sense running and sigp=

>>>>>>> sense loops. But we still lack completion checks for stop and sto=
re
>>>>>>> status, as well as the cpu resets.
>>>>>>>
>>>>>>> Let's add them.
>>>>>>>
>>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>>>>> ---
>>>>>>>  lib/s390x/smp.c | 8 ++++++++
>>>>>>>  lib/s390x/smp.h | 1 +
>>>>>>>  s390x/smp.c     | 4 ++++
>>>>>>>  3 files changed, 13 insertions(+)
>>>>>>>
>>>>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>>>>> index 6ef0335..2555bf4 100644
>>>>>>> --- a/lib/s390x/smp.c
>>>>>>> +++ b/lib/s390x/smp.c
>>>>>>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw =
psw)
>>>>>>>  	return rc;
>>>>>>>  }
>>>>>>> =20
>>>>>>> +void smp_cpu_wait_for_completion(uint16_t addr)
>>>>>>> +{
>>>>>>> +	uint32_t status;
>>>>>>> +
>>>>>>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a sig=
p order */
>>>>>>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>>>>>>> +}
>>>>>>> +
>>>>>>>  int smp_cpu_destroy(uint16_t addr)
>>>>>>>  {
>>>>>>>  	struct cpu *cpu;
>>>>>>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>>>>>>> index ce63a89..a8b98c0 100644
>>>>>>> --- a/lib/s390x/smp.h
>>>>>>> +++ b/lib/s390x/smp.h
>>>>>>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>>>>>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>>>>>>  int smp_cpu_stop(uint16_t addr);
>>>>>>>  int smp_cpu_stop_store_status(uint16_t addr);
>>>>>>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>>>>>>  int smp_cpu_destroy(uint16_t addr);
>>>>>>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>>>>>>  void smp_teardown(void);
>>>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>>>> index 7462211..48321f4 100644
>>>>>>> --- a/s390x/smp.c
>>>>>>> +++ b/s390x/smp.c
>>>>>>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>>>>>>  	lc->prefix_sa =3D 0;
>>>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>>>  	smp_cpu_stop_store_status(1);
>>>>>>> +	smp_cpu_wait_for_completion(1);
>>>>>>>  	mb();
>>>>>>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, =
"prefix");
>>>>>>>  	report(lc->grs_sa[15], "stack");
>>>>>>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>>>>>>  	lc->prefix_sa =3D 0;
>>>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>>>  	smp_cpu_stop_store_status(1);
>>>>>>
>>>>>> Just curious: Would it make sense to add that inside
>>>>>> smp_cpu_stop_store_status() instead?
>>>>>>
>>>>>
>>>>> I think so, we also wait for stop and start to finish, so why not f=
or
>>>>> this order code.
>>>>>
>>>>
>>>> I've moved the waiting into the smp library and now the prefix check=
 for
>>>> stop and store status fails every so often if executed repeatedly.
>>>>
>>>> I've tried making the lc ptr volatile, a print of the prefix before =
the
>>>> report seems to fix the issue, a print after the report still shows =
the
>>>> issue but according to the print both values are the same.
>>>>
>>>> I'm currently at a loss...
>>>
>>> Are you missing a barrier() somewhere?
>>>
>>
>> Maybe, but the question is where?
>>
>> There's already one before the report:
>> smp_cpu_stop_store_status(1);
>> mb();
>> report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "prefix=
");
>=20
> The issue here is:
>=20
> SIGP_SENSE is always handled in the kernel for KVM. Meaning, it will
> complete even before the target CPU executed the stop and store (in QEM=
U).
>=20
> Reading the PoP:
>=20
> "One of the following conditions exists at the
> addressed CPU: ... A previously issued stop-
> and-store-status ... has been accepted by the
> addressed CPU, and execution of the func-
> tion requested by the order has not yet been
> completed.
>=20
> "If the currently specified order is sense ... then the order
> is rejected, and condition code 2 is set."
>=20
> So, in case of KVM, SENSE does not wait for completion of the previous
> order. I remember that was a performance improvements, because we wante=
d
> to avoid going to user space just to sense if another CPU is running.
> (and I remember that the documentation was inconsistent)

So, KVM is not architectural compliant when it comes to SIGP SENSE?
I guess I need to go back to looping until the prefix is > 0

>=20
> Let me guess, under TCG it works all the time?
>=20

Looks like it


--8Fu9ttuanlOsX3VIhRL4kTXL8NKMGftkD--

--AFkMIbYYyPMjYuJis6b3AjhZG5e2ItJvQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6pY1MACgkQ41TmuOI4
ufhIDBAAg7ymSuk41BlKrPlv+yMw8Jxns4PcXKvT5D+FSiO2sBIgNEMgz2bvId/I
0YHyQMlHGLzsmYrdurhnqqHNdQUql6xCU08IapBA0hQwdmclM/ky2EvfsX6cD0GT
4krK19bYyHgX0f375lyYzrPRK9FZ1j2ipAC0WHhoXXeEdCyTJBLDQlbm+NbBnRXP
3R+HZieRBz3yRuMI3XpMcNxF6g0aCzlkHbqC9HLnalQ/Kxfo9ZRRobIlyTJmM5bi
u7koADLK8WcfVwZhV9ru8S9avQM7Cb5+QEY2/0XoyO7xGRHRq8V9/5Mwd34/Akli
50HNsNKbeePebj1Pyfezb8IKDovTSAGfs82xooAlHamMCpmWJ6L7tEh+VYG3j5jK
+7k/L31G+v98B5J5i+UwPTF+EyKkK3kihiBpme5ENmv7lOsTZR3z1AgCavaVzU4I
S2XXo7PJVxeApOpylMSUZZtgi9oEVuNrT7o6Jqi1uk/qaPm8dOGhkcLvlGiHVH5v
919kQgBg/3QusevwtU6gcXg8kEFdAKjZyT0MCgjGPXI0BajTUva7itQcpK5nY1P3
r5d1U9gV3f9bh7jU1UkIPJ+VIc+cLT5WlFSyJuVwM8piztZh1ovp0vF8mLwg2xC+
hvnZ3LMoSCaBSaanL9m141RcWpK3GUyNzvcMHjJBI+Ngbu597IY=
=a5Cu
-----END PGP SIGNATURE-----

--AFkMIbYYyPMjYuJis6b3AjhZG5e2ItJvQ--
