Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504189AbfIXJ0r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Sep 2019 05:26:47 -0400
Date: Tue, 24 Sep 2019 11:25:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190924092551.GK2369@hirez.programming.kicks-ass.net>
References: <1568724534-146242-1-git-send-email-linyunsheng@huawei.com>
 <20190923151519.GE2369@hirez.programming.kicks-ass.net>
 <20190923152856.GB17206@dhcp22.suse.cz>
 <20190923154852.GG2369@hirez.programming.kicks-ass.net>
 <20190923165235.GD17206@dhcp22.suse.cz>
 <20190923203410.GI2369@hirez.programming.kicks-ass.net>
 <f1362dbb-ad31-51a8-2b06-16c9d928b876@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1362dbb-ad31-51a8-2b06-16c9d928b876@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On Tue, Sep 24, 2019 at 09:29:50AM +0800, Yunsheng Lin wrote:
> On 2019/9/24 4:34, Peter Zijlstra wrote:

> > I'm saying the ACPI standard is wrong. Explain to me how it is
> > physically possible to have a device without NUMA affinity in a NUMA
> > system?
> > 
> >  1) The fundamental interconnect is not uniform.
> >  2) The device needs to actually be somewhere.
> > 
> 
> From what I can see, NUMA_NO_NODE may make sense in the below case:
> 
> 1) Theoretically, there would be a device that can access all the memory
> uniformly and can be accessed by all cpus uniformly even in a NUMA system.
> Suppose we have two nodes, and the device just sit in the middle of the
> interconnect between the two nodes.
> 
> Even we define a third node solely for the device, we may need to look at
> the node distance to decide the device can be accessed uniformly.
> 
> Or we can decide that the device can be accessed uniformly by setting
> it's node to NUMA_NO_NODE.

This is indeed a theoretical case; it doesn't scale. The moment you're
adding multiple sockets or even board interconnects this all goes out
the window.

And in this case, forcing the device to either node is fine.

> 2) For many virtual deivces, such as tun or loopback netdevice, they
> are also accessed uniformly by all cpus.

Not true; the virtual device will sit in memory local to some node.

And as with physical devices, you probably want at least one (virtual)
queue per node.
