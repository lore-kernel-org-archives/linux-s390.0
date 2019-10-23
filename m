Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732361AbfJWIln (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Oct 2019 04:41:43 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix selftest malloc check
References: <20191023084017.13142-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b5363884-7360-ffc4-b572-f1942cbfae20@redhat.com>
Date: Wed, 23 Oct 2019 10:41:36 +0200
MIME-Version: 1.0
In-Reply-To: <20191023084017.13142-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com

On 23.10.19 10:40, Janosch Frank wrote:
> Commit c09c54c ("lib: use an argument which doesn't require default
> argument promotion") broke the selftest. Let's fix it by converting
> the binary operations to bool.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/selftest.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/selftest.c b/s390x/selftest.c
> index f4acdc4..9cd6943 100644
> --- a/s390x/selftest.c
> +++ b/s390x/selftest.c
> @@ -49,9 +49,9 @@ static void test_malloc(void)
>   =09*tmp2 =3D 123456789;
>   =09mb();
>  =20
> -=09report("malloc: got vaddr", (uintptr_t)tmp & 0xf000000000000000ul);
> +=09report("malloc: got vaddr", !!((uintptr_t)tmp & 0xf000000000000000ul)=
);
>   =09report("malloc: access works", *tmp =3D=3D 123456789);
> -=09report("malloc: got 2nd vaddr", (uintptr_t)tmp2 & 0xf000000000000000u=
l);
> +=09report("malloc: got 2nd vaddr", !!((uintptr_t)tmp2 & 0xf0000000000000=
00ul));
>   =09report("malloc: access works", (*tmp2 =3D=3D 123456789));
>   =09report("malloc: addresses differ", tmp !=3D tmp2);
>  =20
>=20

See

https://lore.kernel.org/kvm/CAGG=3D3QUdVBg5JArMaBcRbBLrHqLLCpAcrtvgT4q1h0V7=
SHbbEQ@mail.gmail.com/T/


--=20

Thanks,

David / dhildenb
