Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732044AbfHWLeF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 07:34:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7NBWXoD040978
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 07:34:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujcj5pppb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 07:34:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 23 Aug 2019 12:34:02 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190822111100.4444-1-frankja@linux.ibm.com>
 <34c8d077-fc5e-1d62-f946-17d067573c23@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 23 Aug 2019 13:33:58 +0200
MIME-Version: 1.0
In-Reply-To: <34c8d077-fc5e-1d62-f946-17d067573c23@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5RQrRxo71WalowrG9pGdPdjB84oxhSWVk"
Message-Id: <72f07777-0f11-5cbe-da37-ace2ddfce78c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5RQrRxo71WalowrG9pGdPdjB84oxhSWVk
Content-Type: multipart/mixed; boundary="Mk9dvYBknQupxKytoulKQVenyIsb7ew6i";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <72f07777-0f11-5cbe-da37-ace2ddfce78c@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Add diag308 subcode 0 testing
References: <20190821104736.1470-1-frankja@linux.ibm.com>
 <20190822111100.4444-1-frankja@linux.ibm.com>
 <34c8d077-fc5e-1d62-f946-17d067573c23@redhat.com>
In-Reply-To: <34c8d077-fc5e-1d62-f946-17d067573c23@redhat.com>

--Mk9dvYBknQupxKytoulKQVenyIsb7ew6i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/19 1:00 PM, David Hildenbrand wrote:
> On 22.08.19 13:11, Janosch Frank wrote:
>> By adding a load reset routine to cstart.S we can also test the clear
>> reset done by subcode 0, as we now can restore our registers again.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>> I managed to extract this from another bigger test, so let's add it to=
 the bunch.
>> I'd be very happy about assembly review :-)
>> ---
>>  s390x/cstart64.S | 27 +++++++++++++++++++++++++++
>>  s390x/diag308.c  | 31 ++++++++++---------------------
>>  2 files changed, 37 insertions(+), 21 deletions(-)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index dedfe80..47045e1 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -145,6 +145,33 @@ memsetxc:
>>  	.endm
>> =20
>>  .section .text
>> +/*
>> + * load_reset calling convention:
>> + * %r2 subcode (0 or 1)
>> + */
>> +.globl load_reset
>> +load_reset:
>> +	SAVE_REGS
>> +	/* Save the first PSW word to the IPL PSW */
>> +	epsw	%r0, %r1
>> +	st	%r0, 0
>> +	/* Store the address and the bit for 31 bit addressing */
>> +	larl    %r0, 0f
>> +	oilh    %r0, 0x8000
>> +	st      %r0, 0x4
>> +	/* Do the reset */
>> +	diag    %r0,%r2,0x308
>> +	/* Failure path */
>> +	xgr	%r2, %r2
>> +	br	%r14
>> +	/* Success path */
>> +	/* We lost cr0 due to the reset */
>> +0:	larl	%r1, initial_cr0
>> +	lctlg	%c0, %c0, 0(%r1)
>> +	RESTORE_REGS
>> +	lhi	%r2, 1
>> +	br	%r14
>> +
>>  pgm_int:
>>  	SAVE_REGS
>>  	brasl	%r14, handle_pgm_int
>> diff --git a/s390x/diag308.c b/s390x/diag308.c
>> index f085b1a..baf9fd3 100644
>> --- a/s390x/diag308.c
>> +++ b/s390x/diag308.c
>> @@ -21,32 +21,20 @@ static void test_priv(void)
>>  	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>>  }
>> =20
>> +
>>  /*
>> - * Check that diag308 with subcode 1 loads the PSW at address 0, i.e.=

>> + * Check that diag308 with subcode 0 and 1 loads the PSW at address 0=
, i.e.
>>   * that we can put a pointer into address 4 which then gets executed.=

>>   */
>> +extern int load_reset(u64);
>> +static void test_subcode0(void)
>> +{
>> +	report("load modified clear done", load_reset(0));
>> +}
>> +
>>  static void test_subcode1(void)
>>  {
>> -	uint64_t saved_psw =3D *(uint64_t *)0;
>> -	long subcode =3D 1;
>> -	long ret, tmp;
>> -
>> -	asm volatile (
>> -		"	epsw	%0,%1\n"
>> -		"	st	%0,0\n"
>> -		"	larl	%0,0f\n"
>> -		"	oilh	%0,0x8000\n"
>> -		"	st	%0,4\n"
>> -		"	diag	0,%2,0x308\n"
>> -		"	lghi	%0,0\n"
>> -		"	j	1f\n"
>> -		"0:	lghi	%0,1\n"
>> -		"1:"
>> -		: "=3D&d"(ret), "=3D&d"(tmp) : "d"(subcode) : "memory");
>> -
>> -	*(uint64_t *)0 =3D saved_psw;
>> -
>> -	report("load normal reset done", ret =3D=3D 1);
>> +	report("load normal reset done", load_reset(1));
>>  }
>> =20
>>  /* Expect a specification exception when using an uneven register */
>> @@ -107,6 +95,7 @@ static struct {
>>  	void (*func)(void);
>>  } tests[] =3D {
>>  	{ "privileged", test_priv },
>> +	{ "subcode 0", test_subcode0 },
>>  	{ "subcode 1", test_subcode1 },
>>  	{ "subcode 5", test_subcode5 },
>>  	{ "subcode 6", test_subcode6 },
>>
>=20
> So, in general I am wondering if we should restore the original IPL_PSW=

> after we used it - is there any chance we might require the old value
> again (I guess we're fine with cpu resets)?

I currently don't see a need, but we could cache it in the restart old
psw address. Or we just store back the two word constant.



--Mk9dvYBknQupxKytoulKQVenyIsb7ew6i--

--5RQrRxo71WalowrG9pGdPdjB84oxhSWVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1fzyYACgkQ41TmuOI4
ufgDCw//em1tMQ2mHvWcoJ9KG/5zapv6Vbc5KDFjSmloVpJIpwGSwmBV6sxgOCm/
Kq0feZKJd1+wPR6T4/F9BeLeDxbFwwd8NdpyeAADgjFHv7ivfq1nNZu0RY19ExGd
28dZ88AzhuwPuiHyf4FNdzB6KKlx6Dqs9Hzzg9Nx2rYNqvCpeFeDMwgwgahqm6vI
sZESiE0aK4k7eXiiZ6X+OyFNBZZhumKUo0s0eHinybISplzALEStb09an20CqeE/
7+6Ww2P3+pZT08gfp22EyCqw5VyZiE20cZz+s/38Qe5Pa6gQYsQosWBop9vDDoLa
kJEXvEPMu94SgDAFJKz14UAGOrHewuIdwR7ANk3yLPPIbH55i2wDlZwwxkrM/InI
9sBH6fONugyDAiBBVSiZquXUP4dnyPZSu9A1ssI601jceGzrBAgWGI5K4ZP3yQtM
UoZC0qIn60IstWZrZjp0+nW6tInpLUsUcmOc8tW81QZCnn6mt2nXOJO/IajWUhhJ
VYRxYq2MPAjMM1SlCPlOZmNc1Re006RsALTsYRcziyO3q70laZ5od1qdwALuCOiZ
5O8vVGl7Ar1uaHDrIw89jqP6zs78LyCKkliyGA4EdAIubCDSvxg52zkxMbvqy4SI
g6dCyFomHWVpuXh6RNQJzm+feq8H1gxRZ/J+Xm68i0kddHO/VpM=
=ChDn
-----END PGP SIGNATURE-----

--5RQrRxo71WalowrG9pGdPdjB84oxhSWVk--
