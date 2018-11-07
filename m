From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed, 07 Nov 2018 17:52:03 +0000
Subject: Re: [PATCH 09/10] KVM: s390: add and wire function gib_alert_irq_handler()
Message-Id: <d5fd0955-5baf-992b-9d69-df31d4d6ff94@linux.ibm.com>
In-Reply-To: <afec0606-d9c3-9938-e74d-0602e5713685@linux.ibm.com>
References: <afec0606-d9c3-9938-e74d-0602e5713685@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 07/11/2018 17:25, Michael Mueller wrote:
> 
> 
> On 06.11.18 19:42, Pierre Morel wrote:
>> On 05/11/2018 18:41, Michael Mueller wrote:
>>>
>>>
>>> On 31.10.18 13:10, Pierre Morel wrote:
>>>>> atomic_inc(&vcpu->kvm->arch.vcpus_in_sie);
>>>>> +��� if (vcpu->kvm->arch.gib_in_use)
>>>>> +������� vcpu->kvm->arch.gisa->iam = 0;
>>>>
>>>> I am not sure that this is race free....
>>>
>>> It is, I looked at the generated instructions.
>>
>> Here we clear IAM, so an IPM can be set and should trigger an 
>> interrupt in the guest
> 
> Setting or clearing the IAM has no effect whether a ISC can be set or 
> not in the IPM.
> It is cleared because we are about to enter the SIE and which will 
> evaluate the IPM and
> process the interruption possibly.
> 
> Clearing the IAM has the effect, that the fallback path (GIB alert) will 
> not be used.
> 
>>
>>>>
>>>>> vcpu->arch.sie_block->icptcode = 0;
>>>>> ����� cpuflags = atomic_read(&vcpu->arch.sie_block->cpuflags);
>>>>> @@ -3421,6 +3423,9 @@ static int vcpu_post_run(struct kvm_vcpu 
>>>>> *vcpu, int exit_reason)
>>>>> ����� vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
>>>>> � ����� atomic_dec(&vcpu->kvm->arch.vcpus_in_sie);
>>>>> +��� if (vcpu->kvm->arch.gib_in_use &&
>>>>> +������� !atomic_fetch_andnot(0, &vcpu->kvm->arch.vcpus_in_sie))
>>>>> +������� vcpu->kvm->arch.gisa->iam = vcpu->kvm->arch.iam;
>>>>
>>>> ... with this. Is it?
>>>
>>> the same here
>>
>> No, here we set the IAM if the interrupt comes after the vCPU sleeps 
>> and before we set the IAM we have a race window.
>>
>> What I mean is: here we should check the IPM bit to be sure not to 
>> loose an interrupt in case the IPM bit is also set.
> 
> The fallback path will be activated by setting the IAM here if no vCPU 
> of the guest is in SIE.
> 
> Yes, the ISC can be set in the IPM in the short window between exiting 
> the SIE and setting the IAM here.
> Do we loose the interruption because of that or is it just delayed? It 
> will be delivered as soon vCPU enters
> the SIE again. Can we speed up this? Maybe yes, that is further tuning.

OK, if the interruptions are delivered to the guest even if AIM is set 
then there is not problem.


> 
>>
>>>>
>>>>
>>>>> � ����� if (exit_reason == -EINTR) {
>>>>> ��������� VCPU_EVENT(vcpu, 3, "%s", "machine check");
>>>>>
>>>
>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
