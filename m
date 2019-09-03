Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:34456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfICHy5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 03:54:57 -0400
Date: Tue, 3 Sep 2019 09:53:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/mm: Fix cpumask_of_node() error condition
Message-ID: <20190903075352.GY2369@hirez.programming.kicks-ass.net>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
 <20190831085539.GG2369@hirez.programming.kicks-ass.net>
 <4d89c688-49e4-a2aa-32ee-65e36edcd913@huawei.com>
 <20190831161247.GM2369@hirez.programming.kicks-ass.net>
 <ae64285f-5134-4147-7b02-34bb5d519e8c@huawei.com>
 <20190902072542.GN2369@hirez.programming.kicks-ass.net>
 <20190902181731.GB35858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902181731.GB35858@gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, dalias@libc.org, linux-sh@vger.kernel.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linuxarm@huawei.com, jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org, mwb@linux.vnet.ibm.com, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, chenhc@lemote.com, will@kernel.org, cai@lca.pw, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, rppt@linux.ibm.com, borntraeger@de.ibm.com, dledford@redhat.com, mingo@redhat.com, jeffrey.t.kirsher@intel.com, benh@kernel.crashing.org, jhogan@kernel.org, nfont@linux.vnet.ibm.com, mattst88@gmail.com, len.brown@intel.com, gor@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, naveen.n.rao@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org, rth@twiddle.net, axboe@kernel.dk, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, tbogendoerfer@suse.de, paul.burton@mips.com, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net

On Mon, Sep 02, 2019 at 08:17:31PM +0200, Ingo Molnar wrote:

> Nitpicking: please also fix the kernel message to say ">=".

Full patch below.

---
Subject: x86/mm: Fix cpumask_of_node() error condition

When CONFIG_DEBUG_PER_CPU_MAPS we validate that the @node argument of
cpumask_of_node() is a valid node_id. It however forgets to check for
negative numbers. Fix this by explicitly casting to unsigned.

  (unsigned)node >= nr_node_ids

verifies: 0 <= node < nr_node_ids

Also ammend the error message to match the condition.

Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e6dad600614c..4123100e0eaf 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -861,9 +861,9 @@ void numa_remove_cpu(int cpu)
  */
 const struct cpumask *cpumask_of_node(int node)
 {
-	if (node >= nr_node_ids) {
+	if ((unsigned)node >= nr_node_ids) {
 		printk(KERN_WARNING
-			"cpumask_of_node(%d): node > nr_node_ids(%u)\n",
+			"cpumask_of_node(%d): (unsigned)node >= nr_node_ids(%u)\n",
 			node, nr_node_ids);
 		dump_stack();
 		return cpu_none_mask;
