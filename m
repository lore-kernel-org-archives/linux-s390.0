Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15418 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbgGWMX4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jul 2020 08:23:56 -0400
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Add custom pgm cleanup function
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-2-frankja@linux.ibm.com>
 <20200723140112.6525ddba.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <8a7c9e38-8d92-0353-b883-368c2dcdec04@linux.ibm.com>
Date: Thu, 23 Jul 2020 14:23:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200723140112.6525ddba.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HahkwqycjwN8Ar8ZBVPAAf2ELi3zUYIBA"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HahkwqycjwN8Ar8ZBVPAAf2ELi3zUYIBA
Content-Type: multipart/mixed; boundary="BnezAcZawUheR1KIft8DXVrTK6A3niqU4"

--BnezAcZawUheR1KIft8DXVrTK6A3niqU4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/23/20 2:01 PM, Cornelia Huck wrote:
> On Fri, 17 Jul 2020 10:58:11 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Sometimes we need to do cleanup which we don't necessarily want to add=

>> to interrupt.c, so lets add a way to register a cleanup function.
>=20
> s/lets/let's/ :)
>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/asm/interrupt.h | 1 +
>>  lib/s390x/interrupt.c     | 9 +++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
>> index 4cfade9..b2a7c83 100644
>> --- a/lib/s390x/asm/interrupt.h
>> +++ b/lib/s390x/asm/interrupt.h
>> @@ -15,6 +15,7 @@
>>  #define EXT_IRQ_EXTERNAL_CALL	0x1202
>>  #define EXT_IRQ_SERVICE_SIG	0x2401
>> =20
>> +void register_pgm_int_func(void (*f)(void));
>>  void handle_pgm_int(void);
>>  void handle_ext_int(void);
>>  void handle_mcck_int(void);
>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>> index 243b9c2..36ba720 100644
>> --- a/lib/s390x/interrupt.c
>> +++ b/lib/s390x/interrupt.c
>> @@ -16,6 +16,7 @@
>> =20
>>  static bool pgm_int_expected;
>>  static bool ext_int_expected;
>> +static void (*pgm_int_func)(void);
>>  static struct lowcore *lc;
>> =20
>>  void expect_pgm_int(void)
>> @@ -51,8 +52,16 @@ void check_pgm_int_code(uint16_t code)
>>  	       lc->pgm_int_code);
>>  }
>> =20
>> +void register_pgm_int_func(void (*f)(void))
>> +{
>> +	pgm_int_func =3D f;
>> +}
>> +
>>  static void fixup_pgm_int(void)
>>  {
>> +	if (pgm_int_func)
>> +		return (*pgm_int_func)();
>> +
>=20
> Maybe rather call this function, if set, instead of fixup_pgm_int() in
> handle_pgm_int()? Feels a bit cleaner to me.

Well it's currently a cleanup function so it should be in
fixup_pgm_int() because it fixes up.

I don't need a handler here like Pierre with his IO changes.

So it might more sense to change the name of the function ptr and
registration function:

register_pgm_cleanup_func()
static void (*pgm_cleanup_func)(void);

> 	=09
>>  	switch (lc->pgm_int_code) {
>>  	case PGM_INT_CODE_PRIVILEGED_OPERATION:
>>  		/* Normal operation is in supervisor state, so this exception
>=20



--BnezAcZawUheR1KIft8DXVrTK6A3niqU4--

--HahkwqycjwN8Ar8ZBVPAAf2ELi3zUYIBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8ZgVQACgkQ41TmuOI4
ufjirRAAvFdeOdRL18jIQlAnvHPn5MMxrdB1IZojjCr77KU9BW0ZOFCYdBM3toJY
fYz/i4NUcGOOG5hH5Y4YErb6JofDb4fSf+740vdvJHYyoaYL1+McuM/fDMMrhMDB
yiYsWdO7+xF4r3q0X7INAnyhwEcaWdhqhULTBSSMe+whgKUTz8CC6Cavuj2sYvoO
PsbHOA2krAA8HrckJbieNZ0UZ5aOU/N3uhUAYwePKZn7KCuS7Rezhpv9FvcumVTo
B5glnQuV5dKXuR8cTxTicGZWQE441F12+hcGtRArAm+UAJVA4DYsvNfuYBzVexTa
v9zOKBdBojBu5+5tu0IgmXbBUDM6RUHknCMcFxMFILEsZmxI811m0hSkcsvPtp7v
eF3vZJ2YvOSEA1vaHEywQSf70bSxq7OvrcORoEoFGR1J3ruAB8f8JJ5yrytpBxnf
lsOndJuIGWau6kMLLuWaWwrpHoC4wk9dcrBOzGT/fh5l5EiLP437sBhyEmIDFmPY
kRqKr3otMFNKKBsXxmbJWUR9Sq7oXXAfBH7EJ9s/pgeziBPZ6Kk1yZiHkO+2eRCM
qnhgo1azNTXhKCCNflO9D6IzNJjbe0lUWEKbaAahGIiWP7OdLmgEqg/QGXVeyQYH
OdzbivggKt3iVn20r0fg/1e9fm4PFxIzziaj6ybpzXzQdDDoY68=
=Zdds
-----END PGP SIGNATURE-----

--HahkwqycjwN8Ar8ZBVPAAf2ELi3zUYIBA--
