Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53217 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727725AbgBIPu0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 9 Feb 2020 10:50:26 -0500
Subject: Re: [PATCH 25/35] KVM: s390: protvirt: Only sync fmt4 registers
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-26-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cbb6ae42-5320-e6cf-214d-a81602a359cf@redhat.com>
Date: Sun, 9 Feb 2020 16:50:11 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-26-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>=20
> A lot of the registers are controlled by the Ultravisor and never
> visible to KVM. Also some registers are overlayed, like gbea is with
> sidad, which might leak data to userspace.
>=20
> Hence we sync a minimal set of registers for both SIE formats and then
> check and sync format 2 registers if necessary.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 116 ++++++++++++++++++++++++---------------
>  1 file changed, 72 insertions(+), 44 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f995040102ea..7df48cc942fd 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3447,9 +3447,11 @@ static void kvm_arch_vcpu_ioctl_initial_reset(st=
ruct kvm_vcpu *vcpu)
>  	vcpu->arch.sie_block->gcr[0] =3D CR0_INITIAL_MASK;
>  	vcpu->arch.sie_block->gcr[14] =3D CR14_INITIAL_MASK;
>  	vcpu->run->s.regs.fpc =3D 0;
> -	vcpu->arch.sie_block->gbea =3D 1;
> -	vcpu->arch.sie_block->pp =3D 0;
> -	vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
> +	if (!kvm_s390_pv_handle_cpu(vcpu)) {
> +		vcpu->arch.sie_block->gbea =3D 1;
> +		vcpu->arch.sie_block->pp =3D 0;
> +		vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
> +	}

Technically, this part is not about sync'ing but about reset ... worth
to mention this in the patch description, too? (or maybe even move to
the reset patch 34/35 or a new patch?)

And what about vcpu->arch.sie_block->todpr ? Should that be moved into
the if-statement, too?

>  }
> =20
>  static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
> @@ -4060,25 +4062,16 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  	return rc;
>  }
> =20
> -static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_=
run)
>  {
>  	struct runtime_instr_cb *riccb;
>  	struct gs_cb *gscb;
> =20
> -	riccb =3D (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
> -	gscb =3D (struct gs_cb *) &kvm_run->s.regs.gscb;
>  	vcpu->arch.sie_block->gpsw.mask =3D kvm_run->psw_mask;
>  	vcpu->arch.sie_block->gpsw.addr =3D kvm_run->psw_addr;
> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
> -		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
> -		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
> -		/* some control register changes require a tlb flush */
> -		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> -	}
> +	riccb =3D (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
> +	gscb =3D (struct gs_cb *) &kvm_run->s.regs.gscb;

You could leave the riccb and gscb lines at the beginning to make the
diff a little bit nicer.

>  	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
> -		kvm_s390_set_cpu_timer(vcpu, kvm_run->s.regs.cputm);
> -		vcpu->arch.sie_block->ckc =3D kvm_run->s.regs.ckc;
>  		vcpu->arch.sie_block->todpr =3D kvm_run->s.regs.todpr;
>  		vcpu->arch.sie_block->pp =3D kvm_run->s.regs.pp;
>  		vcpu->arch.sie_block->gbea =3D kvm_run->s.regs.gbea;
> @@ -4119,6 +4112,47 @@ static void sync_regs(struct kvm_vcpu *vcpu, str=
uct kvm_run *kvm_run)
>  		vcpu->arch.sie_block->fpf &=3D ~FPF_BPBC;
>  		vcpu->arch.sie_block->fpf |=3D kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
>  	}
> +	if (MACHINE_HAS_GS) {
> +		preempt_disable();
> +		__ctl_set_bit(2, 4);
> +		if (current->thread.gs_cb) {
> +			vcpu->arch.host_gscb =3D current->thread.gs_cb;
> +			save_gs_cb(vcpu->arch.host_gscb);
> +		}
> +		if (vcpu->arch.gs_enabled) {
> +			current->thread.gs_cb =3D (struct gs_cb *)
> +						&vcpu->run->s.regs.gscb;
> +			restore_gs_cb(current->thread.gs_cb);
> +		}
> +		preempt_enable();
> +	}
> +	/* SIE will load etoken directly from SDNX and therefore kvm_run */
> +}
> +
> +static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> +{
> +	/*
> +	 * at several places we have to modify our internal view to not do
> +	 * things that are disallowed by the ultravisor. For example we must
> +	 * not inject interrupts after specific exits (e.g. 112). We do this
> +	 * by turning off the MIE bits of our PSW copy. To avoid getting
> +	 * validity intercepts, we do only accept the condition code from
> +	 * userspace.
> +	 */
> +	vcpu->arch.sie_block->gpsw.mask &=3D ~PSW_MASK_CC;
> +	vcpu->arch.sie_block->gpsw.mask |=3D kvm_run->psw_mask & PSW_MASK_CC;

I think it would be cleaner to only do this for protected guests. You
could combine it with the call to sync_regs_fmt2():

	if (likely(!kvm_s390_pv_is_protected(vcpu->kvm))) {
		sync_regs_fmt2(vcpu, kvm_run);
	} else {
		vcpu->arch.sie_block->gpsw.mask &=3D ~PSW_MASK_CC;
		vcpu->arch.sie_block->gpsw.mask |=3D kvm_run->psw_mask &
						   PSW_MASK_CC;
	}

> +	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
> +		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
> +	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
> +		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
> +		/* some control register changes require a tlb flush */
> +		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +	}
> +	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
> +		kvm_s390_set_cpu_timer(vcpu, kvm_run->s.regs.cputm);
> +		vcpu->arch.sie_block->ckc =3D kvm_run->s.regs.ckc;
> +	}
>  	save_access_regs(vcpu->arch.host_acrs);
>  	restore_access_regs(vcpu->run->s.regs.acrs);
>  	/* save host (userspace) fprs/vrs */
> @@ -4133,23 +4167,31 @@ static void sync_regs(struct kvm_vcpu *vcpu, st=
ruct kvm_run *kvm_run)
>  	if (test_fp_ctl(current->thread.fpu.fpc))
>  		/* User space provided an invalid FPC, let's clear it */
>  		current->thread.fpu.fpc =3D 0;
> +
> +	/* Sync fmt2 only data */
> +	if (likely(!kvm_s390_pv_is_protected(vcpu->kvm)))
> +		sync_regs_fmt2(vcpu, kvm_run);
> +	kvm_run->kvm_dirty_regs =3D 0;
> +}
> +
> +static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm=
_run)
> +{
> +	kvm_run->s.regs.pp =3D vcpu->arch.sie_block->pp;
> +	kvm_run->s.regs.gbea =3D vcpu->arch.sie_block->gbea;
> +	kvm_run->s.regs.bpbc =3D (vcpu->arch.sie_block->fpf & FPF_BPBC) =3D=3D=
 FPF_BPBC;
>  	if (MACHINE_HAS_GS) {
> -		preempt_disable();
>  		__ctl_set_bit(2, 4);
> -		if (current->thread.gs_cb) {
> -			vcpu->arch.host_gscb =3D current->thread.gs_cb;
> -			save_gs_cb(vcpu->arch.host_gscb);
> -		}
> -		if (vcpu->arch.gs_enabled) {
> -			current->thread.gs_cb =3D (struct gs_cb *)
> -						&vcpu->run->s.regs.gscb;
> -			restore_gs_cb(current->thread.gs_cb);
> -		}
> +		if (vcpu->arch.gs_enabled)
> +			save_gs_cb(current->thread.gs_cb);
> +		preempt_disable();
> +		current->thread.gs_cb =3D vcpu->arch.host_gscb;
> +		restore_gs_cb(vcpu->arch.host_gscb);
>  		preempt_enable();
> +		if (!vcpu->arch.host_gscb)
> +			__ctl_clear_bit(2, 4);
> +		vcpu->arch.host_gscb =3D NULL;
>  	}
> -	/* SIE will load etoken directly from SDNX and therefore kvm_run */
> -
> -	kvm_run->kvm_dirty_regs =3D 0;
> +	/* SIE will save etoken directly into SDNX and therefore kvm_run */
>  }
> =20
>  static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
> @@ -4161,12 +4203,9 @@ static void store_regs(struct kvm_vcpu *vcpu, st=
ruct kvm_run *kvm_run)
>  	kvm_run->s.regs.cputm =3D kvm_s390_get_cpu_timer(vcpu);
>  	kvm_run->s.regs.ckc =3D vcpu->arch.sie_block->ckc;
>  	kvm_run->s.regs.todpr =3D vcpu->arch.sie_block->todpr;

