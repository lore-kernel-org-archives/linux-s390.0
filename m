Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfIZMMC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Sep 2019 08:12:02 -0400
Date: Thu, 26 Sep 2019 14:10:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190926121007.GB4581@hirez.programming.kicks-ass.net>
References: <20190924120943.GP2349@hirez.programming.kicks-ass.net>
 <20190924122500.GP23050@dhcp22.suse.cz>
 <20190924124325.GQ2349@hirez.programming.kicks-ass.net>
 <20190924125936.GR2349@hirez.programming.kicks-ass.net>
 <20190924131939.GS23050@dhcp22.suse.cz>
 <20190925104040.GD4553@hirez.programming.kicks-ass.net>
 <20190925132544.GL23050@dhcp22.suse.cz>
 <20190925163154.GF4553@hirez.programming.kicks-ass.net>
 <20190925214526.GA4643@worktop.programming.kicks-ass.net>
 <20190926090559.GA4581@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926090559.GA4581@hirez.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On Thu, Sep 26, 2019 at 11:05:59AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 25, 2019 at 11:45:26PM +0200, Peter Zijlstra wrote:
> > [    7.149889] [Firmware Bug]: device: 'pci0000:7f': no node assigned on NUMA capable HW
> > [    7.882888] [Firmware Bug]: device: 'pci0000:ff': no node assigned on NUMA capable HW
> 
> Going by the limited number of intel numa boxes I have, it looks like:
> 
>   socket = (~busid) >> (8-n)

Bah, I got my notes mixed up, it should be: busid >> (8-n)

> where 'n' is the number of bits required to encode the largest socket
> id, ie 1 for 2-socket and 2 for 4 socket.
> 
> For 8 socket systems we start using pci domains, and things get more
> 'interesting' :/
