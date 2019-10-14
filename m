Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730941AbfJNJtQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Oct 2019 05:49:16 -0400
Date: Mon, 14 Oct 2019 11:49:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] numa: make node_to_cpumask_map() NUMA_NO_NODE aware
Message-ID: <20191014094912.GY2311@hirez.programming.kicks-ass.net>
References: <20191010073212.GB18412@dhcp22.suse.cz>
 <6cc94f9b-0d79-93a8-5ec2-4f6c21639268@huawei.com>
 <20191011111539.GX2311@hirez.programming.kicks-ass.net>
 <7fad58d6-5126-e8b8-a7d8-a91814da53ba@huawei.com>
 <20191012074014.GA2037204@kroah.com>
 <1e1ec851-b5e7-8f35-a627-4c12ca9c2d3c@huawei.com>
 <20191012104001.GA2052933@kroah.com>
 <20191012104742.GA2053473@kroah.com>
 <82000bc8-6912-205b-0251-25b9cc430973@huawei.com>
 <20191014092509.GA3050088@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014092509.GA3050088@kroah.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Michal Hocko <mhocko@kernel.org>, Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, rafael@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Mon, Oct 14, 2019 at 11:25:09AM +0200, Greg KH wrote:
> Good luck, I don't really think that most, if any, of this is needed,
> but hey, it's nice to clean it up where it can be :)

Some of the virtual devices we have (that use devm) really ought to set
the node too, like drivers/base/cpu.c and driver/base/node.c and
arguably the cooling devices too (they create a device per cpu).

The patch I had here:

  https://lkml.kernel.org/r/20190925214526.GA4643@worktop.programming.kicks-ass.net

takes the more radical approach of requiring a node, except when
explicitly marked not (the fake devices that don't use devm for
example).

But yes, PCI and other physical busses really should be having a node
set, no excuses.

Anyway, I don't think non-physical devices actually use
cpumask_of_node() much, a quick grep didn't show any.
