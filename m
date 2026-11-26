Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691950;
	b=076F8c9BuuIDH3e1R79PSFomgBdf2+gd+Iizt3ZgYr5WJuad4q1maTvsfrQlYqwQ57CX
	 121QHsScU0w4dciyQonJ0bjzch0Gkt3TNw9eHoTD0nQW2cqyFmIkdM9Cqahl4v6kXPgyK
	 kehjJgRlZpHIqEG2cDLcmDy7jqchQ4cLv1eM9r+ab1LfdO2i9zhLYTQ1KFbrdX33Rz0JM
	 /I8oZDdc/9fPrrTewPxYQk/OvP2RdvsU5q8pYAJbNipO9DuygXGVrvIZWgV6mWmD08I08
	 ypgjKCs9RNlqC/wvbK+sFJauIGHIrps76RcqysdvbPeX9Bz0L23jk9WH1k1+UMRmwJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691950;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=A+PUx0XRCbGTx37HJhScnoRBeaQUZVDNbN5754+g1GI=;
	b=uhPbdGh1pDa+Zt58gljiQGrMRLi52hjkRxJXwesh37zLA/St9gqxagFZD3o0xT07f+NH
	 sCflD0ZYnUDhMX7IHgScNxqXQKtzpZ56rjv39epSuEnPGWoAcgHeo9wnNilVMAWZUK2a1
	 5wgZtUDo/aVvZxziVzjNpKCbFhnZqTqF/VuqXJnIXX8xHPBkVNPkICKTX32PbbYriFCTV
	 7Rg4Wf/oAqDUClZZ2dQJ2/egHxdLuwINw+nbAu2cWUVSF2fUWgM8wl2hQ3/W+6zM/aiO/
	 WdMA+onHu7aL1TwSrbVF8d10+B8hBKuNBsiGBGKdlqQ9xKo+7+thqTzHRqptdZD9IwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNEe2twT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75400606A32A;
	Thu, 26 Nov 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNEe2twT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038211F00ACF;
	Thu, 26 Nov 2026 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691949;
	bh=A+PUx0XRCbGTx37HJhScnoRBeaQUZVDNbN5754+g1GI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SNEe2twTnC9EK4Dss6Prp095ihJBxfunWzGB5EdSJKHr4Eo9OefU3k1kdtnTaHn9a
	 0XjmHQrGnKEFnI6zn1fSy6ihAmxdI1L0m/4SRU4kfAWeqR4/QvG4OScId1YZfgVO3n
	 uMSVDh3vw14t6ajVxuOP4gQf1BDTg6Zju/pDC+Cd6JXRiYlQG15Ci8kJhA9A6TmHrJ
	 G0ei6sYbFyLHPLQmHbBrxwJlq0EVMO//BBz4jtma6pYE6Vgl7L5oJWhNzYHzctZ9po
	 YM8bC59b9l/K8awSKxVSiHjcRaU3oQ5CjsyImWNKMLQ6xQl6REMgHAZ53+E3pPZ2Dy
	 ED5pMMf4SfWlQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:42 +0200
Subject: [PATCH RFC v2 29/54] x86/mm/pat, mm: pull CPA core to mm/
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-29-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev

Currently there are seven independent implementations for set_memory_*()
and set_direct_map_*().

With increasing demand for kernel page table manipulations, for example
"Direct Map Removal Support for guest_memfd" [1] and "mm: ASI direct map
management" [2], it makes sense to have a generic core in mm/ that
implements the common parts, like page table walks, decisions when to keep
or split large mappings and statistics, with helpers in the architecture
specific code.

The common core will replace seven different policies of what and when
set_memory_*() and set_direct_map_*() would do with the page tables with a
single one that sets common expectations for the callers.

x86's implementation is the most versatile and most battle-tested, and as
such it is the best base for the generic implementation.

It has all the pieces: it preserves large mappings when it can, it splits
when it must, it handles the direct map alias, it serializes against itself
and it sanity checks the result.

Every architecture that reports DirectMap lines in /proc/meminfo has its
own copy of the counters and of the code that prints them. They all count
the same thing: how the direct map is mapped at every page table level.

Pull the core logic of x86 CPA to mm/pageattr.c, together with the direct
map counters and their vmstat events.

Add GENERIC_PAGEATTR Kconfig option to let architectures opt in to the
generic implementation and enable it on x86.

Declare architecture hooks for page table format, restrictions on allowed
and supported protections, alias mapping definitions and TLB management in
include/linux/pageattr.h. The hooks that not every architecture needs have
defaults.

Apart from the table of operations, the x86 set_memory_*() and
set_direct_map_*_noflush() only build a request and pass it to the core.
Move them to mm/pageattr.c as well. An architecture that uses the core
provides its operations with arch_cpa_prepare().

On x86 only the statistics change: X86_CPA_STATISTICS becomes
CPA_STATISTICS and the debugfs file moves from x86/cpa_stats to cpa_stats.

The vmstat events of the direct map counters will show up on every
architecture that uses the core.

[1] https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com
[2] https://lore.kernel.org/all/20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com/

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/Kconfig                  |   9 +-
 arch/x86/include/asm/pageattr.h   |  28 ++
 arch/x86/include/asm/set_memory.h |   5 -
 arch/x86/mm/init_32.c             |   1 +
 arch/x86/mm/init_64.c             |   1 +
 arch/x86/mm/mm_internal.h         |   7 -
 arch/x86/mm/pat/set_memory.c      | 720 +-------------------------------------
 include/asm-generic/set_memory.h  |  11 +
 include/linux/pageattr.h          | 161 +++++++++
 include/linux/vm_event_item.h     |   2 +-
 mm/Kconfig                        |   3 +
 mm/Kconfig.debug                  |   8 +
 mm/Makefile                       |   1 +
 mm/pageattr.c                     | 625 +++++++++++++++++++++++++++++++++
 mm/vmstat.c                       |   2 +-
 15 files changed, 853 insertions(+), 731 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..f4aceaceaf65 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -178,6 +178,7 @@ config X86
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PAGEATTR
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_GETTIMEOFDAY
@@ -1473,14 +1474,6 @@ config X86_DIRECT_GBPAGES
 	  supports them), so don't confuse the user by printing
 	  that we have them enabled.
 
-config X86_CPA_STATISTICS
-	bool "Enable statistic for Change Page Attribute"
-	depends on DEBUG_FS
-	help
-	  Expose statistics about the Change Page Attribute mechanism, which
-	  helps to determine the effectiveness of preserving large and huge
-	  page mappings when mapping protections are changed.
-
 config X86_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select DYNAMIC_PHYSICAL_MASK
diff --git a/arch/x86/include/asm/pageattr.h b/arch/x86/include/asm/pageattr.h
new file mode 100644
index 000000000000..dea7141c3713
--- /dev/null
+++ b/arch/x86/include/asm/pageattr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PAGEATTR_H
+#define _ASM_X86_PAGEATTR_H
+
+static inline bool cpa_is_direct_map(unsigned long addr)
+{
+	return addr >= PAGE_OFFSET &&
+	       addr < PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT);
+}
+#define cpa_is_direct_map cpa_is_direct_map
+
+pgprot_t arch_cpa_new_prot(struct cpa_data *cpa, struct cpa_leaf *leaf);
+#define arch_cpa_new_prot arch_cpa_new_prot
+
+int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
+			void *table);
+#define arch_cpa_split_leaf arch_cpa_split_leaf
+
+int arch_cpa_process_fault(struct cpa_data *cpa);
+#define arch_cpa_process_fault arch_cpa_process_fault
+
+int arch_cpa_process_alias(struct cpa_data *cpa);
+#define arch_cpa_process_alias arch_cpa_process_alias
+
+void arch_cpa_collapse(struct cpa_data *cpa);
+#define arch_cpa_collapse arch_cpa_collapse
+
+#endif /* _ASM_X86_PAGEATTR_H */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 39271a5ea925..7c1981305796 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -6,9 +6,6 @@
 #include <asm-generic/set_memory.h>
 #include <asm/pgtable.h>
 
