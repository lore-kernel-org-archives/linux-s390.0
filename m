Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18354 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgI2HUB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Sep 2020 03:20:01 -0400
Subject: Re: [kvm-unit-tests PATCH v2 1/4] memory: allocation in low memory
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
 <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
 <20200928173147.750e7358.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <136e1860-ddbc-edc0-7e67-fdbd8112a01e@linux.ibm.com>
Date: Tue, 29 Sep 2020 09:19:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200928173147.750e7358.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iiiQSkrXsPKYyn6hwcsD5QoaBubDcAav7"
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iiiQSkrXsPKYyn6hwcsD5QoaBubDcAav7
Content-Type: multipart/mixed; boundary="Lfgq9VU12Zqw1KZol0kYxaePWe3xduDxo"

--Lfgq9VU12Zqw1KZol0kYxaePWe3xduDxo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/28/20 5:31 PM, Cornelia Huck wrote:
> On Mon, 28 Sep 2020 16:23:34 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> Some architectures need allocations to be done under a
>> specific address limit to allow DMA from I/O.
>>
>> We propose here a very simple page allocator to get
>> pages allocated under this specific limit.
>>
>> The DMA page allocator will only use part of the available memory
>> under the DMA address limit to let room for the standard allocator.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  lib/alloc_dma_page.c | 57 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  lib/alloc_dma_page.h | 24 +++++++++++++++++++
>>  lib/s390x/sclp.c     |  2 ++
>>  s390x/Makefile       |  1 +
>>  4 files changed, 84 insertions(+)
>>  create mode 100644 lib/alloc_dma_page.c
>>  create mode 100644 lib/alloc_dma_page.h
>=20
> (...)
>=20
>> diff --git a/lib/alloc_dma_page.h b/lib/alloc_dma_page.h
>> new file mode 100644
>> index 0000000..85e1d2f
>> --- /dev/null
>> +++ b/lib/alloc_dma_page.h
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Page allocator for DMA definitions
>> + *
>> + * Copyright (c) IBM, Corp. 2020
>> + *
>> + * Authors:
>> + *  Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify =
it
>> + * under the terms of the GNU Library General Public License version =
2.
>> + */
>> +#ifndef _ALLOC_DMA_PAGE_H_
>> +#define _ALLOC_DMA_PAGE_H_
>> +
>> +#include <asm/page.h>
>> +
>> +void put_dma_page(void *dma_page);
>> +void *get_dma_page(void);
>> +phys_addr_t dma_page_alloc_init(phys_addr_t start_pfn, phys_addr_t nb=
_pages);
>> +
>> +#define DMA_MAX_PFN	(0x80000000 >> PAGE_SHIFT)
>> +#define DMA_ALLOC_RATIO	8
>=20
> Hm, shouldn't the architecture be able to decide where a dma page can
> be located? Or am I misunderstanding?

Before we start any other discussion on this patch we should clear up if
this is still necessary after Claudio's alloc revamp.

I think he added options to request special types of memory.

>=20
>> +
>> +#endif /* _ALLOC_DMA_PAGE_H_ */
> (...)
>=20



--Lfgq9VU12Zqw1KZol0kYxaePWe3xduDxo--

--iiiQSkrXsPKYyn6hwcsD5QoaBubDcAav7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9y4BkACgkQ41TmuOI4
ufj/2w//ZOQr/ojVVCunhMxmxNclgvBMh7EJdZJWaeNygf1W9mdbh16F+bBxmkPA
Ac0JF4anHo/AlhHJHx/9bgyibPIS5b2guazvRKYnmZZe6Uqv4gBT1a/hB5AIZbH/
Y9CjPdz82kh1J/YLjrUajpNSrG8yi+QYUD51UuKPKM/ougGkOFm7Ih0ZajsFh8iI
gotO5hsE07aBbIm/6rG0wHWd+1qCKAca2frdqjLzpQ9tX/huykj11euA5DMB3pf0
lvb9K2ie1NpBjeLjKRQRnucMELkQjBv8LZH5w/xG9oXi2auBqnhlAhAqz2aJHCTh
01koHPNTct1POCTy8IUnnfSAF4MegaXWqRHxbb6A3N/qUT5F/DQqZ7JA3wwQZSom
dq+kc++A/YNdRXXJbeeQYJFtwKCiuYxUi0Bk4aw56YlsjDReqFtWsm49T4zXt7M7
eZAi2b63cjtGtjJ4590XJRbHL9YRnU3Avq8w7BrfyAtSN0fxf36pq2ewtPXIXuQE
ODDKuFFz1JjhtKbG4AKyj/hfuMJfmd/E7PkVaj+Pa1YS8UtwLDMXReskb1RiOQ9e
GjQwL+6udgJN3Oq3aDlbjiiiPFcDJMUihzsVYd3WyqMsO1dwL/+U2cgdPxQwVZdA
eVASMSfmsAvNSfxiJ6duLr7FWzChpedcg9M7p48Ipk2AIXOROYQ=
=9AWW
-----END PGP SIGNATURE-----

--iiiQSkrXsPKYyn6hwcsD5QoaBubDcAav7--
