Return-Path: <peterz@infradead.org>
Date: Thu, 16 Jul 2015 22:48:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/8] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150716204807.GM3644@twins.programming.kicks-ass.net>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436929315-28520-4-git-send-email-sukadev@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 14, 2015 at 08:01:50PM -0700, Sukadev Bhattiprolu wrote:
> +DEFINE_PER_CPU(int, nop_txn_flags);
> +
> +static int nop_txn_flags_get_and_clear(void)
> +{
> +	int *flagsp;
> +	int flags;
> +	
> +	flagsp = &get_cpu_var(nop_txn_flags);
> +
> +	flags = *flagsp;
> +	*flagsp = 0;
> +
> +	put_cpu_var(nop_txn_flags);
> +
> +	return flags;
> +}
> +
> +static void nop_txn_flags_set(int flags)
> +{
> +	int *flagsp;
> +	
> +	flagsp = &get_cpu_var(nop_txn_flags);
> +	*flagsp = flags;
> +	put_cpu_var(nop_txn_flags);
> +}

That's really horrible, see below:

> +static void perf_pmu_start_txn(struct pmu *pmu, int flags)
>  {
	__this_cpu_write(nop_txn_flags, flags);
> +
> +	if (flags & ~PERF_PMU_TXN_ADD)
> +		return;
> +
>  	perf_pmu_disable(pmu);
>  }
>  
>  static int perf_pmu_commit_txn(struct pmu *pmu)
>  {
	int flags = __this_cpu_read(nop_txn_flags);
	__this_cpu_write(nop_txn_flags, 0);
> +
> +	if (flags & ~PERF_PMU_TXN_ADD)
> +		return 0;
> +
>  	perf_pmu_enable(pmu);
>  	return 0;
>  }
>  
>  static void perf_pmu_cancel_txn(struct pmu *pmu)
>  {
	int flags = __this_cpu_read(nop_txn_flags);
	__this_cpu_write(nop_txn_flags, 0);
> +
> +	if (flags & ~PERF_PMU_TXN_ADD)
> +		return;
> +
>  	perf_pmu_enable(pmu);
>  }
