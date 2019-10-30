Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbfJ3Pus (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Oct 2019 11:50:48 -0400
Subject: Re: [RFC 12/37] KVM: s390: protvirt: Handle SE notification
 interceptions
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-13-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a3d3923a-4047-9d6e-8caf-a07c294e8c7a@redhat.com>
Date: Wed, 30 Oct 2019 16:50:40 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-13-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> Since KVM doesn't emulate any form of load control and load psw
> instructions anymore, we wouldn't get an interception if PSWs or CRs
> are changed in the guest. That means we can't inject IRQs right after
> the guest is enabled for them.
>=20
> The new interception codes solve that problem by being a notification
> for changes to IRQ enablement relevant bits in CRs 0, 6 and 14, as
> well a the machine check mask bit in the PSW.
>=20
> No special handling is needed for these interception codes, the KVM
> pre-run code will consult all necessary CRs and PSW bits and inject
> IRQs the guest is enabled for.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  2 ++
>   arch/s390/kvm/intercept.c        | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index d4fd0f3af676..6cc3b73ca904 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -210,6 +210,8 @@ struct kvm_s390_sie_block {
>   #define ICPT_PARTEXEC=090x38
>   #define ICPT_IOINST=090x40
>   #define ICPT_KSS=090x5c
> +#define ICPT_PV_MCHKR=090x60
> +#define ICPT_PV_INT_EN=090x64
>   =09__u8=09icptcode;=09=09/* 0x0050 */
>   =09__u8=09icptstatus;=09=09/* 0x0051 */
>   =09__u16=09ihcpu;=09=09=09/* 0x0052 */
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index a389fa85cca2..acc1710fc472 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -480,6 +480,24 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>   =09case ICPT_KSS:
>   =09=09rc =3D kvm_s390_skey_check_enable(vcpu);
>   =09=09break;
> +=09case ICPT_PV_MCHKR:
> +=09=09/*
> +=09=09 * A protected guest changed PSW bit 13 to one and is now
> +=09=09 * enabled for interrupts. The pre-run code will check
> +=09=09 * the registers and inject pending MCHKs based on the
> +=09=09 * PSW and CRs. No additional work to do.
> +=09=09 */
> +=09=09rc =3D 0;
> +=09=09break;
> +=09case  ICPT_PV_INT_EN:
> +=09=09/*
> +=09=09 * A protected guest changed CR 0,6,14 and may now be
> +=09=09 * enabled for interrupts. The pre-run code will check
> +=09=09 * the registers and inject pending IRQs based on the
> +=09=09 * CRs. No additional work to do.
> +=09=09 */
> +=09=09rc =3D 0;
> +=09break;

Wrong indentation.

Maybe simply

case ICPT_PV_MCHKR:
ICPT_PV_INT_EN:
=09/*
=09 * PSW bit 13 or a CR (0, 6, 14) changed and we might now be
          * able to deliver interrupts. pre-run code will take care of
          * this.
=09 */
=09rc =3D 0;
=09break;

--=20

Thanks,

David / dhildenb
