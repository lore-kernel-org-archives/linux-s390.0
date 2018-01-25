From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 15:20:43 +0100
Message-ID: <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-7-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-7-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 14:28, Christian Borntraeger wrote:
> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The adapter interruption virtualization (AIV) facility is an
> optional facility that comes with functionality expected to increase
> the performance of adapter interrupt handling for both emulated and
> passed-through adapter interrupts. With AIV, adapter interrupts can be
> delivered to the guest without exiting SIE.
> 
> This patch provides some preparations for using AIV for emulated adapter
> interrupts (inclusive virtio) if it's available. When using AIV, the
> interrupts are delivered at the so called GISA by setting the bit
> corresponding to its Interruption Subclass (ISC) in the Interruption
> Pending Mask (IPM) instead of inserting a node into the floating interrupt
> list.
> 
> To keep the change reasonably small, the handling of this new state is
> deferred in get_all_floating_irqs and handle_tpi. This patch concentrates
> on the code handling enqueuement of emulated adapter interrupts, and their
> delivery to the guest.
> 
> Note that care is still required for adapter interrupts using AIV,
> because there is no guarantee that AIV is going to deliver the adapter
> interrupts pending at the GISA (consider all vcpus idle). When delivering
> GISA adapter interrupts by the host (usual mechanism) special attention
> is required to honor interrupt priorities.
> 
> Empirical results show that the time window between making an interrupt
> pending at the GISA and doing kvm_s390_deliver_pending_interrupts is
> sufficient for a guest with at least moderate cpu activity to get adapter
> interrupts delivered within the SIE, and potentially save some SIE exits
> (if not other deliverable interrupts).
> 
> The code will be activated with a follow-up patch.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |   1 +
>  arch/s390/kvm/interrupt.c        | 106 +++++++++++++++++++++++++++++++--------
>  arch/s390/kvm/kvm-s390.c         |   8 +++
>  arch/s390/kvm/kvm-s390.h         |   3 ++
>  4 files changed, 98 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 77acade..6802d5d 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -772,6 +772,7 @@ struct kvm_arch{
>  	struct kvm_s390_migration_state *migration_state;
>  	/* subset of available cpu features enabled by user space */
>  	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
> +	struct kvm_s390_gisa *gisa;
>  };
>  
>  #define KVM_HVA_ERR_BAD		(-1UL)
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index d559776..263cd10 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -228,7 +228,8 @@ static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gis
>  static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>  {
>  	return vcpu->kvm->arch.float_int.pending_irqs |
> -	       vcpu->arch.local_int.pending_irqs;
> +		vcpu->arch.local_int.pending_irqs |
> +		kvm_s390_gisa_get_ipm(vcpu->kvm->arch.gisa) << IRQ_PEND_IO_ISC_7;
>  }
>  
>  static inline int isc_to_irq_type(unsigned long isc)
> @@ -918,18 +919,38 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
>  	return rc ? -EFAULT : 0;
>  }
>  
> +static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
> +{
> +	int rc;
> +
> +	rc  = put_guest_lc(vcpu, io->subchannel_id, (u16 *)__LC_SUBCHANNEL_ID);
> +	rc |= put_guest_lc(vcpu, io->subchannel_nr, (u16 *)__LC_SUBCHANNEL_NR);
> +	rc |= put_guest_lc(vcpu, io->io_int_parm, (u32 *)__LC_IO_INT_PARM);
> +	rc |= put_guest_lc(vcpu, io->io_int_word, (u32 *)__LC_IO_INT_WORD);
> +	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
> +			     &vcpu->arch.sie_block->gpsw,
> +			     sizeof(psw_t));
> +	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
> +			    &vcpu->arch.sie_block->gpsw,
> +			    sizeof(psw_t));

These should now it into less lines. Can you factor that change out into
a separate patch?

