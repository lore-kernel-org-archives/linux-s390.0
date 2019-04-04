Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 03/12] s390/mm: force swiotlb for protected virtualization
Date: Fri,  5 Apr 2019 01:16:13 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-4-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On s390 protected virtualization guests also have to use bounce I/O
buffers.  That requires some plumbing.

Let us make sure any device using DMA API accordingly is spared from the
problems that hypervisor attempting I/O to a non-shared secure page would
bring.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/Kconfig                   |  4 ++++
 arch/s390/include/asm/Kbuild        |  1 -
 arch/s390/include/asm/dma-mapping.h | 13 +++++++++++
 arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++++++
 arch/s390/mm/init.c                 | 44 +++++++++++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/asm/dma-mapping.h
 create mode 100644 arch/s390/include/asm/mem_encrypt.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d0653002..46c69283a67b 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+config ARCH_HAS_MEM_ENCRYPT
+        def_bool y
+
 config MMU
 	def_bool y
 
@@ -190,6 +193,7 @@ config S390
 	select ARCH_HAS_SCALED_CPUTIME
 	select VIRT_TO_BUS
 	select HAVE_NMI
+	select SWIOTLB
 
 
 config SCHED_OMIT_FRAME_POINTER
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 12d77cb11fe5..ba55cd472950 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,7 +8,6 @@ generic-y += asm-offsets.h
 generic-y += cacheflush.h
 generic-y += device.h
 generic-y += dma-contiguous.h
-generic-y += dma-mapping.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += export.h
diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
new file mode 100644
index 000000000000..8985da6ecdfd
--- /dev/null
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_DMA_MAPPING_H
+#define _ASM_S390_DMA_MAPPING_H
+
+#include <linux/dma-contiguous.h>
+
+static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
+{
+	return NULL;
+}
+
+#endif /* _ASM_S390_DMA_MAPPING_H */
+
diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
new file mode 100644
index 000000000000..0898c09a888c
--- /dev/null
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef S390_MEM_ENCRYPT_H__
+#define S390_MEM_ENCRYPT_H__
+
+#ifndef __ASSEMBLY__
+
+#define sme_me_mask	0ULL
+
+static inline bool sme_active(void) { return false; }
+extern bool sev_active(void);
+
+int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_decrypted(unsigned long addr, int numpages);
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* S390_MEM_ENCRYPT_H__ */
+
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3e82f66d5c61..a47bd4998d24 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -18,6 +18,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/swiotlb.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
@@ -29,6 +30,7 @@
 #include <linux/export.h>
 #include <linux/cma.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
@@ -42,6 +44,7 @@
 #include <asm/sclp.h>
 #include <asm/set_memory.h>
 #include <asm/kasan.h>
+#include <asm/dma-mapping.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
@@ -126,6 +129,45 @@ void mark_rodata_ro(void)
 	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
 }
 
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	/* also called for the swiotlb bounce buffers, make all pages shared */
+	/* TODO: do ultravisor calls */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(set_memory_encrypted);
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	/* also called for the swiotlb bounce buffers, make all pages shared */
+	/* TODO: do ultravisor calls */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(set_memory_decrypted);
+
+/* are we a protected virtualization guest? */
+bool sev_active(void)
+{
+	/*
+	 * TODO: Do proper detection using ultravisor, for now let us fake we
+	 *  have it so the code gets exercised.
+	 */
+	return true;
+}
+EXPORT_SYMBOL_GPL(sev_active);
+
+/* protected virtualization */
+static void pv_init(void)
+{
+	if (!sev_active())
+		return;
+
+	/* make sure bounce buffers are shared */
+	swiotlb_init(1);
+	swiotlb_update_mem_attributes();
+	swiotlb_force = SWIOTLB_FORCE;
+}
+
 void __init mem_init(void)
 {
 	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
@@ -134,6 +176,8 @@ void __init mem_init(void)
 	set_max_mapnr(max_low_pfn);
         high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
+	pv_init();
+
 	/* Setup guest page hinting */
 	cmma_init();
 
-- 
2.16.4
