From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [GIT PULL 10/11] KVM: s390: handle pending local interrupts via
 bitmap
Date: Mon, 1 Dec 2014 09:19:16 +0100
Message-ID: <20141201081916.GA4074@osiris>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
 <1417181139-25623-11-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417181139-25623-11-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Nov 28, 2014 at 02:25:38PM +0100, Christian Borntraeger wrote:
> +static int __must_check __deliver_mchk_floating(struct kvm_vcpu *vcpu,
> +					   struct kvm_s390_interrupt_info *inti)
> +{
> +	struct kvm_s390_mchk_info *mchk = &inti->mchk;
> +	int rc;
> +
> +	VCPU_EVENT(vcpu, 4, "interrupt: machine check mcic=%llx",
> +		   mchk->mcic);
> +	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_MCHK,
> +					 mchk->cr14, mchk->mcic);
> +
> +	rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
> +	rc |= put_guest_lc(vcpu, mchk->mcic,
> +			(u64 __user *) __LC_MCCK_CODE);
> +	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
> +			(u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
> +	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
> +			     &mchk->fixed_logout, sizeof(mchk->fixed_logout));
> +	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
> +			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
> +			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +	return rc;
> +}

FWIW, rc handling seems to be a bit fragile.
The usual return statement for such a pattern is
	return rc ? -EWHATEVER : 0;
so we don't get random or'ed return values.

> -static int __inject_prog_irq(struct kvm_vcpu *vcpu,
> -			     struct kvm_s390_interrupt_info *inti)
> +static int __inject_prog(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
>  {
>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>  
> -	list_add(&inti->list, &li->list);
> -	atomic_set(&li->active, 1);
> +	li->irq.pgm = irq->u.pgm;
> +	__set_bit(IRQ_PEND_PROG, &li->pending_irqs);

        ^^^^^^^^^

> +static int __inject_pfault_init(struct kvm_vcpu *vcpu, struct kvm_s390_irq *irq)
>  {
>  	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>  
> -	inti->ext.ext_params2 = s390int->parm64;
> -	list_add_tail(&inti->list, &li->list);
> -	atomic_set(&li->active, 1);
> +	VCPU_EVENT(vcpu, 3, "inject: external irq params:%x, params2:%llx",
> +		   irq->u.ext.ext_params, irq->u.ext.ext_params2);
> +	trace_kvm_s390_inject_vcpu(vcpu->vcpu_id, KVM_S390_INT_PFAULT_INIT,
> +				   irq->u.ext.ext_params,
> +				   irq->u.ext.ext_params2, 2);
> +
> +	li->irq.ext = irq->u.ext;
> +	set_bit(IRQ_PEND_PFAULT_INIT, &li->pending_irqs);

        ^^^^^^^

You're using atomic and non-atomic bitops all over the place on the same
object(s). It would be very good to have some consistency here.
And as far as I remember the non-atomic variant is good enough anyway.
