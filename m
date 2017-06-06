From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 1/2] srcu: Allow use of Tiny/Tree SRCU
 from both process and interrupt context
Date: Tue, 6 Jun 2017 18:12:27 +0200
Message-ID: <20170606161227.kn7ytruky5popjjd@hirez.programming.kicks-ass.net>
References: <20170605220919.GA27820@linux.vnet.ibm.com>
 <1496700591-30177-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20170606105343.ibhzrk6jwhmoja5t@hirez.programming.kicks-ass.net>
 <b77cb817-9ffb-b600-19a9-1de685049c57@redhat.com>
 <bea28cb2-162c-57c3-1a9c-cc672aff7f1a@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bea28cb2-162c-57c3-1a9c-cc672aff7f1a@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, kvm@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 06, 2017 at 04:45:57PM +0200, Christian Borntraeger wrote:
> A the same time, the implicit memory barrier of the atomic_inc should be
> even cheaper. In contrast to x86, a full smp_mb seems to be almost for
> free (looks like <= 1 cycle for a bcr 14,0 and no contention). So I
> _think_ that this should be really fast enough.

So there is a patch out there that changes the x86 smp_mb()
implementation to do "LOCK ADD some_stack_location, 0" which is lots
cheaper than the "MFENCE" instruction and provides similar guarantees.

HPA was running that through some of the architects.. ping?

(Also, I can imagine OoO CPUs collapsing back-to-back ordering stuff,
but what do I know).

> As a side note, I am asking myself, though, why we do need the
> preempt_disable/enable for the cases where we use the opcodes 
> like lao (atomic load and or to a memory location) and friends.

I suspect the real reason is CPU hotplug, because regular preemption
should not matter. It would be the same as getting migrated the moment
_after_ you do the $op.

But preempt_disable() also holds off hotplug and thereby serializes
against hotplug notifiers that want to, for instance, move the value of
the per-cpu variable to a still online CPU. Without this serialization
it would be possible for the $op to happen _after_ the hotplug notifier
runs.
