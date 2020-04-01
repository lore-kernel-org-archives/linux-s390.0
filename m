Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732058AbgDAHUC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Apr 2020 03:20:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03174Uu1026729
        for <linux-s390@vger.kernel.org>; Wed, 1 Apr 2020 03:20:01 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 304k3h4s9y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 01 Apr 2020 03:20:01 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 1 Apr 2020 08:19:49 +0100
Subject: Re: [kvm-unit-tests PATCH 04/10] s390x: smp: Test local interrupts
 after cpu reset
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-5-frankja@linux.ibm.com>
 <b6f1d06b-aaa5-bdd5-5491-32c8338f9ead@redhat.com>
 <126883fa-6c1e-a1e3-34f0-689cd2c0b7c4@linux.ibm.com>
 <3631ad95-6920-1089-6e87-8687c9f100b6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 1 Apr 2020 09:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <3631ad95-6920-1089-6e87-8687c9f100b6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vkJC8xElT4Mmm5cGMn7V5xz2B3fUqL2PA"
Message-Id: <9c11caa4-04ff-7cc9-8f62-371d2d200048@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vkJC8xElT4Mmm5cGMn7V5xz2B3fUqL2PA
Content-Type: multipart/mixed; boundary="61YDvkVaaaKDiIBR2yHRg4Skc4mSea2kn"

--61YDvkVaaaKDiIBR2yHRg4Skc4mSea2kn
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/31/20 7:27 PM, David Hildenbrand wrote:
> On 31.03.20 11:28, Janosch Frank wrote:
>> On 3/31/20 11:07 AM, David Hildenbrand wrote:
>>> On 24.03.20 09:12, Janosch Frank wrote:
>>>> Local interrupts (external and emergency call) should be cleared aft=
er
>>>> any cpu reset.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  s390x/smp.c | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>> index 8a6cd1d8b17d76c6..a8e3dd7aac0c788c 100644
>>>> --- a/s390x/smp.c
>>>> +++ b/s390x/smp.c
>>>> @@ -243,6 +243,20 @@ static void test_reset_initial(void)
>>>>  	report_prefix_pop();
>>>>  }
>>>> =20
>>>> +static void test_local_ints(void)
>>>> +{
>>>> +	unsigned long mask;
>>>> +
>>>> +	expect_ext_int();
>>>> +	/* Open masks for ecall and emcall */
>>>> +	ctl_set_bit(0, 13);
>>>> +	ctl_set_bit(0, 14);
>>>> +	mask =3D extract_psw_mask();
>>>> +	mask |=3D PSW_MASK_EXT;
>>>> +	load_psw_mask(mask);
>>>> +	set_flag(1);
>>>> +}
>>>> +
>>>>  static void test_reset(void)
>>>>  {
>>>>  	struct psw psw;
>>>> @@ -251,10 +265,18 @@ static void test_reset(void)
>>>>  	psw.addr =3D (unsigned long)test_func;
>>>> =20
>>>>  	report_prefix_push("cpu reset");
>>>> +	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>>>> +	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>>>>  	smp_cpu_start(1, psw);
>>>> =20
>>>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>>>  	report(smp_cpu_stopped(1), "cpu stopped");
>>>> +
>>>> +	set_flag(0);
>>>> +	psw.addr =3D (unsigned long)test_local_ints;
>>>> +	smp_cpu_start(1, psw);
>>>> +	wait_for_flag();
>>>> +	report(true, "local interrupts cleared");
>>>
>>>
>>> How can you be sure they were actually cleared/delivered?
>>>
>> Because cpu 1 would get a ext int it didn't expect and would do a
>> report_abort() as pecified in lib/s390x/interrupt.c
>=20
> But what if it *didn't* get the interrupts delivered.

Well, the target is still looping until the reset initial test is
executed and from personal experience I can say that this test bites
rather fast.

We could execute an instruction with a mandatory exit which will prompt
KVM to inject any remaining IRQs before setting the flag to 1.

Unfortunately we do not have a polling instruction for non-IO interrupts
at the moment to verify this test.

>=20
> Then cpu 1 will simply (test_local_ints()) unlock interrupts, load the
> psw mask, set the flag and be done with it. What am I missing? How can
> you be sure the interrupts on cpu 1 were actually delivered?
>


--61YDvkVaaaKDiIBR2yHRg4Skc4mSea2kn--

--vkJC8xElT4Mmm5cGMn7V5xz2B3fUqL2PA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6EQJsACgkQ41TmuOI4
ufiTRBAAuzGx7dNmrudZWnWZc+cruG5A8mUhao6pZRuPeDowoqAo0o2GEyocu02r
ILtR9fWfP+Q4aCahFa8s9taGRNAaYGwaGmDkRfORP1WqmuPEwFxYVtXGh+HhjTMQ
LLcAnkmSWEIZNDPCLxcDv5cBK7+KRipgt11YYEoEiv2Ei19OoVfnODFXX79NT1S2
ku4Cw++WT2ZAvtAdeK0143XrnTx5LEgm3CffJDUk7LMVBwGQ+9TSq8DwNdG1K7BS
XNSBJIZTkX94kysFYjs99/Yn30G0zUliIAtPZtV3cn8vv9uQl5zJd9iUwk85y4lG
zBIQNTyz8CcQU7w9ZSD8UetoEAyMvQ2DVmqwTESjTPdOfoRuZIT9k4tL1Mq8X9BM
6aRda/CqeNC97N9w7Q7KWxjvwa/Qsx1UAeCCtbtHLZAvDfYZetMEMPLjYOjE5EmZ
0vY0eaWC23TaTkBnqv7gUa5kaLiJZKyM8P9HEsdOSwPbR5/yNqsuFva+DmiOUJuT
6a/4mI0GSuhV8W/eyeLxyHf9glAE9T7dzS1+CbZSQSH2HkKYE9QpybyblPgLJ/Y2
1k6LclfXbzV4Dfvz92zFpo5wdikMZDQFPzq2WCaJzkdANrlO73VAAuUY69KcjhbI
vXnlAKu4FByH3uYZP4BkbrgMXE7nKZqP3la24VTpc16rLCor3qU=
=dgVV
-----END PGP SIGNATURE-----

--vkJC8xElT4Mmm5cGMn7V5xz2B3fUqL2PA--
