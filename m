From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Thu, 23 Aug 2018 13:53:06 +0200
Message-ID: <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J
Content-Type: multipart/mixed; boundary="WRugImPLHTVTnw3U9ddTvarTN6D2cM2Hy";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: pmorel@linux.ibm.com, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
In-Reply-To: <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>

--WRugImPLHTVTnw3U9ddTvarTN6D2cM2Hy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 1:47 PM, Pierre Morel wrote:
> On 23/08/2018 13:33, Janosch Frank wrote:
>> On 8/23/18 1:21 PM, David Hildenbrand wrote:
>>> On 23.08.2018 13:05, Janosch Frank wrote:
>>>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>>>> The comment preceding the shadow_crycb function is
>>>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>>>> guest.
>>>>
>>>> I beg to differ:
>>>>
>>>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>>> 		return 0;
>>>
>>> FORMAT2 includes bit FORMAT1 (backwards compatible)
>>
>> Right, this check is very misleading because of the constant, we
>> effectively test against Format 0 and Format 2.
>>
>> Can we make this clearer by explicitly ANDing 0x01 or adding a comment=
?
>=20
> yes, done, I modified the comment in front of the function.

Which is not what I want, what I want is:

/* CRYCB_FORMAT2 includes the bit for CRYCB_FORMAT1, so we allow both
formats here */
if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
	return 0;

>=20
>>
>> Code makes sense:
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>=20
> Thanks,
>=20
> regards,
> Pierre
>=20
>>
>>>
>>>>
>>>>>
>>>>> When using FORMAT2 in the host we do not need to or with
>>>>> FORMAT1.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>   arch/s390/kvm/vsie.c | 6 +++---
>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>> index 38ea5da..e0e6fbf 100644
>>>>> --- a/arch/s390/kvm/vsie.c
>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>> @@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vc=
pu, struct vsie_page *vsie_page)
>>>>>    * Create a shadow copy of the crycb block and setup key wrapping=
, if
>>>>>    * requested for guest 3 and enabled for guest 2.
>>>>>    *
>>>>> - * We only accept format-1 (no AP in g2), but convert it into form=
at-2
>>>>> + * We accept format-1 or format-2, but we treat it as a format-1 (=
no AP in g2),
>>>>> + * and we convert it into format-2 in the shadow CRYCB.
>>>>>    * There is nothing to do for format-0.
>>>>>    *
>>>>>    * Returns: - 0 if shadowed or nothing to do
>>>>> @@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, =
struct vsie_page *vsie_page)
>>>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>>>  =20
>>>>>   	scb_s->ecb3 |=3D ecb3_flags;
>>>>> -	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORM=
AT1 |
>>>>> -			CRYCB_FORMAT2;
>>>>> +	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORM=
AT2;
>>>>
>>>> That's purely cosmetic but valid.
>>>>
>>>>>  =20
>>>>>   	/* xor both blocks in one run */
>>>>>   	b1 =3D (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;=

>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>
>>
>>
>=20
>=20



--WRugImPLHTVTnw3U9ddTvarTN6D2cM2Hy--

--KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfqAiAAoJEBcO/8Q8ZEV5dqMP/inmsp5Fw/ifYd22PYsX6ExS
1O/dToGFGBI/7d09hsmZi7+wWiTbNDR9sIeRFo1cXuwx15aX/XEmwPxmcRlG8xdq
J/MJinsjzGdzHvJ6lZPLQuG7So+pv2Rzf84eNjU/T2sua+OaAbt64j7KZZeW+PXP
DDz5L8Zi7BgQwBLPmsMUyUBfR8k/7wiN+bM3odgT4SQEYVW7EmZOFuzMCL8ZsGkB
WKfoUkuQVtI76I4k/tyLYHFvrya0mgely+ZnMGztEJbt9I7UHm6ztqDBdSSqIAmj
47R0QZjYQ2NMC2DIQpzCvR3TUzhwJV4pXwBlDME8okhiWpbOeeWMRLnHZF1BvOYH
hUmJI13oPQ7yXg8bCV/3wqYf3fp4ewFli7hgqrMf/9QDjtdJbeV0tpLyJScz9fAd
zAPBtJrVKLySw7J6fwK9+1nbwLBq2/gKPVsvXeuygHUjAzfYiH6tBg1byUNndRq7
x46j4EvcQB5G2hIrKykqqDfSnY+OuTzsm7Gu9OyyoQV/l3nVyCLj+fjRVbkLEIhY
y/NBC5jqnu66Kr81GXvstQ82g7JOeK+oexOkSZAPR+KJmUHYHi5jYR7puckoNbOq
DUGZlnKUbKSIT6AmSvs8+cWqM6qUCNZqwSg0C5qR+dFsZUAbyiVy8phynZSdmd1T
SDamcfcUaJ0lzVvIm5KR
=j6sh
-----END PGP SIGNATURE-----

--KQg9l9Lwy1vunDtYJCwkA03sqJcVbIv0J--
