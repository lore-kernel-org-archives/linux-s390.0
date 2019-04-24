Return-Path: <SRS0=qZKM=S2=kvack.org=owner-linux-mm@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/7] mm/memory_hotplug: arch_remove_memory() and __remove_pages() with CONFIG_MEMORY_HOTPLUG
Date: Wed, 24 Apr 2019 12:25:07 +0200
Message-Id: <20190424102511.29318-4-david@redhat.com>
In-Reply-To: <20190424102511.29318-1-david@redhat.com>
References: <20190424102511.29318-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Nicholas Piggin <npiggin@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>, Rob Herring <robh@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Andrew Banman <andrew.banman@hpe.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richardw.yang@linux.intel.com>, Arun KS <arunks@codeaurora.org>, Qian Cai <cai@lca.pw>, Mathieu Malaterre <malat@debian.org>, Baoquan He <bhe@redhat.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-s390.vger.kernel.org>

Let's prepare for better error handling while adding memory by allowing
to use arch_remove_memory() and __remove_pages() even if
CONFIG_MEMORY_HOTREMOVE is not set. CONFIG_MEMORY_HOTREMOVE effectively
covers
- Offlining of system ram (memory block devices) - offline_pages()
- Unplug of system ram - remove_memory()
- Unplug/remap of device memory - devm_memremap()

This allows e.g. for handling like

arch_add_memory()
rc = do_something();
if (rc) {
	arch_remove_memory();
}

