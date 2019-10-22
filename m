Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20278 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731556AbfJVPqZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Oct 2019 11:46:25 -0400
Subject: Re: [kvm-unit-tests PATCH v1 4/5] s390x: sclp: add service call
 instruction wrapper
References: <1571741584-17621-1-git-send-email-imbrenda@linux.ibm.com>
 <1571741584-17621-5-git-send-email-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aeff96b6-8097-d89b-337c-22300fc4a70e@redhat.com>
Date: Tue, 22 Oct 2019 17:46:19 +0200
MIME-Version: 1.0
In-Reply-To: <1571741584-17621-5-git-send-email-imbrenda@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On 22.10.19 12:53, Claudio Imbrenda wrote:
> Add a wrapper for the service call instruction, and use it for SCLP
> interactions instead of using inline assembly everywhere.

The description is weird.

"Let's factor out the assembly for the service call instruction, we want=20
to reuse that for actual SCLP service call tests soon."

Reviewed-by: David Hildenbrand <david@redhat.com>

>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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
> index a57096c..376040e 100644
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


--=20

Thanks,

David / dhildenb
