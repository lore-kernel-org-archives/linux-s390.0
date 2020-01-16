Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbgAPNCB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 08:02:01 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GCvtlb076617
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:02:00 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xjkbm33aq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:01:59 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 13:01:58 -0000
Subject: Re: [kvm-unit-tests PATCH v2 2/7] s390x: smp: Only use smp_cpu_setup
 once
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-3-frankja@linux.ibm.com>
 <9847c5e8-2950-add1-e86b-0d14f0aca0bd@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Jan 2020 14:01:52 +0100
MIME-Version: 1.0
In-Reply-To: <9847c5e8-2950-add1-e86b-0d14f0aca0bd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="As5EVDSvI2DGATtmvewUXZi6Cy0hoLowM"
Message-Id: <7334c5fc-a125-9db3-877a-31c70c91429e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--As5EVDSvI2DGATtmvewUXZi6Cy0hoLowM
Content-Type: multipart/mixed; boundary="vhzBqbftFTjQqqSnMyrjueRgEpghAnWOC"

--vhzBqbftFTjQqqSnMyrjueRgEpghAnWOC
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/16/20 1:18 PM, David Hildenbrand wrote:
> On 16.01.20 13:05, Janosch Frank wrote:
>> Let's stop and start instead of using setup to run a function on a
>> cpu.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  s390x/smp.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 02204fd..d430638 100644
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
>> @@ -132,9 +132,8 @@ static void test_ecall(void)
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
>> @@ -167,9 +166,8 @@ static void test_emcall(void)
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
>> @@ -187,7 +185,7 @@ static void test_reset_initial(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("reset initial");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -218,7 +216,7 @@ static void test_reset(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("cpu reset");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>  	report(smp_cpu_stopped(1), "cpu stopped");
>> @@ -227,6 +225,7 @@ static void test_reset(void)
>> =20
>>  int main(void)
>>  {
>> +	struct psw psw;
>>  	report_prefix_push("smp");
>> =20
>>  	if (smp_query_num_cpus() =3D=3D 1) {
>> @@ -234,6 +233,12 @@ int main(void)
>>  		goto done;
>>  	}
>> =20
>> +	/* Setting up the cpu to give it a stack and lowcore */
>> +	psw.mask =3D extract_psw_mask();
>> +	psw.addr =3D (unsigned long)cpu_loop;
>> +	smp_cpu_setup(1, psw);
>> +	smp_cpu_stop(1);
>> +
>>  	test_start();
>>  	test_stop();
>>  	test_stop_store_status();
>> @@ -242,6 +247,7 @@ int main(void)
>>  	test_emcall();
>>  	test_reset();
>>  	test_reset_initial();
>> +	smp_cpu_destroy(1);
>> =20
>>  done:
>>  	report_prefix_pop();
>>
>=20
> Acked-by: David Hildenbrand <david@redhat.com>
Thanks!



--vhzBqbftFTjQqqSnMyrjueRgEpghAnWOC--

--As5EVDSvI2DGATtmvewUXZi6Cy0hoLowM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4gXsAACgkQ41TmuOI4
ufgPCQ//WTFS96qyoWLLs2cBlIGaav4M7BcJ2KmFBRk0RIy4Ai4baRrNpMGwze6+
0X0jl7vsy2Y7D74iTTs7hiM+j6iLaTqGJ2RnQSs3XPUWVVpQ6HaycS9rFC9ol6IO
rnDGUsDegutgZm0usZXcrgGYu3X56/G1xU1B/CXv4WMr0+XJBn/5ci2r0SoLm7oD
GV2LLN8KkWoIWQ662fpmtHptLcfJlHcULhczVdiHYwmFKiMrtaApgFjDD08oAnjq
WBglAJngkvCRtvVy6flsKrAZD9XBn6+nxNLy4aJXymEmA/BmtBI22qjlo4NBTJ0Q
XxiX2eq+K26aW8NzYXnEEhHBfv0VKJosjokRuPItVmR5xTlWkoJNOZg+KRwXCToB
5iLXsFdwjJqNfJkWO+mrfAf2NZ5uvb3xBDdusz26PqkktnjK3b8GkmsbeIppfX7H
BzslwpBn8U5DtScBtNf5TxCPlSTV+EoD5kFeEREvRE+N9uhDnPFL3IM/ZguFhY8O
t6qmbiH1g33cD8bbuMIOs/q9PrDIVmGXL9fObwjC9gPr7WkalHfa4slbkjOx0Udh
gqfQ5Y8CgOE6KRfOg4x6gpX/OrOGCB/5xi7ByWJ33/W/sKpCKFyG2WI5ncF2AfP2
WFuGtf7/vIqM8KYLSWewLwNZXgw4zlTrefwa4VVpNBjsQmRWEBk=
=LZ4i
-----END PGP SIGNATURE-----

--As5EVDSvI2DGATtmvewUXZi6Cy0hoLowM--
