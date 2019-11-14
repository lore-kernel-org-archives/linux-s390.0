Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38288 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726473AbfKNPic (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 10:38:32 -0500
Date: Thu, 14 Nov 2019 16:38:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 21/37] KVM: S390: protvirt: Instruction emulation
Message-ID: <20191114163819.4fb4bed1.cohuck@redhat.com>
In-Reply-To: <20191024114059.102802-22-frankja@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-22-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On Thu, 24 Oct 2019 07:40:43 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> We have two new SIE exit codes 104 for a secure instruction
> interception, on which the SIE needs hypervisor action to complete the
> instruction.
>=20
> And 108 which is merely a notification and provides data for tracking
> and management, like for the lowcore we set notification bits for the
> lowcore pages.

What about the following:

"With protected virtualization, we have two new SIE exit codes:

- 104 indicates a secure instruction interception; the hypervisor needs
  to complete emulation of the instruction.
- 108 is merely a notification providing data for tracking and
  management in the hypervisor; for example, we set notification bits
  for the lowcore pages."

?

>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  2 ++
>  arch/s390/kvm/intercept.c        | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm=
_host.h
> index 2a8a1e21e1c3..a42dfe98128b 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -212,6 +212,8 @@ struct kvm_s390_sie_block {
>  #define ICPT_KSS=090x5c
>  #define ICPT_PV_MCHKR=090x60
>  #define ICPT_PV_INT_EN=090x64
> +#define ICPT_PV_INSTR=090x68
> +#define ICPT_PV_NOT=090x6c

Maybe ICPT_PV_NOTIF?

>  =09__u8=09icptcode;=09=09/* 0x0050 */
>  =09__u8=09icptstatus;=09=09/* 0x0051 */
>  =09__u16=09ihcpu;=09=09=09/* 0x0052 */
> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index b013a9c88d43..a1df8a43c88b 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -451,6 +451,23 @@ static int handle_operexc(struct kvm_vcpu *vcpu)
>  =09return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
>  }
> =20
> +static int handle_pv_spx(struct kvm_vcpu *vcpu)
> +{
> +=09u32 pref =3D *(u32 *)vcpu->arch.sie_block->sidad;
> +
> +=09kvm_s390_set_prefix(vcpu, pref);
> +=09trace_kvm_s390_handle_prefix(vcpu, 1, pref);
> +=09return 0;
> +}
> +
> +static int handle_pv_not(struct kvm_vcpu *vcpu)
> +{
> +=09if (vcpu->arch.sie_block->ipa =3D=3D 0xb210)
> +=09=09return handle_pv_spx(vcpu);
> +
> +=09return handle_instruction(vcpu);

Hm... if I understood it correctly, we are getting this one because the
SIE informs us about things that it handled itself (but which we
should be aware of). What can handle_instruction() do in this case?

> +}
> +
>  int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>  {
>  =09int rc, per_rc =3D 0;
> @@ -505,6 +522,12 @@ int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
>  =09=09 */
>  =09=09rc =3D 0;
>  =09break;
> +=09case ICPT_PV_INSTR:
> +=09=09rc =3D handle_instruction(vcpu);
> +=09=09break;
> +=09case ICPT_PV_NOT:
> +=09=09rc =3D handle_pv_not(vcpu);
> +=09=09break;
>  =09default:
>  =09=09return -EOPNOTSUPP;
>  =09}
