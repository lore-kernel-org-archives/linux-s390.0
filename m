Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730831AbfIBORb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Sep 2019 10:17:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x82EHCxH096445
        for <linux-s390@vger.kernel.org>; Mon, 2 Sep 2019 10:17:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2us3vq9nsd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 02 Sep 2019 10:17:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 2 Sep 2019 15:17:27 +0100
Subject: Re: [kvm-unit-tests PATCH 5/6] s390x: Prepare for external calls
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-6-frankja@linux.ibm.com>
 <e32aef57-e9a0-032d-3dec-5c3227225918@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 2 Sep 2019 16:17:23 +0200
MIME-Version: 1.0
In-Reply-To: <e32aef57-e9a0-032d-3dec-5c3227225918@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UEnPJZ4uXXPod6AHevSh3B5bhjl3P5O6O"
Message-Id: <9a1ff6d5-fdd9-730c-cedf-2ec08447e8fb@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UEnPJZ4uXXPod6AHevSh3B5bhjl3P5O6O
Content-Type: multipart/mixed; boundary="7CIqhLPTSb6G5o2S2zZAYE6wEt6fXkl9o";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <9a1ff6d5-fdd9-730c-cedf-2ec08447e8fb@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 5/6] s390x: Prepare for external calls
References: <20190829121459.1708-1-frankja@linux.ibm.com>
 <20190829121459.1708-6-frankja@linux.ibm.com>
 <e32aef57-e9a0-032d-3dec-5c3227225918@redhat.com>
In-Reply-To: <e32aef57-e9a0-032d-3dec-5c3227225918@redhat.com>

--7CIqhLPTSb6G5o2S2zZAYE6wEt6fXkl9o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/2/19 3:58 PM, Thomas Huth wrote:
> On 29/08/2019 14.14, Janosch Frank wrote:
>> With SMP we also get new external interrupts like external call and
>> emergency call. Let's make them known.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm/arch_def.h  |  5 +++++
>>  lib/s390x/asm/interrupt.h |  3 +++
>>  lib/s390x/interrupt.c     | 24 ++++++++++++++++++++----
>>  3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index d5a7f51..5ece2ce 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -19,6 +19,11 @@ struct psw {
>>  #define PSW_MASK_DAT			0x0400000000000000UL
>>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>> =20
>> +#define CR0_EXTM_SCLP			0X0000000000000200UL
>> +#define CR0_EXTM_EXTC			0X0000000000004000UL
>> +#define CR0_EXTM_EMGC			0X0000000000008000UL
>> +#define CR0_EXTM_MASK			0X000000000001DD40UL
>=20
> I think I need more coffee... but if I still count right, the EXTC, EMG=
C
> and some of the mask bits seem to be off-by-one ? Could that be? Please=

> double-check.
>=20
>  Thomas

They are definitely wrong, but as they are not used anyway it doesn't
make a difference in the test that follows -_-



--7CIqhLPTSb6G5o2S2zZAYE6wEt6fXkl9o--

--UEnPJZ4uXXPod6AHevSh3B5bhjl3P5O6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1tJHMACgkQ41TmuOI4
ufh9bg/+JADSH07/b/+nOV0MGOiuWQVeRzNYRtemG62UqzOmYljllvoEmaoIhzoQ
ald7WDOukgk7/tIJRfsL+CnUYuKnjjBf7rN62iiJm24r1ZkV4h/U+A6jaI3gkj0E
XkqEamLD86OAZzRp/TPpTWuglUkIROkEY6m6APVuYCXUhJvMeqS9FHUNbbao10SW
x6WXqbv96h2HUo/9e8S38dtcDznOfGrsFIaFId8NdkLJ3agb42TdUI5XGZD6IRYK
5HCi0fEqZ5Xz7gNBPZ5YzhRI5BYFy/c28ftaZlbhd/oCdLUuUI4PT+WTpAZShlF8
g3h45FWW6EITBcCW76V1MxHRSXrIz7Yt9NgmEzwVeWaQmn38ETyvqLLUKV2as9ZJ
gTZM9JHIR2me5CWR5SOGHJpXLOpYLEYnR8TybesNzY7ni1pR72S62M09a0T4yrsP
a8dKTbbgO6hxN+ZVeVjIz1aqXCdS6k+wL4RVLRLl3AM8qAGN25iPbnoyQjHrUB/S
3O4P9TGGgW8hlMzWRnV0VR4ShunA5uY7nyBy9vtj2uZcBDCdXXJT9iLQ+CAoN1+Z
+yLqL1h1YEAY1vwe1VglLrZRXeRuSV5Ot8yFo2vlObwBWBmx469JM3oBCJNS+N/U
L3YQ/wFh1ZQbntLXLNUa1VcaLTLgA+/rZE4A7dLsyRrBVa7Z7qE=
=scDh
-----END PGP SIGNATURE-----

--UEnPJZ4uXXPod6AHevSh3B5bhjl3P5O6O--
