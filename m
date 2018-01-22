From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
Date: Mon, 22 Jan 2018 13:09:40 +0100
Message-ID: <e67d12fb-706a-fb01-adc3-cb02a2db8604@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <5a4805ea-7b97-60ca-a4a6-e456fe7475c6@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qok7rpjoFRDz9S5jYkRz68HsEnqfdZqfO"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5a4805ea-7b97-60ca-a4a6-e456fe7475c6@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qok7rpjoFRDz9S5jYkRz68HsEnqfdZqfO
Content-Type: multipart/mixed; boundary="wjBPeY5rb11T1GdnEsMWgKfscXYQJ94nt";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <e67d12fb-706a-fb01-adc3-cb02a2db8604@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 03/22] s390/mm: add gmap PMD invalidation
 notification
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-4-git-send-email-frankja@linux.vnet.ibm.com>
 <5a4805ea-7b97-60ca-a4a6-e456fe7475c6@redhat.com>
In-Reply-To: <5a4805ea-7b97-60ca-a4a6-e456fe7475c6@redhat.com>

--wjBPeY5rb11T1GdnEsMWgKfscXYQJ94nt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.2018 12:56, David Hildenbrand wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
>> For later migration of huge pages we want to write-protect guest
>> PMDs. While doing this, we have to make absolutely sure, that the
>> guest's lowcore is always accessible when the VCPU is running. With
>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
>> the invalidation notification bit and kicking the guest out of the SIE=

>> via a notifier function if we need to invalidate such a page.
>>
>> With PMDs we do not have PGSTEs or some other bits we could use in the=

>> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
>> time a host pmd will be invalidated, we will check if the respective
>> gmap PMD has the bit set and in that case fire up the notifier.
>>
>> In the first step we only support setting the invalidation bit, but we=

>> do not support restricting access of guest pmds. It will follow
>> shortly.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  arch/s390/include/asm/gmap.h    |  3 ++
>>  arch/s390/include/asm/pgtable.h |  7 +++-
>>  arch/s390/mm/gmap.c             | 92 ++++++++++++++++++++++++++++++++=
++++-----
>>  arch/s390/mm/pgtable.c          |  4 ++
>>  4 files changed, 94 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap=
=2Eh
>> index c1bc563..21bb658 100644
>> --- a/arch/s390/include/asm/gmap.h
>> +++ b/arch/s390/include/asm/gmap.h
>> @@ -13,6 +13,9 @@
>>  #define GMAP_NOTIFY_SHADOW	0x2
>>  #define GMAP_NOTIFY_MPROT	0x1
>> =20
>> +/* Status bits in the gmap segment entry. */
>> +#define _SEGMENT_ENTRY_GMAP_IN		0x0001	/* invalidation notify bit */
>> +
>=20
> _SEGMENT_ENTRY_READ -> 0x0001
>=20
> Is it even okay to reuse that bit?
>=20

It's in the GMAP segment entry, not in the process' segment entry.
That's why we throw away all software bits from the process entry when
linking into the gmap table.


--wjBPeY5rb11T1GdnEsMWgKfscXYQJ94nt--

--qok7rpjoFRDz9S5jYkRz68HsEnqfdZqfO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaZdSLAAoJEBcO/8Q8ZEV5TMIP/2mJbjslYAygIxRf922c/vSx
2ZXvIdv/yjxRnv2qro3Xlcrq9tyIWpaMOrFthPlGNiGESr0/Bbc4IDgBfln7Ovun
lIZdESoe7NNkxkKgbLLp/0P9kY8/MSXTnTEMkveIqbmPuI57hSWxaSzUYZq0wvbV
Eqo2VI1VzQoUtJ586AJoj0A+Pj+otc9PWDXmDrFIFnO1Ml0Kw6Kjgob5d1wwdvJG
ug4a1yNmNkhv9uNrcaZfBvElHgMuOIhXd+eDKrP001/IqOMqB785T1iwRLo1bW5G
u6m+SLV2WS/ZNl3sdeFFb3DvYZ0ancr3QS2kptXLeYCF/q5Ir0SoJD+S0fIsowvI
rb2adKU8S5x2xd46Sc7suk63gsoWhQcu7iJ7966Nj6+7DKHK70sB12K6lCw34crB
1ZFyv5bUZnUdgWrVUWDF9owVj3HiuzkRKp6X54Xm2SngFVMB7t5cQiOzZKNpawXs
ES82Mpv9NLIdNVH8fOPji26ezfNptSe4U46IPYASVfdybXbO6AVEH5jr5nu10C4Q
i84hvrzMwd9z0IIYX4uM8ybRSVixSQlZrfMo836A+I1WmLbqrOAf0zkq82nfUX46
AeTjv/TEsyj4kChfpiQzv3nRzaFoVv8BSDmvcRaVBxnYKEsrGvTH9k8/J3Q0E55E
zYGOsvgCUYVgUQCpprWC
=FvNV
-----END PGP SIGNATURE-----

--qok7rpjoFRDz9S5jYkRz68HsEnqfdZqfO--
