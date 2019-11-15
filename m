Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727065AbfKOKsJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 05:48:09 -0500
Subject: Re: [RFC 33/37] KVM: s390: Introduce VCPU reset IOCTL
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-34-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e7a62927-7e0e-1309-d5ad-b4a59149bb6a@redhat.com>
Date: Fri, 15 Nov 2019 11:47:56 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-34-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 24/10/2019 13.40, Janosch Frank wrote:
> With PV we need to do things for all reset types, not only initial...
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h |  6 +++++
>  2 files changed, 59 insertions(+)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d3fd3ad1d09b..d8ee3a98e961 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3472,6 +3472,53 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struc=
t kvm_vcpu *vcpu)
>  =09return 0;
>  }
> =20
> +static int kvm_arch_vcpu_ioctl_reset(struct kvm_vcpu *vcpu,
> +=09=09=09=09     unsigned long type)
> +{
> +=09int rc;
> +=09u32 ret;
> +
> +=09switch (type) {
> +=09case KVM_S390_VCPU_RESET_NORMAL:
> +=09=09/*
> +=09=09 * Only very little is reset, userspace handles the
> +=09=09 * non-protected case.
> +=09=09 */
> +=09=09rc =3D 0;
> +=09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
> +=09=09=09rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
> +=09=09=09=09=09   UVC_CMD_CPU_RESET, &ret);
> +=09=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET NORMAL VCPU: cpu %d rc %x r=
rc %x",
> +=09=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
> +=09=09}
> +=09=09break;
> +=09case KVM_S390_VCPU_RESET_INITIAL:
> +=09=09rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> +=09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
> +=09=09=09uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
> +=09=09=09=09      UVC_CMD_CPU_RESET_INITIAL,
> +=09=09=09=09      &ret);
> +=09=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET INITIAL VCPU: cpu %d rc %x =
rrc %x",
> +=09=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
> +=09=09}
> +=09=09break;
> +=09case KVM_S390_VCPU_RESET_CLEAR:
> +=09=09rc =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
> +=09=09if (kvm_s390_pv_handle_cpu(vcpu)) {
> +=09=09=09rc =3D uv_cmd_nodata(kvm_s390_pv_handle_cpu(vcpu),
> +=09=09=09=09=09   UVC_CMD_CPU_RESET_CLEAR, &ret);
> +=09=09=09VCPU_EVENT(vcpu, 3, "PROTVIRT RESET CLEAR VCPU: cpu %d rc %x rr=
c %x",
> +=09=09=09=09   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
> +=09=09}
> +=09=09break;
> +=09default:
> +=09=09rc =3D -EINVAL;
> +=09=09break;

(nit: you could drop the "break;" here)

> +=09}
> +=09return rc;
> +}
> +
> +
>  int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs =
*regs)
>  {
>  =09vcpu_load(vcpu);
> @@ -4633,8 +4680,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  =09=09break;
>  =09}
>  =09case KVM_S390_INITIAL_RESET:
> +=09=09r =3D -EINVAL;
> +=09=09if (kvm_s390_pv_is_protected(vcpu->kvm))
> +=09=09=09break;

Wouldn't it be nicer to call

  kvm_arch_vcpu_ioctl_reset(vcpu, KVM_S390_VCPU_RESET_INITIAL)

in this case instead?

>  =09=09r =3D kvm_arch_vcpu_ioctl_initial_reset(vcpu);
>  =09=09break;
> +=09case KVM_S390_VCPU_RESET:
> +=09=09r =3D kvm_arch_vcpu_ioctl_reset(vcpu, arg);
> +=09=09break;
>  =09case KVM_SET_ONE_REG:
>  =09case KVM_GET_ONE_REG: {
>  =09=09struct kvm_one_reg reg;
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index f75a051a7705..2846ed5e5dd9 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1496,6 +1496,12 @@ struct kvm_pv_cmd {
>  #define KVM_S390_PV_COMMAND=09=09_IOW(KVMIO, 0xc3, struct kvm_pv_cmd)
>  #define KVM_S390_PV_COMMAND_VCPU=09_IOW(KVMIO, 0xc4, struct kvm_pv_cmd)
> =20
> +#define KVM_S390_VCPU_RESET_NORMAL=090
> +#define KVM_S390_VCPU_RESET_INITIAL=091
> +#define KVM_S390_VCPU_RESET_CLEAR=092
> +
> +#define KVM_S390_VCPU_RESET    _IO(KVMIO,   0xd0)

Why not 0xc5 ?

 Thomas
