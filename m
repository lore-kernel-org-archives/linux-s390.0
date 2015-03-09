Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Mar 2015 10:48:59 -0700
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.0.0-rc4
Message-ID: <20150309104859.0f6029fe@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

One performance optimization for page_clear and a couple of bug fixes.

Ameen Ali (1):
      s390/dcss: array index 'i' is used before limits check.

Christian Borntraeger (1):
      s390: let the compiler do page clearing

Heiko Carstens (3):
      s390/jump label: add missing jump_label_apply_nops() call
      s390/jump label: improve and fix sanity check
      s390/ftrace: fix crashes when switching tracers / add notrace to cpu_relax()

Martin Schwidefsky (1):
      s390/mm: fix incorrect ASCE after crst_table_downgrade

Sebastian Ott (4):
      s390/scm_block: fix off by one during cluster reservation
      s390/pci: fix possible information leak in mmio syscall
      s390/pci: fix [un]map_resources sequence
      s390/pci: unify pci_iomap symbol exports

 arch/s390/include/asm/mmu_context.h  |  2 +-
 arch/s390/include/asm/page.h         | 11 +----------
 arch/s390/kernel/jump_label.c        | 12 ++++++++----
 arch/s390/kernel/module.c            |  1 +
 arch/s390/kernel/processor.c         |  2 +-
 arch/s390/pci/pci.c                  | 28 ++++++++++++++++------------
 arch/s390/pci/pci_mmio.c             | 17 ++++++++---------
 drivers/s390/block/dcssblk.c         |  2 +-
 drivers/s390/block/scm_blk_cluster.c |  2 +-
 9 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index f49b719..8fb3802 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -62,6 +62,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	int cpu = smp_processor_id();
 
+	S390_lowcore.user_asce = next->context.asce_bits | __pa(next->pgd);
 	if (prev == next)
 		return;
 	if (MACHINE_HAS_TLB_LC)
@@ -73,7 +74,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	atomic_dec(&prev->context.attach_count);
 	if (MACHINE_HAS_TLB_LC)
 		cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
-	S390_lowcore.user_asce = next->context.asce_bits | __pa(next->pgd);
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 7b2ac6e..53eacbd 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -37,16 +37,7 @@ static inline void storage_key_init_range(unsigned long start, unsigned long end
 #endif
 }
 
