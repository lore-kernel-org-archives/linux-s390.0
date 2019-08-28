Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbfH1G0v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Aug 2019 02:26:51 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7S6MlNo126723
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 02:26:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unhg3dty0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 28 Aug 2019 02:26:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 28 Aug 2019 07:26:47 +0100
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Add storage key removal
 facility
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-4-frankja@linux.ibm.com>
 <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 28 Aug 2019 08:26:41 +0200
MIME-Version: 1.0
In-Reply-To: <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5LvCsyVCQkKunP9t8f7wuow6SOVBqPMgQ"
Message-Id: <f0cddac0-a574-1aeb-69c6-b9d67f2dfd97@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5LvCsyVCQkKunP9t8f7wuow6SOVBqPMgQ
Content-Type: multipart/mixed; boundary="x23KFKtO0yhRUGcR4Af4Mi12osHKYCEgS";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <f0cddac0-a574-1aeb-69c6-b9d67f2dfd97@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Add storage key removal
 facility
References: <20190827134936.1705-1-frankja@linux.ibm.com>
 <20190827134936.1705-4-frankja@linux.ibm.com>
 <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>
In-Reply-To: <ea6d114c-9025-2e15-89b8-52b938efc129@redhat.com>

--x23KFKtO0yhRUGcR4Af4Mi12osHKYCEgS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/27/19 7:58 PM, Thomas Huth wrote:
> On 27/08/2019 15.49, Janosch Frank wrote:
>> The storage key removal facility (stfle bit 169) makes all key related=

>> instructions result in a special operation exception if they handle a
>> key.
>>
>> Let's make sure that the skey and pfmf tests only run non key code
>> (pfmf) or not at all (skey).
>>
>> Also let's test this new facility. As lots of instructions are
>> affected by this, only some of them are tested for now.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---

>> +static void test_skey(void)
>> +{
>> +	report_prefix_push("(i|s)ske");
>> +	expect_pgm_int();
>> +	set_storage_key(pagebuf, 0x30, 0);
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	expect_pgm_int();
>> +	get_storage_key(pagebuf);
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>=20
> Wouldn't it be better to have distinct prefixes for the two tests?

Will do

>=20
>> +}
>> +
>> +static void test_pfmf(void)
>> +{
>> +	union pfmf_r1 r1;
>> +
>> +	report_prefix_push("pfmf");
>> +	r1.val =3D 0;
>> +	r1.reg.sk =3D 1;
>> +	r1.reg.fsc =3D PFMF_FSC_4K;
>> +	r1.reg.key =3D 0x30;
>> +	expect_pgm_int();
>> +	pfmf(r1.val, pagebuf);
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_psw_key(void)
>> +{
>> +	uint64_t psw_mask =3D extract_psw_mask() | 0xF0000000000000UL;
>> +
>> +	report_prefix_push("psw key");
>> +	expect_pgm_int();
>> +	load_psw_mask(psw_mask);
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>> +}
>> +
>> +static void test_mvcos(void)
>> +{
>> +	uint64_t r3 =3D 64;
>> +	uint8_t *src =3D pagebuf;
>> +	uint8_t *dst =3D pagebuf + PAGE_SIZE;
>> +	/* K bit set, as well as keys */
>> +	register unsigned long oac asm("0") =3D 0xf002f002;
>> +
>> +	report_prefix_push("mvcos");
>> +	expect_pgm_int();
>> +	asm volatile(".machine \"z10\"\n"
>> +		     ".machine \"push\"\n"
>=20
> Shouldn't that be the other way round? first push the current one, then=

> set the new one?

Yes, I interpreted the documentation in the wrong way and it was a PPC
documentation anyway :)

>=20
> Anyway, I've now also checked this patch in the CI:
>=20
> diff a/s390x/Makefile b/s390x/Makefile
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -25,7 +25,7 @@ CFLAGS +=3D -std=3Dgnu99
>  CFLAGS +=3D -ffreestanding
>  CFLAGS +=3D -I $(SRCDIR)/lib -I $(SRCDIR)/lib/s390x -I lib
>  CFLAGS +=3D -O2
> -CFLAGS +=3D -march=3Dz900
> +CFLAGS +=3D -march=3Dz10
>  CFLAGS +=3D -fno-delete-null-pointer-checks
>  LDFLAGS +=3D -nostdlib -Wl,--build-id=3Dnone
>=20
> ... and it also seems to work fine with the TCG there:
>=20
> https://gitlab.com/huth/kvm-unit-tests/-/jobs/281450598
>=20
> So I think you can simply change it in the Makefile instead.

z10 or directly something higher?

>=20
>  Thomas
>=20
>> +		     "mvcos	%[dst],%[src],%[len]\n"
>> +		     ".machine \"pop\"\n"
>> +		     : [dst] "+Q" (*(dst))
>> +		     : [src] "Q" (*(src)), [len] "d" (r3), "d" (oac)
>> +		     : "cc", "memory");
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIAL_OPERATION);
>> +	report_prefix_pop();
>> +}



--x23KFKtO0yhRUGcR4Af4Mi12osHKYCEgS--

--5LvCsyVCQkKunP9t8f7wuow6SOVBqPMgQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1mHqEACgkQ41TmuOI4
ufjBQw//ZkFD4cuhAPzsha0FALFVJ+wAoDvaQEYq5GG9YGIoWcdfGlXdFT//Zyg5
2kequ4SjnoAL0kp3bNbG7JWOmM1f8BHUx2nsEgyOpgtVW8JjPllRr3Gsf4R9TgS9
R9jScUcxIMHMG+enh/0TPp29kOxt1cmgErEh4eBoGog+qR8ZgMyR8x3mFJNv8RMN
Z+fqA5ot35MCygNykZmcPO4uWZit9z/HGHHh7Ub0WmiFh2H1vnkxjYRuUDUDHkF2
arghq2e+OHPcqqlTAZ01vDR7GP+OUFMp64xJCjAXa4o4/VA28aPFehV0lR7ApJfy
AJFcXvOp5aFuXY2eJE497HqgE0wKmsGR7YvEh4Q9RIDoELTb/QMJOOGksOnX/ehg
Fwp0LokEpSICvU/ReSu3+DV4TSdJwXuwnb5pIW5RjCy2UNGo1SftgD7Aw/0RvYw8
CNmzB+yDxOgvs5b8QGzTfUo34SzdU4QuXxYeiMSoUJV2J4E32jc7S6A9n4xF5ygM
C9qeVJq80l/W1nkYLsqwzBGsRxINZOdupchWzYL0FfoKHfQSVeSq7ZDimWFvB07P
YilodqnfRUcg8b+qzUokHsHYuQfTNLNsfxFbEDD9o9gmqqogqv0bdtP9hwkPZPtT
9VToVCMOMmSmiYjnxJXRIkT+ev0nFoG3a/tETw9mZn4clMKIsFQ=
=TuBi
-----END PGP SIGNATURE-----

--5LvCsyVCQkKunP9t8f7wuow6SOVBqPMgQ--
