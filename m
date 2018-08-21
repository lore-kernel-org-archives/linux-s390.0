From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: vsie: BUG correction by shadow_crycb
Date: Tue, 21 Aug 2018 16:43:56 +0200
Message-ID: <929b67bc-44aa-a9ff-0ac2-9a35c2b456ef@linux.ibm.com>
References: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X43GvZ6Unz625VP8aaFdeypc3njakGSrY"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X43GvZ6Unz625VP8aaFdeypc3njakGSrY
Content-Type: multipart/mixed; boundary="RPAoSTDRlzAUq6HFxxrK9DAC5aWtm7kl1";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Pierre Morel <pmorel@linux.ibm.com>, david@redhat.com
Cc: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <929b67bc-44aa-a9ff-0ac2-9a35c2b456ef@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: vsie: BUG correction by shadow_crycb
References: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>
In-Reply-To: <1534861178-30372-1-git-send-email-pmorel@linux.ibm.com>

--RPAoSTDRlzAUq6HFxxrK9DAC5aWtm7kl1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.2018 16:19, Pierre Morel wrote:
> Copy the key mask to the right offset inside the shadow CRYCB
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 63844b9..a2b28cd 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, stru=
ct vsie_page *vsie_page)
>  		return set_validity_icpt(scb_s, 0x0039U);
> =20
>  	/* copy only the wrapping keys */
> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
> +	if (read_guest_real(vcpu, crycb_addr + 72,
> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>  		return set_validity_icpt(scb_s, 0x0035U);
> =20
>  	scb_s->ecb3 |=3D ecb3_flags;
>=20

Are we able to use offsetof and sizeof here? I'd rather have a few more
characters than magic offsets.
What about CC stable?


Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--RPAoSTDRlzAUq6HFxxrK9DAC5aWtm7kl1--

--X43GvZ6Unz625VP8aaFdeypc3njakGSrY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfCU7AAoJEBcO/8Q8ZEV5LmoQAIaOj0UvC931G4ViFLCKEZjy
EToo0xDAoWo5uicMsusTYans5zj+LyYOr4cYFZkl1jlw0qR4fQt4GT2WpkSteAZw
jmFsNjwA326A6dRQtjO5SvNPa8pnVHuLKCwWg3ufdWeY3V9PZ2zwJQHUvtZNcyu0
CyAxH63yZ0JTuKHH88GzCgqyWKSXoJuvIslWo7bHSGIHTbiz9xQqVi79L7KzuHqi
XDa96S8tXZedyMeSOk4HmdBFHGoFLZ+T/HUFuim50QF0X9AwoktJVlTpJNI4zdgl
4NoNOapGneOzVXtT5u3B0baO2fP5E94ck6xrNUt8hzvfKHHUDXeIh1lH5dL12abz
Wk8FHvIAsCzZqtBx/sDi60MTUg2+2c381fseu0+oTERaV4aEOdrjmzPNHyeIIWjv
AGGbnLFDUwuR391RwyIV6VfNxTDVEnH0WwLaJxoEu6rVPyvlRiNgCV7LP7Z8KISC
qgJg5LM4gCns2pgiBdPr0NysKvOSUVznuKeLzA7WFgrswUG0oop1ukoCr5XYt2nX
GEN4nxOe4pPf47iEvpR1Tqp3Te0DHbaSYd8hhRazIicaj6pVdOVoc6xO0PanZZdq
Lq6kL8avMbqIujqHfn2kCZR2ru001IT/HLiSncMImbV9QF8t2mmxQf6uR7PP5Vgc
XOk7fhXAjsvqXUOsd9rZ
=D3wa
-----END PGP SIGNATURE-----

--X43GvZ6Unz625VP8aaFdeypc3njakGSrY--
