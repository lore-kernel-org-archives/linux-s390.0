Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgFVJdh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 22 Jun 2020 05:33:37 -0400
Subject: Re: [kvm-unit-tests PATCH v9 08/12] s390x: retrieve decimal and
 hexadecimal kernel parameters
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
 <1592213521-19390-9-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <a86a71c7-8c5e-7216-0a74-7bdc36355c02@linux.ibm.com>
Date: Mon, 22 Jun 2020 11:33:24 +0200
MIME-Version: 1.0
In-Reply-To: <1592213521-19390-9-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x4c5rWxOoMlca6A7C8cqBNKUamy9aC3dC"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, Andrew Jones <drjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x4c5rWxOoMlca6A7C8cqBNKUamy9aC3dC
Content-Type: multipart/mixed; boundary="txW6Zx0vTgWkScy27Jc5dohT3vRniO6r5"

--txW6Zx0vTgWkScy27Jc5dohT3vRniO6r5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/15/20 11:31 AM, Pierre Morel wrote:
> We often need to retrieve hexadecimal kernel parameters.
> Let's implement a shared utility to do it.

Often?

My main problem with this patch is that it doesn't belong into the s390
library. atol() is already in string.c so htol() can be next to it.

util.c already has parse_keyval() so you should be able to extend it a
bit for hex values and add a function below that goes through argv[].

CCing Andrew as he wrote most of the common library

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/kernel-args.c | 60 +++++++++++++++++++++++++++++++++++++++++=

>  lib/s390x/kernel-args.h | 18 +++++++++++++
>  s390x/Makefile          |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100644 lib/s390x/kernel-args.c
>  create mode 100644 lib/s390x/kernel-args.h
>=20
> diff --git a/lib/s390x/kernel-args.c b/lib/s390x/kernel-args.c
> new file mode 100644
> index 0000000..2d3b2c2
> --- /dev/null
> +++ b/lib/s390x/kernel-args.c
> @@ -0,0 +1,60 @@
> +/*
> + * Retrieving kernel arguments
> + *
> + * Copyright (c) 2020 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <string.h>
> +#include <asm/arch_def.h>
> +#include <kernel-args.h>
> +
> +static const char *hex_digit =3D "0123456789abcdef";
> +
> +static unsigned long htol(char *s)
> +{
> +	unsigned long v =3D 0, shift =3D 0, value =3D 0;
> +	int i, digit, len =3D strlen(s);
> +
> +	for (shift =3D 0, i =3D len - 1; i >=3D 0; i--, shift +=3D 4) {
> +		digit =3D s[i] | 0x20;	/* Set lowercase */
> +		if (!strchr(hex_digit, digit))
> +			return 0;	/* this is not a digit ! */
> +
> +		if (digit <=3D '9')
> +			v =3D digit - '0';
> +		else
> +			v =3D digit - 'a' + 10;
> +		value +=3D (v << shift);
> +	}
> +
> +	return value;
> +}
> +
> +int kernel_arg(int argc, char *argv[], const char *str, unsigned long =
*val)
> +{
> +	int i, ret;
> +	char *p, *q;
> +
> +	for (i =3D 0; i < argc; i++) {
> +		ret =3D strncmp(argv[i], str, strlen(str));
> +		if (ret)
> +			continue;
> +		p =3D strchr(argv[i], '=3D');
> +		if (!p)
> +			return -1;
> +		q =3D strchr(p, 'x');
> +		if (!q)
> +			*val =3D atol(p + 1);
> +		else
> +			*val =3D htol(q + 1);
> +		return 0;
> +	}
> +	return -2;
> +}
> diff --git a/lib/s390x/kernel-args.h b/lib/s390x/kernel-args.h
> new file mode 100644
> index 0000000..a88e34e
> --- /dev/null
> +++ b/lib/s390x/kernel-args.h
> @@ -0,0 +1,18 @@
> +/*
> + * Kernel argument
> + *
> + * Copyright (c) 2020 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
> + */
> +
> +#ifndef KERNEL_ARGS_H
> +#define KERNEL_ARGS_H
> +
> +int kernel_arg(int argc, char *argv[], const char *str, unsigned long =
*val);
> +
> +#endif
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ddb4b48..47a94cc 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -51,6 +51,7 @@ cflatobjs +=3D lib/s390x/sclp-console.o
>  cflatobjs +=3D lib/s390x/interrupt.o
>  cflatobjs +=3D lib/s390x/mmu.o
>  cflatobjs +=3D lib/s390x/smp.o
> +cflatobjs +=3D lib/s390x/kernel-args.o
> =20
>  OBJDIRS +=3D lib/s390x
> =20
>=20



--txW6Zx0vTgWkScy27Jc5dohT3vRniO6r5--

--x4c5rWxOoMlca6A7C8cqBNKUamy9aC3dC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7weuQACgkQ41TmuOI4
ufjZWA/+Ikh7yYITvg5lGGijgc1Q062oYsmOshLASfOdbVOR1P80GpU7aZolt/GL
ZvORUl2QpC67DKzA3l6k7Dn7a/tbF7bORchvhOQ9d448eYfXsr4tvFSdq+RTFMcb
oAQobUKNIDjcAtkAaYN87TCSfeEx1WDIgNbkChA83m9VOAJljfyi4WWJv24xS60K
2VHbSc9FpqKsAFqhfP1Ygw+mBgSr2GhJ3lZ6RzsJAQVAo5um5k0enYcEOglKZXrW
+CulEAE8QShEboaXEY2S2sPZL3+UKbRbXRt56VCLUM8IQNliqTvQjsK6bFqulhNy
fBB8BvGaWDdQu+uM3t/mCHKrqfKdbbjKgQHa9FmOOjlWD8qe8+EwP8/BlZCzoWaO
D7juVbdVKMMp7PSQWHTROV+tAjy7hts1PARF/v5P0pyQIaOoumADZBYLlfwNr9ug
ZjI9FwF4/FOKJYkvD3hFrZyz1HDzxt0K+idRdsF98isUMZerGWbjy9huOyeCEEXg
jUTbr0OFQL3khsNYYPKJgv8L+mdwRZQhbN720rgyPNjPayjHYu6HqaU6zCIxjh3S
iiPbS75KoTIO+G/SdW/NJB5HjgAOEwfnSvxbgSNJrceKjkLLhPDzRpQDbq165U4Q
J6pGdldRbjQaNZ1RzrJI6hpjh0GklfahFDhQZmkMqOMRm1fkINY=
=iohs
-----END PGP SIGNATURE-----

--x4c5rWxOoMlca6A7C8cqBNKUamy9aC3dC--
