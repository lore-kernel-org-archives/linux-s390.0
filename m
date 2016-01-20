From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Wed, 20 Jan 2016 11:47:58 +0100
Message-ID: <20160120104758.GD6373@twins.programming.kicks-ass.net>
References: <5698A023.9070703@de.ibm.com>
 <56990C9E.7020801@de.ibm.com>
 <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com>
 <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160120103036.GJ6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 20, 2016 at 11:30:36AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 20, 2016 at 11:15:05AM +0100, Christian Borntraeger wrote:
> > [  561.044066] Krnl PSW : 0704e00180000000 00000000001aa1ee (remove_entity_load_avg+0x1e/0x1b8)
> 
> > [  561.044176] ([<00000000001ad750>] free_fair_sched_group+0x80/0xf8)
> > [  561.044181]  [<0000000000192656>] free_sched_group+0x2e/0x58
> > [  561.044187]  [<00000000001ded82>] rcu_process_callbacks+0x3fa/0x928
> 
> Urgh,.. lemme stare at that.

TJ, is css_offline guaranteed to be called in hierarchical order? I
got properly lost in the whole cgroup destroy code. There's endless
workqueues and rcu callbacks there.

So the current place in free_fair_sched_group() is far too late to be
calling remove_entity_load_avg(). But I'm not sure where I should put
it, it needs to be in a place where we know the group is going to die
but its parent is guaranteed to still exist.

Would offline be that place?
