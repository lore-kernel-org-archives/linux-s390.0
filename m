Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 5/6] arch: simplify several early memory allocations
Date: Mon, 31 Dec 2018 11:29:25 +0200
In-Reply-To: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
References: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
Message-Id: <1546248566-14910-6-git-send-email-rppt@linux.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arm-kernel/>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

There are several early memory allocations in arch/ code that use
memblock_phys_alloc() to allocate memory, convert the returned physical
address to the virtual address and then set the allocated memory to zero.

Exactly the same behaviour can be achieved simply by calling
memblock_alloc(): it allocates the memory in the same way as
memblock_phys_alloc(), then it performs the phys_to_virt() conversion and
clears the allocated memory.

Replace the longer sequence with a simpler call to memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c                     |  4 +---
 arch/c6x/mm/dma-coherent.c            |  9 ++-------
 arch/nds32/mm/init.c                  | 12 ++++--------
 arch/powerpc/kernel/setup-common.c    |  4 ++--
 arch/powerpc/mm/ppc_mmu_32.c          |  3 +--
 arch/powerpc/platforms/powernv/opal.c |  3 +--
 arch/s390/numa/numa.c                 |  6 +-----
 arch/sparc/kernel/prom_64.c           |  7 ++-----
 arch/sparc/mm/init_64.c               |  9 +++------
 arch/unicore32/mm/mmu.c               |  4 +---
 10 files changed, 18 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f5cc1cc..0a04c9a5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -721,9 +721,7 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
 {
-	void *ptr = __va(memblock_phys_alloc(sz, align));
-	memset(ptr, 0, sz);
-	return ptr;
+	return memblock_alloc(sz, align);
 }
 
 static void __init *early_alloc(unsigned long sz)
diff --git a/arch/c6x/mm/dma-coherent.c b/arch/c6x/mm/dma-coherent.c
index 75b7957..0be2898 100644
--- a/arch/c6x/mm/dma-coherent.c
+++ b/arch/c6x/mm/dma-coherent.c
@@ -121,8 +121,6 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
  */
 void __init coherent_mem_init(phys_addr_t start, u32 size)
 {
-	phys_addr_t bitmap_phys;
-
 	if (!size)
 		return;
 
@@ -138,11 +136,8 @@ void __init coherent_mem_init(phys_addr_t start, u32 size)
 	if (dma_size & (PAGE_SIZE - 1))
 		++dma_pages;
 
-	bitmap_phys = memblock_phys_alloc(BITS_TO_LONGS(dma_pages) * sizeof(long),
-					  sizeof(long));
-
-	dma_bitmap = phys_to_virt(bitmap_phys);
-	memset(dma_bitmap, 0, dma_pages * PAGE_SIZE);
+	dma_bitmap = memblock_alloc(BITS_TO_LONGS(dma_pages) * sizeof(long),
+				    sizeof(long));
 }
 
 static void c6x_dma_sync(struct device *dev, phys_addr_t paddr, size_t size,
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index 253f79f..d1e521c 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -78,8 +78,7 @@ static void __init map_ram(void)
 		}
 
 		/* Alloc one page for holding PTE's... */
