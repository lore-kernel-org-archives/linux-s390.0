From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] KVM: s390: vsie: Do the CRYCB validation first
Date: Thu, 23 Aug 2018 15:43:32 +0200
Message-ID: <e0822f44-f7cc-605c-a850-08f0d070c6d5@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y7urgM8jCGYuoA4ImLbIEHKltjDkUoLPl"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y7urgM8jCGYuoA4ImLbIEHKltjDkUoLPl
Content-Type: multipart/mixed; boundary="yY3l69sGsmkJTzTEWU05Jxg00LJ2Ht7AD";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <e0822f44-f7cc-605c-a850-08f0d070c6d5@linux.ibm.com>
Subject: Re: [PATCH v3 2/3] KVM: s390: vsie: Do the CRYCB validation first
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1535019956-23539-3-git-send-email-pmorel@linux.ibm.com>

--yY3l69sGsmkJTzTEWU05Jxg00LJ2Ht7AD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 12:25 PM, Pierre Morel wrote:
> When entering the SIE the CRYCB validation better
> be done independently of the instruction's
> availability.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 12b9707..38ea5da 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -161,17 +161,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, st=
ruct vsie_page *vsie_page)
>  	/* format-1 is supported with message-security-assist extension 3 */
>  	if (!test_kvm_facility(vcpu->kvm, 76))
>  		return 0;
> -	/* we may only allow it if enabled for guest 2 */
> -	ecb3_flags =3D scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
> -		     (ECB3_AES | ECB3_DEA);
> -	if (!ecb3_flags)
> -		return 0;
> =20
>  	if ((crycb_addr & PAGE_MASK) !=3D ((crycb_addr + 128) & PAGE_MASK))
>  		return set_validity_icpt(scb_s, 0x003CU);
>  	else if (!crycb_addr)
>  		return set_validity_icpt(scb_s, 0x0039U);
> =20
> +	/* we may only allow it if enabled for guest 2 */
> +	ecb3_flags =3D scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
> +		     (ECB3_AES | ECB3_DEA);
> +	if (!ecb3_flags)
> +		return 0;
> +
>  	/* copy only the wrapping keys */
>  	if (read_guest_real(vcpu, crycb_addr + 72,
>  			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>=20

I seemed to have forgotten to add this while being preoccupied with the
search for the validity discussion in #3.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--yY3l69sGsmkJTzTEWU05Jxg00LJ2Ht7AD--

--Y7urgM8jCGYuoA4ImLbIEHKltjDkUoLPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfroEAAoJEBcO/8Q8ZEV5WY4P/2/r9hNxj08UlECO6NGc6OW7
I//MOuICB3CLts9ZKqDhBKw79WZgp0bJr6+wtFX6QsE6o0Psm1L/M3I0n/peynO/
2Rhm7N3Xnw0MUcNbsJY3qlfvXIGrIgisrVUU0hUFASpJ98gMCer2OoWL8561/dGK
ChtKX2xLaDtlX2XKMHW+JDD6BHyf+2Y5ZaZfl1cufIwDygBhNeR9OyyGoPR9zsqb
xH8558nWv39cA7rDJcNLyykLtDa4XJara7LKQKq4Mw48IpnK/3c7p66Np/wh+LOU
SIDsp682cP3LcNp2CichrLkkMGbp32hMsg4qaGfPTXDcYWNX5G6zjW4rNFYRV4sB
EDbB+l2K1/N3l4EPAFjfX0WdFcVtIrL+ckur5WLfqlQzX0YVmhx+03u8H2mNr+Gg
RuxNLBLBlpukk0WQ/5qq7oOsuWcqKMXhAASE8lJxEe71XXN3CGxnuNfLCT5G0opx
63Tg4PYp1IBchhBO1AI1Rk3Iqeogt6IdKBManYZvlLlbcHEKRtphH9BceFbm4sRd
NY8unbwiZ6wK+YKmiMrwpJ+wRMrUwvIHnMMqvrOa69W+3ZVO6e0QeNUpevkr21mB
mmmvn6nx/OdNZsVXL5Rr5Pb3g+GMA8tCvcj8l1dpHV2/LqRsVtSm6g5aIkGKOBqn
CEG8XuTcklLYcRcwoGM/
=gck4
-----END PGP SIGNATURE-----

--Y7urgM8jCGYuoA4ImLbIEHKltjDkUoLPl--
