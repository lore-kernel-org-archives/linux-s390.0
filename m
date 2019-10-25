Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406192AbfJYIYn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 04:24:43 -0400
Subject: Re: [RFC 08/37] KVM: s390: add missing include in gmap.h
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-9-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2055e82a-5fea-1903-1c76-b3a8c8fb544f@redhat.com>
Date: Fri, 25 Oct 2019 10:24:34 +0200
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-9-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> gmap.h references radix trees, but does not include linux/radix-tree.h
> itself. Sources that include gmap.h but not also radix-tree.h will
> therefore fail to compile.
>=20
> This simple patch adds the include for linux/radix-tree.h in gmap.h so
> that users of gmap.h will be able to compile.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/include/asm/gmap.h | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> index eab6a2ec3599..99b3eedda26e 100644
> --- a/arch/s390/include/asm/gmap.h
> +++ b/arch/s390/include/asm/gmap.h
> @@ -10,6 +10,7 @@
>   #define _ASM_S390_GMAP_H
>  =20
>   #include <linux/refcount.h>
> +#include <linux/radix-tree.h>
>  =20
>   /* Generic bits for GMAP notification on DAT table entry changes. */
>   #define GMAP_NOTIFY_SHADOW=090x2
>=20

Not sure if that's worth a separate patch, just squash it into the patch=20
that needs it?

We usually don't care about includes as long as it compiles ...

--=20

Thanks,

David / dhildenb
