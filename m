From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Date: Fri, 14 Dec 2018 12:47:19 +0100
Message-ID: <20181214114719.GA3316@lst.de>
References: <20181214082515.14835-1-hch@lst.de> <20181214082515.14835-2-hch@lst.de> <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWOr0EsgFQF8tjJYLxKVXx+Jwn73N8SVKt8AQGLKQ8V-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Linux IOMMU <iommu@lists.linux-foundation.org>, Michal Simek <monstr@monstr.eu>, ashutosh.dixit@intel.com, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 14, 2018 at 10:54:32AM +0100, Geert Uytterhoeven wrote:
> > -       page = alloc_pages(flag, order);
> > +       page = alloc_pages(flag | GFP_ZERO, order);
> >         if (!page)
> >                 return NULL;
> 
> There's second implementation below, which calls __get_free_pages() and
> does an explicit memset().  As __get_free_pages() calls alloc_pages(), perhaps
> it makes sense to replace the memset() by GFP_ZERO, to increase consistency?

It would, but this patch really tries to be minimally invasive to just
provide the zeroing everywhere.  There is plenty of opportunity
to improve the m68k dma allocator if I can get enough reviewers/testers:

 - for one the coldfire/nommu case absolutely does not make sense to
   me as there is not work done at all to make sure the memory is
   mapped uncached despite the architecture implementing cache
   flushing for the map interface.  So this whole implementation
   looks broken to me and will need some major work (I had a previous
   discussion with Greg on that which needs to be dug out)
 - the "regular" implementation in this patch should probably be replaced
   with the generic remapping helpers that have been added for the 4.21
   merge window:

	http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/0c3b3171ceccb8830c2bb5adff1b4e9b204c1450

Compile tested only patch below:

--
From ade86dc75b9850daf9111ebf9ce15825a6144f2d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 14 Dec 2018 12:41:45 +0100
Subject: m68k: use the generic dma coherent remap allocator

This switche to using common code for the DMA allocations, including
potential use of the CMA allocator if configure.  Also add a few
comments where the existing behavior seems to be lacking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig      |  2 ++
 arch/m68k/kernel/dma.c | 64 ++++++++++++------------------------------
 2 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 8a5868e9a3a0..60788cf02fbc 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -2,10 +2,12 @@
 config M68K
 	bool
 	default y
+	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select DMA_DIRECT_REMAP if MMU && !COLDFIRE
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index dafe99d08a6a..16da5d96e228 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -18,57 +18,29 @@
 #include <asm/pgalloc.h>
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t flag, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	struct page *page, **map;
-	pgprot_t pgprot;
-	void *addr;
-	int i, order;
-
-	pr_debug("dma_alloc_coherent: %d,%x\n", size, flag);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	page = alloc_pages(flag | GFP_ZERO, order);
-	if (!page)
-		return NULL;
-
-	*handle = page_to_phys(page);
-	map = kmalloc(sizeof(struct page *) << order, flag & ~__GFP_DMA);
-	if (!map) {
-		__free_pages(page, order);
-		return NULL;
-	}
-	split_page(page, order);
-
-	order = 1 << order;
-	size >>= PAGE_SHIFT;
-	map[0] = page;
-	for (i = 1; i < size; i++)
-		map[i] = page + i;
-	for (; i < order; i++)
-		__free_page(page + i);
-	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_DIRTY);
-	if (CPU_IS_040_OR_060)
-		pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
-	else
-		pgprot_val(pgprot) |= _PAGE_NOCACHE030;
-	addr = vmap(map, size, VM_MAP, pgprot);
-	kfree(map);
-
-	return addr;
+	/*
+	 * XXX: don't we need to flush and invalidate the caches before
+	 * creating a coherent mapping?
+	 * coherent?
+	 */
 }
 
-void arch_dma_free(struct device *dev, size_t size, void *addr,
-		dma_addr_t handle, unsigned long attrs)
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
 {
-	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
-	vfree(addr);
+	/*
+	 * XXX: this doesn't seem to handle the sun3 MMU at all.
+	 */
+	if (CPU_IS_040_OR_060) {
+		pgprot_val(prot) &= ~_PAGE_CACHE040;
+		pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
+	} else {
+		pgprot_val(prot) |= _PAGE_NOCACHE030;
+	}
+	return prot;
 }
-
 #else
 
 #include <asm/cacheflush.h>
-- 
2.19.2
