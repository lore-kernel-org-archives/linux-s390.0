Date: Fri, 5 Jan 2018 14:05:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.15-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180105140522.71632b1a@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Four bug fixes.

Heiko Carstens (1):
      s390/sclp: disable FORTIFY_SOURCE for early sclp code

Martin Schwidefsky (1):
      s390: fix preemption race in disable_sacf_uaccess

Sebastian Ott (1):
      s390/pci: handle insufficient resources during dma tlb flush

Stefan Haberland (1):
      s390/dasd: fix wrongly assigned configuration data

 arch/s390/lib/uaccess.c            |  2 +-
 arch/s390/pci/pci_dma.c            | 21 +++++++++++++++++++--
 arch/s390/pci/pci_insn.c           |  3 +++
 drivers/s390/block/dasd_3990_erp.c | 10 ++++++++++
 drivers/s390/char/Makefile         |  2 ++
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index cae5a1e..c4f8039 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -89,11 +89,11 @@ EXPORT_SYMBOL(enable_sacf_uaccess);
 
 void disable_sacf_uaccess(mm_segment_t old_fs)
 {
+	current->thread.mm_segment = old_fs;
 	if (old_fs == USER_DS && test_facility(27)) {
 		__ctl_load(S390_lowcore.user_asce, 1, 1);
 		clear_cpu_flag(CIF_ASCE_PRIMARY);
 	}
-	current->thread.mm_segment = old_fs;
 }
 EXPORT_SYMBOL(disable_sacf_uaccess);
 
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index f7aa5a7..2d15d84 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -181,6 +181,9 @@ static int __dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
 static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 			   size_t size, int flags)
 {
+	unsigned long irqflags;
+	int ret;
+
 	/*
 	 * With zdev->tlb_refresh == 0, rpcit is not required to establish new
 	 * translations when previously invalid translation-table entries are
@@ -196,8 +199,22 @@ static int __dma_purge_tlb(struct zpci_dev *zdev, dma_addr_t dma_addr,
 			return 0;
 	}
 
-	return zpci_refresh_trans((u64) zdev->fh << 32, dma_addr,
-				  PAGE_ALIGN(size));
+	ret = zpci_refresh_trans((u64) zdev->fh << 32, dma_addr,
+				 PAGE_ALIGN(size));
+	if (ret == -ENOMEM && !s390_iommu_strict) {
+		/* enable the hypervisor to free some resources */
+		if (zpci_refresh_global(zdev))
+			goto out;
+
+		spin_lock_irqsave(&zdev->iommu_bitmap_lock, irqflags);
+		bitmap_andnot(zdev->iommu_bitmap, zdev->iommu_bitmap,
+			      zdev->lazy_bitmap, zdev->iommu_pages);
+		bitmap_zero(zdev->lazy_bitmap, zdev->iommu_pages);
+		spin_unlock_irqrestore(&zdev->iommu_bitmap_lock, irqflags);
+		ret = 0;
+	}
+out:
+	return ret;
 }
 
 static int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 19bcb3b..f069929 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -89,6 +89,9 @@ int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
 	if (cc)
 		zpci_err_insn(cc, status, addr, range);
 
+	if (cc == 1 && (status == 4 || status == 16))
+		return -ENOMEM;
+
 	return (cc) ? -EIO : 0;
 }
 
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index c94b606..ee14d8e 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2803,6 +2803,16 @@ dasd_3990_erp_action(struct dasd_ccw_req * cqr)
 		erp = dasd_3990_erp_handle_match_erp(cqr, erp);
 	}
 
+
+	/*
+	 * For path verification work we need to stick with the path that was
+	 * originally chosen so that the per path configuration data is
+	 * assigned correctly.
+	 */
+	if (test_bit(DASD_CQR_VERIFY_PATH, &erp->flags) && cqr->lpm) {
+		erp->lpm = cqr->lpm;
+	}
+
 	if (device->features & DASD_FEATURE_ERPLOG) {
 		/* print current erp_chain */
 		dev_err(&device->cdev->dev,
diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
index 05ac6ba..614b44e 100644
--- a/drivers/s390/char/Makefile
+++ b/drivers/s390/char/Makefile
@@ -17,6 +17,8 @@ CFLAGS_REMOVE_sclp_early_core.o	+= $(CC_FLAGS_MARCH)
 CFLAGS_sclp_early_core.o		+= -march=z900
 endif
 
+CFLAGS_sclp_early_core.o		+= -D__NO_FORTIFY
+
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
 	 sclp_cmd.o sclp_config.o sclp_cpi_sys.o sclp_ocf.o sclp_ctl.o \
 	 sclp_early.o sclp_early_core.o
