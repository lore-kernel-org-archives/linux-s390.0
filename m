From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Thu, 23 Aug 2018 13:33:50 +0200
Message-ID: <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4MAqB4dxe1Spjn5UhYyX85elQCGUgA7aO"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4MAqB4dxe1Spjn5UhYyX85elQCGUgA7aO
Content-Type: multipart/mixed; boundary="cIYfBJInpBEcmqcR3KweZUG3Yyzk7rYKp";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
In-Reply-To: <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>

--cIYfBJInpBEcmqcR3KweZUG3Yyzk7rYKp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 1:21 PM, David Hildenbrand wrote:
> On 23.08.2018 13:05, Janosch Frank wrote:
>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>> The comment preceding the shadow_crycb function is
>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>> guest.
>>
>> I beg to differ:
>>
>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>> 		return 0;
>=20
> FORMAT2 includes bit FORMAT1 (backwards compatible)

Right, this check is very misleading because of the constant, we
effectively test against Format 0 and Format 2.

Can we make this clearer by explicitly ANDing 0x01 or adding a comment?

Code makes sense:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

>=20
>>
>>>
>>> When using FORMAT2 in the host we do not need to or with
>>> FORMAT1.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>  arch/s390/kvm/vsie.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 38ea5da..e0e6fbf 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu=
, struct vsie_page *vsie_page)
>>>   * Create a shadow copy of the crycb block and setup key wrapping, i=
f
>>>   * requested for guest 3 and enabled for guest 2.
>>>   *
>>> - * We only accept format-1 (no AP in g2), but convert it into format=
-2
>>> + * We accept format-1 or format-2, but we treat it as a format-1 (no=
 AP in g2),
>>> + * and we convert it into format-2 in the shadow CRYCB.
>>>   * There is nothing to do for format-0.
>>>   *
>>>   * Returns: - 0 if shadowed or nothing to do
>>> @@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
>>>  		return set_validity_icpt(scb_s, 0x0035U);
>>> =20
>>>  	scb_s->ecb3 |=3D ecb3_flags;
>>> -	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT=
1 |
>>> -			CRYCB_FORMAT2;
>>> +	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT=
2;
>>
>> That's purely cosmetic but valid.
>>
>>> =20
>>>  	/* xor both blocks in one run */
>>>  	b1 =3D (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20



--cIYfBJInpBEcmqcR3KweZUG3Yyzk7rYKp--

--4MAqB4dxe1Spjn5UhYyX85elQCGUgA7aO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfpueAAoJEBcO/8Q8ZEV5BKcP/0YYXNq7RmLfyLaoUDEub/Im
ERPEfp/VhwLfRfk6VzYxtqlqoqWvQNccgymf1B0ZA6tNyy98Iu7gMU2TdN0mh0W+
XLCQmuoAvnZwvesxtCrYPmD3tbVCbexavTaV6IAxBqResQUNmIjdBTqrXqSqs6O1
7VYl9InnQd8+5zqxXbws0uYge+AaOh98qxPW6IgvjoVFFnMhQjNvz+XTBKSHkvcL
uTAWGyeiA9Oy2EWDYg0E6iaymVL0NtOvboFgwhmWzWs/fpZ1rc3KktAvUjZpxs3C
JHnXG87cO46Ux1NUDImb4Kw3AaPaM2LXGtk3292ohNTgH/1NPxQ5aQD4mfg2jhj3
5Mxe6c3GnVHPtObdvtPuLtKK/JWEIsMVhXCt1bRHD1dRj/WUaBlPY74+OvsVhLBD
MKvSQtT3OQy+XszOQTDOq/aTCcUzu6mgWDQ/0mkEJp0OrOOz58v70atYB95Muq5K
XrcQHiT5RdV8arnqgv5dI7yhaVPnREC2+WLvdWYhIDl8nUph3wlivS7UnQl+2R16
Sj3/eR3plYDu4NUFcXzLSStCksHdfxYD+dLYcSLiYbqo6vJ0JGGRkg3T10tIB5yB
BxOvMlD1OOeeJSJt1KazFfgBkmqdfSINJJLre4I2Kah2Vcyq7t+uXFAZbgZBxLzE
V0SGSkIcAuex9gH2RDVi
=nXQz
-----END PGP SIGNATURE-----

--4MAqB4dxe1Spjn5UhYyX85elQCGUgA7aO--
