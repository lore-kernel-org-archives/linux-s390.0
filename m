Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 25 Jul 2016 18:22:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.8 merge window
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160725182248.7b858b73@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

There are a couple of new things for s390 with this merge request:

 * A new scheduling domain "drawer" is added to reflect the unusual
   topology found on z13 machines. Performance tests showed up to
   8 percent gain with the additional domain.
 * The new crc-32 checksum crypto module uses the vector-galois-field
   multiply and sum SIMD instruction to speed up crc-32 and crc-32c.
 * Proper __ro_after_init support, this requires RO_AFTER_INIT_DATA
   in the generic vmlinux.lds linker script definitions.
 * Kcov instrumentation support. A prerequisite for that is the
   inline assembly basic block cleanup, which is the reason for the 
   net/iucv/iucv.c change.
 * Support for 2GB pages is added to the hugetlbfs backend.

Then there are two removals:

 * The oprofile hardware sampling support is dead code and is removed.
   The oprofile user space uses the perf interface nowadays.
 * The ETR clock synchronization is removed, this has been superseeded
   be the STP clock synchronization. And it always has been "interesting"
   code..

And the usual bug fixes and cleanups.

The shortlog:

Bhaktipriya Shridhar (1):
      s390/cio/chp : Remove deprecated create_singlethread_workqueue

Christian Borntraeger (1):
      s390: dump_stack: fill in arch description

Dan Carpenter (1):
      s390/smp: clean up a condition

Daniel van Gerpen (1):
      s390: use canonical include guard style

David Hildenbrand (1):
      s390/mm: fix gmap tlb flush issues

Gerald Schaefer (1):
      s390/mm: add support for 2GB hugepages

Heiko Carstens (49):
      s390/pgtable: introduce and use generic csp inline asm
      s390/vmem: align segment and region tables to 16k
      s390/vmem: introduce and use SEGMENT_KERNEL and REGION3_KERNEL
      s390/pgtable: get rid of _REGION3_ENTRY_RO
      s390/vmem: make use of pte_clear()
      s390/mm: always use PAGE_KERNEL when mapping pages
      s390/pgtable: make pmd and pud helper functions available
      s390/pageattr: allow kernel page table splitting
      s390/vmem: simplify vmem code for read-only mappings
      s390/pgtable: add mapping statistics
      s390/cpuinfo: print cache info and all single cpu lines on first iteration
      s390/cpuinfo: show dynamic and static cpu mhz
      s390/mm: align swapper_pg_dir to 16k
      s390/kexec: fix update of os_info crash kernel size
      s390/kexec: fix crash on resize of reserved memory
      vmlinux.lds.h: allow arch specific handling of ro_after_init data section
      s390: add proper __ro_after_init support
      s390: use __section macro everywhere
      s390/uaccess: fix whitespace damage
      s390/uaccess: use __builtin_expect for get_user/put_user
      s390: avoid extable collisions
      s390/ipl: use load normal for LPAR re-ipl
      s390/ipl: rename diagnose enums
      topology/sysfs: provide drawer id and siblings attributes
      s390/topology: add drawer scheduling domain level
      s390/topology: remove z10 special handling
      s390/mm: fix compile for PAGE_DEFAULT_KEY != 0
      s390: calculate loops_per_jiffies with fp instructions
      s390: remove math emulation code
      s390/oprofile: remove hardware sampler support
      s390/perf: remove perf_release/reserver_sampling functions
      s390/cpuinfo: rename cpu field to cpu number
      s390/uaccess: fix __put_get_user_asm define
      s390/lib: use basic blocks for inline assemblies
      s390/mm: use basic block for essa inline assembly
      s390/crypto: use basic blocks for ap bus inline assemblies
      s390/iucv: use basic blocks for iucv inline assemblies
      s390/pci: use basic blocks for pci inline assemblies
      s390/cio: use basic blocks for cmf inline assemblies
      s390/cio: use basic blocks for i/o inline assemblies
      s390/smp: use basic blocks for sigp inline assemblies
      s390/sysinfo: use basic block for stsi inline assembly
      s390/hypfs: use basic block for diag inline assembly
      s390/cpumf: use basic block for ecctr inline assembly
      s390: enable kcov support
      s390: remove pointless load within __switch_to
      s390: stack address vs thread_info
      s390/cpuinfo: show maximum thread id
      s390: have unique symbol for __switch_to address

