From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCHv3] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Fri, 17 Jan 2014 15:03:43 +0100
Message-ID: <52D9383F.7040206@redhat.com>
References: <52D7C186.1070700@redhat.com> <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com> <20140116185520.GC29522@redhat.com> <52D83BF2.6030705@de.ibm.com> <20140116202213.GF29522@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140116202213.GF29522@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

Il 16/01/2014 21:22, Michael S. Tsirkin ha scritto:
>> [PATCHv3] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
>>
>> When starting lots of dataplane devices the bootup takes very long
>> on my s390 system(prototype irqfd code). With larger setups we are even
>> able to trigger some timeouts in some components.
>> Turns out that the KVM_SET_GSI_ROUTING ioctl takes very
>> long (strace claims up to 0.1 sec) when having multiple CPUs.
>> This is caused by the  synchronize_rcu and the HZ=100 of s390.
>>
>> Lets use the expedited variant to speed things up as suggested by
>> Michael S. Tsirkin
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  virt/kvm/irqchip.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
>> index 20dc9e4..dbcfde7 100644
>> --- a/virt/kvm/irqchip.c
>> +++ b/virt/kvm/irqchip.c
>> @@ -226,7 +226,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
>>  	kvm_irq_routing_update(kvm, new);
>>  	mutex_unlock(&kvm->irq_lock);
>>  
>> -	synchronize_rcu();
>> +	synchronize_rcu_expedited();
>>  
>>  	new = old;
>>  	r = 0;
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Well... I love to contradict myself, so: no way this can be accepted
this close to the end of the merge window.  :(

synchronize_rcu_expedited() forces a context switch on all CPUs, even
those that are not running KVM.  Thus, this patch might help a guest DoS
its host by changing the IRQ routing tables in a loop.

So this will have to wait for 3.15.  We have ~2 months to do performance
measurements on the v2 patch.  Sorry.

Thanks,

Paolo
