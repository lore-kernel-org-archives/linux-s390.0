Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30914 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbfKNIxP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 03:53:15 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAE8iUih006745
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 03:53:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w92jkt6sp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 03:53:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 14 Nov 2019 08:53:11 -0000
Subject: Re: [PATCH v1 2/4] s390x: Define the PSW bits
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-3-git-send-email-pmorel@linux.ibm.com>
 <5796f620-7ee6-6333-e4f4-5e904284a331@linux.ibm.com>
 <189f8129-86c5-8761-fdfe-d08c34fb1f18@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 14 Nov 2019 09:53:06 +0100
MIME-Version: 1.0
In-Reply-To: <189f8129-86c5-8761-fdfe-d08c34fb1f18@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bvrZk29AW7JlVivJwCtwUVDz2tOxzbyUE"
Message-Id: <e27023c2-5f9c-884d-e194-4420ec6e3023@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bvrZk29AW7JlVivJwCtwUVDz2tOxzbyUE
Content-Type: multipart/mixed; boundary="qXhX8UDA3YZv8oZ0t2M2KkPYTfvHszah2"

--qXhX8UDA3YZv8oZ0t2M2KkPYTfvHszah2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/14/19 9:40 AM, Pierre Morel wrote:
>=20
> On 2019-11-13 17:05, Janosch Frank wrote:
>> On 11/13/19 1:23 PM, Pierre Morel wrote:
>>> Instead of assigning obfuscated masks to the PSW dedicated to the
>>> exceptions, let's define the masks explicitely, it will clarify the
>> s/explicitely/explicitly/
>> Try to break that up into sentences.
> OK thx
>>
>>> usage.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   lib/s390x/asm/arch_bits.h | 32 ++++++++++++++++++++++++++++++++
>>>   lib/s390x/asm/arch_def.h  |  6 ++----
>>>   s390x/cstart64.S          | 13 +++++++------
>>>   3 files changed, 41 insertions(+), 10 deletions(-)
>>>   create mode 100644 lib/s390x/asm/arch_bits.h
>>>
>>> diff --git a/lib/s390x/asm/arch_bits.h b/lib/s390x/asm/arch_bits.h
>>> new file mode 100644
>>> index 0000000..0521125
>>> --- /dev/null
>>> +++ b/lib/s390x/asm/arch_bits.h
>>> @@ -0,0 +1,32 @@
>>> +
>>> +/*
>>> + * Copyright (c) 2019 IBM Corp
>>> + *
>>> + * Authors:
>>> + *  Pierre Morel <pmorel@linux.ibm.com>
>>> + *
>>> + * This code is free software; you can redistribute it and/or modify=
 it
>>> + * under the terms of the GNU Library General Public License version=
 2.
>>> + */
>>> +#ifndef _ASM_S390X_ARCH_BITS_H_
>>> +#define _ASM_S390X_ARCH_BITS_H_
>>> +
>>> +#define PSW_MASK_PER		0x4000000000000000
>>> +#define PSW_MASK_DAT		0x0400000000000000
>>> +#define PSW_MASK_IO		0x0200000000000000
>>> +#define PSW_MASK_EXT		0x0100000000000000
>>> +#define PSW_MASK_BASE		0x0000000000000000
>>> +#define PSW_MASK_KEY		0x00F0000000000000
>>> +#define PSW_MASK_MCHECK		0x0004000000000000
>>> +#define PSW_MASK_WAIT		0x0002000000000000
>>> +#define PSW_MASK_PSTATE		0x0001000000000000
>>> +#define PSW_MASK_ASC		0x0000C00000000000
>>> +#define PSW_MASK_CC		0x0000300000000000
>>> +#define PSW_MASK_PM		0x00000F0000000000
>>> +#define PSW_MASK_RI		0x0000008000000000
>>> +#define PSW_MASK_EA		0x0000000100000000
>>> +#define PSW_MASK_BA		0x0000000080000000
>> a-f should be lower case in hex values.
>> Also, do we need all of them?
>> I'd like to keep it as small as poss
>>
>>
>>>> +
>>>> +#endif
>>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>>> index 96cca2e..34c1188 100644
>>>> --- a/lib/s390x/asm/arch_def.h
>>>> +++ b/lib/s390x/asm/arch_def.h
>>>> @@ -10,15 +10,13 @@
>>>>   #ifndef _ASM_S390X_ARCH_DEF_H_
>>>>   #define _ASM_S390X_ARCH_DEF_H_
>>>>  =20
>>>> +#include <asm/arch_bits.h>
>>>> +
>>>>   struct psw {
>>>>   	uint64_t	mask;
>>>>   	uint64_t	addr;
>>>>   };
>>>>  =20
>>>> -#define PSW_MASK_EXT			0x0100000000000000UL
>>>> -#define PSW_MASK_DAT			0x0400000000000000UL
>>>> -#define PSW_MASK_PSTATE			0x0001000000000000UL
>>>> -
>>>>   #define CR0_EXTM_SCLP			0X0000000000000200UL
>>>>   #define CR0_EXTM_EXTC			0X0000000000002000UL
>>>>   #define CR0_EXTM_EMGC			0X0000000000004000UL
>>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>>> index eaff481..7475f32 100644
>>>> --- a/s390x/cstart64.S
>>>> +++ b/s390x/cstart64.S
>>>> @@ -11,6 +11,7 @@
>>>>    * under the terms of the GNU Library General Public License versi=
on 2.
>>>>    */
>>>>   #include <asm/asm-offsets.h>
>>>> +#include <asm/arch_bits.h>
>>>>   #include <asm/sigp.h>
>>>>  =20
>>>>   .section .init
>>>> @@ -196,17 +197,17 @@ svc_int:
>>>>  =20
>>>>   	.align	8
>>>>   initial_psw:
>>>> -	.quad	0x0000000180000000, clear_bss_start
>>>> +	.quad	PSW_EXCEPTION_MASK, clear_bss_start
>>>>   pgm_int_psw:
>>>> -	.quad	0x0000000180000000, pgm_int
>>>> +	.quad	PSW_EXCEPTION_MASK, pgm_int
>>>>   ext_int_psw:
>>>> -	.quad	0x0000000180000000, ext_int
>>>> +	.quad	PSW_EXCEPTION_MASK, ext_int
>>>>   mcck_int_psw:
>>>> -	.quad	0x0000000180000000, mcck_int
>>>> +	.quad	PSW_EXCEPTION_MASK, mcck_int
>>>>   io_int_psw:
>>>> -	.quad	0x0000000180000000, io_int
>>>> +	.quad	PSW_EXCEPTION_MASK, io_int
>>>>   svc_int_psw:
>>>> -	.quad	0x0000000180000000, svc_int
>>>> +	.quad	PSW_EXCEPTION_MASK, svc_int
>>>>   initial_cr0:
>>>>   	/* enable AFP-register control, so FP regs (+BFP instr) can be us=
ed */
>>>>   	.quad	0x0000000000040000
>>>>
>> ible.
>=20
> OK
>=20
>=20
>>
>>> +
>>> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
>> That's not a bit anymore, shouldn't that be in arch_def.h?
>> Also please add a comment, that this is 64 bit addressing.
>=20
>=20
> Don't we use the 64bit architecture only?