Hendrik Brueckner (4):
      s390/vx: add support functions for in-kernel FPU use
      s390/crc32-vx: use vector instructions to optimize CRC-32 computation
      s390/crc32-vx: add crypto API module for optimized CRC-32 algorithms
      s390: Updated kernel config files

Jason Baron (1):
      s390: add explicit <linux/stringify.h> for jump label

Markus Elfring (1):
      s390/pci: Delete an unnecessary check before the function call "pci_dev_put"

Martin Schwidefsky (9):
      s390/time: STP sync clock correction
      s390/time: move PTFF definitions
      s390/time: LPAR offset handling
      s390/time: add leap seconds to initial system time
      s390/time: remove ETR support
      s390/mm: fix vunmap vs finish_arch_post_lock_switch
      bitmap: bitmap_equal memcmp optimization
      s390/mm: simplify the TLB flushing code
      s390/ptrace: clarify bits in the per_struct

Muhammad Falak R Wani (1):
      s390/keyboard: use memdup_user_nul()

Peter Oberparleiter (1):
      s390/console: Make preferred console handling more consistent

Sebastian Ott (9):
      s390: use SPARSE_IRQ
      s390/pci: ensure page aligned dma start address
      s390/pci: ensure to not cross a dma segment boundary
      s390/cio: allow to reset channel measurement block
      s390/cio/device_ops: fix kernel doc
      s390/chsc: fix ioctl CHSC_INFO_CU command
      s390/cio: make fmt1 channel path descriptor optional
      s390/chsc: sanitize fmt check for chp_desc determination
      s390/chsc: improve channel path descriptor determination

