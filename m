Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26114 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfKDLZw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 06:25:52 -0500
Subject: Re: [RFC 19/37] KVM: s390: protvirt: Add new gprs location handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-20-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2eba24a5-063d-1e93-acf0-1153963facfe@redhat.com>
Date: Mon, 4 Nov 2019 12:25:43 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-20-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24.10.19 13:40, Janosch Frank wrote:
> Guest registers for protected guests are stored at offset 0x380.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |  4 +++-
>   arch/s390/kvm/kvm-s390.c         | 11 +++++++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 0ab309b7bf4c..5deabf9734d9 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -336,7 +336,9 @@ struct kvm_s390_itdb {
>   struct sie_page {
>   =09struct kvm_s390_sie_block sie_block;
>   =09struct mcck_volatile_info mcck_info;=09/* 0x0200 */
> -=09__u8 reserved218[1000];=09=09/* 0x0218 */
> +=09__u8 reserved218[360];=09=09/* 0x0218 */
> +=09__u64 pv_grregs[16];=09=09/* 0x380 */
> +=09__u8 reserved400[512];
>   =09struct kvm_s390_itdb itdb;=09/* 0x0600 */
>   =09__u8 reserved700[2304];=09=09/* 0x0700 */
>   };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 490fde080107..97d3a81e5074 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3965,6 +3965,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int=
 exit_reason)
>   static int __vcpu_run(struct kvm_vcpu *vcpu)
>   {
>   =09int rc, exit_reason;
> +=09struct sie_page *sie_page =3D (struct sie_page *)vcpu->arch.sie_block=
;
>  =20
>   =09/*
>   =09 * We try to hold kvm->srcu during most of vcpu_run (except when run=
-
> @@ -3986,8 +3987,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>   =09=09guest_enter_irqoff();
>   =09=09__disable_cpu_timer_accounting(vcpu);
>   =09=09local_irq_enable();
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09memcpy(sie_page->pv_grregs,
> +=09=09=09       vcpu->run->s.regs.gprs,
> +=09=09=09       sizeof(sie_page->pv_grregs));
> +=09=09}
>   =09=09exit_reason =3D sie64a(vcpu->arch.sie_block,
>   =09=09=09=09     vcpu->run->s.regs.gprs);
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09memcpy(vcpu->run->s.regs.gprs,
> +=09=09=09       sie_page->pv_grregs,
> +=09=09=09       sizeof(sie_page->pv_grregs));
> +=09=09}

sie64a will load/save gprs 0-13 from to vcpu->run->s.regs.gprs.

I would have assume that this is not required for prot virt, because the=20
HW has direct access via the sie block?


1. Would it make sense to have a specialized sie64a() (or a parameter,=20
e.g., if you pass in NULL in r3), that optimizes this loading/saving?=20
Eventually we can also optimize which host registers to save/restore then.

2. Avoid this copying here. We have to store the state to=20
vcpu->run->s.regs.gprs when returning to user space and restore the=20
state when coming from user space.

Also, we access the GPRS from interception handlers, there we might use=20
wrappers like

kvm_s390_set_gprs()
kvm_s390_get_gprs()

to route to the right location. There are multiple options to optimize this=
.

--=20

Thanks,

David / dhildenb