-static inline void clear_page(void *page)
-{
-	register unsigned long reg1 asm ("1") = 0;
-	register void *reg2 asm ("2") = page;
-	register unsigned long reg3 asm ("3") = 4096;
-	asm volatile(
-		"	mvcl	2,0"
-		: "+d" (reg2), "+d" (reg3) : "d" (reg1)
-		: "memory", "cc");
-}
+#define clear_page(page)	memset((page), 0, PAGE_SIZE)
 
 /*
  * copy_page uses the mvcl instruction with 0xb0 padding byte in order to
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index cb2d51e..830066f 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -36,16 +36,20 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
 	insn->offset = (entry->target - entry->code) >> 1;
 }
 
-static void jump_label_bug(struct jump_entry *entry, struct insn *insn)
+static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
+			   struct insn *new)
 {
 	unsigned char *ipc = (unsigned char *)entry->code;
-	unsigned char *ipe = (unsigned char *)insn;
+	unsigned char *ipe = (unsigned char *)expected;
+	unsigned char *ipn = (unsigned char *)new;
 
 	pr_emerg("Jump label code mismatch at %pS [%p]\n", ipc, ipc);
 	pr_emerg("Found:    %02x %02x %02x %02x %02x %02x\n",
 		 ipc[0], ipc[1], ipc[2], ipc[3], ipc[4], ipc[5]);
 	pr_emerg("Expected: %02x %02x %02x %02x %02x %02x\n",
 		 ipe[0], ipe[1], ipe[2], ipe[3], ipe[4], ipe[5]);
+	pr_emerg("New:      %02x %02x %02x %02x %02x %02x\n",
+		 ipn[0], ipn[1], ipn[2], ipn[3], ipn[4], ipn[5]);
 	panic("Corrupted kernel text");
 }
 
@@ -69,10 +73,10 @@ static void __jump_label_transform(struct jump_entry *entry,
 	}
 	if (init) {
 		if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
-			jump_label_bug(entry, &old);
+			jump_label_bug(entry, &orignop, &new);
 	} else {
 		if (memcmp((void *)entry->code, &old, sizeof(old)))
-			jump_label_bug(entry, &old);
+			jump_label_bug(entry, &old, &new);
 	}
 	probe_kernel_write((void *)entry->code, &new, sizeof(new));
 }
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 36154a2..2ca9586 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -436,6 +436,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
+	jump_label_apply_nops(me);
 	vfree(me->arch.syminfo);
 	me->arch.syminfo = NULL;
 	return 0;
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 2610823..dc488e1 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -18,7 +18,7 @@
 
 static DEFINE_PER_CPU(struct cpuid, cpu_id);
 
-void cpu_relax(void)
+void notrace cpu_relax(void)
 {
 	if (!smp_cpu_mtid && MACHINE_HAS_DIAG44)
 		asm volatile("diag 0,0,0x44");
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 753a567..f0b8544 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -287,7 +287,7 @@ void __iomem *pci_iomap_range(struct pci_dev *pdev,
 	addr = ZPCI_IOMAP_ADDR_BASE | ((u64) idx << 48);
 	return (void __iomem *) addr + offset;
 }
-EXPORT_SYMBOL_GPL(pci_iomap_range);
+EXPORT_SYMBOL(pci_iomap_range);
 
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -309,7 +309,7 @@ void pci_iounmap(struct pci_dev *pdev, void __iomem *addr)
 	}
 	spin_unlock(&zpci_iomap_lock);
 }
-EXPORT_SYMBOL_GPL(pci_iounmap);
+EXPORT_SYMBOL(pci_iounmap);
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 		    int size, u32 *val)
@@ -483,9 +483,8 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
 }
 
-static void zpci_map_resources(struct zpci_dev *zdev)
+static void zpci_map_resources(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = zdev->pdev;
 	resource_size_t len;
 	int i;
 
@@ -499,9 +498,8 @@ static void zpci_map_resources(struct zpci_dev *zdev)
 	}
 }
 
-static void zpci_unmap_resources(struct zpci_dev *zdev)
+static void zpci_unmap_resources(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = zdev->pdev;
 	resource_size_t len;
 	int i;
 
@@ -651,7 +649,7 @@ int pcibios_add_device(struct pci_dev *pdev)
 
 	zdev->pdev = pdev;
 	pdev->dev.groups = zpci_attr_groups;
-	zpci_map_resources(zdev);
+	zpci_map_resources(pdev);
 
 	for (i = 0; i < PCI_BAR_COUNT; i++) {
 		res = &pdev->resource[i];
@@ -663,6 +661,11 @@ int pcibios_add_device(struct pci_dev *pdev)
 	return 0;
 }
 
+void pcibios_release_device(struct pci_dev *pdev)
+{
+	zpci_unmap_resources(pdev);
+}
+
 int pcibios_enable_device(struct pci_dev *pdev, int mask)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
@@ -670,7 +673,6 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 	zdev->pdev = pdev;
 	zpci_debug_init_device(zdev);
 	zpci_fmb_enable_device(zdev);
-	zpci_map_resources(zdev);
 
 	return pci_enable_resources(pdev, mask);
 }
@@ -679,7 +681,6 @@ void pcibios_disable_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
 
-	zpci_unmap_resources(zdev);
 	zpci_fmb_disable_device(zdev);
 	zpci_debug_exit_device(zdev);
 	zdev->pdev = NULL;
@@ -688,7 +689,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 static int zpci_restore(struct device *dev)
 {
-	struct zpci_dev *zdev = get_zdev(to_pci_dev(dev));
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct zpci_dev *zdev = get_zdev(pdev);
 	int ret = 0;
 
 	if (zdev->state != ZPCI_FN_STATE_ONLINE)
@@ -698,7 +700,7 @@ static int zpci_restore(struct device *dev)
 	if (ret)
 		goto out;
 
-	zpci_map_resources(zdev);
+	zpci_map_resources(pdev);
 	zpci_register_ioat(zdev, 0, zdev->start_dma + PAGE_OFFSET,
 			   zdev->start_dma + zdev->iommu_size - 1,
 			   (u64) zdev->dma_table);
@@ -709,12 +711,14 @@ out:
 
 static int zpci_freeze(struct device *dev)
 {
-	struct zpci_dev *zdev = get_zdev(to_pci_dev(dev));
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct zpci_dev *zdev = get_zdev(pdev);
 
 	if (zdev->state != ZPCI_FN_STATE_ONLINE)
 		return 0;
 
 	zpci_unregister_ioat(zdev, 0);
+	zpci_unmap_resources(pdev);
 	return clp_disable_fh(zdev);
 }
 
diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 8aa271b..b1bb2b7 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -64,8 +64,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	if (copy_from_user(buf, user_buffer, length))
 		goto out;
 
-	memcpy_toio(io_addr, buf, length);
-	ret = 0;
+	ret = zpci_memcpy_toio(io_addr, buf, length);
 out:
 	if (buf != local_buf)
 		kfree(buf);
@@ -98,16 +97,16 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 		goto out;
 	io_addr = (void __iomem *)((pfn << PAGE_SHIFT) | (mmio_addr & ~PAGE_MASK));
 
-	ret = -EFAULT;
-	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE)
+	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE) {
+		ret = -EFAULT;
 		goto out;
-
-	memcpy_fromio(buf, io_addr, length);
-
-	if (copy_to_user(user_buffer, buf, length))
+	}
+	ret = zpci_memcpy_fromio(buf, io_addr, length);
+	if (ret)
 		goto out;
+	if (copy_to_user(user_buffer, buf, length))
+		ret = -EFAULT;
 
-	ret = 0;
 out:
 	if (buf != local_buf)
 		kfree(buf);
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 96128cb..da21281 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -547,7 +547,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	 * parse input
 	 */
 	num_of_segments = 0;
-	for (i = 0; ((buf[i] != '\0') && (buf[i] != '\n') && i < count); i++) {
+	for (i = 0; (i < count && (buf[i] != '\0') && (buf[i] != '\n')); i++) {
 		for (j = i; (buf[j] != ':') &&
 			(buf[j] != '\0') &&
 			(buf[j] != '\n') &&
diff --git a/drivers/s390/block/scm_blk_cluster.c b/drivers/s390/block/scm_blk_cluster.c
index 09db452..7497ddd 100644
--- a/drivers/s390/block/scm_blk_cluster.c
+++ b/drivers/s390/block/scm_blk_cluster.c
@@ -92,7 +92,7 @@ bool scm_reserve_cluster(struct scm_request *scmrq)
 			add = 0;
 			continue;
 		}
-		for (pos = 0; pos <= iter->aob->request.msb_count; pos++) {
+		for (pos = 0; pos < iter->aob->request.msb_count; pos++) {
 			if (clusters_intersect(req, iter->request[pos]) &&
 			    (rq_data_dir(req) == WRITE ||
 			     rq_data_dir(iter->request[pos]) == WRITE)) {
