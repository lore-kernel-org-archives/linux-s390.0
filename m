Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgGPLQG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jul 2020 07:16:06 -0400
Subject: Re: [kvm-unit-tests PATCH v13 6/9] s390x: Library resources for CSS
 tests
References: <1594887809-10521-1-git-send-email-pmorel@linux.ibm.com>
 <1594887809-10521-7-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <9d6f0445-9c13-c23b-6095-0699ad09be87@linux.ibm.com>
Date: Thu, 16 Jul 2020 13:15:59 +0200
MIME-Version: 1.0
In-Reply-To: <1594887809-10521-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L3jFuDl4lhAuhJ01ZT1MssJVHp3slIx8d"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, drjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L3jFuDl4lhAuhJ01ZT1MssJVHp3slIx8d
Content-Type: multipart/mixed; boundary="JS3mdtDrOWnaEEuRhm207fEsvnGeG9bQS"

--JS3mdtDrOWnaEEuRhm207fEsvnGeG9bQS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/16/20 10:23 AM, Pierre Morel wrote:
> Provide some definitions and library routines that can be used by
> tests targeting the channel subsystem.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Acked-by: Janosch Frank <frankja@de.ibm.com>
> ---
[...]
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ddb4b48..050c40b 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -51,6 +51,7 @@ cflatobjs +=3D lib/s390x/sclp-console.o
>  cflatobjs +=3D lib/s390x/interrupt.o
>  cflatobjs +=3D lib/s390x/mmu.o
>  cflatobjs +=3D lib/s390x/smp.o
> +cflatobjs +=3D lib/s390x/css_dump.o
> =20
>  OBJDIRS +=3D lib/s390x
> =20

I need to fix this up when picking because Thomas added vm.o after smp.o.=

Can I do that or do you want to rebase on my next branch?



--JS3mdtDrOWnaEEuRhm207fEsvnGeG9bQS--

--L3jFuDl4lhAuhJ01ZT1MssJVHp3slIx8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8QNu8ACgkQ41TmuOI4
ufh8Wg/+KzzzpGwqm6uC5UKVFmQSV2wxrkMo8DXhNJmtpVGLlYytLaD3OjOcCsAV
Fcvm1erYdIKD1HslhwoZXpbQ73ngKug0BYF1FWwaWoC9S/sFajy8tqcVgjsKyIgw
MH2ZlNEuZcBLqMHEIwgd7rRBRhHM6nxPaulLqphtOcyvjjpQJJSgugOSxQBBR1Y/
9xXYkYytdQrB/du0Wu4PM4O0zrHzZjN6OnuoxyvEgec6azCx1ZCDEcJtGCUT2iEi
/njzmweXXw2+X3ivLSJoPbD4CwLuE95U2TLrHHXzy9fw03TM6nNM4A10sx4itkUx
cEDSmvFNAvnbgeaH8dTRXW6vlb/bo/SSlniN7/Dd14BvbTQl1LzuxMFSKApJm1AX
uHGFeTO+huFaI5xqX3CdUu9K53vkFswOnayreticZfaZLyNSvL/9QNdzvlKb//k/
TTrEGZQXM3AV/0qUr+M+43rDPF/u7ndvIneAo/fzBXZD3IxAC3j6cDcr+mnguaWn
+GdRR3XFeM2X9+oRcvD6JwfcWkTEIwSN1jandPujOdiyEMTeNflQyo7QwP9ti1Y+
uZFFx1hclARw4UlrJK3ZLL0RaoX5HoqZvTr+HVUbCWiKgN+MKVwWG8IbVBYVO2/c
i2o1IbfsFNA36gyjRhfUvlh9ewXHe6zGsKuKuCzGEOkv+ZpnTYM=
=YZQa
-----END PGP SIGNATURE-----

--L3jFuDl4lhAuhJ01ZT1MssJVHp3slIx8d--