Whereby do_something() will for example be memory block device creation
after it has been factored out.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Cc: Andrew Banman <andrew.banman@hpe.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/ia64/mm/init.c            | 2 --
 arch/powerpc/mm/mem.c          | 2 --
 arch/s390/mm/init.c            | 2 --
 arch/sh/mm/init.c              | 2 --
 arch/x86/mm/init_32.c          | 2 --
 arch/x86/mm/init_64.c          | 2 --
 drivers/base/memory.c          | 2 --
 include/linux/memory.h         | 2 --
 include/linux/memory_hotplug.h | 2 --
 mm/memory_hotplug.c            | 2 --
 mm/sparse.c                    | 6 ------
 11 files changed, 26 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index d28e29103bdb..aae75fd7b810 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -681,7 +681,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return ret;
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
 			struct vmem_altmap *altmap)
 {
@@ -693,4 +692,3 @@ void arch_remove_memory(int nid, u64 start, u64 size,
 	__remove_pages(zone, start_pfn, nr_pages, altmap);
 }
 #endif
-#endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c14fc0bd422d..28fea4c56cd4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -131,7 +131,6 @@ int __ref arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altm
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 int __ref arch_remove_memory(int nid, u64 start, u64 size,
 			     struct vmem_altmap *altmap)
 {
@@ -164,7 +163,6 @@ int __ref arch_remove_memory(int nid, u64 start, u64 size,
 	resize_hpt_for_hotplug(memblock_phys_mem_size());
 }
 #endif
-#endif /* CONFIG_MEMORY_HOTPLUG */
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
 void __init mem_topology_setup(void)
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 2636d62df04e..5874cfb392da 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -233,7 +233,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return rc;
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
 			struct vmem_altmap *altmap)
 {
@@ -245,5 +244,4 @@ void arch_remove_memory(int nid, u64 start, u64 size,
 	zone = page_zone(pfn_to_page(start_pfn));
 	__remove_pages(zone, start_pfn, nr_pages, altmap);
 }
-#endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 5aeb4d7099a1..59c5fe511f25 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -428,7 +428,6 @@ int memory_add_physaddr_to_nid(u64 addr)
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
 			struct vmem_altmap *altmap)
 {
@@ -439,5 +438,4 @@ void arch_remove_memory(int nid, u64 start, u64 size,
 	zone = page_zone(pfn_to_page(start_pfn));
 	__remove_pages(zone, start_pfn, nr_pages, altmap);
 }
-#endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 075e568098f2..8d4bf2d97d50 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -859,7 +859,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 void arch_remove_memory(int nid, u64 start, u64 size,
 			struct vmem_altmap *altmap)
 {
@@ -871,7 +870,6 @@ void arch_remove_memory(int nid, u64 start, u64 size,
 	__remove_pages(zone, start_pfn, nr_pages, altmap);
 }
 #endif
-#endif
 
 int kernel_set_to_readonly __read_mostly;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 20d14254b686..f1b55ddea23f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1131,7 +1131,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 	remove_pagetable(start, end, false, altmap);
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 static void __meminit
 kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 {
@@ -1156,7 +1155,6 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 	__remove_pages(zone, start_pfn, nr_pages, altmap);
 	kernel_physical_mapping_remove(start, start + size);
 }
-#endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 static struct kcore_list kcore_vsyscall;
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f180427e48f4..6e0cb4fda179 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -728,7 +728,6 @@ int hotplug_memory_register(int nid, struct mem_section *section)
 	return ret;
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 static void
 unregister_memory(struct memory_block *memory)
 {
@@ -767,7 +766,6 @@ void unregister_memory_section(struct mem_section *section)
 out_unlock:
 	mutex_unlock(&mem_sysfs_mutex);
 }
-#endif /* CONFIG_MEMORY_HOTREMOVE */
 
 /* return true if the memory block is offlined, otherwise, return false */
 bool is_memblock_offlined(struct memory_block *mem)
diff --git a/include/linux/memory.h b/include/linux/memory.h
index e1dc1bb2b787..474c7c60c8f2 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -112,9 +112,7 @@ extern void unregister_memory_notifier(struct notifier_block *nb);
 extern int register_memory_isolate_notifier(struct notifier_block *nb);
 extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
 int hotplug_memory_register(int nid, struct mem_section *section);
-#ifdef CONFIG_MEMORY_HOTREMOVE
 extern void unregister_memory_section(struct mem_section *);
-#endif
 extern int memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ae892eef8b82..2d4de313926d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -123,12 +123,10 @@ static inline bool movable_node_is_enabled(void)
 	return movable_node_enabled;
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 extern void arch_remove_memory(int nid, u64 start, u64 size,
 			       struct vmem_altmap *altmap);
 extern void __remove_pages(struct zone *zone, unsigned long start_pfn,
 			   unsigned long nr_pages, struct vmem_altmap *altmap);
-#endif /* CONFIG_MEMORY_HOTREMOVE */
 
 /*
  * Do we want sysfs memblock files created. This will allow userspace to online
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 202febe88b58..7b5439839d67 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -317,7 +317,6 @@ int __ref __add_pages(int nid, unsigned long phys_start_pfn,
 	return err;
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
 static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 				     unsigned long start_pfn,
@@ -581,7 +580,6 @@ void __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 
 	set_zone_contiguous(zone);
 }
-#endif /* CONFIG_MEMORY_HOTREMOVE */
 
 int set_online_page_callback(online_page_callback_t callback)
 {
diff --git a/mm/sparse.c b/mm/sparse.c
index fd13166949b5..d1d5e05f5b8d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -604,7 +604,6 @@ static void __kfree_section_memmap(struct page *memmap,
 
 	vmemmap_free(start, end, altmap);
 }
-#ifdef CONFIG_MEMORY_HOTREMOVE
 static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
@@ -612,7 +611,6 @@ static void free_map_bootmem(struct page *memmap)
 
 	vmemmap_free(start, end, NULL);
 }
-#endif /* CONFIG_MEMORY_HOTREMOVE */
 #else
 static struct page *__kmalloc_section_memmap(void)
 {
@@ -651,7 +649,6 @@ static void __kfree_section_memmap(struct page *memmap,
 			   get_order(sizeof(struct page) * PAGES_PER_SECTION));
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long maps_section_nr, removing_section_nr, i;
@@ -681,7 +678,6 @@ static void free_map_bootmem(struct page *memmap)
 			put_page_bootmem(page);
 	}
 }
-#endif /* CONFIG_MEMORY_HOTREMOVE */
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
 /**
@@ -746,7 +742,6 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
 	return ret;
 }
 
-#ifdef CONFIG_MEMORY_HOTREMOVE
 #ifdef CONFIG_MEMORY_FAILURE
 static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
 {
@@ -823,5 +818,4 @@ void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
 			PAGES_PER_SECTION - map_offset);
 	free_section_usemap(memmap, usemap, altmap);
 }
-#endif /* CONFIG_MEMORY_HOTREMOVE */
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.20.1
