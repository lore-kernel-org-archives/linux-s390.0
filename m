From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Tue, 21 Feb 2017 20:08:10 +0100
Message-ID: <f8ce0ffd-1580-4e19-83ae-99991a86f236@de.ibm.com>
References: <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
 <20170217151227.GA27770@potion>
 <e55d4aba-6c0b-f188-1632-d7293c857deb@de.ibm.com>
 <b1df82b4-dc77-d152-ca0a-c97741df20dd@redhat.com>
 <6f3d1415-b337-ecff-e56a-02017ea44658@de.ibm.com>
 <71af37f1-c465-f2aa-ad78-ed0acf103c13@redhat.com>
 <f76e2e51-aca0-b95d-9c80-5354d63a270a@de.ibm.com>
 <8c881e51-65f4-100e-fec7-9490b9031d3b@redhat.com>
 <20170220214510.GB3744@potion>
 <8e6785e2-c3d0-cceb-f64f-391cdeec1c17@de.ibm.com>
 <20170221171518.GA28100@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170221171518.GA28100@potion>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 02/21/2017 06:15 PM, Radim Krčmář wrote:
> 2017-02-21 09:59+0100, Christian Borntraeger:
>> On 02/20/2017 10:45 PM, Radim Krčmář wrote:
>>> 2017-02-20 12:35+0100, David Hildenbrand:
>>>> Am 20.02.2017 um 12:12 schrieb Christian Borntraeger:
>>>>> On 02/17/2017 06:10 PM, David Hildenbrand wrote:
>>>>>>
>>>>>>>> Yes, it would.  There's some parallel with QEMU's qemu_cpu_kick, where
>>>>>>>> the signal would be processed immediately after entering KVM_RUN.
>>>>>>>
>>>>>>> Something like 
>>>>>>>
>>>>>>> ---snip-----
>>>>>>>         struct kvm_s390_sie_block *scb = READ_ONCE(vcpu->arch.vsie_block);
>>>>>>>
>>>>>>> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
>>>>>>>         if (scb)
>>>>>>> 		atomic_or(CPUSTAT_STOP_INT, &scb->cpuflags);
>>>>>>> ---snip-----
>>>>>>>
>>>>>>> or 
>>>>>>> ---snip-----
>>>>>>> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
>>>>>>> 	kvm_s390_vsie_kick(vcpu);
>>>>>>> ---snip-----
>>>>>>
>>>>>> I'd go for the latter one. Keep the vsie stuff isolated. Please note
>>>>>
>>>>> Yes makes sense.
>>>>>
>>>>> Radim, if you go with this patch something like this can be used as the
>>>>> s390 variant of kvm_arch_cpu_kick:
>>>>>
>>>>> ---snip---
>>>>> 	/*
>>>>> 	 * The stop indication is reset in the interrupt code. As the CPU
>>>>> 	 * loop handles requests after interrupts, we will
>>>>> 	 * a: miss the request handler and enter the guest, but then the
>>>>> 	 * stop request will exit the CPU and handle the request in the next
>>>>> 	 * round or
>>>>> 	 * b: handle the request directly before entering the guest
>>>>> 	 */
>>>>> 	atomic_or(CPUSTAT_STOP_INT, &vcpu->arch.sie_block->cpuflags);
>>>>> 	kvm_s390_vsie_kick(vcpu);
>>>>>
>>>>> ---snip---
>>>>> feel free to add that to your patch. I can also send a fixup patch later
>>>>> on if you prefer that.
>>>>
>>>> kvm_arch_vcpu_should_kick() then also has to be changed to return 1 for now.
>>>>
>>>> An interesting thing to note is how vcpu->cpu is used.
>>>>
>>>> Again, as s390x can preempt just before entering the guest, vcpu_kick()
>>>> might see vcpu->cpu = -1. Therefore, kvm_arch_vcpu_should_kick() won't
>>>> even be called. So our cpu might go into guest mode and stay there
>>>> longer than expected (as we won't kick it).
>>>>
>>>> On x86, it is the following way:
>>>>
>>>> If vcpu->cpu is -1, no need to kick the VCPU. It will check for requests
>>>> when preemption is disabled, therefore when rescheduled.
>>>>
>>>> If vcpu->cpu is set, kvm_arch_vcpu_should_kick() remembers if the VCPU
>>>> has already been kicked while in the critical section. It will get
>>>> kicked by smp resched as soon as entering guest mode.
>>>>
>>>> So here, disabled preemption + checks in the section with disabled
>>>> preemption (for requests and EXITING_GUEST_MODE) make sure that the
>>>> guest will leave guest mode and process requests in a timely fashion.
>>>>
>>>> On s390x, this is not 100% true. vcpu->cpu cannot be used as an
>>>> indicator whether a kick is necessary. Either that is ok for now, or the
>>>> vcpu->cpu != -1 check has to be disabled for s390x, e.g. by moving the
>>>> check into kvm_arch_vcpu_should_kick().
>>>
>>> Good point.
>>>
>>> So s390 doesn't need vcpu->cpu and only sets it because other arches do?
>>
>> David added it as a sanity check for cpu time accounting while in host. But
>> we do not need it, yes.
>>
>>> And do I understand it correctly that the s390 SIE block operations have
>>> no side-effect, apart from changed memory, when outside of guest-mode?
>>
>> You mean accesses to the sie control block vcpu->arch.sie_block? Yes its just
>> changed memory as long as the VCPU that is backed by this sie control block
>> is not running.
> 
> Great, thanks.
> 
>>> (We have cpu->mode mostly because interrupts are expensive. :])
>>>
>>> In the end, I'd like to use kvm_vcpu_kick() for kvm_s390_vcpu_wakeup().
>>
>> something like this?
>>
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -1067,15 +1067,7 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
>>          * in kvm_vcpu_block without having the waitqueue set (polling)
>>          */
>>         vcpu->valid_wakeup = true;
>> -       if (swait_active(&vcpu->wq)) {
>> -               /*
>> -                * The vcpu gave up the cpu voluntarily, mark it as a good
>> -                * yield-candidate.
>> -                */
>> -               vcpu->preempted = true;
>> -               swake_up(&vcpu->wq);
>> -               vcpu->stat.halt_wakeup++;
>> -       }
>> +       kvm_vcpu_wake_up(vcpu);
>>         /*
>>          * The VCPU might not be sleeping but is executing the VSIE. Let's
>>          * kick it, so it leaves the SIE to process the request.
> 
> Yes, and ideally also covering the SIE kick, so the result would be
> 
>   {
>   	vcpu->valid_wakeup = true;
>  +	kvm_vcpu_kick(vcpu);
>   }
> 

No we do not want to replace kvm_s390_vcpu_wakeup with the generic SIE kick. the
stop exit will exit the guest unconditionally. As kvm_s390_vcpu_wakeup is also called 
after queuing interrupts we want to use the special exits for the different interrupt
types that wait with the guest exits until that interrupt is enabled by the guest. (e.g.
not when running in local_irq_disable)
So I think it does not make sense to replace this with the generic kvm_vcpu_wake_up
if we need the kick.


>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2213,6 +2213,7 @@ void kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>>         wqp = kvm_arch_vcpu_wq(vcpu);
>>         if (swait_active(wqp)) {
>>                 swake_up(wqp);
>> +               vcpu->preempted = true;
>>
>>                 ++vcpu->stat.halt_wakeup;
>>         }
>>
>>> s390 sets vcpu->preempted to get a performance boost, which makes
>>> touching it less than desirable ...
>>> On s390, vcpu->preempted is only used in __diag_time_slice_end(), which
>>> seems to be a type of spinning-on-a-taken-lock hypercall -- any reason
>>> why that optimization shouldn't work on other architectures?
>>
>> We set preempted in kvm_s390_vcpu_wakeup because otherwise a cpu that sleeps
>> (halted) would not be considered as a good candidate in kvm_vcpu_on_spin,
>> even if we just decided to wakeup that CPU for an interrupt.
>>
>> Yes, it certainly makes sense to do that in kvm_vcpu_wake_up as well.
> 
> I assume that s390 doesn't go to sleep while holding a spinlock, so it

Yes x86 and s390 do not sleep in atomic contexts. Both spin for a while 
and exit after some time into kvm_vcpu_on_on (*) We try to find a good 
candidate for yielding and then sleep due to the yield. But a normal 
spinlock does not cause a halt (or a wait PSW).

(*) all modern s390 Linuxes now use the directed yield hypercall for
spinlocks (see diag 9c) so the diag 44 is only relevant for stop machine
run.

> would mean that we need to update kvm_vcpu_on_spin().
> (Ignoring a formerly sleeping VCPU as a candidate made sense: the VCPU
>  shouldn't have been holding a lock that is blocking the spinning VCPU.)

Yes, if the yielding wants to boost the lock holder, indeed ignoring
a sleeping cpu sounds like a good idea. In reality things are more complicated
and lock holder preemption is especially nasty with many VCPUs. In that case
we want to also boost these CPUs that are delivering interrupts.
We had several performance issues with some workloads that were fixed by this
in commit 9cac38dd5dc41c943d711b96f9755a29c8b854ea
    KVM/s390: Set preempted flag during vcpu wakeup and interrupt delivery

so it turned out to be better this way for a semop intense workload back then.

 
> Boosting a VCPU that is likely not going to use the contended spinlock
> seems like a good thing to try.  I think we don't need vcpu->preempted
> in its current form then.  After the change, it it would be false only
> in two cases:
>  1) the VCPU task is currently scheduled on some CPU
>  2) the VCPU is sleeping
> 
> There might be some other way know (1) (or we can adapt vcpu->preempted
> to vcpu->scheduled) and (2) is done with swait_active().
> 
> Sadly, any change of kvm_vcpu_on_spin() is going to need many days of
> testing ...

Yes, this requires a lot of tuning. Maybe we should just stick with the
minimal changes then?
