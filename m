From: David Hildenbrand <david@redhat.com>
Date: Fri, 23 Nov 2018 10:23:19 +0000
Subject: Re: [PATCH v2 01/12] KVM: s390: leave AIs in IPM of GISA during vcpu_pre_run()
Message-Id: <9243314f-4ac5-9c01-7bf7-248b6a31d4ea@redhat.com>
In-Reply-To: <00c4ea1a-9baf-9416-8e4f-808a5c2bb713@linux.ibm.com>
References: <00c4ea1a-9baf-9416-8e4f-808a5c2bb713@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 23.11.18 10:00, Pierre Morel wrote:
> On 23/11/2018 09:50, David Hildenbrand wrote:
>> On 23.11.18 09:37, Michael Mueller wrote:
>>>
>>>
>>> On 22.11.18 18:33, Pierre Morel wrote:
>>>> On 22/11/2018 17:38, David Hildenbrand wrote:
>>>>> On 22.11.18 12:21, Michael Mueller wrote:
>>>>>>
>>>>>>
>>>>>> On 21.11.18 22:05, Halil Pasic wrote:
>>>>>>> On Tue, 20 Nov 2018 13:00:03 +0100
>>>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>>> On 20.11.18 12:33, Cornelia Huck wrote:
>>>>>>>>> On Mon, 19 Nov 2018 18:25:25 +0100
>>>>>>>>> Michael Mueller <mimu@linux.ibm.com> wrote:
>>>>>>>>>
>>>>>>>>>> Do not call __deliver_io() for adapter interruptions already
>>>>>>>>>> pending in the IPM. That is a double effort. They will
>>>>>>>>>> be processed as soon the vcpu control is given to SIE.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>>>>>>>>> ---
>>>>>>>>>>  �� arch/s390/kvm/interrupt.c | 54
>>>>>>>>>> ++++++++++++++++++++++------------------------- 1 file changed, 25
>>>>>>>>>> insertions(+), 29 deletions(-)
>>>>>>>>> I think this patch does what it says on the tin, but I'm a bit lost
>>>>>>>>> as to the why. (Might make more sense with the gib.)
>>>>>>>>>
>>>>>>>>> Currently, we are trying to process any I/O interrupts, even if we'd
>>>>>>>>> get them delivered via the gisa, when we're out of the SIE anyway.
>>>>>>>>> IIRC, while this looks a bit like a belt-and-suspenders approach, it
>>>>>>>>> also prevented performance problems when the vcpu did not go back
>>>>>>>>> into the SIE immediately (it even may exit to userspace).
>>>>>>>>>
>>>>>>>>> Also, if you're ignoring the I/O interrupts pending in the ipm, you
>>>>>>>>> may end up delivering interrupts with a lower priority (higher isc)
>>>>>>>>> first. I'm not sure that's what we want.
>>>>>>>>>
>>>>>>>>> But maybe I'm just missing another bit of the code that makes this
>>>>>>>>> safe. Can you elaborate a bit?
>>>>>>>>>
>>>>>>>> For interrupt priorities to work at least somewhat predictable, we
>>>>>>>> should always try to inject all interrupts even if the HW would be
>>>>>>>> doing it for us. In the order of priority.
>>>>>>>>
>>>>>>>> But we don't have the same thing for external calls injected via SCA.
>>>>>>>> I remember that I once had a patch lying around a couple of years ago
>>>>>>>> to fix that ... it went missing :)
>>>>>>>>
>>>>>>>> IO interrupt almost have lowest priority, so letting the HW inject
>>>>>>>> them could be problematic when mixing IO interrupt priorities between
>>>>>>>> SW and HW injected ones (hat Conny described).
>>>>>>>>
>>>>>>>> There are other corner cases if a e.g. a RESTART interrupt is pending
>>>>>>>> for that CPU. We would deliver eventually the RESTART interrupt before
>>>>>>>> delivering the IO interrupt, which would be wrong.
>>>>>>>>
>>>>>>> I do share David's concern. Could somebody try to explain why this
>>>>>>> RESTART scenario David described is not actually a problem -- AFAIU it
>>>>>>> is a problem.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Halil
>>>>>>>
>>>>>> Before I start arguing why this is *not* a problem I ask you both why
>>>>>> you consider
>>>>>> this being a problem. We are talking about the CPU restart� here, right?
>>>>>>
>>>>>>
>>>>>
>>>>> When sending a restart interrupt to a running CPU (e.g. system_reset) an
>>>>> IO interrupt might remain pending and not delivered.
>>>>>
>>>>> One could make a guess how bad that is (depending on the type of guest
>>>>> and use case), however it is guest observable difference to what is
>>>>> documented in the PoP. Restart interrupt has (almost) lowest priority.
>>>>>
>>>>
>>>> I do not see the priority as a problem.
>>>> RESET and IO IRQ are asynchronous from each other anyway.
>>>>
>>>> But there I see another issue that your question point.
>>>>
>>>> Generally, on system RESET all peripheral also get a RESET and all
>>>> interrupt are cleared.
>>>> This is the case for AP VFIO devices.
>>>> This is the case for local interrupts.
>>
>> Please don't confuse SIGP RESTART (e.g. RESTART interrupt any CPU can
>> happily send to another CPU) with system resets.
> 
> I do not, you were speaking about system_reset.
> And I answered on this.

I think I was confused. "nmi" uses RESTART interrupts from "external".
"system_reset" does not use RESTART interrupts on the QEMU side. (so the
example I gave was both confusing and wrong :) )

In Linux, restart interrupts are used for multiple purposes (hibernation
restore, bringing up CPUs, kdump).

Not sure if the priority thingy could be a problem there (I guess not,
but I am not sure yet about the implications).

-- 

Thanks,

David / dhildenb
