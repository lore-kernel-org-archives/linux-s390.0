From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [Patchv5 5/7] KVM: async_pf: Allow to wait for outstanding work
Date: Sun, 13 Oct 2013 12:08:41 +0300
Message-ID: <20131013090840.GA7063@redhat.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
 <1381244100-59056-6-git-send-email-borntraeger@de.ibm.com>
 <20131013084802.GC15657@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131013084802.GC15657@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Oct 13, 2013 at 11:48:03AM +0300, Gleb Natapov wrote:
> On Tue, Oct 08, 2013 at 04:54:58PM +0200, Christian Borntraeger wrote:
> > From: Dominik Dingel <dingel@linux.vnet.ibm.com>
> > 
> > kvm_clear_async_pf_completion get an additional flag to either cancel outstanding
> > work or wait for oustanding work to be finished, x86 currentlx cancels all work.
> >
> I do not see why x86 would not cancel all work in the feature, so the
> flag seems to be always true on s390 and always false on x86, which
> means that it is better to make it compile time option, same as
> KVM_ASYNC_PF_SYNC. Actually we can reuse KVM_ASYNC_PF_SYNC in
> kvm_clear_async_pf_completion_queue() instead of adding another one.
>  
Spoke to soon. I see that s390 uses both true and false, mostly false.
Lets add another function kvm_drain_async_pf_completion_queue() instead
of new parameter.

> > Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  arch/x86/kvm/x86.c       | 8 ++++----
> >  include/linux/kvm_host.h | 2 +-
> >  virt/kvm/async_pf.c      | 6 +++++-
> >  3 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 187f824..00a4262 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -539,7 +539,7 @@ int kvm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
> >  	kvm_x86_ops->set_cr0(vcpu, cr0);
> >  
> >  	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
> > -		kvm_clear_async_pf_completion_queue(vcpu);
> > +		kvm_clear_async_pf_completion_queue(vcpu, false);
> >  		kvm_async_pf_hash_reset(vcpu);
> >  	}
> >  
> > @@ -1911,7 +1911,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
> >  	vcpu->arch.apf.msr_val = data;
> >  
> >  	if (!(data & KVM_ASYNC_PF_ENABLED)) {
> > -		kvm_clear_async_pf_completion_queue(vcpu);
> > +		kvm_clear_async_pf_completion_queue(vcpu, false);
> >  		kvm_async_pf_hash_reset(vcpu);
> >  		return 0;
> >  	}
> > @@ -6742,7 +6742,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu)
> >  
> >  	kvmclock_reset(vcpu);
> >  
> > -	kvm_clear_async_pf_completion_queue(vcpu);
> > +	kvm_clear_async_pf_completion_queue(vcpu, false);
> >  	kvm_async_pf_hash_reset(vcpu);
> >  	vcpu->arch.apf.halted = false;
> >  
> > @@ -7015,7 +7015,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
> >  	 * Unpin any mmu pages first.
> >  	 */
> >  	kvm_for_each_vcpu(i, vcpu, kvm) {
> > -		kvm_clear_async_pf_completion_queue(vcpu);
> > +		kvm_clear_async_pf_completion_queue(vcpu, false);
> >  		kvm_unload_vcpu_mmu(vcpu);
> >  	}
> >  	kvm_for_each_vcpu(i, vcpu, kvm)
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index b4e8666..223fcf3 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -192,7 +192,7 @@ struct kvm_async_pf {
> >  	struct page *page;
> >  };
> >  
> > -void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
> > +void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu, bool flush);
> >  void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
> >  int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, unsigned long hva,
> >  		       struct kvm_arch_async_pf *arch);
> > diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> > index 8f57d63..3e13a73 100644
> > --- a/virt/kvm/async_pf.c
> > +++ b/virt/kvm/async_pf.c
> > @@ -107,7 +107,7 @@ static void async_pf_execute(struct work_struct *work)
> >  	kvm_put_kvm(vcpu->kvm);
> >  }
> >  
> > -void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
> > +void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu, bool flush)
> >  {
> >  	/* cancel outstanding work queue item */
> >  	while (!list_empty(&vcpu->async_pf.queue)) {
> > @@ -115,6 +115,10 @@ void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu)
> >  			list_entry(vcpu->async_pf.queue.next,
> >  				   typeof(*work), queue);
> >  		list_del(&work->queue);
> > +		if (flush) {
> > +			flush_work(&work->work);
> > +			continue;
> > +		}
> >  		if (cancel_work_sync(&work->work)) {
> >  			mmdrop(work->mm);
> >  			kvm_put_kvm(vcpu->kvm); /* == work->vcpu->kvm */
> > -- 
> > 1.8.3.1
> 
> --
> 			Gleb.
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
			Gleb.
