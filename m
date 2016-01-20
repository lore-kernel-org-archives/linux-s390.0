From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Wed, 20 Jan 2016 08:07:40 +0100
Message-ID: <20160120070740.GA3395@osiris>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org>
 <5698A023.9070703@de.ibm.com>
 <56990C9E.7020801@de.ibm.com>
 <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com>
 <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119193845.GT3520@mtj.duckdns.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 19, 2016 at 02:38:45PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 19, 2016 at 08:36:18PM +0100, Christian Borntraeger wrote:
> > No, its not a task_struct. Activating some more debug information did indeed 
> > revealed several other issues (overwritten redzones etc). Unfortunately I 
> > only saw the broken things after the facts, so I do not know which code did that.
> > When I disabled the cgroup controllers in libvirt I was no longer able to trigger
> > the bugs. Still trying to narrow things down.
> 
> Hmmm... that's worrying.  CONFIG_DEBUG_PAGEALLOC sometimes can catch
> these sort of bugs red-handed.  Might worth trying.

Christian, just to avoid that you get surprised like I did:
CONFIG_DEBUG_PAGEALLOC requires in the meantime an additional kernel
parameter "debug_pagealloc=on" to be active.

That change was introduced a year ago, so it was probably only me who
wasn't aware of that change :)
