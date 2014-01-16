From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Thu, 16 Jan 2014 12:24:54 +0100
Message-ID: <52D7C186.1070700@redhat.com>
References: <1389864219-47412-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1389864219-47412-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

Il 16/01/2014 10:23, Christian Borntraeger ha scritto:
> When starting lots of dataplane devices the bootup takes very long on my
> s390 system(prototype irqfd code). With larger setups we are even able to
> trigger some timeouts in some components.
> Turns out that the KVM_SET_GSI_ROUTING ioctl takes very
> long (strace claims up to 0.1 sec) when having multiple CPUs.
> This is caused by the  synchronize_rcu and the HZ=100 of s390.
> We can defer the freeing outside of the ioctl path by using kfree_rcu.
> 
> Please note that we now have to check for a NULL pointer, since
> the underlying call_rcu in kfree_rcu cannot handle broken rcu
> callbacks.
> 
> This patch reduces the boot time till mounting root from 8 to 2 seconds
> on my s390 guest with 100 disks.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Hi Christian,

please take a look at the thread at
http://permalink.gmane.org/gmane.comp.emulators.kvm.devel/116933 - uses
of call_rcu need to be rate limited, otherwise the guest can allocate
arbitrarily large amounts of memory.

Can you check if using a dedicated SRCU (possibly with
synchronize_srcu_expedited in kvm_set_irq_routing) speeds up
KVM_SET_GSI_ROUTING enough?  Back-of-the-envelope, the latency should be
on the order of tens of microseconds.

Thanks,

Paolo

> ---
>  include/linux/kvm_host.h | 1 +
>  virt/kvm/irqchip.c       | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3d1b0e6..2f19079 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -327,6 +327,7 @@ struct kvm_kernel_irq_routing_entry {
>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>  
>  struct kvm_irq_routing_table {
> +	struct rcu_head	rcu;
>  	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
>  	struct kvm_kernel_irq_routing_entry *rt_entries;
>  	u32 nr_rt_entries;
> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
> index 20dc9e4..3e2ebed 100644
> --- a/virt/kvm/irqchip.c
> +++ b/virt/kvm/irqchip.c
> @@ -226,12 +226,11 @@ int kvm_set_irq_routing(struct kvm *kvm,
>  	kvm_irq_routing_update(kvm, new);
>  	mutex_unlock(&kvm->irq_lock);
>  
> -	synchronize_rcu();
> -
>  	new = old;
>  	r = 0;
>  
>  out:
> -	kfree(new);
> +	if (new)
> +		kfree_rcu(new, rcu);
>  	return r;
>  }
> 
