From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 01/22] s390/mm: make gmap_protect_range more
 modular
Date: Mon, 22 Jan 2018 14:02:48 +0100
Message-ID: <f52b5163-3286-1358-098a-183eeb5a0f15@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-2-git-send-email-frankja@linux.vnet.ibm.com>
 <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>
 <2a4094a9-aee5-adad-f543-3bfe1ca9d440@linux.vnet.ibm.com>
 <66bd80bc-841a-39f2-9e51-6961e2da1330@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qkf0s3Q8MeCvXXVv3TBgwPrBdZnjvyw9V"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <66bd80bc-841a-39f2-9e51-6961e2da1330@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qkf0s3Q8MeCvXXVv3TBgwPrBdZnjvyw9V
Content-Type: multipart/mixed; boundary="A69RiptiVeh6y12ifqi4fszd3MV6GHR36";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <f52b5163-3286-1358-098a-183eeb5a0f15@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 01/22] s390/mm: make gmap_protect_range more
 modular
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-2-git-send-email-frankja@linux.vnet.ibm.com>
 <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>
 <2a4094a9-aee5-adad-f543-3bfe1ca9d440@linux.vnet.ibm.com>
 <66bd80bc-841a-39f2-9e51-6961e2da1330@redhat.com>
In-Reply-To: <66bd80bc-841a-39f2-9e51-6961e2da1330@redhat.com>

--A69RiptiVeh6y12ifqi4fszd3MV6GHR36
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.2018 13:50, David Hildenbrand wrote:
>=20
>>>
>>>> +	if (!pmdp || pmd_none(*pmdp)) {
>>>> +		spin_unlock(&gmap->guest_table_lock);
>>>> +		return NULL;
>>>> +	}
>>>> +	/*
>>>> +	 * For plain 4k guests that do not run under the vsie it
>>>> +	 * suffices to take the pte lock later on. Thus we can unlock
>>>> +	 * the guest_table_lock here.
>>>> +	 */
>>>
>>> As discussed, the gmap_is_shadow() check is not needed. The comment
>>> should be something like
>>
>> IFF we'll never use this function to walk shadow tables, then you are
>> right. We can make it a policy and throw in a BUG_ON.
>=20
> Right. We never protect anything on a shadow gmap. We only mirror the
> access tights requested by the guest (which are then valid in the host)=
=2E

For now I'll introduce a comment, a BUG_ON and get rid of the check.

>=20
>>
>> [...]
>>>> +static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,=

>>>> +			    pmd_t *pmdp, int prot, unsigned long bits)
>>>> +{
>>>> +	int rc;
>>>> +	pte_t *ptep;
>>>> +	spinlock_t *ptl =3D NULL;
>>>> +
>>>> +	/* We have no upper segment, let's go back and fix this up. */
>>>> +	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
>>>> +		return -EAGAIN;
>>>
>>> This is essentially pmd_none(*pmdp), which you already verified in
>>> gmap_pmd_op_walk().
>>
>> Well, not really pmd_none is entry =3D=3D ENTRY_EMPTY (only I bit set)=
 not
>> entry & I.
>> Is there a path where we have an I bit on a pmd entry which has a vali=
d pto?
>>
>=20
> Thing idte only sets the invalid bit. But can this check than go into
> gmap_pmd_op_walk? (replacing pmd_none() ?)

I'll have to think about that, but quite possibly yes.
The problem comes from Martin's wish to properly handle prot_none entries=
=2E




--A69RiptiVeh6y12ifqi4fszd3MV6GHR36--

--qkf0s3Q8MeCvXXVv3TBgwPrBdZnjvyw9V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaZeD4AAoJEBcO/8Q8ZEV5hg0P/1XdPOgFfH0IRhU+OBC988/B
Afrz2dHqMbXiM1mV7IerEGWB2ZRuWpVjK+JiQUDXQwyJaut8b35JZTDClbrtiruj
hOw0DSRK5uKSmFjMZ+Gdgz8uj4Fh5VQGaenVQzRrv28f+uvLHdt1OyN/TVQn9v4c
lurKAQk3EPgLJHxwMRuhHXq39YIoCXV0gwftSu5MamYI5zudnSKO2PEOmdNWrvd8
iDbKAW3OIFTcYy3gYNG01/sT3Gg8hozD41A39ihaMeRdCCILvBE8fFGMlrDiMM5M
xOhov1RunS4JNJACzDs6Rs8iZxmefjBsEY6Uqd15iuU6UjRpMSCSEY9DhtMaoKBY
2vwvw74x6vioTbzqkCL68GCHr6ZPVtuVhyDFeOgvFvLP9S4EDhU/7upJ+H7Axl7B
3A/Ynlm9+K7bD6380+FqMysPkDAjHNZvax5rSrXc7yYe7EFetj1wuTafX28mYvFF
yCv3E672nkvJISljM9Y4eoZlx5skbWncTH9+FYVRaLk5D7PnZvl1Vs0uLm+TaBmx
jbNdvQ1ZpKCy14pgcXTdCF/JDx32rQU0Oz5sOA+NsYW+4z1ApjSLevaOTkgQcOhg
7IyfclAlCJB5DIw+CK9Mu0kuoXhTpX1laaztvnMzSs5Q0fbOUZM38X0C0KC3JpBR
afg4ImgllIQck4R0WktT
=99yf
-----END PGP SIGNATURE-----

--qkf0s3Q8MeCvXXVv3TBgwPrBdZnjvyw9V--
