Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENIdl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 04:33:41 -0400
Subject: Re: [PATCH v6 1/2] s390/setup: diag318: refactor struct
References: <20200513221557.14366-1-walling@linux.ibm.com>
 <20200513221557.14366-2-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <cf47cb01-863b-f7e1-6a0d-22bf16d9a09b@linux.ibm.com>
Date: Thu, 14 May 2020 10:33:33 +0200
MIME-Version: 1.0
In-Reply-To: <20200513221557.14366-2-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qWfG88lzbT31LqIVd4SmACT4nwUkZVnKz"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qWfG88lzbT31LqIVd4SmACT4nwUkZVnKz
Content-Type: multipart/mixed; boundary="pzuwDLFSNrOSbQ08m7saGCqxmiBflQpSI"

--pzuwDLFSNrOSbQ08m7saGCqxmiBflQpSI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/14/20 12:15 AM, Collin Walling wrote:
> The diag318 struct introduced in include/asm/diag.h can be
> reused in KVM, so let's condense the version code fields in the
> diag318_info struct for easier usage and simplify it until we
> can determine how the data should be formatted.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  arch/s390/include/asm/diag.h | 6 ++----
>  arch/s390/kernel/setup.c     | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.=
h
> index 0036eab14391..ca8f85b53a90 100644
> --- a/arch/s390/include/asm/diag.h
> +++ b/arch/s390/include/asm/diag.h
> @@ -298,10 +298,8 @@ struct diag26c_mac_resp {
>  union diag318_info {
>  	unsigned long val;
>  	struct {
> -		unsigned int cpnc : 8;
> -		unsigned int cpvc_linux : 24;
> -		unsigned char cpvc_distro[3];
> -		unsigned char zero;
> +		unsigned long cpnc : 8;
> +		unsigned long cpvc : 56;
>  	};
>  };
> =20
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index 36445dd40fdb..1aaaf11acc6b 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -1028,8 +1028,7 @@ static void __init setup_control_program_code(voi=
d)
>  {
>  	union diag318_info diag318_info =3D {
>  		.cpnc =3D CPNC_LINUX,
> -		.cpvc_linux =3D 0,
> -		.cpvc_distro =3D {0},
> +		.cpvc =3D 0,
>  	};
> =20
>  	if (!sclp.has_diag318)
>=20



--pzuwDLFSNrOSbQ08m7saGCqxmiBflQpSI--

--qWfG88lzbT31LqIVd4SmACT4nwUkZVnKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl69Al4ACgkQ41TmuOI4
ufh2JQ/9FWCjQB8INIm+Ew0JppRYgRZXiWntkHyj1xaetw4wvtT9/i44PtFrtfEm
YuHGFuDvHW3TE7sOWJ89/RUr+DeANf1+qGQPO7Tk1gK/hCGmHkUVytQqjlhGAJrh
bmPPztouk6HyaO1UA8W2OOidn+C0MvlQ3Oj58Z6PtMq5UfKzCfYvz/pEIWvgMuFJ
m1nEhUNVgnmym3T2Nzda13LBqWFJbu5MTU33ZCWmQAG8KoF8krnMvxl5Rot2VBcJ
OI3hOGdf9VlCbilAQEHf6tBoRsWieQhhMnvpkfuagmr/Iep5BJPlILsP1ivA0hG0
krfIEPWFroFNCM8/SFTeTKpz+sDmtpE6+SfYGNiETKyRZgMnl3P92ENAC6hOt/VR
goQwVJxW9glaXFznQN+Jr/S5utQzaLlO8AeiawF8hoqBltETD8M7rWb5+jA/HOPK
IavYYRaZ4JtEpYpbqkBVrb2abfjXK1xA5iEbXlfs4GaAL11y/jyGoxQOHYYFqAZy
uRzl9oJl7tY5VOYIU33z0Wdj93ar2JQjzcU99rI/OuMbCXhlAeQOliWqZhAM73lK
6okg5kczouZBOSuyrQ4OAZTVqrGyjEPbwTYipx8mQGlLOl+ISROjOZO0LpQ9hjvD
PM90fuiM12q4oZDb/YI8LMU1py936TBUu/1FN1/40lga1DvpbHU=
=/nd2
-----END PGP SIGNATURE-----

--qWfG88lzbT31LqIVd4SmACT4nwUkZVnKz--
