From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 1/2] srcu: Allow use of Tiny/Tree SRCU
 from both process and interrupt context
Date: Tue, 6 Jun 2017 08:58:48 -0700
Message-ID: <20170606155848.GE3721@linux.vnet.ibm.com>
References: <20170605220919.GA27820@linux.vnet.ibm.com>
 <1496700591-30177-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170606105343.ibhzrk6jwhmoja5t@hirez.programming.kicks-ass.net>
 <b77cb817-9ffb-b600-19a9-1de685049c57@redhat.com>
 <bea28cb2-162c-57c3-1a9c-cc672aff7f1a@de.ibm.com>
 <20170606152705.GD6681@osiris>
 <01328b70-38fa-384d-d75a-3d615ef3244c@de.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <01328b70-38fa-384d-d75a-3d615ef3244c@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 06, 2017 at 05:37:05PM +0200, Christian Borntraeger wrote:
> On 06/06/2017 05:27 PM, Heiko Carstens wrote:
> > On Tue, Jun 06, 2017 at 04:45:57PM +0200, Christian Borntraeger wrote:
> >> Adding s390 folks and list
> >>>> Only s390 is TSO, arm64 is very much a weak arch.
> >>>
> >>> Right, and thus arm64 can implement a fast this_cpu_inc using LL/SC.
> >>> s390 cannot because its atomic_inc has implicit memory barriers.
> >>>
> >>> s390's this_cpu_inc is *faster* than the generic one, but still pretty slow.
> >>
> >> FWIW, we improved the performance of local_irq_save/restore some time ago
> >> with commit 204ee2c5643199a2 ("s390/irqflags: optimize irq restore") and
> >> disable/enable seem to be reasonably fast (3-5ns on my system doing both
> >> disable/enable in a loop) on todays systems. So  I would assume that the
> >> generic implementation would not be that bad. 
> >>
> >> A the same time, the implicit memory barrier of the atomic_inc should be
> >> even cheaper. In contrast to x86, a full smp_mb seems to be almost for
> >> free (looks like <= 1 cycle for a bcr 14,0 and no contention). So I
> >> _think_ that this should be really fast enough.
> >>
> >> As a side note, I am asking myself, though, why we do need the
> >> preempt_disable/enable for the cases where we use the opcodes 
> >> like lao (atomic load and or to a memory location) and friends.
> > 
> > Because you want the atomic instruction to be executed on the local cpu for
> > which you have to per cpu pointer. If you get preempted to a different cpu
> > between the ptr__ assignment and lan instruction it might be executed not
> > on the local cpu. It's not really a correctness issue.
> > 
> > #define arch_this_cpu_to_op(pcp, val, op)				\
> > {									\
> > 	typedef typeof(pcp) pcp_op_T__;					\
> > 	pcp_op_T__ val__ = (val);					\
> > 	pcp_op_T__ old__, *ptr__;					\
> > 	preempt_disable();						\
> > 	ptr__ = raw_cpu_ptr(&(pcp));					\
> > 	asm volatile(							\
> > 		op "	%[old__],%[val__],%[ptr__]\n"			\
> > 		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
> > 		: [val__] "d" (val__)					\
> > 		: "cc");						\
> > 	preempt_enable();						\
> > }
> > 
> > #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
> > 
> > However in reality it doesn't matter at all, since all distributions we
> > care about have preemption disabled.
> > 
> > So this_cpu_inc() should just generate three instructions: two to calculate
> > the percpu pointer and an additional asi for the atomic increment, with
> > operand specific serialization. This is supposed to be a lot faster than
> > disabling/enabling interrupts around a non-atomic operation.
> > 
> > But maybe I didn't get the point of this thread :)
> 
> I think on x86 a memory barrier is relatively expensive (e.g. 33 cycles for mfence
> on Haswell according to http://www.agner.org/optimize/instruction_tables.pdf). The 
> thread started with a change to rcu, which now happens to use these percpu things
> more often so I think Paolos fear is that on s390 we now pay the price for an extra
> memory barrier due to that change. For the inc case (asi instruction) this should be
> really really cheap.

So what I am seeing from this is that there aren't any real performance
issues for this patch series.  I will update accordingly.  ;-)

						Thanx, Paul
