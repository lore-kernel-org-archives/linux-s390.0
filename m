Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 29 Nov 2018 13:16:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.20 #3
Message-Id: <20181129131638.4034318f@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull s390 fixes for 4.20-rc5

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.20-3

for you to fetch changes up to 814cedbc0b78d75e335c96da9b9391142eab5600:

  s390/mm: correct pgtable_bytes on page table downgrade (2018-11-27 14:07:12 +0100)

----------------------------------------------------------------
s390 updates for 4.20-rc5

 - Add two missing kfree calls on error paths in the vfio-ccw code

 - Make sure that all data structures of a mediated vfio-ccw device are
   initialized before registering it

 - Fix a sparse warning in vfio-ccw

 - A followup patch for the pgtable_bytes accounting, the page table
   downgrade for compat processes missed a mm_dec_nr_pmds()

 - Reject sampling requests in the PMU init function of the CPU
   measurement counter facility

 - With the vfio AP driver an AP queue needs to be reset on every device
   probe as the alternative driver could have modified the device state

----------------------------------------------------------------
Eric Farman (2):
      s390/cio: Fix cleanup of pfn_array alloc failure
      s390/cio: Fix cleanup when unsupported IDA format is used

Harald Freudenberger (1):
      s390/zcrypt: reinit ap queue state machine during device probe

Martin Schwidefsky (2):
      Merge tag 'vfio-ccw-20181113' of git://git.kernel.org/.../kvms390/vfio-ccw into fixes
      s390/mm: correct pgtable_bytes on page table downgrade

Pierre Morel (1):
      vfio: ccw: Register mediated device once all structures are initialized

Sebastian Ott (1):
      s390/cio: make vfio_ccw_io_region static

Thomas Richter (1):
      s390/cpum_cf: Reject request for sampling in event initialization

 arch/s390/kernel/perf_cpum_cf.c    |  2 ++
 arch/s390/mm/pgalloc.c             |  1 +
 drivers/s390/cio/vfio_ccw_cp.c     |  6 ++++--
 drivers/s390/cio/vfio_ccw_drv.c    | 10 +++++-----
 drivers/s390/crypto/ap_bus.c       |  8 ++++----
 drivers/s390/crypto/ap_bus.h       |  1 +
 drivers/s390/crypto/ap_queue.c     | 15 +++++++++++++++
 drivers/s390/crypto/zcrypt_cex2a.c |  1 -
 drivers/s390/crypto/zcrypt_cex2c.c |  1 -
 drivers/s390/crypto/zcrypt_cex4.c  |  1 -
 10 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 74091fd..d5523ad 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -346,6 +346,8 @@ static int __hw_perf_event_init(struct perf_event *event)
 		break;
 
 	case PERF_TYPE_HARDWARE:
+		if (is_sampling_event(event))	/* No sampling support */
+			return -ENOENT;
 		ev = attr->config;
 		/* Count user space (problem-state) only */
 		if (!attr->exclude_user && attr->exclude_kernel) {
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 814f265..6791562 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -131,6 +131,7 @@ void crst_table_downgrade(struct mm_struct *mm)
 	}
 
 	pgd = mm->pgd;
+	mm_dec_nr_pmds(mm);
 	mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
 	mm->context.asce_limit = _REGION3_SIZE;
 	mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index fd77e46..70a006ba 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -387,8 +387,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 		 * orb specified one of the unsupported formats, we defer
 		 * checking for IDAWs in unsupported formats to here.
 		 */
-		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
+		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw)) {
+			kfree(p);
 			return -EOPNOTSUPP;
+		}
 
 		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
 			break;
@@ -528,7 +530,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 
 	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
 	if (ret < 0)
-		goto out_init;
+		goto out_unpin;
 
 	/* Translate this direct ccw to a idal ccw. */
 	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index f47d16b..a10cec0 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -22,7 +22,7 @@
 #include "vfio_ccw_private.h"
 
 struct workqueue_struct *vfio_ccw_work_q;
