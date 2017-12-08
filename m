From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 19/22] s390/mm: Split huge pages if granular
 protection is needed
Date: Fri, 8 Dec 2017 08:00:01 +0100
Message-ID: <c7493542-85d6-da62-1ab8-e683e1bf3f19@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-20-git-send-email-frankja@linux.vnet.ibm.com>
 <e3030116-81cf-b419-97ab-8bd863317222@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T2tXxJRNDPnmcK0QbH1b34IfA7g5DEOCr"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <e3030116-81cf-b419-97ab-8bd863317222@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T2tXxJRNDPnmcK0QbH1b34IfA7g5DEOCr
Content-Type: multipart/mixed; boundary="G687T6ckkQM1u9F4hlnhcEBFJirh1awRw";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <c7493542-85d6-da62-1ab8-e683e1bf3f19@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 19/22] s390/mm: Split huge pages if granular
 protection is needed
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-20-git-send-email-frankja@linux.vnet.ibm.com>
 <e3030116-81cf-b419-97ab-8bd863317222@redhat.com>
In-Reply-To: <e3030116-81cf-b419-97ab-8bd863317222@redhat.com>

--G687T6ckkQM1u9F4hlnhcEBFJirh1awRw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.12.2017 17:32, David Hildenbrand wrote:
> On 06.11.2017 23:29, Janosch Frank wrote:
>> A guest can put DAT tables for a lower level guest in the same huge
>> segment as one of its prefixes. This would make it necessary for the
>> segment to be unprotected (because of the prefix) and protected
>> (because of the shadowing) at the same time. This is not possible in
>> this universe.
>>
>> Hence we split the affected huge segment, so we can protect on a
>> per-page basis. Such gmap segments are special and get a new software
>> bit, that helps us handling this edge case.
>=20
> I am thinking about another condition and am not sure yet if it is
> really a problem and already handled by this patch (if so, feel free to=

> add it to the description :) ): G2 -> G3 page table and a contained G2
> -> G3 page lying on same G1 huge page

Valid objection, but we (hopefully :) ) got you covered.

We directly split on a pmd protection with the VSIE bit and then
re-drive protection on the pte:

if (((prot !=3D PROT_WRITE) && (bits & GMAP_ENTRY_VSIE))) {
		ret =3D gmap_pmd_split(gmap, gaddr, pmdp);

The red-rive is a bit ugly because of the EFAULT, but I'm open to
suggestions.



>=20
> G1 runs G2 with huge pages.
> G2 runs G3 without huge pages,
> G1 creates shadow page tables for G3.
>=20
> G2 has no idea of huge pages, so it could happen that a
> page table from G2 -> G3 falls into the same G1 huge page as a G2->G3
> backing page.
>=20
> Now, if we're unlucky, it can happen that this page table references
> that G3 page, lying on the same G1 huge page.
>=20
> G1 will create a shadow page table, protecting access to this huge page=

> (do maintain the shadow properly).
>=20
> What will happen when G3 tries to write to this page:
>=20
> 1. Shadow page table in G1 is built, huge page is protected in g2 gmap.=

> 2. Part of that huge page is to be used in the shadow page table with
> write access. This huge page is protected but we need write access, we
> need to fixup.
> 3. Fixing up will invalidate the shadow page table.
>=20
> IOW, G3 will never make progress.
>=20
>=20



--G687T6ckkQM1u9F4hlnhcEBFJirh1awRw--

--T2tXxJRNDPnmcK0QbH1b34IfA7g5DEOCr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaKjh3AAoJEBcO/8Q8ZEV5HRwP/1+mEv+3yt9iDaLG0SJoFeHx
JMPo8DeWXHT+yoyK2GnRyhlGBKHckXJOeFm2pWgM8U1YgXPuc4k4f9UqOUG+Bru8
AA6ScqJkCTpAgqyJSyenbRC8fkxtnDe8JDVGENRgMnXw9DeEFCL+VkiIZSPeZ6pX
JInZQbtr6m2julGuN9Wk4eZVwA0LkN7PbcAfjbqrTCVQK/KCM7CuP3omdKEjZ+hN
SwqfW9nNYAaPAy/yuID5eKg5VbFoVGLZVuKe8w1HQgDI7fhF15uOiAWafmkdB6ht
JGVNXv2MjI0BEdSOalBY7nYvhZFNmFXqbYFXcLvJuTFXl9EYiBpp1gfSgtDC/xpb
4NOzPrOOewFA02fLZMzYyXf4YJCET88ikY1PhkNRGyiGIpKHgQWdHKHv+ZGDPQrX
faPgbwCUe+ln0QIkL5M/P3Un6k7mKbNMWtH0OzZqGWF26Q4umBPJS+gTgP6ZFviW
n8qWUxUqGTwCYlJi/haYfKjMxDPIM6zabgpbBpkBIvJ6KvaD5yIzR56lGn937E1k
mvJEHQ1mfrGMuvF2Pl/crl6loMi4ZnNiQ8PGBZT48fq/MemtU/cYMmjCTsmx0i73
IIKQw4ve1Nrv1D/8BmABHlbIyZpFZzHGRxbIk5kCjbEQt7h+OKn6Rwurvl47/Uqo
zJsJWx+6TljbI9EBtePg
=fgdT
-----END PGP SIGNATURE-----

--T2tXxJRNDPnmcK0QbH1b34IfA7g5DEOCr--
