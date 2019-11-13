Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726155AbfKMKE6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 05:04:58 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADA2f0E082917
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 05:04:57 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8ex21ydp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 05:04:56 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 13 Nov 2019 10:04:55 -0000
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Load reset psw on diag308
 reset
References: <20191111153345.22505-1-frankja@linux.ibm.com>
 <20191111153345.22505-4-frankja@linux.ibm.com>
 <7683adc7-2cd0-1103-d231-8a1577f1e673@redhat.com>
 <a22f8407-efb1-ab0e-eaf6-77d0b853c6de@linux.ibm.com>
 <f3be87c4-135e-dd42-b9b4-aadc0d0c90ca@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 13 Nov 2019 11:04:51 +0100
MIME-Version: 1.0
In-Reply-To: <f3be87c4-135e-dd42-b9b4-aadc0d0c90ca@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="R9M4CJ64KgErxY7TzRvS9mPqN6v2vSIBi"
Message-Id: <1dac633a-65f3-5331-ecd7-6173acffa360@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R9M4CJ64KgErxY7TzRvS9mPqN6v2vSIBi
Content-Type: multipart/mixed; boundary="qidyiw5avUOLYvIyf2HQhNK20D8OrDgVc"

--qidyiw5avUOLYvIyf2HQhNK20D8OrDgVc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/12/19 5:17 PM, Thomas Huth wrote:
> On 12/11/2019 14.42, Janosch Frank wrote:
>> On 11/12/19 1:09 PM, David Hildenbrand wrote:
>>> On 11.11.19 16:33, Janosch Frank wrote:
>>>> On a diag308 subcode 0 CRs will be reset, so we need a PSW mask
>>>> without DAT. Also we need to set the short psw indication to be
>>>> compliant with the architecture.
>>>>
>>>> Let's therefore define a reset PSW mask with 64 bit addressing and
>>>> short PSW indication that is compliant with architecture and use it.=

>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  lib/s390x/asm-offsets.c  |  1 +
>>>>  lib/s390x/asm/arch_def.h |  3 ++-
>>>>  s390x/cstart64.S         | 24 +++++++++++++++++-------
>>>>  3 files changed, 20 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
>>>> index 4b213f8..61d2658 100644
>>>> --- a/lib/s390x/asm-offsets.c
>>>> +++ b/lib/s390x/asm-offsets.c
>>>> @@ -58,6 +58,7 @@ int main(void)
>>>>  	OFFSET(GEN_LC_SW_INT_FPRS, lowcore, sw_int_fprs);
>>>>  	OFFSET(GEN_LC_SW_INT_FPC, lowcore, sw_int_fpc);
>>>>  	OFFSET(GEN_LC_SW_INT_CRS, lowcore, sw_int_crs);
>>>> +	OFFSET(GEN_LC_SW_INT_PSW, lowcore, sw_int_psw);
>>>>  	OFFSET(GEN_LC_MCCK_EXT_SA_ADDR, lowcore, mcck_ext_sa_addr);
>>>>  	OFFSET(GEN_LC_FPRS_SA, lowcore, fprs_sa);
>>>>  	OFFSET(GEN_LC_GRS_SA, lowcore, grs_sa);
>>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>>> index 07d4e5e..7d25e4f 100644
>>>> --- a/lib/s390x/asm/arch_def.h
>>>> +++ b/lib/s390x/asm/arch_def.h
>>>> @@ -79,7 +79,8 @@ struct lowcore {
>>>>  	uint32_t	sw_int_fpc;			/* 0x0300 */
>>>>  	uint8_t		pad_0x0304[0x0308 - 0x0304];	/* 0x0304 */
>>>>  	uint64_t	sw_int_crs[16];			/* 0x0308 */
>>>> -	uint8_t		pad_0x0310[0x11b0 - 0x0388];	/* 0x0388 */
>>>> +	struct psw	sw_int_psw;			/* 0x0388 */
>>>> +	uint8_t		pad_0x0310[0x11b0 - 0x0390];	/* 0x0390 */
>>>>  	uint64_t	mcck_ext_sa_addr;		/* 0x11b0 */
>>>>  	uint8_t		pad_0x11b8[0x1200 - 0x11b8];	/* 0x11b8 */
>>>>  	uint64_t	fprs_sa[16];			/* 0x1200 */
> [...]
>>> This patch breaks the smp test under TCG (no clue and no time to look=

>>> into the details :) ):
>>
>> I forgot to fixup the offset calculation at the top of the patch once
>> again...
>=20
> Maybe add a
>=20
> _Static_assert(sizeof(struct lowcore) =3D=3D xyz)
>=20
> after the struct definitions, to avoid that this happens again?
>=20
>  Thomas
>=20

How about this?
Or do we want to extend the struct to 8K and test for that?

diff --git i/lib/s390x/asm/arch_def.h w/lib/s390x/asm/arch_def.h
index 5f034a7..cf6e1ca 100644
--- i/lib/s390x/asm/arch_def.h
+++ w/lib/s390x/asm/arch_def.h
@@ -99,6 +99,7 @@ struct lowcore {
        uint8_t         pad_0x1400[0x1800 - 0x1400];    /* 0x1400 */
        uint8_t         pgm_int_tdb[0x1900 - 0x1800];   /* 0x1800 */
 } __attribute__ ((__packed__));
+_Static_assert(sizeof(struct lowcore) =3D=3D 0x1900, "Lowcore size");

 #define PGM_INT_CODE_OPERATION                 0x01
 #define PGM_INT_CODE_PRIVILEGED_OPERATION      0x02


--qidyiw5avUOLYvIyf2HQhNK20D8OrDgVc--

--R9M4CJ64KgErxY7TzRvS9mPqN6v2vSIBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3L1UMACgkQ41TmuOI4
ufjDOg/9HhG3Go2fGO8oyrGYcYsUtzPpWzIvnNjN+RrC1AJ926/ILPtNSSG/Bs2t
UKyJSW6XrOWb1vGzR2+HdpOpOSO/nyxdnFfRXs9zLhNSpiYKbGRC5RH7d9k0qqSR
iMWv7rxBrIqq4pK1/1yj+mXD68lCx5HLQvdWvPPj6ErjjS9zPePLHWTETN81md8Z
Gas0KppzhVeY0VWeFfFWWFOB/KQFhbS/ubxEI76eXy5t5GYOsq7KWrI3iZxAI0m9
jAkXBeumbRWlFtDR/szqYUomGmwKyNCtjI0vI8WVTu/GATvtMPXtB7NJXNfferJi
dMJCH/1phE6/xOpfsgOsCvWMQdm2wDUYoLI12Cr1PmeBJDuL2ie4tRiy81+sGXek
9hmfCKM2E/R1vusypBPd+ycDpZdvD6fKf3rAIg1wXle9n9FXIiyRw93qOrtS99dZ
HTuFgt52T0OzkJhuCz+mMtt/nSZggtJJd1X4gQClG2KByBq7feqHWG7afRVYa+CO
EFI8L/nVwKTJL6ILOPsd4mLAjmi2urrScGhey5BLcfOpI/vpqUVuf+CJeyfjKKSV
xGAMI2q9/ypdB+GfMK2BKmpMAInZi5d+wmBAZ0k+cb4i9iy/iVswHxvPN94S8HBx
maHKca4XfHntfYH7kGNQXJ74riSjQTAiV/lFXKxlruEw4jcLips=
=ckTA
-----END PGP SIGNATURE-----

--R9M4CJ64KgErxY7TzRvS9mPqN6v2vSIBi--
