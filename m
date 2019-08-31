Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37914 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfHaQOf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Aug 2019 12:14:35 -0400
Date: Sat, 31 Aug 2019 18:12:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
Message-ID: <20190831161247.GM2369@hirez.programming.kicks-ass.net>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
 <20190831085539.GG2369@hirez.programming.kicks-ass.net>
 <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, linuxarm@huawei.com

On Sat, Aug 31, 2019 at 06:09:39PM +0800, Yunsheng Lin wrote:
> 
> 
> On 2019/8/31 16:55, Peter Zijlstra wrote:
> > On Sat, Aug 31, 2019 at 01:58:16PM +0800, Yunsheng Lin wrote:
> >> According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
> >> of proximity domain is optional, as below:
> >>
> >> This optional object is used to describe proximity domain
> >> associations within a machine. _PXM evaluates to an integer
> >> that identifies a device as belonging to a Proximity Domain
> >> defined in the System Resource Affinity Table (SRAT).
> > 
> > That's just words.. what does it actually mean?
> 
> It means the dev_to_node(dev) may return -1 if the bios does not
> implement the proximity domain feature, user may use that value
> to call cpumask_of_node and cpumask_of_node does not protect itself
> from node id being -1, which causes out of bound access.

> >> @@ -69,6 +69,12 @@ extern const struct cpumask *cpumask_of_node(int node);
> >>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> >>  static inline const struct cpumask *cpumask_of_node(int node)
> >>  {
> >> +	if (node >= nr_node_ids)
> >> +		return cpu_none_mask;
> >> +
> >> +	if (node < 0 || !node_to_cpumask_map[node])
> >> +		return cpu_online_mask;
> >> +
> >>  	return node_to_cpumask_map[node];
> >>  }
> >>  #endif
> > 
> > I _reallly_ hate this. Users are expected to use valid numa ids. Now
> > we're adding all this checking to all users. Why do we want to do that?
> 
> As above, the dev_to_node(dev) may return -1.
> 
> > 
> > Using '(unsigned)node >= nr_nods_ids' is an error.
> 
> 'node >= nr_node_ids' can be dropped if all user is expected to not call
> cpumask_of_node with node id greater or equal to nr_nods_ids.

you copied my typo :-)

> From what I can see, the problem can be fixed in three place:
> 1. Make user dev_to_node return a valid node id even when proximity
>    domain is not set by bios(or node id set by buggy bios is not valid),
>    which may need info from the numa system to make sure it will return
>    a valid node.
> 
> 2. User that call cpumask_of_node should ensure the node id is valid
>    before calling cpumask_of_node, and user also need some info to
>    make ensure node id is valid.
> 
> 3. Make sure cpumask_of_node deal with invalid node id as this patchset.
> 
> Which one do you prefer to make sure node id is valid, or do you
> have any better idea?
> 
> Any detail advice and suggestion will be very helpful, thanks.

1) because even it is not set, the device really does belong to a node.
It is impossible a device will have magic uniform access to memory when
CPUs cannot.

2) is already true today, cpumask_of_node() requires a valid node_id.

3) is just wrong and increases overhead for everyone.
