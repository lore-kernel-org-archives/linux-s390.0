Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Apr 2016 09:48:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.6-rc5
Message-ID: <20160418094805.2ff60511@mschwide>
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

A couple of bug fixes.

Gerald Schaefer (1):
      s390/dcssblk: fix possible deadlock in remove vs. per-device attributes

Heiko Carstens (2):
      s390/spinlock: avoid yield to non existent cpu
      s390: add CPU_BIG_ENDIAN config option

Sebastian Ott (2):
      s390/scm_blk: fix deadlock for requests != REQ_TYPE_FS
      s390/pci: add extra padding to function measurement block

Sudip Mukherjee (1):
      s390/seccomp: include generic seccomp header file

 arch/s390/Kconfig               | 3 +++
 arch/s390/include/asm/pci.h     | 3 ++-
 arch/s390/include/asm/seccomp.h | 2 ++
 arch/s390/lib/spinlock.c        | 1 +
 drivers/s390/block/dcssblk.c    | 5 +++--
 drivers/s390/block/scm_blk.c    | 2 +-
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index aad23e3..bf24ab1 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -4,6 +4,9 @@ config MMU
 config ZONE_DMA
 	def_bool y
 
+config CPU_BIG_ENDIAN
+	def_bool y
+
 config LOCKDEP_SUPPORT
 	def_bool y
 
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index b6bfa16..535a46d 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -44,7 +44,8 @@ struct zpci_fmb {
 	u64 rpcit_ops;
 	u64 dma_rbytes;
 	u64 dma_wbytes;
-} __packed __aligned(64);
+	u64 pad[2];
+} __packed __aligned(128);
 
 enum zpci_state {
 	ZPCI_FN_STATE_RESERVED,
diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 781a9cf..e10f833 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -13,4 +13,6 @@
 #define __NR_seccomp_exit_32	__NR_exit
 #define __NR_seccomp_sigreturn_32 __NR_sigreturn
 
+#include <asm-generic/seccomp.h>
+
 #endif	/* _ASM_S390_SECCOMP_H */
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index d4549c9..e5f50a7 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -105,6 +105,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp, unsigned long flags)
 			if (_raw_compare_and_swap(&lp->lock, 0, cpu))
 				return;
 			local_irq_restore(flags);
+			continue;
 		}
 		/* Check if the lock owner is running. */
 		if (first_diag && cpu_is_preempted(~owner)) {
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 1bce9cf..b839086 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -756,15 +756,16 @@ dcssblk_remove_store(struct device *dev, struct device_attribute *attr, const ch
 	blk_cleanup_queue(dev_info->dcssblk_queue);
 	dev_info->gd->queue = NULL;
 	put_disk(dev_info->gd);
-	device_unregister(&dev_info->dev);
 
 	/* unload all related segments */
 	list_for_each_entry(entry, &dev_info->seg_list, lh)
 		segment_unload(entry->segment_name);
 
-	put_device(&dev_info->dev);
 	up_write(&dcssblk_devices_sem);
 
+	device_unregister(&dev_info->dev);
+	put_device(&dev_info->dev);
+
 	rc = count;
 out_buf:
 	kfree(local_buf);
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 75d9896..e6f54d3 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -303,7 +303,7 @@ static void scm_blk_request(struct request_queue *rq)
 		if (req->cmd_type != REQ_TYPE_FS) {
 			blk_start_request(req);
 			blk_dump_rq_flags(req, KMSG_COMPONENT " bad request");
-			blk_end_request_all(req, -EIO);
+			__blk_end_request_all(req, -EIO);
 			continue;
 		}
 
