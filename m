Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728993AbgAOHu3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 02:50:29 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F7iKHA065920
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 02:50:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvq7cwur-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 02:50:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 15 Jan 2020 07:50:25 -0000
Subject: Re: [kvm-unit-tests PATCH 2/4] s390x: smp: Only use smp_cpu_setup
 once
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-3-frankja@linux.ibm.com>
 <9db91398-0371-cd4a-9758-a185b74467a0@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 15 Jan 2020 08:50:21 +0100
MIME-Version: 1.0
In-Reply-To: <9db91398-0371-cd4a-9758-a185b74467a0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="97w2nfovMSVWyv80OK2EJ22C0b2QWNq3E"
Message-Id: <5c880248-bd35-a5f8-0526-80defc5864e5@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--97w2nfovMSVWyv80OK2EJ22C0b2QWNq3E
Content-Type: multipart/mixed; boundary="kudNxptmPkuI8tcyCsnTcY4cP4belrBle"

--kudNxptmPkuI8tcyCsnTcY4cP4belrBle
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/14/20 5:45 PM, Thomas Huth wrote:
> On 14/01/2020 16.30, Janosch Frank wrote:
>> Let's stop and start instead of using setup to run a function on a
>> cpu.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/smp.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 4dee43e..767d167 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -47,7 +47,7 @@ static void test_start(void)
>>  	psw.mask =3D extract_psw_mask();
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	report(1, "start");
>>  }
>> @@ -131,9 +131,8 @@ static void test_ecall(void)
>> =20
>>  	report_prefix_push("ecall");
>>  	testflag =3D 0;
>> -	smp_cpu_destroy(1);
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	testflag =3D 0;
>>  	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>> @@ -166,9 +165,8 @@ static void test_emcall(void)
>> =20
>>  	report_prefix_push("emcall");
>>  	testflag =3D 0;
>> -	smp_cpu_destroy(1);
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	testflag =3D 0;
>>  	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>> @@ -186,7 +184,7 @@ static void test_reset_initial(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("reset initial");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -217,7 +215,7 @@ static void test_reset(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("cpu reset");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>=20
> I think this also fixes a memory leak in case the code did not call
> smp_cpu_destroy() inbetween (since smp_cpu_setup() allocates new memory=

> for the low-core). So as far as I can see, this is a good idea:

Well, if the cpu is active, we should just return in the setup function.
But I have another patch in the queue which cleans up lowcore allocation.=


>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20



--kudNxptmPkuI8tcyCsnTcY4cP4belrBle--

--97w2nfovMSVWyv80OK2EJ22C0b2QWNq3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4exD0ACgkQ41TmuOI4
ufgCOw//eZPLhJYGZ0W9au+moydeJ710NZT8ZL21dhQAeZGDUUBWQzUM3UnupULU
ycMqgoj2clqm3VKSNsM5EkwVaBicmCq4OUD/phCp4hY7G657fgLhUvkWyH1EeVUH
cDovPHFvc9zSqfLaskT01E+59mNmczl99gjrFxBJjYp6aRLHKoC5KGB2ti7eiwya
oNhaUJk3XKzvgBNRx2IS6OjSV6du1zAMsKKn0ly1Dze+evQoBm4+w6Hwv/pXMTxw
8MghDk5Op+uvEYuQL3mCERlyXh7IMYT+0JCb0+WHTDYzPTASijTUfg8OrVJHMGR3
NZj+O0t+CzxsHbgFtrR53IUqrBMeovW6ZYn6l++vKEvFBOQ2/HH7R/Uj/BCR+XTY
jXK9pvESisLNr6u6Yzt9Xuf86eeW5TzcWlXpkM0AjRa8Ee1Pj1YSDNPQT0kQad1R
edfdoPLjEa97YF6IYrLfOmQ9S89j9ZenWmH/fTXuazX67wNz1fJ+YePUcOhWBPeV
ohErsl3ALrzp2lHT6ZkEov9GLhGilwFLyrNs5weXztI2hoopib7BYoD5yDwYl6yH
MaPP8piOTAg7yeEnAz4Ys2yY4ml52jJljwzi9dvYbjr2h/C3Got55OQYSZbg/44h
9xMJSosXp9ZTwbrBmJl2miwpJInUtYFEP3YG7FvNOXLaPRUGSLk=
=n5ay
-----END PGP SIGNATURE-----

--97w2nfovMSVWyv80OK2EJ22C0b2QWNq3E--
