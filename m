Return-Path: <linux-kernel-owner+w=401wt.eu-S1765214AbXLTP3o@vger.kernel.org>
Message-Id: <20071220152112.244337812@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:07 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 42/47] drivers/s390/: Spelling fixes
Content-Disposition: inline; filename=141-spelling-drivers.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_3990_erp.c |    2 +-
 drivers/s390/block/dasd_eckd.c     |    2 +-
 drivers/s390/char/sclp_rw.c        |    2 +-
 drivers/s390/char/tape_3590.c      |    2 +-
 drivers/s390/scsi/zfcp_erp.c       |    2 +-
 drivers/s390/scsi/zfcp_qdio.c      |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_3990_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_3990_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_3990_erp.c
@@ -2620,7 +2620,7 @@ dasd_3990_erp_handle_match_erp(struct da
  * DASD_3990_ERP_ACTION
  *
  * DESCRIPTION
- *   controll routine for 3990 erp actions.
+ *   control routine for 3990 erp actions.
  *   Has to be called with the queue lock (namely the s390_irq_lock) acquired.
  *
  * PARAMETER
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -1542,7 +1542,7 @@ dasd_eckd_performance(struct dasd_device
 	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
 	memset(prssdp, 0, sizeof (struct dasd_psf_prssd_data));
 	prssdp->order = PSF_ORDER_PRSSD;
-	prssdp->suborder = 0x01;	/* Perfomance Statistics */
+	prssdp->suborder = 0x01;	/* Performance Statistics */
 	prssdp->varies[1] = 0x01;	/* Perf Statistics for the Subsystem */
 
 	ccw = cqr->cpaddr;
Index: quilt-2.6/drivers/s390/char/sclp_rw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_rw.c
+++ quilt-2.6/drivers/s390/char/sclp_rw.c
@@ -76,7 +76,7 @@ sclp_make_buffer(void *page, unsigned sh
 }
 
 /*
- * Return a pointer to the orignal page that has been used to create
+ * Return a pointer to the original page that has been used to create
  * the buffer.
  */
 void *
Index: quilt-2.6/drivers/s390/char/tape_3590.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_3590.c
+++ quilt-2.6/drivers/s390/char/tape_3590.c
@@ -1495,7 +1495,7 @@ tape_3590_unit_check(struct tape_device 
 			   device->cdev->dev.bus_id);
 		return tape_3590_erp_basic(device, request, irb, -EPERM);
 	case 0x8013:
-		PRINT_WARN("(%s): Another host has priviliged access to the "
+		PRINT_WARN("(%s): Another host has privileged access to the "
 			   "tape device\n", device->cdev->dev.bus_id);
 		PRINT_WARN("(%s): To solve the problem unload the current "
 			   "cartridge!\n", device->cdev->dev.bus_id);
Index: quilt-2.6/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_erp.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_erp.c
@@ -1285,7 +1285,7 @@ zfcp_erp_strategy_do_action(struct zfcp_
 	 * note: no lock in subsequent strategy routines
 	 * (this allows these routine to call schedule, e.g.
 	 * kmalloc with such flags or qdio_initialize & friends)
-	 * Note: in case of timeout, the seperate strategies will fail
+	 * Note: in case of timeout, the separate strategies will fail
 	 * anyhow. No need for a special action. Even worse, a nameserver
 	 * failure would not wake up waiting ports without the call.
 	 */
Index: quilt-2.6/drivers/s390/scsi/zfcp_qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_qdio.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_qdio.c
@@ -529,7 +529,7 @@ zfcp_qdio_sbals_wipe(struct zfcp_fsf_req
 
 
 /**
- * zfcp_qdio_sbale_fill - set address and lenght in current SBALE
+ * zfcp_qdio_sbale_fill - set address and length in current SBALE
  *	on request_queue
  */
 static void

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
