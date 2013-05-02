From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] [RFC] s390/kvm: note a quiescing state if we interupt
 guest mode
Date: Thu, 02 May 2013 17:32:15 +0200
Message-ID: <518286FF.7060304@de.ibm.com>
References: <1367482192-2753-1-git-send-email-borntraeger@de.ibm.com> <20130502150910.GW3780@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130502150910.GW3780@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Dipankar Sarma <dipankar@in.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Gleb Natapov <gleb@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/05/13 17:09, Paul E. McKenney wrote:
> On Thu, May 02, 2013 at 10:09:52AM +0200, Christian Borntraeger wrote:
>> The SIE instruction is interruptible, so instead of having a guest
>> exit on a host interrupt we basically return to guest mode.
>> We have some logic in the interrupt handler to check for
>> need_resched, machine checks or sigpending to exit SIE the hard
>> way, but RCU is currently not handled, leading to several second
>> delays on cpu bound guests.
>>
>> Lets mark SIE (guest context) as quiescing state in the external
>> interrupt handler (hz tick, timers sigp and others) thus making
>> RCU working properly again.
>>
>> Long term we might want to use proper state tracking (just like
>> the dynticks folks) and mark guest state similar to user space
>> as an extended grace period, but this is not ready yet.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Cc: Dipankar Sarma <dipankar@in.ibm.com>
>> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Gleb Natapov <gleb@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>> ---
> 
> Hmmm...  This looks like an interrupt.  Can it interrupt kernel code?

Yes, it does.

> If it can, then we would need to deal with the possibility of it
> having interrupted an RCU read-side critical section.  If it somehow is
> guaranteed to never interrupt code containing RCU read-side critical
> sections (for example, if it is the exception handler for an SIE
> instruction in cases where the SIE instruction is illegal), then should
> be OK.

My assumption was that checking for PF_VCPU should guarantee that the
interrupted code is not an RCU read-side critical section, but your 
comment regarding exeption handler made me re-think again: We actually 
might end up interrupting a page fault handler even with PF_VCPU, so we
need some other indication than PF_VCPU. Ok, will look into it.

Thanks




> 
> 							Thanx, Paul
> 
>>  arch/s390/kernel/irq.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
>> index 1630f43..d6ccb1d 100644
>> --- a/arch/s390/kernel/irq.c
>> +++ b/arch/s390/kernel/irq.c
>> @@ -244,6 +244,17 @@ void __irq_entry do_extint(struct pt_regs *regs, struct ext_code ext_code,
>>  	int index;
>>
>>  	old_regs = set_irq_regs(regs);
>> +	/*
>> +	 * The SIE instruction is interruptible, so instead of having a guest
>> +	 * exit on a host interrupt we basically return to guest mode if there
>> +	 * is no need_resched, machine check or signal pending. So we can
>> +	 * stay in guest mode for several seconds or even minutes. This
>> +	 * lets RCU wait for a grace period much too long. In case of PF_VCPU
>> +	 * we know that we do not hold any rcu data, so lets claim that a
>> +	 * context switch happened, which is a quiescing state.
>> +	 */
>> +	if (current->flags & PF_VCPU) 
>> +		rcu_sched_qs(smp_processor_id());
>>  	irq_enter();
>>  	if (S390_lowcore.int_clock >= S390_lowcore.clock_comparator) {
>>  		/* Serve timer interrupts first. */