-		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-		memset(pte, 0, PAGE_SIZE);
+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		set_pmd(pme, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
 
 		/* Fill the newly allocated page with PTE'S */
@@ -111,8 +110,7 @@ static void __init fixedrange_init(void)
 	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pud = pud_offset(pgd, vaddr);
 	pmd = pmd_offset(pud, vaddr);
-	fixmap_pmd_p = (pmd_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	memset(fixmap_pmd_p, 0, PAGE_SIZE);
+	fixmap_pmd_p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	set_pmd(pmd, __pmd(__pa(fixmap_pmd_p) + _PAGE_KERNEL_TABLE));
 
 #ifdef CONFIG_HIGHMEM
@@ -124,8 +122,7 @@ static void __init fixedrange_init(void)
 	pgd = swapper_pg_dir + pgd_index(vaddr);
 	pud = pud_offset(pgd, vaddr);
 	pmd = pmd_offset(pud, vaddr);
-	pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	memset(pte, 0, PAGE_SIZE);
+	pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	set_pmd(pmd, __pmd(__pa(pte) + _PAGE_KERNEL_TABLE));
 	pkmap_page_table = pte;
 #endif /* CONFIG_HIGHMEM */
@@ -150,8 +147,7 @@ void __init paging_init(void)
 	fixedrange_init();
 
 	/* allocate space for empty_zero_page */
-	zero_page = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
-	memset(zero_page, 0, PAGE_SIZE);
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 	zone_sizes_init();
 
 	empty_zero_page = virt_to_page(zero_page);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index ca00fbb..82be48c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -459,8 +459,8 @@ void __init smp_setup_cpu_maps(void)
 
 	DBG("smp_setup_cpu_maps()\n");
 
-	cpu_to_phys_id = __va(memblock_phys_alloc(nr_cpu_ids * sizeof(u32), __alignof__(u32)));
-	memset(cpu_to_phys_id, 0, nr_cpu_ids * sizeof(u32));
+	cpu_to_phys_id = memblock_alloc(nr_cpu_ids * sizeof(u32),
+					__alignof__(u32));
 
 	for_each_node_by_type(dn, "cpu") {
 		const __be32 *intserv;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 3f41932..36a664f 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -211,8 +211,7 @@ void __init MMU_init_hw(void)
 	 * Find some memory for the hash table.
 	 */
 	if ( ppc_md.progress ) ppc_md.progress("hash:find piece", 0x322);
-	Hash = __va(memblock_phys_alloc(Hash_size, Hash_size));
-	memset(Hash, 0, Hash_size);
+	Hash = memblock_alloc(Hash_size, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
 	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 79586f1..8e157f9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -171,8 +171,7 @@ int __init early_init_dt_scan_recoverable_ranges(unsigned long node,
 	/*
 	 * Allocate a buffer to hold the MC recoverable ranges.
 	 */
-	mc_recoverable_range =__va(memblock_phys_alloc(size, __alignof__(u64)));
-	memset(mc_recoverable_range, 0, size);
+	mc_recoverable_range = memblock_alloc(size, __alignof__(u64));
 
 	for (i = 0; i < mc_recoverable_range_len; i++) {
 		mc_recoverable_range[i].start_addr =
diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index d31bde0..2281a88 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -62,11 +62,7 @@ int numa_debug_enabled;
  */
 static __init pg_data_t *alloc_node_data(void)
 {
-	pg_data_t *res;
-
-	res = (pg_data_t *) memblock_phys_alloc(sizeof(pg_data_t), 8);
-	memset(res, 0, sizeof(pg_data_t));
-	return res;
+	return memblock_alloc(sizeof(pg_data_t), 8);
 }
 
 /*
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index e897a4d..c50ff1f 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -34,16 +34,13 @@
 
 void * __init prom_early_alloc(unsigned long size)
 {
-	unsigned long paddr = memblock_phys_alloc(size, SMP_CACHE_BYTES);
-	void *ret;
+	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
 
-	if (!paddr) {
+	if (!ret) {
 		prom_printf("prom_early_alloc(%lu) failed\n", size);
 		prom_halt();
 	}
 
-	ret = __va(paddr);
-	memset(ret, 0, size);
 	prom_early_allocated += size;
 
 	return ret;
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 3c8aac2..52884f4 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1089,16 +1089,13 @@ static void __init allocate_node_data(int nid)
 	struct pglist_data *p;
 	unsigned long start_pfn, end_pfn;
 #ifdef CONFIG_NEED_MULTIPLE_NODES
-	unsigned long paddr;
 
-	paddr = memblock_phys_alloc_try_nid(sizeof(struct pglist_data),
-					    SMP_CACHE_BYTES, nid);
-	if (!paddr) {
+	NODE_DATA(nid) = memblock_alloc_node(sizeof(struct pglist_data),
+					     SMP_CACHE_BYTES, nid);
+	if (!NODE_DATA(nid)) {
 		prom_printf("Cannot allocate pglist_data for nid[%d]\n", nid);
 		prom_halt();
 	}
-	NODE_DATA(nid) = __va(paddr);
-	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
 	NODE_DATA(nid)->node_id = nid;
 #endif
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index 040a8c2..50d8c1a 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -143,9 +143,7 @@ static void __init build_mem_type_table(void)
 
 static void __init *early_alloc(unsigned long sz)
 {
-	void *ptr = __va(memblock_phys_alloc(sz, sz));
-	memset(ptr, 0, sz);
-	return ptr;
+	return memblock_alloc(sz, sz);
 }
 
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
