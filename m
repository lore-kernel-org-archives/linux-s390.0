Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37020 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbfKFG6o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 01:58:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA66vd08110823
        for <linux-s390@vger.kernel.org>; Wed, 6 Nov 2019 01:58:43 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3n357a4n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 01:58:43 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 6 Nov 2019 06:58:39 -0000
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: Remove DAT and add short
 indication psw bits on diag308 reset
References: <20191105162828.2490-1-frankja@linux.ibm.com>
 <20191105162828.2490-3-frankja@linux.ibm.com>
 <15a9d438-d906-dcc6-0bda-8c6b049c946d@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 6 Nov 2019 07:58:35 +0100
MIME-Version: 1.0
In-Reply-To: <15a9d438-d906-dcc6-0bda-8c6b049c946d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qs1tlpGuylshWuc6dJwZ6ZcL6csuQxYAJ"
Message-Id: <5147b7e8-0531-30a0-a25b-c36ba0dc9b30@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qs1tlpGuylshWuc6dJwZ6ZcL6csuQxYAJ
Content-Type: multipart/mixed; boundary="u0Qzj72axJ1BERBQZEffiS220yOqOQLst"

--u0Qzj72axJ1BERBQZEffiS220yOqOQLst
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/5/19 8:53 PM, David Hildenbrand wrote:
> On 05.11.19 17:28, Janosch Frank wrote:
>=20
> In the subject "Disable" vs. "Remove" ?
>=20
>> On a diag308 subcode 0 CRs will be reset, so we need to mask of PSW
>> DAT indication until we restore our CRs.
>>
>> Also we need to set the short psw indication to be compliant with the
>> architecture.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/asm-offsets.c  |  1 +
>>   lib/s390x/asm/arch_def.h |  3 ++-
>>   s390x/cstart64.S         | 20 ++++++++++++++------
>>   3 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
>> index 4b213f8..61d2658 100644
>> --- a/lib/s390x/asm-offsets.c
>> +++ b/lib/s390x/asm-offsets.c
>> @@ -58,6 +58,7 @@ int main(void)
>>   	OFFSET(GEN_LC_SW_INT_FPRS, lowcore, sw_int_fprs);
>>   	OFFSET(GEN_LC_SW_INT_FPC, lowcore, sw_int_fpc);
>>   	OFFSET(GEN_LC_SW_INT_CRS, lowcore, sw_int_crs);
>> +	OFFSET(GEN_LC_SW_INT_PSW, lowcore, sw_int_psw);
>>   	OFFSET(GEN_LC_MCCK_EXT_SA_ADDR, lowcore, mcck_ext_sa_addr);
>>   	OFFSET(GEN_LC_FPRS_SA, lowcore, fprs_sa);
>>   	OFFSET(GEN_LC_GRS_SA, lowcore, grs_sa);
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index 07d4e5e..7d25e4f 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -79,7 +79,8 @@ struct lowcore {
>>   	uint32_t	sw_int_fpc;			/* 0x0300 */
>>   	uint8_t		pad_0x0304[0x0308 - 0x0304];	/* 0x0304 */
>>   	uint64_t	sw_int_crs[16];			/* 0x0308 */
>> -	uint8_t		pad_0x0310[0x11b0 - 0x0388];	/* 0x0388 */
>> +	struct psw	sw_int_psw;			/* 0x0388 */
>> +	uint8_t		pad_0x0310[0x11b0 - 0x0390];	/* 0x0390 */
>>   	uint64_t	mcck_ext_sa_addr;		/* 0x11b0 */
>>   	uint8_t		pad_0x11b8[0x1200 - 0x11b8];	/* 0x11b8 */
>>   	uint64_t	fprs_sa[16];			/* 0x1200 */
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index 0455591..2e0dcf5 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -129,8 +129,15 @@ memsetxc:
>>   .globl diag308_load_reset
>>   diag308_load_reset:
>>   	SAVE_REGS
>> -	/* Save the first PSW word to the IPL PSW */
>> +	/* Backup current PSW */
>=20
> /*
>   * Backup the current PSW MASK, as we have to restore it on
>   * success.
>   */
>=20
>>   	epsw	%r0, %r1
>> +	st	%r0, GEN_LC_SW_INT_PSW
>> +	st	%r1, GEN_LC_SW_INT_PSW + 4
>=20
> I was confused at first, but then I realized that you really only store=
=20
> the PSW mask here and not also the PSW address ...
>=20
>=20
>> +	/* Disable DAT as the CRs will be reset too */
>> +	nilh	%r0, 0xfbff
>> +	/* Add psw bit 12 to indicate short psw */
>> +	oilh	%r0, 0x0008
>=20
> Why care about the old PSW mask here at all? Wouldn't it be easier to=20
> just construct a new PSW mask from scratch? (64bit, PSW bit 12 set ...)=

>=20
> Save it somewhere and just load it directly from memory.

Sounds like a good idea, will do

>=20
>> +	/* Save the first PSW word to the IPL PSW */
>>   	st	%r0, 0
>>   	/* Store the address and the bit for 31 bit addressing */
>>   	larl    %r0, 0f
>> @@ -142,12 +149,13 @@ diag308_load_reset:
>>   	xgr	%r2, %r2
>>   	br	%r14
>>   	/* Success path */
>> -	/* We lost cr0 due to the reset */
>> -0:	larl	%r1, initial_cr0
>> -	lctlg	%c0, %c0, 0(%r1)
>> -	RESTORE_REGS
>> +	/* Switch to z/Architecture mode and 64-bit */
>> +0:	RESTORE_REGS
>>   	lhi	%r2, 1
>> -	br	%r14
>> +	larl	%r0, 1f
>> +	stg	%r0, GEN_LC_SW_INT_PSW + 8
>> +	lpswe	GEN_LC_SW_INT_PSW
>> +1:	br	%r14
>>  =20
>>   .globl smp_cpu_setup_state
>>   smp_cpu_setup_state:
>>
>=20
>=20



--u0Qzj72axJ1BERBQZEffiS220yOqOQLst--

--qs1tlpGuylshWuc6dJwZ6ZcL6csuQxYAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3CbxsACgkQ41TmuOI4
ufiIOQ/+Pw7kbOK8m2UiEUv4nkxxgWWvrZZi65Go1e0FtziUHs05sVD8vUUYc4iw
YwqjJOs2chOD1fRVTP7meBwFNCiYMWn7sYKVYW0irp1Uldz3ffNyNfBCozD2JGco
ix+pUfL5Mv7kRL9z+kFhyzLa1iam9G/6keDQZDtqn3O8yPSefk5OC33+ZEVlFmTh
DAjNjWasMaiz38JSBI8WwJ/P10co2s0FOUa0E9+bCf2iBPeItBkXLTdVfMX7R+Rc
d6CdY8EkM7OVd+Qc7TB8PBJNn0oIyjZeXM3gNkd6NkINjxuSlL89YWEc06vNrRHt
w6CEThkjMSj6p6auk0JfGg0ZLdx5DBKSV6d4kMxD/AegKgWxUKdhOtGYB0m2FOQu
hjQEMDIsPmtEyndaPEzLaoXXJZtm6inwkBzi5LqRFtQWQUlCWCV86RstZRyte+n2
vZSKWHLDXpLXNL7ZJTVRhURv0E9IE8UbfFI8JAyhGBN0bUt3dfRUAaFqgsqapMNd
mKbVwGQHjOtVaDt+ZPKQSwUu+vQDAyIINTW8164FlLxvwdbViJUrCoEgdE3+SerD
4rGqlNqUMIPPA0udrs0VMgfsyVII3z4zuGfopQp8QIeErHDfe63QGVxFOWHqx6zE
c+4dfw6iM69g7M81p9QSVEkCSRy4YoxzrVwgxZHOg4krSWbOCnQ=
=h+Id
-----END PGP SIGNATURE-----

--qs1tlpGuylshWuc6dJwZ6ZcL6csuQxYAJ--
