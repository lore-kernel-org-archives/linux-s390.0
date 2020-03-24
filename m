Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbgCXKIO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 06:08:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OA4moa146531
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 06:08:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7d5037-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 06:08:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 24 Mar 2020 10:08:08 -0000
Subject: Re: [kvm-unit-tests PATCH 01/10] s390x: smp: Test all CRs on initial
 reset
References: <20200324081251.28810-1-frankja@linux.ibm.com>
 <20200324081251.28810-2-frankja@linux.ibm.com>
 <fb384a50-6c38-b636-ecde-ad220aad950c@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 24 Mar 2020 11:08:05 +0100
MIME-Version: 1.0
In-Reply-To: <fb384a50-6c38-b636-ecde-ad220aad950c@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="of4QRSXK2r8W6dDSKIp6uDMUUCRscT4c3"
Message-Id: <c1f01ea5-219e-4680-72bd-56f68270bf9b@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--of4QRSXK2r8W6dDSKIp6uDMUUCRscT4c3
Content-Type: multipart/mixed; boundary="FZAi9xJTASK4KTKHj2k30Z3ojYGXVkRC2"

--FZAi9xJTASK4KTKHj2k30Z3ojYGXVkRC2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/24/20 10:52 AM, Christian Borntraeger wrote:
>=20
>=20
> On 24.03.20 09:12, Janosch Frank wrote:
>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>> so we also need to test 1-13 and 15 for 0.
>>
>> And while we're at it, let's also set some values to cr 1, 7 and 13, s=
o
>> we can actually be sure that they will be zeroed.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  s390x/smp.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index fa40753524f321d4..8c9b98aabd9e8222 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -182,16 +182,28 @@ static void test_emcall(void)
>>  	report_prefix_pop();
>>  }
>>
>> +/* Used to dirty registers of cpu #1 before it is reset */
>> +static void test_func_initial(void)
>> +{
>> +	lctlg(1, 0x42000UL);
>> +	lctlg(7, 0x43000UL);
>> +	lctlg(13, 0x44000UL);
>> +	set_flag(1);
>> +}
>> +
>>  static void test_reset_initial(void)
>>  {
>>  	struct cpu_status *status =3D alloc_pages(0);
>> +	uint64_t nullp[12] =3D {};
>>  	struct psw psw;
>>
>>  	psw.mask =3D extract_psw_mask();
>> -	psw.addr =3D (unsigned long)test_func;
>> +	psw.addr =3D (unsigned long)test_func_initial;
>>
>>  	report_prefix_push("reset initial");
>> +	set_flag(0);
>>  	smp_cpu_start(1, psw);
>> +	wait_for_flag();
>>
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -202,6 +214,8 @@ static void test_reset_initial(void)
>>  	report(!status->fpc, "fpc");
>>  	report(!status->cputm, "cpu timer");
>>  	report(!status->todpr, "todpr");
>> +	report(!memcmp(&status->crs[1], nullp, sizeof(status->crs[1]) * 12),=
 "cr1-13 =3D=3D 0");
>> +	report(status->crs[15] =3D=3D 0, "cr15 =3D=3D 0");
>>  	report_prefix_pop();
>=20
> Why not add a check for crs[0] =3D=3D 0xe0=20
> and crs[14] =3D 0xc2000000

You mean the checks which are done a few lines below this?
This patch just actually dirties registers which should be set to 0 so
we can really be sure that they have been touched.



--FZAi9xJTASK4KTKHj2k30Z3ojYGXVkRC2--

--of4QRSXK2r8W6dDSKIp6uDMUUCRscT4c3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl553AUACgkQ41TmuOI4
ufjkfQ//eacC+WqPAOArkFUZ11Dk8p30hZowaO2RUacMpQTbOdsJ50pFpiOjGohv
+l3aeF8IagP7fxdgtxqdMSPH56KGFPTylsv4vNv2ONQottRkzPGolg9z9IOsPL06
dYBr06yDN0CHyPQzoAXjavivNDPew57j1/qiT8o21gKioZmpdeggdaG5EO3NuREj
9FTpTkEryr/osMYmG3IJgZ77eoh0YrDO2u7zcfyLMMXdnS6dwmqD6GG2UGAQ0eu+
/O3T9I0dqgo21zj3YmBVET/slrELT1q5WVHQCAWjNqqNDhYflLJH/xj4KY7ypJu5
zrpQV9koeyf9aH2+7qBRX0QqwqgDYuRFmPDKjSy5dO+oXSuN27Y9LYu6kxSU9+mK
5GUP4tJs5DpJz4ya1hP4FTRN0eXnSGrn0YxwJtvABg1+oFSO/JgIitJSuIyHPn3E
hSkfuAnbUazC7FRfmr0jpzAtfNGT+ZWhNNvapw3F7UXWKPf83puDONxM6uX6+gxl
tbdFyw1xhl5L2Cl1MuZIpiU43GELZeks+6uuGgLD1/s9qZROVxA3ESJYFMODz9v6
fhfDzN2y4LlNdJQwkBgciY7QDipc2yTrXBfsDKP351ZCC/mR/Qi874a95TYyJc8e
Cs25WjYOT6dnz77iC75vrBw7Iu/VavDe48iZC5vCNsqka6kcjnI=
=tqfD
-----END PGP SIGNATURE-----

--of4QRSXK2r8W6dDSKIp6uDMUUCRscT4c3--
