From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Wed, 20 Jan 2016 11:56:38 -0500
Message-ID: <20160120165638.GE5157@mtj.duckdns.org>
References: <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120104758.GD6373@twins.programming.kicks-ass.net>
 <20160120153007.GC5157@mtj.duckdns.org>
 <20160120160435.GD5157@mtj.duckdns.org>
 <20160120164932.GM6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160120164932.GM6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello, Peter.

On Wed, Jan 20, 2016 at 05:49:32PM +0100, Peter Zijlstra wrote:
> > I thought a bit more about this and I think the right thing to do here
> > is making both css_offline and css_free follow the ancestry order.
> > I'll post a patch to do that soon.  offline is called at the head of
> > destruction when the css is made invisble and draining of existing
> > refs starts.  free at the end of that process.  Tree ordering
> > shouldn't be where the two differ.
> 
> OK, that would be good. Meanwhile the above seems to suggest that
> css_offline is already hierarchical?

No, I was thinking just fixing css_free and leaving css_offline
unordered as the latter is more involved.  Will fix both soon.

> I get the feeling the way sched uses the css_{offline,release,free} is
> sub-optimal. cpu_cgrp_subsys::css_free := sched_destroy_group() does a
> call_rcu, whereas if I read the comment with css_free_work_fn()
> correctly, this is already after a grace-period, so yet another doesn't
> make sense.

Here are what the three callbacks do

 css_offline

	The css is no longer visible to userland and it's guaranteed
	that all future css_tryget_online() will fail.

 css_released

	The reference count hit zero and css_free will be called on
	the css after a RCU grace period.

 css_free

	A RCU grace period has passed after css's last ref is put.
	The css can be freed now.

So, as long as sched adheres to css refcnting, there's no need to do
another RCUing off of css_free.

Thanks.

-- 
tejun
