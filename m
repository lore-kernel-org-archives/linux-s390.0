Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726721AbgD0NOu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 09:14:50 -0400
Subject: Re: [kvm-unit-tests PATCH v6 10/10] s390x: css: ping pong
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-11-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <ecd95341-0cc2-1aee-239d-5de63cf6e7e1@linux.ibm.com>
Date: Mon, 27 Apr 2020 15:14:42 +0200
MIME-Version: 1.0
In-Reply-To: <1587725152-25569-11-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VyqPkqdbUITqYaIO0uC6vBUXeniAb2kHj"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VyqPkqdbUITqYaIO0uC6vBUXeniAb2kHj
Content-Type: multipart/mixed; boundary="i0FRPbYCTBrF48cJQBESMhP1kCF65USwz"

--i0FRPbYCTBrF48cJQBESMhP1kCF65USwz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:45 PM, Pierre Morel wrote:
> To test a write command with the SSCH instruction we need a QEMU device=
,
> with control unit type 0xC0CA. The PONG device is such a device.
>=20
> This type of device responds to PONG_WRITE requests by incrementing an
> integer, stored as a string at offset 0 of the CCW data.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/css.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 54 insertions(+)
>=20
> diff --git a/s390x/css.c b/s390x/css.c
> index b9dbf01..7cd8731 100644
> --- a/s390x/css.c
> +++ b/s390x/css.c
> @@ -23,6 +23,12 @@
>  #define PSW_PRG_MASK (PSW_MASK_EA | PSW_MASK_BA)
> =20
>  #define PONG_CU_TYPE		0xc0ca
> +/* Channel Commands for PONG device */
> +#define PONG_WRITE	0x21 /* Write */
> +#define PONG_READ	0x22 /* Read buffer */
> +
> +#define BUFSZ	9
> +static char buffer[BUFSZ];
> =20
>  struct lowcore *lowcore =3D (void *)0x0;
> =20
> @@ -262,6 +268,53 @@ unreg_cb:
>  	unregister_io_int_func(irq_io);
>  }
> =20
> +static void test_ping(void)
> +{
> +	int success, result;
> +	int cnt =3D 0, max =3D 4;
> +
> +	if (senseid.cu_type !=3D PONG_CU) {
> +		report_skip("No PONG, no ping-pong");

"Device is not a pong device."

> +		return;
> +	}
> +
> +	result =3D register_io_int_func(irq_io);
> +	if (result) {
> +		report(0, "Could not register IRQ handler");
> +		return;
> +	}

I'm not sure if it's worth checking the return values or even having a
check in register_io_int_func() in the first place.

> +
> +	while (cnt++ < max) {
> +		snprintf(buffer, BUFSZ, "%08x\n", cnt);
> +		success =3D start_subchannel(PONG_WRITE, buffer, BUFSZ);
> +		if (!success) {
> +			report(0, "start_subchannel failed");
> +			goto unreg_cb;
> +		}
> +
> +		wfi(PSW_MASK_IO);
> +
> +		success =3D start_subchannel(PONG_READ, buffer, BUFSZ);
> +		if (!success) {
> +			report(0, "start_subchannel failed");
> +			goto unreg_cb;
> +		}
> +
> +		wfi(PSW_MASK_IO);
> +
> +		result =3D atol(buffer);
> +		if (result !=3D (cnt + 1)) {
> +			report(0, "Bad answer from pong: %08x - %08x",
> +			       cnt, result);
> +			goto unreg_cb;
> +		}
> +	}
> +	report(1, "ping-pong count 0x%08x", cnt);
> +
> +unreg_cb:
> +	unregister_io_int_func(irq_io);
> +}
> +
>  static struct {
>  	const char *name;
>  	void (*func)(void);
> @@ -269,6 +322,7 @@ static struct {
>  	{ "enumerate (stsch)", test_enumerate },
>  	{ "enable (msch)", test_enable },
>  	{ "sense (ssch/tsch)", test_sense },
> +	{ "ping-pong (ssch/tsch)", test_ping },
>  	{ NULL, NULL }
>  };
> =20
>=20



--i0FRPbYCTBrF48cJQBESMhP1kCF65USwz--

--VyqPkqdbUITqYaIO0uC6vBUXeniAb2kHj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6m2sIACgkQ41TmuOI4
ufhqGQ//XzwgcznOKIT/896pX9dyVpuW0p1I7r8gE1gJ4IIpa8CU+rcUNbsmmCLX
BQw5jjnhuenHV0veHZ2HqXq+1k2DxlAKZOhxo0NC80z+wdjPEw4/IhmQEPzihSc+
keoUgN5bj+Jp5dlNpcGLnPBCTTuINSqdrwAQnZGdiuEAT3hETYAxSkdU/6hCsnR5
kUxRSil7cPlU8HMMTBemr2Y6QVM2Ew4QnWp5s+IS9051OB+lpKpeyRFXgsKsIVa+
0JHLdipTMzdw9cr2IXs5b0h2Oq5FU1Z8/eKFrAeN/yM48VkXdMeZMnPKWtWz7waa
rc5A57HbGHvKN8qsCnl7TFt30kOVwAtaD0WMVb9Wtn0tT0Cl8N5ACnoIe5Tnbqjr
OalF8K3dPD5YOKdVMCSgHvPrF1wQTry58J4d2cC1XxBpOo1Mw/QqC6tGt1himoHg
9VyI31UTVzMtJxrybNTz5dudGPQ/KbJ4Y/WRZhCDqF7nbgrfvtC6se+LQjz8hD5o
J/yHmFgySIBP1yQ+7BWwYTrht9IOrCdM06Axk/q7xh0A6ImNZ2exVUAC+JIX/eQF
iiIxgaaF2yoFiwdwl4eaBMyjWrFIgEmZYTIUbLUKEQc7uVyQoLbB2vOYvtM1ZNEW
tULRzNRRRj+uJsLvZjKQvsN03seFuZzQl623daNBUDX2NRrjRmU=
=P/+U
-----END PGP SIGNATURE-----

--VyqPkqdbUITqYaIO0uC6vBUXeniAb2kHj--