-#define set_memory_rox set_memory_rox
-int set_memory_rox(unsigned long addr, int numpages);
-
 /*
  * The set_memory_* API can be used to change various attributes of a virtual
  * address range. The attributes include:
@@ -86,8 +83,6 @@ int set_pages_wb(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
-int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
-int set_direct_map_default_noflush(struct page *page, unsigned int nr);
 bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index d9e835aaf912..39c84a07449e 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -30,6 +30,7 @@
 #include <linux/initrd.h>
 #include <linux/cpumask.h>
 #include <linux/gfp.h>
+#include <linux/pageattr.h>
 
 #include <asm/asm.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e2592ed2d905..56acc97a7bf6 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/pageattr.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 8e461ae43d5f..7c4a41235323 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -24,13 +24,6 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
 extern unsigned long tlb_single_page_flush_ceiling;
 
-#ifdef CONFIG_PROC_FS
-void direct_map_count_update(enum pgtable_level level, long pages);
-#else
-static inline void direct_map_count_update(enum pgtable_level level,
-					   long pages) { }
-#endif
-
 #ifdef CONFIG_NUMA
 void __init x86_numa_init(void);
 #endif
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 34c58c7da4e3..11dc83d05404 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -10,17 +10,16 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
-#include <linux/debugfs.h>
 #include <linux/pfn.h>
 #include <linux/percpu.h>
 #include <linux/gfp.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/libnvdimm.h>
-#include <linux/vmstat.h>
 #include <linux/kernel.h>
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
+#include <linux/pageattr.h>
 #include <linux/memregion.h>
 #include <linux/cleanup.h>
 
@@ -36,30 +35,6 @@
 
 #include "../mm_internal.h"
 
-/*
- * The current flushing context - we pass it instead of 5 arguments:
- */
-struct cpa_data {
-	unsigned long	addr;
-	pgd_t		*pgd;
-	pgprot_t	mask_set;
-	pgprot_t	mask_clr;
-	unsigned long	numpages;
-	unsigned long	curpage;
-	unsigned long	pfn;
-	unsigned int	flags;
-	unsigned int	state;
-};
-
-struct cpa_leaf {
-	pte_t			*kpte;
-	enum pgtable_level	level;
-	unsigned long		addr;
-	unsigned long		size;
-	unsigned long		pfn;
-	pgprot_t		prot;
-};
-
 enum cpa_warn {
 	CPA_PROTECT,
 	CPA_DETECT,
@@ -67,96 +42,12 @@ enum cpa_warn {
 
 static const int cpa_warn_level = CPA_PROTECT;
 
-/*
- * Serialize CPA using cpa_lock so that:
- * - concurrent requests don't split or change the same large mapping at the
- *   same time
- * - collapses of large mappings don't free page tables under a CPA lookup
- */
-static DEFINE_SPINLOCK(cpa_lock);
-
-/* cpa_data::flags */
-#define CPA_REQ_NO_CHECK_ALIAS	0x01 /* Do not search for aliases */
-#define CPA_REQ_COLLAPSE	0x02 /* try to collapse large pages */
-#define CPA_REQ_SPLIT		0x04 /* split large pages */
-
-/* cpa_data::state */
-#define CPA_ST_FLUSHTLB		0x01 /* the TLB needs a flush */
-#define CPA_ST_FLUSH_ALL	0x02 /* flush the entire TLB */
-#define CPA_ST_ALIAS		0x04 /* the request is for an alias */
-
 static inline pgprot_t cachemode2pgprot(enum page_cache_mode pcm)
 {
 	return __pgprot(cachemode2protval(pcm));
 }
 
-#if defined(CONFIG_PROC_FS) || defined(CONFIG_X86_CPA_STATISTICS)
-static const char *cpa_size_str(enum pgtable_level level, char *buf, size_t len)
-{
-	unsigned long size = pgtable_level_size(level);
-
-	if (size >= SZ_1G)
-		snprintf(buf, len, "%luG", size >> 30);
-	else if (size >= SZ_1M)
-		snprintf(buf, len, "%luM", size >> 20);
-	else
-		snprintf(buf, len, "%luk", size >> 10);
-
-	return buf;
-}
-#endif
-
 #ifdef CONFIG_PROC_FS
-static atomic_long_t cpa_direct_map_pages[PGTABLE_LEVEL_NUM];
-
-void direct_map_count_update(enum pgtable_level level, long pages)
-{
-	atomic_long_add(pages, &cpa_direct_map_pages[level]);
-}
-
-static void direct_map_count_split(enum pgtable_level level)
-{
-	if (atomic_long_dec_if_positive(&cpa_direct_map_pages[level]) < 0)
-		return;
-
-	if (system_state == SYSTEM_RUNNING) {
-		if (level == PGTABLE_LEVEL_PMD)
-			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
-		else if (level == PGTABLE_LEVEL_PUD)
-			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
-	}
-	atomic_long_add(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
-}
-
-static void direct_map_count_collapse(enum pgtable_level level)
-{
-	atomic_long_inc(&cpa_direct_map_pages[level]);
-	if (system_state == SYSTEM_RUNNING) {
-		if (level == PGTABLE_LEVEL_PMD)
-			count_vm_event(DIRECT_MAP_LEVEL2_COLLAPSE);
-		else if (level == PGTABLE_LEVEL_PUD)
-			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
-	}
-	atomic_long_sub(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
-}
-
-static void cpa_report_meminfo(struct seq_file *m, unsigned long levels)
-{
-	enum pgtable_level level;
-	char label[32], sz[20];
-
-	for (level = PGTABLE_LEVEL_PTE; level <= PGTABLE_LEVEL_PGD; level++) {
-		if (!(levels & BIT(level)))
-			continue;
-
-		snprintf(label, sizeof(label), "DirectMap%s:",
-			 cpa_size_str(level, sz, sizeof(sz)));
-		seq_printf(m, "%-16s%8lu kB\n", label,
-			   atomic_long_read(&cpa_direct_map_pages[level]) *
-			   (pgtable_level_size(level) >> 10));
-	}
-}
-
 void arch_report_meminfo(struct seq_file *m)
 {
 	unsigned long levels = BIT(PGTABLE_LEVEL_PTE) | BIT(PGTABLE_LEVEL_PMD);
@@ -166,99 +57,14 @@ void arch_report_meminfo(struct seq_file *m)
 
 	cpa_report_meminfo(m, levels);
 }
-#else
-static inline void direct_map_count_split(enum pgtable_level level) { }
-static inline void direct_map_count_collapse(enum pgtable_level level) { }
 #endif
 
-#ifdef CONFIG_X86_CPA_STATISTICS
-
-static unsigned long cpa_checked[PGTABLE_LEVEL_NUM];
-static unsigned long cpa_sameprot[PGTABLE_LEVEL_NUM];
-static unsigned long cpa_preserved[PGTABLE_LEVEL_NUM];
-
-static inline void cpa_inc_pxd_checked(enum pgtable_level level)
-{
-	cpa_checked[level]++;
-}
-
-static inline void cpa_inc_pte_install(void)
-{
-	cpa_checked[PGTABLE_LEVEL_PTE]++;
-}
-
-static inline void cpa_inc_pxd_sameprot(enum pgtable_level level)
-{
-	cpa_sameprot[level]++;
-}
-
-static inline void cpa_inc_pxd_preserved(enum pgtable_level level)
-{
-	cpa_preserved[level]++;
-}
-
-static void cpastats_show_level(struct seq_file *m, enum pgtable_level level)
-{
-	char sz[20];
-
-	cpa_size_str(level, sz, sizeof(sz));
-	seq_printf(m, "%s pages checked:     %16lu\n", sz, cpa_checked[level]);
-	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, cpa_sameprot[level]);
-	seq_printf(m, "%s pages preserved:   %16lu\n", sz,
-		   cpa_preserved[level]);
-}
-
-static int cpastats_show(struct seq_file *m, void *p)
-{
-	char sz[20];
-
-	cpastats_show_level(m, PGTABLE_LEVEL_PUD);
-	cpastats_show_level(m, PGTABLE_LEVEL_PMD);
-	seq_printf(m, "%s pages set-checked: %16lu\n",
-		   cpa_size_str(PGTABLE_LEVEL_PTE, sz, sizeof(sz)),
-		   cpa_checked[PGTABLE_LEVEL_PTE]);
-	return 0;
-}
-
-static int cpastats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cpastats_show, NULL);
-}
-
-static const struct file_operations cpastats_fops = {
-	.open		= cpastats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init cpa_stats_init(void)
-{
-	debugfs_create_file("cpa_stats", S_IRUSR, arch_debugfs_dir, NULL,
-			    &cpastats_fops);
-	return 0;
-}
-late_initcall(cpa_stats_init);
-#else
-static inline void cpa_inc_pxd_checked(enum pgtable_level level) { }
-static inline void cpa_inc_pte_install(void) { }
-static inline void cpa_inc_pxd_sameprot(enum pgtable_level level) { }
-static inline void cpa_inc_pxd_preserved(enum pgtable_level level) { }
-#endif
-
-
 static inline int
 within(unsigned long addr, unsigned long start, unsigned long end)
 {
 	return addr >= start && addr < end;
 }
 
-static inline bool cpa_is_direct_map(unsigned long addr)
-{
-	return within(addr, PAGE_OFFSET,
-		      PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT));
-}
-
 #ifdef CONFIG_X86_64
 
 static inline int
@@ -337,19 +143,6 @@ static inline unsigned long fix_addr(unsigned long addr)
 #endif
 }
 
