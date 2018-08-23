From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Thu, 23 Aug 2018 10:02:35 +0200
Message-ID: <c5e8669d-3d8e-5d66-66da-b61e509b04e0@linux.ibm.com>
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-2-git-send-email-pmorel@linux.ibm.com>
 <8300634d-8500-1898-e283-175fc893054a@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="icx2f5uLm7iAFWNogypKe1vcwN65dXeM9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8300634d-8500-1898-e283-175fc893054a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--icx2f5uLm7iAFWNogypKe1vcwN65dXeM9
Content-Type: multipart/mixed; boundary="tk0BJjvMPUoCU3RaovxtZGhJDilXdoz8S";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <c5e8669d-3d8e-5d66-66da-b61e509b04e0@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: BUG correction by shadow_crycb
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-2-git-send-email-pmorel@linux.ibm.com>
 <8300634d-8500-1898-e283-175fc893054a@redhat.com>
In-Reply-To: <8300634d-8500-1898-e283-175fc893054a@redhat.com>

--tk0BJjvMPUoCU3RaovxtZGhJDilXdoz8S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.2018 18:53, David Hildenbrand wrote:
> On 22.08.2018 18:51, Pierre Morel wrote:
>> Copy the key mask to the right offset inside the shadow CRYCB
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> ---
>>  arch/s390/kvm/vsie.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index 9175518..12b9707 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page)
>>  		return set_validity_icpt(scb_s, 0x0039U);
>> =20
>>  	/* copy only the wrapping keys */
>> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
>> +	if (read_guest_real(vcpu, crycb_addr + 72,
>> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>  		return set_validity_icpt(scb_s, 0x0035U);
>> =20
>>  	scb_s->ecb3 |=3D ecb3_flags;
>>
>=20
> Please fixup the subject as requested. (were there more RB-s?)
>=20

Yes, he seems to have ignored mine...


--tk0BJjvMPUoCU3RaovxtZGhJDilXdoz8S--

--icx2f5uLm7iAFWNogypKe1vcwN65dXeM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfmojAAoJEBcO/8Q8ZEV5+WYP/Aikloh3ysiYMGvUF2jpjPrl
H3ilM4wDO1joUeR8XT7aqcmarblvjM8PtA0sfCcdhAEJHrHRJRRE/3/wywZjpC+H
ahzpQkpbUNdjQSkotN0DdS2p7nAE6aV2yRNwsu+ShUhVsduClgFYOzmzjvtywj62
WCelhBC8T95MiAAKNEuwYV1cjMkFziTb+U4zdUsBgIfyA8smg7JbD91BgFJMQ8wB
FNxIskP6wCaH1zDCmWetkVunnRdDSOwWjt41G7G6HWDvI44uAoBNinbYR7jHHAle
iKe+QQCWENrSCz70ymwRf7fxM5aIDxHv9TIqOgeNz8DXFAwrKXnJUn/XGrU7N8do
W5W/T3u4qIPCJpizufqvD8G5W4YV4JAIUbeHCQO/q/e3gcB5ESk0phPVJKK2Kdo1
uYA9n/3B3DRl/D+Ox7FA51gbvu17d+3WqR4HvKJU1fn3H0bleNGs7mhZHGJ7mNSK
OkirV8seLMKPQ9Og40rCBdOP67h3rZgfhtZ+VhiXUK1cj7uqtG3LfbhKjoOLnwfC
tvJb5sP+EjF2ozuopfG8S12+mzNqS0ORbkCEheBiY+1jmBV5neSTPYqgNJUQ2a0H
IVru6yxbI6Yg+bxEZYOcL1ShQejg/655hLbbdWDbrc9RImfJ3ml+YfILYjv6TJmy
aLZSSZvu1MoqF1QkTsxz
=bvQJ
-----END PGP SIGNATURE-----

--icx2f5uLm7iAFWNogypKe1vcwN65dXeM9--
