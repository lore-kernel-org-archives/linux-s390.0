From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Aug 2018 08:34:15 +0000
Subject: Re: [PATCH] s390/mm: Check for valid vma before zapping in gmap_discard
Message-Id: <3c682642-7e04-15bc-a6ab-f7780241eb93@linux.ibm.com>
In-Reply-To: <a25be136-b8a3-c57b-9511-212bee9bf2d6@redhat.com>
References: <a25be136-b8a3-c57b-9511-212bee9bf2d6@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--udVIMxf7gRmhoXNSRF4fEytG5mvg5rbwj"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--udVIMxf7gRmhoXNSRF4fEytG5mvg5rbwj
Content-Type: multipart/mixed; boundary="fhRVzzD67xPUFIeAndgqd93KpxM8l2IdJ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, dan.carpenter@oracle.com
Message-ID: <3c682642-7e04-15bc-a6ab-f7780241eb93@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Check for valid vma before zapping in
 gmap_discard
References: <20180816082432.78828-1-frankja@linux.ibm.com>
 <a25be136-b8a3-c57b-9511-212bee9bf2d6@redhat.com>
In-Reply-To: <a25be136-b8a3-c57b-9511-212bee9bf2d6@redhat.com>

--fhRVzzD67xPUFIeAndgqd93KpxM8l2IdJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.08.2018 10:26, David Hildenbrand wrote:
> On 16.08.2018 10:24, Janosch Frank wrote:
>> Userspace could have munmapped the area before doing unmapping from
>> the gmap. This would leave us with a valid vmaddr, but an invalid vma
>> from which we would try to zap memory.
>>
>> Let's check before using the vma.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  arch/s390/mm/gmap.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index bb44990c8212..911c7ded35f1 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -708,11 +708,13 @@ void gmap_discard(struct gmap *gmap, unsigned lo=
ng from, unsigned long to)
>>  		vmaddr |=3D gaddr & ~PMD_MASK;
>>  		/* Find vma in the parent mm */
>>  		vma =3D find_vma(gmap->mm, vmaddr);
>> +		if (!vma)
>> +			continue;
>>  		/*
>>  		 * We do not discard pages that are backed by
>>  		 * hugetlbfs, so we don't have to refault them.
>>  		 */
>> -		if (vma && is_vm_hugetlb_page(vma))
>> +		if (is_vm_hugetlb_page(vma))
>>  			continue;
>>  		size =3D min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
>>  		zap_page_range(vma, vmaddr, size);
>>
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

That was fast.
Thanks


--fhRVzzD67xPUFIeAndgqd93KpxM8l2IdJ--

--udVIMxf7gRmhoXNSRF4fEytG5mvg5rbwj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbdTcOAAoJEBcO/8Q8ZEV5P7MQALe1IY62JOfDcL4o+wogoFrW
BMj88sjltq+H4x2my3S7NIbww12twjWA+HvXY1fThVbnZBdYyjlDzPwMSwi+621P
0ICmqc3UAVu95J6YZOIyGQbiZZ7tTwY8uJZ6hS4nMsEf+qXZ0LejOfJ4lmYoaB+b
tiUj9szVqhW5RVv3lrUncDMYWZWKmvSfEd2agZ46q6yRMDh9nFKr4nSfqIJrwjx3
ULdr5YKwhyOAydl7SGHy1aQCs0/EgYnR4bYiwegewWBSim2va7fvA+LoLGNki6kL
t56IT0N+qDV05OnzAmx86tRfT8qHugcdwPxIj0axsfjk/jLRG3m6x8AQ8N1JpyZo
VVnObnaxIbQV+5TFKjaPXOCpyDZLfvTf4VmE01JC33P5hwOiEAROj1dBmHeWyIwo
KJX3MjbfbT8zDG1RROzO1Uxub56eSxUfKdANI1U8e1oN7MhNV3CmWPi5xIuK8634
CUyEvOQa6BTBF+RWr8TsYekooLO6erhM2A4n1oX25viG09OzigsZ6Ikos11kORWN
HyY/CTUvmxVB275mMaLkLTUSfRHPhjfH7rIIumnL0hKq7dW1vabAr0Gy4qIZ2/Gy
pd9Mz0h0wveJCdlGjIZZ9O2CWFOHWSXGzpUHlZ45OE5WDqq9ur+h8jVfHkkjx5v9
6YAGOPzUKfk1KPv7Vuzh
=brVg
-----END PGP SIGNATURE-----

--udVIMxf7gRmhoXNSRF4fEytG5mvg5rbwj--
