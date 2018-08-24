Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
References: <20180822095310.29145-1-david@redhat.com>
 <7c7e52aa-7b07-d146-ac4e-2b1afea6a83d@de.ibm.com>
 <b613c011-67f0-317d-c430-cdccfbded46f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Aug 2018 08:34:43 +0200
MIME-Version: 1.0
In-Reply-To: <b613c011-67f0-317d-c430-cdccfbded46f@redhat.com>
Content-Language: en-US
Message-Id: <d8ab5075-c589-8a0b-516c-9cff79522abb@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/23/2018 07:44 PM, David Hildenbrand wrote:
> On 23.08.2018 17:43, Christian Borntraeger wrote:
>>
>>
>> On 08/22/2018 11:53 AM, David Hildenbrand wrote:
>>> When DATA exceptions and vector-processing exceptions (program interrupts)
>>> are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
>>> enabled in CR0.
>>>
>>> This can happen inside KVM when reinjecting an interrupt during program
>>> interrupt intercepts. These are triggered for example when debugging the
>>> guest (concurrent PER events result in an intercept instead of an
>>> injection of such interrupts).
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>
>>> Only compile-tested.
>>
>> I checked the Linux code (arch/s390/kernel/traps.c) and Linux uses the FPC (and
>> not the lowcore field) to decide about the signal (SIGFPE) and si_code. So we want
>> to have the correct DXC/VXC value.
>>
>> Now, I wrote a short test program that does
>> feenableexcept(FE_DIVBYZERO);
>> and a division by zero.
>> and attached gdb to that guest together with a breakpoint on the divide (and the instruction
>> after).
>> I get the pint exit for the instruction after (as it is suppressing) and at this point in
>> time the guest fpc already contains the correct DXC value. So you patch will certainly not
>> hurt, but it seems not necessary.
> 
> Thanks for trying. Wonder if that is documented behavior or just works
> by pure luck.


My guess is, that this is works as designed. There is the interruption
parameter block that is used instead of the guest lowcore for program
interrupt exits. To me it looks like that everything is "prepared" except
for the psw swap itself and the data in the lowcore. The data is written 
to the interruption parameter block instead. So that the hypervisor then
just has to move the data and do the psw swap. 

> 
> E.g. it would be interesting to see what other instructions do that
> usually don't touch the DXC, except when injecting an exception. E.g. CRT.
> 
> But if you believe this is not needed, we can also drop it. (if ever
> somebody would want to inject from QEMU, he could also just set the fpc
> directly)

The (unlikely to ever happen) inject from QEMU is indeed a thing where this
patch would simplify things.

I will talk to some hardware folks to verify my assumption but for the time
being, lets drop this patch.


> 
>>
>> Still trying to look further if I missed something.
>>
>>>
>>>  arch/s390/include/asm/ctl_reg.h | 1 +
>>>  arch/s390/kvm/interrupt.c       | 8 ++++++++
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
>>> index 4600453536c2..88f3f14baee9 100644
>>> --- a/arch/s390/include/asm/ctl_reg.h
>>> +++ b/arch/s390/include/asm/ctl_reg.h
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/const.h>
>>>  
>>>  #define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
>>> +#define CR0_AFP_REGISTER_CONTROL	_BITUL(63 - 45)
>>>  #define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
>>>  #define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
>>>  #define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>> index fcb55b02990e..5b5754d8f460 100644
>>> --- a/arch/s390/kvm/interrupt.c
>>> +++ b/arch/s390/kvm/interrupt.c
>>> @@ -765,6 +765,14 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>>>  		break;
>>>  	case PGM_VECTOR_PROCESSING:
>>>  	case PGM_DATA:
>>> +		if (vcpu->arch.sie_block->gcr[0] & CR0_AFP_REGISTER_CONTROL) {
>>> +			/* make sure the new fpc will be lazily loaded */
>>> +			save_fpu_regs();
>>> +			/* the DXC/VXC cannot make the fpc invalid */
>>> +			current->thread.fpu.fpc &= ~0xff00u;
>>> +			current->thread.fpu.fpc |= (pgm_info.data_exc_code << 8)
>>> +						   & 0xff00u;
>>
>> maybe reuse  FPC_DXC_MASK instead of 0xff00 ?
>>
> 
> Sure, didn't know about that.
> 
> 
