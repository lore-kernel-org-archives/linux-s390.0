From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 1/2] srcu: Allow use of Tiny/Tree SRCU
 from both process and interrupt context
Date: Tue, 6 Jun 2017 18:15:51 +0200
Message-ID: <20170606161551.dy5lr6mo6vqujk5d@hirez.programming.kicks-ass.net>
References: <20170605220919.GA27820@linux.vnet.ibm.com>
 <1496700591-30177-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170606105343.ibhzrk6jwhmoja5t@hirez.programming.kicks-ass.net>
 <b77cb817-9ffb-b600-19a9-1de685049c57@redhat.com>
 <bea28cb2-162c-57c3-1a9c-cc672aff7f1a@de.ibm.com>
 <20170606152705.GD6681@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606152705.GD6681@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 06, 2017 at 05:27:06PM +0200, Heiko Carstens wrote:
> On Tue, Jun 06, 2017 at 04:45:57PM +0200, Christian Borntraeger wrote:

> > As a side note, I am asking myself, though, why we do need the
> > preempt_disable/enable for the cases where we use the opcodes 
> > like lao (atomic load and or to a memory location) and friends.
> 
> Because you want the atomic instruction to be executed on the local cpu for
> which you have to per cpu pointer. If you get preempted to a different cpu
> between the ptr__ assignment and lan instruction it might be executed not
> on the local cpu. It's not really a correctness issue.

As per the previous email, I think it is a correctness issue wrt CPU
hotplug.

> 
> #define arch_this_cpu_to_op(pcp, val, op)				\
> {									\
> 	typedef typeof(pcp) pcp_op_T__;					\
> 	pcp_op_T__ val__ = (val);					\
> 	pcp_op_T__ old__, *ptr__;					\
> 	preempt_disable();						\
> 	ptr__ = raw_cpu_ptr(&(pcp));					\
> 	asm volatile(							\
> 		op "	%[old__],%[val__],%[ptr__]\n"			\
> 		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
> 		: [val__] "d" (val__)					\
> 		: "cc");						\
> 	preempt_enable();						\
> }
> 
> #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
> 
> However in reality it doesn't matter at all, since all distributions we
> care about have preemption disabled.

Well, either you support PREEMPT=y or you don't :-) If you do, it needs
to be correct, irrespective of what distro's do with it.

> So this_cpu_inc() should just generate three instructions: two to calculate
> the percpu pointer and an additional asi for the atomic increment, with
> operand specific serialization. This is supposed to be a lot faster than
> disabling/enabling interrupts around a non-atomic operation.

So typically we joke about s390 that it has an instruction for this
'very-complicated-thing', but here you guys do not, what gives? ;-)
