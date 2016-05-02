From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Mon, 2 May 2016 15:34:29 +0200
Message-ID: <20160502133428.GA30059@potion>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

2016-05-02 12:42+0200, Christian Borntraeger:
> Radim, Paolo,
> 
> can you have a look at this patch? If you are ok with it, I want to
> submit this patch with my next s390 pull request. It touches KVM common
> code, but I tried to make it a nop for everything but s390.

(I have few questions and will ack the solution if you stand behind it.)

> Christian
> 
> ----snip----
> 
> 
> Some wakeups should not be considered a sucessful poll. For example on
> s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
> would be considered runnable - letting all vCPUs poll all the time for
> transactional like workload, even if one vCPU would be enough.
> 
> This can result in huge CPU usage for large guests.
> This patch lets architectures provide a way to qualify wakeups if they
> should be considered a good/bad wakeups in regard to polls.
> 
> For s390 the implementation will fence of halt polling for anything but
> known good, single vCPU events. The s390 implementation for floating
> interrupts does a wakeup for one vCPU, but the interrupt will be delivered
> by whatever CPU comes first. To limit the halt polling we only mark the
> woken up CPU as a valid poll. This code will also cover several other
> wakeup reasons like IPI or expired timers. This will of course also mark
> some events as not sucessful. As  KVM on z runs always as a 2nd level
> hypervisor, we prefer to not poll, unless we are really sure, though.
> 
> So we start with a minimal set and will provide additional patches in
> the future that mark additional code paths as valid wakeups, if that
> turns out to be necessary.
> 
> This patch successfully limits the CPU usage for cases like uperf 1byte
> transactional ping pong workload or wakeup heavy workload like OLTP
> while still providing a proper speedup.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> @@ -976,6 +976,14 @@ no_timer:
>  
>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
>  {
> +	/*
> +	 * This is outside of the if because we want to mark the wakeup
> +	 * as valid for vCPUs that
> +	 * a: do polling right now
> +	 * b: do sleep right now
> +	 * otherwise we would never grow the poll interval properly
> +	 */
> +	vcpu_set_valid_wakeup(vcpu);
>  	if (waitqueue_active(&vcpu->wq)) {

(Can't kvm_s390_vcpu_wakeup() be called when the vcpu isn't in
 kvm_vcpu_block()?  Either this condition is useless or we'd the set
 vcpu_set_valid_wakeup() for any future wakeup.)

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> @@ -224,6 +224,7 @@ struct kvm_vcpu {
>  	sigset_t sigset;
>  	struct kvm_vcpu_stat stat;
>  	unsigned int halt_poll_ns;
> +	bool valid_wakeup;
>  
>  #ifdef CONFIG_HAS_IOMEM
>  	int mmio_needed;
> @@ -1178,4 +1179,37 @@ int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
>  				  uint32_t guest_irq, bool set);
>  #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
>  
> +#ifdef CONFIG_HAVE_KVM_INVALID_POLLS
> +/* If we wakeup during the poll time, was it a sucessful poll? */
> +static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)

(smp barriers?)

> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> @@ -41,6 +41,10 @@ config KVM_VFIO
> +config HAVE_KVM_INVALID_POLLS
> +       bool
> +
> +

(One newline is enough.)

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> @@ -2008,7 +2008,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  			 * arrives.
>  			 */
>  			if (kvm_vcpu_check_block(vcpu) < 0) {
> -				++vcpu->stat.halt_successful_poll;
> +				if (vcpu_valid_wakeup(vcpu))
> +					++vcpu->stat.halt_successful_poll;

KVM didn't call schedule(), so it's still a successful poll, IMO, just
invalid.

>  				goto out;
>  			}
>  			cur = ktime_get();
> @@ -2038,14 +2039,16 @@ out:
>  		if (block_ns <= vcpu->halt_poll_ns)
>  			;
>  		/* we had a long block, shrink polling */
> -		else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> +		else if (!vcpu_valid_wakeup(vcpu) ||
> +			(vcpu->halt_poll_ns && block_ns > halt_poll_ns))
>  			shrink_halt_poll_ns(vcpu);

Is the shrinking important?

>  		/* we had a short halt and our poll time is too small */
>  		else if (vcpu->halt_poll_ns < halt_poll_ns &&
> -			block_ns < halt_poll_ns)
> +			block_ns < halt_poll_ns && vcpu_valid_wakeup(vcpu))
>  			grow_halt_poll_ns(vcpu);

IIUC, the problem comes from overgrown halt_poll_ns, so couldn't we just
ignore all invalid wakeups?

It would make more sense to me, because we are not interested in latency
of invalid wakeups, so they shouldn't affect valid ones.

>  	} else
>  		vcpu->halt_poll_ns = 0;
> +	vcpu_reset_wakeup(vcpu);
>  
>  	trace_kvm_vcpu_wakeup(block_ns, waited);

(Tracing valid/invalid wakeups could be useful.)

Thanks.
