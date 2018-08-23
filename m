From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Thu, 23 Aug 2018 13:05:54 +0200
Message-ID: <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f8wAQi4XCzRHihTFHrPa6TYtcAhSbZWLv"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f8wAQi4XCzRHihTFHrPa6TYtcAhSbZWLv
Content-Type: multipart/mixed; boundary="ZaJuj2jQstAlwb8LcmZvHVTHqnot5yAR6";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>

--ZaJuj2jQstAlwb8LcmZvHVTHqnot5yAR6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 12:25 PM, Pierre Morel wrote:
> The comment preceding the shadow_crycb function is
> misleading, we effectively accept FORMAT2 CRYCB in the
> guest.

I beg to differ:

if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
		return 0;

>=20
> When using FORMAT2 in the host we do not need to or with
> FORMAT1.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 38ea5da..e0e6fbf 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, =
struct vsie_page *vsie_page)
>   * Create a shadow copy of the crycb block and setup key wrapping, if
>   * requested for guest 3 and enabled for guest 2.
>   *
> - * We only accept format-1 (no AP in g2), but convert it into format-2=

> + * We accept format-1 or format-2, but we treat it as a format-1 (no A=
P in g2),
> + * and we convert it into format-2 in the shadow CRYCB.
>   * There is nothing to do for format-0.
>   *
>   * Returns: - 0 if shadowed or nothing to do
> @@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, stru=
ct vsie_page *vsie_page)
>  		return set_validity_icpt(scb_s, 0x0035U);
> =20
>  	scb_s->ecb3 |=3D ecb3_flags;
> -	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 =
|
> -			CRYCB_FORMAT2;
> +	scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;=


That's purely cosmetic but valid.

> =20
>  	/* xor both blocks in one run */
>  	b1 =3D (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>=20



--ZaJuj2jQstAlwb8LcmZvHVTHqnot5yAR6--

--f8wAQi4XCzRHihTFHrPa6TYtcAhSbZWLv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfpUYAAoJEBcO/8Q8ZEV5g0cQAKd5DhU8hVtXrU8Pv0NpciDi
8N+jJUlEoikp2XrOrscCqVNOUNRUUywwtZ4yCjse/TQnfQ61qtDykX6DXQJJxojz
GwNQWO4yDs/n8YnA3j7oUtzvPxI+7vMt17tuoSzoI04HbpYtbgQ3m2mPgRL6A+JX
baa8qzuh7mP6yAchf/8bR1S7rcS4PIO+BsexsNngfsYTOx7PNKROI6AcpPCqukyE
RVS2tBV+vDRm0pSSlKKOJCdKHgt7By1GbEWLnM9zLAXex+T5MkAwPr2qiotAurCR
ELrychnOeN9eQIlb+Duwy8+zJ1uqLudxIGejlFidjrMCaerJWlEqxqUDpzFZc0W+
CeDz5HVoYn8FeSHD9aaFqdV/SFg1EMxQMyCeRApiphf3X9oq8xaje1mK/o/QRe6v
vDcA9cw3O19Mxp25D0fMU3YKuFIT9/Y/QNxsM7SimCJXMeJVO4IvGTBLV3T4Et5R
OAdsf8yPieuLiRgcJ4ORv6wQ14wuEc0UPR1ZPbK6xhBMzBJYLRZ+B76Rle6wsLGp
ESn3t0q9GBsPcMcPqXULoWLvBvvV2q+HOHaCGhfBLdvNNcK1gAOzpkfvT0QJJinN
5LNqwnwSRIPjhnAF2AANYaKfIyeI16/+H3C0R7bfoVZ6VFeV+h1+NzPhH7ez07wW
E85o48r9IOX+b8B/KJh/
=vDcN
-----END PGP SIGNATURE-----

--f8wAQi4XCzRHihTFHrPa6TYtcAhSbZWLv--
