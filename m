Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgC0JKf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 05:10:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R95Dmm030464
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 05:10:34 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf0s1jbd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2020 05:10:34 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 27 Mar 2020 09:10:30 -0000
Subject: Re: [PATCH] s390/gmap: return proper error code on ksm unsharing
References: <20200327085602.24535-1-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 27 Mar 2020 10:10:27 +0100
MIME-Version: 1.0
In-Reply-To: <20200327085602.24535-1-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tHvwkubQvYrASZx5yJknDpVawMZM19yOR"
Message-Id: <c1a20f51-e39d-f8c6-2bac-e374017f46dd@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tHvwkubQvYrASZx5yJknDpVawMZM19yOR
Content-Type: multipart/mixed; boundary="dhcmXRPtRVT7MDxMUj7OLvG7PgMTXTLh5"

--dhcmXRPtRVT7MDxMUj7OLvG7PgMTXTLh5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/27/20 9:56 AM, Christian Borntraeger wrote:
> If a signal is pending we might return -ENOMEM instead of -EINTR.
> We should propagate the proper error during KSM unsharing.
>=20
> Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled page=
s")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

> ---
>  arch/s390/mm/gmap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 27926a06df32..2bf63035a295 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2552,15 +2552,16 @@ int gmap_mark_unmergeable(void)
>  {
>  	struct mm_struct *mm =3D current->mm;
>  	struct vm_area_struct *vma;
> +	int ret  =3D 0;
>=20
>  	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> -		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -				MADV_UNMERGEABLE, &vma->vm_flags)) {
> -			return -ENOMEM;
> -		}
> +		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
> +				MADV_UNMERGEABLE, &vma->vm_flags);
> +		if (ret)
> +			return ret;
>  	}
>  	mm->def_flags &=3D ~VM_MERGEABLE;
> -	return 0;
> +	return ret;

That part is not really necessary but also doesn't hurt.

>  }
>  EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
>=20



--dhcmXRPtRVT7MDxMUj7OLvG7PgMTXTLh5--

--tHvwkubQvYrASZx5yJknDpVawMZM19yOR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl59wwMACgkQ41TmuOI4
ufjhVw/+KCOJI3kp1JpdX7RECLZp8bFR/DdPkVRwmKYmqRQsS/GnN6CaX7xvELWQ
waJXLNk1IbY7WMNoYALcZV1lYSGRVA8THAixWiRYzI1vxYwmuDhgpzhUCaOg4RD8
3boZEkjpwHOA+7Js+1ykv/09XBe3YdIwQeKoCyl40T8Z7VwUYvhhOU8ParKoHUTq
ZWt76zmXyBKdCkvZAE1SLcounDHvsEnrTttlSMdhq3oK4sobrx0s7WyM+rrJyG4Z
k9ki6WPLB/OK/A6+oBtGLrmRzJaZ/R72hHRvPV6DKRq322rmFrJgIFQXEpNPk6W5
a/a/gZ7bnR724gQaZCauDBtCpvykOdpHjq0qdg1XhBByAgza77hvp5yKPDq20X5Y
Rj86BNfqOaUMVuix25tXiJYIhMLhmPI9X92lN4ja9kkbi+NcFU4llBc28dQUkG05
NwA0iEl9EWvcbPm54C9JjZ1zXE21Oc2h9oNjriD8SIdFxahSy827stBxUJdtlnt9
B7qnC47aP7PYqcUfha/D3bLire35MUABCza/A/Dbx5inTC8apLZGqntZ+gwXegyJ
VOSBJbEoW6YIoW0jDOTX0EiY2/yYGptL5jA3JMUYj0siK0fIHC+bkgyHupqp4EDz
lwLEomdq+FaOn8t0zp9sv+rbV6a4adjHspgTFM+kfSPw4b9NH28=
=WUer
-----END PGP SIGNATURE-----

--tHvwkubQvYrASZx5yJknDpVawMZM19yOR--
