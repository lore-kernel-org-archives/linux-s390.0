From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Tue, 3 May 2016 10:46:41 +0200
Message-ID: <57286571.2010600@de.ibm.com>
References: <1462185753-14634-1-git-send-email-borntraeger@de.ibm.com>
 <CALzav=cht2EtCyEryOWrpDY+dciN1dB+7SGaNMiS_TayhtzK+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CALzav=cht2EtCyEryOWrpDY+dciN1dB+7SGaNMiS_TayhtzK+g@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 05/02/2016 09:44 PM, David Matlack wrote:
> On Mon, May 2, 2016 at 3:42 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> Radim, Paolo,
>>
>> can you have a look at this patch? If you are ok with it, I want to
>> submit this patch with my next s390 pull request. It touches KVM common
>> code, but I tried to make it a nop for everything but s390.
>>
>> Christian
>>
>> ----snip----
>>
>>
>> Some wakeups should not be considered a sucessful poll. For example on
>> s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
>> would be considered runnable - letting all vCPUs poll all the time for
>> transactional like workload, even if one vCPU would be enough.
>> This can result in huge CPU usage for large guests.
>> This patch lets architectures provide a way to qualify wakeups if they
>> should be considered a good/bad wakeups in regard to polls.
>>
>> For s390 the implementation will fence of halt polling for anything but
>> known good, single vCPU events. The s390 implementation for floating
>> interrupts does a wakeup for one vCPU, but the interrupt will be delivered
>> by whatever CPU comes first.
> 
> Can the delivery of the floating interrupt to the "first CPU" be done
> by kvm_vcpu_check_block? If so, then kvm_vcpu_check_block can return
> false for all other CPUs and the polling problem goes away.
> 

The delivery of interrupts is always done inside the __vcpu_run function.
So when we leave kvm_vpcu_block we will come back to __vcpu_run and 
deliver pending interrupts (if not masked by PSW or control registers) 
according to their priority. 
I remember that some time ago we had a reason why we could not deliver
in kvm_vcpu_block but I forgot why :-/



>> To limit the halt polling we only mark the
>> woken up CPU as a valid poll. This code will also cover several other
>> wakeup reasons like IPI or expired timers. This will of course also mark
>> some events as not sucessful. As  KVM on z runs always as a 2nd level
>> hypervisor, we prefer to not poll, unless we are really sure, though.
>>
>> So we start with a minimal set and will provide additional patches in
>> the future that mark additional code paths as valid wakeups, if that
>> turns out to be necessary.
>>
>> This patch successfully limits the CPU usage for cases like uperf 1byte
>> transactional ping pong workload or wakeup heavy workload like OLTP
>> while still providing a proper speedup.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Reviewed-By: David Matlack <dmatlack@google.com>
> (I reviewed the non-s390 case, to make sure that this change is a nop.)
> 
> Request to be cc'd on halt-polling patches in the future. Thanks!

Sure.
