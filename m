Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfHUIrC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Aug 2019 04:47:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7L8dDmI012512
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 04:47:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh0mpwgut-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 21 Aug 2019 04:47:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 21 Aug 2019 09:46:58 +0100
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: STSI tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-4-frankja@linux.ibm.com>
 <ef4faf31-e9db-f984-94ec-f3c332823b6f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 21 Aug 2019 10:46:54 +0200
MIME-Version: 1.0
In-Reply-To: <ef4faf31-e9db-f984-94ec-f3c332823b6f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i46DJLcmY8aRHGp7zothYhcO0H3zCuEZ6"
Message-Id: <08a4f2f8-5654-7883-615a-5a8d5f9b72b1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i46DJLcmY8aRHGp7zothYhcO0H3zCuEZ6
Content-Type: multipart/mixed; boundary="2YH4lhAejYvP9htODCU6luvP6d6AcGZDD";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <08a4f2f8-5654-7883-615a-5a8d5f9b72b1@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: STSI tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <20190820105550.4991-4-frankja@linux.ibm.com>
 <ef4faf31-e9db-f984-94ec-f3c332823b6f@redhat.com>
In-Reply-To: <ef4faf31-e9db-f984-94ec-f3c332823b6f@redhat.com>

--2YH4lhAejYvP9htODCU6luvP6d6AcGZDD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 3:21 PM, Thomas Huth wrote:
> On 8/20/19 12:55 PM, Janosch Frank wrote:
>> For now let's concentrate on the error conditions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/Makefile      |   1 +
>>  s390x/stsi.c        | 123 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |   5 +-
>>  3 files changed, 128 insertions(+), 1 deletion(-)
>>  create mode 100644 s390x/stsi.c
>>
>> diff --git a/s390x/Makefile b/s390x/Makefile
>> index b654c56..311ab77 100644
>> --- a/s390x/Makefile
>> +++ b/s390x/Makefile
>> @@ -12,6 +12,7 @@ tests +=3D $(TEST_DIR)/vector.elf
>>  tests +=3D $(TEST_DIR)/gs.elf
>>  tests +=3D $(TEST_DIR)/iep.elf
>>  tests +=3D $(TEST_DIR)/diag288.elf
>> +tests +=3D $(TEST_DIR)/stsi.elf
>>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
>> =20
>>  all: directories test_cases test_cases_binary
>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>> new file mode 100644
>> index 0000000..005f337
>> --- /dev/null
>> +++ b/s390x/stsi.c
>> @@ -0,0 +1,123 @@
>> +/*
>> + * Store System Information tests
>> + *
>> + * Copyright (c) 2019 IBM Corp
>> + *
>> + * Authors:
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify =
it
>> + * under the terms of the GNU Library General Public License version =
2.
>> + */
>> +
>> +#include <libcflat.h>
>> +#include <asm/page.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/interrupt.h>
>> +
>> +static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZ=
E * 2)));
>> +
>> +static inline unsigned long stsi(unsigned long *addr,
>> +				 unsigned long fc, uint8_t sel1, uint8_t sel2)
>=20
> Return code should be "int", not "long".
>=20
> I'd also suggest to use "void *addr" instead of "unsigned long *addr",
> then you don't have to cast the pagebuf when you're calling this functi=
on.

Ok

>=20
>> +{
>> +	register unsigned long r0 asm("0") =3D (fc << 28) | sel1;
>> +	register unsigned long r1 asm("1") =3D sel2;
>> +	int cc;
>> +
>> +	asm volatile("stsi	0(%3)\n"
>> +		     "ipm	 %[cc]\n"
>> +		     "srl	 %[cc],28\n"
>> +		     : "+d" (r0), [cc] "=3Dd" (cc)
>> +		     : "d" (r1), "a" (addr)
>> +		     : "cc", "memory");
>> +	return cc;
>> +}
>=20
> Bonus points for putting that function into a header and re-use it in
> skey.c (maybe in a separate patch, though).

I forgot that you added that...
How about moving it to lib/s390/asm/arch_def.h ?

[...]

>> +static void test_fc(void)
>> +{
>> +	report("cc =3D=3D 3", stsi((void *)pagebuf, 7, 0, 0));
>=20
> Shouldn't that line look like this instead:
>=20
>     	report("cc =3D=3D 3", stsi((void *)pagebuf, 7, 0, 0) =3D=3D 3);
>=20
> ?

Yes

>=20
>> +	report("r0 =3D=3D 3", stsi_get_fc((void *)pagebuf));
>=20
>     report("r0 >=3D 3", stsi_get_fc((void *)pagebuf) >=3D 3);
>=20
> ?

Well rather >=3D 2 because we can also run on lpar with some additional
patches applied. Time to test this under lpar...

>=20
>> +}
>> +
>> +int main(void)
>> +{
>> +	report_prefix_push("stsi");
>> +	test_priv();
>> +	test_specs();
>> +	test_fc();
>> +	return report_summary();
>> +}
>=20
> How about adding another test for access exceptions? Activate low
> address protection, then store to address 4096 ... and/or check
> "stsi((void *)-0xdeadadd, 1, 0, 0);" ?

Sounds good

>=20
>  Thomas
>=20



--2YH4lhAejYvP9htODCU6luvP6d6AcGZDD--

--i46DJLcmY8aRHGp7zothYhcO0H3zCuEZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1dBP4ACgkQ41TmuOI4
ufh0+RAAzk77Kl+NrJ5MT6YKtiS+Fl7XqYS69sQlBQaAlHFUAMVsmhslFwSZybn+
FT5fUFewNhIU6kGjNnnX5MzMrBOCnkuB7s+GJ8B19EQtfrzvtXdqKIcx+Ro3jOCm
DeM8hr4cbsSNcj4VgSOxiN08nEMAZWnb0XtjIfQgOkkje6sMpU5TkE00EHKHZDbP
xHnIJyev7B04USALDEiwhOUL8Diw30Fp6zbayrBVzOYjFPwoBGr7lyuhWCUcHx4p
hrfhWZIaX7LgTRaaL4R/16nrc02PfFek5y18p4dw3XHgTjhEUBwsXWZweeVaInOL
OuVv6oVpC5lz/BO37CW3OMjFaSy2MZe9wklrK8L8N8uBeouuq0v77uTYPS/Yc7bu
ApE1Ck46NSdqympKR0PutR1cjGUriRK1UMzSKzGOQKjzm42oel1S6rRROce7elEy
GIwGOPL7fC0xBKvYOARDkPMz7lgZ9jpdsqJuAdW3l51yIslpOMRoCWR2Yiq8zc/I
MAIqlbRKVWIlFZuTCrYvRlf3qyphZdX8D4KSTh5lvmEf3ZBtl3ltrUR8aG1x1nV4
HEdoawzQXmRta4pfp4Y4SgHx0E0oilVnzpVIE7DuAwvYfode+P15DfCF2Z9+OVKS
hOfa+O6H4HWIRv47WiTyIIX9BlZJhNiaL58HmvnLfP90DlYe/IU=
=6Lxl
-----END PGP SIGNATURE-----

--i46DJLcmY8aRHGp7zothYhcO0H3zCuEZ6--
