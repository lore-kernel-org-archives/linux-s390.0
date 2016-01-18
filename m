From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Mon, 18 Jan 2016 19:32:05 +0100
Message-ID: <20160118183205.GW6357@twins.programming.kicks-ass.net>
References: <56978452.6010606@de.ibm.com>
 <20160114195630.GA3520@mtj.duckdns.org>
 <5698A023.9070703@de.ibm.com>
 <56990C9E.7020801@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56990C9E.7020801@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 15, 2016 at 04:13:34PM +0100, Christian Borntraeger wrote:
> > Yes, the deadlock is gone and the system is still running.
> > After some time I had the following WARN in the logs, though.
> > Not sure yet if that is related.
> > 
> > [25331.763607] DEBUG_LOCKS_WARN_ON(lock->owner != current)
> > [25331.763630] ------------[ cut here ]------------
> > [25331.763634] WARNING: at kernel/locking/mutex-debug.c:80

> I restarted the test with panic_on_warn. Hopefully I can get a dump to check
> which mutex this was.

Hard to reproduce warnings like this tend to point towards memory
corruption. Someone stepped on the mutex value and tickles the sanity
check.

With lockdep and debugging enabled the mutex gets quite a bit bigger, so
it gets more likely to be hit by 'random' corruption.

The locking in seq_read() seems rather straight forward.
