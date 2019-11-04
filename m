Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728064AbfKDJXH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 04:23:07 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA49FRef172636
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 04:23:06 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w15ethxyb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 04:23:05 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 4 Nov 2019 09:23:01 -0000
Subject: Re: [kvm-unit-tests PATCH v2 4/5] s390x: sclp: add service call
 instruction wrapper
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
 <1572023194-14370-5-git-send-email-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 4 Nov 2019 10:22:56 +0100
MIME-Version: 1.0
In-Reply-To: <1572023194-14370-5-git-send-email-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YPrNEOhWAleduR4UqGl7Gb59wIlVhuQIW"
Message-Id: <8b634cc6-6675-66f2-f4e7-2a36256915a1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YPrNEOhWAleduR4UqGl7Gb59wIlVhuQIW
Content-Type: multipart/mixed; boundary="qeEJT3seud3JZET4BgvxSkkrJWKXjvppk"

--qeEJT3seud3JZET4BgvxSkkrJWKXjvppk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/25/19 7:06 PM, Claudio Imbrenda wrote:
> Add a wrapper for the service call instruction, and use it for SCLP
> interactions instead of using inline assembly everywhere.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  lib/s390x/asm/arch_def.h | 13 +++++++++++++
>  lib/s390x/sclp.c         |  7 +------
>  2 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 96cca2e..b3caff6 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -269,4 +269,17 @@ static inline int stsi(void *addr, int fc, int sel=
1, int sel2)
>  	return cc;
>  }
> =20
> +static inline int servc(uint32_t command, unsigned long sccb)
> +{
> +	int cc;
> +
> +	asm volatile(
> +		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
> +		"       ipm     %0\n"
> +		"       srl     %0,28"
> +		: "=3D&d" (cc) : "d" (command), "a" (sccb)
> +		: "cc", "memory");
> +	return cc;
> +}
> +
>  #endif
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 7798f04..e35c282 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -116,12 +116,7 @@ int sclp_service_call(unsigned int command, void *=
sccb)
>  	int cc;
> =20
>  	sclp_setup_int();
> -	asm volatile(
> -		"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
> -		"       ipm     %0\n"
> -		"       srl     %0,28"
> -		: "=3D&d" (cc) : "d" (command), "a" (__pa(sccb))
> -		: "cc", "memory");
> +	cc =3D servc(command, __pa(sccb));
>  	sclp_wait_busy();
>  	if (cc =3D=3D 3)
>  		return -1;
>=20



--qeEJT3seud3JZET4BgvxSkkrJWKXjvppk--

--YPrNEOhWAleduR4UqGl7Gb59wIlVhuQIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2/7fAACgkQ41TmuOI4
ufiJKw/+OsLZx9LFAmmSTtmzNlYo8g4bGzl8PX+TvbklXoOhXlaZITHEFyApLSQH
9FQQkAq/h0eQYKhAt55OyNcinldStRnKDtMREXNdmeHrYQvHqmXu7hbsXanMI5G0
+yWf18yAzIsGRdVKE4XONyV88eiHm9waRkHR8CU1FaSnbTk89WOD9cJLh3BKO7f1
+vHfQq+9v/EhXBuIbSYzMA+liB5aScDf34YdtbliBVVoU+YZZHZie3LOy1zB0J0W
GSiW1IJaKXOi5fxAc5BDa1Ckwd28MlX1J33ZqT5F/OrZ6shnfuHZTddmHriA5Kw6
rcMt97CxW2ynFHJ2ddSgQvFJWF4QbvZAoOUpQAbD435MK8X0BHlocYY98Vw80Z7n
FNXUafjCEATuYQsVmw1HXaZm+dB31jAvnvSYrYHXEzESYOHktmmo1F1LANVlAmnm
dDP/7E719hATshwQT4ItKx7QE9CqHHFqdk+wezabfRhOEuqq9bI5r1+gSuyXP9a4
23EKWeY2kHy9GOYECmbRkWobz/s03SxVSAWP+EFg9ZlAPWkD5jb/mexcbNa99C5k
nxw0/dj1d3i+i8Yvb+Y+Qy3dcz6CTSFhZjMe2hEjk6QhNY273MViB4Iox6JHzewx
seno8k0mdNjcfveV4yznOqyjRxAp7hy+zxmEunvsq9Wg6yTp7yc=
=SBAF
-----END PGP SIGNATURE-----

--YPrNEOhWAleduR4UqGl7Gb59wIlVhuQIW--
