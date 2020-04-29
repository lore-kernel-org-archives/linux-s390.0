Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgD2MKr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 08:10:47 -0400
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
 <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
 <18b6f022-81b7-6e0d-996d-3abcffceca41@linux.ibm.com>
 <be5ed01e-f4f6-6e3a-deb0-8f983e658e0f@linux.ibm.com>
 <8182df06-8190-001d-ad02-ae13fb99ec72@redhat.com>
 <802601e1-0bc0-faba-b802-2b0e24e3d96b@linux.ibm.com>
 <5ef08433-10fd-ccca-eb13-5a93bd462c4c@redhat.com>
 <cca03b19-4008-78c8-0528-e928b013b715@linux.ibm.com>
 <b1372d9f-ad21-af27-3c7f-1b60ab2e0597@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <23fb6bc6-6ac9-6337-4446-2248ce2b0a14@linux.ibm.com>
Date: Wed, 29 Apr 2020 14:09:56 +0200
MIME-Version: 1.0
In-Reply-To: <b1372d9f-ad21-af27-3c7f-1b60ab2e0597@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3QYPPD6zaBJgqfp2uDEI8aGWhYizReHVg"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3QYPPD6zaBJgqfp2uDEI8aGWhYizReHVg
Content-Type: multipart/mixed; boundary="xTsfu581ocqQii7oYwKUw1L8rYMjkpy6f"

