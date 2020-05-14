Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENJib (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 05:38:31 -0400
Subject: Re: [PATCH v6 2/2] s390/kvm: diagnose 318 handling
References: <20200513221557.14366-1-walling@linux.ibm.com>
 <20200513221557.14366-3-walling@linux.ibm.com>
 <d4320d09-7b3a-ac13-77be-02397f4ccc83@redhat.com>
 <de4e4416-5158-b60f-e2a8-fb6d3d48d516@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <88d27a61-b55b-ee68-f7f9-85ce7fcefd64@redhat.com>
Date: Thu, 14 May 2020 11:37:47 +0200
MIME-Version: 1.0
In-Reply-To: <de4e4416-5158-b60f-e2a8-fb6d3d48d516@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

On 14.05.20 10:52, Janosch Frank wrote:
> On 5/14/20 9:53 AM, Thomas Huth wrote:
>> On 14/05/2020 00.15, Collin Walling wrote:
>>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>>> be intercepted by SIE and handled via KVM. Let's introduce some
>>> functions to communicate between userspace and KVM via ioctls. These
>>> will be used to get/set the diag318 related information, as well as
>>> check the system if KVM supports handling this instruction.
>>>
>>> This information can help with diagnosing the environment the VM is
>>> running in (Linux, z/VM, etc) if the OS calls this instruction.
>>>
>>> By default, this feature is disabled and can only be enabled if a
>>> user space program (such as QEMU) explicitly requests it.
>>>
>>> The Control Program Name Code (CPNC) is stored in the SIE block
>>> and a copy is retained in each VCPU. The Control Program Version
>>> Code (CPVC) is not designed to be stored in the SIE block, so we
>>> retain a copy in each VCPU next to the CPNC.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>>  Documentation/virt/kvm/devices/vm.rst | 29 +++++++++
>>>  arch/s390/include/asm/kvm_host.h      |  6 +-
>>>  arch/s390/include/uapi/asm/kvm.h      |  5 ++
>>>  arch/s390/kvm/diag.c                  | 20 ++++++
>>>  arch/s390/kvm/kvm-s390.c              | 89 +++++++++++++++++++++++++++
>>>  arch/s390/kvm/kvm-s390.h              |  1 +
>>>  arch/s390/kvm/vsie.c                  |  2 +
>>>  7 files changed, 151 insertions(+), 1 deletion(-)
>> [...]
>>> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
>>> index 563429dece03..3caed4b880c8 100644
>>> --- a/arch/s390/kvm/diag.c
>>> +++ b/arch/s390/kvm/diag.c
>>> @@ -253,6 +253,24 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
>>>  	return ret < 0 ? ret : 0;
>>>  }
>>>  
>>> +static int __diag_set_diag318_info(struct kvm_vcpu *vcpu)
>>> +{
>>> +	unsigned int reg = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
>>> +	u64 info = vcpu->run->s.regs.gprs[reg];
>>> +
>>> +	if (!vcpu->kvm->arch.use_diag318)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	vcpu->stat.diagnose_318++;
>>> +	kvm_s390_set_diag318_info(vcpu->kvm, info);
>>> +
>>> +	VCPU_EVENT(vcpu, 3, "diag 0x318 cpnc: 0x%x cpvc: 0x%llx",
>>> +		   vcpu->kvm->arch.diag318_info.cpnc,
>>> +		   (u64)vcpu->kvm->arch.diag318_info.cpvc);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>>>  {
>>>  	int code = kvm_s390_get_base_disp_rs(vcpu, NULL) & 0xffff;
>>> @@ -272,6 +290,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>>>  		return __diag_page_ref_service(vcpu);
>>>  	case 0x308:
>>>  		return __diag_ipl_functions(vcpu);
>>> +	case 0x318:
>>> +		return __diag_set_diag318_info(vcpu);
>>>  	case 0x500:
>>>  		return __diag_virtio_hypercall(vcpu);
>>
>> I wonder whether it would make more sense to simply drop to userspace
>> and handle the diag 318 call there? That way the userspace would always
>> be up-to-date, and as we've seen in the past (e.g. with the various SIGP
>> handling), it's better if the userspace is in control... e.g. userspace
>> could also decide to only use KVM_S390_VM_MISC_ENABLE_DIAG318 if the
>> guest just executed the diag 318 instruction.
>>
>> And you need the kvm_s390_vm_get/set_misc functions anyway, so these
>> could also be simply used by the diag 318 handler in userspace?
>>
>>>  	default:
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index d05bb040fd42..c3eee468815f 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -159,6 +159,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>>>  	{ "diag_9c_ignored", VCPU_STAT(diagnose_9c_ignored) },
>>>  	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
>>>  	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
>>> +	{ "instruction_diag_318", VCPU_STAT(diagnose_318) },
>>>  	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
>>>  	{ "instruction_diag_other", VCPU_STAT(diagnose_other) },
>>>  	{ NULL }
>>> @@ -1243,6 +1244,76 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
>>>  	return ret;
>>>  }
>>>  
>>> +void kvm_s390_set_diag318_info(struct kvm *kvm, u64 info)
>>> +{
>>> +	struct kvm_vcpu *vcpu;
>>> +	int i;
>>> +
>>> +	kvm->arch.diag318_info.val = info;
>>> +
>>> +	VM_EVENT(kvm, 3, "SET: CPNC: 0x%x CPVC: 0x%llx",
>>> +		 kvm->arch.diag318_info.cpnc, kvm->arch.diag318_info.cpvc);
>>> +
>>> +	if (sclp.has_diag318) {
>>> +		kvm_for_each_vcpu(i, vcpu, kvm) {
>>> +			vcpu->arch.sie_block->cpnc = kvm->arch.diag318_info.cpnc;
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static int kvm_s390_vm_set_misc(struct kvm *kvm, struct kvm_device_attr *attr)
>>> +{
>>> +	int ret;
>>> +	u64 diag318_info;
>>> +
>>> +	switch (attr->attr) {
>>> +	case KVM_S390_VM_MISC_ENABLE_DIAG318:
>>> +		kvm->arch.use_diag318 = 1;
>>> +		ret = 0;
>>> +		break;
>>
>> Would it make sense to set kvm->arch.use_diag318 = 1 during the first
>> execution of KVM_S390_VM_MISC_DIAG318 instead, so that we could get
>> along without the KVM_S390_VM_MISC_ENABLE_DIAG318 ?
> 
> I'm not an expert in feature negotiation, but why isn't this a cpu
> feature like sief2 instead of a attribute?
> 
> @David?

In the end you want to have it somehow in the CPU model I guess. You
cannot glue it to QEMU machines, because availability depends on HW+KVM
support.

How does the guest detect that it can use diag318? I assume/hope via a a
STFLE feature.

-- 
Thanks,

David / dhildenb
