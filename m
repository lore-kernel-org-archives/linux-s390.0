From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Tue, 13 Feb 2018 16:33:03 +0100
Message-ID: <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V3Cblh4lRIEiLmf3hRuSDcB71DT50l57v"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V3Cblh4lRIEiLmf3hRuSDcB71DT50l57v
Content-Type: multipart/mixed; boundary="ASilzInWRXCFKLuAN0na4rxFuqYjzwXmn";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
In-Reply-To: <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>

--ASilzInWRXCFKLuAN0na4rxFuqYjzwXmn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.02.2018 15:59, David Hildenbrand wrote:
> On 13.02.2018 15:54, Janosch Frank wrote:
>> On 13.02.2018 15:36, David Hildenbrand wrote:
>>> On 09.02.2018 10:34, Janosch Frank wrote:
>>>> For later migration of huge pages we want to write-protect guest
>>>> PMDs. While doing this, we have to make absolutely sure, that the
>>>> guest's lowcore is always accessible when the VCPU is running. With
>>>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with=

>>>> the invalidation notification bit and kicking the guest out of the S=
IE
>>>> via a notifier function if we need to invalidate such a page.
>>>>
>>>> With PMDs we do not have PGSTEs or some other bits we could use in t=
he
>>>> host PMD. Instead we pick one of the free bits in the gmap PMD. Ever=
y
>>>> time a host pmd will be invalidated, we will check if the respective=

>>>> gmap PMD has the bit set and in that case fire up the notifier.
>>>>
>>>> In the first step we only support setting the invalidation bit, but =
we
>>>> do not support restricting access of guest pmds. It will follow
>>>> shortly.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>>
>>> [...]
>>>
>>>> +
>>>> +/**
>>>> + * gmap_pmd_split - Split a huge gmap pmd and use a page table inst=
ead
>>>> + * @gmap: pointer to guest mapping meta data structure
>>>> + * @gaddr: virtual address in the guest address space
>>>> + * @pmdp: pointer to the pmd that will be split
>>>> + *
>>>> + * When splitting gmap pmds, we have to make the resulting page tab=
le
>>>> + * look like it's a normal one to be able to use the common pte
>>>> + * handling functions. Also we need to track these new tables as th=
ey
>>>> + * aren't tracked anywhere else.
>>>> + */
>>>> +static int gmap_pmd_split(struct gmap *gmap, unsigned long gaddr, p=
md_t *pmdp)
>>>> +{
>>>> +	unsigned long *table;
>>>> +	struct page *page;
>>>> +	pmd_t new;
>>>> +	int i;
>>>> +
>>>
>>> That's interesting, because the SIE can now suddenly work on these
>>> PGSTEs, e.g. not leading to intercepts on certain events (like settin=
g
>>> storage keys).
>>>
>>> How is that intended to be handled? I assume we would somehow have to=

>>> forbid the SIE from making use of the PGSTE. But that involves cleari=
ng
>>> certain interception controls, which might be problematic.
>>
>> Well, cmma is disabled and storage keys should only be a problem, when=

>> the pte is invalid without the pgste lock, which should never be the
>> case for split pmds.
>>
>=20
> Are you sure? Because the SIE would suddenly stark working on guest
> storage keys stored in the PGSTE if I am not mistaking? So I would
> assume that there would have to be some kind of a sync.
>=20
> But I don't have any documentation at hand, so i can't tell :)
>=20

The pgste lock is that sync and as the gmap is the only way to get to
the pte, we don't have any ptes invalid without the lock. Also
set_guest_storage_keys will find a (userspace) pmd and do a hardware
sske, like it is supposed to.




--ASilzInWRXCFKLuAN0na4rxFuqYjzwXmn--

--V3Cblh4lRIEiLmf3hRuSDcB71DT50l57v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJagwUvAAoJEBcO/8Q8ZEV56pQQALpuz51sz3yLewx83SV36VOO
X9FJJqEaAhyBQU65rXMMZ0h9RMFNOqLLAOia8UWKov5wa+ZsT45R7rLywbfw36hs
NSWLEtwvSzH7qg1dhirFax6LTLfSnfagvndVN/Hq3SJy2QSAPMyctWwG6T3E2/mq
nt4BQKX/ri4LmzGO6QwiZFBJiFuV/5M/zW4zFvMJJhd44L+VcBLa5aW5rV43a6tk
NHmWSwlotocM0Ug/fT9dRoNKHf/D+UrOQwGnAf35VkuL5cLRVYhSjjQ2xHYvBV3h
MToBgT+DJtiT2DH6vZeB/B8PG0E71obqEoEO2XPjVD2BvXD+IxEvir/G9li35CbB
h36MlRK4HvJ3u+160akbNTlzzjz1hjgfni0qiWzuo2ZzLpCPPZgXPkPZ3vqC/lPA
C7APX3jn5hlTEHCFsP6Mg8hoKTQ6Yjue45zeu+SvuEMlgmGRslBdiBc5oiH1K30c
Q/xIoh+Y1lk4jAdP9760cG4gLBkY5P5pzu7y3kQAq8YSGrUeWt1fGDO0Cq10iioC
BZZjdsDVNI+9ICr6nd6cxkt0W4eg2+yYjnypLBGxjEUu8nQepZ5k9rF1oiQayOKC
0H2MI9EwHpp8aUBruR5jvlqxLTtoaq25w5fgUCw+ToMgDXtIrEuC0x1NoaDJTWlU
GzHIfmKvupWYwODQzYpz
=hVPz
-----END PGP SIGNATURE-----

--V3Cblh4lRIEiLmf3hRuSDcB71DT50l57v--
