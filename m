From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 0/5] rcu,nohz,kvm: use RCU extended quiescent state
 when running KVM guest
Date: Fri, 6 Feb 2015 19:20:58 +0100
Message-ID: <20150206182056.GG21905@lerouge>
References: <1423167832-17609-1-git-send-email-riel@redhat.com>
 <54D4D70B.2040300@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D4D70B.2040300@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: riel@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mtosatti@redhat.com, mingo@kernel.orgm, ak@linux.intel.com, oleg@redhat.com, masami.hiramatsu.pt@hitachi.com, paulmck@linux.vnet.ibm.com, lcapitulino@redhat.com, pbonzini@redhat.com, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 06, 2015 at 04:00:27PM +0100, Christian Borntraeger wrote:
> Am 05.02.2015 um 21:23 schrieb riel@redhat.com:
> > When running a KVM guest on a system with NOHZ_FULL enabled, and the
> > KVM guest running with idle=poll mode, we still get wakeups of the
> > rcuos/N threads.
> > 
> > This problem has already been solved for user space by telling the
> > RCU subsystem that the CPU is in an extended quiescent state while
> > running user space code.
> > 
> > This patch series extends that code a little bit to make it usable
> > to track KVM guest space, too.
> > 
> > I tested the code by booting a KVM guest with idle=poll, on a system
> > with NOHZ_FULL enabled on most CPUs, and a VCPU thread bound to a
> > CPU. In a 10 second interval, rcuos/N threads on other CPUs got woken
> > up several times, while the rcuos thread on the CPU running the bound
> > and alwasy running VCPU thread never got woken up once.
> > 
> > Thanks to Christian Borntraeger and Paul McKenney for reviewing the
> > first version of this patch series, and helping optimize patch 4/5.
> 
> I gave it a quick run on s390/kvm and everything still seem to be 
> running fine. A also I like the idea of this patch set.
> 
> We have seen several cases were the fact that we are in guest context
> a full tick for cpu bound guests (10ms on s390) caused significant
> latencies for host synchronize-rcu heavy workload - e.g. getting rid
> of macvtap devices on guest shutdown, adding hundreds of irq routes
> for many guest devices....
> 
> s390 has no context tracking infrastructure yet (no nohz_full), but
> this series looks like that the current case (nohz_idle) still works.
> With this in place, having hohz==full on s390 now even makes more
> sense, as KVM hosts with cpu bound guests should have get much quicker
> rcu response times when most host CPUs are in an extended quiescant
> state.

Sure, if you need any help for context tracking, don't hesitate to ask,
it can be a bit tricky to implement sometimes. Perhaps x86 isn't the
best example because it does quite some weird dances to minimize fast path
overhead. ARM is perhaps clearer.

> 
> Christian
> 