--xTsfu581ocqQii7oYwKUw1L8rYMjkpy6f
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/29/20 1:47 PM, David Hildenbrand wrote:
> On 29.04.20 13:21, Janosch Frank wrote:
>> On 4/29/20 11:55 AM, David Hildenbrand wrote:
>>> On 29.04.20 11:37, Janosch Frank wrote:
>>>> On 4/29/20 11:06 AM, David Hildenbrand wrote:
>>>>> On 29.04.20 10:57, Janosch Frank wrote:
>>>>>> On 4/24/20 1:40 PM, Janosch Frank wrote:
>>>>>>> On 4/24/20 12:11 PM, David Hildenbrand wrote:
>>>>>>>> On 23.04.20 11:10, Janosch Frank wrote:
>>>>>>>>> Sigp orders are not necessarily finished when the processor fin=
ished
>>>>>>>>> the sigp instruction. We need to poll if the order has been fin=
ished
>>>>>>>>> before we continue.
>>>>>>>>>
>>>>>>>>> For (re)start and stop we already use sigp sense running and si=
gp
>>>>>>>>> sense loops. But we still lack completion checks for stop and s=
tore
>>>>>>>>> status, as well as the cpu resets.
>>>>>>>>>
>>>>>>>>> Let's add them.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>>>>>>> ---
>>>>>>>>>  lib/s390x/smp.c | 8 ++++++++
>>>>>>>>>  lib/s390x/smp.h | 1 +
>>>>>>>>>  s390x/smp.c     | 4 ++++
>>>>>>>>>  3 files changed, 13 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>>>>>>> index 6ef0335..2555bf4 100644
>>>>>>>>> --- a/lib/s390x/smp.c
>>>>>>>>> +++ b/lib/s390x/smp.c
>>>>>>>>> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct ps=
w psw)
>>>>>>>>>  	return rc;
>>>>>>>>>  }
>>>>>>>>> =20
>>>>>>>>> +void smp_cpu_wait_for_completion(uint16_t addr)
>>>>>>>>> +{
>>>>>>>>> +	uint32_t status;
>>>>>>>>> +
>>>>>>>>> +	/* Loops when cc =3D=3D 2, i.e. when the cpu is busy with a s=
igp order */
>>>>>>>>> +	sigp_retry(1, SIGP_SENSE, 0, &status);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>  int smp_cpu_destroy(uint16_t addr)
>>>>>>>>>  {
>>>>>>>>>  	struct cpu *cpu;
>>>>>>>>> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
>>>>>>>>> index ce63a89..a8b98c0 100644
>>>>>>>>> --- a/lib/s390x/smp.h
>>>>>>>>> +++ b/lib/s390x/smp.h
>>>>>>>>> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>>>>>>>>>  int smp_cpu_start(uint16_t addr, struct psw psw);
>>>>>>>>>  int smp_cpu_stop(uint16_t addr);
>>>>>>>>>  int smp_cpu_stop_store_status(uint16_t addr);
>>>>>>>>> +void smp_cpu_wait_for_completion(uint16_t addr);
>>>>>>>>>  int smp_cpu_destroy(uint16_t addr);
>>>>>>>>>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>>>>>>>>>  void smp_teardown(void);
>>>>>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>>>>>> index 7462211..48321f4 100644
>>>>>>>>> --- a/s390x/smp.c
>>>>>>>>> +++ b/s390x/smp.c
>>>>>>>>> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>>>>>>>>>  	lc->prefix_sa =3D 0;
>>>>>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>>>>>  	smp_cpu_stop_store_status(1);
>>>>>>>>> +	smp_cpu_wait_for_completion(1);
>>>>>>>>>  	mb();
>>>>>>>>>  	report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore=
, "prefix");
>>>>>>>>>  	report(lc->grs_sa[15], "stack");
>>>>>>>>> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>>>>>>>>>  	lc->prefix_sa =3D 0;
>>>>>>>>>  	lc->grs_sa[15] =3D 0;
>>>>>>>>>  	smp_cpu_stop_store_status(1);
>>>>>>>>
>>>>>>>> Just curious: Would it make sense to add that inside
>>>>>>>> smp_cpu_stop_store_status() instead?
>>>>>>>>
>>>>>>>
>>>>>>> I think so, we also wait for stop and start to finish, so why not=
 for
>>>>>>> this order code.
>>>>>>>
>>>>>>
>>>>>> I've moved the waiting into the smp library and now the prefix che=
ck for
>>>>>> stop and store status fails every so often if executed repeatedly.=

>>>>>>
>>>>>> I've tried making the lc ptr volatile, a print of the prefix befor=
e the
>>>>>> report seems to fix the issue, a print after the report still show=
s the
>>>>>> issue but according to the print both values are the same.
>>>>>>
>>>>>> I'm currently at a loss...
>>>>>
>>>>> Are you missing a barrier() somewhere?
>>>>>
>>>>
>>>> Maybe, but the question is where?
>>>>
>>>> There's already one before the report:
>>>> smp_cpu_stop_store_status(1);
>>>> mb();
>>>> report(lc->prefix_sa =3D=3D (uint32_t)(uintptr_t)cpu->lowcore, "pref=
ix");
>>>
>>> The issue here is:
>>>
>>> SIGP_SENSE is always handled in the kernel for KVM. Meaning, it will
>>> complete even before the target CPU executed the stop and store (in Q=
EMU).
>>>
>>> Reading the PoP:
>>>
>>> "One of the following conditions exists at the
>>> addressed CPU: ... A previously issued stop-
>>> and-store-status ... has been accepted by the
>>> addressed CPU, and execution of the func-
>>> tion requested by the order has not yet been
>>> completed.
>>>
>>> "If the currently specified order is sense ... then the order
>>> is rejected, and condition code 2 is set."
>>>
>>> So, in case of KVM, SENSE does not wait for completion of the previou=
s
>>> order. I remember that was a performance improvements, because we wan=
ted
>>> to avoid going to user space just to sense if another CPU is running.=

>>> (and I remember that the documentation was inconsistent)
>>
>> So, KVM is not architectural compliant when it comes to SIGP SENSE?
>> I guess I need to go back to looping until the prefix is > 0
>=20
> Yeah, or fix SIGP_SENSE in KVM. Would need QEMU and KVM changes. I
> remember that a tricky part was checking if external calls are pending
> for a CPU from user space.
>=20
> We could pass that information along with the intercept to QEMU.
>=20
> AFAIKs, SIGP SENSE is not used on a hot path in Linux.
>=20

For now I'd rather have a workaround in the test until I can find cycles
to find a solution in KVM/QEMU.

SIGP SENSE has been working quite well for Linux for the last few years,
so I won't start running around now frantically fixing stuff.



--xTsfu581ocqQii7oYwKUw1L8rYMjkpy6f--

--3QYPPD6zaBJgqfp2uDEI8aGWhYizReHVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6pbpQACgkQ41TmuOI4
ufgAyQ//eP/bjZQ0TahIUEjFu175vKYj68EDmwEamk81bVGAdhPNCqySsLo5mozD
U76DmyuHI6+ZH677dhvTup6zPUPJk//JEYkSwqUdXyxrxFb5zn6f/Sepls1FnRtZ
Mb9wYiYUmZaI3X4V2rAq6TTW45EW3tVObnkqtBJ1yRkq7cQHwo7P0JHUL7z/74KR
kakPZ2H23yslqfD1/WrH6n99StaiF/BPT4UOxVKsOznjpnjcYiH+c5qRxxbUUCIp
o7otGXUNwAsFt0YsIKqyxjZ2PREVBNF7QwZdAm2CB2BAR8yQoxmtlAyDLQBzOrFQ
4W+TgsZKYKU/Rl/FvlZ1XZB4R4dSO3RkrxhiU8bVOBoYiAE65/8lndD5zRCLXE9P
dIRMxkydK4PZXANVtM1UEOgcLBavLBhA//yhlWpEW5u+/eaymMP4ki7OOfkiEBOd
pIdUu6MU0xnNCnhyoxTH+CBvSfDVeoy99m2yTha81uIpu0nBXQSddq3abG292Unb
HK8bafxKviT70tmeYfb8rynpy+ecVh6TLFEOtJypD1pErDKX8HeGtoUDq+PI0xcN
gptac3SLlocPKp+nPsXpCbxaDkx3XJrASIxEZ77IqnXKxcX50Qrwn2towwJ1azu8
qO2sMAgYl6aIiFOCv/ihx/82/uN8CuPmdz/2eV8BKqvI9cvxDVo=
=ovs7
-----END PGP SIGNATURE-----

--3QYPPD6zaBJgqfp2uDEI8aGWhYizReHVg--
