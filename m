Return-Path: <SRS0=sFCg=TC=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 2/2] s390/kvm: diagnose 318 handling
References: <1556751063-21835-1-git-send-email-walling@linux.ibm.com>
 <1556751063-21835-3-git-send-email-walling@linux.ibm.com>
 <783ecdb4-3bc2-4bf3-55cb-9a902467aadd@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 2 May 2019 11:25:28 -0400
MIME-Version: 1.0
In-Reply-To: <783ecdb4-3bc2-4bf3-55cb-9a902467aadd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1988b4c3-e123-47dd-2008-15d8bec0171d@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 5/2/19 8:59 AM, David Hildenbrand wrote:
> On 02.05.19 00:51, Collin Walling wrote:
>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>> be intercepted by SIE and handled via KVM. Let's introduce some
>> functions to communicate between userspace and KVM via ioctls. These
>> will be used to get/set the diag318 related information (also known
>> as the "Control Program Code" or "CPC"), as well as check the system
>> if KVM supports handling this instruction.
>>
>> This information can help with diagnosing the OS the VM is running
>> in (Linux, z/VM, etc) if the OS calls this instruction.
>>
>> The get/set functions are introduced primarily for VM migration and
>> reset, though no harm could be done to the system if a userspace
>> program decides to alter this data (this is highly discouraged).
>>
>> The Control Program Name Code (CPNC) is stored in the SIE block and
>> a copy is retained in each VCPU. The Control Program Version Code
>> (CPVC) retains a copy in each VCPU as well.
>>
>> At this time, the CPVC is not reported as its format is yet to be
>> defined.
>>
>> Note that the CPNC is set in the SIE block iff the host hardware
>> supports it.
> 
> For vSIE and SIE you only configure the CPNC. Is that sufficient?
> Shouldn't diag318 allow the guest to set both? (especially regarding vSIE)
> 

The SIE block only stores the CPNC. The CPVC is not designed to be
stored in the SIE block, so we store it in guest memory only.

> [...]
>>
>> diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
>> index 95ca68d..9a8d934 100644
>> --- a/Documentation/virtual/kvm/devices/vm.txt
>> +++ b/Documentation/virtual/kvm/devices/vm.txt
>> @@ -267,3 +267,17 @@ Parameters: address of a buffer in user space to store the data (u64) to;
>>   	    if it is enabled
>>   Returns:    -EFAULT if the given address is not accessible from kernel space
>>   	    0 in case of success.
>> +
>> +6. GROUP: KVM_S390_VM_MISC
>> +Architectures: s390
>> +
>> +6.1. KVM_S390_VM_MISC_CPC (r/w)
>> +
>> +Allows userspace to access the "Control Program Code" which consists of a
>> +1-byte "Control Program Name Code" and a 7-byte "Control Program Version Code".
>> +This information is initialized during IPL and must be preserved during
>> +migration.
> 
> Your implementation does not match this description. User space can only
> get/set the cpnc effectively for the HW to see it, not the CPVC, no?
> 

We retrieve the entire CPNC + CPVC. User space (i.e. QEMU) can retrieve
this 64-bit value and save / load it during live guest migration.

I figured it would be best to set / get this entire value now, so that
we don't need to add extra handling for the version code later when its
format is properly decided.

> Shouldn't you transparently forward that data to the SCB for vSIE/SIE,
> because we really don't care what the target format will be?
> 

Sorry, I'm not fully understanding what you mean by "we really don't
care what the target format will be?"

Do you mean to shadow the CPNC without checking if diag318 is supported?
I imagine that would be harmless.

