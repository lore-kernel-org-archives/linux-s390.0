From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 27 May 2010 03:53:34 +0000
Subject: [patch 0/3] S390-HWBKPT v5: Hardware breakpoint implementation for
Message-Id: <20100527034134.GA6404@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Heiko/Frederic,

Please find the latest set of patches that introduces s390 specific
implementation for perf-events based hardware breakpoint interfaces for review.

Change in v5:
- Use exclude_kernel attribute set to decide whether to install wide breakpoint
  in kernel or not. This flag will be used by ptrace breakpoint.
- Removed 'info->name' field as Name to address resolving is done in generic
  code.
- Select CONFIG_HAVE_MIXED_BREAKPOINTS_REGS as s390 uses same register for
  instruction as well as data breakpoint.
- Re-based the patches on commit d67f088e084755bdceb4f15bc6e05e309db1eea7 of
  -tip perf/core

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
