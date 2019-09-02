Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46544 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfIBTPw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Sep 2019 15:15:52 -0400
Date: Mon, 2 Sep 2019 21:14:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
Message-ID: <20190902191421.GT2369@hirez.programming.kicks-ass.net>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
 <20190831085539.GG2369@hirez.programming.kicks-ass.net>
 <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
 <20190831161247.GM2369@hirez.programming.kicks-ass.net>
 <ae64285f-5134-4147-7b02-34bb5d519e8c@huawei.com>
 <20190902072542.GN2369@hirez.programming.kicks-ass.net>
 <5fa2aa99-89fa-cd41-b090-36a23cfdeb73@huawei.com>
 <20190902125644.GQ2369@hirez.programming.kicks-ass.net>
 <20190902182252.GC35858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902182252.GC35858@gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, dalias@libc.org, linux-sh@vger.kernel.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linuxarm@huawei.com, jiaxun.yang@flygoat.com, linux-kernel@vger.kernel.org, mwb@linux.vnet.ibm.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com, will@kernel.org, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, rppt@linux.ibm.com, borntraeger@de.ibm.com, dledford@redhat.com, mingo@redhat.com, jeffrey.t.kirsher@intel.com, benh@kernel.crashing.org, jhogan@kernel.org, nfont@linux.vnet.ibm.com, mattst88@gmail.com, len.brown@intel.com, gor@linux.ibm.com, anshuman.khandual@arm.com, ink@jurassic.park.msu.ru, cai@lca.pw, luto@kernel.org, tglx@linutronix.de, naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org, rth@twiddle.net, axboe@kernel.dk, robin.murphy@arm.com, linux-mips@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de, paul.burton@mips.com, linux-alpha@vger.kernel.org, bp@alien8.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Sep 02, 2019 at 08:22:52PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:

> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index f0dd8e38fee3..2caf204966a0 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2120,8 +2120,16 @@ int device_add(struct device *dev)
> >  		dev->kobj.parent = kobj;
> >  
> >  	/* use parent numa_node */
> > -	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> > -		set_dev_node(dev, dev_to_node(parent));
> > +	if (dev_to_node(dev) == NUMA_NO_NODE) {
> > +		if (parent)
> > +			set_dev_node(dev, dev_to_node(parent));
> > +#ifdef CONFIG_NUMA
> > +		else {
> > +			pr_err("device: '%s': has no assigned NUMA node\n", dev_name(dev));
> > +			set_dev_node(dev, 0);
> > +		}
> > +#endif
> 
> BTW., is firmware required to always provide a NUMA node on NUMA systems?
> 
> I.e. do we really want this warning on non-NUMA systems that don't assign 
> NUMA nodes?

Good point; we might have to exclude nr_node_ids==1 systems from
warning.

> Also, even on NUMA systems, is firmware required to provide a NUMA node - 
> i.e. is it in principle invalid to offer no NUMA binding?

I think so; a device needs to be _somewhere_, right? Typically though;
devices are on a PCI bus, and the PCI bridge itself will have a NUMA
binding and then the above parent rule will make everything just work.

But I don't see how you can be outside of the NUMA topology.
