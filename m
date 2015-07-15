Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 0/8] Implement group-read of events using txn interface
Date: Tue, 14 Jul 2015 20:01:47 -0700
Message-Id: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Unlike normal hardware PMCs, the 24x7 counters in Power8 are stored in
memory and accessed via a hypervisor call(HCALL).  A major aspect of the
HCALL is that it allows retireving _several_ counters at once (unlike
regular PMCs, which are read one at a time). By reading several counters
at once, we can get a more consistent snapshot of the system.

This patchset extends the transaction interface to accomplish submitting
several events to the PMU and have the PMU read them all at once. User is
expected to submit the set of events they want to read as an "event group".

In the kernel, we submit each event to the PMU using the following logic
(from Peter Zijlstra).

        pmu->start_txn(pmu, PMU_TXN_READ);

        leader->read();
        for_each_sibling()
                sibling->read();
        pmu->commit_txn();

where:
        - the ->read()s queue events to be submitted to the hypervisor, and,
        - the ->commit_txn() issues the HCALL, retrieves the result and
          updates the event count.

Architectures/PMUs that don't need/implement PMU_TXN_READ type of transactions,
simply ignore the ->start_txn() and ->commit_txn() and continue to read the
counters one at a time in the ->read() call.

Compile/touch tested on x86. Need help testing on s390 and Sparc.

Thanks to Peter Zijlstra for his input.

Changelog [v3]
	- Simple changes/reorg of patchset to split/rename functions
	- [Peter Zijlstra] Save the transaction flags in ->start_txn() and
	  drop the flags parameter from ->commit_txn() and ->cancel_txn().
	- [Peter Zijlstra] The nop txn interfaces don't need to disable/enable
	  PMU for PERF_PMU_TXN_READ transactions.

Changelog [v2]
        - Use the transaction interface unconditionally to avoid special-case
          code. Architectures/PMUs that don't need the READ transaction types
          simply ignore the ->start_txn() and ->commit_txn() calls.

Peter Zijlstra (Intel) (1):
  perf: Rename perf_event_read_{one,group}, perf_read_hw

Sukadev Bhattiprolu (7):
  powerpc/perf/hv-24x7: Whitespace - fix parameter alignment
  powerpc/perf/hv-24x7: Simplify extracting counter from result buffer
  perf: Add a flags parameter to pmu txn interfaces
  perf: Split perf_event_read() and perf_event_count()
  perf: Split perf_event_read_value()
  perf: Define PMU_TXN_READ interface
  powerpc/perf/hv-24x7: Use PMU_TXN_READ interface

 arch/powerpc/perf/core-book3s.c  |   25 ++++-
 arch/powerpc/perf/hv-24x7.c      |  186 ++++++++++++++++++++++++++++++++++----
 arch/s390/kernel/perf_cpum_cf.c  |   24 ++++-
 arch/sparc/kernel/perf_event.c   |   19 +++-
 arch/x86/kernel/cpu/perf_event.c |   27 +++++-
 arch/x86/kernel/cpu/perf_event.h |    1 +
 include/linux/perf_event.h       |   15 ++-
 kernel/events/core.c             |  143 +++++++++++++++++++++++------
 8 files changed, 389 insertions(+), 51 deletions(-)

-- 
1.7.9.5
