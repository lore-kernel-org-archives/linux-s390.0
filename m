Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728680AbgAUNIE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 08:08:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LD0AIC112769
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:08:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmghb14d4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 08:08:02 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 13:08:00 -0000
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu
 loops
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-8-frankja@linux.ibm.com>
 <20200120122956.6879d159.cohuck@redhat.com>
 <97f7f794-e0be-3984-99b2-ba229212fd3e@linux.ibm.com>
 <20200120171113.02a9b807.cohuck@redhat.com>
 <f0f17e60-29b6-12b1-6692-5da745cbe60a@linux.ibm.com>
 <20200121135911.4d41c418.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 21 Jan 2020 14:07:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200121135911.4d41c418.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bCmHwAiM1FvN6J4364I56N1i753EkjL6r"
Message-Id: <9236567e-f70a-1e0b-6582-150ec83f9604@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bCmHwAiM1FvN6J4364I56N1i753EkjL6r
Content-Type: multipart/mixed; boundary="92Hi3je3Cq1vBcrlMeshqfdBRVnBqtOZD"

--92Hi3je3Cq1vBcrlMeshqfdBRVnBqtOZD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/21/20 1:59 PM, Cornelia Huck wrote:
> On Tue, 21 Jan 2020 13:46:51 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 1/20/20 5:11 PM, Cornelia Huck wrote:
>>> On Mon, 20 Jan 2020 15:41:52 +0100
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> On 1/20/20 12:29 PM, Cornelia Huck wrote: =20
>>>>> On Fri, 17 Jan 2020 05:46:38 -0500
>>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>>>    =20
>>>>>> Now that we have a loop which is executed after we return from the=

>>>>>> main function of a secondary cpu, we can remove the surplus loops.=

>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> ---
>>>>>>  s390x/smp.c | 8 +-------
>>>>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>>>> index 555ed72..c12a3db 100644
>>>>>> --- a/s390x/smp.c
>>>>>> +++ b/s390x/smp.c
>>>>>> @@ -29,15 +29,9 @@ static void wait_for_flag(void)
>>>>>>  	}
>>>>>>  }
>>>>>> =20
>>>>>> -static void cpu_loop(void)
>>>>>> -{
>>>>>> -	for (;;) {}
>>>>>> -}
>>>>>> -
>>>>>>  static void test_func(void)
>>>>>>  {
>>>>>>  	testflag =3D 1;
>>>>>> -	cpu_loop();
>>>>>>  }
>>>>>> =20
>>>>>>  static void test_start(void)
>>>>>> @@ -234,7 +228,7 @@ int main(void)
>>>>>> =20
>>>>>>  	/* Setting up the cpu to give it a stack and lowcore */
>>>>>>  	psw.mask =3D extract_psw_mask();
>>>>>> -	psw.addr =3D (unsigned long)cpu_loop;
>>>>>> +	psw.addr =3D (unsigned long)test_func;   =20
>>>>>
>>>>> Before, you did not set testflag here... intended change?   =20
>>>>
>>>> Yes
>>>> It is set to 0 before the first test, so it shouldn't matter. =20
>>>
>>> Hm... I got a bit lost in all those changes, so I checked your branch=

>>> on github, and I don't see it being set to 0 before test_start() is
>>> called? =20
>>
>> Well, that's because test_start doesn't care about the flag.
>=20
> But I see a wait_for_flag() in there? What am I missing?
>=20
>> ecall and emcall are the first users, and they set it to 0 before usin=
g it.

Well, cpu #1 will update tesflag to 1 in ecall() and emcall()

>>
>>>  =20
>>>> =20
>>>>>    =20
>>>>>>  	smp_cpu_setup(1, psw);
>>>>>>  	smp_cpu_stop(1);
>>>>>>     =20
>>>>>    =20
>>>>
>>>> =20
>>>  =20
>>
>>
>=20



--92Hi3je3Cq1vBcrlMeshqfdBRVnBqtOZD--

--bCmHwAiM1FvN6J4364I56N1i753EkjL6r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4m96sACgkQ41TmuOI4
ufho3RAAg9W0beHShrEc54rHfXPbCYyzzDWdJSRhjk2o9UHiKGlXtHTeeEbDND5l
0E0LL8SKzCIv0O0r3AWcjZnaRUus48M7piKP5bTt9Zs1yzGz7T3bCS2MbWZXcmdg
AS1d2XzZhdkLQs8yBqwkwINk/FdC4LwTvCc3tUeXBk80KAt7qtblJvkeCANIOwfD
MTIMOJX1/acq2PaeMup8b8iNmo05ZqDhxfnhc049FE8XPfhXcIVCqm1d3j7ve5vH
05QbBgpOsE8HmLVzXy3mTwm9JKeCacqwhAYw3tLc+kSuJ3WQXdaAIYEstKxDkWF9
kGRoNccHF4QKsrCKMPzqpLkhVX0YR8a3Yx0rQ7QJXBLdZpIWKwCp2hfgLOndmGHQ
TDCd/eBXpMsG9nkLzDJ87azDcfn9vhOv1nHIbuKa2IYajhnCzyC59ZwwFtmjgk4m
Iz2RcAl9AQCoiQ+KfIWXA25M6ymB3LY8M1jcxjUL3NJFT13pKESSNKYRNcANStQw
bX5SO/rnUpSmDg705qfMtMCpIlRiZpnZjjggG7SPsvTe2fdGOvHmqE1tInXbeh9Z
I52H6PGWTqtt/pb2GyRkHjtAz0oXw+ZfijpXdUZESPhxHznPIUV42PiNT3y8HSnJ
Cg0WWjVcvr7ZvnVQlvwTAy2vcudkpsCCdzUq1yH9Lj/Qsay6j/o=
=tdsv
-----END PGP SIGNATURE-----

--bCmHwAiM1FvN6J4364I56N1i753EkjL6r--
