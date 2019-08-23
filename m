Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727025AbfHWLQt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 07:16:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NBGX6j019913
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 07:16:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujedbspwd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 07:16:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 23 Aug 2019 12:16:45 +0100
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: STSI tests
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-5-frankja@linux.ibm.com>
 <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 23 Aug 2019 13:16:41 +0200
MIME-Version: 1.0
In-Reply-To: <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ"
Message-Id: <40b29623-8fcf-2a8b-6e44-c94a958f3044@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ
Content-Type: multipart/mixed; boundary="dKiOaeDN0le2wFE7maVhLPHYgKkvf7ppL";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <40b29623-8fcf-2a8b-6e44-c94a958f3044@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: STSI tests
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190821104736.1470-5-frankja@linux.ibm.com>
 <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>
In-Reply-To: <3fffb16f-672e-bff1-03cc-475fd2739165@redhat.com>

--dKiOaeDN0le2wFE7maVhLPHYgKkvf7ppL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/19 12:57 PM, Thomas Huth wrote:
> On 8/21/19 12:47 PM, Janosch Frank wrote:
>> For now let's concentrate on the error conditions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile      |  1 +
>>  s390x/stsi.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  3 ++
>>  3 files changed, 88 insertions(+)
>>  create mode 100644 s390x/stsi.c
>>
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index 3453373..76db0bb 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -13,6 +13,7 @@ tests +=3D $(TEST_DIR)/gs.elf
>>  tests +=3D $(TEST_DIR)/iep.elf
>>  tests +=3D $(TEST_DIR)/cpumodel.elf
>>  tests +=3D $(TEST_DIR)/diag288.elf
>> +tests +=3D $(TEST_DIR)/stsi.elf
>>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>> =20
>>  all: directories test_cases test_cases_binary
>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>> new file mode 100644
>> index 0000000..0f90c9a
>> --- /dev/null
>> +++ b/s390x/stsi.c
>> @@ -0,0 +1,84 @@
> [...]
>> +static inline unsigned long stsi_get_fc(void *addr)
>> +{
>> +	register unsigned long r0 asm("0") =3D 0;
>> +	register unsigned long r1 asm("1") =3D 0;
>> +	int cc;
>> +
>> +	asm volatile("stsi	0(%2)\n"
>=20
> Shouldn't that be %3 instead?

Yup, although it doesn't really matter, as the address is ignored.

>=20
>> +		     "ipm	%[cc]\n"
>> +		     "srl	%[cc],28\n"
>> +		     : "+d" (r0), [cc] "=3Dd" (cc)
>> +		     : "d" (r1), "a" (addr)
>> +		     : "cc", "memory");
>> +	assert(!cc);
>> +	return r0 >> 28;
>> +}
>> +
>> +static void test_fc(void)
>> +{
>> +	report("cc =3D=3D 3",  stsi(pagebuf, 7, 0, 0) =3D=3D 3);
>> +	report("r0 =3D=3D 3",  stsi_get_fc(pagebuf) >=3D 2);

Just changed it to:
"invalid fc"
"query fc >=3D 2

>=20
> I'd like to suggest to change the string to "r0 >=3D 2", too.
>=20
>  Thomas
>=20



--dKiOaeDN0le2wFE7maVhLPHYgKkvf7ppL--

--3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1fyxkACgkQ41TmuOI4
ufjunBAAlJ2DsDxxeAFmclBSNwfYDjvOANmzNBmltRtm9IjQGt750dnRUPknQ7E8
Ppv7Hy3MHQk9VUBqh8KqN0KTe6H08k5EotCjlZ865vqa8CuMyT44cTSUPeIksCDl
V3RKW3DyxdvvLvqLRnoa9IXdudiy4pgVI9RzrM0me3r2sGkQ4nUFHAiCqD/RG0MC
2hBX0bo2REEqrcFvJH+o4wNh3mHZuVDQ1C+7Gstq7xOIGe5PBxv28R1eNz5yfsuX
ymrj445s6eP5mvx5QmkPZ7EAP9nxiE8woiJYFzgcczZR9zIxUC+S0jASGUm/MpZc
P02lGkpli43cJHm5qb7ZtPXPtG03OwnvmIvJmYTsPjU/7XW7Xe8CRYrvOsy3Heuo
RbssJHLtNxE7pfwkmuVr4sXbfFOYrVLuoXdwfUE15PPvWdoSbnxlDyKadWu7YNEF
btV9MJef4s4XyztSsxpXuKM50UQ4NT/eBPOydUoRuizG8YtiVZahs1Vvm1w0+MI8
jAbk1XMDR0L02oscTRFd3bJkv2/Zocnux6imijkW5SIOaPMf4+yGuhaYpN1Jo+Pp
/qKbb6hBZPEMtxaHV8jE+NqsWh0yWQFrUHplOpJkwgWu9lKASzMeIXzR3sPd2L7I
/ypnbKEgNN6R9IKpEOC7Qv4G1ebjvbKcVIzFGBU7N81Jw0Cv6mY=
=dkqd
-----END PGP SIGNATURE-----

--3BuPIrtxKUdlKPYkmCoxSTaHAnOvUIgGQ--
