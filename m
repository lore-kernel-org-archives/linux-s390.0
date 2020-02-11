Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52112 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgBKMAi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 07:00:38 -0500
Subject: Re: [PATCH 16/35] KVM: s390: protvirt: Add SCLP interrupt handling
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-17-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dbeb32f7-7cf5-ad93-fb79-94d4ac7e3d8c@redhat.com>
Date: Tue, 11 Feb 2020 13:00:24 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-17-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> The sclp interrupt is kind of special. The ultravisor polices that we
> do not inject an sclp interrupt with payload if no sccb is outstanding.
> On the other hand we have "asynchronous" event interrupts, e.g. for
> console input.
> We separate both variants into sclp interrupt and sclp event interrupt.
> The sclp interrupt is masked until a previous servc instruction has
> finished (sie exit 108).
> 
> [frankja@linux.ibm.com: factoring out write_sclp]
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
[...]
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index e5ee52e33d96..c28fa09cb557 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -325,8 +325,11 @@ static inline int gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  
>  static inline unsigned long pending_irqs_no_gisa(struct kvm_vcpu *vcpu)
>  {
> -	return vcpu->kvm->arch.float_int.pending_irqs |
> -		vcpu->arch.local_int.pending_irqs;
> +	unsigned long pending = vcpu->kvm->arch.float_int.pending_irqs |
> +				vcpu->arch.local_int.pending_irqs;
> +
> +	pending &= ~vcpu->kvm->arch.float_int.masked_irqs;
> +	return pending;
>  }
>  
>  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
> @@ -384,8 +387,10 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
>  		__clear_bit(IRQ_PEND_EXT_CLOCK_COMP, &active_mask);
>  	if (!(vcpu->arch.sie_block->gcr[0] & CR0_CPU_TIMER_SUBMASK))
>  		__clear_bit(IRQ_PEND_EXT_CPU_TIMER, &active_mask);
> -	if (!(vcpu->arch.sie_block->gcr[0] & CR0_SERVICE_SIGNAL_SUBMASK))
> +	if (!(vcpu->arch.sie_block->gcr[0] & CR0_SERVICE_SIGNAL_SUBMASK)) {
>  		__clear_bit(IRQ_PEND_EXT_SERVICE, &active_mask);
> +		__clear_bit(IRQ_PEND_EXT_SERVICE_EV, &active_mask);
> +	}
>  	if (psw_mchk_disabled(vcpu))
>  		active_mask &= ~IRQ_PEND_MCHK_MASK;
>  	/* PV guest cpus can have a single interruption injected at a time. */
> @@ -947,6 +952,31 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>  	return rc ? -EFAULT : 0;
>  }
>  
> +#define SCCB_MASK 0xFFFFFFF8
> +#define SCCB_EVENT_PENDING 0x3
> +
> +static int write_sclp(struct kvm_vcpu *vcpu, u32 parm)
> +{
> +	int rc;
> +
> +	if (kvm_s390_pv_handle_cpu(vcpu)) {
> +		vcpu->arch.sie_block->iictl = IICTL_CODE_EXT;
> +		vcpu->arch.sie_block->eic = EXT_IRQ_SERVICE_SIG;
> +		vcpu->arch.sie_block->eiparams = parm;
> +		return 0;
> +	}
> +
> +	rc  = put_guest_lc(vcpu, EXT_IRQ_SERVICE_SIG, (u16 *)__LC_EXT_INT_CODE);
> +	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
> +	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
> +			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
> +			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> +	rc |= put_guest_lc(vcpu, parm,
> +			   (u32 *)__LC_EXT_PARAMS);
> +	return rc;

I think it would be nicer to move the "return rc ? -EFAULT : 0;" here
instead of using it in the __deliver_service* functions...

> +}
> +
>  static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
> @@ -954,13 +984,17 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
>  	int rc = 0;
>  
>  	spin_lock(&fi->lock);
> -	if (!(test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs))) {
> +	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs) ||
> +	    !(test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs))) {
>  		spin_unlock(&fi->lock);
>  		return 0;
>  	}
>  	ext = fi->srv_signal;
>  	memset(&fi->srv_signal, 0, sizeof(ext));
>  	clear_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs);
> +	clear_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs);
> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
> +		set_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
>  	spin_unlock(&fi->lock);
>  
>  	VCPU_EVENT(vcpu, 4, "deliver: sclp parameter 0x%x",
> @@ -969,15 +1003,33 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
>  	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_SERVICE,
>  					 ext.ext_params, 0);
>  
> -	rc  = put_guest_lc(vcpu, EXT_IRQ_SERVICE_SIG, (u16 *)__LC_EXT_INT_CODE);
> -	rc |= put_guest_lc(vcpu, 0, (u16 *)__LC_EXT_CPU_ADDR);
> -	rc |= write_guest_lc(vcpu, __LC_EXT_OLD_PSW,
> -			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> -	rc |= read_guest_lc(vcpu, __LC_EXT_NEW_PSW,
> -			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
> -	rc |= put_guest_lc(vcpu, ext.ext_params,
> -			   (u32 *)__LC_EXT_PARAMS);
> +	rc = write_sclp(vcpu, ext.ext_params);
> +	return rc ? -EFAULT : 0;

... i.e. use "return write_sclp(...)" here...

> +}
> +
> +static int __must_check __deliver_service_ev(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
> +	struct kvm_s390_ext_info ext;
> +	int rc = 0;
> +
> +	spin_lock(&fi->lock);
> +	if (!(test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs))) {
> +		spin_unlock(&fi->lock);
> +		return 0;
> +	}
> +	ext = fi->srv_signal;
> +	/* only clear the event bit */
> +	fi->srv_signal.ext_params &= ~SCCB_EVENT_PENDING;
> +	clear_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs);
> +	spin_unlock(&fi->lock);
> +
> +	VCPU_EVENT(vcpu, 4, "%s", "deliver: sclp parameter event");
> +	vcpu->stat.deliver_service_signal++;
> +	trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, KVM_S390_INT_SERVICE,
> +					 ext.ext_params, 0);
>  
> +	rc = write_sclp(vcpu, SCCB_EVENT_PENDING);
>  	return rc ? -EFAULT : 0;
>  }

... and here.

Apart from that, patch looks ok to me.

 Thomas
