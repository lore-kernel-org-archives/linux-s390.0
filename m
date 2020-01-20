Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgATOtf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jan 2020 09:49:35 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KEmhi8101940
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 09:49:34 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkyea29qt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2020 09:49:33 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 20 Jan 2020 14:49:31 -0000
Subject: Re: [kvm-unit-tests PATCH v3 8/9] s390x: smp: Test all CRs on initial
 reset
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-9-frankja@linux.ibm.com>
 <15f8b733-1b81-4a1b-22fe-53099878c013@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 20 Jan 2020 15:49:28 +0100
MIME-Version: 1.0
In-Reply-To: <15f8b733-1b81-4a1b-22fe-53099878c013@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kTwcvY8zcgtZ2MGIvkJZKQ27tt4L8PObw"
Message-Id: <d866273e-5108-e634-4e92-93aa66bbed57@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kTwcvY8zcgtZ2MGIvkJZKQ27tt4L8PObw
Content-Type: multipart/mixed; boundary="ym7yKKQ0hBlb4olf6wf6P4Y14J2n6Ba1F"

--ym7yKKQ0hBlb4olf6wf6P4Y14J2n6Ba1F
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/20/20 1:10 PM, David Hildenbrand wrote:
> On 17.01.20 11:46, Janosch Frank wrote:
>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>> so we also need to test 1-13 and 15 for 0.
>>
>> And while we're at it, let's also set some values to cr 1, 7 and 13, s=
o
>> we can actually be sure that they will be zeroed.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/smp.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index c12a3db..1385488 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -169,16 +169,30 @@ static void test_emcall(void)
>>  	report_prefix_pop();
>>  }
>> =20
>> +/* Used to dirty registers of cpu #1 before it is reset */
>> +static void test_func_initial(void)
>> +{
>> +	lctlg(1, 0x42000UL);
>> +	lctlg(7, 0x43000UL);
>> +	lctlg(13, 0x44000UL);
>> +	mb();
>> +	testflag =3D 1;
>> +}
>> +
>>  static void test_reset_initial(void)
>>  {
>>  	struct cpu_status *status =3D alloc_pages(0);
>> +	uint64_t nullp[12] =3D {};
>>  	struct psw psw;
>> =20
>>  	psw.mask =3D extract_psw_mask();
>> -	psw.addr =3D (unsigned long)test_func;
>> +	psw.addr =3D (unsigned long)test_func_initial;
>> =20
>>  	report_prefix_push("reset initial");
>> +	testflag =3D 0;
>> +	mb();
>=20
> maybe use a  set_flag() function like
>=20
> mb();
> testflag =3D val;
> mb();
>=20
> and use it everywhere you set the flag? (e.g., in test_func_initial())

Hmm, so basically a set_test_flag() function in a new patch :)
Ok, I'll have a look.

>=20
> Apart from that
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
>>  	smp_cpu_start(1, psw);
>> +	wait_for_flag();
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -189,6 +203,8 @@ static void test_reset_initial(void)
>>  	report(!status->fpc, "fpc");
>>  	report(!status->cputm, "cpu timer");
>>  	report(!status->todpr, "todpr");
>> +	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12),=
 "cr1-13 =3D=3D 0");
>> +	report(status->crs[15] =3D=3D 0, "cr15 =3D=3D 0");
>>  	report_prefix_pop();
>> =20
>>  	report_prefix_push("initialized");
>>
>=20
>=20



--ym7yKKQ0hBlb4olf6wf6P4Y14J2n6Ba1F--

--kTwcvY8zcgtZ2MGIvkJZKQ27tt4L8PObw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4lvfgACgkQ41TmuOI4
ufjgWRAArhi9PosMeixZOGJEVcZIntB4MDWAFDfOUAngo5m7L9Oagcnt6SF3zCNd
iXqVe7txQliSa///ePPKHtqBeryy0xtynsfYtZjHlmwGb9Epo5qUQY5jLxOCXMOX
j3XwOm1vI4n5n6JA+DSLg0RZNZPvBHNjVKudNSoTGxC417/q80dqQbr2RxCddvkH
SVZFjYZcdkRoggxKmEzoaMjjNN89zUvz0j6gu5diQLQp8M930Kf1vSERiYPIIj2X
s9Vy6PIvhxQGAgxiE19QQeuybMiI0k7q4bmxBx9vQtEIF7pfR8HaRAqoe+Q+BmQ/
kyoeWRs3LQugxvB7Dg3+56nkMpXqmN7DwdaLTKyxtRZHNLqYuYThH8UtCDffq9CM
bJhqUjOZ4bfOYldswrsjFCOZ/Mb/bvwxtcqZCODENZMUjDrXN0Hi5oa15NiT+HMz
dwgOOhZb8lSTbvwTGRA+HNZjM8C6pADNY0MctKn+5QBYj7fF8I5YORoF5SYMVH7j
ioWHA50chnzfE2OKvytmBERgsOH2y+77T1hucpntC/+0O/WdKCim08wfiC+UBTuV
TqK544KX9Gas763TCDsPE0Dr0JPWJdW7//yUcbT0A7kySJ/KPUTz8K6tPVx1+hu7
PbRqYIWBR5my3dKFmLPLtPbBv4/eG6XIUhmVWoIIegNpUFOBwSQ=
=4tKr
-----END PGP SIGNATURE-----

--kTwcvY8zcgtZ2MGIvkJZKQ27tt4L8PObw--