> +	return rc ? -EFAULT : 0;
> +}
> +
>  static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
>  				     unsigned long irq_type)
>  {
>  	struct list_head *isc_list;
>  	struct kvm_s390_float_interrupt *fi;
>  	struct kvm_s390_interrupt_info *inti = NULL;
> +	struct kvm_s390_io_info io;
> +	u32 isc;
>  	int rc = 0;
>  
>  	fi = &vcpu->kvm->arch.float_int;
>  
>  	spin_lock(&fi->lock);
> -	isc_list = &fi->lists[irq_type_to_isc(irq_type)];
> +	isc = irq_type_to_isc(irq_type);
> +	isc_list = &fi->lists[isc];
>  	inti = list_first_entry_or_null(isc_list,
>  					struct kvm_s390_interrupt_info,
>  					list);
> @@ -957,24 +978,32 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
>  	spin_unlock(&fi->lock);
>  
>  	if (inti) {
> -		rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
> -				(u16 *)__LC_SUBCHANNEL_ID);
> -		rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
> -				(u16 *)__LC_SUBCHANNEL_NR);
> -		rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
> -				(u32 *)__LC_IO_INT_PARM);
> -		rc |= put_guest_lc(vcpu, inti->io.io_int_word,
> -				(u32 *)__LC_IO_INT_WORD);
> -		rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
> -				&vcpu->arch.sie_block->gpsw,
> -				sizeof(psw_t));
> -		rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
> -				&vcpu->arch.sie_block->gpsw,
> -				sizeof(psw_t));
> +		rc = __do_deliver_io(vcpu, &(inti->io));
>  		kfree(inti);
> +		goto out;
>  	}
>  
> -	return rc ? -EFAULT : 0;
> +	if (vcpu->kvm->arch.gisa) {
> +		if (kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {


if (vcpu->kvm->arch.gisa &&
    kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc) {

avoids one nesting level

> +			/*
> +			 * in case an adapter interrupt was not delivered
> +			 * in SIE context KVM will handle the delivery
> +			 */
> +			VCPU_EVENT(vcpu, 4, "%s isc %u", "deliver: I/O (AI/gisa)", isc);
> +			memset(&io, 0, sizeof(io));
> +			io.io_int_word = (isc << 27) | 0x80000000;
> +			vcpu->stat.deliver_io_int++;
> +			trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
> +				KVM_S390_INT_IO(1, 0, 0, 0),
> +				((__u32)io.subchannel_id << 16) |
> +				io.subchannel_nr,
> +				((__u64)io.io_int_parm << 32) |
> +				io.io_int_word);
> +			rc = __do_deliver_io(vcpu, &io);
> +		}
> +	}
> +out:
> +	return rc;
>  }
>  
>  typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
> @@ -1537,12 +1566,23 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>  	struct kvm_s390_float_interrupt *fi;
>  	struct list_head *list;
>  	int isc;
> +	int rc = 0;
> +
> +	isc = int_word_to_isc(inti->io.io_int_word);
> +
> +	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {

&& (inti->type & KVM_S390_INT_IO_AI_MASK)) {

> +		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
> +		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);

Can there only be one pending at a time? (e.g. what happens if the bit
is already set?)

> +		kfree(inti);
> +		goto out;

Why not simply return 0? ...

> +	}
>  
>  	fi = &kvm->arch.float_int;
>  	spin_lock(&fi->lock);
>  	if (fi->counters[FIRQ_CNTR_IO] >= KVM_S390_MAX_FLOAT_IRQS) {
>  		spin_unlock(&fi->lock);
> -		return -EBUSY;
> +		rc = -EBUSY;
> +		goto out;

... avoids this change ...

>  	}
>  	fi->counters[FIRQ_CNTR_IO] += 1;
>  
> @@ -1553,12 +1593,12 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>  			inti->io.subchannel_id >> 8,
>  			inti->io.subchannel_id >> 1 & 0x3,
>  			inti->io.subchannel_nr);
> -	isc = int_word_to_isc(inti->io.io_int_word);
>  	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
>  	list_add_tail(&inti->list, list);
>  	set_bit(isc_to_irq_type(isc), &fi->pending_irqs);
>  	spin_unlock(&fi->lock);
> -	return 0;
> +out:
> +	return rc;