-static pgd_t *cpa_pgd(struct cpa_data *cpa, unsigned long address)
-{
-	if (!cpa->pgd)
-		return pgd_offset_k(address);
-
-	return cpa->pgd + pgd_index(address);
-}
-
-static unsigned long cpa_addr(struct cpa_data *cpa, unsigned long idx)
-{
-	return cpa->addr + idx * PAGE_SIZE;
-}
-
 /*
  * Flushing functions
  */
@@ -460,7 +253,7 @@ static void __cpa_flush_tlb(void *data)
 
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
 
-static void arch_cpa_collapse(struct cpa_data *cpa)
+void arch_cpa_collapse(struct cpa_data *cpa)
 {
 	unsigned long start, addr, end;
 	struct ptdesc *ptdesc, *tmp;
@@ -540,7 +333,7 @@ static void cpa_flush(struct cpa_data *cpa, int cache)
 	__cpa_flush(&req, cache);
 }
 
-static void arch_cpa_flush(struct cpa_data *cpa)
+void arch_cpa_flush(struct cpa_data *cpa)
 {
 	/*
 	 * No need to flush, when we did not set any of the caching
@@ -882,46 +675,7 @@ pte_t *lookup_address(unsigned long address, unsigned int *level)
 }
 EXPORT_SYMBOL_GPL(lookup_address);
 
-static pte_t *cpa_lookup_in_pgd(pgd_t *pgdp, unsigned long address,
-				enum pgtable_level *level)
-{
-	p4d_t *p4dp, p4d;
-	pud_t *pudp, pud;
-	pmd_t *pmdp, pmd;
-
-	*level = PGTABLE_LEVEL_PGD;
-	if (pgd_none(*pgdp))
-		return NULL;
-
-	*level = PGTABLE_LEVEL_P4D;
-	p4dp = p4d_offset(pgdp, address);
-	p4d = p4dp_get(p4dp);
-	if (p4d_none(p4d))
-		return NULL;
-	if (p4d_leaf(p4d) || !p4d_present(p4d))
-		return (pte_t *)p4dp;
-
-	*level = PGTABLE_LEVEL_PUD;
-	pudp = pud_offset(p4dp, address);
-	pud = pudp_get(pudp);
-	if (pud_none(pud))
-		return NULL;
-	if (pud_leaf(pud) || !pud_present(pud))
-		return (pte_t *)pudp;
-
-	*level = PGTABLE_LEVEL_PMD;
-	pmdp = pmd_offset(pudp, address);
-	pmd = pmdp_get(pmdp);
-	if (pmd_none(pmd))
-		return NULL;
-	if (pmd_leaf(pmd) || !pmd_present(pmd))
-		return (pte_t *)pmdp;
-
-	*level = PGTABLE_LEVEL_PTE;
-	return pte_offset_kernel(pmdp, address);
-}
-
-static void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 {
 	enum pgtable_level level = leaf->level;
 	pte_t *kpte = leaf->kpte;
@@ -952,24 +706,6 @@ static void arch_cpa_decode_leaf(struct cpa_leaf *leaf)
 	}
 }
 
-static pte_t *cpa_lookup(struct cpa_data *cpa, unsigned long address,
-			 struct cpa_leaf *leaf)
-{
-	pgd_t *pgd = cpa_pgd(cpa, address);
-
-	leaf->kpte = cpa_lookup_in_pgd(pgd, address, &leaf->level);
-	if (!leaf->kpte)
-		return NULL;
-	if (leaf->level == PGTABLE_LEVEL_PTE && pte_none(ptep_get(leaf->kpte)))
-		return NULL;
-
-	leaf->size = pgtable_level_size(leaf->level);
-	leaf->addr = address & pgtable_level_mask(leaf->level);
-	arch_cpa_decode_leaf(leaf);
-
-	return leaf->kpte;
-}
-
 /*
  * Lookup the PMD entry for a virtual address. Return a pointer to the entry
  * or NULL if not present.
@@ -1110,7 +846,7 @@ static pte_t cpa_pte(enum pgtable_level level, unsigned long pfn, pgprot_t prot)
 	return pfn_pte(pfn, prot);
 }
 
-static void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 {
 	enum pgtable_level level = leaf->level;
 	unsigned long lpaddr = leaf->addr;
@@ -1126,14 +862,7 @@ static void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot)
 		__set_pmd_pte(kpte, lpaddr, pte);
 }
 
-static pgprot_t cpa_req_prot(const struct cpa_data *cpa,
-			     const struct cpa_leaf *leaf)
-{
-	return __pgprot((pgprot_val(leaf->prot) & ~pgprot_val(cpa->mask_clr)) |
-			pgprot_val(cpa->mask_set));
-}
-
-static pgprot_t arch_cpa_new_prot(struct cpa_data *cpa, struct cpa_leaf *leaf)
+pgprot_t arch_cpa_new_prot(struct cpa_data *cpa, struct cpa_leaf *leaf)
 {
 	pgprot_t prot = cpa_req_prot(cpa, leaf);
 	enum pgtable_level level = leaf->level;
@@ -1158,80 +887,8 @@ static pgprot_t arch_cpa_new_prot(struct cpa_data *cpa, struct cpa_leaf *leaf)
 	return verify_rwx(cpa, old_prot, prot, addr, pfn, numpages);
 }
 
-static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
-{
-	unsigned long address = cpa_addr(cpa, cpa->curpage);
-	enum pgtable_level level = leaf->level;
-	unsigned long lpaddr = leaf->addr;
-	unsigned long old_pfn = leaf->pfn;
-	unsigned long psize = leaf->size;
-	pgprot_t old_prot = leaf->prot;
-	unsigned long numpages, pfn;
-	pgprot_t new_prot, req_prot;
-
-	if (cpa->flags & CPA_REQ_SPLIT)
-		return 1;
-
-	if (level != PGTABLE_LEVEL_PMD && level != PGTABLE_LEVEL_PUD)
-		return -EINVAL;
-
-	cpa_inc_pxd_checked(level);
-
-	/*
-	 * Calculate the number of pages, which fit into this large
-	 * page starting at address:
-	 */
-	numpages = (lpaddr + psize - address) >> PAGE_SHIFT;
-	if (numpages < cpa->numpages)
-		cpa->numpages = numpages;
-
-	req_prot = cpa_req_prot(cpa, leaf);
-
-	/*
-	 * old_pfn points to the large page base pfn. So we need to add the
-	 * offset of the virtual address:
-	 */
-	pfn = old_pfn + ((address & (psize - 1)) >> PAGE_SHIFT);
-	cpa->pfn = pfn;
-
-	numpages = psize >> PAGE_SHIFT;
-
-	/*
-	 * Optimization: If the requested pgprot is the same as the current
-	 * pgprot, then the large page can be preserved and no updates are
-	 * required independent of alignment and length of the requested
-	 * range.
-	 */
-	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
-		cpa_inc_pxd_sameprot(level);
-		return 0;
-	}
-
-	/*
-	 * If the requested range does not cover the full page, split it up
-	 */
-	if (address != lpaddr || cpa->numpages != numpages)
-		return 1;
-
-	/*
-	 * Check whether the architecture allows the requested protection for
-	 * the whole large page.
-	 */
-	new_prot = arch_cpa_new_prot(cpa, leaf);
-
-	/* If there is a conflict, split the large page. */
-	if (pgprot_val(req_prot) != pgprot_val(new_prot))
-		return 1;
-
-	/* All checks passed. Update the large page mapping. */
-	arch_cpa_modify_leaf(leaf, new_prot);
-	cpa->state |= CPA_ST_FLUSHTLB;
-	cpa_inc_pxd_preserved(level);
-	return 0;
-}
-
-static int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
-			       void *table)
+int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
+			void *table)
 {
 	unsigned long address = cpa_addr(cpa, cpa->curpage);
 	struct page *base = virt_to_page(table);
@@ -1287,58 +944,6 @@ static int arch_cpa_split_leaf(struct cpa_data *cpa, struct cpa_leaf *leaf,
 	return 0;
 }
 
-static void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf)
-{
-	if (leaf->level == PGTABLE_LEVEL_PMD)
-		return pte_alloc_one_kernel(&init_mm);
-
-	return pmd_alloc_one(&init_mm, leaf->addr);
-}
-
-static void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table)
-{
-	if (leaf->level == PGTABLE_LEVEL_PMD)
-		pte_free_kernel(&init_mm, table);
-	else
-		pmd_free(&init_mm, table);
-}
-
-static int split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
-{
-	unsigned long address = cpa_addr(cpa, cpa->curpage);
-	pte_t *kpte = leaf->kpte;
-	struct cpa_leaf tmp;
-	void *table;
-	int ret = 0;
-
-	spin_unlock(&cpa_lock);
-	table = arch_cpa_alloc_pgtable(leaf);
-	spin_lock(&cpa_lock);
-	if (!table)
-		return -ENOMEM;
-
-	/*
-	 * Check for races, another CPU might have split this page
-	 * up for us already:
-	 */
-	if (cpa_lookup(cpa, address, &tmp) != kpte)
-		goto out;
-	*leaf = tmp;
-
-	ret = arch_cpa_split_leaf(cpa, leaf, table);
-	if (ret)
-		goto out;
-
-	if (cpa_is_direct_map(address))
-		direct_map_count_split(leaf->level);
-
-	return 0;
-
-out:
-	arch_cpa_free_pgtable(leaf, table);
-	return ret;
-}
-
 static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 			     struct list_head *pgtables)
 {
@@ -1889,38 +1494,7 @@ static int populate_pgd(struct cpa_data *cpa, unsigned long addr)
 	return 0;
 }
 
