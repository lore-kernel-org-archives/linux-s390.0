From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 02/22] s390/mm: Abstract gmap notify bit setting
Date: Mon, 13 Nov 2017 16:57:46 +0100
Message-ID: <84dc4936-6fe2-0636-3757-ae0e87a8938f@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-3-git-send-email-frankja@linux.vnet.ibm.com>
 <5939dc68-f6e8-54a0-a6d1-b9655de273a5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CUp3LVhmuHx5u3sds4L4EMnOeaQ7nSvjn"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5939dc68-f6e8-54a0-a6d1-b9655de273a5@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CUp3LVhmuHx5u3sds4L4EMnOeaQ7nSvjn
Content-Type: multipart/mixed; boundary="DwxBrCo1JDBQbNcUcFARHbS2QUECalpKo";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <84dc4936-6fe2-0636-3757-ae0e87a8938f@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 02/22] s390/mm: Abstract gmap notify bit setting
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-3-git-send-email-frankja@linux.vnet.ibm.com>
 <5939dc68-f6e8-54a0-a6d1-b9655de273a5@redhat.com>
In-Reply-To: <5939dc68-f6e8-54a0-a6d1-b9655de273a5@redhat.com>

--DwxBrCo1JDBQbNcUcFARHbS2QUECalpKo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.11.2017 13:57, David Hildenbrand wrote:
> On 06.11.2017 23:29, Janosch Frank wrote:
>> Currently we use the software PGSTE bits PGSTE_IN_BIT and PGSTE_VSIE_B=
IT
>> to notify before an invalidation occurs on a prefix page or a VSIE pag=
e
>> respectively. Both bits only work for a PGSTE, which only exists for
>> page tables.
>>
>> For huge page support we also need such bits for segments (pmds) so
>> let's introduce abstract GMAP_ENTRY_* bits that will be realized into
>> the respective bits when gmap DAT table entries are protected.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
[...]
>> @@ -8,6 +8,10 @@
>>  #ifndef _ASM_S390_GMAP_H
>>  #define _ASM_S390_GMAP_H
>> =20
>> +/* Generic bits for GMAP notification on DAT table entry changes. */
>> +#define GMAP_ENTRY_VSIE	0x2
>> +#define GMAP_ENTRY_IN	0x1
>=20
> Can we rename
> GMAP_ENTRY_VSIE -> GMAP_ENTRY_SHADOW_IN
>=20
> and also
>=20
> PGSTE_VSIE_BIT -> PGSTE_SHADOW_IN_BIT

I'd like to keep the PGSTE bit names, the PGSTE bits are nicely
formatted and consistent in pgtable.h. The segment bit names are even
worse because of their length:

_SEGMENT_ENTRY_GMAP_VSIE

and if we'd use your naming it gets even longer:

_SEGMENT_ENTRY_GMAP_SHADOW_IN_BIT


I'll try to come up with something consistent and good sounding, but it
certainly isn't a #1 priority and I might fail to do so :)

>=20
> as they are used for managing shadow page table invalidation.
>=20
> Also, a better fitting name for ENTRY would be nice :)
> (GMAP_NOTIFY_...)

Yes, the ENTRY part came from the _SEGMENT_ENTRY_* constants, whose
names you might also dislike.

So I think I'll use:
GMAP_NOTIFY_PREFIX(_BIT)
GMAP_NOTIFY_SHADOW(_BIT)



--DwxBrCo1JDBQbNcUcFARHbS2QUECalpKo--

--CUp3LVhmuHx5u3sds4L4EMnOeaQ7nSvjn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaCcD6AAoJEBcO/8Q8ZEV5beYP/3VLPY0mIrtcDZbukDINOBVT
gyjNXS+cW7t3DcPlpBARyCqSEwAGAkVkNw1hTeL38liEpjopBIZ4f8B7HigCYiG3
0oM/0adWRF3Adbg3nmfS4jaisLM+dGMTA6KaKuSY3Dincx7+rF+xFoNEBsiiyDMH
y+1zCgrXLpvNMWOfHWpATVnx22r3r5YdnwKWLcc/Xkcn8fHjhaWoqbzJvySayFQm
cvS4ZGEHxtHlvZtH+HshL+hn2rEP/kF0GjrNc9YrknxDC8jiTeS6eCubvXS3UDma
otO6lxOhCUwk1b1b0CUn+QjR9CWSjLra9bbFqa/iQaa84V+MCSxAZbpUqujkUo1i
/M64tQNhP+rna8nMHvRXHD8OlFSuL551qQ5Qj3mHU8BgUAuap9Xdh3yoNetXAsFd
h9h3pj0NhnooeX+LPaOSPKlRJ3elzCcvrkdvfrHFRNf6tbAsFQTrPslxZlb8U+bh
ZU1tRlTO2FNaXxYGT+F04Gg9Q/HRLqKHhUU/WqlTB6vOSYoUHAm8nlb98yn3/j4c
YUp/t7rLP5+1eiFR8ab/pMVKN6pEp2AQMBvQKYiFBWY1qRrbMBm4B6MAHn/aW7r+
JZfbMUHOwV5AT3ts/oLDWOk6MrwQKHc6ZBxUmlJrvVUbQmItNXAAaJNT+ZFvJx7K
YRx4fo8DT4gnURUKBZE2
=+bIS
-----END PGP SIGNATURE-----

--CUp3LVhmuHx5u3sds4L4EMnOeaQ7nSvjn--
