Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B92B55D869;
	Tue, 22 Sep 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091618; cv=none; b=NekYn7xzat9SAQGCVZ2tNNKl5YOe8aoTb/d1D9dO3zF0oVCkFTbVLhXK2aQ4YtPMKOwQtAwxiIbDOFcrv1NXoSE9v953V6ZoGo1RnOtdBKIKHQjayXZrYY2pqQ6xJfr9PzzWLdfAhN8NIOGdKCrPqoE1ZJLObtdHQ4TKWU8B+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091618; c=relaxed/simple;
	bh=6W0g4Ck4JPsftf63O4MoWWYbRZcMaFdvRzcMK3bJO74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Awi9Xq6RgC1Cjj9Dg4UzQGaNovi59naiDM7qOcR2VdTef+zLD/hlyeFqkxj2Xuu3OQLE5w7pXwSB2WCwuDtL54HYo+LMVPOCzlXUanKa/WhIwY2Nn5P5d+FKLpcoRBrd+AIl8yGgQ4IWmM651rWYLEG739N7t0JYoZeqXj1ew7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBlXszrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBlXszrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C5A1F00893;
	Tue, 22 Sep 2026 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091617;
	bh=fUi0jBX2gNbeikyLH6NBFgw3bykuPr333IPe1Mu8mWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oBlXszrpHmbC1L39oiYrfsLXYt0tWyovlepfyoh4M57W/m40ZxhvpFELjycOKusJ4
	 bChO11gXU/dIjDyVMo88rIR1xoXPcO2zvCnkQxXQ5l2aq4aID+jqSITDVffNy79clb
	 jwen+K5f3UhSbVb9JA0ogEP/8RItWsa3m8snnl8vX3K1+riLCsZyK1/mTuTyXiT0YI
	 DKHuECZMKJXuHkPPLPn0V4Vwk88BpouwpTu15w0WZHsGD8J009Tv8cac4fjE8Xua9F
	 uNH6MrfvV8o1Ptjxi+VdVn9aE1xv316X/SEkbtaEN1dckNkXn3XmDaYdaTguzhgJDd
	 ZMm2pJ0BS9JyQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 22 Sep 2026 16:35:41 +0100
Subject: [PATCH v4 10/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc32
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-rcu-pagetable-freeing-v4-10-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, 
 Qi Zheng <qi.zheng@linux.dev>, linux-doc@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7457; i=ljs@kernel.org;
 h=from:subject:message-id; bh=6W0g4Ck4JPsftf63O4MoWWYbRZcMaFdvRzcMK3bJO74=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2LcjRYH1nV3JO7voClUs/hHkzJk/9ZfviaHzM7YhK2
 /t/NUMTOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRqVcZGfYsnXzv/5NQnYM+
 H3WE66L/WH4QrNv/RrNgyzGDWnH2U7GMDNcbMyzTfn5Tt3+s6ah8975gn/q+HZE6X+w2zT3myd8
 qyA4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Careful handling is required for sparc32 which implements page tables as
part of a shared backing page.

To support this, a custom __tlb_remove_table() function is required, as
specified by CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE.

This allows __pte_free_tlb() and __pmd_free_tlb() to specify which page
table level is being freed, which is transmitted to __tlb_remove_table()
through setting the lowest bit of the page table to 1 for a PMD and 0 for a
PTE (the page tables are 256-byte aligned so this is safe to do).

Next, since the page table freeing is done via RCU callback, and thus might
be executed in softirq context, update the spin locks to IRQ save/restore.

Then, in __tlb_remove_table(), figure out whether to free a PMD page table
via free_pmd_fast() or a PTE via the newly introduced __pte_free()
function, using the lower bit encoded in __pte_free_tlb() or
__pmd_free_tlb() to determine which to call.

As part of this change use this spin lock rather than mm->page_table_lock
for all shared page table exclusion, as RCU freeing means that page tables
can be freed from soft IRQ context so both don't have an mm and also
mm->page_table_lock is not IRQ-safe.

Note that the specification of CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE disables
CONFIG_PT_RECLAIM for sparc32, which mirrors sparc64.

This forms part of an overall effort to switch every architecture to this
mode, and with it complete, means every architecture now supports
CONFIG_MMU_GATHER_RCU_TABLE_FREE.

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/sparc/Kconfig                  |  2 ++
 arch/sparc/include/asm/pgalloc_32.h |  7 +++++--
 arch/sparc/lib/bitext.c             | 14 +++++++-------
 arch/sparc/mm/srmmu.c               | 32 +++++++++++++++++++++++++++-----
 4 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8d42ebc6d302..79c09d6ee466 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,6 +64,8 @@ config SPARC32
 	select HAVE_UID16
 	select HAVE_PAGE_SIZE_4KB
 	select LOCK_MM_AND_FIND_VMA
+	select MMU_GATHER_RCU_TABLE_FREE
+	select HAVE_ARCH_TLB_REMOVE_TABLE
 	select OLD_SIGACTION
 	select ZONE_DMA
 
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index 4f73e87b22a3..36010852ba0c 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -48,7 +48,9 @@ static inline void free_pmd_fast(pmd_t * pmd)
 }
 
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
+
+#define __pmd_free_tlb(tlb, pmd, addr)					\
+	tlb_remove_table((tlb), (void *)((unsigned long)(pmd) | 1UL))
 
 #define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
 
