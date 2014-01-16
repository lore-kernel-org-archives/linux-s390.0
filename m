From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Thu, 16 Jan 2014 22:22:13 +0200
Message-ID: <20140116202213.GF29522@redhat.com>
References: <52D7C186.1070700@redhat.com>
 <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com>
 <20140116185520.GC29522@redhat.com>
 <52D83BF2.6030705@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D83BF2.6030705@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 16, 2014 at 09:07:14PM +0100, Christian Borntraeger wrote:
> On 16/01/14 19:55, Michael S. Tsirkin wrote:
> > On Thu, Jan 16, 2014 at 01:44:20PM +0100, Christian Borntraeger wrote:
> [...]
> >> I converted most of the rcu routines to srcu. Review for the unconverted
> [...]
> 
> > That's nice but did you try to measure the overhead
> > on some interrupt-intensive workloads, such as RX with 10G ethernet?
> > srcu locks aren't free like rcu ones.
> 
> Right, but the read side is only acting on cpu local data structures so the overhead
> is probably very small in contrast to the hlist work and the injection itself.

My testing of VM exit paths shows the overhead of read size RCU
is not negligeable, IIRC it involves memory barriers which
are expensive operations.

> You have a more compelling review comment, though:
> 
> [...]
> >> -	synchronize_rcu();
> >> +	synchronize_srcu_expedited(&irq_srcu);
> > 
> > Hmm, it's a bit strange that you also do _expecited here.
> 
> Well, I just did what the original mail thread suggested :-)
> 
> > What if this synchronize_rcu is replaced by synchronize_rcu_expedited
> > and no other changes are made?
> > Maybe that's enough?
> 
> Yes, its enough. (seems slightly slower than v2, but fast enough)
> 
> Patch below:
> 
> 
> [PATCHv3] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
> 
> When starting lots of dataplane devices the bootup takes very long
> on my s390 system(prototype irqfd code). With larger setups we are even
> able to trigger some timeouts in some components.
> Turns out that the KVM_SET_GSI_ROUTING ioctl takes very
> long (strace claims up to 0.1 sec) when having multiple CPUs.
> This is caused by the  synchronize_rcu and the HZ=100 of s390.
> 
> Lets use the expedited variant to speed things up as suggested by
> Michael S. Tsirkin
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  virt/kvm/irqchip.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 20dc9e4..dbcfde7 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -226,7 +226,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  	kvm_irq_routing_update(kvm, new);
>  	mutex_unlock(&kvm->irq_lock);
>  
> -	synchronize_rcu();
> +	synchronize_rcu_expedited();
>  
>  	new = old;
>  	r = 0;
