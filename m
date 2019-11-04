Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbfKDJWX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 04:22:23 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA49FIMW145368
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 04:22:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w2fm9bms0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 04:22:21 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 4 Nov 2019 09:22:20 -0000
Subject: Re: [kvm-unit-tests PATCH v2 3/5] s390x: sclp: expose ram_size and
 max_ram_size
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
 <1572023194-14370-4-git-send-email-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 4 Nov 2019 10:22:15 +0100
MIME-Version: 1.0
In-Reply-To: <1572023194-14370-4-git-send-email-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cEaQwYbAN250IzQ20hs73u4TgHoDAE3SW"
Message-Id: <a93da22b-4306-42da-1f6d-82141bab361a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cEaQwYbAN250IzQ20hs73u4TgHoDAE3SW
Content-Type: multipart/mixed; boundary="BciYyPTjWnF4fzBglZr2CKNeFF3iTKC0O"

--BciYyPTjWnF4fzBglZr2CKNeFF3iTKC0O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/25/19 7:06 PM, Claudio Imbrenda wrote:
> Expose ram_size and max_ram_size through accessor functions.
>=20
> We only use get_ram_size in an upcoming patch, but having an accessor
> for the other one does not hurt.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

I already use it for WIP patches :-)

>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  lib/s390x/sclp.h |  2 ++
>  lib/s390x/sclp.c | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index f00c3df..6d40fb7 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -272,5 +272,7 @@ void sclp_console_setup(void);
>  void sclp_print(const char *str);
>  int sclp_service_call(unsigned int command, void *sccb);
>  void sclp_memory_setup(void);
> +uint64_t get_ram_size(void);
> +uint64_t get_max_ram_size(void);
> =20
>  #endif /* SCLP_H */
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 56fca0c..7798f04 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -167,3 +167,13 @@ void sclp_memory_setup(void)
> =20
>  	mem_init(ram_size);
>  }
> +
> +uint64_t get_ram_size(void)
> +{
> +	return ram_size;
> +}
> +
> +uint64_t get_max_ram_size(void)
> +{
> +	return max_ram_size;
> +}
>=20



--BciYyPTjWnF4fzBglZr2CKNeFF3iTKC0O--

--cEaQwYbAN250IzQ20hs73u4TgHoDAE3SW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2/7ccACgkQ41TmuOI4
ufjIIQ/+POocjny6VKWaxGCDJkkyyHt3sWcrLt8qxAVvPzZSEWnwxlTis2u1U7Gq
wUlSI4fGXVExkd+B23+3Uqfqrhkcq5O5NXEalmijEXhseoqYoBM2MOZAiFknQQFF
lewcpDWDsDdSFhFly0OBVAGIEjHI7rceOzVd4UUxt7kYg6ZTTJQiLoSVbkuXH3tI
efQ/bxOCY406AtA0EviV7Xyima5PZ48U5z+vA4KcvND1mfhl4+qXX6XBy/wmPA5+
Id8KgrndkuqHweKTKgUhuHjQUsD/dhs64js/tdHm90kz8fTLflifounrKaCYZyuO
4MOiMH5mXA1YhXNKsbQIl1xWzBvDCR749UkYzqf/lrRtX5/BIhSkVJzascz24QJW
3cjtpkHUYCa2pymYF7UI7jrwPB8JHVDqNBZYY7sPXQv1FdxgK+fcRHgOKrB/86in
qGXKkD/+Be9hK5qUlpGIp1jLgZEUd/R0rBL05qgKTgj1zjHo1O9TlmS/JKVkaPNn
1tcE9enWhpT1fNJYSkx6dc4bUstErqUwHYxwnftO0hjbhEVILargEIOPHcUskYyS
KWo7J+JCtb9sbrwlpXm4NmyHrcU17ZjTaUvkCpupafzruS/bLEwwjs2QuKhjsLd1
nzMtMzNmPkh/zY8whqxy0Ty/Y37Y6PJ+uVXJEipJUZsHF+WGweQ=
=8WlR
-----END PGP SIGNATURE-----

--cEaQwYbAN250IzQ20hs73u4TgHoDAE3SW--
