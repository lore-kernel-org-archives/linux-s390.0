Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726697AbgAJKgz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 05:36:55 -0500
Subject: Re: [PATCH v6] KVM: s390: Add new reset vcpu API
References: <20200110101906.54291-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9b9c3e09-e3ec-0ef2-0aef-a31ff34df33b@redhat.com>
Date: Fri, 10 Jan 2020 11:36:44 +0100
MIME-Version: 1.0
In-Reply-To: <20200110101906.54291-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 10/01/2020 11.19, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that on a normal reset.
>=20
> Let's implement an interface for the missing normal and clear resets
> and reset all local IRQs, registers and control structures as stated
> in the architecture.
>=20
> Userspace might already reset the registers via the vcpu run struct,
> but as we need the interface for the interrupt clearing part anyway,
> we implement the resets fully and don't rely on userspace to reset the
> rest.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
[...]
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d9e6bf3d54f0..4936f9499291 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -529,6 +529,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  	case KVM_CAP_S390_CMMA_MIGRATION:
>  	case KVM_CAP_S390_AIS:
>  	case KVM_CAP_S390_AIS_MIGRATION:
> +	case KVM_CAP_S390_VCPU_RESETS:
>  		r =3D 1;
>  		break;
>  	case KVM_CAP_S390_HPAGE_1M:
> @@ -2844,35 +2845,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
> =20
>  }
> =20
> -static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
> -{
> -	/* this equals initial cpu reset in pop, but we don't switch to ESA *=
/
> -	vcpu->arch.sie_block->gpsw.mask =3D 0UL;
> -	vcpu->arch.sie_block->gpsw.addr =3D 0UL;
> -	kvm_s390_set_prefix(vcpu, 0);
> -	kvm_s390_set_cpu_timer(vcpu, 0);
> -	vcpu->arch.sie_block->ckc       =3D 0UL;
> -	vcpu->arch.sie_block->todpr     =3D 0;
> -	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
> -	vcpu->arch.sie_block->gcr[0]  =3D CR0_UNUSED_56 |
> -					CR0_INTERRUPT_KEY_SUBMASK |
> -					CR0_MEASUREMENT_ALERT_SUBMASK;
> -	vcpu->arch.sie_block->gcr[14] =3D CR14_UNUSED_32 |
> -					CR14_UNUSED_33 |
> -					CR14_EXTERNAL_DAMAGE_SUBMASK;
> -	/* make sure the new fpc will be lazily loaded */
> -	save_fpu_regs();
> -	current->thread.fpu.fpc =3D 0;
> -	vcpu->arch.sie_block->gbea =3D 1;
> -	vcpu->arch.sie_block->pp =3D 0;
> -	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
> -	vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
> -	kvm_clear_async_pf_completion_queue(vcpu);
> -	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> -		kvm_s390_vcpu_stop(vcpu);
> -	kvm_s390_clear_local_irqs(vcpu);
> -}
> -
>  void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  {
>  	mutex_lock(&vcpu->kvm->lock);
> @@ -3287,10 +3259,78 @@ static int kvm_arch_vcpu_ioctl_set_one_reg(stru=
ct kvm_vcpu *vcpu,
>  	return r;
>  }
> =20
> -static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
> +static void kvm_arch_vcpu_ioctl_normal_reset(struct kvm_vcpu *vcpu)
>  {
> -	kvm_s390_vcpu_initial_reset(vcpu);
> -	return 0;
> +	vcpu->arch.sie_block->gpsw.mask =3D ~PSW_MASK_RI;
> +	vcpu->arch.pfault_token =3D KVM_S390_PFAULT_TOKEN_INVALID;
> +	memset(vcpu->run->s.regs.riccb, 0, sizeof(vcpu->run->s.regs.riccb));
> +
> +	kvm_clear_async_pf_completion_queue(vcpu);
> +	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
> +		kvm_s390_vcpu_stop(vcpu);
> +	kvm_s390_clear_local_irqs(vcpu);
> +}
> +
> +static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
> +{
> +	/* Initial reset is a superset of the normal reset */
> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +
> +	/* this equals initial cpu reset in pop, but we don't switch to ESA *=
/
> +	vcpu->arch.sie_block->gpsw.mask =3D 0UL;
> +	vcpu->arch.sie_block->gpsw.addr =3D 0UL;
> +	kvm_s390_set_prefix(vcpu, 0);
> +	kvm_s390_set_cpu_timer(vcpu, 0);
> +	vcpu->arch.sie_block->ckc       =3D 0UL;
> +	vcpu->arch.sie_block->todpr     =3D 0;
> +	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
> +	vcpu->arch.sie_block->gcr[0]  =3D CR0_UNUSED_56 |
> +					CR0_INTERRUPT_KEY_SUBMASK |
> +					CR0_MEASUREMENT_ALERT_SUBMASK;
> +	vcpu->arch.sie_block->gcr[14] =3D CR14_UNUSED_32 |
> +					CR14_UNUSED_33 |
> +					CR14_EXTERNAL_DAMAGE_SUBMASK;
> +	/* make sure the new fpc will be lazily loaded */
> +	save_fpu_regs();
> +	current->thread.fpu.fpc =3D 0;
> +	vcpu->arch.sie_block->gbea =3D 1;
> +	vcpu->arch.sie_block->pp =3D 0;
> +	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
> +}
> +
> +static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sync_regs *regs =3D &vcpu->run->s.regs;
> +
> +	/* Clear reset is a superset of the initial reset */
> +	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> +
> +	memset(&regs->gprs, 0, sizeof(regs->gprs));
> +	/*
> +	 * Will be picked up via save_fpu_regs() in the initial reset
> +	 * fallthrough.

The word "fallthrough" now likely should be removed from the comment.

Also, I'm not an expert in this lazy-fpu stuff, but don't you rather
have to deal with current->thread.fpu.regs here instead?

> +	 */
> +	memset(&regs->vrs, 0, sizeof(regs->vrs));
> +	memset(&regs->acrs, 0, sizeof(regs->acrs));
> +
> +	regs->etoken =3D 0;
> +	regs->etoken_extension =3D 0;
> +
> +	memset(&regs->gscb, 0, sizeof(regs->gscb));
> +	if (MACHINE_HAS_GS) {
> +		preempt_disable();
> +		__ctl_set_bit(2, 4);
> +		if (current->thread.gs_cb) {
> +			vcpu->arch.host_gscb =3D current->thread.gs_cb;
> +			save_gs_cb(vcpu->arch.host_gscb);
> +		}
> +		if (vcpu->arch.gs_enabled) {
> +			current->thread.gs_cb =3D (struct gs_cb *)
> +				&vcpu->run->s.regs.gscb;
> +			restore_gs_cb(current->thread.gs_cb);
> +		}
> +		preempt_enable();
> +	}
>  }

 Thomas
