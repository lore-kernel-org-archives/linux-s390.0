From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Tue, 26 Jan 2016 10:28:46 -0500
Message-ID: <20160126152846.GO3628@mtj.duckdns.org>
References: <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120104758.GD6373@twins.programming.kicks-ass.net>
 <20160120153007.GC5157@mtj.duckdns.org>
 <20160123020313.GA4915@linux.vnet.ibm.com>
 <20160125084942.GA7354@lst.de>
 <20160125193836.GH3628@mtj.duckdns.org>
 <20160126145157.GA31177@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160126145157.GA31177@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Hello, Christoph.

On Tue, Jan 26, 2016 at 03:51:57PM +0100, Christoph Hellwig wrote:
> > That's interesting.  Can you please elaborate on how kill and exit
> > interact to make things complex?
> 
> That we need to first call kill to tear down the reference, then we get
> a release callback which is in the calling context of the last
> percpu_ref_put, but will need to call percpu_ref_exit from process context
> again.  This means if any percpu_ref_put is from non-process context

Hmmm... why do you need to call percpu_ref_exit() from process
context?  All it does is freeing the percpu counter and resetting the
state, both of which can be done from any context.

> we will always need a work_struct or similar to schedule the final
> percpu_ref_exit.  Except when..

I don't think that's true.

> > > be a percpu_ref_exit_sync that kills the ref and waits for all references
> > > to go away synchronously.
> > 
> > That shouldn't be difficult to implement.  One minor concern is that
> > it's almost guaranteed that there will be cases where the
> > synchronicity is exposed to userland.  Anyways, can you please
> > describe the use case?
> 
> We use this completion scheme where the percpu_ref_exit is done from
> the same context as the percpu_ref_kill which previously waits for
> the last reference drop.  But for these cases exposing the synchronicity
> to the caller (including userland) actually is intentional.
> 
> My use case is a new storage target, broadly similar to the SCSI target,
> which happens to exhibit the same behavior.  In that case we only want
> to return from the teardown function when all I/O on a 'queue' of sorts
> has finished, for example during module removal.

It'd most likely end up doing synchronous destruction in a loop with
each iteration involving a full RCU grace period.  If there can be a
lot of devices, it can add up to a substantial amount of time.  Maybe
it's okay here but I've already been bitten several times by the exact
same issue.

Thanks.

-- 
tejun