>> +
>> +Parameters: address of a buffer in user space to store the data (u64) to
>> +Returns:    -EFAULT if the given address is not accessible from kernel space
>> +	     0 in case of success.
> 
> [...]
>>   
>>   #define KVM_HVA_ERR_BAD		(-1UL)
>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>> index 16511d9..3d3d2a5 100644
>> --- a/arch/s390/include/uapi/asm/kvm.h
>> +++ b/arch/s390/include/uapi/asm/kvm.h
>> @@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
>>   #define KVM_S390_VM_CRYPTO		2
>>   #define KVM_S390_VM_CPU_MODEL		3
>>   #define KVM_S390_VM_MIGRATION		4
>> +#define KVM_S390_VM_MISC		5
>>   
>>   /* kvm attributes for mem_ctrl */
>>   #define KVM_S390_VM_MEM_ENABLE_CMMA	0
>> @@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
>>   #define KVM_S390_VM_MIGRATION_START	1
>>   #define KVM_S390_VM_MIGRATION_STATUS	2
>>   
>> +/* kvm attributes for KVM_S390_VM_MISC */
>> +#define KVM_S390_VM_MISC_CPC		0
>> +
>>   /* for KVM_GET_REGS and KVM_SET_REGS */
>>   struct kvm_regs {
>>   	/* general purpose regs for s390 */
>> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
>> index 45634b3d..9762e6a 100644
>> --- a/arch/s390/kvm/diag.c
>> +++ b/arch/s390/kvm/diag.c
>> @@ -235,6 +235,21 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
>>   	return ret < 0 ? ret : 0;
>>   }
>>   
>> +static int __diag_set_control_prog_name(struct kvm_vcpu *vcpu)
> 
> Can we name that "__diag_set_cpc" ?
> 
> "control_prog_name" is certainly not 100% correct.
> 

Sure

>> +{
>> +	unsigned int reg = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
>> +	u64 cpc = vcpu->run->s.regs.gprs[reg];
>> +
>> +	vcpu->stat.diagnose_318++;
>> +	kvm_s390_set_cpc(vcpu->kvm, cpc);
>> +
>> +	VCPU_EVENT(vcpu, 3, "diag 0x318 cpnc: 0x%x cpvc: 0x%llx",
>> +		   vcpu->kvm->arch.diag318_info.cpnc,
>> +		   (u64)vcpu->kvm->arch.diag318_info.cpvc);
>> +
>> +	return 0;
>> +}
> 
> 
> [...]
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 4638303..910af18 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -156,6 +156,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>>   	{ "instruction_diag_9c", VCPU_STAT(diagnose_9c) },
>>   	{ "instruction_diag_258", VCPU_STAT(diagnose_258) },
>>   	{ "instruction_diag_308", VCPU_STAT(diagnose_308) },
>> +	{ "instruction_diag_318", VCPU_STAT(diagnose_318) },
>>   	{ "instruction_diag_500", VCPU_STAT(diagnose_500) },
>>   	{ "instruction_diag_other", VCPU_STAT(diagnose_other) },
>>   	{ NULL }
>> @@ -1190,6 +1191,70 @@ static int kvm_s390_get_tod(struct kvm *kvm, struct kvm_device_attr *attr)
>>   	return ret;
>>   }
>>   
>> +void kvm_s390_set_cpc(struct kvm *kvm, u64 cpc)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	int i;
>> +
>> +	mutex_lock(&kvm->lock);
>> +	kvm->arch.diag318_info.val = cpc;
>> +
>> +	VM_EVENT(kvm, 3, "SET: CPNC: 0x%x CPVC: 0x%llx",
>> +		 kvm->arch.diag318_info.cpnc, (u64)kvm->arch.diag318_info.cpvc);
>> +
>> +	if (sclp.has_diag318) {
>> +		kvm_for_each_vcpu(i, vcpu, kvm) {
>> +			vcpu->arch.sie_block->cpnc = kvm->arch.diag318_info.cpnc;
>> +		}
>> +	}
> 
> Do we care about races here between guest VCPUs reading it via the SCB
> (HW) and us changing the value? My gut feeling is that it can be tolerated.
>  >> +	mutex_unlock(&kvm->lock);
>> +}
>> +
>> +static int kvm_s390_set_misc(struct kvm *kvm, struct kvm_device_attr *attr)
>> +{
>> +	int ret;
>> +	u64 cpc;
>> +
>> +	switch (attr->attr) {
>> +	case KVM_S390_VM_MISC_CPC:
>> +		ret = -EFAULT;
>> +		if (get_user(cpc, (u64 __user *)attr->addr))
>> +			break;
>> +		kvm_s390_set_cpc(kvm, cpc);
>> +		ret = 0;
>> +		break;
>> +	default:
>> +		ret = -ENXIO;
>> +		break;
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int kvm_s390_get_cpc(struct kvm *kvm, struct kvm_device_attr *attr)
>> +{
>> +	if (put_user(kvm->arch.diag318_info.val, (u64 __user *)attr->addr))
>> +		return -EFAULT;
> 
> Another possible race with setting code. Should be at least take the
> kvm->lock here? Otherwise, also looks like this can be tolerated.
> 

I'm 99% sure both can be tolerated. I can't really think of a scenario
where not taking the lock in either get / set would cause any concerns.

Thanks for the review!
