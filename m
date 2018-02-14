From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Wed, 14 Feb 2018 16:24:51 +0100
Message-ID: <b50dadcf-c114-7c65-e3df-373f1dd399f4@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
 <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
 <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
 <da99ceda-9ce3-e8b9-f190-83dbdfed6c68@linux.vnet.ibm.com>
 <cd3e5011-ef32-bdc8-6d22-1c128d5c6f40@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gOK9TWsyxmQJvl9a1qhWZWIGMJHhOeSjz"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <cd3e5011-ef32-bdc8-6d22-1c128d5c6f40@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gOK9TWsyxmQJvl9a1qhWZWIGMJHhOeSjz
Content-Type: multipart/mixed; boundary="68iDrqvXhzSCmlz01QBZqGZBoTuetnd1y";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <b50dadcf-c114-7c65-e3df-373f1dd399f4@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
 <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
 <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
 <da99ceda-9ce3-e8b9-f190-83dbdfed6c68@linux.vnet.ibm.com>
 <cd3e5011-ef32-bdc8-6d22-1c128d5c6f40@redhat.com>
In-Reply-To: <cd3e5011-ef32-bdc8-6d22-1c128d5c6f40@redhat.com>

--68iDrqvXhzSCmlz01QBZqGZBoTuetnd1y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.02.2018 16:15, David Hildenbrand wrote:
>>> So what can happen is (please correct me if I'm wrong)
>>>
>>> a) PMD is split. SSKE writes storage key with _PAGE_CHANGED, ends up =
in
>>> PGSTE. The real storage key doesn't match the requested storage key.
>>> b) Split PMD is replaced, triggers a removal of the split PMD ->
>>> gmap_pmd_split_free(pmdp). The requested storage key is partially los=
t
>>> (pgste removed).
>>> c) PMD is mapped in again. If the guest reads the storage key now, th=
e
>>> value is wrong.
>>
>> Yes, we loose GR and GC.
>> Is there a case when the VM is running, where this would happen?
>=20
> It should already happen when migrating storage keys. The fake PGSTE ar=
e
> not considered in get_guest_storage_key().

Yes, that should break it reliably :)

>=20
> For the other parts, the original user space PMD would have to be
> changed. A simply mprotect() should achieve that. Or dirty tracking. Bu=
t
> not sure how that applies to huge pages at all.

I've only seen that 'till now when the VM is already dead and the kernel
cleans up. Anyhow, you already proposed a solution, so there's no sense
in defending against corner cases.



--68iDrqvXhzSCmlz01QBZqGZBoTuetnd1y--

--gOK9TWsyxmQJvl9a1qhWZWIGMJHhOeSjz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahFTDAAoJEBcO/8Q8ZEV5nJcQAIJLvMd3bMS7rZDyELIf0G/I
4ZtUkrLdHZ1syQ9AH69SFc1JGb6W4DGyhTE48YGxKlmWAp4aeKIe8FpQHKhuRtGw
Nfq4459MbSEmDVUyDhqr0HQ7BYIL0y9EwrZ7kK5UGimeZypQm57P9C0UvI/f7364
ZaHVlWOI6QFeJ2tCRnOuT5zTYcCkcmgFxbtT/mriuwBTq4ykgTdjyx+0PZoYgXM1
5ZIn3O1i5p8dL+w0hk54cjquNbPlnooRQIx7q5mHmwM+iu46QeApwWrvNvfkYmkw
8/o49dd3TFIWn+rlfkTwsAX5h+EcBbWoFm3FID/bBhWJrV/F2LDXeJKXQj15hlkM
/O+9GQpdEAm1r3C+1DZQ78cpSzob251fLpZw3vEZFGn2TnyOP7WUSMK2ud9a6vXs
uUMqyVyg4RblFiZ5c6w7WSucp9SoMw9tmErHK/Clr19RSkugwzLMGSGKgcU/64YA
EXYNwL89PD1AgXTtZURc9zsSJ8Srf6SSVyInXH4rb/FJGjBWieAyyOZmTBb01t6g
qBH0GcSXuCOVup2q1V15fAV8U4oAcFNSXyqIB3jsAkM6aHPSuHKKv1WLuCSzFz/R
8IZ+g9UWLKUyrm+i8Ik/eIkXlOyUNSMhd33JCp2oQd0fLf5G/BoDoR+Wc2ibI+OD
jf3DPVeqeD9QSxOfo2w/
=uyhW
-----END PGP SIGNATURE-----

--gOK9TWsyxmQJvl9a1qhWZWIGMJHhOeSjz--