Thomas Richter (1):
      s390/Documentation: improve sort command for trace buffer

 Documentation/cputopology.txt           |   40 +-
 Documentation/kernel-parameters.txt     |    2 -
 Documentation/s390/s390dbf.txt          |    2 +-
 arch/s390/Kconfig                       |   16 +-
 arch/s390/boot/compressed/Makefile      |    2 +
 arch/s390/configs/default_defconfig     |    1 +
 arch/s390/configs/gcov_defconfig        |    1 +
 arch/s390/configs/performance_defconfig |    1 +
 arch/s390/crypto/Makefile               |    3 +
 arch/s390/crypto/crc32-vx.c             |  310 ++++++++
 arch/s390/crypto/crc32be-vx.S           |  207 ++++++
 arch/s390/crypto/crc32le-vx.S           |  268 +++++++
 arch/s390/defconfig                     |    4 +
 arch/s390/hypfs/hypfs_diag.c            |   14 +-
 arch/s390/hypfs/hypfs_vm.c              |    2 +-
 arch/s390/include/asm/cache.h           |    5 +-
 arch/s390/include/asm/cio.h             |    2 +-
 arch/s390/include/asm/cpu_mf.h          |   17 +-
 arch/s390/include/asm/diag.h            |    2 +-
 arch/s390/include/asm/etr.h             |  261 -------
 arch/s390/include/asm/fcx.h             |    2 +-
 arch/s390/include/asm/fpu/api.h         |   75 ++
 arch/s390/include/asm/fpu/types.h       |   10 +
 arch/s390/include/asm/hugetlb.h         |    5 +-
 arch/s390/include/asm/ipl.h             |   10 +-
 arch/s390/include/asm/irq.h             |    7 +-
 arch/s390/include/asm/jump_label.h      |    1 +
 arch/s390/include/asm/kprobes.h         |    4 +-
 arch/s390/include/asm/mathemu.h         |   28 -
 arch/s390/include/asm/mmu.h             |    2 +-
 arch/s390/include/asm/mmu_context.h     |   15 +-
 arch/s390/include/asm/page.h            |    8 +-
 arch/s390/include/asm/perf_event.h      |   12 -
 arch/s390/include/asm/pgtable.h         |  272 +++++--
 arch/s390/include/asm/processor.h       |   17 +-
 arch/s390/include/asm/sections.h        |    1 +
 arch/s390/include/asm/setup.h           |    4 +
 arch/s390/include/asm/sfp-machine.h     |  142 ----
 arch/s390/include/asm/sfp-util.h        |   67 --
 arch/s390/include/asm/sigp.h            |   17 +-
 arch/s390/include/asm/stp.h             |   51 ++
 arch/s390/include/asm/timex.h           |   66 +-
 arch/s390/include/asm/tlbflush.h        |   31 +-
 arch/s390/include/asm/topology.h        |    4 +
 arch/s390/include/asm/uaccess.h         |   65 +-
 arch/s390/include/uapi/asm/ptrace.h     |    6 +-
 arch/s390/kernel/Makefile               |    5 +-
 arch/s390/kernel/cache.c                |    7 +-
 arch/s390/kernel/dis.c                  |    1 -
 arch/s390/kernel/dumpstack.c            |   12 +-
 arch/s390/kernel/early.c                |   22 +
 arch/s390/kernel/entry.S                |   11 +-
 arch/s390/kernel/fpu.c                  |  249 +++++++
 arch/s390/kernel/ipl.c                  |   25 +-
 arch/s390/kernel/irq.c                  |    7 +-
 arch/s390/kernel/machine_kexec.c        |   55 +-
 arch/s390/kernel/nmi.c                  |   13 +-
 arch/s390/kernel/perf_cpum_sf.c         |    5 -
 arch/s390/kernel/perf_event.c           |   30 -
 arch/s390/kernel/processor.c            |  114 ++-
 arch/s390/kernel/setup.c                |   40 +-
 arch/s390/kernel/smp.c                  |   18 +-
 arch/s390/kernel/sysinfo.c              |   63 +-
 arch/s390/kernel/time.c                 | 1053 ++-------------------------
 arch/s390/kernel/topology.c             |   89 +--
 arch/s390/kernel/vdso32/Makefile        |    2 +
 arch/s390/kernel/vdso64/Makefile        |    2 +
 arch/s390/kernel/vmlinux.lds.S          |   21 +-
 arch/s390/kvm/kvm-s390.c                |    2 +-
 arch/s390/lib/string.c                  |   50 +-
 arch/s390/lib/uaccess.c                 |    6 +-
 arch/s390/mm/dump_pagetables.c          |    2 +-
 arch/s390/mm/fault.c                    |    2 +-
 arch/s390/mm/gmap.c                     |    7 +-
 arch/s390/mm/gup.c                      |   45 +-
 arch/s390/mm/hugetlbpage.c              |  129 +++-
 arch/s390/mm/init.c                     |   13 +-
 arch/s390/mm/page-states.c              |   13 +-
 arch/s390/mm/pageattr.c                 |  267 ++++++-
 arch/s390/mm/pgtable.c                  |   93 ++-
 arch/s390/mm/vmem.c                     |   73 +-
 arch/s390/numa/mode_emu.c               |   25 +-
 arch/s390/oprofile/Makefile             |    1 -
 arch/s390/oprofile/hwsampler.c          | 1178 -------------------------------
 arch/s390/oprofile/hwsampler.h          |   63 --
 arch/s390/oprofile/init.c               |  489 -------------
 arch/s390/oprofile/op_counter.h         |   21 -
 arch/s390/pci/pci_dma.c                 |    4 +-
 arch/s390/pci/pci_event.c               |    3 +-
 arch/s390/pci/pci_insn.c                |   12 +-
 drivers/base/topology.c                 |   13 +
 drivers/crypto/Kconfig                  |   13 +
 drivers/s390/block/dasd_eckd.c          |    4 +-
 drivers/s390/char/keyboard.c            |   15 +-
 drivers/s390/char/sclp_con.c            |    3 +-
 drivers/s390/char/sclp_config.c         |    2 +-
 drivers/s390/char/zcore.c               |    2 +-
 drivers/s390/cio/chp.c                  |   22 +-
 drivers/s390/cio/chp.h                  |    2 +-
 drivers/s390/cio/chsc.c                 |   25 +-
 drivers/s390/cio/chsc.h                 |    5 +-
 drivers/s390/cio/chsc_sch.c             |    2 +-
 drivers/s390/cio/cmf.c                  |   44 +-
 drivers/s390/cio/device_ops.c           |   22 +-
 drivers/s390/cio/idset.h                |    2 +-
 drivers/s390/cio/ioasm.c                |   91 ++-
 drivers/s390/crypto/ap_bus.c            |   77 +-
 include/asm-generic/vmlinux.lds.h       |   10 +-
 include/linux/bitmap.h                  |    4 +
 mm/hugetlb.c                            |    4 +-
 net/iucv/iucv.c                         |   36 +-
 111 files changed, 2861 insertions(+), 3961 deletions(-)
 create mode 100644 arch/s390/crypto/crc32-vx.c
 create mode 100644 arch/s390/crypto/crc32be-vx.S
 create mode 100644 arch/s390/crypto/crc32le-vx.S
 delete mode 100644 arch/s390/include/asm/etr.h
 delete mode 100644 arch/s390/include/asm/mathemu.h
 delete mode 100644 arch/s390/include/asm/sfp-machine.h
 delete mode 100644 arch/s390/include/asm/sfp-util.h
 create mode 100644 arch/s390/include/asm/stp.h
 create mode 100644 arch/s390/kernel/fpu.c
 delete mode 100644 arch/s390/oprofile/hwsampler.c
 delete mode 100644 arch/s390/oprofile/hwsampler.h
 delete mode 100644 arch/s390/oprofile/op_counter.h


