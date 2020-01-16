Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgAPNHV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 08:07:21 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GD76fH105252
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:07:20 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhm35nndb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:07:20 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 13:07:17 -0000
Subject: Re: [kvm-unit-tests PATCH v2 6/7] s390x: smp: Test all CRs on initial
 reset
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-7-frankja@linux.ibm.com>
 <7e85ec92-4d0a-f673-00c8-a9ab9a22118c@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Jan 2020 14:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <7e85ec92-4d0a-f673-00c8-a9ab9a22118c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8XDH7mI6QSSZ8DwtB4XqTYuIGbQIVRJnp"
Message-Id: <400dc0d2-86bc-cdc8-ec8a-7d1148ebd5fa@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8XDH7mI6QSSZ8DwtB4XqTYuIGbQIVRJnp
Content-Type: multipart/mixed; boundary="7coQ9ksdeHYirCVdNkLo49dtMkX2UHpIj"

--7coQ9ksdeHYirCVdNkLo49dtMkX2UHpIj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/16/20 1:24 PM, David Hildenbrand wrote:
> On 16.01.20 13:05, Janosch Frank wrote:
>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>> so we also need to test 1-13 and 15 for 0.
>>
>> And while we're at it, let's also set some values to cr 1, 7 and 13, s=
o
>> we can actually be sure that they will be zeroed.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/smp.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/s390x/smp.c b/s390x/smp.c
>> index d430638..ce3215d 100644
>> --- a/s390x/smp.c
>> +++ b/s390x/smp.c
>> @@ -176,16 +176,31 @@ static void test_emcall(void)
>>  	report_prefix_pop();
>>  }
>> =20
>> +/* Used to dirty registers of cpu #1 before it is reset */
>> +static void test_func_initial(void)
>> +{
>> +	lctlg(1, 0x42000UL);
>> +	lctlg(7, 0x43000UL);
>> +	lctlg(13, 0x44000UL);
>> +	testflag =3D 1;
>> +	mb();
>> +	cpu_loop();
>=20
> Can we make cpu_loop() the default when this function returns? (IOW, an=

> endless loop whenever a cpu finished executing the function?)

So adding it to cstart64.S after the br 14?

>=20
> Do we need the mb() here?

Would the compiler reorder the lctlcg and testflag if it could?

>=20
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
>>  	smp_cpu_start(1, psw);
>> +	wait_for_flag();
>> =20
>>  	sigp_retry(1, SIGP_INITIAL_CPU_RESET, 0, NULL);
>>  	sigp(1, SIGP_STORE_STATUS_AT_ADDRESS, (uintptr_t)status, NULL);
>> @@ -196,6 +211,8 @@ static void test_reset_initial(void)
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



--7coQ9ksdeHYirCVdNkLo49dtMkX2UHpIj--

--8XDH7mI6QSSZ8DwtB4XqTYuIGbQIVRJnp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4gYAEACgkQ41TmuOI4
ufjcixAArqxzA6JhVk4CN7MukoAuAi/NpK9BWYY3Y1jDMkK9kWlOYxpKUIPD8JX4
vbjrtUjYh6PSdJad6WRf+GJc6Uzw2wJP3v45DS/RfMpVSQN13/IoZPh4pK3/bm7L
YgSJf1+QHFwyPeTCAPLnRwG0Xm9ogDwC3mkzmMef0XzrY04hw7MgRFD+WQhjYAW1
8sC+hmaUtnjZ1PCJi9SEPxTd02JmRemXoei2M0KX4bqzP4VN2TYNxZDDWnlUFb/K
QnPMCzr27pnNYTYOq7sw6NouU4ZXEDzcWPwx6dzXx/amrMbTCUDsiPMlC/KkyN9S
lQHLmsmHDHezRdlIbnf64GSweI+BwlIzKgI6iXbFkCid/1Plz1RMjLmxiZ3KOxsK
IB/Sd5NpEh+oBXqH4nqyLXa+MDhQNfp6Ae4c9JewhlwJP0P1Ygouzbj+QvZm4TOY
4FvYiPVNq63KdTYdZCnAKz18PtBoGzEROZ/AqtPVWCDJX8hVHb8z7TWvsRDAFpbO
GjFvDKmZ7Uzd1XryFjMKJPZC452tGR6/PWU0iD4Dqs59G0m+LdoHTsKpk+GsDLgg
8/G/iWOu/TQU4D1ysbZrkWhtLVAvTxufLBJm+3luAwcR9fsm1PnOJfaLoBkxGgvt
aoY5YP3SOSSGqbKXGEmF3QyC2lbW9mPQqEy/0d5tHs2wIsLI9RU=
=84BG
-----END PGP SIGNATURE-----

--8XDH7mI6QSSZ8DwtB4XqTYuIGbQIVRJnp--
