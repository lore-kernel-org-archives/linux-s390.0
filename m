Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgDXI1U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 04:27:20 -0400
Subject: Re: [kvm-unit-tests PATCH v5 04/10] s390x: interrupt registration
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-5-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <c8d1081a-8e94-f28e-66e7-fe98aea31837@linux.ibm.com>
Date: Fri, 24 Apr 2020 10:27:12 +0200
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-5-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wPx7vhOY84tMe3TtHWKKZgdUZIIxEscDN"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wPx7vhOY84tMe3TtHWKKZgdUZIIxEscDN
Content-Type: multipart/mixed; boundary="PdD8IvfZTe6vLUBVmh1zujAiFl1yOzhLJ"

--PdD8IvfZTe6vLUBVmh1zujAiFl1yOzhLJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/20/20 1:00 PM, Pierre Morel wrote:
> Let's make it possible to add and remove a custom io interrupt handler,=

> that can be used instead of the normal one.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 22 +++++++++++++++++++++-
>  lib/s390x/interrupt.h |  7 +++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>  create mode 100644 lib/s390x/interrupt.h
>=20
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 3a40cac..f6f0665 100644
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

Hrm

> =20
>  static bool pgm_int_expected;
>  static bool ext_int_expected;
> @@ -144,12 +144,32 @@ void handle_mcck_int(void)
>  		     stap(), lc->mcck_old_psw.addr);
>  }
> =20
> +static void (*io_int_func)(void);
> +
>  void handle_io_int(void)
>  {
> +	if (*io_int_func)
> +		return (*io_int_func)();
>  	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
>  		     stap(), lc->io_old_psw.addr);
>  }
> =20
> +int register_io_int_func(void (*f)(void))
> +{
> +	if (io_int_func)
> +		return -1;
> +	io_int_func =3D f;
> +	return 0;
> +}
> +
> +int unregister_io_int_func(void (*f)(void))
> +{
> +	if (io_int_func !=3D f)
> +		return -1;
> +	io_int_func =3D NULL;
> +	return 0;
> +}

I'm currently working on something similar for PGMs and I see no
additional value in two functions for this. Unregistering can be done by
doing register_io_int_func(NULL)

This should be enough:

int register_io_int_func(void (*f)(void))
{
	io_int_func =3D f;
}

> +
>  void handle_svc_int(void)
>  {
>  	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx=
",
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



--PdD8IvfZTe6vLUBVmh1zujAiFl1yOzhLJ--

--wPx7vhOY84tMe3TtHWKKZgdUZIIxEscDN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6iouAACgkQ41TmuOI4
ufi1yg/+OT/HIYcrKEY965SpT9ZzWtHuQuix0LbuTooJicTSB+3+2HMMDvBjPKWl
/Yw5vdUCbuFC1iltxuI/EpceCUjFFzL7Pq4Nwvg0xH0TGDDaPkOOawJtMVkwpjVt
iW7SbDDKTIN212uqIXgJ/uWX6ve/aANeI/ogSzV2MprwJX/IZelUrgLEu8dtn7Sc
lYtpYSgbtzHHSYxYuvsAfCYcAX2e8X7OxTdogpAXAjE78QJRfAT+rKIuY2I7MvaW
TygTwkvVjNaLEo2ryI3nEc3zt4F2AmVfvfncNjX4qiXUL3CwW8E2QrKPW86uaWoF
LZuzOVV/fbeewr3YPjf8yX10XpN7BoAlI9nXZY3xurO3K63wkyIrJPG3fTZVs6fl
3/h9zAvn3w1xmPMj5itldzRiMUF+GCbFQQweGyFeqXWs8GoDvc9JM7Ek0QQgiMYX
PMjxcx3zg9dzdRy0ZN8VXa/PEUF3/b9g7F23VprJ8I3J7vXqJ/SFRL4U/B/eIcyk
broJDhuu/bnunbYXfr4estfqjadpM2MuTYdmE5cZUdECJMYaYy23BK47LOqMAHWZ
wLq9j6GKVQPw2/I9sBn1ahQIDW+VGLgDyUoGv+mc8xr7Y5nGX8BqeznKpBzR6ywC
ab7/mEoeea1W3zXs3gET4isS8jwN+ZVkDZEeNGrfGymaUtzq7sM=
=mExk
-----END PGP SIGNATURE-----

--wPx7vhOY84tMe3TtHWKKZgdUZIIxEscDN--
