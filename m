From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 28 Feb 2019 12:42:17 +0000
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: Beautify pfmf report strings
Message-Id: <fa8f8c54-d8ab-d66b-ef29-98335e338105@linux.ibm.com>
In-Reply-To: <26e38770-0dbc-b248-db47-9ac95cfd4a6e@redhat.com>
References: <26e38770-0dbc-b248-db47-9ac95cfd4a6e@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--EcbjZff7I5WGiVcmXHTaenJWpdGX2rMJg"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EcbjZff7I5WGiVcmXHTaenJWpdGX2rMJg
Content-Type: multipart/mixed; boundary="xyB0nEoPDc7LZIKOdCdPXULhGt3sLHeJb";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <fa8f8c54-d8ab-d66b-ef29-98335e338105@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/3] s390x: Beautify pfmf report strings
References: <20190228083539.146516-1-frankja@linux.ibm.com>
 <20190228083539.146516-3-frankja@linux.ibm.com>
 <26e38770-0dbc-b248-db47-9ac95cfd4a6e@redhat.com>
In-Reply-To: <26e38770-0dbc-b248-db47-9ac95cfd4a6e@redhat.com>

--xyB0nEoPDc7LZIKOdCdPXULhGt3sLHeJb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.02.19 12:26, Thomas Huth wrote:
> On 28/02/2019 09.35, Janosch Frank wrote:
>> Use a 4k/1m prefix rather than mangling it into the report string.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/pfmf.c | 21 +++++++++++++++------
>>  1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/s390x/pfmf.c b/s390x/pfmf.c
>> index 4cc6bd1..21f4e6a 100644
>> --- a/s390x/pfmf.c
>> +++ b/s390x/pfmf.c
>> @@ -64,6 +64,7 @@ static void test_4k_key(void)
>>  	union r1 r1;
>>  	union skey skey;
>> =20
>> +	report_prefix_push("4K");
>>  	r1.val =3D 0;
>>  	r1.reg.sk =3D 1;
>>  	r1.reg.fsc =3D FSC_4K;
>> @@ -71,15 +72,18 @@ static void test_4k_key(void)
>>  	pfmf(r1.val, (unsigned long) pagebuf);
>>  	skey.val =3D get_storage_key((unsigned long) pagebuf);
>>  	skey.val &=3D SKEY_ACC | SKEY_FP;
>> -	report("set 4k", skey.val =3D=3D 0x30);
>> +	report("set storage keys", skey.val =3D=3D 0x30);
>> +	report_prefix_pop();
>>  }
>> =20
>>  static void test_1m_key(void)
>>  {
>>  	int i;
>> +	bool rp =3D true;
>>  	union r1 r1;
>>  	union skey skey;
>> =20
>> +	report_prefix_push("1M");
>>  	r1.val =3D 0;
>>  	r1.reg.sk =3D 1;
>>  	r1.reg.fsc =3D FSC_1M;
>> @@ -89,11 +93,12 @@ static void test_1m_key(void)
>>  		skey.val =3D get_storage_key((unsigned long) pagebuf + i * PAGE_SIZ=
E);
>>  		skey.val &=3D SKEY_ACC | SKEY_FP;
>>  		if (skey.val !=3D 0x30) {
>> -			report("set 1M", false);
>> -			return;
>> +			rp =3D false;
>> +			break;
>>  		}
>>  	}
>> -	report("set 1M", true);
>> +	report("set storage keys", rp);
>> +	report_prefix_pop();
>>  }
>> =20
>>  static void test_4k_clear(void)
>> @@ -104,9 +109,11 @@ static void test_4k_clear(void)
>>  	r1.reg.cf =3D 1;
>>  	r1.reg.fsc =3D FSC_4K;
>> =20
>> +	report_prefix_push("4K");
>>  	memset(pagebuf, 42, PAGE_SIZE);
>>  	pfmf(r1.val, (unsigned long) pagebuf);
>> -	report("clear 4k", !memcmp(pagebuf, pagebuf + PAGE_SIZE, PAGE_SIZE))=
;
>> +	report("clear memory", !memcmp(pagebuf, pagebuf + PAGE_SIZE, PAGE_SI=
ZE));
>> +	report_prefix_pop();
>>  }
>> =20
>>  static void test_1m_clear(void)
>> @@ -119,11 +126,13 @@ static void test_1m_clear(void)
>>  	r1.reg.cf =3D 1;
>>  	r1.reg.fsc =3D FSC_1M;
>> =20
>> +	report_prefix_push("1M");
>>  	memset(pagebuf, 42, PAGE_SIZE * 256);
>>  	pfmf(r1.val, (unsigned long) pagebuf);
>>  	for (i =3D 0; i < PAGE_SIZE * 256; i++)
>>  		sum |=3D pagebuf[i];
>>  	report("clear 1m", !sum);
>=20
> I'd suggest to replace "clear 1m" with "clear memory" here now, like yo=
u
> did in the 4k function.
> If you agree, I can also do that when picking up the patch, no need to
> respin just because of this.
>=20
>  Thomas

Sure, go ahead
>=20



--xyB0nEoPDc7LZIKOdCdPXULhGt3sLHeJb--

--EcbjZff7I5WGiVcmXHTaenJWpdGX2rMJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcd9cqAAoJEONU5rjiOLn4/KMP/A83sK68q3GMmofUKFL7lEFE
IOCUwws96YutFEHOJ2FoO3lZOC0ND3eQQjXEQ88Sp5Q507ol7pSi6oDoPRAlA44l
SkW+PIrgKJLOdYiTC5TwSv9/0DTwp1NsVljG5l1bdbERSQustdAUA0Jnj/9bL88r
GT8Rcd0jN74gbg02sBZ+9KkihcWcyJJ9j/9AnQIYHJMP6WdeTHFtuQFbOsVGoW5c
8lXJdAJUdJK8/FQbQS+IuIspcZD8XDA7+cgkaXHGsdkDnW7bXXgXM69BYytTTU3p
4HZ3BtB8gX3StjwPoluZMWpweh20u7j6RlhyG44w6e5cH/XjADJIAJA/pJgqLg5t
MQ+DmigPNQ3FeobcuWTZeHMTpO5QUQjqw3bQxYQJQj6WQrWz71oTYFbV0L+e2nXv
JCjbQl4kK7PUDiL6Ulu2mkOMKDOBMGkxkWFgTaEd2QsF0C+j3BU6BxuOjRR3siZC
R2KSR66d9oNcvYY2BKGFDj6N0llMrL55bzMXQFpY9GqLY8RBWCpTO9CPBz2NQ5CP
6fRaK6Fz+peYu36RZfh4eW7lzyXVh1Dr92JNzZQejGlyeXLLIug9wUsl7xGt83kg
hdhjjnI8TVFFHjoB+ZvWUogxrnoOYnMtLWq/sBxVGSX7ucCcBcfNqgS7T6TR1MBX
A3TmEa3R9dj5IAapDCF1
=p7oE
-----END PGP SIGNATURE-----

--EcbjZff7I5WGiVcmXHTaenJWpdGX2rMJg--
