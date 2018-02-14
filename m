From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: force bp isolation for VSIE
Date: Wed, 14 Feb 2018 11:06:57 +0100
Message-ID: <16458103-a499-ce6d-4160-682cd9e8f926@redhat.com>
References: <20180214083422.44175-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180214083422.44175-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 14.02.2018 09:34, Christian Borntraeger wrote:
> If the guest runs with bp isolation when doing a SIE instruction,
> we must also run the nested guest with bp isolation when emulating
> that SIE instruction.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index ec772700ff96..b8e7660d7207 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -821,6 +821,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  {
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
> +	int guest_bp_isolation;
>  	int rc;
>  
>  	handle_last_fault(vcpu, vsie_page);
> @@ -831,6 +832,15 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		s390_handle_mcck();
>  
>  	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
> +
> +	/* save current guest state of bp isolation override */
> +	guest_bp_isolation = test_thread_flag(TIF_ISOLATE_BP_GUEST);

If I am not wrong, this is not "guest state". The guest state is
vcpu->arch.sie_block->fpf . This is host state of a thread.

> +
> +	/* if guest runs with bp isolation force it on nested guest */
> +	if (test_kvm_facility(vcpu->kvm, 82) &&
> +	    vcpu->arch.sie_block->fpf & FPF_BPBC)
> +		set_thread_flag(TIF_ISOLATE_BP_GUEST);
> +
>  	local_irq_disable();
>  	guest_enter_irqoff();
>  	local_irq_enable();
> @@ -840,6 +850,11 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	local_irq_disable();
>  	guest_exit_irqoff();
>  	local_irq_enable();
> +
> +	/* restore guest state for bp isolation override */
> +	if (!guest_bp_isolation)
> +		clear_thread_flag(TIF_ISOLATE_BP_GUEST);
> +
>  	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
>  
>  	if (rc == -EINTR) {
> 

You are trying to optimize the following case here:

1. TIF_ISOLATE_BP_GUEST is not set
2. The guest has facility 82 and enabled FPF_BPBC

As the vSIE guest can change its FPF_BPBC, there is basically no
guarantee to that. So, when entering/leaving the nested guest, you act
like the hardware would be doing FPF_BPBC - as it could be disabled for
the nested guest / the nested guest can change the state itself.

However I wonder what the semantics of FPF_BPBC should be. Shouldn't it
be the case that if the guest has enabled FPF_BPBC, that it is forced on
for the nested guest? (HW is missing a control to force it on).

Unfortunately, I don't have access to documentation, can you clarify?

-- 

Thanks,

David / dhildenb
