Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55023 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728294AbgG0Miw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Jul 2020 08:38:52 -0400
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200727095415.494318-1-frankja@linux.ibm.com>
 <20200727095415.494318-3-frankja@linux.ibm.com>
 <b5b0f9d1-075d-edf6-8a30-39cb84f7b42c@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <25826c5e-af31-0f43-5e2b-962887c6272f@linux.ibm.com>
Date: Mon, 27 Jul 2020 14:38:44 +0200
MIME-Version: 1.0
In-Reply-To: <b5b0f9d1-075d-edf6-8a30-39cb84f7b42c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gOAZKg9Hwrvfhwwwu0mSvp8djceChNGH3"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gOAZKg9Hwrvfhwwwu0mSvp8djceChNGH3
Content-Type: multipart/mixed; boundary="t49HWrjI7tGQtGnTqjuSQG1MyQNJpag8U"

--t49HWrjI7tGQtGnTqjuSQG1MyQNJpag8U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/27/20 2:20 PM, Thomas Huth wrote:
> On 27/07/2020 11.54, Janosch Frank wrote:
>> When an exception new psw with a storage key in its mask is loaded
>> from lowcore, a specification exception is raised. This differs from
>> the behavior when trying to execute skey related instructions, which
>> will result in special operation exceptions.
>>
>> Also let's add the test unittests.cfg so it is run more often.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  s390x/skrf.c        | 80 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  4 +++
>>  2 files changed, 84 insertions(+)
>>
>> diff --git a/s390x/skrf.c b/s390x/skrf.c
>> index 9cae589..fe78711 100644
>> --- a/s390x/skrf.c
>> +++ b/s390x/skrf.c
>> @@ -11,12 +11,16 @@
>>   */
>>  #include <libcflat.h>
>>  #include <asm/asm-offsets.h>
>> +#include <asm-generic/barrier.h>
>>  #include <asm/interrupt.h>
>>  #include <asm/page.h>
>>  #include <asm/facility.h>
>>  #include <asm/mem.h>
>> +#include <asm/sigp.h>
>> +#include <smp.h>
>> =20
>>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZ=
E * 2)));
>> +static int testflag =3D 0;
>> =20
>>  static void test_facilities(void)
>>  {
>> @@ -106,6 +110,81 @@ static void test_tprot(void)
>>  	report_prefix_pop();
>>  }
>> =20
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
>> +	lc->sw_int_crs[0] =3D 0x0000000000040000;
>> +
>> +	/*
>> +	 * PGM old contains the ext new PSW, we need to clean it up,
>> +	 * so we don't get a special operation exception on the lpswe
>> +	 * of pgm old.
>> +	 */
>> +	lc->pgm_old_psw.mask =3D 0x0000000180000000UL;
>> +	lc->pgm_old_psw.addr =3D (unsigned long)wait_for_flag;
>=20
> I don't quite understand why you are using wait_for_flag here? Won't
> that function return immediately due to the set_flag(1) below? And if i=
t
> returns, where does the cpu continue to exec code in that case? Wouldn'=
t
> it be better to leave the .addr unchanged, so that the CPU returns to
> the endless loop in smp_cpu_setup_state ?

That's a valid point, will change

>=20
>  Thomas
>=20
>=20
>> +	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>> +	set_flag(1);
>> +}
>> +
>> +/* Set a key into the external new psw mask and open external call ma=
sks */
>> +static void ecall_setup(void)
>> +{
>> +	struct lowcore *lc =3D (void *)0x0;
>> +	uint64_t mask;
>> +
>> +	register_pgm_int_func(ecall_cleanup);
>> +	expect_pgm_int();
>> +	/* Put a skey into the ext new psw */
>> +	lc->ext_new_psw.mask =3D 0x00F0000180000000UL;
>> +	/* Open up ext masks */
>> +	ctl_set_bit(0, 13);
>> +	mask =3D extract_psw_mask();
>> +	mask |=3D PSW_MASK_EXT;
>> +	load_psw_mask(mask);
>> +	/* Tell cpu 0 that we're ready */
>> +	set_flag(1);
>> +}
>> +
>> +static void test_exception_ext_new(void)
>> +{
>> +	struct psw psw =3D {
>> +		.mask =3D extract_psw_mask(),
>> +		.addr =3D (unsigned long)ecall_setup
>> +	};
>> +
>> +	report_prefix_push("exception external new");
>> +	if (smp_query_num_cpus() < 2) {
>> +		report_skip("Need second cpu for exception external new test.");
>> +		report_prefix_pop();
>> +		return;
>> +	}
>> +
>> +	smp_cpu_setup(1, psw);
>> +	wait_for_flag();
>> +	set_flag(0);
>> +
>> +	sigp(1, SIGP_EXTERNAL_CALL, 0, NULL);
>> +	wait_for_flag();
>> +	smp_cpu_stop(1);
>> +	report_prefix_pop();
>> +}
>> +
>>  int main(void)
>>  {
>>  	report_prefix_push("skrf");
>> @@ -121,6 +200,7 @@ int main(void)
>>  	test_mvcos();
>>  	test_spka();
>>  	test_tprot();
>> +	test_exception_ext_new();
>> =20
>>  done:
>>  	report_prefix_pop();
>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>> index 0f156af..b35269b 100644
>> --- a/s390x/unittests.cfg
>> +++ b/s390x/unittests.cfg
>> @@ -88,3 +88,7 @@ extra_params =3D -m 3G
>>  [css]
>>  file =3D css.elf
>>  extra_params =3D -device virtio-net-ccw
>> +
>> +[skrf]
>> +file =3D skrf.elf
>> +smp =3D 2
>>
>=20



--t49HWrjI7tGQtGnTqjuSQG1MyQNJpag8U--

--gOAZKg9Hwrvfhwwwu0mSvp8djceChNGH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8eytQACgkQ41TmuOI4
ufjEQBAAmTHOeK2leMi2Tcl84T48SAXBeGEssdPKqEuXc/oZEwjzSWCgt7dwEC27
f3975DUGAgaKR1C1Vaua7cQlIP7InDy4SiAaSzswjFlFNGCHAt5C1V8tytO3prs/
QWJc1uIqMyD9rthwBqHtVJ0zF/CrME2bcKjPZMLb2tNOX3l3u8/kCec/IknEELtH
s3YZEx1OHe4mk5dRz1rqQ7tg6PqeIcdhu3XizI2V2M4ulNsyvd5vJOh5SR+3PT1m
jmXEM8rlZhBp5QNs2SreEiRa3H7PsfKuEVyY0lv6HIrITE1Q8AcaJvk43YR+U4yc
NJMTSvVlAgIufCAUtw2Dp6UgdL+8CsY/892rtmloGRCvw7R4oXvEFOLQUc+hMf48
5vuzOqWgeP9rKLJKR500Zr6iFUPAnpGVGCxt04nafxeIYYljojqkI3rBJKb4R+4v
XAmwUhmpJuZVz6PURkz6hi3rGKFqRK9mHoA8jqtpdbhJUA4NW37VMvUjdcFW1eNS
clOWj4J1PbWjxtRTbcHAQKCs1/9IE1BlI3AfJJYwhgHSOotRmF7W9eM4d8JUuS/P
ICQ0VriM34tsx34v/3mrF2xV86ZoY0rPpxh0g09uhwHsZV3KuRR1xGwauf9y2VOD
6ek6LsEr107rBasnHa3FVkkfVL0PnhEC3PNq1Mtzjkb12dtl+FY=
=JbGT
-----END PGP SIGNATURE-----

--gOAZKg9Hwrvfhwwwu0mSvp8djceChNGH3--
