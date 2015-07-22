Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Tue, 21 Jul 2015 18:50:45 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Message-ID: <20150722015045.GA24420@us.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716222015.GO3644@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150716222015.GO3644@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Jul 14, 2015 at 08:01:54PM -0700, Sukadev Bhattiprolu wrote:
| > +/*
| > + * Use the transaction interface to read the group of events in @leader.
| > + * PMUs like the 24x7 counters in Power, can use this to queue the events
| > + * in the ->read() operation and perform the actual read in ->commit_txn.
| > + *
| > + * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
| > + * PMU directly in the ->read() operation.
| > + */
| > +static int perf_event_read_group(struct perf_event *leader)
| > +{
| > +	int ret;
| > +	struct perf_event *sub;
| > +	struct pmu *pmu;
| > +
| > +	pmu = leader->pmu;
| > +
| > +	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
| > +
| > +	perf_event_read(leader);
| 
| There should be a lockdep assert with that list iteration.
| 
| > +	list_for_each_entry(sub, &leader->sibling_list, group_entry)
| > +		perf_event_read(sub);
| > +
| > +	ret = pmu->commit_txn(pmu);

Peter,

I have a situation :-)

We are trying to use the following interface:

	start_txn(pmu, PERF_PMU_TXN_READ);

	perf_event_read(leader);
	list_for_each(sibling, &leader->sibling_list, group_entry)
		perf_event_read(sibling)

	pmu->commit_txn(pmu);

with the idea that the PMU driver would save the type of transaction in
->start_txn() and use in ->read() and ->commit_txn().

But since ->start_txn() and the ->read() operations could happen on different
CPUs (perf_event_read() uses the event->oncpu to schedule a call), the PMU
driver cannot use a per-cpu variable to save the state in ->start_txn().

I tried using a pmu-wide global, but that would also need us to hold a mutex
to serialize access to that global. The problem is ->start_txn() can be
called from an interrupt context for the TXN_ADD transactions (I got the
following backtrace during testing)

	mutex_lock_nested+0x504/0x520 (unreliable)
	h_24x7_event_start_txn+0x3c/0xd0
	group_sched_in+0x70/0x230
	ctx_sched_in.isra.63+0x150/0x230
	__perf_install_in_context+0x1c8/0x1e0
	remote_function+0x7c/0xa0
	flush_smp_call_function_queue+0xb0/0x1d0
	smp_ipi_demux+0x88/0xf0
	icp_hv_ipi_action+0x54/0xc0
	handle_irq_event_percpu+0x98/0x2b0
	handle_percpu_irq+0x7c/0xc0
	generic_handle_irq+0x4c/0x80
	__do_irq+0x7c/0x190
	call_do_irq+0x14/0x24
	do_IRQ+0x8c/0x100
	hardware_interrupt_common+0x168/0x180
	--- interrupt: 501 at .plpar_hcall_norets+0x14/0x20

Basically stuck trying to save the txn type in ->start_txn() and retrieve in
->read().

Couple of options I can think of are:

	- having ->start_txn() return a handle that should then be passed in
	  with ->read() (yuck) and ->commit_txn().

	- serialize the READ transaction for the PMU in perf_event_read_group()
	  with a new pmu->txn_mutex:

		mutex_lock(&pmu->txn_mutex);

		pmu->start_txn()
		list_for_each_entry(sub, &leader->sibling_list, group_entry)
			perf_event_read(sub);

		ret = pmu->commit_txn(pmu);

		mutex_unlock(&pmu->txn_mutex);

	  such serialization would be ok with 24x7 counters (they are system
	  wide counters anyway) We could maybe skip the mutex for PMUs that
	  don't implement TXN_READ interface.

or is there better way?

Sukadev
