From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Wed, 20 Jan 2016 11:04:35 -0500
Message-ID: <20160120160435.GD5157@mtj.duckdns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160120153007.GC5157@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 20, 2016 at 10:30:07AM -0500, Tejun Heo wrote:
> > So the current place in free_fair_sched_group() is far too late to be
> > calling remove_entity_load_avg(). But I'm not sure where I should put
> > it, it needs to be in a place where we know the group is going to die
> > but its parent is guaranteed to still exist.
> > 
> > Would offline be that place?
> 
> Hmmm... css_free would be with the following patch.

I thought a bit more about this and I think the right thing to do here
is making both css_offline and css_free follow the ancestry order.
I'll post a patch to do that soon.  offline is called at the head of
destruction when the css is made invisble and draining of existing
refs starts.  free at the end of that process.  Tree ordering
shouldn't be where the two differ.

Thanks.

-- 
tejun
