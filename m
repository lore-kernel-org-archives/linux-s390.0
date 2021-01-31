Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nadav Amit <nadav.amit@gmail.com>
Subject: [RFC 00/20] TLB batching consolidation and enhancements
Date: Sat, 30 Jan 2021 16:11:12 -0800
Message-Id: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, x86@kernel.org, Yu Zhao <yuzhao@google.com>

From: Nadav Amit <namit@vmware.com>

There are currently (at least?) 5 different TLB batching schemes in the
kernel:

1. Using mmu_gather (e.g., zap_page_range()).

2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
   ongoing deferred TLB flush and flushing the entire range eventually
   (e.g., change_protection_range()).

3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).

4. Batching per-table flushes (move_ptes()).

5. By setting a flag on that a deferred TLB flush operation takes place,
   flushing when (try_to_unmap_one() on x86).

It seems that (1)-(4) can be consolidated. In addition, it seems that
(5) is racy. It also seems there can be many redundant TLB flushes, and
potentially TLB-shootdown storms, for instance during batched
reclamation (using try_to_unmap_one()) if at the same time mmu_gather
defers TLB flushes.

More aggressive TLB batching may be possible, but this patch-set does
not add such batching. The proposed changes would enable such batching
in a later time.

Admittedly, I do not understand how things are not broken today, which
frightens me to make further batching before getting things in order.
For instance, why is ok for zap_pte_range() to batch dirty-PTE flushes
for each page-table (but not in greater granularity). Can't
ClearPageDirty() be called before the flush, causing writes after
ClearPageDirty() and before the flush to be lost?

This patch-set therefore performs the following changes:

1. Change mprotect, task_mmu and mapping_dirty_helpers to use mmu_gather
   instead of {inc|dec}_tlb_flush_pending().

2. Avoid TLB flushes if PTE permission is not demoted.

3. Cleans up mmu_gather to be less arch-dependant.

4. Uses mm's generations to track in finer granularity, either per-VMA
   or per page-table, whether a pending mmu_gather operation is
   outstanding. This should allow to avoid some TLB flushes when KSM or
   memory reclamation takes place while another operation such as
   munmap() or mprotect() is running.

5. Changes try_to_unmap_one() flushing scheme, as the current seems
   broken to track in a bitmap which CPUs have outstanding TLB flushes
   instead of having a flag.

Further optimizations are possible, such as changing move_ptes() to use
mmu_gather.

The patches were very very lightly tested. I am looking forward for your
feedback regarding the overall approaches, and whether to split them
into multiple patch-sets.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-csky@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: x86@kernel.org
Cc: Yu Zhao <yuzhao@google.com>


Nadav Amit (20):
  mm/tlb: fix fullmm semantics
  mm/mprotect: use mmu_gather
  mm/mprotect: do not flush on permission promotion
  mm/mapping_dirty_helpers: use mmu_gather
  mm/tlb: move BATCHED_UNMAP_TLB_FLUSH to tlb.h
  fs/task_mmu: use mmu_gather interface of clear-soft-dirty
  mm: move x86 tlb_gen to generic code
  mm: store completed TLB generation
  mm: create pte/pmd_tlb_flush_pending()
  mm: add pte_to_page()
  mm/tlb: remove arch-specific tlb_start/end_vma()
  mm/tlb: save the VMA that is flushed during tlb_start_vma()
  mm/tlb: introduce tlb_start_ptes() and tlb_end_ptes()
  mm: move inc/dec_tlb_flush_pending() to mmu_gather.c
  mm: detect deferred TLB flushes in vma granularity
  mm/tlb: per-page table generation tracking
  mm/tlb: updated completed deferred TLB flush conditionally
  mm: make mm_cpumask() volatile
  lib/cpumask: introduce cpumask_atomic_or()
  mm/rmap: avoid potential races

 arch/arm/include/asm/bitops.h         |   4 +-
 arch/arm/include/asm/pgtable.h        |   4 +-
 arch/arm64/include/asm/pgtable.h      |   4 +-
 arch/csky/Kconfig                     |   1 +
 arch/csky/include/asm/tlb.h           |  12 --
 arch/powerpc/Kconfig                  |   1 +
 arch/powerpc/include/asm/tlb.h        |   2 -
 arch/s390/Kconfig                     |   1 +
 arch/s390/include/asm/tlb.h           |   3 -
 arch/sparc/Kconfig                    |   1 +
 arch/sparc/include/asm/pgtable_64.h   |   9 +-
 arch/sparc/include/asm/tlb_64.h       |   2 -
 arch/sparc/mm/init_64.c               |   2 +-
 arch/x86/Kconfig                      |   3 +
 arch/x86/hyperv/mmu.c                 |   2 +-
 arch/x86/include/asm/mmu.h            |  10 -
 arch/x86/include/asm/mmu_context.h    |   1 -
 arch/x86/include/asm/paravirt_types.h |   2 +-
 arch/x86/include/asm/pgtable.h        |  24 +--
 arch/x86/include/asm/tlb.h            |  21 +-
 arch/x86/include/asm/tlbbatch.h       |  15 --
 arch/x86/include/asm/tlbflush.h       |  61 ++++--
 arch/x86/mm/tlb.c                     |  52 +++--
 arch/x86/xen/mmu_pv.c                 |   2 +-
 drivers/firmware/efi/efi.c            |   1 +
 fs/proc/task_mmu.c                    |  29 ++-
 include/asm-generic/bitops/find.h     |   8 +-
 include/asm-generic/tlb.h             | 291 +++++++++++++++++++++-----
 include/linux/bitmap.h                |  21 +-
 include/linux/cpumask.h               |  40 ++--
 include/linux/huge_mm.h               |   3 +-
 include/linux/mm.h                    |  29 ++-
 include/linux/mm_types.h              | 166 ++++++++++-----
 include/linux/mm_types_task.h         |  13 --
 include/linux/pgtable.h               |   2 +-
 include/linux/smp.h                   |   6 +-
 init/Kconfig                          |  21 ++
 kernel/fork.c                         |   2 +
 kernel/smp.c                          |   8 +-
 lib/bitmap.c                          |  33 ++-
 lib/cpumask.c                         |   8 +-
 lib/find_bit.c                        |  10 +-
 mm/huge_memory.c                      |   6 +-
 mm/init-mm.c                          |   1 +
 mm/internal.h                         |  16 --
 mm/ksm.c                              |   2 +-
 mm/madvise.c                          |   6 +-
 mm/mapping_dirty_helpers.c            |  52 +++--
 mm/memory.c                           |   2 +
 mm/mmap.c                             |   1 +
 mm/mmu_gather.c                       |  59 +++++-
 mm/mprotect.c                         |  55 ++---
 mm/mremap.c                           |   2 +-
 mm/pgtable-generic.c                  |   2 +-
 mm/rmap.c                             |  42 ++--
 mm/vmscan.c                           |   1 +
 56 files changed, 803 insertions(+), 374 deletions(-)
 delete mode 100644 arch/x86/include/asm/tlbbatch.h

-- 
2.25.1
