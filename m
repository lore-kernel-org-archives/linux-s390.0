Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgFVJJh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 05:09:37 -0400
Subject: Re: [kvm-unit-tests PATCH v9 06/12] s390x: clock and delays
 caluculations
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-7-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <7659047a-a0f9-b959-c286-b150477d15ab@linux.ibm.com>
Date: Mon, 22 Jun 2020 11:09:29 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rWj6qfHjn1QKv1PMOF07HRRk9NA3lH7eX"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rWj6qfHjn1QKv1PMOF07HRRk9NA3lH7eX
Content-Type: multipart/mixed; boundary="eMFW8VtGtyjG1OW2PJx919qRaN2UMEjNH"

--eMFW8VtGtyjG1OW2PJx919qRaN2UMEjNH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/15/20 11:31 AM, Pierre Morel wrote:
> The hardware gives us a good definition of the microsecond,
> let's keep this information and let the routine accessing
> the hardware keep all the information and return microseconds.
>=20
> Calculate delays in microseconds and take care about wrapping
> around zero.
>=20
> Define values with macros and use inlines to keep the
> milliseconds interface.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

Small nit below.


Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  lib/s390x/asm/time.h | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> index 1791380..7f1d891 100644
> --- a/lib/s390x/asm/time.h
> +++ b/lib/s390x/asm/time.h
> @@ -13,14 +13,39 @@
>  #ifndef ASM_S390X_TIME_H
>  #define ASM_S390X_TIME_H
> =20
> -static inline uint64_t get_clock_ms(void)
> +#define STCK_SHIFT_US	(63 - 51)
> +#define STCK_MAX	((1UL << 52) - 1)
> +
> +static inline uint64_t get_clock_us(void)
>  {
>  	uint64_t clk;
> =20
>  	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
> =20
>  	/* Bit 51 is incrememented each microsecond */
> -	return (clk >> (63 - 51)) / 1000;
> +	return clk >> STCK_SHIFT_US;
> +}
> +
> +static inline void udelay(unsigned long us)
> +{
> +	unsigned long startclk =3D get_clock_us();
> +	unsigned long c;
> +
> +	do {
> +		c =3D get_clock_us();
> +		if (c < startclk)
> +			c +=3D STCK_MAX;
> +	} while (c < startclk + us);
> +}
> +
> +static inline void mdelay(unsigned long ms)
> +{
> +	udelay(ms * 1000);
> +}
> +
> +static inline uint64_t get_clock_ms(void)
> +{
> +	return get_clock_us() / 1000;
>  }

Why don't you put that below to the get_clock_us()?

> =20
>  #endif
>=20



--eMFW8VtGtyjG1OW2PJx919qRaN2UMEjNH--

--rWj6qfHjn1QKv1PMOF07HRRk9NA3lH7eX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7wdUoACgkQ41TmuOI4
ufgcwhAA14vAWKiDcnMIFzAyT1EaL41KAoWwEWpUvwg4+3quGjUDKDw69WHFjiie
PKjD+Zir+NT+/7KAVri7uvVWCz20lR4hRhh/9F5/rTXeDuLuaxNlI3Sb4jujhmTC
k9mvAg88/tAajSBChjacHHllEl95sXczi0Woa8lykUKiQFhJLnvbngwMcHLhpzuH
07oEDPX/DIw2pKvzFgTyZKDGJtYHvL8QpIKoiGVLE7a7H+aXYU0u0Gol+vmqipkl
GgaPzfPQBhcsYsO7fiAap8WCUGX075ZtIBtN9Spg+qvuvI5lSUFNvcjowHPGAUJS
f0AL41Rtm1pn4GLyckgxMNt5Rv3MO/NZ/+tNv2vhTVha3tD9tPCWBk7LkUlOymuI
y5gxr6qjylLy+lQgkcAGENofmj78b3kAP4a4qo4gQT2MfPf/HXTqnG7TmLguUJzD
jPVqIiC0HjXNqwprJFKHevwBsNR5Q7w0WY+qQxRz9INJaI1xblZq7GRyPiHx7WnD
IB97Pg4PAgbze54KZ6ky8zbdpmKW2+8Xl/HY5ZjIfTtna7nILQ3XVrHmYjGKJaqV
OKkEE8rBuvnimKT3BBH5qYjtGYgnvskTHO6CDNrsR1Dau7PTEjxoFvmm3hQqeWs/
03dAtECIe5AsQlGwjHmq8RBE+dRQSdkSjRT+R0DcsnIUnnG64ZI=
=6t/0
-----END PGP SIGNATURE-----

--rWj6qfHjn1QKv1PMOF07HRRk9NA3lH7eX--
