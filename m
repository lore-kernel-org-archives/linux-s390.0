Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728436AbfLLJlE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 04:41:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9dI00075861
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:41:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wugd25bky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:41:04 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Dec 2019 09:41:01 -0000
Subject: Re: [kvm-unit-tests PATCH v4 4/9] s390x: export the clock
 get_clock_ms() utility
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-5-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:40:57 +0100
MIME-Version: 1.0
In-Reply-To: <1576079170-7244-5-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ysUUF0xKVnVihvhlPKKfQk0bhznBwboor"
Message-Id: <c26c335a-7894-09ad-bc23-6ae060f4a255@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ysUUF0xKVnVihvhlPKKfQk0bhznBwboor
Content-Type: multipart/mixed; boundary="FCmalBjL3xuIvOHKwKUrjjKubkxaIDQHy"

--FCmalBjL3xuIvOHKwKUrjjKubkxaIDQHy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 4:46 PM, Pierre Morel wrote:
> To serve multiple times, the function get_clock_ms() is moved
> from intercept.c test to the new file asm/time.h.

Let's move get_clock_ms() to lib/s390/asm/time.h, so it can be used in
multiple places.

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  lib/s390x/asm/time.h | 26 ++++++++++++++++++++++++++
>  s390x/intercept.c    | 11 +----------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/time.h
>=20
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> new file mode 100644
> index 0000000..25c7a3c
> --- /dev/null
> +++ b/lib/s390x/asm/time.h
> @@ -0,0 +1,26 @@
> +/*
> + * Clock utilities for s390
> + *
> + * Authors:
> + *  Thomas Huth <thuth@redhat.com>
> + *
> + * Copied from the s390/intercept test by:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
> + */
> +#ifndef _ASM_S390X_TIME_H_
> +#define _ASM_S390X_TIME_H_
> +
> +static inline uint64_t get_clock_ms(void)
> +{
> +	uint64_t clk;
> +
> +	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
> +
> +	/* Bit 51 is incrememented each microsecond */
> +	return (clk >> (63 - 51)) / 1000;
> +}
> +
> +#endif
> diff --git a/s390x/intercept.c b/s390x/intercept.c
> index 3696e33..80e9606 100644
> --- a/s390x/intercept.c
> +++ b/s390x/intercept.c
> @@ -13,6 +13,7 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/interrupt.h>
>  #include <asm/page.h>
> +#include <asm/time.h>
> =20
>  static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE=
 * 2)));
> =20
> @@ -159,16 +160,6 @@ static void test_testblock(void)
>  	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
>  }
> =20
> -static uint64_t get_clock_ms(void)
> -{
> -	uint64_t clk;
> -
> -	asm volatile(" stck %0 " : : "Q"(clk) : "memory");
> -
> -	/* Bit 51 is incrememented each microsecond */
> -	return (clk >> (63 - 51)) / 1000;
> -}
> -
>  struct {
>  	const char *name;
>  	void (*func)(void);
>=20



--FCmalBjL3xuIvOHKwKUrjjKubkxaIDQHy--

--ysUUF0xKVnVihvhlPKKfQk0bhznBwboor
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3yCykACgkQ41TmuOI4
ufg6Bw/8CaCMB1IUQls7ldXjBU483a+8iLXIcVCACRVwM7X349Ib+0HibVGga5T+
tQ1+fGPvX0JqAwKNX6H3AxaLuXap3Svu7b/JxtDgvwBzTj+SXR49Lg1foXHhkQRK
UGQGpP+iupKe7LXemBp9Hka8dKWgZnIoqtuAhCe8mXdIMYn67AtuRojxrnWRiFl+
SV8xWJypfTijOcQy5+tDGbl3yFLc/ksQoEa05oqwfFG1mvL31y8G1n3F9pyb/iCa
/tdAVz8aOKtHNcTZoLEJHlCvV00ML+f3Ybyop4lS/95wgiEfVD1Bd58t3hFFvKe5
e0U02+zuypCtVFlrdLylnzXx0ls7Yfk5VHDpxotBjbt6wRXT4dVoDpfwNd0Hov6B
ZsjXIZOo8m+BpsBn6S9lOl0lnh7KA5sIwAblOGqbZbt+kHBe/xPnOJLkkQGozEQv
FxWT+hwT0eYbzvE+eJ8qgdp90AqJaA5Uctv9aYpBlUIep2qHYxnIAB5gSykWG1Zo
jv8badKdxutpbTBehh/KXpw8nDFgB8ZA+wi4gkNOsDGXHKPGqH6VfnoZGp0yQyBG
Y5MLX2kQSHPhtACs+3UiUps6yf3N5UcTL856fwrI+dIKvYhtOhiHrOKKbbezgMKy
c85ikwhy7BepJ6qxBHG0q8Lg5SFuTkwD2PG1IXSBMgoZYnyewcg=
=6E0e
-----END PGP SIGNATURE-----

--ysUUF0xKVnVihvhlPKKfQk0bhznBwboor--
