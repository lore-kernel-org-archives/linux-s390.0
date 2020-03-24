Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727405AbgCXM0X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:26:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OC3p27163259
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:26:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7t852b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:26:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 24 Mar 2020 12:26:20 -0000
Subject: Re: [PATCH 2/2] s390x: add linux-s390 list
References: <20200324121722.9776-1-cohuck@redhat.com>
 <20200324121722.9776-3-cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 24 Mar 2020 13:26:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200324121722.9776-3-cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="go4K6aiLk1UK4UuQV7Cw4M1CJPKxrVJjp"
Message-Id: <de43705a-f183-ad80-a86e-3c407aa79b6c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--go4K6aiLk1UK4UuQV7Cw4M1CJPKxrVJjp
Content-Type: multipart/mixed; boundary="AhEOGOtfT5utPYsXLHmgGbI4BQmdr4Aei"

--AhEOGOtfT5utPYsXLHmgGbI4BQmdr4Aei
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/24/20 1:17 PM, Cornelia Huck wrote:
> It makes sense to cc: patches there as well.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 471767a355c6..8912533e441d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -83,6 +83,7 @@ M: David Hildenbrand <david@redhat.com>
>  R: Janosch Frank <frankja@linux.ibm.com>
>  R: Cornelia Huck <cohuck@redhat.com>
>  L: kvm@vger.kernel.org
> +L: linux-s390@vger.kernel.org
>  F: s390x/*
>  F: lib/s390x/*

Ack.


--AhEOGOtfT5utPYsXLHmgGbI4BQmdr4Aei--

--go4K6aiLk1UK4UuQV7Cw4M1CJPKxrVJjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl55/GgACgkQ41TmuOI4
ufhURRAAtOGH8GgWqGT9Bazpzc8L4SYRFmNHZFIpRsf91UMzlLluZnZWfMrP9TAt
AY5pkuktHlsGqokCedJ51wjIa3nk6p4LEYpP4nT/fZoKH3ZOJ+Gkfd/8g4tLPeLV
7pd3HXayH3jJi5b3eCqz4QkoGkzL2B6ObC3EZxD9BotZFhS17ihFSpLwvgNnYQFv
kO+UgFn0hyjzWGV+JP6tH6nJnp+e8HIn4u7Kydm/6/U7MN0LY0WgXuzFn3DtcCqp
NEPpOBzzdPF7M/BAyP1NVBwVYPs3Hlkrw9hQOyGk9nVmmDNYHCU6elf/VGw7PEnu
6aOsY0Fuv8wRxMupuquHjS5xT8QRbYsma9032Teld6izXb0JFqVuRLoVb+nG51O3
qBS/+G3V/qcCfr4caX3laa2bV6FYPQ5S6RDPmgaGVVafed885b3qR8EkJn4gx8FE
ifBN16IRGFS1/lFhny2Sf1omXQpyhKb3jHEk9h4yQO1M3k/wTomQMypC4RXLGRkF
LPzmhvu5zNWOw4azNO479n6rG5hxMebGbixgZ7XGmoCSuQiokL7itRcfWOmVMFYL
phzI0VK3aBZw9idn/v/7N3dk6J7v7jEaQUFOTCPYR1r6uyKFPuf0jYoSj8K+xa9A
2zq/a4teR8OBOLf8oh2A8WwDHks0Vtuxm2d2PVjMeug8UjHWNUo=
=0D5r
-----END PGP SIGNATURE-----

--go4K6aiLk1UK4UuQV7Cw4M1CJPKxrVJjp--
