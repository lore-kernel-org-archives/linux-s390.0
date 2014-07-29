From: Alexander Graf <agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is
 STOPPED when checking "has_work"
Date: Tue, 29 Jul 2014 13:49:24 +0200
Message-ID: <53D78A44.1060706@suse.de>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com> <1404997839-29038-5-git-send-email-borntraeger@de.ibm.com> <53D654D2.40308@suse.de> <20140728161644.00c09b3f@thinkpad-w530> <2B39547D-B9A3-4509-808C-B0808067ED54@suse.de> <53D78937.3010307@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53D78937.3010307@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


On 29.07.14 13:44, Christian Borntraeger wrote:
> On 28/07/14 16:22, Alexander Graf wrote:
>> On 28.07.2014, at 16:16, David Hildenbrand <dahi@linux.vnet.ibm.com> wrote:
>>
>>>> On 10.07.14 15:10, Christian Borntraeger wrote:
>>>>> From: David Hildenbrand <dahi@linux.vnet.ibm.com>
>>>>>
>>>>> If a cpu is stopped, it must never be allowed to run and no interrupt may wake it
>>>>> up. A cpu also has to be unhalted if it is halted and has work to do - this
>>>>> scenario wasn't hit in kvm case yet, as only "disabled wait" is processed within
>>>>> QEMU.
>>>>>
>>>>> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
>>>>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> This looks like it's something that generic infrastructure should take
>>>> care of, no? How does this work for the other archs? They always get an
>>>> interrupt on the transition between !has_work -> has_work. Why don't we
>>>> get one for s390x?
>>>>
>>>>
>>>> Alex
>>>>
>>>>
>>> Well, we have the special case on s390 as a CPU that is in the STOPPED or the
>>> CHECK STOP state may never run - even if there is an interrupt. It's
>>> basically like this CPU has been switched off.
>>>
>>> Imagine that it is tried to inject an interrupt into a stopped vcpu. It
>>> will kick the stopped vcpu and thus lead to a call to
>>> "kvm_arch_process_async_events()". We have to deny that this vcpu will ever
>>> run as long as it is stopped. It's like a way to "suppress" the
>>> interrupt for such a transition you mentioned.
>> An interrupt kick usually just means we go back into the main loop. From there we check the interrupt bitmap which interrupt to handle. Check out the handling code here:
>>
>>    http://git.qemu.org/?p=qemu.git;a=blob;f=cpu-exec.c;h=38e5f02a307523d99134f4e2e6c51683bb10b45b;hb=HEAD#l580
>>
>> If you just check for the stopped state in here, do_interrupt() will never get called and thus the CPU shouldn't ever get executed. Unless I'm heavily mistaken :).
>>
>>> Later, another vcpu might decide to turn that vcpu back on (by e.g. sending a
>>> SIGP START to that vcpu).
>> Yes, in that case that other CPU generates a signal (a different bit in interrupt_request) and the first CPU would see that it has to wake up and wake up.
>>
>>> I am not sure if such a mechanism/scenario is applicable to any other arch. They
>>> all seem to reset the cs->halted flag if they know they are able to run (e.g.
>>> due to an interrupt) - they have no such thing as "stopped cpus", only
>>> "halted/waiting cpus".
>> There's not really much difference between the two. The only difference from a software point of view is that a "stopped" CPU has its external interrupt bits masked off, no?
> We have
> - wait (wait bit in PSW)
> - disabled wait (wait bit and interrupt fencing in PSW)
> - STOPPED (not related to PSW, state change usually handled via service processor or hypervisor)
>
> I think we have to differentiate between KVM/TCG. On KVM we always do in kernel halt and qemu sees a halted only for STOPPED or disabled wait. TCG has to take care of the normal wait as well.
>
>  From a first glimpse, a disabled wait and STOPPED look similar, but there are (important) differences, e.g. other CPUs get a different a different result from a SIGP SENSE. This makes a big difference, e.g. for Linux guests, that send a SIGP STOP, followed by a SIGP SENSE loop until the CPU is down on hotplug (and shutdown, kexec..) So I think we agree, that handling the cpu states natively makes sense.
>
> The question is now only how to model it correctly without breaking TCG/KVM and reuse as much common code as possible. Correct?
>
> Do I understand you correctly, that your collapsing of stopped and halted is only in the qemu coding sense, IOW maybe we could just modify kvm_arch_process_async_events to consider the STOPPED state, as TCGs sigp implementation does not support SMP anyway?

That works for me, yes.


Alex
