From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv2/RFC] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Fri, 21 Feb 2014 18:35:49 +0100
Message-ID: <53078E75.2040603@redhat.com>
References: <52D7C186.1070700@redhat.com> <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@minantech.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de, mst@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Il 16/01/2014 13:44, Christian Borntraeger ha scritto:
> +DEFINE_STATIC_SRCU(irq_srcu);
> +
>  bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin)
>  {
>  	struct kvm_irq_ack_notifier *kian;
> -	int gsi;
> +	int gsi, idx;
>  
> -	rcu_read_lock();
> -	gsi = rcu_dereference(kvm->irq_routing)->chip[irqchip][pin];
> +	idx = srcu_read_lock(&irq_srcu);
> +	gsi = srcu_dereference(kvm->irq_routing, &irq_srcu)->chip[irqchip][pin];
>  	if (gsi != -1)
>  		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
>  					 link)
> @@ -45,7 +48,7 @@ bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin)
>  				return true;
>  			}
>  
> -	rcu_read_unlock();
> +	srcu_read_unlock(&irq_srcu, idx);

Missing hunk here:

@@ -44,7 +44,7 @@ bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin)
 		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
 					 link)
 			if (kian->gsi == gsi) {
-				rcu_read_unlock();
+				srcu_read_unlock(&irq_srcu, idx);
 				return true;
 			}
 

Paolo
