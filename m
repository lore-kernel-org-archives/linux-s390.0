From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] KVM: s390: diagnoses are instructions as well
Date: Wed, 24 Jan 2018 13:41:59 +0100
Message-ID: <b18db04f-86e2-8b44-844f-6fc91920bdda@linux.vnet.ibm.com>
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
 <20180124113235.31485-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UYnDAwX68A5vSuf246esPBhr5KDljA1lb"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180124113235.31485-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UYnDAwX68A5vSuf246esPBhr5KDljA1lb
Content-Type: multipart/mixed; boundary="g2pjhsjXJmPDdMsKfrI2wTyJrIUWUyPWD";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>
Message-ID: <b18db04f-86e2-8b44-844f-6fc91920bdda@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] KVM: s390: diagnoses are instructions as well
References: <20180124113235.31485-1-borntraeger@de.ibm.com>
 <20180124113235.31485-3-borntraeger@de.ibm.com>
In-Reply-To: <20180124113235.31485-3-borntraeger@de.ibm.com>

--g2pjhsjXJmPDdMsKfrI2wTyJrIUWUyPWD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.01.2018 12:32, Christian Borntraeger wrote:
> make the diagnose counters also appear as instruction counters.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

I always liked having them in an own category, as they are somewhat
special, but the instruction prefix only makes them slightly harder to
find, so I'm fine with it. :)

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

> ---
>  arch/s390/kvm/kvm-s390.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3abe177..1f30087 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -132,12 +132,12 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D=
 {
>  	{ "instruction_sigp_cpu_reset", VCPU_STAT(instruction_sigp_cpu_reset)=
 },
>  	{ "instruction_sigp_init_cpu_reset", VCPU_STAT(instruction_sigp_init_=
cpu_reset) },
>  	{ "instruction_sigp_unknown", VCPU_STAT(instruction_sigp_unknown) },
> -	{ "diagnose_10", VCPU_STAT(diagnose_10) },
> -	{ "diagnose_44", VCPU_STAT(diagnose_44) },
> -	{ "diagnose_9c", VCPU_STAT(diagnose_9c) },
> -	{ "diagnose_258", VCPU_STAT(diagnose_258) },
> -	{ "diagnose_308", VCPU_STAT(diagnose_308) },
> -	{ "diagnose_500", VCPU_STAT(diagnose_500) },
> +	{ "instruction_diag_10", VCPU_STAT(diagnose_10) },
> +	{ "instruction_diag_44", VCPU_STAT(diagnose_44) },
> +	{ "instruction_diag_9c", VCPU_STAT(diagnose_9c) },
> +	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
> +	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
> +	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
>  	{ NULL }
>  };
>=20



--g2pjhsjXJmPDdMsKfrI2wTyJrIUWUyPWD--

--UYnDAwX68A5vSuf246esPBhr5KDljA1lb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaaH8XAAoJEBcO/8Q8ZEV5c7wQAKqGcyaIa4LfYFy/eE88N6fy
r/pegIUTGJD0Z/I2Sr+ZClud8o8tHgQoef5qLYCP37w5XIwtVlXE8VPt8E1xg5zc
ckMeTjwbXjKly8GEEhza25YPk2upvVWBoDinLDy+VTkHiD5dVRVBLjy7IBIcoBRA
tdeeY1Ip5weL7ysyUOnAt+Ikh+v2DI3/ncP1HGkYDYyUN/BPJqmDcHxPmCYS/tjQ
d4SNcTT+7X5jVuQTBMlqerghGXZM/kUA6txxgIy1xTuA+cCrT0i0mWfFmmDm5HXQ
wk41jyg+wO+otplNFO3qDVXmAAJpNjEsnJRCVSk1E+tlv0ldXLnITYJt5RzejEYy
10uZ2MmpVtmlXMHOkxoguB0DuJSNB79mgAwHKHcDz82DcN2PiYJ81624j/fU8x1O
1nfJqYFDUX1psTL9g1kr/XA9TLKsdF0uXtCugQruDGqgXK6S+mgPwalXtwTDpmxr
gOVhSx6Q/HcKlMhbFaOEzi8iL0g8RRvlN4Ff2vSG19NOlp4vUYFXRytnOCyyH9lD
4jGXrKl1YDitCbrv02/1SNhuwze3GAHKrd8CSere0RPj8A9lPHy0wS1sfWDyMs6E
RaFgxL+BgYZAg1C6jwXhwreGtiGWK9ebLbSS4cRw+hrD+XeYEutoYI7Qyfxevh0K
gt1NB2l4BktU9GKmsB01
=QiqW
-----END PGP SIGNATURE-----

--UYnDAwX68A5vSuf246esPBhr5KDljA1lb--