-struct kmem_cache *vfio_ccw_io_region;
+static struct kmem_cache *vfio_ccw_io_region;
 
 /*
  * Helpers
@@ -134,14 +134,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_free;
 
-	ret = vfio_ccw_mdev_reg(sch);
-	if (ret)
-		goto out_disable;
-
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
+	ret = vfio_ccw_mdev_reg(sch);
+	if (ret)
+		goto out_disable;
+
 	return 0;
 
 out_disable:
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 048665e..9f5a201 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -775,6 +775,8 @@ static int ap_device_probe(struct device *dev)
 		drvres = ap_drv->flags & AP_DRIVER_FLAG_DEFAULT;
 		if (!!devres != !!drvres)
 			return -ENODEV;
+		/* (re-)init queue's state machine */
+		ap_queue_reinit_state(to_ap_queue(dev));
 	}
 
 	/* Add queue/card to list of active queues/cards */
@@ -807,6 +809,8 @@ static int ap_device_remove(struct device *dev)
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	struct ap_driver *ap_drv = ap_dev->drv;
 
+	if (is_queue_dev(dev))
+		ap_queue_remove(to_ap_queue(dev));
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
 
@@ -1444,10 +1448,6 @@ static void ap_scan_bus(struct work_struct *unused)
 			aq->ap_dev.device.parent = &ac->ap_dev.device;
 			dev_set_name(&aq->ap_dev.device,
 				     "%02x.%04x", id, dom);
-			/* Start with a device reset */
-			spin_lock_bh(&aq->lock);
-			ap_wait(ap_sm_event(aq, AP_EVENT_POLL));
-			spin_unlock_bh(&aq->lock);
 			/* Register device */
 			rc = device_register(&aq->ap_dev.device);
 			if (rc) {
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 3eed1b3..bfc66e4 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -254,6 +254,7 @@ struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type);
 void ap_queue_remove(struct ap_queue *aq);
 void ap_queue_suspend(struct ap_device *ap_dev);
 void ap_queue_resume(struct ap_device *ap_dev);
+void ap_queue_reinit_state(struct ap_queue *aq);
 
 struct ap_card *ap_card_create(int id, int queue_depth, int raw_device_type,
 			       int comp_device_type, unsigned int functions);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 66f7334..0aa4b3c 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -718,5 +718,20 @@ void ap_queue_remove(struct ap_queue *aq)
 {
 	ap_flush_queue(aq);
 	del_timer_sync(&aq->timeout);
+
+	/* reset with zero, also clears irq registration */
+	spin_lock_bh(&aq->lock);
+	ap_zapq(aq->qid);
+	aq->state = AP_STATE_BORKED;
+	spin_unlock_bh(&aq->lock);
 }
 EXPORT_SYMBOL(ap_queue_remove);
+
+void ap_queue_reinit_state(struct ap_queue *aq)
+{
+	spin_lock_bh(&aq->lock);
+	aq->state = AP_STATE_RESET_START;
+	ap_wait(ap_sm_event(aq, AP_EVENT_POLL));
+	spin_unlock_bh(&aq->lock);
+}
+EXPORT_SYMBOL(ap_queue_reinit_state);
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index 146f54f..c50f3e8 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -196,7 +196,6 @@ static void zcrypt_cex2a_queue_remove(struct ap_device *ap_dev)
 	struct ap_queue *aq = to_ap_queue(&ap_dev->device);
 	struct zcrypt_queue *zq = aq->private;
 
-	ap_queue_remove(aq);
 	if (zq)
 		zcrypt_queue_unregister(zq);
 }
diff --git a/drivers/s390/crypto/zcrypt_cex2c.c b/drivers/s390/crypto/zcrypt_cex2c.c
index 546f676..35c7c66 100644
--- a/drivers/s390/crypto/zcrypt_cex2c.c
+++ b/drivers/s390/crypto/zcrypt_cex2c.c
@@ -251,7 +251,6 @@ static void zcrypt_cex2c_queue_remove(struct ap_device *ap_dev)
 	struct ap_queue *aq = to_ap_queue(&ap_dev->device);
 	struct zcrypt_queue *zq = aq->private;
 
-	ap_queue_remove(aq);
 	if (zq)
 		zcrypt_queue_unregister(zq);
 }
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index f9d4c6c..582ffa7 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -275,7 +275,6 @@ static void zcrypt_cex4_queue_remove(struct ap_device *ap_dev)
 	struct ap_queue *aq = to_ap_queue(&ap_dev->device);
 	struct zcrypt_queue *zq = aq->private;
 
-	ap_queue_remove(aq);
 	if (zq)
 		zcrypt_queue_unregister(zq);
 }
