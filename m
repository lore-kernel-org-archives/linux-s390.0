Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHaI4w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 31 Aug 2019 04:56:52 -0400
Date: Sat, 31 Aug 2019 10:55:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/9] x86: numa: check the node id consistently for x86
Message-ID: <20190831085539.GG2369@hirez.programming.kicks-ass.net>
References: <1567231103-13237-1-git-send-email-linyunsheng@huawei.com>
 <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567231103-13237-3-git-send-email-linyunsheng@huawei.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com, bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com, akpm@linux-foundation.org, rppt@linux.ibm.com, anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com, jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org, nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tbogendoerfer@suse.de, linux-mips@vger.kernel.org, linuxarm@huawei.com

On Sat, Aug 31, 2019 at 01:58:16PM +0800, Yunsheng Lin wrote:
> According to Section 6.2.14 from ACPI spec 6.3 [1], the setting
> of proximity domain is optional, as below:
> 
> This optional object is used to describe proximity domain
> associations within a machine. _PXM evaluates to an integer
> that identifies a device as belonging to a Proximity Domain
> defined in the System Resource Affinity Table (SRAT).

That's just words.. what does it actually mean?

> This patch checks node id with the below case before returning
> node_to_cpumask_map[node]:
> 1. if node_id >= nr_node_ids, return cpu_none_mask
> 2. if node_id < 0, return cpu_online_mask
> 3. if node_to_cpumask_map[node_id] is NULL, return cpu_online_mask
> 
> [1] https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  arch/x86/include/asm/topology.h | 6 ++++++
>  arch/x86/mm/numa.c              | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index 4b14d23..f36e9c8 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -69,6 +69,12 @@ extern const struct cpumask *cpumask_of_node(int node);
>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
>  static inline const struct cpumask *cpumask_of_node(int node)
>  {
> +	if (node >= nr_node_ids)
> +		return cpu_none_mask;
> +
> +	if (node < 0 || !node_to_cpumask_map[node])
> +		return cpu_online_mask;
> +
>  	return node_to_cpumask_map[node];
>  }
>  #endif

I _reallly_ hate this. Users are expected to use valid numa ids. Now
we're adding all this checking to all users. Why do we want to do that?

Using '(unsigned)node >= nr_nods_ids' is an error.

> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index e6dad60..5e393d2 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -868,7 +868,7 @@ const struct cpumask *cpumask_of_node(int node)
>  		dump_stack();
>  		return cpu_none_mask;
>  	}
> -	if (node_to_cpumask_map[node] == NULL) {
> +	if (node < 0 || !node_to_cpumask_map[node]) {
>  		printk(KERN_WARNING
>  			"cpumask_of_node(%d): no node_to_cpumask_map!\n",
>  			node);
> -- 
> 2.8.1
> 
