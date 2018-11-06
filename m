From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 06 Nov 2018 18:46:46 +0000
Subject: Re: [PATCH 02/10] KVM: s390: add the GIB and its related life-cyle functions
Message-Id: <4fd3b973-2d65-9355-84f7-47c6d188f0da@linux.ibm.com>
In-Reply-To: <142597db-3a87-9360-5463-f72275c1545f@linux.ibm.com>
References: <142597db-3a87-9360-5463-f72275c1545f@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 06/11/2018 13:06, Michael Mueller wrote:
> 
> 
> On 05.11.18 16:44, Janosch Frank wrote:
>> On 05.11.18 16:36, Halil Pasic wrote:
>>>
>>> On 11/05/2018 04:14 PM, Michael Mueller wrote:
>>>>
>>>> On 05.11.18 15:51, Pierre Morel wrote:
>>>>> On 25/10/2018 14:37, Michael Mueller wrote:
>>> [..]
>>>>>> +
>>>>>> +void kvm_s390_gib_init(u8 nisc)
>>>>>> +{
>>>>>> +��� int rc;
>>>>>> +
>>>>>> +��� if (gib)
>>>>>> +������� return;
>>>>>> +
>>>>>> +��� if (!css_general_characteristics.aiv) {
>>>>>> +������� KVM_EVENT(3, "%s", "gib not initialized, no AIV facility");
>>>>>> +������� return;
>>>>>> +��� }
>>>>>> +
>>>>>> +��� gib = (struct kvm_s390_gib *)get_zeroed_page(GFP_KERNEL | 
>>>>>> GFP_DMA);
>>>>>> +��� if (!gib) {
>>>>>> +������� KVM_EVENT(3, "%s", "gib memory allocation failed");
>>>>>> +������� return;
>>>>>> +��� }
>>>>> Why should we survive this error?
>>>> Design question.
>>>>
>>> I'm with Pierre on this one. We should fail starting the guest
>>> if this allocation fails.
>>>
>> Halil, the GIB is global to KVM, we would need to fail loading/init of
>> KVM, which I'd like to avoid.
>>
>> Neither GIB nor gisa is necessary for a VM to run, so we shouldn't stop
>> on an error.
> 
> I changed the design such that kvm_s390_gib_init() fails and thus 
> kvm_arch_init() as well
> in all error cases except facility AIV is *not* available. This is also 
> a success case but no GIB
> is initialized.

OK, seems right.

> 
>>
>>>>>
>>>>>> +
>>>>>> +��� gib->nisc = nisc;
>>>>>> +��� rc = chsc_sgib((u32)(u64)gib);
>>>>>> +��� if (rc) {
>>>>>> +������� KVM_EVENT(3, "gib 0x%pK AIV association failed rc: %d",
>>>>>> +������������� gib, rc);
>>>>>> +������� free_page((unsigned long)gib);
>>>>>> +������� gib = NULL;
>>>>>> +������� return;
>>>>>> +��� }
>>>>> or this failure ?
>>>>>
>>>>> shouldn't we better return an error and abort loading KVM?
>>>> Design question.
>>>>
>>> Same here I guess. This would be only either due to a guest or
>>> a host bug, or?
>>>
>>> I would prefer being fairly deterministic about whether we do have
>>> a gib or not.
>> Same as above
> 
> see above
> 
>>> Regards,
>>> Halil
>>>
>>
> 


-- 
Pierre Morel
Linux/KVM/QEMU in B�blingen - Germany
