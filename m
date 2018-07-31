From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 31 Jul 2018 12:37:42 +0000
Subject: Re: [PATCH v7 15/22] KVM: s390: interfaces to clear CRYCB masks
Message-Id: <15000473-ffd3-b295-bda2-14e9775f0c4f@linux.ibm.com>
In-Reply-To: <187b1530-540f-79f8-54e1-e73776e1fd7d@linux.ibm.com>
References: <187b1530-540f-79f8-54e1-e73776e1fd7d@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 31/07/2018 14:10, Christian Borntraeger wrote:
>
> On 07/31/2018 01:04 PM, David Hildenbrand wrote:
>> On 31.07.2018 10:56, Pierre Morel wrote:
>>> On 31/07/2018 10:36, David Hildenbrand wrote:
>>>> On 31.07.2018 10:34, Pierre Morel wrote:
>>>>> On 30/07/2018 16:40, Halil Pasic wrote:
>>>>>> On 07/30/2018 01:15 PM, Pierre Morel wrote:
>>>>>>> On 30/07/2018 11:24, David Hildenbrand wrote:
>>>>>>>> On 26.07.2018 21:54, Christian Borntraeger wrote:
>>>>>>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>>>>>
>>>>>>>>> Introduces two new KVM interface to lear the APM, AQM and ADM masks in
>>>>>>>>> the guest's CRYCB.� The VCPUs are taken out of SIE to ensure the
>>>>>>>>> VCPUs do
>>>>>>>>> not get out of synch.
>>>>>>>> s/synch/sync/
>>>>>>>>
>>>>>>>> When will this be called and why?
>>>>>>>>
>>>>>>>> If I read correctly, this can happen while other VCPUs are running
>>>>>>>> (currently in the SIE). Please note that
>>>>>>>> kvm_s390_vcpu_block_all/kvm_s390_vcpu_unblock_all will not care about
>>>>>>>> vSIE. So a CPU inside the vSIE loop will not be hindered of executing
>>>>>>>> the SIE. (because so far, all VCPU requests we handle don't rely on
>>>>>>>> that)
>>>>>>>>
>>>>>>>> So it could happen here, that after this call a vSIE CPU still can
>>>>>>>> access some adapters if we allowed to forward some of them to the
>>>>>>>> nested
>>>>>>>> guest.
>>>>>>> You are right for the principle.
>>>>>>>
>>>>>>> However this function is only called when the mediated device is release
>>>>>>> which is, as we do not support hotplug, when the vfio-device is closed
>>>>>>> and the guest already disappeared.
>>>>>>>
>>>>>>> So I do not think it is useful the way it is currently used.
>>>>>>>
>>>>>>> What about just letting this call and function fall and take more
>>>>>>> time on this problem when we introduce hotplug?
>>>>>>>
>>>>>> The point is, I don't think we can prohibit userspace to close the
>>>>>> vfio device before the VM is teared down (hot-unplug). The idea
>>>>>> was, do the best we can to give up the resources. I was not aware
>>>>>> of the problems with the VSIE.
>>>>>>
>>>>>> QEMU however does make sure there is no hot-unplug. So no user
>>>>>> can observe the problem.
>>>>>>
>>>>>> Halil
>>>>> David,
>>>>> what about if I extend this function to handle
>>>>> the SIE when I introduce the SIE� in patch 20
>>>>> by calling kvm_s390_vsie_kick() ?
>>>>>
>>>> SIE kick is not enough. The semantics of that are simply "please exit
>>>> the SIE to check for any events". It can immediately enter it again
>>>> reusing the old created crycb block. There would have to be some
>>>> additional check. But such stuff is usually prone to races.
>>> I intended to use it in extension of the vcpu_block() so that
>>> when the vsie() is exited the vcpu falls in the SIE which will be blocked.
>>>
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 0eecc9d..4937299 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -1925,9 +1925,13 @@ static void kvm_s390_set_crycb_format(struct kvm
>>> *kvm)
>>>
>>>   �void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>>>   �{
>>> -��� mutex_lock(&kvm->lock);
>>> -��� kvm_s390_vcpu_block_all(kvm);
>>> +��� int i;
>>>
>>> +��� mutex_lock(&kvm->lock);
>>> +��� kvm_for_each_vcpu(i, vcpu, kvm) {
>>> +��� ��� kvm_s390_vcpu_block(vcpu);
>>> +��� ��� kvm_s390_vsie_kick(vcpu);
>>> +��� }
>> No that does not work. The VSIE can be immediately reentered afther the
>> kick with the old crycb block.
> Hmm, shall we change that so that kvm_s390_vcpu_block will also block
> vsie from entering?
>
>
>>
>>>   ���� memset(&kvm->arch.crypto.crycb->apcb0, 0,
>>>   ���� ������ sizeof(kvm->arch.crypto.crycb->apcb0));
>>>   ���� memset(&kvm->arch.crypto.crycb->apcb1, 0,
> I am asking myself if if would be valid to first memset the crycb and then do a kick.
> On reentry sie will then use the new value. I will double check.

The first solution, blocking VSIE, and wait for the vcpu to exit the SCB 
(that I did not do)
(and if it is OK) seems better to me.
The function is called rarely so we may use a dedicated function and let 
the xxx_vcpu_block()
have a short path.



-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