@@ -72,6 +74,7 @@ static inline void free_pte_fast(pte_t *pte)
 #define pte_free_kernel(mm, pte)	free_pte_fast(pte)
 
 void pte_free(struct mm_struct * mm, pgtable_t pte);
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+void __tlb_remove_table(void *table);
+#define __pte_free_tlb(tlb, pte, addr)	tlb_remove_table((tlb), (void *)(pte))
 
 #endif /* _SPARC_PGALLOC_H */
diff --git a/arch/sparc/lib/bitext.c b/arch/sparc/lib/bitext.c
index 32a5c1d9459c..c309e27973ce 100644
--- a/arch/sparc/lib/bitext.c
+++ b/arch/sparc/lib/bitext.c
@@ -22,8 +22,6 @@
  * @align: requested alignment
  *
  * Returns offset in the map or -1 if out of space.
- *
- * Not safe to call from an interrupt (uses spin_lock).
  */
 int bit_map_string_get(struct bit_map *t, int len, int align)
 {
@@ -31,6 +29,7 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 	int off_new;
 	int align1;
 	int i, color;
+	unsigned long flags;
 
 	if (t->num_colors) {
 		/* align is overloaded to be the page color */
@@ -50,7 +49,7 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 		BUG();
 	color &= align1;
 
-	spin_lock(&t->lock);
+	spin_lock_irqsave(&t->lock, flags);
 	if (len < t->last_size)
 		offset = t->first_free;
 	else
@@ -64,7 +63,7 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 		if (offset >= t->size)
 			offset = 0;
 		if (count + len > t->size) {
-			spin_unlock(&t->lock);
+			spin_unlock_irqrestore(&t->lock, flags);
 /* P3 */ printk(KERN_ERR
   "bitmap out: size %d used %d off %d len %d align %d count %d\n",
   t->size, t->used, offset, len, align, count);
@@ -90,7 +89,7 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 					t->last_off = 0;
 				t->used += len;
 				t->last_size = len;
-				spin_unlock(&t->lock);
+				spin_unlock_irqrestore(&t->lock, flags);
 				return offset;
 			}
 		}
@@ -103,10 +102,11 @@ int bit_map_string_get(struct bit_map *t, int len, int align)
 void bit_map_clear(struct bit_map *t, int offset, int len)
 {
 	int i;
+	unsigned long flags;
 
 	if (t->used < len)
 		BUG();		/* Much too late to do any good, but alas... */
-	spin_lock(&t->lock);
+	spin_lock_irqsave(&t->lock, flags);
 	for (i = 0; i < len; i++) {
 		if (test_bit(offset + i, t->map) == 0)
 			BUG();
@@ -115,7 +115,7 @@ void bit_map_clear(struct bit_map *t, int offset, int len)
 	if (offset < t->first_free)
 		t->first_free = offset;
 	t->used -= len;
-	spin_unlock(&t->lock);
+	spin_unlock_irqrestore(&t->lock, flags);
 }
 
 void bit_map_init(struct bit_map *t, unsigned long *map, int size)
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 9a74902ad181..1c277ab3cdb8 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -340,38 +340,60 @@ pgd_t *get_pgd_fast(void)
  * Alignments up to the page size are the same for physical and virtual
  * addresses of the nocache area.
  */
+
+static DEFINE_SPINLOCK(pte_page_lock);
+
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
+	unsigned long flags;
 	pte_t *ptep;
 	struct page *page;
 
 	if (!(ptep = pte_alloc_one_kernel(mm)))
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
-	spin_lock(&mm->page_table_lock);
+	spin_lock_irqsave(&pte_page_lock, flags);
 	if (page_ref_inc_return(page) == 2 &&
 			!pagetable_pte_ctor(mm, page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock_irqrestore(&pte_page_lock, flags);
 
 	return ptep;
 }
 
-void pte_free(struct mm_struct *mm, pgtable_t ptep)
+static void __pte_free(pgtable_t ptep)
 {
 	struct page *page;
+	unsigned long flags;
 
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
-	spin_lock(&mm->page_table_lock);
+	spin_lock_irqsave(&pte_page_lock, flags);
 	if (page_ref_dec_return(page) == 1)
 		pagetable_dtor(page_ptdesc(page));
-	spin_unlock(&mm->page_table_lock);
+	spin_unlock_irqrestore(&pte_page_lock, flags);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
 }
 
+void pte_free(struct mm_struct *mm, pgtable_t ptep)
+{
+	__pte_free(ptep);
+}
+
+void __tlb_remove_table(void *table)
+{
+	const unsigned long encoded = (unsigned long)table;
+	const unsigned long addr = encoded & ~1UL;
+	const bool is_pmd = encoded & 1;
+
+	if (is_pmd)
+		free_pmd_fast((pmd_t *)addr);
+	else
+		__pte_free((pgtable_t)addr);
+}
+
 /* context handling - a dynamically sized pool is used */
 #define NO_CONTEXT	-1
 

-- 
2.55.0

