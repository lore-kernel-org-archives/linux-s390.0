Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728435AbfLLJjc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:32 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9bEkc116654
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:39:31 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8m0v7c3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:39:30 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Dec 2019 09:39:19 -0000
Subject: Re: [kvm-unit-tests PATCH v4 3/9] s390x: interrupt registration
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-4-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:39:15 +0100
MIME-Version: 1.0
In-Reply-To: <1576079170-7244-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L3xDJArAebKHX4yp87u0Vf7JaK820eBN7"
Message-Id: <7ae0f105-0809-3c42-288c-f7136764a8f3@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L3xDJArAebKHX4yp87u0Vf7JaK820eBN7
Content-Type: multipart/mixed; boundary="bOld5wOUZqOqi8aFVTkcWeQY8k5ooa1w2"

--bOld5wOUZqOqi8aFVTkcWeQY8k5ooa1w2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 4:46 PM, Pierre Morel wrote:
> Define two functions to register and to unregister a call back for IO
> Interrupt handling.

How about:
Let's make it possible to add and remove a custom io interrupt handler,
that can be used instead of the normal one.

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  lib/s390x/interrupt.c | 23 ++++++++++++++++++++++-
>  lib/s390x/interrupt.h |  7 +++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>  create mode 100644 lib/s390x/interrupt.h
>=20
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 05f30be..b70aafd 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -10,9 +10,9 @@
>   * under the terms of the GNU Library General Public License version 2=
=2E
>   */
>  #include <libcflat.h>
> -#include <asm/interrupt.h>
>  #include <asm/barrier.h>
>  #include <sclp.h>
> +#include <interrupt.h>
> =20
>  static bool pgm_int_expected;
>  static bool ext_int_expected;
> @@ -141,12 +141,33 @@ void handle_mcck_int(void)
>  		     lc->mcck_old_psw.addr);
>  }
> =20
> +static void (*io_int_func)(void);
> +
>  void handle_io_int(void)
>  {
> +	if (*io_int_func)
> +		return (*io_int_func)();
> +
>  	report_abort("Unexpected io interrupt: at %#lx",
>  		     lc->io_old_psw.addr);
>  }
> =20
> +int register_io_int_func(void (*f)(void))
> +{
> +	if (io_int_func)
> +		return -1;
> +	io_int_func =3D f;
> +	return 0;
> +}

Not completely sure why this isn't a bool, but ok.

> +
> +int unregister_io_int_func(void (*f)(void))
> +{
> +	if (io_int_func !=3D f)
> +		return -1;
> +	io_int_func =3D NULL;
> +	return 0;
> +}
> +
>  void handle_svc_int(void)
>  {
>  	report_abort("Unexpected supervisor call interrupt: at %#lx",
> diff --git a/lib/s390x/interrupt.h b/lib/s390x/interrupt.h
> new file mode 100644
> index 0000000..e945ef7
> --- /dev/null
> +++ b/lib/s390x/interrupt.h
> @@ -0,0 +1,7 @@
> +#ifndef __INTERRUPT_H
> +#include <asm/interrupt.h>
> +
> +int register_io_int_func(void (*f)(void));
> +int unregister_io_int_func(void (*f)(void));
> +
> +#endif
>=20



--bOld5wOUZqOqi8aFVTkcWeQY8k5ooa1w2--

--L3xDJArAebKHX4yp87u0Vf7JaK820eBN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3yCsMACgkQ41TmuOI4
ufht7w//cYFofO2ThArFFL5dMEdt3moQp+urrqjmwq+bSdtXwWg6Whrdoi6xumyR
UT8AQpBp4CPbaz4YAHymvUAQDpSHIh9nGqnN8ezgt7eeNVCGdoGXIGZ8ygkDICfA
w2O1AEIIG16uGVA31Q4n3I2ZvA3J2pEW4Ap1/rMDHqJqYtm9wfl03iEgT6FaoT35
od4kSrBSYTi1z4MdNqcTzOZXl7OcNv2okOQpMk4V1Kc+7PsxpzVL+NBLQeYjrJBj
iAyPCg4teuVYFR6Kii+fYWToW+xPFwG2DOjVWI/QSG4jJ+J4YlcdicxtbbAmfoDh
wxTuldax75wZ5dt1LZOY7neijpxfesqJdmKn9KKK0sHiT51uvugZ9ANEg9ECD/1h
SbSt0tdmtPEcP3de70Yn9eI20lqcR1zJRuJKq/bnMY9aYMIyvB7qyNwXXjeOvnTb
fFJsTdfivOxPD/FnBmNkRfXFrFCwFVsr+trud47Zz/lT6jOT4kAxG9O2mmoV94db
p6Ru7UjKNgVJA3G/qR+n6BHh+AUpP3O/voBgvwFjNtoaQRMqCEfgu6kFzKw/rnck
nrajs7wyC2jv/9u9UEiwoNfVnUf1fan0AjBrUNLZq/rI3x2lCJxXiB6bjPc6dmGY
t42hDe1clRKSO27oVywa20garWdXm2TysUHkjKn6bjaUx5dtWyU=
=UoxB
-----END PGP SIGNATURE-----

--L3xDJArAebKHX4yp87u0Vf7JaK820eBN7--
