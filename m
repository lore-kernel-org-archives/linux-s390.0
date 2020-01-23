Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgAWKCO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jan 2020 05:02:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9v53I116240
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 05:02:14 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xp3u8a9ay-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2020 05:02:13 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 23 Jan 2020 10:02:11 -0000
Subject: Re: [kvm-unit-tests PATCH v4 3/9] s390x: Add cpu id to interrupt
 error prints
From: Janosch Frank <frankja@linux.ibm.com>
References: <20200121134254.4570-1-frankja@linux.ibm.com>
 <20200121134254.4570-4-frankja@linux.ibm.com>
Date: Thu, 23 Jan 2020 11:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <20200121134254.4570-4-frankja@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QuKMEoGgLNLkEZq3WdAd9WQRmY1XwXkkP"
Message-Id: <0eb69c66-5aa7-1609-9de0-c3d0efaed30a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QuKMEoGgLNLkEZq3WdAd9WQRmY1XwXkkP
Content-Type: multipart/mixed; boundary="cHoknl57HwFFjRuAxHcNlg9v4ZhoKdgtr"

--cHoknl57HwFFjRuAxHcNlg9v4ZhoKdgtr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/21/20 2:42 PM, Janosch Frank wrote:
> It's good to know which cpu broke the test.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/interrupt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 05f30be..773752a 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -107,8 +107,8 @@ static void fixup_pgm_int(void)
>  void handle_pgm_int(void)
>  {
>  	if (!pgm_int_expected)
> -		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
> -			     lc->pgm_int_code, lc->pgm_old_psw.addr,
> +		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, il=
en %d\n",
> +			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
>  			     lc->pgm_int_id);
> =20
>  	pgm_int_expected =3D false;
> @@ -119,8 +119,8 @@ void handle_ext_int(void)
>  {
>  	if (!ext_int_expected &&
>  	    lc->ext_int_code !=3D EXT_IRQ_SERVICE_SIG) {
> -		report_abort("Unexpected external call interrupt (code %#x): at %#lx=
",
> -			     lc->ext_int_code, lc->ext_old_psw.addr);
> +		report_abort("Unexpected external call interrupt (code %#x): on cpu =
%d at %#lx",
> +			     stap(), lc->ext_int_code, lc->ext_old_psw.addr);

The arguments are in the wrong order, stap() should come after the int
code...


>  		return;
>  	}
> =20
> @@ -137,18 +137,18 @@ void handle_ext_int(void)
> =20
>  void handle_mcck_int(void)
>  {
> -	report_abort("Unexpected machine check interrupt: at %#lx",
> -		     lc->mcck_old_psw.addr);
> +	report_abort("Unexpected machine check interrupt: on cpu %d at %#lx",=

> +		     stap(), lc->mcck_old_psw.addr);
>  }
> =20
>  void handle_io_int(void)
>  {
> -	report_abort("Unexpected io interrupt: at %#lx",
> -		     lc->io_old_psw.addr);
> +	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
> +		     stap(), lc->io_old_psw.addr);
>  }
> =20
>  void handle_svc_int(void)
>  {
> -	report_abort("Unexpected supervisor call interrupt: at %#lx",
> -		     lc->svc_old_psw.addr);
> +	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#lx=
",
> +		     stap(), lc->svc_old_psw.addr);
>  }
>=20



--cHoknl57HwFFjRuAxHcNlg9v4ZhoKdgtr--

--QuKMEoGgLNLkEZq3WdAd9WQRmY1XwXkkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4pbx8ACgkQ41TmuOI4
ufgJCRAAkMV085Xgr4bBJawmFm39u79utTIgPYZ8If25YhhqIirHAMRE9uUJMlEG
L3uY9aX814Knu6sJT2/j8Z+06oqTqIDmcQ5k7uXSEsLA7++t3RUqlGdqaBXqEfKd
gkOQKoYEu05YOmHND9QNlKxvCxC3BEl3xScQqVVSDGydkvSh/wPtqQTNSKlmL8Se
yZZV589OXxFYWwzqZDiU2iLdpwhlwWGXKHW46jo3H/2sZcR08BtGUbOWCHsUXz9a
+L7PflwGMT86MKLBgPRSEWWmuULeBfVqDPkr8d2HLpuMrJPEj5XPxMXKFiThpm7r
BB48m+sdSNHqtPn6gbMbvt1DeDhmdlqrWbmRBNa45+0fROBieJNY6+Vmcbe5Ap4d
X4Z7QfC2XIedk/IZTLPmASCBt37bmfcuh4qMi3jITNYvjKvpVqKBAF6ZA0EQChZ9
tcWbMFKFJvQvhS5uTzrfGfCPFKD2EZjRUMQOFbxjRcjF66HxOVD6IQYKUMIf9LIp
HLBQR4TYsEgW5CYyVBdts5f7eJjjfxCHuwldTjg17RpGOrLzWhebKruaiNERMHGx
RupbreYViEA8Joo4mfXW3rfuNrlt5mL0jgo5TI3Tlf6+x/IzHWUdLfEEjyv4oGE8
KbXh/Ol8uD9QESGlcCvgHRK7qsGVBOLu/adrbmCCOMxbUjSqsD8=
=8lNe
-----END PGP SIGNATURE-----

--QuKMEoGgLNLkEZq3WdAd9WQRmY1XwXkkP--
