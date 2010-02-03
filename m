From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 03 Feb 2010 06:50:19 +0000
Subject: [patch 0/3] HWBKPT v4: Hardware breakpoint implementation for s390
Message-Id: <20100203063819.GA17281@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko,

Please find the set of patches that introduces s390 specific implementation
for perf-events based hardware breakpoint interfaces for review.

I did not introduce kernel per tracing check under kernel exit path
'RESTORE_ALL' as you said it is not so easy (and it was too complex for me to
understand).

Change in v4:
- Introduced a kernel per tracing flag in lowcore structure for each cpu
  instead of global.
- Handled a race condition with interrupts/preemption while looking for
  PER event in hw_breakpoint_handler() routine.

Change in v3:
- Merged first two patches of v1 patchset.
- Introduced second patch that implements kernel part PER tracing.

The patch set has been tested with ksym_tracer and watchpoints over GDB+ptrace
and works fine.

Thanks,
-Mahesh.
-- 
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
