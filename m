Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 6/6] arm, s390,
 unicore32: remove oneliner wrappers for memblock_alloc()
Date: Mon, 31 Dec 2018 11:29:26 +0200
In-Reply-To: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
References: <1546248566-14910-1-git-send-email-rppt@linux.ibm.com>
Message-Id: <1546248566-14910-7-git-send-email-rppt@linux.ibm.com>
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

arm, s390 and unicore32 use oneliner wrappers for memblock_alloc().
Replace their usage with direct call to memblock_alloc().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/mm/mmu.c       | 11 +++--------
 arch/s390/numa/numa.c   | 10 +---------
 arch/unicore32/mm/mmu.c | 12 ++++--------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 0a04c9a5..57de0dd 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
-{
-	return memblock_alloc(sz, align);
-}
-
 static void __init *early_alloc(unsigned long sz)
 {
-	return early_alloc_aligned(sz, sz);
+	return memblock_alloc(sz, sz);
 }
 
 static void *__init late_alloc(unsigned long sz)
@@ -998,7 +993,7 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	if (!nr)
 		return;
 
-	svm = early_alloc_aligned(sizeof(*svm) * nr, __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm) * nr, __alignof__(*svm));
 
 	for (md = io_desc; nr; md++, nr--) {
 		create_mapping(md);
@@ -1020,7 +1015,7 @@ void __init vm_reserve_area_early(unsigned long addr, unsigned long size,
 	struct vm_struct *vm;
 	struct static_vm *svm;
 
-	svm = early_alloc_aligned(sizeof(*svm), __alignof__(*svm));
+	svm = memblock_alloc(sizeof(*svm), __alignof__(*svm));
 
 	vm = &svm->vm;
 	vm->addr = (void *)addr;
diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 2281a88..2d1271e 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -58,14 +58,6 @@ EXPORT_SYMBOL(__node_distance);
 int numa_debug_enabled;
 
 /*
- * alloc_node_data() - Allocate node data
- */
-static __init pg_data_t *alloc_node_data(void)
-{
-	return memblock_alloc(sizeof(pg_data_t), 8);
-}
-
-/*
  * numa_setup_memory() - Assign bootmem to nodes
  *
  * The memory is first added to memblock without any respect to nodes.
@@ -101,7 +93,7 @@ static void __init numa_setup_memory(void)
 
 	/* Allocate and fill out node_data */
 	for (nid = 0; nid < MAX_NUMNODES; nid++)
-		NODE_DATA(nid) = alloc_node_data();
+		NODE_DATA(nid) = memblock_alloc(sizeof(pg_data_t), 8);
 
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
diff --git a/arch/unicore32/mm/mmu.c b/arch/unicore32/mm/mmu.c
index 50d8c1a..a402192 100644
--- a/arch/unicore32/mm/mmu.c
+++ b/arch/unicore32/mm/mmu.c
@@ -141,16 +141,12 @@ static void __init build_mem_type_table(void)
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
-{
-	return memblock_alloc(sz, sz);
-}
-
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr,
 		unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = early_alloc(PTRS_PER_PTE * sizeof(pte_t));
+		pte_t *pte = memblock_alloc(PTRS_PER_PTE * sizeof(pte_t),
+					    PTRS_PER_PTE * sizeof(pte_t));
 		__pmd_populate(pmd, __pa(pte) | prot);
 	}
 	BUG_ON(pmd_bad(*pmd));
@@ -352,7 +348,7 @@ static void __init devicemaps_init(void)
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = early_alloc(PAGE_SIZE);
+	vectors = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -429,7 +425,7 @@ void __init paging_init(void)
 	top_pmd = pmd_off_k(0xffff0000);
 
 	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
+	zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	bootmem_init();
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
