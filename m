Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Oct 2018 07:20:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.19 #4
Message-Id: <20181010072001.425618eb@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Greg,

please pull s390 fixes for 4.19:

The following changes since commit 4b92e7fd76e94624e3d5ff56b3d6a5788c4a7ac8:

  Merge tag 'mtd/fixes-for-4.19-rc5' of git://git.infradead.org/linux-mtd (2018-09-20 11:25:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.19-4

for you to fetch changes up to 7c75544983edece1b745367922cf1053606cd369:

  Merge tag 'vfio-ccw-20181002' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into fixes (2018-10-08 09:08:21 +0200)

----------------------------------------------------------------
s390 fixes for 4.19-rc8

Four more patches for 4.19

 - Fix resume after suspend-to-disk if resume-CPU != suspend-CPU

 - Fix vfio-ccw check for pinned pages

 - Two patches to avoid a usercopy-whitelist warning in vfio-ccw

----------------------------------------------------------------
Eric Farman (3):
      s390/cio: Convert ccw_io_region to pointer
      s390/cio: Refactor alloc of ccw_io_region
      s390/cio: Fix how vfio-ccw checks pinned pages

Gerald Schaefer (1):
      s390/hibernate: fix error handling when suspend cpu != resume cpu

Martin Schwidefsky (2):
      Merge tag 'vfio-ccw-20181001' of git://git.kernel.org/.../kvms390/vfio-ccw into fixes
      Merge tag 'vfio-ccw-20181002' of git://git.kernel.org/.../kvms390/vfio-ccw into fixes

 arch/s390/include/asm/sclp.h        |  3 ++-
 arch/s390/kernel/early_printk.c     |  2 +-
 arch/s390/kernel/swsusp.S           |  8 +++-----
 drivers/s390/char/sclp_early_core.c | 11 ++++++++---
 drivers/s390/cio/vfio_ccw_cp.c      |  2 +-
 drivers/s390/cio/vfio_ccw_drv.c     | 24 +++++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_fsm.c     |  6 +++---
 drivers/s390/cio/vfio_ccw_ops.c     |  4 ++--
 drivers/s390/cio/vfio_ccw_private.h |  2 +-
 9 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 3cae916..e44a8d7 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -108,7 +108,8 @@ int sclp_early_get_core_info(struct sclp_core_info *info);
 void sclp_early_get_ipl_info(struct sclp_ipl_info *info);
 void sclp_early_detect(void);
 void sclp_early_printk(const char *s);
-void __sclp_early_printk(const char *s, unsigned int len);
+void sclp_early_printk_force(const char *s);
+void __sclp_early_printk(const char *s, unsigned int len, unsigned int force);
 
 int _sclp_get_core_info(struct sclp_core_info *info);
 int sclp_core_configure(u8 core);