There are a couple of merge conflicts between the s390 tree and
the kvm tree. If the kvm tree is pulled first this patch will
resolve the fallout:

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index cc1e16a..28f03ca 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -210,33 +210,6 @@ static inline __u64 phys_cpu__ctidx(enum diag204_format type, void *hdr)
 }
 
 /* Diagnose 204 functions */
-<<<<<<< HEAD
-=======
-
-static inline int __diag204(unsigned long *subcode, unsigned long size, void *addr)
-{
-	register unsigned long _subcode asm("0") = *subcode;
-	register unsigned long _size asm("1") = size;
-
-	asm volatile(
-		"	diag	%2,%0,0x204\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b,0b)
-		: "+d" (_subcode), "+d" (_size) : "d" (addr) : "memory");
-	*subcode = _subcode;
-	return _size;
-}
-
-static int diag204(unsigned long subcode, unsigned long size, void *addr)
-{
-	diag_stat_inc(DIAG_STAT_X204);
-	size = __diag204(&subcode, size, addr);
-	if (subcode)
-		return -1;
-	return size;
-}
-
->>>>>>> 64a40c84001e55001a4d80496b6b56e4d04e4360
 /*
  * For the old diag subcode 4 with simple data format we have to use real
  * memory. If we use subcode 6 or 7 with extended data format, we can (and
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index a44faf4..a97354c 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -162,25 +162,27 @@ int diag14(unsigned long rx, unsigned long ry1, unsigned long subcode)
 }
 EXPORT_SYMBOL(diag14);
 
-static inline int __diag204(unsigned long subcode, unsigned long size, void *addr)
+static inline int __diag204(unsigned long *subcode, unsigned long size, void *addr)
 {
-	register unsigned long _subcode asm("0") = subcode;
+	register unsigned long _subcode asm("0") = *subcode;
 	register unsigned long _size asm("1") = size;
 
 	asm volatile(
 		"	diag	%2,%0,0x204\n"
-		"0:\n"
+		"0:	nopr	%%r7\n"
 		EX_TABLE(0b,0b)
 		: "+d" (_subcode), "+d" (_size) : "d" (addr) : "memory");
-	if (_subcode)
-		return -1;
+	*subcode = _subcode;
 	return _size;
 }
 
 int diag204(unsigned long subcode, unsigned long size, void *addr)
 {
 	diag_stat_inc(DIAG_STAT_X204);
-	return __diag204(subcode, size, addr);
+	size = __diag204(&subcode, size, addr);
+	if (subcode)
+		return -1;
+	return size;
 }
 EXPORT_SYMBOL(diag204);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8911848..d0bf317 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -38,7 +38,6 @@
 #include <asm/isc.h>
 #include <asm/sclp.h>
 #include <asm/cpacf.h>
-#include <asm/etr.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -243,7 +242,8 @@ static void kvm_s390_cpu_feat_init(void)
 	}
 
 	if (test_facility(28)) /* TOD-clock steering */
-		etr_ptff(kvm_s390_available_subfunc.ptff, ETR_PTFF_QAF);
+		ptff(kvm_s390_available_subfunc.ptff,
+		     sizeof(kvm_s390_available_subfunc.ptff), PTFF_QAF);
 
 	if (test_facility(17)) { /* MSA */
 		__cpacf_query(CPACF_KMAC, kvm_s390_available_subfunc.kmac);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 3d12272..2ce6bb3 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -175,18 +175,9 @@ static void gmap_free(struct gmap *gmap)
 {
 	struct page *page, *next;
 
-<<<<<<< HEAD
 	/* Flush tlb of all gmaps (if not already done for shadows) */
 	if (!(gmap_is_shadow(gmap) && gmap->removed))
 		gmap_flush_tlb(gmap);
-=======
-	/* Flush tlb. */
-	if (MACHINE_HAS_IDTE)
-		__tlb_flush_idte(gmap->asce);
-	else
-		__tlb_flush_global();
-
->>>>>>> 64a40c84001e55001a4d80496b6b56e4d04e4360
 	/* Free all segment & region tables. */
 	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
 		__free_pages(page, 2);
