Return-Path: <linux-kernel-owner+w=401wt.eu-S1763500AbXEWAZg@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.22-rc1-mm1 - s390 vs. md
Date: Tue, 22 May 2007 17:25:24 -0700
Message-ID: <0C7297FA1D2D244A9C7F6959C0BF1E5201E39968@azsmsx413.amr.corp.intel.com>
In-Reply-To: <20070521092449.34a50f2e@gondolin.boeblingen.de.ibm.com>
From: "Williams, Dan J" <dan.j.williams@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> From: Cornelia Huck [mailto:cornelia.huck@de.ibm.com]
> On Fri, 18 May 2007 09:30:09 -0700,
> "Williams, Dan J" <dan.j.williams@intel.com> wrote:
> 
> > When CONFIG_DMA_ENGINE=n async_tx_find_channel takes the form:
> > ... async_tx_find_channel( ... )
> > {
> > 	return NULL;
> > }
> >
> > So in the S390 case the entire asynchronous path will be compiled
away.
> 
> Unfortunately, do_async_xor() (and others) is not ifdef'ed and
contains
> dma_map_page(), which led to the compile failure...

The approach I have taken is to add the missing definitions to
include/asm-s390/dma-mapping.h [ a non-outlook-mangled version of the
patch is pushed out in my rebased git tree ].  I was not able to fully
compile-test this change as the three s390-cross-toolchains I tried each
died early in the kernel build process.  The most common error was:
"s390-unknown-linux-gnu-ld: unrecognised emulation mode: elf64_s390"

---

s390: add dma mapping api stub definitions for async_tx

From: Dan Williams <dan.j.williams@intel.com>

The asynchronous path in async_tx is meant to be compiled away on
platforms
like s390 with CONFIG_DMA_ENGINE=n.  However, it is difficult to compile
something away if it does not compile in the first place.  This patch
adds
the missing dma api definitions as BUG() stubs.

Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 include/asm-s390/dma-mapping.h |   78
++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/include/asm-s390/dma-mapping.h
b/include/asm-s390/dma-mapping.h
index 3f8c12f..33a3c82 100644
--- a/include/asm-s390/dma-mapping.h
+++ b/include/asm-s390/dma-mapping.h
@@ -4,9 +4,87 @@
  *  S390 version
  *
  *  This file exists so that #include <dma-mapping.h> doesn't break
anything.
+ *  It also includes stub definitions of the API so common code like
async_tx
+ *  can compile.
  */
 
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <linux/mm.h>
+#include <asm/scatterlist.h>
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+	enum dma_data_direction dir)
+{
+	BUG();
+	return 0;
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size,
+	     enum dma_data_direction dir)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t handle, size_t size,
+	enum dma_data_direction dir)
+{
+	BUG();
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
+	       enum dma_data_direction dir)
+{
+	BUG();
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	enum dma_data_direction dir)
+{
+	BUG();
+	return 0;
+}
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+	     enum dma_data_direction dir)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_single_for_cpu(struct device *dev, dma_addr_t handle, size_t
size,
+			enum dma_data_direction dir)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_single_for_device(struct device *dev, dma_addr_t handle,
size_t size,
+			   enum dma_data_direction dir)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int
nents,
+		    enum dma_data_direction dir)
+{
+	BUG();
+}
+
+static inline void
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int
nents,
+		       enum dma_data_direction dir)
+{
+	BUG();
+}
 #endif /* _ASM_DMA_MAPPING_H */
