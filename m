Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48768 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439119AbfIXMo7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Sep 2019 08:44:59 -0400
Date: Tue, 24 Sep 2019 14:43:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190924124325.GQ2349@hirez.programming.kicks-ass.net>
References: <20190923154852.GG2369@hirez.programming.kicks-ass.net>
 <20190923165235.GD17206@dhcp22.suse.cz>
 <20190923203410.GI2369@hirez.programming.kicks-ass.net>
 <20190924074751.GB23050@dhcp22.suse.cz>
 <20190924091714.GJ2369@hirez.programming.kicks-ass.net>
 <20190924105622.GH23050@dhcp22.suse.cz>
 <20190924112349.GJ2332@hirez.programming.kicks-ass.net>
 <20190924115401.GM23050@dhcp22.suse.cz>
 <20190924120943.GP2349@hirez.programming.kicks-ass.net>
 <20190924122500.GP23050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924122500.GP23050@dhcp22.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On Tue, Sep 24, 2019 at 02:25:00PM +0200, Michal Hocko wrote:
> On Tue 24-09-19 14:09:43, Peter Zijlstra wrote:

> > We can push back and say we don't respect the specification because it
> > is batshit insane ;-)
> 
> Here is my fingers crossed.
> 
> [...]
> 
> > Now granted; there's a number of virtual devices that really don't have
> > a node affinity, but then, those are not hurt by forcing them onto a
> > random node, they really don't do anything. Like:
> 
> Do you really consider a random node a better fix than simply living
> with a more robust NUMA_NO_NODE which tells the actual state? Page
> allocator would effectivelly use the local node in that case. Any code
> using the cpumask will know that any of the online cpus are usable.

For the pmu devices? Yes, those 'devices' aren't actually used for
anything other than sysfs entries.

Nothing else uses the struct device.

> Compare that to a wild guess that might be easily wrong and have subtle
> side effects which are really hard to debug. You will only see a higher
> utilization on a specific node. Good luck with a bug report like that.

We'd have the FW_BUG in the dmesg, which should be a big fat clue.
