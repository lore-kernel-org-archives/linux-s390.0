From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 18 Jan 2018 19:10:16 +0100
Message-ID: <20180118191016.22947066.cohuck@redhat.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
        <20180116200217.211897-7-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-7-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 16 Jan 2018 21:02:11 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

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
>  arch/s390/kvm/interrupt.c | 104 +++++++++++++++++++++++++++++++++++++---------
>  arch/s390/kvm/kvm-s390.c  |   8 ++++
>  arch/s390/kvm/kvm-s390.h  |   3 ++
>  3 files changed, 96 insertions(+), 19 deletions(-)
> 

> @@ -935,23 +960,27 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
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
> +	if (vcpu->kvm->arch.gisa) {
> +		if (kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {

I think this could benefit from a comment here or there; e.g. that you
manually deliver interrupts here that have not yet been injected via
gisa. This is complex enough to confuse people having to look at this
some years from now :)

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
>  	return rc ? -EFAULT : 0;
>  }
>  

The general approach seems sane from what I can see (unless I'm already
too tired...)
