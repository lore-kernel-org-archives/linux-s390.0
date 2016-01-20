From: Tejun Heo <tj@kernel.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Wed, 20 Jan 2016 10:30:07 -0500
Message-ID: <20160120153007.GC5157@mtj.duckdns.org>
References: <56990C9E.7020801@de.ibm.com>
 <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com>
 <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120104758.GD6373@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160120104758.GD6373@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hello,

On Wed, Jan 20, 2016 at 11:47:58AM +0100, Peter Zijlstra wrote:
> TJ, is css_offline guaranteed to be called in hierarchical order? I

No, they aren't.  The ancestors of a css are guaranteed to stay around
until css_free is called on the css and that's the only ordering
guarantee.

> got properly lost in the whole cgroup destroy code. There's endless
> workqueues and rcu callbacks there.

Yeah, it's hairy.  I wondered about adding support for bouncing to
workqueue in both percpu_ref and rcu which would make things easier to
follow.  Not sure how often this pattern happens tho.

> So the current place in free_fair_sched_group() is far too late to be
> calling remove_entity_load_avg(). But I'm not sure where I should put
> it, it needs to be in a place where we know the group is going to die
> but its parent is guaranteed to still exist.
> 
> Would offline be that place?

Hmmm... css_free would be with the following patch.

diff -u b/kernel/cgroup.c work/kernel/cgroup.c
--- b/kernel/cgroup.c
+++ work/kernel/cgroup.c
@@ -4725,14 +4725,14 @@
 
 	if (ss) {
 		/* css free path */
+		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
 
-		if (css->parent)
-			css_put(css->parent);
-
 		ss->css_free(css);
 		cgroup_idr_remove(&ss->css_idr, id);
 		cgroup_put(cgrp);
+		if (parent)
+			css_put(parent);
 	} else {
 		/* cgroup free path */
 		atomic_dec(&cgrp->root->nr_cgrps);


Thanks.

-- 
tejun
