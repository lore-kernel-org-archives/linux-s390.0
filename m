Return-Path: <SRS0=5+JM=T5=vger.kernel.org=kvm-owner@kernel.org>
From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v3 1/8] s390/mm: force swiotlb for protected virtualization
Date: Wed, 29 May 2019 14:26:50 +0200
In-Reply-To: <20190529122657.166148-1-mimu@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
Message-Id: <20190529122657.166148-2-mimu@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.ibm.com>

On s390, protected virtualization guests have to use bounced I/O
buffers.  That requires some plumbing.

Let us make sure, any device that uses DMA API with direct ops correctly
is spared from the problems, that a hypervisor attempting I/O to a
non-shared page would bring.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/Kconfig                   |  4 ++++
 arch/s390/include/asm/mem_encrypt.h | 18 ++++++++++++++
 arch/s390/mm/init.c                 | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 arch/s390/include/asm/mem_encrypt.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 109243fdb6ec..88d8355b7bf7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+config ARCH_HAS_MEM_ENCRYPT
+        def_bool y
+
 config MMU
 	def_bool y
 
@@ -187,6 +190,7 @@ config S390
 	select VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_SCALED_CPUTIME
 	select HAVE_NMI
+	select SWIOTLB
 
 
 config SCHED_OMIT_FRAME_POINTER
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
index 14d1eae9fe43..f0bee6af3960 100644
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
@@ -42,6 +44,8 @@
 #include <asm/sclp.h>
 #include <asm/set_memory.h>
 #include <asm/kasan.h>
+#include <asm/dma-mapping.h>
+#include <asm/uv.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
 
@@ -128,6 +132,47 @@ void mark_rodata_ro(void)
 	pr_info("Write protected read-only-after-init data: %luk\n", size >> 10);
 }
 
+int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	int i;
+
+	/* make specified pages unshared, (swiotlb, dma_free) */
+	for (i = 0; i < numpages; ++i) {
+		uv_remove_shared(addr);
+		addr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	int i;
+	/* make specified pages shared (swiotlb, dma_alloca) */
+	for (i = 0; i < numpages; ++i) {
+		uv_set_shared(addr);
+		addr += PAGE_SIZE;
+	}
+	return 0;
+}
+
+/* are we a protected virtualization guest? */
+bool sev_active(void)
+{
+	return is_prot_virt_guest();
+}
+
+/* protected virtualization */
+static void pv_init(void)
+{
+	if (!is_prot_virt_guest())
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
@@ -136,6 +181,8 @@ void __init mem_init(void)
 	set_max_mapnr(max_low_pfn);
         high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 
+	pv_init();
+
 	/* Setup guest page hinting */
 	cmma_init();
 
-- 
2.13.4
