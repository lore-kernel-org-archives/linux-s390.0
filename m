Return-Path: <peterz@infradead.org>
Date: Wed, 22 Jul 2015 07:55:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Message-ID: <20150722055503.GO25159@twins.programming.kicks-ass.net>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716222015.GO3644@twins.programming.kicks-ass.net>
 <20150722015045.GA24420@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722015045.GA24420@us.ibm.com>
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

On Tue, Jul 21, 2015 at 06:50:45PM -0700, Sukadev Bhattiprolu wrote:
> We are trying to use the following interface:
> 
> 	start_txn(pmu, PERF_PMU_TXN_READ);
> 
> 	perf_event_read(leader);
> 	list_for_each(sibling, &leader->sibling_list, group_entry)
> 		perf_event_read(sibling)
> 
> 	pmu->commit_txn(pmu);
> 
> with the idea that the PMU driver would save the type of transaction in
> ->start_txn() and use in ->read() and ->commit_txn().
> 
> But since ->start_txn() and the ->read() operations could happen on different
> CPUs (perf_event_read() uses the event->oncpu to schedule a call), the PMU
> driver cannot use a per-cpu variable to save the state in ->start_txn().

> or is there better way?


I've not woken up yet, and not actually fully read the email, but can
you stuff the entire above chunk inside the IPI?

I think you could then actually optimize __perf_event_read() as well,
because all these events should be on the same context, so no point in
calling update_*time*() for every event or so.
