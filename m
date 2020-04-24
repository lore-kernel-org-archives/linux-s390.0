Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726247AbgDXLvw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 07:51:52 -0400
Subject: Re: [PATCH v2 04/10] s390x: smp: Test local interrupts after cpu
 reset
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-5-frankja@linux.ibm.com>
 <8bdbe934-fff9-cc2a-3043-4851365735f3@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <c92a928a-aa94-38b6-f8af-d0bf28e368fd@linux.ibm.com>
Date: Fri, 24 Apr 2020 13:51:45 +0200
MIME-Version: 1.0
In-Reply-To: <8bdbe934-fff9-cc2a-3043-4851365735f3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aOrwj5xvk38smJvn6YESLUkGSJZgLIb52"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aOrwj5xvk38smJvn6YESLUkGSJZgLIb52
Content-Type: multipart/mixed; boundary="lZfKXrBz9XIErdMhMDpoUgWKD9h2NyaY3"

--lZfKXrBz9XIErdMhMDpoUgWKD9h2NyaY3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:07 PM, David Hildenbrand wrote:
> On 23.04.20 11:10, Janosch Frank wrote:
>> Local interrupts (external and emergency call) should be cleared after=

>> any cpu reset.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  s390x/smp.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 8a6cd1d..a8e3dd7 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -243,6 +243,20 @@ static void test_reset_initial(void)
>>  	report_prefix_pop();
>>  }
>> =20
>> +static void test_local_ints(void)
>> +{
>> +	unsigned long mask;
>> +
>> +	expect_ext_int();
>> +	/* Open masks for ecall and emcall */
>> +	ctl_set_bit(0, 13);
>> +	ctl_set_bit(0, 14);
>> +	mask =3D extract_psw_mask();
>> +	mask |=3D PSW_MASK_EXT;
>> +	load_psw_mask(mask);
>> +	set_flag(1);
>> +}
>=20
> I think last time I looked at this I got it all wrong. So, we actually
> don't expect that an interrupt triggers here, correct?

Correct

>=20
> The SIGP_CPU_RESET should have cleared both interrupts on this cpu. So
> once we enable them, none should trigger.

Yes

>=20
> Why do we have "expect_ext_int()" ?

Excellent question, that should not be there.
Fortunately removing it doesn't change the test results.

>=20
>> +
>>  static void test_reset(void)
>>  {
>>  	struct psw psw;
>> @@ -251,10 +265,18 @@ static void test_reset(void)
>>  	psw.addr =3D (unsigned long)test_func;
>> =20
>>  	report_prefix_push("cpu reset");
>> +	sigp(1, SIGP_EMERGENCY_SIGNAL, 0, NULL);
>> +	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>>  	smp_cpu_start(1, psw);
>> =20
>>  	sigp_retry(1, SIGP_CPU_RESET, 0, NULL);
>>  	report(smp_cpu_stopped(1), "cpu stopped");
>> +
>> +	set_flag(0);
>> +	psw.addr =3D (unsigned long)test_local_ints;
>> +	smp_cpu_start(1, psw);
>> +	wait_for_flag();
>> +	report(true, "local interrupts cleared");
>>  	report_prefix_pop();
>>  }
>> =20
>>
>=20
>=20



--lZfKXrBz9XIErdMhMDpoUgWKD9h2NyaY3--

--aOrwj5xvk38smJvn6YESLUkGSJZgLIb52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6i0tEACgkQ41TmuOI4
ufj4EA//aXAKunI1QR4Ntu+FV3GAd2rgU8RBpTd1kDK/MvbYUykdg7tW4VYjvRAG
eO7fiYX92s+ARdvlU4hc5LMfdcMi1ftxotKnq83DP450ZqbBZcrzkYL3IcXqLnl0
rmUs4gihMloe9Yan7qY+F/Etemoaa0aqBCXikK1q3Gnmm/UG2QkfNTr8cWAnn0M7
UUxxpt9zbMGJ8yyAdSC7Da9t4+95nFfd3avnNokTjh7LIaZY6cTaN+oPwSVvHMqh
TqsrgLRsylABJoGkwTZNVUtlV9pPk/lBuxZUsDvekCOdxvG2899s85jAvnXn+ylP
n0TyqA4hsRLV9K0uINXBnibUQnR5hYdOoE3sieBkUGncrJBwoRRavR6N3u+5d2e8
CGbcr0kYGi4ObPFpbF3v0kXUfnFWpglb0YZ4PIyiMGh9NXBjOEOfxq1l8uBUSwEn
FtSWmEzU9Vid2le/V3pZL4VVRDzqU7jIX+59hZCriQRU3meObX5APv9JbpItFw0d
X8v4hKybMV82nBtSYsAp8349ukskupj9p6wS9nHCcpk4wNk6LwG+9TubYj5yURLz
qq6s/eEMJwqcbrRP484TDyyinUVjz0shh77PIXGT/R6iE+2/2ET7C3uL3babPhEL
9ylVZ6Bt4uemlFw1iyL3cjKffRz9nF4u66ECc3/1brunw+9qTFk=
=f38m
-----END PGP SIGNATURE-----

--aOrwj5xvk38smJvn6YESLUkGSJZgLIb52--
