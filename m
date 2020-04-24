Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52007 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgDXLQM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 07:16:12 -0400
Subject: Re: [PATCH v2 07/10] s390x: smp: Use full PSW to bringup new cpu
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-8-frankja@linux.ibm.com>
 <f13b31f6-80ef-9cfc-0cde-fe1c1601cf1f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <0f4ceb74-4ac4-4e26-3d2c-d8572b970cc8@linux.ibm.com>
Date: Fri, 24 Apr 2020 13:16:05 +0200
MIME-Version: 1.0
In-Reply-To: <f13b31f6-80ef-9cfc-0cde-fe1c1601cf1f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b4GM7Btv2fnXbdu4aEygDfm6FNw683Kxb"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b4GM7Btv2fnXbdu4aEygDfm6FNw683Kxb
Content-Type: multipart/mixed; boundary="oOOuGQqghUikVl8soioly845LqS0tk0mu"

--oOOuGQqghUikVl8soioly845LqS0tk0mu
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:09 PM, David Hildenbrand wrote:
> On 23.04.20 11:10, Janosch Frank wrote:
>> Up to now we ignored the psw mask and only used the psw address when
>> bringing up a new cpu. For DAT we need to also load the mask, so let's=

>> do that.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  lib/s390x/smp.c  | 2 ++
>>  s390x/cstart64.S | 3 ++-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index 3f86243..6ef0335 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -202,6 +202,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>>  	cpu->stack =3D (uint64_t *)alloc_pages(2);
>> =20
>>  	/* Start without DAT and any other mask bits. */
>> +	cpu->lowcore->sw_int_psw.mask =3D psw.mask;
>> +	cpu->lowcore->sw_int_psw.addr =3D psw.addr;
>>  	cpu->lowcore->sw_int_grs[14] =3D psw.addr;
>=20
> Do we still have to set sw_int_grs[14] ?
>=20
r14 is saved to restart_new so we don't go through setup twice.
We could instead copy cpu->lowcore->sw_int_psw.addr to restart new, but
that means more changes than the removal of one line.

Also, what about backtraces or plain old debug?
Having r14 is a good backup to have IMHO.


--oOOuGQqghUikVl8soioly845LqS0tk0mu--

--b4GM7Btv2fnXbdu4aEygDfm6FNw683Kxb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6iynUACgkQ41TmuOI4
ufgkfg//bj4Pl04OfMXjuF9ERXbP34igr3prop4a4fLtGRLlcbiPxob33QjTrrKw
taz7k99OPRoZn6TAoH6ObY26gGW8X8et5UmtXDAgmUGAB0qhOs5UI9kLdKy3l8o8
k8L4wo8m8RR4TZN5gUqzArOW1bJrzY/frMsKWn1xCf4x4qd4HCBev7u/Nsxzi4n3
6d2Rsy/TUoTIeAdXCdjX+wqOgVq32aRir7Htw/ap+9ZCFP+bzmHD+cuaUTgNZ6mY
nNWtdULs27i7T8+6BmrvNR0BsLeQMBG/NRuWr5m0iON7vgfliws5KIwtGzo8ylsM
5kk+BDXc1F0Xazvqvvw+wN2kd+5pOP8fWW5cSI59YiNFvBPl3lGRYyvU9rNgyspW
bye9HKHH6rr3Pq7Gx6tBfvWfrmV149L7IFhF/uyW/1feU1JXh7Qu/I+gqNbP+4zr
3T5SkWWVffblfZEQkH4eNULuTbafF0lXIGQCWYPkWUSwo4+lcMUcXtrSM4Q3B+/T
w7dyoCp5w/svYW6kx/tdsD311I5RmeSgQidiPHCGH1Ys0tYoBnFfh4syocz9UXHB
BKNKAM/5wQ3KmYciyJgXqvTbONxTmCbp6wVRpB+JscTUS6frhWA6/9ZONgys/xTH
VwAAIVy1frRzfJPIrpCye0YvQdPp00Wmi84gZ+sYkVkLaq1mxwE=
=gmkL
-----END PGP SIGNATURE-----

--b4GM7Btv2fnXbdu4aEygDfm6FNw683Kxb--
