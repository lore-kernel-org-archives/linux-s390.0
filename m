Return-Path: <peterz@infradead.org>
Date: Fri, 17 Jul 2015 00:20:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Message-ID: <20150716222015.GO3644@twins.programming.kicks-ass.net>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Tue, Jul 14, 2015 at 08:01:54PM -0700, Sukadev Bhattiprolu wrote:
> +/*
> + * Use the transaction interface to read the group of events in @leader.
> + * PMUs like the 24x7 counters in Power, can use this to queue the events
> + * in the ->read() operation and perform the actual read in ->commit_txn.
> + *
> + * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
> + * PMU directly in the ->read() operation.
> + */
> +static int perf_event_read_group(struct perf_event *leader)
> +{
> +	int ret;
> +	struct perf_event *sub;
> +	struct pmu *pmu;
> +
> +	pmu = leader->pmu;
> +
> +	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
> +
> +	perf_event_read(leader);

There should be a lockdep assert with that list iteration.

> +	list_for_each_entry(sub, &leader->sibling_list, group_entry)
> +		perf_event_read(sub);
> +
> +	ret = pmu->commit_txn(pmu);
> +
> +	return ret;
> +}
