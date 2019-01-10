From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 10 Jan 2019 12:19:54 +0000
Subject: Re: [kvm-unit-tests PATCH] s390x: Initialize the physical allocator on mem init
Message-Id: <4982035d-79f8-87a8-7e0a-16a723b6f8ba@linux.ibm.com>
In-Reply-To: <4c40bb1d-7311-6e58-477e-2df3ce97cd03@redhat.com>
References: <4c40bb1d-7311-6e58-477e-2df3ce97cd03@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--9E2b638198oW6pE5cesTJaZ9avOFVKzic"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9E2b638198oW6pE5cesTJaZ9avOFVKzic
Content-Type: multipart/mixed; boundary="vSo1VGj4JiBefk7qs9sT7b1BXEUmEYHtw";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <4982035d-79f8-87a8-7e0a-16a723b6f8ba@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Initialize the physical allocator
 on mem init
References: <20190110103424.166061-1-frankja@linux.ibm.com>
 <4c40bb1d-7311-6e58-477e-2df3ce97cd03@redhat.com>
In-Reply-To: <4c40bb1d-7311-6e58-477e-2df3ce97cd03@redhat.com>

--vSo1VGj4JiBefk7qs9sT7b1BXEUmEYHtw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.01.19 13:10, David Hildenbrand wrote:
> On 10.01.19 11:34, Janosch Frank wrote:
>> The physical and virtual allocators can coexist, so we can initialize
>> the former and allocate pages without breaking VM alloc.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/sclp.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>> index e14f25d..52be655 100644
>> --- a/lib/s390x/sclp.c
>> +++ b/lib/s390x/sclp.c
>> @@ -18,6 +18,7 @@
>>  #include <asm/spinlock.h>
>>  #include "sclp.h"
>>  #include <alloc_phys.h>
>> +#include <alloc_page.h>
>> =20
>>  extern unsigned long stacktop;
>> =20
>> @@ -31,9 +32,17 @@ static struct spinlock sclp_lock;
>> =20
>>  static void mem_init(phys_addr_t mem_end)
>>  {
>> +	phys_addr_t base, top;
>=20
> nit: move this one line down

Will do

>=20
>>  	phys_addr_t freemem_start =3D (phys_addr_t)&stacktop;
>> =20
>>  	phys_alloc_init(freemem_start, mem_end - freemem_start);
>> +	phys_alloc_get_unused(&base, &top);
>> +	base =3D (base + PAGE_SIZE - 1) & -PAGE_SIZE;
>> +	top =3D top & -PAGE_SIZE;
>> +
>> +	/* Make the pages available to the physical allocator */
>> +	free_pages((void *)(unsigned long)base, top - base);
>> +	page_alloc_ops_enable();
>>  }
>> =20
>>  static void sclp_setup_int(void)
>>
>=20
> This does not apply upstream. (sclp_setup_int) I guess this is based on=

> your other series.

Yup
I'll add it to the series.

>=20
> Tests still run fine
>=20
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks

>=20



--vSo1VGj4JiBefk7qs9sT7b1BXEUmEYHtw--

--9E2b638198oW6pE5cesTJaZ9avOFVKzic
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcNzhqAAoJEONU5rjiOLn4JQIP/A+MF0wIV1tNCZpHvW4LfbZp
iVO25c/AZ6pOLSPAtKSXDdpTF8B6NXq0KH7zI+TBjsC4z0C3Nwh3PE3nZy11eIxL
vC8Un0wTjDFXKry/O2d+n00gfcxXdsYdsTNenEpSsM2FhRMRo66xdwx3giIKCWsF
GlPaYGZ17UEBbz73gP6ElFfxC3nhl0qqRFqHZTtvCd4MK45HThY/VD/9KFrM0lVM
lT2c1yFeL4tpdvrMvk4HvBs1j3lB1tGNYbvblZdDJXRNsLu/kFIkw9E1AJxJjdN0
vHszP0Gb9gS4eUwtYe8sMLTQyqvhUAVDWKr8JbtVjZZDbLbV/zId6KTwzY/9lduS
lZgIEdBecJ5DvvPVXnTvLxXD2OxY27OKDJCXSjfyjkLHr6gVfIyAdsnDY/Hx986v
MGLdBMnveeuVeoULw9k7bzkPexRGkKnI2RwumJLJxJDNCwDFvGFDzTtd6jQjuyYn
dwKI3KhGHlk121HavykOlynlvY4Rtdwemi0ty5FhJsQ6XkkMEkhFLYAWLVsfzIPu
ITZJVHYXsKhaqbn8mmOP7LdZvImDm2ZwGdI2GUP1Ei4NdI/rg8oKOU79CVPaGnsK
2VkhEkSAwXozswVmkSwJ6l1kSIgbCbawCaOxN004fPnht6O7nB1ISCirtDp8Pv3/
S/9gi6u9uXKMzrNBFzfD
=omk0
-----END PGP SIGNATURE-----

--9E2b638198oW6pE5cesTJaZ9avOFVKzic--
