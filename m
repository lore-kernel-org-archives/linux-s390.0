Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43640 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgHMRKy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 13:10:54 -0400
Date: Thu, 13 Aug 2020 19:10:43 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] s390 updates for 5.9-rc1
Message-ID: <20200813171043.GE12168@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

Hi Linus,

please pull some small s390 updates for 5.9-rc1.

Thanks,
Heiko

The following changes since commit 00e4db51259a5f936fec1424b884f029479d3981:

  Merge tag 'perf-tools-2020-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (2020-08-10 19:21:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-2

for you to fetch changes up to b450eeb0c973ed4125ea91e35613f029337fd28b:

  s390/numa: move code to arch/s390/kernel (2020-08-11 18:16:55 +0200)

----------------------------------------------------------------
- Allow s390 debug feature to handle finally more than 256 CPU numbers, instead
  of truncating the most significant bits.

- Improve THP splitting required by qemu processes by making use of
  walk_page_vma() instead of calling follow_page() for every single page
  within each vma.

- Add missing ZCRYPT dependency to VFIO_AP to fix potential compile problems.

- Remove not required select CLOCKSOURCE_VALIDATE_LAST_CYCLE again.

- Set node distance to LOCAL_DISTANCE instead of 0, since e.g. libnuma
  translates a node distance of 0 to "no NUMA support available".

- Couple of other minor fixes and improvements.

----------------------------------------------------------------
Alexander Gordeev (2):
      s390/numa: set node distance to LOCAL_DISTANCE
      s390/numa: move code to arch/s390/kernel

Gerald Schaefer (1):
      s390/gmap: improve THP splitting

Heiko Carstens (1):
      s390/time: remove select CLOCKSOURCE_VALIDATE_LAST_CYCLE again

Krzysztof Kozlowski (1):
      s390/Kconfig: add missing ZCRYPT dependency to VFIO_AP

Mikhail Zaslonko (1):
      s390/debug: debug feature version 3

Tianjia Zhang (1):
      s390/pkey: remove redundant variable initialization

Vasily Gorbik (1):
      s390/atomic: circumvent gcc 10 build regression

Wang Hai (1):
      s390/test_unwind: fix possible memleak in test_unwind()

 arch/s390/Kbuild                  |  1 -
 arch/s390/Kconfig                 |  2 +-
 arch/s390/include/asm/atomic.h    | 12 ++++++++++--
 arch/s390/include/asm/debug.h     | 17 ++++++-----------
 arch/s390/include/asm/topology.h  |  6 ------
 arch/s390/kernel/Makefile         |  1 +
 arch/s390/kernel/debug.c          | 32 ++++++++++++++++++--------------
 arch/s390/{numa => kernel}/numa.c |  0
 arch/s390/lib/test_unwind.c       |  1 +
 arch/s390/mm/gmap.c               | 27 ++++++++++++++++++++-------
 arch/s390/numa/Makefile           |  2 --
 drivers/s390/crypto/pkey_api.c    |  4 ++--
 12 files changed, 59 insertions(+), 46 deletions(-)
 rename arch/s390/{numa => kernel}/numa.c (100%)
 delete mode 100644 arch/s390/numa/Makefile

diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
index e63940bb57cd..8b98c501142d 100644
--- a/arch/s390/Kbuild
+++ b/arch/s390/Kbuild
@@ -7,5 +7,4 @@ obj-$(CONFIG_S390_HYPFS_FS)	+= hypfs/
 obj-$(CONFIG_APPLDATA_BASE)	+= appldata/
 obj-y				+= net/
 obj-$(CONFIG_PCI)		+= pci/
-obj-$(CONFIG_NUMA)		+= numa/
 obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += purgatory/
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8c0b52940165..3d86e12e8e3c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -126,7 +126,6 @@ config S390
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_VMALLOC
-	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
@@ -766,6 +765,7 @@ config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
 	depends on S390_AP_IOMMU && VFIO_MDEV_DEVICE && KVM
+	depends on ZCRYPT
 	help
 		This driver grants access to Adjunct Processor (AP) devices
 		via the VFIO mediated device interface.
diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
index cae473a7b6f7..11c5952e1afa 100644
--- a/arch/s390/include/asm/atomic.h
+++ b/arch/s390/include/asm/atomic.h
@@ -45,7 +45,11 @@ static inline int atomic_fetch_add(int i, atomic_t *v)
 static inline void atomic_add(int i, atomic_t *v)
 {
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
-	if (__builtin_constant_p(i) && (i > -129) && (i < 128)) {
+	/*
+	 * Order of conditions is important to circumvent gcc 10 bug:
+	 * https://gcc.gnu.org/pipermail/gcc-patches/2020-July/549318.html
+	 */
+	if ((i > -129) && (i < 128) && __builtin_constant_p(i)) {
 		__atomic_add_const(i, &v->counter);
 		return;
 	}
@@ -112,7 +116,11 @@ static inline s64 atomic64_fetch_add(s64 i, atomic64_t *v)
 static inline void atomic64_add(s64 i, atomic64_t *v)
 {
 #ifdef CONFIG_HAVE_MARCH_Z196_FEATURES
-	if (__builtin_constant_p(i) && (i > -129) && (i < 128)) {
+	/*
+	 * Order of conditions is important to circumvent gcc 10 bug:
+	 * https://gcc.gnu.org/pipermail/gcc-patches/2020-July/549318.html
+	 */
+	if ((i > -129) && (i < 128) && __builtin_constant_p(i)) {
 		__atomic64_add_const(i, (long *)&v->counter);
 		return;
 	}
diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 17a26261f288..c1b82bcc017c 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -2,7 +2,7 @@
 /*
  *   S/390 debug facility
  *
- *    Copyright IBM Corp. 1999, 2000
+ *    Copyright IBM Corp. 1999, 2020
  */
 #ifndef DEBUG_H
 #define DEBUG_H
@@ -26,19 +26,14 @@
 #define DEBUG_DATA(entry) (char *)(entry + 1) /* data is stored behind */
 					      /* the entry information */
 
-#define __DEBUG_FEATURE_VERSION	   2  /* version of debug feature */
+#define __DEBUG_FEATURE_VERSION	   3  /* version of debug feature */
 
 struct __debug_entry {
-	union {
-		struct {
-			unsigned long clock	: 52;
-			unsigned long exception	:  1;
-			unsigned long level	:  3;
-			unsigned long cpuid	:  8;
-		} fields;
-		unsigned long stck;
-	} id;
+	unsigned long clock	: 60;
+	unsigned long exception	:  1;
+	unsigned long level	:  3;
 	void *caller;
+	unsigned short cpu;
 } __packed;
 
 typedef struct __debug_entry debug_entry_t;
diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index fbb507504a3b..3a0ac0c7a9a3 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -86,12 +86,6 @@ static inline const struct cpumask *cpumask_of_node(int node)
 
 #define pcibus_to_node(bus) __pcibus_to_node(bus)
 
-#define node_distance(a, b) __node_distance(a, b)
-static inline int __node_distance(int a, int b)
-{
-	return 0;
-}
-
 #else /* !CONFIG_NUMA */
 
 #define numa_node_id numa_node_id
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index a8f136943deb..efca70970761 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -49,6 +49,7 @@ CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_SCHED_TOPOLOGY)	+= topology.o
+obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index beb4b44a11d1..b6619ae9a3e0 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -2,7 +2,7 @@
 /*
  *   S/390 debug facility
  *
- *    Copyright IBM Corp. 1999, 2012
+ *    Copyright IBM Corp. 1999, 2020
  *
  *    Author(s): Michael Holzheu (holzheu@de.ibm.com),
  *		 Holger Smolinski (Holger.Smolinski@de.ibm.com)
@@ -433,7 +433,7 @@ static int debug_format_entry(file_private_info_t *p_info)
 	act_entry = (debug_entry_t *) ((char *)id_snap->areas[p_info->act_area]
 				       [p_info->act_page] + p_info->act_entry);
 
-	if (act_entry->id.stck == 0LL)
+	if (act_entry->clock == 0LL)
 		goto out; /* empty entry */
 	if (view->header_proc)
 		len += view->header_proc(id_snap, view, p_info->act_area,
@@ -829,12 +829,17 @@ static inline debug_entry_t *get_active_entry(debug_info_t *id)
 static inline void debug_finish_entry(debug_info_t *id, debug_entry_t *active,
 				      int level, int exception)
 {
-	active->id.stck = get_tod_clock_fast() -
-		*(unsigned long long *) &tod_clock_base[1];
-	active->id.fields.cpuid = smp_processor_id();
+	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	unsigned long timestamp;
+
+	get_tod_clock_ext(clk);
+	timestamp = *(unsigned long *) &clk[0] >> 4;
+	timestamp -= TOD_UNIX_EPOCH >> 12;
+	active->clock = timestamp;
+	active->cpu = smp_processor_id();
 	active->caller = __builtin_return_address(0);
-	active->id.fields.exception = exception;
-	active->id.fields.level = level;
+	active->exception = exception;
+	active->level = level;
 	proceed_active_entry(id);
 	if (exception)
 		proceed_active_area(id);
@@ -1398,25 +1403,24 @@ static int debug_hex_ascii_format_fn(debug_info_t *id, struct debug_view *view,
 int debug_dflt_header_fn(debug_info_t *id, struct debug_view *view,
 			 int area, debug_entry_t *entry, char *out_buf)
 {
-	unsigned long base, sec, usec;
+	unsigned long sec, usec;
 	unsigned long caller;
 	unsigned int level;
 	char *except_str;
 	int rc = 0;
 
-	level = entry->id.fields.level;
-	base = (*(unsigned long *) &tod_clock_base[0]) >> 4;
-	sec = (entry->id.stck >> 12) + base - (TOD_UNIX_EPOCH >> 12);
+	level = entry->level;
+	sec = entry->clock;
 	usec = do_div(sec, USEC_PER_SEC);
 
-	if (entry->id.fields.exception)
+	if (entry->exception)
 		except_str = "*";
 	else
 		except_str = "-";
 	caller = (unsigned long) entry->caller;
-	rc += sprintf(out_buf, "%02i %011ld:%06lu %1u %1s %02i %pK  ",
+	rc += sprintf(out_buf, "%02i %011ld:%06lu %1u %1s %04u %pK  ",
 		      area, sec, usec, level, except_str,
-		      entry->id.fields.cpuid, (void *)caller);
+		      entry->cpu, (void *)caller);
 	return rc;
 }
 EXPORT_SYMBOL(debug_dflt_header_fn);
diff --git a/arch/s390/numa/numa.c b/arch/s390/kernel/numa.c
similarity index 100%
rename from arch/s390/numa/numa.c
rename to arch/s390/kernel/numa.c
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index eb382ceaa116..7c988994931f 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -64,6 +64,7 @@ static noinline int test_unwind(struct task_struct *task, struct pt_regs *regs,
 			break;
 		if (state.reliable && !addr) {
 			pr_err("unwind state reliable but addr is 0\n");
+			kfree(bt);
 			return -EINVAL;
 		}
 		sprint_symbol(sym, addr);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 190357ff86b3..46c1bf2a3b4b 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2485,23 +2485,36 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 }
 EXPORT_SYMBOL_GPL(gmap_sync_dirty_log_pmd);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int thp_split_walk_pmd_entry(pmd_t *pmd, unsigned long addr,
+				    unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	split_huge_pmd(vma, pmd, addr);
+	return 0;
+}
+
+static const struct mm_walk_ops thp_split_walk_ops = {
+	.pmd_entry	= thp_split_walk_pmd_entry,
+};
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct vm_area_struct *vma;
-	unsigned long addr;
 
 	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
-		for (addr = vma->vm_start;
-		     addr < vma->vm_end;
-		     addr += PAGE_SIZE)
-			follow_page(vma, addr, FOLL_SPLIT);
 		vma->vm_flags &= ~VM_HUGEPAGE;
 		vma->vm_flags |= VM_NOHUGEPAGE;
+		walk_page_vma(vma, &thp_split_walk_ops, NULL);
 	}
 	mm->def_flags |= VM_NOHUGEPAGE;
-#endif
 }
+#else
+static inline void thp_split_mm(struct mm_struct *mm)
+{
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
  * Remove all empty zero pages from the mapping for lazy refaulting
diff --git a/arch/s390/numa/Makefile b/arch/s390/numa/Makefile
deleted file mode 100644
index c89d26f4f77d..000000000000
--- a/arch/s390/numa/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-y			+= numa.o
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index d5880f52dc2b..5896e5282a4e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -818,7 +818,7 @@ static int pkey_keyblob2pkey2(const struct pkey_apqn *apqns, size_t nr_apqns,
 static int pkey_apqns4key(const u8 *key, size_t keylen, u32 flags,
 			  struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	int rc = EINVAL;
+	int rc;
 	u32 _nr_apqns, *_apqns = NULL;
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
 
@@ -886,7 +886,7 @@ static int pkey_apqns4keytype(enum pkey_key_type ktype,
 			      u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
 			      struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	int rc = -EINVAL;
+	int rc;
 	u32 _nr_apqns, *_apqns = NULL;
 
 	if (ktype == PKEY_TYPE_CCA_DATA || ktype == PKEY_TYPE_CCA_CIPHER) {
