From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 20/22] s390/mm: Enable gmap huge pmd support
Date: Wed, 15 Nov 2017 13:24:11 +0100
Message-ID: <634ddccc-b772-b2d4-5cfc-49e7e9d4886f@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-21-git-send-email-frankja@linux.vnet.ibm.com>
 <d4793e16-1eed-3124-0086-5d574ed7822b@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="J7HX5frLEFWKf0GoborBFbOsRmosxOBwo"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <d4793e16-1eed-3124-0086-5d574ed7822b@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J7HX5frLEFWKf0GoborBFbOsRmosxOBwo
Content-Type: multipart/mixed; boundary="2S9eBDRq2Qw7QeKn1OgPshafx8nHthqp4";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <634ddccc-b772-b2d4-5cfc-49e7e9d4886f@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 20/22] s390/mm: Enable gmap huge pmd support
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-21-git-send-email-frankja@linux.vnet.ibm.com>
 <d4793e16-1eed-3124-0086-5d574ed7822b@redhat.com>
In-Reply-To: <d4793e16-1eed-3124-0086-5d574ed7822b@redhat.com>

--2S9eBDRq2Qw7QeKn1OgPshafx8nHthqp4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.11.2017 11:08, David Hildenbrand wrote:
> On 06.11.2017 23:29, Janosch Frank wrote:
>> Now that we have everything in place, let's allow huge pmds for gmap
>> linking, effectively allowing huge pages guests.
>=20
> Can you add a comment about transparent huge pages?

Now that we have everything in place, let's allow huge (1m) pmds for
gmap linking, effectively allowing hugetlbfs backed guests. Transparent
huge pages and 2g huge pages are *not* supported through this change.

>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> ---
>>  arch/s390/mm/gmap.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 430dcd9..3cc2765 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -1,8 +1,10 @@
>>  /*
>>   *  KVM guest address space mapping code
>>   *
>> - *    Copyright IBM Corp. 2007, 2016
>> + *    Copyright IBM Corp. 2007, 2016, 2017
>>   *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
>> + *		 David Hildenbrand <david@redhat.com>
>> + *		 Janosch Frank <frankja@linux.vnet.ibm.com>
>>   */
>> =20
>>  #include <linux/kernel.h>
>> @@ -596,9 +598,6 @@ int __gmap_link(struct gmap *gmap, unsigned long g=
addr, unsigned long vmaddr)
>>  		return -EFAULT;
>>  	pmd =3D pmd_offset(pud, vmaddr);
>>  	VM_BUG_ON(pmd_none(*pmd));
>> -	/* large pmds cannot yet be handled */
>> -	if (pmd_large(*pmd))
>> -		return -EFAULT;
>>  	/* Link gmap segment table entry location to page table. */
>>  	rc =3D radix_tree_preload(GFP_KERNEL);
>>  	if (rc)
>>
>=20
>=20



--2S9eBDRq2Qw7QeKn1OgPshafx8nHthqp4--

--J7HX5frLEFWKf0GoborBFbOsRmosxOBwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaDDHrAAoJEBcO/8Q8ZEV5Jw4P/11Olw87NpHn3nfAbj7ESQgS
RYVCboPmHqdyJ4XqLEgYJuyzyqxDhNXbVt4om6SxnWSU2pn+ZAc5is2F3nawX23R
Ww85/j2pVhk+oXLfg5vjpYr9po+pQbYGxHTrDA0e2q/g1tIXAXsktJvzQThme1fv
Lw4DK/b6GbVA62lAvz6+7MX7CI4w48lHbLHklmw21Tj74UbyXyATHhP3jXyVEo1p
v8NNcIcUTpON3Qrdllo4pxbetgdg8fD7ualvW1PLoKEtc08zlKz9Phwwx2pX731q
zpYey8IRITLsnrUJTGC5o3NTik+zmRLeKMiarzmYE/+2TuaTqhID3ovCDdX3ULtu
+SwJwXrPjl7M3peZ/7V2ob5e+JG3NPGkAQGtCgMz3HjrCjOaTck9VnLJWLDMvbXP
eXNPwNeomW1gEx4AFkbOt9X/2Ai5mE61mgqz4bIpRFNcBE+g3gZBw2/8H5owrtLf
4/IwbiqCqbk/pha7unwtzmlp7OqcgJz2MQtmAeUOrGcJzJrK9rOtBPBFKk4aOUlK
lnAS89Uf/nyAFnmI0NcrTRYJrtgtPDlzhh6+6L9p/AxKH5J0pPHjPAEdbOeUK6d7
fmy5IaTxx+Y8P6ztXjhPTIASm4H54lqfNK/ALzLN+Y1oVekKggS8Fm+ggiflwpiq
6wYqkYMIBjriBzXMaPfK
=AQit
-----END PGP SIGNATURE-----

--J7HX5frLEFWKf0GoborBFbOsRmosxOBwo--