-static int cpa_process_fault(struct cpa_data *cpa)
-{
-	unsigned long vaddr = cpa_addr(cpa, cpa->curpage);
-
-	/*
-	 * Ignore all non primary paths.
-	 */
-	if (cpa->state & CPA_ST_ALIAS) {
-		cpa->numpages = 1;
-		return 0;
-	}
-
-	/*
-	 * Ignore the NULL PTE for kernel identity mapping, as it is expected
-	 * to have holes.
-	 * Also set numpages to '1' indicating that we processed cpa req for
-	 * one virtual address page and its pfn. TBD: numpages can be set based
-	 * on the initial value and the level returned by cpa_lookup().
-	 */
-	if (cpa_is_direct_map(vaddr)) {
-		cpa->numpages = 1;
-		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
-		return 0;
-	}
-
-	WARN(1, "CPA: called for zero pte. "
-		"vaddr = %lx cpa->addr = %lx\n", vaddr, cpa->addr);
-
-	return -EFAULT;
-}
-
-static int arch_cpa_process_fault(struct cpa_data *cpa)
+int arch_cpa_process_fault(struct cpa_data *cpa)
 {
 	unsigned long vaddr = cpa_addr(cpa, cpa->curpage);
 
@@ -1943,79 +1517,10 @@ static int arch_cpa_process_fault(struct cpa_data *cpa)
 	return cpa_process_fault(cpa);
 }
 
-static int __change_page_attr(struct cpa_data *cpa)
-{
-	unsigned long address;
-	struct cpa_leaf leaf;
-	int do_split, ret;
-
-	address = cpa_addr(cpa, cpa->curpage);
-repeat:
-	if (!cpa_lookup(cpa, address, &leaf))
-		return arch_cpa_process_fault(cpa);
-
-	if (leaf.level == PGTABLE_LEVEL_PTE) {
-		pgprot_t new_prot;
-		unsigned long pfn = leaf.pfn;
-
-		cpa_inc_pte_install();
-		new_prot = arch_cpa_new_prot(cpa, &leaf);
-		cpa->pfn = pfn;
-		/*
-		 * Do we really change anything ?
-		 */
-		if (pgprot_val(new_prot) != pgprot_val(leaf.prot)) {
-			arch_cpa_modify_leaf(&leaf, new_prot);
-			cpa->state |= CPA_ST_FLUSHTLB;
-		}
-		cpa->numpages = 1;
-		return 0;
-	}
-
-	/*
-	 * Check, whether we can keep the large page intact
-	 * and just change the pte:
-	 */
-	do_split = should_split_large_page(cpa, &leaf);
-	/*
-	 * When the range fits into the existing large page,
-	 * return. cpa->numpages and cpa->state have been updated in
-	 * should_split_large_page():
-	 */
-	if (do_split <= 0)
-		return do_split;
-
-	/*
-	 * We have to split the large page:
-	 */
-	ret = split_large_page(cpa, &leaf);
-	if (!ret)
-		goto repeat;
-
-	return ret;
-}
-
-static int change_page_attr_noflush(struct cpa_data *cpa);
-
-static int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias)
-{
-	int ret;
-
-	alias->state &= ~CPA_ST_FLUSHTLB;
-	alias->state |= CPA_ST_ALIAS;
-	alias->curpage = 0;
-
-	ret = change_page_attr_noflush(alias);
-	if (alias->state & CPA_ST_FLUSHTLB)
-		cpa->state |= CPA_ST_FLUSHTLB | CPA_ST_FLUSH_ALL;
-
-	return ret;
-}
-
 /*
  * Check the directmap and "high kernel map" 'aliases'.
  */
-static int arch_cpa_process_alias(struct cpa_data *cpa)
+int arch_cpa_process_alias(struct cpa_data *cpa)
 {
 	struct cpa_data alias_cpa;
 	unsigned long vaddr;
@@ -2077,111 +1582,6 @@ static int arch_cpa_process_alias(struct cpa_data *cpa)
 	return 0;
 }
 
-static int change_page_attr_noflush(struct cpa_data *cpa)
-{
-	unsigned long numpages = cpa->numpages;
-	unsigned long rempages = numpages;
-	int ret = 0;
-
-	/*
-	 * No changes, easy!
-	 */
-	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)) &&
-	    !(cpa->flags & CPA_REQ_SPLIT))
-		return ret;
-
-	while (rempages) {
-		/*
-		 * Store the remaining nr of pages for the large page
-		 * preservation check.
-		 */
-		cpa->numpages = rempages;
-
-		scoped_guard(spinlock, &cpa_lock)
-			ret = __change_page_attr(cpa);
-		if (ret)
-			goto out;
-
-		if (!(cpa->state & CPA_ST_ALIAS) &&
-		    !(cpa->flags & CPA_REQ_NO_CHECK_ALIAS)) {
-			ret = arch_cpa_process_alias(cpa);
-			if (ret)
-				goto out;
-		}
-
-		/*
-		 * Adjust the number of pages with the result of the
-		 * CPA operation. Either a large page has been
-		 * preserved or a single page update happened.
-		 */
-		if (WARN_ON_ONCE(cpa->numpages > rempages || !cpa->numpages)) {
-			ret = -EINVAL;
-			goto out;
-		}
-		rempages -= cpa->numpages;
-		cpa->curpage += cpa->numpages;
-	}
-
-out:
-	/* Restore the original numpages */
-	cpa->numpages = numpages;
-	return ret;
-}
-
-static int change_page_attr(struct cpa_data *cpa)
-{
-	int ret;
-
-	/* Ensure we are PAGE_SIZE aligned */
-	if (cpa->addr & ~PAGE_MASK) {
-		cpa->addr &= PAGE_MASK;
-		/*
-		 * People should not be passing in unaligned addresses:
-		 */
-		WARN_ON_ONCE(1);
-	}
-
-	/* Must avoid aliasing mappings in the highmem code */
-	kmap_flush_unused();
-
-	vm_unmap_aliases();
-
-	ret = change_page_attr_noflush(cpa);
-
-	/*
-	 * Check whether we really changed something:
-	 */
-	if (!(cpa->state & CPA_ST_FLUSHTLB))
-		return ret;
-
-	/*
-	 * On error; flush everything to be sure.
-	 */
-	if (ret)
-		cpa->state |= CPA_ST_FLUSH_ALL;
-
-	arch_cpa_flush(cpa);
-
-	if (ret)
-		return ret;
-
-	if (!(cpa->flags & CPA_REQ_COLLAPSE))
-		return 0;
-
-	/*
-	 * Take the mmap write lock on init_mm to avoid a use-after-free if
-	 * there is a race with
-	 * - ptdump (which takes its own write lock on init_mm)
-	 * - text poking (which takes the read lock around vmalloc_to_page())
-	 */
-	scoped_guard(mmap_write_lock, &init_mm) {
-		guard(spinlock)(&cpa_lock);
-		arch_cpa_collapse(cpa);
-	}
-
-	return ret;
-}
-
 static int change_page_attr_set_clr(unsigned long addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
 				    int in_flag)
