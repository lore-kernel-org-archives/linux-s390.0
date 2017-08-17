From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 2/2] KVM: RCU protected dynamic vcpus array
Date: Thu, 17 Aug 2017 18:54:30 +0200
Message-ID: <1dea37fa-d51e-1381-c3f1-e067065560b7@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <20170816194037.9460-3-rkrcmar@redhat.com>
 <7cb42373-355c-7cb3-2979-9529aef0641c@redhat.com>
 <20170817165044.GF2566@flask>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817165044.GF2566@flask>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On 17/08/2017 18:50, Radim Krčmář wrote:
> 2017-08-17 13:14+0200, David Hildenbrand:
>>>  	atomic_set(&kvm->online_vcpus, 0);
>>>  	mutex_unlock(&kvm->lock);
>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>> index c8df733eed41..eb9fb5b493ac 100644
>>> --- a/include/linux/kvm_host.h
>>> +++ b/include/linux/kvm_host.h
>>> @@ -386,12 +386,17 @@ struct kvm_memslots {
>>>  	int used_slots;
>>>  };
>>>  
>>> +struct kvm_vcpus {
>>> +	u32 online;
>>> +	struct kvm_vcpu *array[];
>>
>> On option could be to simply chunk it:
>>
>> +struct kvm_vcpus {
>> +       struct kvm_vcpu vcpus[32];
> 
> I'm thinking of 128/256.
> 
>> +};
>> +
>>  /*
>>   * Note:
>>   * memslots are not sorted by id anymore, please use id_to_memslot()
>> @@ -391,7 +395,7 @@ struct kvm {
>>         struct mutex slots_lock;
>>         struct mm_struct *mm; /* userspace tied to this vm */
>>         struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
>> -       struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>> +       struct kvm_vcpus vcpus[(KVM_MAX_VCPUS + 31) / 32];
>>         /*
>>          * created_vcpus is protected by kvm->lock, and is incremented
>> @@ -483,12 +487,14 @@ static inline struct kvm_io_bus
>> *kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)
>>
>>
>> 1. make nobody access kvm->vcpus directly (factor out)
>> 2. allocate next chunk if necessary when creating a VCPU and store
>> pointer using WRITE_ONCE
>> 3. use READ_ONCE to test for availability of the current chunk
> 
> We can also use kvm->online_vcpus exactly like we did now.
> 
>> kvm_for_each_vcpu just has to use READ_ONCE to access/test for the right
>> chunk. Pointers never get invalid. No RCU needed. Sleeping in the loop
>> is possible.
> 
> I like this better than SRCU because it keeps the internal code mostly
> intact, even though it is compromise solution with a tunable.
> (SRCU gives us more protection than we need.)
>
> I'd do this for v2,

Sounds good!

Paolo