architecture !=3D addressing
We can do 24 bit addressing on zArch...
We mostly use ESAME (zArch), but old machines start up in the old mode
and then we transition to zArch via a SIGP.

>=20
> Regards,
>=20
> Pierre
>=20
>=20



--qXhX8UDA3YZv8oZ0t2M2KkPYTfvHszah2--

--bvrZk29AW7JlVivJwCtwUVDz2tOxzbyUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3NFfMACgkQ41TmuOI4
ufgrlw/+OHrZktIYzOGWHPzFueuJgRsleq/RvwzStAeZrS4b68rEMLYHOmJlvJ4x
GKZ4lfwvIOrcPQQIuGNmj+dRwunuNQs+zZgPflC8AHqVrJSfY8A7f1ixPVb65kcx
JTU1Bv+4C6cPAWLymKsPl4FIq6k31zYujWYFYe6hseFQhPArf6UbtJJLVNWm371W
KC6L+rKDgl+sRw6E4lRzUR3q1gTdLRV/WDrOsjcn7r7hSOfKWAiVQsQHta1cFDAG
RJFhTKMv49F8OPxI1o0sAuYxF6AfvQ20adbNcKwUHNJoPJ6TUPQhGqatpHOIRIJ+
E4uDkp9/Qwy77VPCscFhUh1f6DJHxLyV3NudJrSyUyZPA7f1sWFXvXK13bmuc6Fo
fo/Sv2Sbp5bjtV1MUL+BcFfPqFBriuwL3LuVennY6kLWcr5ZJCtRqaVA2LViZu0y
UBB4cALLZ5Scy9fITNsEPX52/vE4ia56bizAHI+CgT/sdgR6745KoGbQ7/Q2th4T
K0S/ELEMZU5ulXFG1+T3Twy9zD6cFT0feBE0Ndu4qdYyefA8vUMLcV8RoQemxI1d
bC5HlLWtWdlCW+mA64NCYX9GFxDRjdmiYG+ml9hw3mxfaUoab2s7KcaPHtkTDOxU
7j1ebo6hQpBBSpIaNOsfr+qpAebfGHfBcQp0QISHAoIvONdBbMI=
=XI5X
-----END PGP SIGNATURE-----

--bvrZk29AW7JlVivJwCtwUVDz2tOxzbyUE--