@@ -2428,23 +1828,6 @@ int clear_mce_nospec(unsigned long pfn)
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
 #endif /* CONFIG_X86_64 */
 
-enum cpa_op {
-	CPA_OP_RO,
-	CPA_OP_RW,
-	CPA_OP_X,
-	CPA_OP_NX,
-	CPA_OP_ROX,
-	CPA_OP_DIRECT_MAP_INVALID,
-	CPA_OP_DIRECT_MAP_DEFAULT,
-	CPA_OP_NR
-};
-
-struct cpa_op_prot {
-	pgprot_t	set;
-	pgprot_t	clr;
-	unsigned int	req;
-};
-
 static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
 	[CPA_OP_RO]	= { .clr = __pgprot(_PAGE_RW | _PAGE_DIRTY) },
 	[CPA_OP_RW]	= { .set = __pgprot(_PAGE_RW) },
@@ -2462,14 +1845,7 @@ static const struct cpa_op_prot cpa_ops[CPA_OP_NR] = {
 	},
 };
 
-static void cpa_init_op(struct cpa_data *cpa, const struct cpa_op_prot *prot)
-{
-	cpa->mask_set = prot->set;
-	cpa->mask_clr = prot->clr;
-	cpa->flags |= prot->req;
-}
-
-static int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 {
 	cpa_init_op(cpa, &cpa_ops[op]);
 
@@ -2481,50 +1857,6 @@ static int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op)
 	return 0;
 }
 
-static int set_memory_op(unsigned long addr, int numpages, enum cpa_op op)
-{
-	struct cpa_data cpa = {
-		.addr = addr,
-		.numpages = numpages,
-	};
-	int ret;
-
-	ret = arch_cpa_prepare(&cpa, op);
-	if (ret)
-		return ret;
-
-	if (!pgprot_val(cpa.mask_set) && !pgprot_val(cpa.mask_clr) &&
-	    !(cpa.flags & CPA_REQ_SPLIT))
-		return 0;
-
-	return change_page_attr(&cpa);
-}
-
-int set_memory_x(unsigned long addr, int numpages)
-{
-	return set_memory_op(addr, numpages, CPA_OP_X);
-}
-
-int set_memory_nx(unsigned long addr, int numpages)
-{
-	return set_memory_op(addr, numpages, CPA_OP_NX);
-}
-
-int set_memory_ro(unsigned long addr, int numpages)
-{
-	return set_memory_op(addr, numpages, CPA_OP_RO);
-}
-
-int set_memory_rox(unsigned long addr, int numpages)
-{
-	return set_memory_op(addr, numpages, CPA_OP_ROX);
-}
-
-int set_memory_rw(unsigned long addr, int numpages)
-{
-	return set_memory_op(addr, numpages, CPA_OP_RW);
-}
-
 int set_memory_np(unsigned long addr, int numpages)
 {
 	return change_page_attr_clear(addr, numpages, __pgprot(_PAGE_PRESENT));
@@ -2787,36 +2119,6 @@ int set_pages_rw(struct page *page, int numpages)
 	return set_memory_rw(addr, numpages);
 }
 
-static int set_direct_map(struct page *page, unsigned int nr, enum cpa_op op)
-{
-	struct cpa_data cpa = {
-		.addr = (unsigned long)page_address(page),
-		.numpages = nr,
-		.flags = CPA_REQ_NO_CHECK_ALIAS,
-	};
-	int ret;
-
-	ret = arch_cpa_prepare(&cpa, op);
-	if (ret)
-		return ret;
-
-	/*
-	 * set_direct_map_*_noflush() change only the direct map, not its
-	 * aliases.
-	 */
-	return change_page_attr_noflush(&cpa);
-}
-
-int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
-{
-	return set_direct_map(page, nr, CPA_OP_DIRECT_MAP_INVALID);
-}
-
-int set_direct_map_default_noflush(struct page *page, unsigned int nr)
-{
-	return set_direct_map(page, nr, CPA_OP_DIRECT_MAP_DEFAULT);
-}
-
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static int kernel_map_pte(pte_t *ptep, unsigned long addr, void *data)
 {
diff --git a/include/asm-generic/set_memory.h b/include/asm-generic/set_memory.h
index c86abf6bc7ba..7ac5c3d3d92d 100644
--- a/include/asm-generic/set_memory.h
+++ b/include/asm-generic/set_memory.h
@@ -10,4 +10,15 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
+#ifdef CONFIG_GENERIC_PAGEATTR
+int set_memory_rox(unsigned long addr, int numpages);
+#define set_memory_rox set_memory_rox
+
+#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
+struct page;
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr);
+int set_direct_map_default_noflush(struct page *page, unsigned int nr);
+#endif
+#endif
+
 #endif
