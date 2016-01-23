From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Fri, 22 Jan 2016 18:03:13 -0800
Message-ID: <20160123020313.GA4915@linux.vnet.ibm.com>
References: <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com>
 <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120104758.GD6373@twins.programming.kicks-ass.net>
 <20160120153007.GC5157@mtj.duckdns.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160120153007.GC5157@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, hch@lst.de
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 20, 2016 at 10:30:07AM -0500, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jan 20, 2016 at 11:47:58AM +0100, Peter Zijlstra wrote:
> > TJ, is css_offline guaranteed to be called in hierarchical order? I
> 
> No, they aren't.  The ancestors of a css are guaranteed to stay around
> until css_free is called on the css and that's the only ordering
> guarantee.
> 
> > got properly lost in the whole cgroup destroy code. There's endless
> > workqueues and rcu callbacks there.
> 
> Yeah, it's hairy.  I wondered about adding support for bouncing to
> workqueue in both percpu_ref and rcu which would make things easier to
> follow.  Not sure how often this pattern happens tho.

This came up recently offlist for call_rcu(), so that a call to (say)
call_rcu_schedule_work() would do a schedule_work() after a grace period
elapsed, invoking the function passed in to call_rcu_schedule_work().
There are several existing cases that do this, so special-casing it seems
worthwhile.  Perhaps something vaguely similar would work for percpu_ref.

							Thanx, Paul
