From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 4/6] KVM: s390: consider epoch index on TOD clock
 syncs
Date: Thu, 8 Feb 2018 13:15:55 +0100
Message-ID: <bd8ce1fc-6ed9-5c4c-0912-0c9bac36b015@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
 <20180207114647.6220-5-david@redhat.com>
 <438d8539-44fa-2661-ea04-a0642c48c9fa@linux.vnet.ibm.com>
 <402a12fb-28ec-c11a-de72-222fde27517b@redhat.com>
 <65719abd-37bb-c9ca-88d5-ecb230696a04@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <65719abd-37bb-c9ca-88d5-ecb230696a04@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

>> The rules of unsigned addition should make sure that all cases are
>> covered. (I tried to find a counter example but wasn't able to find one)
> 
> Agreed. I just wrote down a few edge cases myself... it seems to check 
> out nicely.
> 
>>
>> (Especially, this is the same code pattern as found in
>> arch/s390/kvm/vsie.c:register_shadow_scb(), which also adds two signed
>> numbers.)
>>
>>>>    /*
>>>>     * This callback is executed during stop_machine(). All CPUs are therefore
>>>>     * temporarily stopped. In order not to change guest behavior, we have to
>>>> @@ -194,13 +216,17 @@ static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
>>>>    	unsigned long long *delta = v;
>>>>
>>>>    	list_for_each_entry(kvm, &vm_list, vm_list) {
>>>> -		kvm->arch.epoch -= *delta;
>>>>    		kvm_for_each_vcpu(i, vcpu, kvm) {
>>>> -			vcpu->arch.sie_block->epoch -= *delta;
>>>> +			kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
>>>> +			if (i == 0) {
>>>> +				kvm->arch.epoch = vcpu->arch.sie_block->epoch;
>>>> +				kvm->arch.epdx = vcpu->arch.sie_block->epdx;
>>> Are we safe by setting the kvm epochs to the sie epochs wrt migration?
>> Yes, in fact they should be the same for all VCPUs, otherwise we are in
>> trouble. The TOD has to be the same over all VCPUs.
>>
>> So we should always have
>> - kvm->arch.epoch == vcpu->arch.sie_block->epoch
>> - kvm->arch.epdx == vcpu->arch.sie_block->epdx
>> for all VCPUs, otherwise their TOD could differ.
> 
> Perhaps then this could be shortened to calculate the epochs only once, 
> then set
> each vcpu to those values instead ofcalculating on each iteration?
> 

I had that before, but changed it to this. Especially because some weird user
space could set the epochs differently on different CPUs (e.g. for testing
purposes or IDK).

So something like this is not shorter and possibly performs less calculations


        list_for_each_entry(kvm, &vm_list, vm_list) {
                kvm_for_each_vcpu(i, vcpu, kvm) {
-                       kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
                        if (i == 0) {
+                               kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
                                kvm->arch.epoch = vcpu->arch.sie_block->epoch;
                                kvm->arch.epdx = vcpu->arch.sie_block->epdx;
+                       } else {
+                               vcpu->arch.sie_block->epoch = kvm->arch.epoch;
+                               vcpu->arch.sie_block->epdx = kvm->arch.epdx;
                        }
                        if (vcpu->arch.cputm_enabled)
                                vcpu->arch.cputm_start += *delta;

I'll let the Maintainers decide :)

> I imagine the number of iterations would never be large enough to cause any
> considerable performance hits, though.

Thanks!

-- 

Thanks,

David / dhildenb
