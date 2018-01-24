From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 05/22] s390/mm: hugetlb pages within a gmap can not
 be freed
Date: Wed, 24 Jan 2018 14:56:28 +0100
Message-ID: <531908d9-fc7e-c120-46e3-423b2bbb4cf7@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-6-git-send-email-frankja@linux.vnet.ibm.com>
 <07d8227f-ec52-f282-6ecf-d0880f3b74d8@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j5hRJ8qhRCEf8vDMqpZR6yKFtFWma5qa6"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <07d8227f-ec52-f282-6ecf-d0880f3b74d8@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5hRJ8qhRCEf8vDMqpZR6yKFtFWma5qa6
Content-Type: multipart/mixed; boundary="RYgvuiAx9diUvidMhvaa7lktVXamSnhOL";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <531908d9-fc7e-c120-46e3-423b2bbb4cf7@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 05/22] s390/mm: hugetlb pages within a gmap can not
 be freed
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-6-git-send-email-frankja@linux.vnet.ibm.com>
 <07d8227f-ec52-f282-6ecf-d0880f3b74d8@redhat.com>
In-Reply-To: <07d8227f-ec52-f282-6ecf-d0880f3b74d8@redhat.com>

--RYgvuiAx9diUvidMhvaa7lktVXamSnhOL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.01.2018 14:45, David Hildenbrand wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
>> From: Dominik Dingel <dingel@linux.vnet.ibm.com>
>>
>> Guests backed by huge pages could theoretically free unused pages via
>> the diagnose 10 instruction. We currently don't allow that, so we
>> don't have to refault it once it's needed again.
>>
>> Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
>> Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> ---
>>  arch/s390/mm/gmap.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index aceaeb5..056acfc 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -695,6 +695,9 @@ void gmap_discard(struct gmap *gmap, unsigned long=
 from, unsigned long to)
>>  		vmaddr |=3D gaddr & ~PMD_MASK;
>>  		/* Find vma in the parent mm */
>>  		vma =3D find_vma(gmap->mm, vmaddr);
>> +		/* We do not discard pages that are backed by hugetlbfs */
>> +		if (vma && is_vm_hugetlb_page(vma))
>> +			continue;
>>  		size =3D min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
>>  		zap_page_range(vma, vmaddr, size);
>>  	}
>>
>=20
> This check does not care about split huge pages, correct? (because we'r=
e
> checking the VMA?)
>=20

Correct


--RYgvuiAx9diUvidMhvaa7lktVXamSnhOL--

--j5hRJ8qhRCEf8vDMqpZR6yKFtFWma5qa6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaaJCMAAoJEBcO/8Q8ZEV5lcEP/38KyzLK8qLI/qgI3DsAjlcT
h/5UrLHRgSJReLlOmm3vVPTQqSurZ7o4SLxUGyXLFFR4LXpmAKPN75P+2ZcVd9II
a2LeMKgvp9J/W1+B+nK9Z3sshVlbfns/dHi6cKSR5ed+dUu5yelnbGpB0Cz/E3S0
qrbaNaVmOxMb3EKgWLSaBRIjwrOvet2lg3fabvUvnd0H0VNU5fSDLy330JhAv/R3
6/nxHg4pwyVAYDX17n21mJSkWoYKvVJFNgb+wgQQME1MHc4RmZtZVEJz7xmidT2D
Cl7HVOJTSc4U+tzpBCRGWRBRAlSfPjbmPImplM8cvqyPUPsTO2zIsfgwCsPmUL7C
C6LftuNYxIe2aN4F3FunzE4l3+c2ydshXS6rSPYAIxOIaexvNfr9REoqCA/zVA2U
kST+WJRCJLLgx9qkJjO0aO9uAPJu8DhGP9JgLahKfYhaQtwNAOsUMhvOXxipskfS
JPB+w2einNxL72mgziUi2JR1B7O1PcOvMQxVnyhhjZ8z2dOr5sCdmYcsFyuVpy3h
ZrNQmJQxn+Z9ap2LC8/RKyE9TZrI1o7Y5piKuWkZBl2l9BAavjtliS7a9jSj2Z//
0TCaTG0ZLSm/hPeD9JFffI4SL2M/sYdbZ+/+6dO5wFTsBBI4SZysEm1bGiAHppn9
n0EVi/wXVLkJ9AfwrmYq
=JZJE
-----END PGP SIGNATURE-----

--j5hRJ8qhRCEf8vDMqpZR6yKFtFWma5qa6--
