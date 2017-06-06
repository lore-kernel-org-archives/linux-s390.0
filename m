From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 1/2] srcu: Allow use of Tiny/Tree SRCU
 from both process and interrupt context
Date: Tue, 6 Jun 2017 16:45:57 +0200
Message-ID: <bea28cb2-162c-57c3-1a9c-cc672aff7f1a@de.ibm.com>
References: <20170605220919.GA27820@linux.vnet.ibm.com>
 <1496700591-30177-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170606105343.ibhzrk6jwhmoja5t@hirez.programming.kicks-ass.net>
 <b77cb817-9ffb-b600-19a9-1de685049c57@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b77cb817-9ffb-b600-19a9-1de685049c57@redhat.com>
Content-Language: en-IE
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Adding s390 folks and list

On 06/06/2017 03:08 PM, Paolo Bonzini wrote:
> 
> 
> On 06/06/2017 12:53, Peter Zijlstra wrote:
>> On Mon, Jun 05, 2017 at 03:09:50PM -0700, Paul E. McKenney wrote:
>>> There would be a slowdown if 1) fast this_cpu_inc is not available and
>>> cannot be implemented (this usually means that atomic_inc has implicit
>>> memory barriers),
>>
>> I don't get this.
>>
>> How is per-cpu crud related to being strongly ordered?
>>
>> this_cpu_ has 3 forms:
>>
>> 	x86:		single instruction
>> 	arm64,s390:	preempt_disable()+atomic_op
>> 	generic:	local_irq_save()+normal_op
>>
>> Only s390 is TSO, arm64 is very much a weak arch.
> 
> Right, and thus arm64 can implement a fast this_cpu_inc using LL/SC.
> s390 cannot because its atomic_inc has implicit memory barriers.
> 
> s390's this_cpu_inc is *faster* than the generic one, but still pretty slow.

FWIW, we improved the performance of local_irq_save/restore some time ago
with commit 204ee2c5643199a2 ("s390/irqflags: optimize irq restore") and
disable/enable seem to be reasonably fast (3-5ns on my system doing both
disable/enable in a loop) on todays systems. So  I would assume that the
generic implementation would not be that bad. 

A the same time, the implicit memory barrier of the atomic_inc should be
even cheaper. In contrast to x86, a full smp_mb seems to be almost for
free (looks like <= 1 cycle for a bcr 14,0 and no contention). So I
_think_ that this should be really fast enough.

As a side note, I am asking myself, though, why we do need the
preempt_disable/enable for the cases where we use the opcodes 
like lao (atomic load and or to a memory location) and friends.

> 
>>>                   and 2) local_irq_save/restore is slower than disabling
>>> preemption.  The main architecture with these constraints is s390, which
>>> however is already paying the price in __srcu_read_unlock and has not
>>> complained.
>>
>> IIRC only PPC (and hopefully soon x86) has a local_irq_save() that is as
>> fast as preempt_disable().
> 
> 1 = arch-specific this_cpu_inc is available
> 2 = local_irq_save/restore as fast as preempt_disable/enable
> 
> If either 1 or 2 are true, this patch makes SRCU faster or equal
> 
> x86 (single instruction): 1 = true, 2 = false   -> ok
> arm64 (weakly ordered):   1 = true, 2 = false   -> ok
> powerpc:                  1 = false, 2 = true   -> ok
> s390:                     1 = false, 2 = false  -> slower
> 
> For other LL/SC architectures, notably arm, fast this_cpu_* ops not yet
> available, but could be written pretty easily.
> 
>>> A valid optimization on s390 would be to skip the smp_mb;
>>> AIUI, this_cpu_inc implies a memory barrier (!) due to its implementation.
>>
>> You mean the s390 this_cpu_inc() in specific, right? Because
>> this_cpu_inc() in general does not imply any such thing.
> 
> Yes, of course, this is only for s390.
> 
> Alternatively, we could change the counters to atomic_t and use
> smp_mb__{before,after}_atomic, as in the (unnecessary) srcutiny patch.
> That should shave a few cycles on x86 too, since "lock inc" is faster
> than "inc; mfence".  For srcuclassic (and stable) however I'd rather
> keep the simple __this_cpu_inc -> this_cpu_inc change.
> 
> Paolo
> 