TODPR handling has been move from sync_regs() to sync_regs_fmt2() ...
should this here move from store_regs() to store_regs_fmt2(), too?

And maybe you should also not read the sie_block->gpsw.addr (and some of
the control registers) field in store_regs() either, i.e. move the lines
to store_regs_fmt2()?

> -	kvm_run->s.regs.pp =3D vcpu->arch.sie_block->pp;
> -	kvm_run->s.regs.gbea =3D vcpu->arch.sie_block->gbea;
>  	kvm_run->s.regs.pft =3D vcpu->arch.pfault_token;
>  	kvm_run->s.regs.pfs =3D vcpu->arch.pfault_select;
>  	kvm_run->s.regs.pfc =3D vcpu->arch.pfault_compare;
> -	kvm_run->s.regs.bpbc =3D (vcpu->arch.sie_block->fpf & FPF_BPBC) =3D=3D=
 FPF_BPBC;
>  	save_access_regs(vcpu->run->s.regs.acrs);
>  	restore_access_regs(vcpu->arch.host_acrs);
>  	/* Save guest register state */
> @@ -4175,19 +4214,8 @@ static void store_regs(struct kvm_vcpu *vcpu, st=
ruct kvm_run *kvm_run)
>  	/* Restore will be done lazily at return */
>  	current->thread.fpu.fpc =3D vcpu->arch.host_fpregs.fpc;
>  	current->thread.fpu.regs =3D vcpu->arch.host_fpregs.regs;
> -	if (MACHINE_HAS_GS) {
> -		__ctl_set_bit(2, 4);
> -		if (vcpu->arch.gs_enabled)
> -			save_gs_cb(current->thread.gs_cb);
> -		preempt_disable();
> -		current->thread.gs_cb =3D vcpu->arch.host_gscb;
> -		restore_gs_cb(vcpu->arch.host_gscb);
> -		preempt_enable();
> -		if (!vcpu->arch.host_gscb)
> -			__ctl_clear_bit(2, 4);
> -		vcpu->arch.host_gscb =3D NULL;
> -	}
> -	/* SIE will save etoken directly into SDNX and therefore kvm_run */
> +	if (likely(!kvm_s390_pv_is_protected(vcpu->kvm)))
> +		store_regs_fmt2(vcpu, kvm_run);
>  }
> =20
>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm=
_run)
>=20

 Thomas
