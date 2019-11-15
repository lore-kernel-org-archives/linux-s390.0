Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbfKOJDI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 15 Nov 2019 04:03:08 -0500
Subject: Re: [RFC 26/37] KVM: s390: protvirt: Only sync fmt4 registers
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-27-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <197c1218-3171-3e22-caf8-47cdab58caf8@redhat.com>
Date: Fri, 15 Nov 2019 10:02:55 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-27-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> A lot of the registers are controlled by the Ultravisor and never
> visible to KVM. Also some registers are overlayed, like gbea is with
> sidad, which might leak data to userspace.
>=20
> Hence we sync a minimal set of registers for both SIE formats and then
> check and sync format 2 registers if necessary.
>=20
> Also we disable set/get one reg for the same reason. It's an old
> interface anyway.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 138 +++++++++++++++++++++++----------------
>  1 file changed, 82 insertions(+), 56 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 17a78774c617..f623c64aeade 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2997,7 +2997,8 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_=
vcpu *vcpu)
>  =09/* make sure the new fpc will be lazily loaded */
>  =09save_fpu_regs();
>  =09current->thread.fpu.fpc =3D 0;
> -=09vcpu->arch.sie_block->gbea =3D 1;
> +=09if (!kvm_s390_pv_is_protected(vcpu->kvm))
> +=09=09vcpu->arch.sie_block->gbea =3D 1;
>  =09vcpu->arch.sie_block->pp =3D 0;
>  =09vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>  =09vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
> @@ -3367,6 +3368,10 @@ static int kvm_arch_vcpu_ioctl_get_one_reg(struct =
kvm_vcpu *vcpu,
>  =09=09=09     (u64 __user *)reg->addr);
>  =09=09break;
>  =09case KVM_REG_S390_GBEA:
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09r =3D 0;
> +=09=09=09break;
> +=09=09}
>  =09=09r =3D put_user(vcpu->arch.sie_block->gbea,
>  =09=09=09     (u64 __user *)reg->addr);
>  =09=09break;
> @@ -3420,6 +3425,10 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(struct =
kvm_vcpu *vcpu,
>  =09=09=09     (u64 __user *)reg->addr);
>  =09=09break;
>  =09case KVM_REG_S390_GBEA:
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +=09=09=09r =3D 0;
> +=09=09=09break;
> +=09=09}

Wouldn't it be better to return EINVAL in this case? ... the callers
definitely do not get what they expected here...

 Thomas
