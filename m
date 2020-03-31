Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63312 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729624AbgCaJ3C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 31 Mar 2020 05:29:02 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V943bf001645
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2020 05:29:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 303ymjwtw8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 31 Mar 2020 05:29:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 31 Mar 2020 10:28:52 +0100
Subject: Re: [kvm-unit-tests PATCH 04/10] s390x: smp: Test local interrupts
 after cpu reset
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-5-frankja@linux.ibm.com>
 <b6f1d06b-aaa5-bdd5-5491-32c8338f9ead@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 31 Mar 2020 11:28:56 +0200
MIME-Version: 1.0
In-Reply-To: <b6f1d06b-aaa5-bdd5-5491-32c8338f9ead@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GOc88mcdnMmgMHV8RM0WqiPTRCLmnZ4CU"
Message-Id: <126883fa-6c1e-a1e3-34f0-689cd2c0b7c4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GOc88mcdnMmgMHV8RM0WqiPTRCLmnZ4CU
Content-Type: multipart/mixed; boundary="K7gavZP7CHORnCAvuMbKaUQyf7V0Qis8D"

--K7gavZP7CHORnCAvuMbKaUQyf7V0Qis8D
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/31/20 11:07 AM, David Hildenbrand wrote:
> On 24.03.20 09:12, Janosch Frank wrote:
>> Local interrupts (external and emergency call) should be cleared after=

>> any cpu reset.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/smp.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index 8a6cd1d8b17d76c6..a8e3dd7aac0c788c 100644
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
>=20
>=20
> How can you be sure they were actually cleared/delivered?
>=20
Because cpu 1 would get a ext int it didn't expect and would do a
report_abort() as pecified in lib/s390x/interrupt.c



--K7gavZP7CHORnCAvuMbKaUQyf7V0Qis8D--

--GOc88mcdnMmgMHV8RM0WqiPTRCLmnZ4CU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6DDVgACgkQ41TmuOI4
ufgPgRAAwkq/yYR5Yy2ZiCswYXsf3koxKhEEgGHduoOyT0kBcbBEnacoMUtxw92e
Z6Dq9qRPiMAfLxBoTXB4/Lj3fMzpG6h9i/EHlHYFQgD8NE+cVhV22O1FkjxYCxvT
J5jUkWvPZyfTNfXeSM77+99Yq2kegEsnTlSgM+ebyK6TafrdIATM+ijjp2ST5Sf2
IIgS9t+bAtgEkOw09CwuemLhA5Z9W4ONMrR5v/XeCyQ+5G3GqzutFgUVYcnVVX0s
V9aXDOrMuPadD3K92ik6qvmI1zUumCQYldkrJPKGuLvrKvyp6VBC7QCOvK4Gekv0
mFfinXiRwDwdxaKGJ85lijnFlJFpNF5Ontnqom2B9wu2cxCRzGe2QmlZtGRbf8Jl
1gTmfNw59wsHjFK0wmgiMP8fyLfvSQ+XxlFAtYngqWFD3sLOjf4rVCFkueZQCdAj
PnEBfwd1adqq4cA1NNeNaqCu8FsNkOctOHFC+RDEna0TsZycroSdnagsQZAXS6ZA
jo3LKodxlmuuPU+0KyLGYs+8RWCSEbvGhO5+biaH6oqeYzf+12nTNLGU2j0mWMzu
/CboHjfd8EiJVRfTUsKtyMR6r9tZVwaXUUxjIuKsLZhxSJeR7Iw/ElkGkXdj68xQ
XYAbjAifcA2ZrCH8jM3XSh6P7UAHuZCuIpGvrPmhM3pKFSE8uZ4=
=SUPZ
-----END PGP SIGNATURE-----

--GOc88mcdnMmgMHV8RM0WqiPTRCLmnZ4CU--