diff --git a/include/linux/pageattr.h b/include/linux/pageattr.h
new file mode 100644
index 000000000000..f8b6b17e0b0b
--- /dev/null
+++ b/include/linux/pageattr.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PAGEATTR_H
+#define _LINUX_PAGEATTR_H
+
+#include <linux/mm.h>
+#include <linux/pgtable.h>
+
+struct seq_file;
+
+/*
+ * The current flushing context - we pass it instead of 5 arguments:
+ */
+struct cpa_data {
+	unsigned long	addr;
+	pgd_t		*pgd;
+	pgprot_t	mask_set;
+	pgprot_t	mask_clr;
+	unsigned long	numpages;
+	unsigned long	curpage;
+	unsigned long	pfn;
+	unsigned int	flags;
+	unsigned int	state;
+};
+
+struct cpa_leaf {
+	pte_t			*kpte;
+	enum pgtable_level	level;
+	unsigned long		addr;
+	unsigned long		size;
+	unsigned long		pfn;
+	pgprot_t		prot;
+};
+
+/* cpa_data::flags */
+#define CPA_REQ_NO_CHECK_ALIAS	0x01 /* Do not search for aliases */
+#define CPA_REQ_COLLAPSE	0x02 /* try to collapse large pages */
+#define CPA_REQ_SPLIT		0x04 /* split large pages */
+
+/* cpa_data::state */
+#define CPA_ST_FLUSHTLB		0x01 /* the TLB needs a flush */
+#define CPA_ST_FLUSH_ALL	0x02 /* flush the entire TLB */
+#define CPA_ST_ALIAS		0x04 /* the request is for an alias */
+
+#include <asm/pageattr.h>
+
+static inline pgprot_t cpa_req_prot(const struct cpa_data *cpa,
+				    const struct cpa_leaf *leaf)
+{
+	return __pgprot((pgprot_val(leaf->prot) & ~pgprot_val(cpa->mask_clr)) |
+			pgprot_val(cpa->mask_set));
+}
+
+static inline pgd_t *cpa_pgd(struct cpa_data *cpa, unsigned long address)
+{
+	if (!cpa->pgd)
+		return pgd_offset_k(address);
+
+	return cpa->pgd + pgd_index(address);
+}
+
+static inline unsigned long cpa_addr(struct cpa_data *cpa, unsigned long idx)
+{
+	return cpa->addr + idx * PAGE_SIZE;
+}
+
+int cpa_process_fault(struct cpa_data *cpa);
+int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias);
+
+int change_page_attr(struct cpa_data *cpa);
+
+int change_page_attr_noflush(struct cpa_data *cpa);
+
+#ifdef CONFIG_PROC_FS
+void direct_map_count_update(enum pgtable_level level, long pages);
+void direct_map_count_split(enum pgtable_level level);
+void direct_map_count_collapse(enum pgtable_level level);
+void cpa_report_meminfo(struct seq_file *m, unsigned long levels);
+#else
+static inline void direct_map_count_update(enum pgtable_level level,
+					   long pages) { }
+static inline void direct_map_count_split(enum pgtable_level level) { }
+static inline void direct_map_count_collapse(enum pgtable_level level) { }
+#endif
+
+void arch_cpa_decode_leaf(struct cpa_leaf *leaf);
+
+void arch_cpa_modify_leaf(struct cpa_leaf *leaf, pgprot_t prot);
+
+void arch_cpa_flush(struct cpa_data *cpa);
+
+#ifndef arch_cpa_new_prot
+static inline pgprot_t arch_cpa_new_prot(struct cpa_data *cpa,
+					 struct cpa_leaf *leaf)
+{
+	return cpa_req_prot(cpa, leaf);
+}
+#endif
+
+#ifndef arch_cpa_split_leaf
+static inline int arch_cpa_split_leaf(struct cpa_data *cpa,
+				      struct cpa_leaf *leaf, void *table)
+{
+	return -EINVAL;
+}
+#endif
+
+#ifndef cpa_is_direct_map
+static inline bool cpa_is_direct_map(unsigned long addr)
+{
+	return addr >= PAGE_OFFSET && addr < (unsigned long)high_memory;
+}
+#endif
+
+#ifndef arch_cpa_process_fault
+static inline int arch_cpa_process_fault(struct cpa_data *cpa)
+{
+	return cpa_process_fault(cpa);
+}
+#endif
+
+#ifndef arch_cpa_process_alias
+static inline int arch_cpa_process_alias(struct cpa_data *cpa)
+{
+	return 0;
+}
+#endif
+
+#ifndef arch_cpa_collapse
+static inline void arch_cpa_collapse(struct cpa_data *cpa)
+{
+}
+#endif
+
+enum cpa_op {
+	CPA_OP_RO,
+	CPA_OP_RW,
+	CPA_OP_X,
+	CPA_OP_NX,
+	CPA_OP_ROX,
+	CPA_OP_DIRECT_MAP_INVALID,
+	CPA_OP_DIRECT_MAP_DEFAULT,
+	CPA_OP_NR
+};
+
+struct cpa_op_prot {
+	pgprot_t	set;
+	pgprot_t	clr;
+	unsigned int	req;
+};
+
+static inline void cpa_init_op(struct cpa_data *cpa,
+			       const struct cpa_op_prot *prot)
+{
+	cpa->mask_set = prot->set;
+	cpa->mask_clr = prot->clr;
+	cpa->flags |= prot->req;
+}
+
+int arch_cpa_prepare(struct cpa_data *cpa, enum cpa_op op);
+
+#endif /* _LINUX_PAGEATTR_H */
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 2628ccda076a..4d2ab343abf9 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -139,7 +139,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		ZSWPOUT,
 		ZSWPWB,
 #endif
-#ifdef CONFIG_X86
+#ifdef CONFIG_GENERIC_PAGEATTR
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
 		DIRECT_MAP_LEVEL2_COLLAPSE,
diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..3948e64dc590 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1138,6 +1138,9 @@ config MEM_SOFT_DIRTY
 config GENERIC_EARLY_IOREMAP
 	bool
 
+config GENERIC_PAGEATTR
+	bool
+
 config STACK_MAX_DEFAULT_SIZE_MB
 	int "Default maximum user stack size for 32-bit processes (MB)"
 	default 100
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 9ae75229c76d..556a2e47cd9e 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -180,6 +180,14 @@ config DEBUG_RODATA_TEST
 	help
 	  This option enables a testcase for the setting rodata read-only.
 
