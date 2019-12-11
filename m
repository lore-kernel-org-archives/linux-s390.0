Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60102 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729212AbfLKMfK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 07:35:10 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBCX1Cp005261
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 07:35:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf6yauxs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 07:35:08 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Dec 2019 12:34:44 -0000
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: smp: Use full PSW to bringup
 new cpu
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-2-frankja@linux.ibm.com>
 <6433a418-e42f-0cf6-9cd4-bbe9912b901d@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Dec 2019 13:34:39 +0100
MIME-Version: 1.0
In-Reply-To: <6433a418-e42f-0cf6-9cd4-bbe9912b901d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ujKttf4NQOrgsGG6ICtA5kPzYt6ym8iB7"
Message-Id: <7391e55e-7be5-c69b-a1e5-5e1ddadbc06c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ujKttf4NQOrgsGG6ICtA5kPzYt6ym8iB7
Content-Type: multipart/mixed; boundary="5aG45P6yevNdbXuRTiw3Mw6IVKRkGzYvd"

--5aG45P6yevNdbXuRTiw3Mw6IVKRkGzYvd
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 1:31 PM, David Hildenbrand wrote:
> On 11.12.19 12:59, Janosch Frank wrote:
>> Up to now we ignored the psw mask and only used the psw address when
>> bringing up a new cpu. For DAT we need to also load the mask, so let's=

>> do that.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/smp.c  | 2 ++
>>  s390x/cstart64.S | 2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index f57f420..e17751a 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -185,6 +185,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>>  	cpu->stack =3D (uint64_t *)alloc_pages(2);
>> =20
>>  	/* Start without DAT and any other mask bits. */
>> +	cpu->lowcore->sw_int_psw.mask =3D psw.mask;
>> +	cpu->lowcore->sw_int_psw.addr =3D psw.addr;
>>  	cpu->lowcore->sw_int_grs[14] =3D psw.addr;
>=20
> Not looking at the code (sorry :D ), do we still need this then? (you
> drop the br bewlo)

r14 is the return address, saving/initialising it doesn't sound like a
bad idea to me. If we ever have stack traces, it might show up, or won't =
it?

>=20
>>  	cpu->lowcore->sw_int_grs[15] =3D (uint64_t)cpu->stack + (PAGE_SIZE *=
 4);
>>  	lc->restart_new_psw.mask =3D 0x0000000180000000UL;
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 86dd4c4..e6a6bdb 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -159,7 +159,7 @@ smp_cpu_setup_state:
>>  	xgr	%r1, %r1
>>  	lmg     %r0, %r15, GEN_LC_SW_INT_GRS
>>  	lctlg   %c0, %c0, GEN_LC_SW_INT_CRS
>> -	br	%r14
>> +	lpswe	GEN_LC_SW_INT_PSW
>> =20
>>  pgm_int:
>>  	SAVE_REGS
>>
>=20
>=20



--5aG45P6yevNdbXuRTiw3Mw6IVKRkGzYvd--

--ujKttf4NQOrgsGG6ICtA5kPzYt6ym8iB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3w4mAACgkQ41TmuOI4
ufimEA/+ONL3Gbw4hqr4BI7FjgHYyXd6M3fIJPouOuNyWevQzEwqHU7JtQjaOSsi
kiLf+Pp1YWD1+CasGQ4zATFhIkMsas7UTCq8EbQHdaYiybwzFX670mNmU9qQruQk
UWG1M1kLpGGG3Nx8b59hCqoqCd/CPwoNUv16orRSAv8dj8WgKwUetG8bKn5OhH73
csKmKCVe0RDT5XEMU2ri0RS931/EWPZPh0MuRrXPMAsxKM2Qy6zePzxAhiosbgry
7DkrZ95uycoxM88Ypvc8FPxD4bvQI4V0Jzed+5v1KB8mwRNsE7ARhayvSGSjGWLC
ibWbhyY1Zz0x3yVhDys2juI51gtpmi+Trk39d2p5EB7PBSFGbfa1c4F1+JAunDVH
Gacs0dCyVeWrNfNqU8ZeFWGj4FOFK8z7S9TUV+0gLl60S3sVj/5MyHy6Q3lJxvEq
iVpltdaaRPdpJ+Y0PEfTmfhJXuwOV26qjSUX+s0uJK0UXiq8dliObjsD5KbHwiCu
OSdUztiokOlG7vccL/w61g6DE9muk31YZrm8IkgjRLrfT8DwSF832Vu4P8beAtbm
UrA+AeCy9ctKsBwmA+wt4Zi9Layv42I07W12GtN7F+icou0tLZrz12MFiBpStOAp
NasqxMnx+uomiO+egJcMSiXX5g+gU8EaRjMmJTCm2nDZWkRPXtk=
=+AkB
-----END PGP SIGNATURE-----

--ujKttf4NQOrgsGG6ICtA5kPzYt6ym8iB7--
