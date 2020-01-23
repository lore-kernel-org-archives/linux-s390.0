Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgAWNyy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 08:54:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NDqOPx127615
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 08:54:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqa25y4g7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 08:54:53 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Jan 2020 13:54:51 -0000
Subject: Re: [kvm-unit-tests PATCH v4 2/9] s390x: smp: Only use smp_cpu_setup
 once
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-3-frankja@linux.ibm.com>
 <ef7894ff-4179-6730-ce28-c48e7730eff8@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 23 Jan 2020 14:54:46 +0100
MIME-Version: 1.0
In-Reply-To: <ef7894ff-4179-6730-ce28-c48e7730eff8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav"
Message-Id: <e09c42a7-279a-7e8b-8241-26c69940cdd0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav
Content-Type: multipart/mixed; boundary="5ds5ufiKTnugcR6YKVnm1LkVNANTpFlOo"

--5ds5ufiKTnugcR6YKVnm1LkVNANTpFlOo
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/23/20 2:45 PM, David Hildenbrand wrote:
> On 21.01.20 14:42, Janosch Frank wrote:
>> Let's stop and start instead of using setup to run a function on a
>> cpu.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>  s390x/smp.c | 21 ++++++++++++++-------
>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index e37eb56..3e8cf3e 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -53,7 +53,7 @@ static void test_start(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	set_flag(0);
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	report(1, "start");
>>  }
>> @@ -109,6 +109,7 @@ static void test_store_status(void)
>>  	report(1, "status written");
>>  	free_pages(status, PAGE_SIZE * 2);
>>  	report_prefix_pop();
>> +	smp_cpu_stop(1);
>> =20
>>  	report_prefix_pop();
>>  }
>> @@ -137,9 +138,8 @@ static void test_ecall(void)
>> =20
>>  	report_prefix_push("ecall");
>>  	set_flag(0);
>> -	smp_cpu_destroy(1);
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	set_flag(0);
>>  	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>> @@ -172,9 +172,8 @@ static void test_emcall(void)
>> =20
>>  	report_prefix_push("emcall");
>>  	set_flag(0);
>> -	smp_cpu_destroy(1);
>> =20
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>>  	wait_for_flag();
>>  	set_flag(0);
>>  	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>> @@ -192,7 +191,7 @@ static void test_reset_initial(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("reset initial");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -223,7 +222,7 @@ static void test_reset(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("cpu reset");
>> -	smp_cpu_setup(1, psw);
>> +	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>  	report(smp_cpu_stopped(1), "cpu stopped");
>> @@ -232,6 +231,7 @@ static void test_reset(void)
>> =20
>>  int main(void)
>>  {
>> +	struct psw psw;
>>  	report_prefix_push("smp");
>> =20
>>  	if (smp_query_num_cpus() =3D=3D 1) {
>> @@ -239,6 +239,12 @@ int main(void)
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
>> @@ -247,6 +253,7 @@ int main(void)
>>  	test_emcall();
>>  	test_reset();
>>  	test_reset_initial();
>> +	smp_cpu_destroy(1);
>> =20
>>  done:
>>  	report_prefix_pop();
>>
>=20
> With this patch, I get timeouts under TCG. Seems to loop forever.
>=20
The branch works on lpar and kvm without a problem.


--5ds5ufiKTnugcR6YKVnm1LkVNANTpFlOo--

--V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4ppaYACgkQ41TmuOI4
ufiHYg//es8ywqNE5SVvTOi3PXwJpQ6dY9gTntCRh4n46OMI+KmUobQ2ZDa+RvhG
IUglxBaqOTF5RvLOBwt5W+XdJYcVPtzeGk1KpOXzS5Atby3nxzOSru98wA0jGSdD
a/3gMhPL+ZIuGBUziPlUXahv5WaYsc+jzBfiXFoHVppK0k+0OJDEVfA7+d2AMtEq
yeliAAPm7LJfrnXpnX14Q/0td3LAmR699B3sPipzi3ZelL1xmhzAr80RFXOuzCor
l2/VYDd44jeeB1K5R0JYuRyPLAYMowg8v8MaaDlIr54C+pLWhWLMYG6Lu4GuSfKa
lraQsRztPYprgNArH7QGDQWVem2pr1Rb0jUrVcDkha87REpl9N6So+TX+fLYXt8t
DiC9VgRoyPuq8WI5+SkyzaozVt58JMTNvvioOka3qmxI5YQYUJgvZ31q1YeVQFw9
/jiGaJmtI3Fgpw8thSAZ6aU+pr4N/8r2uXBq+WYlQGglV6xhjPrD0DnHhHY/AIdl
va9QpC5eyexmvrT/gOrYVrs+MQ58X7gon2ivXlx7ykCGtgbLOCD/2X6Oo5V5k639
o1oZr/AqY9DZqicVH9lbeF5+yiAoctKUNenREeYqom/JgJxbTu1sdyhPo/wLkgvw
OsH84nyQVHcxtcpdciJdgD5IfBlkTudaAQXzpa/DNMEwPiamxEQ=
=mNh1
-----END PGP SIGNATURE-----

--V2umUpQQJqxbaQrGZ00qKqAwEO25NLbav--