+config CPA_STATISTICS
+	bool "Enable statistic for Change Page Attribute"
+	depends on GENERIC_PAGEATTR && DEBUG_FS
+	help
+	  Expose statistics about the Change Page Attribute mechanism, which
+	  helps to determine the effectiveness of preserving large and huge
+	  page mappings when mapping protections are changed.
+
 config PTDUMP_DEBUGFS
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
diff --git a/mm/Makefile b/mm/Makefile
index 2a3ec53d62ee..0de865d02c70 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP) += ptdump.o
+obj-$(CONFIG_GENERIC_PAGEATTR) += pageattr.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
diff --git a/mm/pageattr.c b/mm/pageattr.c
new file mode 100644
index 000000000000..6fb89632b679
--- /dev/null
+++ b/mm/pageattr.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2002 Andi Kleen, SuSE Labs.
+ * Thanks to Ben LaHaise for precious feedback.
+ */
+#include <linux/mm.h>
+#include <linux/pageattr.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/cleanup.h>
+#include <linux/vmstat.h>
+#include <linux/pgalloc.h>
+#include <linux/highmem.h>
+#include <linux/vmalloc.h>
+#include <linux/set_memory.h>
+
+/*
+ * Serialize CPA using cpa_lock so that:
+ * - concurrent requests don't split or change the same large mapping at the
+ *   same time
+ * - collapses of large mappings don't free page tables under a CPA lookup
+ */
+static DEFINE_SPINLOCK(cpa_lock);
+
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_CPA_STATISTICS)
+static const char *cpa_size_str(enum pgtable_level level, char *buf, size_t len)
+{
+	unsigned long size = pgtable_level_size(level);
+
+	if (size >= SZ_1G)
+		snprintf(buf, len, "%luG", size >> 30);
+	else if (size >= SZ_1M)
+		snprintf(buf, len, "%luM", size >> 20);
+	else
+		snprintf(buf, len, "%luk", size >> 10);
+
+	return buf;
+}
+#endif
+
+#ifdef CONFIG_PROC_FS
+static atomic_long_t cpa_direct_map_pages[PGTABLE_LEVEL_NUM];
+
+void direct_map_count_update(enum pgtable_level level, long pages)
+{
+	atomic_long_add(pages, &cpa_direct_map_pages[level]);
+}
+
+void direct_map_count_split(enum pgtable_level level)
+{
+	if (atomic_long_dec_if_positive(&cpa_direct_map_pages[level]) < 0)
+		return;
+
+	if (system_state == SYSTEM_RUNNING) {
+		if (level == PGTABLE_LEVEL_PMD)
+			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
+		else if (level == PGTABLE_LEVEL_PUD)
+			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
+	}
+	atomic_long_add(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
+}
+
+void direct_map_count_collapse(enum pgtable_level level)
+{
+	atomic_long_inc(&cpa_direct_map_pages[level]);
+	if (system_state == SYSTEM_RUNNING) {
+		if (level == PGTABLE_LEVEL_PMD)
+			count_vm_event(DIRECT_MAP_LEVEL2_COLLAPSE);
+		else if (level == PGTABLE_LEVEL_PUD)
+			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
+	}
+	atomic_long_sub(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
+}
+
+void cpa_report_meminfo(struct seq_file *m, unsigned long levels)
+{
+	enum pgtable_level level;
+	char label[32], sz[20];
+
+	for (level = PGTABLE_LEVEL_PTE; level <= PGTABLE_LEVEL_PGD; level++) {
+		if (!(levels & BIT(level)))
+			continue;
+
+		snprintf(label, sizeof(label), "DirectMap%s:",
+			 cpa_size_str(level, sz, sizeof(sz)));
+		seq_printf(m, "%-16s%8lu kB\n", label,
+			   atomic_long_read(&cpa_direct_map_pages[level]) *
+			   (pgtable_level_size(level) >> 10));
+	}
+}
+#endif
+
+#ifdef CONFIG_CPA_STATISTICS
+
+static unsigned long cpa_checked[PGTABLE_LEVEL_NUM];
+static unsigned long cpa_sameprot[PGTABLE_LEVEL_NUM];
+static unsigned long cpa_preserved[PGTABLE_LEVEL_NUM];
+
+static inline void cpa_inc_pxd_checked(enum pgtable_level level)
+{
+	cpa_checked[level]++;
+}
+
+static inline void cpa_inc_pte_install(void)
+{
+	cpa_checked[PGTABLE_LEVEL_PTE]++;
+}
+
+static inline void cpa_inc_pxd_sameprot(enum pgtable_level level)
+{
+	cpa_sameprot[level]++;
+}
+
+static inline void cpa_inc_pxd_preserved(enum pgtable_level level)
+{
+	cpa_preserved[level]++;
+}
+
+static void cpastats_show_level(struct seq_file *m, enum pgtable_level level)
+{
+	char sz[20];
+
+	cpa_size_str(level, sz, sizeof(sz));
+	seq_printf(m, "%s pages checked:     %16lu\n", sz, cpa_checked[level]);
+	seq_printf(m, "%s pages sameprot:    %16lu\n", sz, cpa_sameprot[level]);
+	seq_printf(m, "%s pages preserved:   %16lu\n", sz,
+		   cpa_preserved[level]);
+}
+
+static int cpastats_show(struct seq_file *m, void *p)
+{
+	char sz[20];
+
+	cpastats_show_level(m, PGTABLE_LEVEL_PUD);
+	cpastats_show_level(m, PGTABLE_LEVEL_PMD);
+	seq_printf(m, "%s pages set-checked: %16lu\n",
+		   cpa_size_str(PGTABLE_LEVEL_PTE, sz, sizeof(sz)),
+		   cpa_checked[PGTABLE_LEVEL_PTE]);
+	return 0;
+}
+
+static int cpastats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, cpastats_show, NULL);
+}
+
+static const struct file_operations cpastats_fops = {
+	.open		= cpastats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init cpa_stats_init(void)
+{
+	debugfs_create_file("cpa_stats", 0400, NULL, NULL, &cpastats_fops);
+	return 0;
+}
+late_initcall(cpa_stats_init);
+#else
+static inline void cpa_inc_pxd_checked(enum pgtable_level level) { }
+static inline void cpa_inc_pte_install(void) { }
+static inline void cpa_inc_pxd_sameprot(enum pgtable_level level) { }
+static inline void cpa_inc_pxd_preserved(enum pgtable_level level) { }
+#endif
+
+static pte_t *cpa_lookup_in_pgd(pgd_t *pgdp, unsigned long address,
+				enum pgtable_level *level)
+{
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
+
+	*level = PGTABLE_LEVEL_PGD;
+	if (pgd_none(*pgdp))
+		return NULL;
+
+	*level = PGTABLE_LEVEL_P4D;
+	p4dp = p4d_offset(pgdp, address);
+	p4d = p4dp_get(p4dp);
+	if (p4d_none(p4d))
+		return NULL;
+	if (p4d_leaf(p4d) || !p4d_present(p4d))
+		return (pte_t *)p4dp;
+
+	*level = PGTABLE_LEVEL_PUD;
+	pudp = pud_offset(p4dp, address);
+	pud = pudp_get(pudp);
+	if (pud_none(pud))
+		return NULL;
+	if (pud_leaf(pud) || !pud_present(pud))
+		return (pte_t *)pudp;
+
+	*level = PGTABLE_LEVEL_PMD;
+	pmdp = pmd_offset(pudp, address);
+	pmd = pmdp_get(pmdp);
+	if (pmd_none(pmd))
+		return NULL;
+	if (pmd_leaf(pmd) || !pmd_present(pmd))
+		return (pte_t *)pmdp;
+
+	*level = PGTABLE_LEVEL_PTE;
+	return pte_offset_kernel(pmdp, address);
+}
+
+static pte_t *cpa_lookup(struct cpa_data *cpa, unsigned long address,
+			 struct cpa_leaf *leaf)
+{
+	pgd_t *pgd = cpa_pgd(cpa, address);
+
+	leaf->kpte = cpa_lookup_in_pgd(pgd, address, &leaf->level);
+	if (!leaf->kpte)
+		return NULL;
+	if (leaf->level == PGTABLE_LEVEL_PTE && pte_none(ptep_get(leaf->kpte)))
+		return NULL;
+
+	leaf->size = pgtable_level_size(leaf->level);
+	leaf->addr = address & pgtable_level_mask(leaf->level);
+	arch_cpa_decode_leaf(leaf);
+
+	return leaf->kpte;
+}
+
+static void *arch_cpa_alloc_pgtable(struct cpa_leaf *leaf)
+{
+	if (leaf->level == PGTABLE_LEVEL_PMD)
+		return pte_alloc_one_kernel(&init_mm);
+
+	return pmd_alloc_one(&init_mm, leaf->addr);
+}
+
+static void arch_cpa_free_pgtable(struct cpa_leaf *leaf, void *table)
+{
+	if (leaf->level == PGTABLE_LEVEL_PMD)
+		pte_free_kernel(&init_mm, table);
+	else
+		pmd_free(&init_mm, table);
+}
+
+static int should_split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
+{
+	unsigned long address = cpa_addr(cpa, cpa->curpage);
+	enum pgtable_level level = leaf->level;
+	unsigned long lpaddr = leaf->addr;
+	unsigned long old_pfn = leaf->pfn;
+	unsigned long psize = leaf->size;
+	pgprot_t old_prot = leaf->prot;
+	unsigned long numpages, pfn;
+	pgprot_t new_prot, req_prot;
+
+	if (cpa->flags & CPA_REQ_SPLIT)
+		return 1;
+
+	if (level != PGTABLE_LEVEL_PMD && level != PGTABLE_LEVEL_PUD)
+		return -EINVAL;
+
+	cpa_inc_pxd_checked(level);
+
+	/*
+	 * Calculate the number of pages, which fit into this large
+	 * page starting at address:
+	 */
+	numpages = (lpaddr + psize - address) >> PAGE_SHIFT;
+	if (numpages < cpa->numpages)
+		cpa->numpages = numpages;
+
+	req_prot = cpa_req_prot(cpa, leaf);
+
+	/*
+	 * old_pfn points to the large page base pfn. So we need to add the
+	 * offset of the virtual address:
+	 */
+	pfn = old_pfn + ((address & (psize - 1)) >> PAGE_SHIFT);
+	cpa->pfn = pfn;
+
+	numpages = psize >> PAGE_SHIFT;
+
+	/*
+	 * Optimization: If the requested pgprot is the same as the current
+	 * pgprot, then the large page can be preserved and no updates are
+	 * required independent of alignment and length of the requested
+	 * range.
+	 */
+	if (pgprot_val(req_prot) == pgprot_val(old_prot)) {
+		cpa_inc_pxd_sameprot(level);
+		return 0;
+	}
+
+	/*
+	 * If the requested range does not cover the full page, split it up
+	 */
+	if (address != lpaddr || cpa->numpages != numpages)
+		return 1;
+
+	/*
+	 * Check whether the architecture allows the requested protection for
+	 * the whole large page.
+	 */
+	new_prot = arch_cpa_new_prot(cpa, leaf);
+
+	/* If there is a conflict, split the large page. */
+	if (pgprot_val(req_prot) != pgprot_val(new_prot))
+		return 1;
+
+	/* All checks passed. Update the large page mapping. */
+	arch_cpa_modify_leaf(leaf, new_prot);
+	cpa->state |= CPA_ST_FLUSHTLB;
+	cpa_inc_pxd_preserved(level);
+	return 0;
+}
+
+static int split_large_page(struct cpa_data *cpa, struct cpa_leaf *leaf)
+{
+	unsigned long address = cpa_addr(cpa, cpa->curpage);
+	pte_t *kpte = leaf->kpte;
+	struct cpa_leaf tmp;
+	void *table;
+	int ret = 0;
+
+	spin_unlock(&cpa_lock);
+	table = arch_cpa_alloc_pgtable(leaf);
+	spin_lock(&cpa_lock);
+	if (!table)
+		return -ENOMEM;
+
+	/*
+	 * Check for races, another CPU might have split this page
+	 * up for us already:
+	 */
+	if (cpa_lookup(cpa, address, &tmp) != kpte)
+		goto out;
+	*leaf = tmp;
+
+	ret = arch_cpa_split_leaf(cpa, leaf, table);
+	if (ret)
+		goto out;
+
+	if (cpa_is_direct_map(address))
+		direct_map_count_split(leaf->level);
+
+	return 0;
+
+out:
+	arch_cpa_free_pgtable(leaf, table);
+	return ret;
+}
+
+int cpa_process_fault(struct cpa_data *cpa)
+{
+	unsigned long vaddr = cpa_addr(cpa, cpa->curpage);
+
+	/*
+	 * Ignore all non primary paths.
+	 */
+	if (cpa->state & CPA_ST_ALIAS) {
+		cpa->numpages = 1;
+		return 0;
+	}
+
+	/*
+	 * Ignore the NULL PTE for kernel identity mapping, as it is expected
+	 * to have holes.
+	 * Also set numpages to '1' indicating that we processed cpa req for
+	 * one virtual address page and its pfn. TBD: numpages can be set based
+	 * on the initial value and the level returned by cpa_lookup().
+	 */
+	if (cpa_is_direct_map(vaddr)) {
+		cpa->numpages = 1;
+		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
+		return 0;
+	}
+
+	WARN(1, "CPA: called for zero pte. "
+		"vaddr = %lx cpa->addr = %lx\n", vaddr, cpa->addr);
+
+	return -EFAULT;
+}
+
+static int __change_page_attr(struct cpa_data *cpa)
+{
+	unsigned long address;
+	struct cpa_leaf leaf;
+	int do_split, ret;
+
+	address = cpa_addr(cpa, cpa->curpage);
+repeat:
+	if (!cpa_lookup(cpa, address, &leaf))
+		return arch_cpa_process_fault(cpa);
+
+	if (leaf.level == PGTABLE_LEVEL_PTE) {
+		pgprot_t new_prot;
+		unsigned long pfn = leaf.pfn;
+
+		cpa_inc_pte_install();
+		new_prot = arch_cpa_new_prot(cpa, &leaf);
+		cpa->pfn = pfn;
+		/*
+		 * Do we really change anything ?
+		 */
+		if (pgprot_val(new_prot) != pgprot_val(leaf.prot)) {
+			arch_cpa_modify_leaf(&leaf, new_prot);
+			cpa->state |= CPA_ST_FLUSHTLB;
+		}
+		cpa->numpages = 1;
+		return 0;
+	}
+
+	/*
+	 * Check, whether we can keep the large page intact
+	 * and just change the pte:
+	 */
+	do_split = should_split_large_page(cpa, &leaf);
+	/*
+	 * When the range fits into the existing large page,
+	 * return. cpa->numpages and cpa->state have been updated in
+	 * should_split_large_page():
+	 */
+	if (do_split <= 0)
+		return do_split;
+
+	/*
+	 * We have to split the large page:
+	 */
+	ret = split_large_page(cpa, &leaf);
+	if (!ret)
+		goto repeat;
+
+	return ret;
+}
+
+int change_page_attr_noflush(struct cpa_data *cpa)
+{
+	unsigned long numpages = cpa->numpages;
+	unsigned long rempages = numpages;
+	int ret = 0;
+
+	/*
+	 * No changes, easy!
+	 */
+	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)) &&
+	    !(cpa->flags & CPA_REQ_SPLIT))
+		return ret;
+
+	while (rempages) {
+		/*
+		 * Store the remaining nr of pages for the large page
+		 * preservation check.
+		 */
+		cpa->numpages = rempages;
+
+		scoped_guard(spinlock, &cpa_lock)
+			ret = __change_page_attr(cpa);
+		if (ret)
+			goto out;
+
+		if (!(cpa->state & CPA_ST_ALIAS) &&
+		    !(cpa->flags & CPA_REQ_NO_CHECK_ALIAS)) {
+			ret = arch_cpa_process_alias(cpa);
+			if (ret)
+				goto out;
+		}
+
+		/*
+		 * Adjust the number of pages with the result of the
+		 * CPA operation. Either a large page has been
+		 * preserved or a single page update happened.
+		 */
+		if (WARN_ON_ONCE(cpa->numpages > rempages || !cpa->numpages)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		rempages -= cpa->numpages;
+		cpa->curpage += cpa->numpages;
+	}
+
+out:
+	/* Restore the original numpages */
+	cpa->numpages = numpages;
+	return ret;
+}
+
+int cpa_change_alias(struct cpa_data *cpa, struct cpa_data *alias)
+{
+	int ret;
+
+	alias->state &= ~CPA_ST_FLUSHTLB;
+	alias->state |= CPA_ST_ALIAS;
+	alias->curpage = 0;
+
+	ret = change_page_attr_noflush(alias);
+	if (alias->state & CPA_ST_FLUSHTLB)
+		cpa->state |= CPA_ST_FLUSHTLB | CPA_ST_FLUSH_ALL;
+
+	return ret;
+}
+
+int change_page_attr(struct cpa_data *cpa)
+{
+	int ret;
+
+	/* Ensure we are PAGE_SIZE aligned */
+	if (cpa->addr & ~PAGE_MASK) {
+		cpa->addr &= PAGE_MASK;
+		/*
+		 * People should not be passing in unaligned addresses:
+		 */
+		WARN_ON_ONCE(1);
+	}
+
+	/* Must avoid aliasing mappings in the highmem code */
+	kmap_flush_unused();
+
+	vm_unmap_aliases();
+
+	ret = change_page_attr_noflush(cpa);
+
+	/*
+	 * Check whether we really changed something:
+	 */
+	if (!(cpa->state & CPA_ST_FLUSHTLB))
+		return ret;
+
+	/*
+	 * On error; flush everything to be sure.
+	 */
+	if (ret)
+		cpa->state |= CPA_ST_FLUSH_ALL;
+
+	arch_cpa_flush(cpa);
+
+	if (ret)
+		return ret;
+
+	if (!(cpa->flags & CPA_REQ_COLLAPSE))
+		return 0;
+
+	/*
+	 * Take the mmap write lock on init_mm to avoid a use-after-free if
+	 * there is a race with
+	 * - ptdump (which takes its own write lock on init_mm)
+	 * - text poking (which takes the read lock around vmalloc_to_page())
+	 */
+	scoped_guard(mmap_write_lock, &init_mm) {
+		guard(spinlock)(&cpa_lock);
+		arch_cpa_collapse(cpa);
+	}
+
+	return ret;
+}
+
+static int set_memory_op(unsigned long addr, int numpages, enum cpa_op op)
+{
+	struct cpa_data cpa = {
+		.addr = addr,
+		.numpages = numpages,
+	};
+	int ret;
+
+	ret = arch_cpa_prepare(&cpa, op);
+	if (ret)
+		return ret;
+
+	if (!pgprot_val(cpa.mask_set) && !pgprot_val(cpa.mask_clr) &&
+	    !(cpa.flags & CPA_REQ_SPLIT))
+		return 0;
+
+	return change_page_attr(&cpa);
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_X);
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_NX);
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_RO);
+}
+
+int set_memory_rox(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_ROX);
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return set_memory_op(addr, numpages, CPA_OP_RW);
+}
+
+#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
+static int set_direct_map(struct page *page, unsigned int nr, enum cpa_op op)
+{
+	struct cpa_data cpa = {
+		.addr = (unsigned long)page_address(page),
+		.numpages = nr,
+		.flags = CPA_REQ_NO_CHECK_ALIAS,
+	};
+	int ret;
+
+	ret = arch_cpa_prepare(&cpa, op);
+	if (ret)
+		return ret;
+
+	/*
+	 * set_direct_map_*_noflush() change only the direct map, not its
+	 * aliases.
+	 */
+	return change_page_attr_noflush(&cpa);
+}
+
+int set_direct_map_invalid_noflush(struct page *page, unsigned int nr)
+{
+	return set_direct_map(page, nr, CPA_OP_DIRECT_MAP_INVALID);
+}
+
+int set_direct_map_default_noflush(struct page *page, unsigned int nr)
+{
+	return set_direct_map(page, nr, CPA_OP_DIRECT_MAP_DEFAULT);
+}
+#endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c6beac6be2bc..330d443597e4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1467,7 +1467,7 @@ const char * const vmstat_text[] = {
 	[I(ZSWPOUT)]				= "zswpout",
 	[I(ZSWPWB)]				= "zswpwb",
 #endif
-#ifdef CONFIG_X86
+#ifdef CONFIG_GENERIC_PAGEATTR
 	[I(DIRECT_MAP_LEVEL2_SPLIT)]		= "direct_map_level2_splits",
 	[I(DIRECT_MAP_LEVEL3_SPLIT)]		= "direct_map_level3_splits",
 	[I(DIRECT_MAP_LEVEL2_COLLAPSE)]		= "direct_map_level2_collapses",

-- 
2.53.0

