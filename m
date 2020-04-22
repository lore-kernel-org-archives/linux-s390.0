Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgDVJNp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 05:13:45 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M92gkt022223
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:13:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gcbgdtqb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 05:13:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Apr 2020 10:13:05 +0100
Subject: Re: [kvm-unit-tests PATCH v5 02/10] s390x: Use PSW bits definitions
 in cstart
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
 <aae40a5a-63a6-e802-53bb-9683d03ad57d@linux.ibm.com>
 <1b38a0e5-76cf-c3da-fe8d-7a75bf44f19f@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Apr 2020 11:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <1b38a0e5-76cf-c3da-fe8d-7a75bf44f19f@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FWFeuPrxzRFAC695Gb7eTjLM0D2d1Njmw"
Message-Id: <9fb32067-4175-cbe3-94d9-e877d5dce703@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FWFeuPrxzRFAC695Gb7eTjLM0D2d1Njmw
Content-Type: multipart/mixed; boundary="ceVmlMSVVz2ETwoBtrqNSp7AibVMe6J0l"

--ceVmlMSVVz2ETwoBtrqNSp7AibVMe6J0l
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/22/20 11:06 AM, Pierre Morel wrote:
>=20
>=20
> On 2020-04-22 09:35, Janosch Frank wrote:
>> On 2/20/20 1:00 PM, Pierre Morel wrote:
>>> This patch defines the PSW bits EA/BA used to initialize the PSW mask=
s
>>> for exceptions.
>>>
>>> Since some PSW mask definitions exist already in arch_def.h we add th=
ese
>>> definitions there.
>>> We move all PSW definitions together and protect assembler code again=
st
>>> C syntax.
>>
>> Please fix the issue mentioned below and run *all* tests against your
>> new code to verify you didn't introduce regressions.
>>
>> The rest looks good to me.
>=20
> Thanks,
>=20
>>
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   lib/s390x/asm/arch_def.h | 15 +++++++++++----
>>>   s390x/cstart64.S         | 15 ++++++++-------
>>>   2 files changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>> index 15a4d49..69a8256 100644
>>> --- a/lib/s390x/asm/arch_def.h
>>> +++ b/lib/s390x/asm/arch_def.h
>>> @@ -10,15 +10,21 @@
>>>   #ifndef _ASM_S390X_ARCH_DEF_H_
>>>   #define _ASM_S390X_ARCH_DEF_H_
>>>  =20
>>> +#define PSW_MASK_EXT			0x0100000000000000UL
>>> +#define PSW_MASK_DAT			0x0400000000000000UL
>>> +#define PSW_MASK_PSTATE			0x0001000000000000UL
>>> +#define PSW_MASK_BA			0x0000000080000000UL
>>> +#define PSW_MASK_EA			0x0000000100000000UL
>>> +
>>> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
>>
>> Could you add a space before and after the | ?
>>
>>> +
>>> +#ifndef __ASSEMBLER__
>>> +
>>>   struct psw {
>>>   	uint64_t	mask;
>>>   	uint64_t	addr;
>>>   };
>>>  =20
>>> -#define PSW_MASK_EXT			0x0100000000000000UL
>>> -#define PSW_MASK_DAT			0x0400000000000000UL
>>> -#define PSW_MASK_PSTATE			0x0001000000000000UL
>>> -
>>>   #define CR0_EXTM_SCLP			0X0000000000000200UL
>>>   #define CR0_EXTM_EXTC			0X0000000000002000UL
>>>   #define CR0_EXTM_EMGC			0X0000000000004000UL
>>> @@ -297,4 +303,5 @@ static inline uint32_t get_prefix(void)
>>>   	return current_prefix;
>>>   }
>>>  =20
>>> +#endif /* not __ASSEMBLER__ */
>>>   #endif
>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>> index 45da523..2885a36 100644
>>> --- a/s390x/cstart64.S
>>> +++ b/s390x/cstart64.S
>>> @@ -12,6 +12,7 @@
>>>    */
>>>   #include <asm/asm-offsets.h>
>>>   #include <asm/sigp.h>
>>> +#include <asm/arch_def.h>
>>>  =20
>>>   .section .init
>>>  =20
>>> @@ -214,19 +215,19 @@ svc_int:
>>>  =20
>>>   	.align	8
>>>   reset_psw:
>>> -	.quad	0x0008000180000000
>>> +	.quad	PSW_EXCEPTION_MASK
>>
>> That won't work, this is a short PSW and you're removing the short
>> indication here. Notice the 0008 at the front.
>>
>=20
> Will change and define PSW_MASK_SHORT_PSW and PSW_RESET_MASK like:
>=20
> #define PSW_MASK_SHORT_PSW              0x0008000000000000UL
> ...
>=20
> #define PSW_EXCEPTION_MASK      (PSW_MASK_EA | PSW_MASK_BA)
> #define PSW_RESET_MASK          (PSW_EXCEPTION_MASK | PSW_MASK_SHORT_PS=
W)


Looks good to me, but please send out a new version.



--ceVmlMSVVz2ETwoBtrqNSp7AibVMe6J0l--

--FWFeuPrxzRFAC695Gb7eTjLM0D2d1Njmw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6gCsAACgkQ41TmuOI4
ufj5DA/+LhF0yVqIvMXo+jUcijds3G4oI2vCpypVExcr98D21VnyXEuyElmBpSBH
SAME7WehLfOPluRLf+wyRIB13lkiTnJLIDP+SXhL3x7fWQFHuSgB6kHsChKttNLD
8hino4Zo6a1JoUwJ2mVZnVtl0ALkJP/z6kkLV22hLLY36KyWYsD3yGVsHeTRc1D5
Jn7qufoijbBHIDWnli2n373xonrK8xgGU3/40svBFMBPgrPWomLrSxR35yn6hG6l
7sujsFd3CfNwIkKGeFGUvFKzvj5tvTdoTV/b7XAdmnkRU0YOafzysG6a4nrDn/U5
m0dx/0//OpAx9ibzzfZgp7CUQBHb+Kqwzr8+tyLQZM/I5PjSMcVl+qWMFojKZFJI
8SA/mByT70bwGrvaw3c11GPAzJJ2DKjBRuF1Agi0RY7SkGVDojfSU0L5hnCCC3hb
zHIIz0fj6wtRrmyEBsKSVZkyPWfvvsOibJGxfl3dCDgYjJ9GoItNI+6t0Fwd7j9V
PVi7x8VpvrkbHBR8sAPwHhxe1/FVvkgxJQzV/kzeoNTSvGGnoMmyDdq9GWjQKc8H
0SzC2mtAMcN5S2nTbAlCe0XtsOIFeUBT+EmevrFpXqWyG3krkDO2zKzrLr5g4yS0
ktK+E+ksDNAZABbgJU5btOQ7ifwZpDOdkYxwRk58zmxdmdiJ2dE=
=JTtW
-----END PGP SIGNATURE-----

--FWFeuPrxzRFAC695Gb7eTjLM0D2d1Njmw--
