From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 25 Feb 2019 14:29:39 +0000
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Beautify pfmf report strings
Message-Id: <9ead12e4-ea17-acc2-9478-749b9018cd10@linux.ibm.com>
In-Reply-To: <3a88d97f-bf63-9014-33bd-e7c93fd21266@redhat.com>
References: <3a88d97f-bf63-9014-33bd-e7c93fd21266@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--DEN2Uli1PW7s7ua1vBwpCX6a4szu7zyKa"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DEN2Uli1PW7s7ua1vBwpCX6a4szu7zyKa
Content-Type: multipart/mixed; boundary="US4R5HdbsvE7Qsw5XTYoDz2hMSmXDEvbR";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <9ead12e4-ea17-acc2-9478-749b9018cd10@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Beautify pfmf report strings
References: <20190219084913.198737-1-frankja@linux.ibm.com>
 <20190219084913.198737-3-frankja@linux.ibm.com>
 <3a88d97f-bf63-9014-33bd-e7c93fd21266@redhat.com>
In-Reply-To: <3a88d97f-bf63-9014-33bd-e7c93fd21266@redhat.com>

--US4R5HdbsvE7Qsw5XTYoDz2hMSmXDEvbR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.02.19 13:39, Thomas Huth wrote:
> On 19/02/2019 09.49, Janosch Frank wrote:
>> Use a 4k/1m prefix rather than mangling it into the report string.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/pfmf.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/s390x/pfmf.c b/s390x/pfmf.c
>> index 4cc6bd1..340b0bd 100644
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
>> @@ -71,7 +72,8 @@ static void test_4k_key(void)
>>  	pfmf(r1.val, (unsigned long) pagebuf);
>>  	skey.val =3D get_storage_key((unsigned long) pagebuf);
>>  	skey.val &=3D SKEY_ACC | SKEY_FP;
>> -	report("set 4k", skey.val =3D=3D 0x30);
>> +	report("set storage keys", skey.val =3D=3D 0x30);
>> +	report_prefix_pop();
>>  }
>> =20
>>  static void test_1m_key(void)
>> @@ -80,6 +82,7 @@ static void test_1m_key(void)
>>  	union r1 r1;
>>  	union skey skey;
>> =20
>> +	report_prefix_push("1M");
>>  	r1.val =3D 0;
>>  	r1.reg.sk =3D 1;
>>  	r1.reg.fsc =3D FSC_1M;
>> @@ -89,11 +92,12 @@ static void test_1m_key(void)
>>  		skey.val =3D get_storage_key((unsigned long) pagebuf + i * PAGE_SIZ=
E);
>>  		skey.val &=3D SKEY_ACC | SKEY_FP;
>>  		if (skey.val !=3D 0x30) {
>> -			report("set 1M", false);
>> +			report("set storage keys", false);
>>  			return;
>=20
> I think you need a report_prefix_pop() before that return now.

I'll introduce a new bool rp =3D true, set it to false on error and break=

put of the loop.

The report will be based on rp.

>=20
>>  		}
>>  	}
>> -	report("set 1M", true);
>> +	report("set storage keys", true);
>> +	report_prefix_pop();
>>  }
>=20
>  Thomas
>=20



--US4R5HdbsvE7Qsw5XTYoDz2hMSmXDEvbR--

--DEN2Uli1PW7s7ua1vBwpCX6a4szu7zyKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcc/vTAAoJEONU5rjiOLn4WxIQAMgNe2McsuJuW1KF3zAZz4aK
2Xd2/TjP9JobjLUR9tarq4UdGvt/JgBpsudomX/tMytvDu37PvkN28+4RaPT2Do5
MjdEMteaaEPAJ/37zYUVZ5HjlH2ROnEIIzI/rQIzw1+K8lwyRYFIQvg5tpV/k5Uu
Q3Ov6isJ7Jz7OxtGzkcB6Xh756qJqZKdfv8pLxBRHlvYC3S6RTTSeo+kWrIxs9DV
L5RyIkYyhRFi7MJ7BZXZlHOwTi0dZXYIaA1YlBuNElKNwBNQW31/ullNZXoE88YZ
c00j3xQTzN1EF9NLXhULPMDo0zxYAXLqaz3gClZE2MSdg3mUGpIYYnD/2vP8ILv8
mwCge8IO+zZe+0rzgVC1+WyxQ4q6egmrSwazDJvGYZB19sAFN+BGcvGOB1h/dSvN
w3RugrW9XIJKpQZ+GKuvm47vVNc+qRrJv0/PKJlLu6QvOpPU+jJsH3Ls9nRBeQDd
y70QE4aIUEV2DgcRiiGthCjEoQ/c5BsZqp85H0SoH9M4vqirXQFzKUASVFXzdPyC
NhPjM/GYo9Eb3t+kR5qa/n7kAJ8+pxJOUGPatglWOIGcDah59uPnxwaNu33eT2mz
hXzG8MAEZ8PiDJIPd5WgM9EKhoIOzuVRl51WPKRpxg0hh/0dlTwwvnqUrRUtWpqi
6vTen1Luors4lC9E4fns
=SjD/
-----END PGP SIGNATURE-----

--DEN2Uli1PW7s7ua1vBwpCX6a4szu7zyKa--
