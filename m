Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727607AbfKDKAv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 05:00:51 -0500
Subject: Re: [kvm-unit-tests PATCH] s390x: Use loop to save and restore fprs
References: <20191104085533.2892-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <284994ac-6d9d-d5b5-5030-2c612f74bf42@redhat.com>
Date: Mon, 4 Nov 2019 11:00:41 +0100
MIME-Version: 1.0
In-Reply-To: <20191104085533.2892-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, pmorel@linux.ibm.com

On 04.11.19 09:55, Janosch Frank wrote:
> Let's save some lines in the assembly by using a loop to save and
> restore the fprs.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/cstart64.S | 38 ++++++--------------------------------
>   1 file changed, 6 insertions(+), 32 deletions(-)
>=20
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 5dc1577..8e2b21e 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -99,44 +99,18 @@ memsetxc:
>   =09lctlg=09%c0, %c0, 0(%r1)
>   =09/* save fprs 0-15 + fpc */
>   =09la=09%r1, GEN_LC_SW_INT_FPRS
> -=09std=09%f0, 0(%r1)
> -=09std=09%f1, 8(%r1)
> -=09std=09%f2, 16(%r1)
> -=09std=09%f3, 24(%r1)
> -=09std=09%f4, 32(%r1)
> -=09std=09%f5, 40(%r1)
> -=09std=09%f6, 48(%r1)
> -=09std=09%f7, 56(%r1)
> -=09std=09%f8, 64(%r1)
> -=09std=09%f9, 72(%r1)
> -=09std=09%f10, 80(%r1)
> -=09std=09%f11, 88(%r1)
> -=09std=09%f12, 96(%r1)
> -=09std=09%f13, 104(%r1)
> -=09std=09%f14, 112(%r1)
> -=09std=09%f15, 120(%r1)
> +=09.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +=09std=09\i, \i * 8(%r1)
> +=09.endr
>   =09stfpc=09GEN_LC_SW_INT_FPC
>   =09.endm
>  =20
>   =09.macro RESTORE_REGS
>   =09/* restore fprs 0-15 + fpc */
>   =09la=09%r1, GEN_LC_SW_INT_FPRS
> -=09ld=09%f0, 0(%r1)
> -=09ld=09%f1, 8(%r1)
> -=09ld=09%f2, 16(%r1)
> -=09ld=09%f3, 24(%r1)
> -=09ld=09%f4, 32(%r1)
> -=09ld=09%f5, 40(%r1)
> -=09ld=09%f6, 48(%r1)
> -=09ld=09%f7, 56(%r1)
> -=09ld=09%f8, 64(%r1)
> -=09ld=09%f9, 72(%r1)
> -=09ld=09%f10, 80(%r1)
> -=09ld=09%f11, 88(%r1)
> -=09ld=09%f12, 96(%r1)
> -=09ld=09%f13, 104(%r1)
> -=09ld=09%f14, 112(%r1)
> -=09ld=09%f15, 120(%r1)
> +=09.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +=09ld=09\i, \i * 8(%r1)
> +=09.endr
>   =09lfpc=09GEN_LC_SW_INT_FPC
>   =09/* restore cr0 */
>   =09lctlg=09%c0, %c0, GEN_LC_SW_INT_CR0
>=20

Looks good to me!

Queued to

https://github.com/davidhildenbrand/kvm-unit-tests.git s390x-next

For now, but waiting for more review.

--=20

Thanks,

David / dhildenb
