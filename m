Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbfIXL71 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Sep 2019 07:59:27 -0400
Date: Tue, 24 Sep 2019 13:58:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20190924115804.GO2349@hirez.programming.kicks-ass.net>
References: <20190923151519.GE2369@hirez.programming.kicks-ass.net>
 <20190923152856.GB17206@dhcp22.suse.cz>
 <20190923154852.GG2369@hirez.programming.kicks-ass.net>
 <20190923165235.GD17206@dhcp22.suse.cz>
 <20190923203410.GI2369@hirez.programming.kicks-ass.net>
 <f1362dbb-ad31-51a8-2b06-16c9d928b876@huawei.com>
 <20190924092551.GK2369@hirez.programming.kicks-ass.net>
 <c816abbe-155b-504b-cef1-6413f7cdd20c@huawei.com>
 <20190924112811.GK2332@hirez.programming.kicks-ass.net>
 <8cff8350-311e-3817-0c42-b6f98de589a3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cff8350-311e-3817-0c42-b6f98de589a3@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org

On Tue, Sep 24, 2019 at 07:44:28PM +0800, Yunsheng Lin wrote:
> From [1], there is a lot of devices with node id of NUMA_NO_NODE with the
> FW_BUG.
> 
> [1] https://lore.kernel.org/lkml/5a188e2b-6c07-a9db-fbaa-561e9362d3ba@huawei.com/

So aside of all the software devices which we can (and really should)
fix; these:

26.470076]  pci0000:00: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
26.815436]  pci0000:7b: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
27.004447]  pci0000:7a: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
27.236797]  pci0000:78: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
27.505833]  pci0000:7c: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
28.056452]  pci0000:74: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
28.470018]  pci0000:80: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
28.726411]  pci0000:bb: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
28.916656]  pci0000:ba: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
29.152839]  pci0000:b8: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
29.425808]  pci0000:bc: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.
29.718593]  pci0000:b4: has invalid NUMA node(-1), default node of 0 now selected. Readjust it by writing to sysfs numa_node or contact your vendor for updates.

look like actual problems. How can PCI devices not have a node assigned?
