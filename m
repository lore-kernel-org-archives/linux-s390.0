From: Christoph Hellwig <hch@lst.de>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Mon, 25 Jan 2016 09:49:42 +0100
Message-ID: <20160125084942.GA7354@lst.de>
References: <569D3370.6040503@de.ibm.com> <20160119095518.GC3528@osiris> <569E9032.3070903@de.ibm.com> <20160119193845.GT3520@mtj.duckdns.org> <20160120070740.GA3395@osiris> <569F5E29.3090107@de.ibm.com> <20160120103036.GJ6357@twins.programming.kicks-ass.net> <20160120104758.GD6373@twins.programming.kicks-ass.net> <20160120153007.GC5157@mtj.duckdns.org> <20160123020313.GA4915@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160123020313.GA4915@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, hch@lst.de
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 22, 2016 at 06:03:13PM -0800, Paul E. McKenney wrote:
> > Yeah, it's hairy.  I wondered about adding support for bouncing to
> > workqueue in both percpu_ref and rcu which would make things easier to
> > follow.  Not sure how often this pattern happens tho.
> 
> This came up recently offlist for call_rcu(), so that a call to (say)
> call_rcu_schedule_work() would do a schedule_work() after a grace period
> elapsed, invoking the function passed in to call_rcu_schedule_work().
> There are several existing cases that do this, so special-casing it seems
> worthwhile.  Perhaps something vaguely similar would work for percpu_ref.

FYI, my use case was also related to percpu-ref.  The percpu ref API
is unfortunately really hard to use and will almost always involve
a work queue due to the complex interaction between percpu_ref_kill
and percpu_ref_exit.  One thing that would help a lot of callers would
be a percpu_ref_exit_sync that kills the ref and waits for all references
to go away synchronously.