... and this.

>  }
>  
>  /*
> @@ -2705,3 +2745,29 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>  	return n;
>  }
>  
> +void kvm_s390_gisa_clear(struct kvm *kvm)

can we instead call this "gisa_setup" or move all that directly into the
init function? (because it essentially inits the gisa)

> +{
> +	if (kvm->arch.gisa) {

This check is not needed: guaranteed to be set by the caller.

> +		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
> +		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
> +		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
> +	}
> +}
> +
> +void kvm_s390_gisa_init(struct kvm *kvm)
> +{
> +	if (1 || !css_general_characteristics.aiv)
> +		kvm->arch.gisa = NULL;

1 || ... ? This will always trigger. -> gisa never active with this patch

> +	else {
> +		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
> +		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
> +		kvm_s390_gisa_clear(kvm);
> +	}
> +}
> +
> +void kvm_s390_gisa_destroy(struct kvm *kvm)
> +{
> +	if (!kvm->arch.gisa)
> +		return;
> +	kvm->arch.gisa = NULL;

You can do this unconditionally. Nevertheless, this function is not
really useful: only called when we destroy the VM.

> +}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 48f0099..68d7eef 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1986,6 +1986,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  
>  	spin_lock_init(&kvm->arch.start_stop_lock);
>  	kvm_s390_vsie_init(kvm);
> +	kvm_s390_gisa_init(kvm);
>  	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
>  
>  	return 0;
> @@ -2048,6 +2049,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  	kvm_free_vcpus(kvm);
>  	sca_dispose(kvm);
>  	debug_unregister(kvm->arch.dbf);
> +	kvm_s390_gisa_destroy(kvm);
>  	free_page((unsigned long)kvm->arch.sie_page2);
>  	if (!kvm_is_ucontrol(kvm))
>  		gmap_remove(kvm->arch.gmap);
> @@ -2458,6 +2460,11 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>  	if (test_kvm_facility(vcpu->kvm, 139))
>  		vcpu->arch.sie_block->ecd |= ECD_MEF;
>  
> +	if (vcpu->arch.sie_block->gd) {
> +		vcpu->arch.sie_block->eca |= ECA_AIV;
> +		VCPU_EVENT(vcpu, 3, "AIV gisa format-%u enabled for cpu %03u",
> +			   vcpu->arch.sie_block->gd & 0x3, vcpu->vcpu_id);
> +	}
>  	vcpu->arch.sie_block->sdnxo = ((unsigned long) &vcpu->run->s.regs.sdnx)
>  					| SDNXC;
>  	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
> @@ -2510,6 +2517,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
>  
>  	vcpu->arch.sie_block->icpua = id;
>  	spin_lock_init(&vcpu->arch.local_int.lock);
> +	vcpu->arch.sie_block->gd = (u32)(u64)kvm->arch.gisa;
>  	seqcount_init(&vcpu->arch.cputm_seqcount);
>  
>  	rc = kvm_vcpu_init(vcpu, kvm, id);
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 8877116..05269a9 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -367,6 +367,9 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu,
>  			   void __user *buf, int len);
>  int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu,
>  			   __u8 __user *buf, int len);
> +void kvm_s390_gisa_init(struct kvm *kvm);
> +void kvm_s390_gisa_clear(struct kvm *kvm);
> +void kvm_s390_gisa_destroy(struct kvm *kvm);
>  
>  /* implemented in guestdbg.c */
>  void kvm_s390_backup_guest_per_regs(struct kvm_vcpu *vcpu);
> 


-- 

Thanks,

David / dhildenb
