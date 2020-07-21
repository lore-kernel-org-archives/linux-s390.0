Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728850AbgGUIw0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jul 2020 04:52:26 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-3-frankja@linux.ibm.com>
 <78da93f7-118d-2c1d-582a-092232f36108@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <032c1103-3020-9deb-a307-70ded3bdb55e@linux.ibm.com>
Date: Tue, 21 Jul 2020 10:52:18 +0200
MIME-Version: 1.0
In-Reply-To: <78da93f7-118d-2c1d-582a-092232f36108@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xMZyrpipTA2KqjcA3SYYgxjli9C4GwRh9"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xMZyrpipTA2KqjcA3SYYgxjli9C4GwRh9
Content-Type: multipart/mixed; boundary="Pgy1o91AOZpK5E76FrGO7T6I0fTfchkNW"

--Pgy1o91AOZpK5E76FrGO7T6I0fTfchkNW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/21/20 9:28 AM, Thomas Huth wrote:
> On 17/07/2020 16.58, Janosch Frank wrote:
>> If a exception new psw mask contains a key a specification exception
>> instead of a special operation exception is presented.
>=20
> I have troubles parsing that sentence... could you write that different=
ly?
> (and: "s/a exception/an exception/")

How about:

When an exception psw new with a storage key in its mask is loaded from
lowcore a specification exception is raised instead of the special
operation exception that is normally presented when skrf is active.

>=20
>> Let's test
>> that.
>>
>> Also let's add the test to unittests.cfg so it is run more often.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/skrf.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  4 +++
>>  2 files changed, 85 insertions(+)
>>
>> diff --git a/s390x/skrf.c b/s390x/skrf.c
>> index 9cae589..9733412 100644
>> --- a/s390x/skrf.c
>> +++ b/s390x/skrf.c
>> @@ -15,6 +15,8 @@
>>  #include <asm/page.h>
>>  #include <asm/facility.h>
>>  #include <asm/mem.h>
>> +#include <asm/sigp.h>
>> +#include <smp.h>
>> =20
>>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZ=
E * 2)));
>> =20
>> @@ -106,6 +108,84 @@ static void test_tprot(void)
>>  	report_prefix_pop();
>>  }
>> =20
>> +#include <asm-generic/barrier.h>
>=20
> Can we keep the #includes at the top of the file, please?

Yes

>=20
>> +static int testflag =3D 0;
>> +
>> +static void wait_for_flag(void)
>> +{
>> +	while (!testflag)
>> +		mb();
>> +}
>> +
>> +static void set_flag(int val)
>> +{
>> +	mb();
>> +	testflag =3D val;
>> +	mb();
>> +}
>> +
>> +static void ecall_cleanup(void)
>> +{
>> +	struct lowcore *lc =3D (void *)0x0;
>> +
>> +	lc->ext_new_psw.mask =3D 0x0000000180000000UL;
>=20
> Don't we have defines for the PSW values yet?

Pierre dropped that patch because of your old binutils version...

>=20
>> +	lc->sw_int_crs[0] =3D 0x0000000000040000;
>> +
>> +	/*
>> +	 * PGM old contains the ext new PSW, we need to clean it up,
>> +	 * so we don't get a special oepration exception on the lpswe
>=20
> operation

fixed

>=20
>> +	 * of pgm old.
>> +	 */
>> +	lc->pgm_old_psw.mask =3D 0x0000000180000000UL;
>> +	lc->pgm_old_psw.addr =3D (unsigned long)wait_for_flag;
>> +
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>> +	set_flag(1);
>> +}
>=20
>  Thomas
>=20



--Pgy1o91AOZpK5E76FrGO7T6I0fTfchkNW--

--xMZyrpipTA2KqjcA3SYYgxjli9C4GwRh9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8WrMIACgkQ41TmuOI4
ufikrBAAt3tuzugHWo+wRVmTna4z83VE4T4EreGnRr0dLChOM3ulqk/XwIKzNpPJ
9OQzdpvYsY2Si9Z9FKElMOVe+9OLXe0D78ksRBzdEC7WphdLUxVXawSeB+cLqIEW
vn4hDvPJipg6J2fAjG1sOeErWQbGmjra1P/GFEY15rGQ23AHqCWXIz+w1OicCrtb
pPDWPluK98UTiqYAg9OjJxHrvjr/dvxQijMdW97XEKQ4OeHV0XT9zhKrTtKAoGp9
gD1goKDJNr64fPoVnduzKgZdiPPbPlrci9daVhgsAzF4cTlWqm7xBiVFdNPpH54U
wbVUzAwCmxkfknW7WhwwXeW8zLy3HrfYiaK5vaZm6FO25roUO6HTadgHqC8t6wwa
B3c8IBjFXllF1Y+OyufTbVu4kc0N3l9dMQAWE9nrVgkYZqVS4KVSKqWlQJqdJ3i0
KtbQSI7HttkkVW/bCR4W9ofOOpmSxCQnJ1jfavQ+ZQHASRkbsgCB9tEuCJ0blXBT
TDrsCcKQj4HDY1S8wsD/bwZV3ZBzKbCopakLBUv1W4eUR4VF3mj+rODtmF7iiwkk
DBcYV3ppUjopSLSr6eQb68TQRvTDj9QR24GOPZOVKO9ozXqnOjzGfQqxBInZN3z7
31vyubSNkWvBeTnFN2TGuv96h5PJiTBWa59djLE0N0ArQab9U8s=
=2BGP
-----END PGP SIGNATURE-----

--xMZyrpipTA2KqjcA3SYYgxjli9C4GwRh9--
