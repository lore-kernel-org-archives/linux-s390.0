Return-Path: <peterz@infradead.org>
Date: Thu, 16 Jul 2015 22:17:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/8] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150716201749.GL3644@twins.programming.kicks-ass.net>
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
> @@ -1604,6 +1613,12 @@ static void power_pmu_start_txn(struct pmu *pmu)
>  static void power_pmu_cancel_txn(struct pmu *pmu)
>  {
>  	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
> +	int txn_flags;
> +
> +	txn_flags = cpuhw->txn_flags;
> +	cpuhw->txn_flags = 0;
> +	if (cpuhw->txn_flags & ~PERF_PMU_TXN_ADD)
> +		return;

That seems, unintentional? ;-)
