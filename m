From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 06 Dec 2018 10:22:27 +0000
Subject: Re: [kvm-unit-tests PATCH v2 2/6] s390x: Make tests bootable from disk
Message-Id: <83294d58-d782-9d8e-4c67-bb5d5472b784@linux.ibm.com>
In-Reply-To: <d5d4481d-a781-226b-5f3d-e3a6052d9efd@redhat.com>
References: <d5d4481d-a781-226b-5f3d-e3a6052d9efd@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--nlF7pXhWkj4beqhpvXVirCSfksnUr8T6v"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nlF7pXhWkj4beqhpvXVirCSfksnUr8T6v
Content-Type: multipart/mixed; boundary="f7LT2k2KSckD2XfX1P0MZVEA6rEp5XpQa";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <83294d58-d782-9d8e-4c67-bb5d5472b784@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 2/6] s390x: Make tests bootable from
 disk
References: <20181205153918.29480-1-frankja@linux.ibm.com>
 <20181205153918.29480-3-frankja@linux.ibm.com>
 <d5d4481d-a781-226b-5f3d-e3a6052d9efd@redhat.com>
In-Reply-To: <d5d4481d-a781-226b-5f3d-e3a6052d9efd@redhat.com>

--f7LT2k2KSckD2XfX1P0MZVEA6rEp5XpQa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.12.18 10:20, David Hildenbrand wrote:
> On 05.12.18 16:39, Janosch Frank wrote:
>> Currently tests are run with the --kernel option of Qemu, which will
>> load the ELF file and jump to the start address. When booting from
>> disk, we need to specify a start address. This is done by setting the
>> initial short PSW at 0x0.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/cstart64.S | 9 ++++++++-
>>  s390x/flat.lds   | 8 +++++++-
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>> index dc7ddd6..d382497 100644
>> --- a/s390x/cstart64.S
>> +++ b/s390x/cstart64.S
>> @@ -14,9 +14,16 @@
>> =20
>>  .section .init
>> =20
>> -/* entry point - for KVM + TCG we directly start in 64 bit mode */
>> +/*
>> + * Short init between 0x10000 and 0x10480 and then jump to 0x11000.
>> + * 0x10480 - 0x11000 are written to by bootloader.
>> + *
>> + * For KVM and TCG kernel boot we are in 64 bit z/Arch mode.
>> + * When booting from disk the initial short psw is in 31 bit mode.
>> + */
>>  	.globl start
>>  start:
>> +	sam64				# Set addressing mode to 64 bit
>>  	/* setup stack */
>>  	larl	%r15, stackptr
>>  	/* setup initial PSW mask + control registers*/
>> diff --git a/s390x/flat.lds b/s390x/flat.lds
>> index b6e2172..7cfd9f9 100644
>> --- a/s390x/flat.lds
>> +++ b/s390x/flat.lds
>> @@ -1,10 +1,16 @@
>>  SECTIONS
>>  {
>> +	.lowcore : {
>> +		. =3D 0;
>=20
> Can you add a comment here describing what this is and what it does?
> (31bit PSW jumping to start to be used for booting from disk)

Sure

>=20
>> +		 LONG(0x00080000)
>> +		 LONG(0x80010000)
>> +	}
>> +	. =3D 0x10000;
>>  	.text : {
>>  		*(.init)
>>  		. =3D 0x480;
>>  		ipl_args =3D .;
>> -		. =3D 0x600;
>> +		.  =3D 0x1000;
>=20
> Can you give me a hint why that change is needed?

Martin told me that it's saver to start again at 0x11000 you never know
how long the command line will be or if someone writes other stuff in the=
re.

>=20
>>  		*(.text)
>>  		*(.text.*)
>>  	}
>>
>=20
>=20



--f7LT2k2KSckD2XfX1P0MZVEA6rEp5XpQa--

--nlF7pXhWkj4beqhpvXVirCSfksnUr8T6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcCPhjAAoJEONU5rjiOLn46bgQAIf6ZGKhy75bukfJp8mo5zrX
9S816E720zjHfx1cLI451Dgtug5dI0BMK59ErTTfxPfVZoWUeVkubLUHli8pKBvI
U54D+SleJ5vbtGodeJrztPAP3ad9NPksYDzeI9Zpemdbhm/3lQsQkFUilxemVts0
UF8D/jy76nfNtUbKgV55B4Xgb+sDwbfHVU2fz9yNgpuwgnRuK7wIYNWAVI0BCro2
U8+L9xRJNcBGpnz78BLm29rLQKh4/Iqg4FyUAX/PHiioN5G7A+wUr+CJRcL2sUeR
YT9JrwJSvYnnoY7e6yIpEbHvPiy0d9f81EDKG8SefsA+XKsY7LlC2JiXGw9vRHeR
7N3lVFHWhS/p1UqMZ4T/50aNqPZAwM2sg8YwgAmNyryse8RfotuNfA0ebqz8EtK5
d2qFUoUo3hUR777UR+UKw7IncUeGwR4qVBiO8J4/P90lREeueeFHA0jBG0fIW3bw
L91ucH3ckGpC6Lv3gMSHIjEQe/Uh5/OjsexneZGz6bIr6ffog4ZfUN8b+DDorz6e
742u1Gw7UoMdr0elwWiTgypcg6BZzFqq0+y5Z9EfpidtMfktaU98gHDXylX9YRjI
K0qm1fj1LwU9Ussrbm2qTWOKZp2/zfBqWvSJ64Yy+5ZOgobmj3EIQr8VG18ReJSb
exWtuwOgXGbHWNUIywy8
=TQBd
-----END PGP SIGNATURE-----

--nlF7pXhWkj4beqhpvXVirCSfksnUr8T6v--
