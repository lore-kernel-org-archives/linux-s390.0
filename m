Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfIWPvF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Sep 2019 11:51:05 -0400
Date: Mon, 23 Sep 2019 17:48:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190923154852.GG2369@hirez.programming.kicks-ass.net>
References: <1568724534-146242-1-git-send-email-linyunsheng@huawei.com>
 <20190923151519.GE2369@hirez.programming.kicks-ass.net>
 <20190923152856.GB17206@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923152856.GB17206@dhcp22.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On Mon, Sep 23, 2019 at 05:28:56PM +0200, Michal Hocko wrote:
> On Mon 23-09-19 17:15:19, Peter Zijlstra wrote:

> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 4123100e..9859acb 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -861,6 +861,9 @@ void numa_remove_cpu(int cpu)
> > >   */
> > >  const struct cpumask *cpumask_of_node(int node)
> > >  {
> > > +	if (node == NUMA_NO_NODE)
> > > +		return cpu_online_mask;
> > 
> > This mandates the caller holds cpus_read_lock() or something, I'm pretty
> > sure that if I put:
> > 
> > 	lockdep_assert_cpus_held();
> 
> Is this documented somewhere?

No idea... common sense :-)

> Also how does that differ from a normal
> case when a proper node is used? The cpumask will always be dynamic in
> the cpu hotplug presence, right?

As per normal yes, and I'm fairly sure there's a ton of bugs. Any
'online' state is subject to change except when you're holding
sufficient locks to stop it.

Disabling preemption also stabilizes it, because cpu unplug relies on
stop-machine.

> > here, it comes apart real quick. Without holding the cpu hotplug lock,
> > the online mask is gibberish.
> 
> Can the returned cpu mask go away?

No, the cpu_online_mask itself has static storage, the contents OTOH can
change at will. Very little practical difference :-)
