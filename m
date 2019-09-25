Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfIYKmY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 Sep 2019 06:42:24 -0400
Date: Wed, 25 Sep 2019 12:40:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190925104040.GD4553@hirez.programming.kicks-ass.net>
References: <20190924074751.GB23050@dhcp22.suse.cz>
 <20190924091714.GJ2369@hirez.programming.kicks-ass.net>
 <20190924105622.GH23050@dhcp22.suse.cz>
 <20190924112349.GJ2332@hirez.programming.kicks-ass.net>
 <20190924115401.GM23050@dhcp22.suse.cz>
 <20190924120943.GP2349@hirez.programming.kicks-ass.net>
 <20190924122500.GP23050@dhcp22.suse.cz>
 <20190924124325.GQ2349@hirez.programming.kicks-ass.net>
 <20190924125936.GR2349@hirez.programming.kicks-ass.net>
 <20190924131939.GS23050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924131939.GS23050@dhcp22.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On Tue, Sep 24, 2019 at 03:19:39PM +0200, Michal Hocko wrote:

> > The below would get rid of the PMU and workqueue warnings with no
> > side-effects (the device isn't used for anything except sysfs).
> 
> Hardcoding to 0 is simply wrong, if the node0 is cpuless for example...

It doesn't matter.... that 0 is _never_ used. These are fake devices,
and all we care about is getting rid of that error.

If it makes you feel better we can make it -2 and have dev_to_node()
WARN if it ever sees one.
