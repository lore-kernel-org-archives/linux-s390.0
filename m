From: David Hildenbrand <david@redhat.com>
Date: Thu, 06 Dec 2018 08:25:15 +0000
Subject: Re: [PATCH v1 2/2] s390/kvm: handle diagnose 318 instruction call
Message-Id: <5a66c52a-018b-f822-6807-728c9a381120@redhat.com>
In-Reply-To: <5ab80dee-6bdf-83f1-ce40-8b8cca7ed75b@linux.ibm.com>
References: <5ab80dee-6bdf-83f1-ce40-8b8cca7ed75b@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 05.12.18 23:46, Collin Walling wrote:
> On 12/5/18 11:07 AM, Collin Walling wrote:
>> On 12/5/18 4:02 AM, David Hildenbrand wrote:
>>> On 04.12.18 23:06, Collin Walling wrote:
>>>> Diagnose 318 is a privileged instruction that must be interpreted by 
>>>> SIE and handled via KVM.
>>>>
>>>> The control program name and version codes (CPNC and CPVC) set by this
>>>> instruction are saved to the kvm->arch struct. The CPNC is also set in
>>>> the SIE control block of all VCPUs. The new kvm_s390_set_misc interface
>>>> is introduced for migration.
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
> 
> [...]
> 
>>>>  
>>>> +void kvm_s390_set_cpc(struct kvm *kvm, u64 cpc)
>>>> +{
>>>> +	struct kvm_vcpu *vcpu;
>>>> +	int i;
>>>> +
>>>> +	mutex_lock(&kvm->lock);
>>>> +	kvm->arch.diag318_info.cpc = cpc;
>>>> +
>>>> +	VM_EVENT(kvm, 3, "SET: cpnc: 0x%x cpvc: 0x%llx",
>>>> +		 (u8)kvm->arch.diag318_info.cpnc, (u64)kvm->arch.diag318_info.cpvc);
>>>> +
>>>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>>>> +		vcpu->arch.sie_block->cpnc = kvm->arch.diag318_info.cpnc;
>>>
>>> No, that does not look completely right. The other VCPUs could be
>>> running in the SIE. Can you update that via a sync request instead?
>>>
>>> (after a VCPU updated the CPNC, other VCPUS could read for some time the
>>> old value, as values in this part of the sie_block might be cached while
>>> a CPU is in the SIE)
>>>
>>
>> True. There are different name codes for other control programs (v/ZM, z/OS, etc).
>> We should make sure that the name code is properly updated for all VCPUs if we are
>> running a non-linux environment on top of KVM.
>>
>> Thanks for the heads up! 
>>
> 
> I've been reading up on what the other requests (KVM_REQ_*) are used for, and none of them
> seem to make sense for what we want to do here (update a field in the vcpu). So let's see 
> if I fully understand how this should be implemented: 
> 
> 1) create a new s390 specific request that will handle updating the cpc
> 2) call a sync_broadcast using the new request within set_cpc
> 
> Alternatively, I think a vcpu block would work as well (you mentioned this in the RFC back 
> at the end of August / beginning of September).

Yes it would as well. E.g. see kvm_arch_crypto_clear_masks()

mutex_lock(&kvm->lock);
kvm_s390_vcpu_block_all(kvm);

/* do stuff to other VCPUs */

kvm_s390_vcpu_unblock_all(kvm);
mutex_unlock(&kvm->lock);

> 
> Am I headed in the right direction?
> 
> [...]
> 


-- 

Thanks,

David / dhildenb
