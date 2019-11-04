Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726441AbfKDKHJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 05:07:09 -0500
Subject: Re: [kvm-unit-tests PATCH v2 4/5] s390x: sclp: add service call
 instruction wrapper
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
 <1572023194-14370-5-git-send-email-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1427281c-9493-9889-a37f-81c6c603b91a@redhat.com>
Date: Mon, 4 Nov 2019 11:06:59 +0100
MIME-Version: 1.0
In-Reply-To: <1572023194-14370-5-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 25.10.19 19:06, Claudio Imbrenda wrote:
> Add a wrapper for the service call instruction, and use it for SCLP
> interactions instead of using inline assembly everywhere.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   lib/s390x/asm/arch_def.h | 13 +++++++++++++
>   lib/s390x/sclp.c         |  7 +------
>   2 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 96cca2e..b3caff6 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -269,4 +269,17 @@ static inline int stsi(void *addr, int fc, int sel1,=
 int sel2)
>   =09return cc;
>   }
>  =20
> +static inline int servc(uint32_t command, unsigned long sccb)
> +{
> +=09int cc;
> +
> +=09asm volatile(
> +=09=09"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
> +=09=09"       ipm     %0\n"
> +=09=09"       srl     %0,28"
> +=09=09: "=3D&d" (cc) : "d" (command), "a" (sccb)
> +=09=09: "cc", "memory");
> +=09return cc;
> +}
> +
>   #endif
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 7798f04..e35c282 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -116,12 +116,7 @@ int sclp_service_call(unsigned int command, void *sc=
cb)
>   =09int cc;
>  =20
>   =09sclp_setup_int();
> -=09asm volatile(
> -=09=09"       .insn   rre,0xb2200000,%1,%2\n"  /* servc %1,%2 */
> -=09=09"       ipm     %0\n"
> -=09=09"       srl     %0,28"
> -=09=09: "=3D&d" (cc) : "d" (command), "a" (__pa(sccb))
> -=09=09: "cc", "memory");
> +=09cc =3D servc(command, __pa(sccb));
>   =09sclp_wait_busy();
>   =09if (cc =3D=3D 3)
>   =09=09return -1;
>=20

I do wonder if we should really do that. Shouldn't we always set/wait if=20
busy (especially, if testing for an error condition that won't trigger)?=20
IOW, shouldn't we have a modified sclp_service_call() that returns the=20
CC (and also calls sclp_setup_int()/sclp_wait_busy())?

We could also simply make sclp_service_call() return the cc and handle=20
the cc in the existing callers.

--=20

Thanks,

David / dhildenb