diff --git a/arch/s390/kernel/early_printk.c b/arch/s390/kernel/early_printk.c
index 9431784..40c1dfe 100644
--- a/arch/s390/kernel/early_printk.c
+++ b/arch/s390/kernel/early_printk.c
@@ -10,7 +10,7 @@
 
 static void sclp_early_write(struct console *con, const char *s, unsigned int len)
 {
-	__sclp_early_printk(s, len);
+	__sclp_early_printk(s, len, 0);
 }
 
 static struct console sclp_early_console = {
diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index a049a7b..c1a080b 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -198,12 +198,10 @@ pgm_check_entry:
 
 	/* Suspend CPU not available -> panic */
 	larl	%r15,init_thread_union
-	ahi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
+	aghi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
+	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r2,.Lpanic_string
-	lghi	%r1,0
-	sam31
-	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	brasl	%r14,sclp_early_printk
+	brasl	%r14,sclp_early_printk_force
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
diff --git a/drivers/s390/char/sclp_early_core.c b/drivers/s390/char/sclp_early_core.c
index eceba38..2f61f55 100644
--- a/drivers/s390/char/sclp_early_core.c
+++ b/drivers/s390/char/sclp_early_core.c
@@ -210,11 +210,11 @@ static int sclp_early_setup(int disable, int *have_linemode, int *have_vt220)
  * Output one or more lines of text on the SCLP console (VT220 and /
  * or line-mode).
  */
-void __sclp_early_printk(const char *str, unsigned int len)
+void __sclp_early_printk(const char *str, unsigned int len, unsigned int force)
 {
 	int have_linemode, have_vt220;
 
-	if (sclp_init_state != sclp_init_state_uninitialized)
+	if (!force && sclp_init_state != sclp_init_state_uninitialized)
 		return;
 	if (sclp_early_setup(0, &have_linemode, &have_vt220) != 0)
 		return;
@@ -227,5 +227,10 @@ void __sclp_early_printk(const char *str, unsigned int len)
 
 void sclp_early_printk(const char *str)
 {
-	__sclp_early_printk(str, strlen(str));
+	__sclp_early_printk(str, strlen(str), 0);
+}
+
+void sclp_early_printk_force(const char *str)
+{
+	__sclp_early_printk(str, strlen(str), 1);
 }
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index dbe7c7a..fd77e46 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -163,7 +163,7 @@ static bool pfn_array_table_iova_pinned(struct pfn_array_table *pat,
 
 	for (i = 0; i < pat->pat_nr; i++, pa++)
 		for (j = 0; j < pa->pa_nr; j++)
-			if (pa->pa_iova_pfn[i] == iova_pfn)
+			if (pa->pa_iova_pfn[j] == iova_pfn)
 				return true;
 
 	return false;
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 770fa9c..f47d16b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -22,6 +22,7 @@
 #include "vfio_ccw_private.h"
 
 struct workqueue_struct *vfio_ccw_work_q;
+struct kmem_cache *vfio_ccw_io_region;
 
 /*
  * Helpers
@@ -79,7 +80,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		cp_update_scsw(&private->cp, &irb->scsw);
 		cp_free(&private->cp);
 	}
-	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
+	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
@@ -114,6 +115,14 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
 	if (!private)
 		return -ENOMEM;
+
+	private->io_region = kmem_cache_zalloc(vfio_ccw_io_region,
+					       GFP_KERNEL | GFP_DMA);
+	if (!private->io_region) {
+		kfree(private);
+		return -ENOMEM;
+	}
+
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 
@@ -139,6 +148,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
+	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private);
 	return ret;
 }
@@ -153,6 +163,7 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	dev_set_drvdata(&sch->dev, NULL);
 
+	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private);
 
 	return 0;
@@ -232,10 +243,20 @@ static int __init vfio_ccw_sch_init(void)
 	if (!vfio_ccw_work_q)
 		return -ENOMEM;
 
+	vfio_ccw_io_region = kmem_cache_create_usercopy("vfio_ccw_io_region",
+					sizeof(struct ccw_io_region), 0,
+					SLAB_ACCOUNT, 0,
+					sizeof(struct ccw_io_region), NULL);
+	if (!vfio_ccw_io_region) {
+		destroy_workqueue(vfio_ccw_work_q);
+		return -ENOMEM;
+	}
+
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
 	if (ret) {
 		isc_unregister(VFIO_CCW_ISC);
+		kmem_cache_destroy(vfio_ccw_io_region);
 		destroy_workqueue(vfio_ccw_work_q);
 	}
 
@@ -246,6 +267,7 @@ static void __exit vfio_ccw_sch_exit(void)
 {
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
+	kmem_cache_destroy(vfio_ccw_io_region);
 	destroy_workqueue(vfio_ccw_work_q);
 }
 module_init(vfio_ccw_sch_init);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 797a827..f94aa01 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -93,13 +93,13 @@ static void fsm_io_error(struct vfio_ccw_private *private,
 			 enum vfio_ccw_event event)
 {
 	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
-	private->io_region.ret_code = -EIO;
+	private->io_region->ret_code = -EIO;
 }
 
 static void fsm_io_busy(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
-	private->io_region.ret_code = -EBUSY;
+	private->io_region->ret_code = -EBUSY;
 }
 
 static void fsm_disabled_irq(struct vfio_ccw_private *private,
@@ -126,7 +126,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 {
 	union orb *orb;
 	union scsw *scsw = &private->scsw;
-	struct ccw_io_region *io_region = &private->io_region;
+	struct ccw_io_region *io_region = private->io_region;
 	struct mdev_device *mdev = private->mdev;
 	char *errstr = "request";
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 41eeb57..f673e10 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -174,7 +174,7 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
 		return -EINVAL;
 
 	private = dev_get_drvdata(mdev_parent_dev(mdev));
-	region = &private->io_region;
+	region = private->io_region;
 	if (copy_to_user(buf, (void *)region + *ppos, count))
 		return -EFAULT;
 
@@ -196,7 +196,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if (private->state != VFIO_CCW_STATE_IDLE)
 		return -EACCES;
 
-	region = &private->io_region;
+	region = private->io_region;
 	if (copy_from_user((void *)region + *ppos, buf, count))
 		return -EFAULT;
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 78a66d9..078e46f 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -41,7 +41,7 @@ struct vfio_ccw_private {
 	atomic_t		avail;
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
-	struct ccw_io_region	io_region;
+	struct ccw_io_region	*io_region;
 
 	struct channel_program	cp;
 	struct irb		irb;
