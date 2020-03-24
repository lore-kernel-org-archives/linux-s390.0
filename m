Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727283AbgCXMZp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Mar 2020 08:25:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OCJvMi167792
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:25:43 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yyj400534-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Mar 2020 08:25:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 24 Mar 2020 12:25:40 -0000
Subject: Re: [PATCH 1/2] s390x: add myself as reviewer
References: <20200324121722.9776-1-cohuck@redhat.com>
 <20200324121722.9776-2-cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 24 Mar 2020 13:25:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200324121722.9776-2-cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="28rLbVZHWbCJ6NDdmOL62T72wYYoS1eUT"
Message-Id: <2556051f-99d8-4d18-80eb-f6bdf7e886a1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--28rLbVZHWbCJ6NDdmOL62T72wYYoS1eUT
Content-Type: multipart/mixed; boundary="Jl7pIfwUcR8e6fU8Vl4QcUaCZ2lQVvg5x"

--Jl7pIfwUcR8e6fU8Vl4QcUaCZ2lQVvg5x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/24/20 1:17 PM, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48da1dbdd1ac..471767a355c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -81,6 +81,7 @@ S390X
>  M: Thomas Huth <thuth@redhat.com>
>  M: David Hildenbrand <david@redhat.com>
>  R: Janosch Frank <frankja@linux.ibm.com>

Hmm, so the patch to make me maintainer hasn't yet been pulled. Oo
@David, did it go missing once Thomas went on leave?

> +R: Cornelia Huck <cohuck@redhat.com>
>  L: kvm@vger.kernel.org
>  F: s390x/*
>  F: lib/s390x/*
>=20

Acked.
So you want to have more work being sent to you? :-)
Time to send out more QEMU patches then!


--Jl7pIfwUcR8e6fU8Vl4QcUaCZ2lQVvg5x--

--28rLbVZHWbCJ6NDdmOL62T72wYYoS1eUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl55/EEACgkQ41TmuOI4
ufhdJQ/9HFYwYf+ddbZMuvrJditWvihj+3nI+2QXKAUZz1VIFso7+hYga+AB9gr+
8lGgUiyOQzeYDVhjK+lvJOn3dIfp0XOgG6jRpxiiwtBhVgP0+A8SgRrzH2loSQGY
uiv5yTfDIaNdcM9G1y5n7TPw03MyVzUM4hFjHR+Z8h6PW9mX6BcN8x3n10Fo4Ic4
sqovQwpPXwyIy6ryfmM07dPgTh7FJMmYFfKOcFx7mBYDJAPM8NF0r3JaSG3ISd9s
QCaHIpyJVt0ZScccMWaDubTGpB+RfICEDi3ZStJqC+FutZluGAvHfkxmaoeYl2gM
983T0dWwNEU4nWPVONLcDCYFgq7JYBbHFwuLR0qm92+3CD3BncFHGeLy5IADXNBt
GiNpKWjaIq/oWUGU/sjmF2Z2ZnaBhGYAENXUZrbr8bfJTK07jci0vVEiyqyWaz9W
lh4iEW3c9APV+nxmFgIryHif6AHVQIl20q4wtdnY6wDWQJbn87kMEWxkew9RZT3i
2LEHtXXIk4sqB9dx8Nh8J7jU00garX+kAWQ155mLU+PSCodu8Nkw+iTt1hd/bKGX
ocj8U23D3UNuz5blYMrhQxtoO4X4J6CFjaT8zh7IdIAKo5iTWXC0KTqw3J5Ye8Pj
I86swskRziwEq8M+UiaYX6B+qVu4u/41YH4qO5480htLE5+ITQY=
=rxFZ
-----END PGP SIGNATURE-----

--28rLbVZHWbCJ6NDdmOL62T72wYYoS1eUT--
