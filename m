Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 00/25] mm: Page fault accounting cleanups
Date: Mon, 15 Jun 2020 18:15:42 -0400
Message-Id: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>

Gerald Schaefer reported an issue a week ago regarding to incorrect page fault
accountings for retried page fault after commit 4064b9827063 ("mm: allow
VM_FAULT_RETRY for multiple times"):

  https://lore.kernel.org/lkml/20200610174811.44b94525@thinkpad/

When I was looking at the issue, I actually found some other trivial issues too
related to the page fault accounting, namely:

  - Incorrect accountings

    - The major issue that was reported by Gerald, that we did multiple
      accounting when the page fault retried while we should only do it once
      (for either perf event accounting or per-task accounting).

    - In many archs, major fault is only accounted when the 1st page fault is a
      major fault, or the last page fault is a major fault.  Ideally we should
      account the page fault as a major fault as long as any of the page fault
      retries is a major fault and keep the same behavior across archs.

  - Missing accountings of perf events (PERF_COUNT_SW_PAGE_FAULTS[_[MAJ|MIN]]).

  - Doing accounting with mmap_sem: not a big deal, but logically we can move
    it after releasing the mmap_sem because accounting does not need it.

This series tries to address all of them by introducing mm_fault_accounting()
first, so that we move all the page fault accounting into the common code base,
then call it properly from arch pf handlers just like handle_mm_fault().  There
are some special cases, e.g., the um arch does not have "regs" in the fault
handler, so it's still using the manual statistics.

For each of the patch that fixes a specific arch, I'm CCing the maintainers and
the arch list if there is.  Besides, I only lightly tested this series on x86.

Please have a look, thanks.

Peter Xu (25):
  mm/um: Fix extra accounting for page fault retries
  mm: Introduce mm_fault_accounting()
  mm/alpha: Use mm_fault_accounting()
  mm/arc: Use mm_fault_accounting()
  mm/arm: Use mm_fault_accounting()
  mm/arm64: Use mm_fault_accounting()
  mm/csky: Use mm_fault_accounting()
  mm/hexagon: Use mm_fault_accounting()
  mm/ia64: Use mm_fault_accounting()
  mm/m68k: Use mm_fault_accounting()
  mm/microblaze: Use mm_fault_accounting()
  mm/mips: Use mm_fault_accounting()
  mm/nds32: Use mm_fault_accounting()
  mm/nios2: Use mm_fault_accounting()
  mm/openrisc: Use mm_fault_accounting()
  mm/parisc: Use mm_fault_accounting()
  mm/powerpc: Use mm_fault_accounting()
  mm/riscv: Use mm_fault_accounting()
  mm/s390: Use mm_fault_accounting()
  mm/sh: Use mm_fault_accounting()
  mm/sparc32: Use mm_fault_accounting()
  mm/sparc64: Use mm_fault_accounting()
  mm/unicore32: Use mm_fault_accounting()
  mm/x86: Use mm_fault_accounting()
  mm/xtensa: Use mm_fault_accounting()

 arch/alpha/mm/fault.c      |  9 ++++-----
 arch/arc/mm/fault.c        | 15 +++------------
 arch/arm/mm/fault.c        | 21 ++++-----------------
 arch/arm64/mm/fault.c      | 17 ++---------------
 arch/csky/mm/fault.c       | 13 +------------
 arch/hexagon/mm/vm_fault.c |  9 +++------
 arch/ia64/mm/fault.c       |  8 +++-----
 arch/m68k/mm/fault.c       | 13 +++----------
 arch/microblaze/mm/fault.c |  8 +++-----
 arch/mips/mm/fault.c       | 14 +++-----------
 arch/nds32/mm/fault.c      | 19 +++----------------
 arch/nios2/mm/fault.c      | 13 +++----------
 arch/openrisc/mm/fault.c   |  8 +++-----
 arch/parisc/mm/fault.c     |  8 +++-----
 arch/powerpc/mm/fault.c    | 13 ++++---------
 arch/riscv/mm/fault.c      | 21 +++------------------
 arch/s390/mm/fault.c       | 21 +++++----------------
 arch/sh/mm/fault.c         | 15 +++------------
 arch/sparc/mm/fault_32.c   | 16 +++-------------
 arch/sparc/mm/fault_64.c   | 16 ++++------------
 arch/um/kernel/trap.c      | 13 +++++++------
 arch/unicore32/mm/fault.c  | 15 +++++++--------
 arch/x86/mm/fault.c        | 10 +---------
 arch/xtensa/mm/fault.c     | 14 +++-----------
 include/linux/mm.h         |  2 ++
 mm/memory.c                | 18 ++++++++++++++++++
 26 files changed, 101 insertions(+), 248 deletions(-)

-- 
2.26.2
