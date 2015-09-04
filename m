Return-Path: <mpe@ellerman.id.au>
Message-ID: <1441361249.3777.3.camel@ellerman.id.au>
Subject: Re: [[PATCH v6 02/10] perf: Add a flags parameter to pmu txn
 interfaces
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 04 Sep 2015 20:07:29 +1000
In-Reply-To: <1441336073-22750-3-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1441336073-22750-3-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2015-09-03 at 20:07 -0700, Sukadev Bhattiprolu wrote:
> Currently, the PMU interface allows reading only one counter at a time.
> But some PMUs like the 24x7 counters in Power, support reading several
> counters at once. To leveage this functionality, extend the transaction
> interface to support a "transaction type".
> 
> The first type, PERF_PMU_TXN_ADD, refers to the existing transactions,
> i.e. used to _schedule_ all the events on the PMU as a group. A second
> transaction type, PERF_PMU_TXN_READ, will be used in a follow-on patch,
> by the 24x7 counters to read several counters at once.
> 
> Extend the transaction interfaces to the PMU to accept a 'txn_flags'
> parameter and use this parameter to ignore any transactions that are
> not of type PERF_PMU_TXN_ADD.
> 
> Thanks to Peter Zijlstra for his input.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/perf/core-book3s.c  |   30 +++++++++++++++++++++++++++++-

These powerpc changes look OK to me.

So for those you can have an:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


Having said that, we do end up repeating a lot of boiler plate for each arch,
which is a pity. eg:

> +static void power_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
>  {
>  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
>
> +	WARN_ON_ONCE(cpuhw->txn_flags);		/* txn already in flight */
> +
> +	cpuhw->txn_flags = txn_flags;
> +	if (txn_flags & ~PERF_PMU_TXN_ADD)
> +		return;
> +

And so on.

But I can't think of an easy way to avoid that, so it's not a blocker, but
maybe someone can think of a nice solution to avoid it?

cheers
