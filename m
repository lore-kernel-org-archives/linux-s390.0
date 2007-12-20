Return-Path: <linux-kernel-owner+w=401wt.eu-S1766004AbXLTPY1@vger.kernel.org>
Message-Id: <20071220152104.464452835@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/47] cio: Cleanup debug feature usage.
Content-Disposition: inline; filename=106-cio-s390dbf.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Cleanup cio_debug.h.
Also make CIO_DEBUG add the "cio:" prefix to the printk string
so that it isn't needed for the debug feature.
Fix outdated comments for cio_debug_init() and clean it up.
Enlarge cio_crw to the same size as cio_msg so we may actually
find some relevant information there.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c        |   38 ++++++++++++++++++--------------------
 drivers/s390/cio/cio_debug.h  |   22 +++++++++++-----------
 drivers/s390/cio/device_fsm.c |    8 ++++----
 3 files changed, 33 insertions(+), 35 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -56,39 +56,37 @@ __setup ("cio_msg=", cio_setup);
 
 /*
  * Function: cio_debug_init
- * Initializes three debug logs (under /proc/s390dbf) for common I/O:
- * - cio_msg logs the messages which are printk'ed when CONFIG_DEBUG_IO is on
+ * Initializes three debug logs for common I/O:
+ * - cio_msg logs generic cio messages
  * - cio_trace logs the calling of different functions
- * - cio_crw logs the messages which are printk'ed when CONFIG_DEBUG_CRW is on
- * debug levels depend on CONFIG_DEBUG_IO resp. CONFIG_DEBUG_CRW
+ * - cio_crw logs machine check related cio messages
  */
-static int __init
-cio_debug_init (void)
+static int __init cio_debug_init(void)
 {
-	cio_debug_msg_id = debug_register ("cio_msg", 16, 4, 16*sizeof (long));
+	cio_debug_msg_id = debug_register("cio_msg", 16, 4, 16 * sizeof(long));
 	if (!cio_debug_msg_id)
 		goto out_unregister;
-	debug_register_view (cio_debug_msg_id, &debug_sprintf_view);
-	debug_set_level (cio_debug_msg_id, 2);
-	cio_debug_trace_id = debug_register ("cio_trace", 16, 4, 16);
+	debug_register_view(cio_debug_msg_id, &debug_sprintf_view);
+	debug_set_level(cio_debug_msg_id, 2);
+	cio_debug_trace_id = debug_register("cio_trace", 16, 4, 16);
 	if (!cio_debug_trace_id)
 		goto out_unregister;
-	debug_register_view (cio_debug_trace_id, &debug_hex_ascii_view);
-	debug_set_level (cio_debug_trace_id, 2);
-	cio_debug_crw_id = debug_register ("cio_crw", 4, 4, 16*sizeof (long));
+	debug_register_view(cio_debug_trace_id, &debug_hex_ascii_view);
+	debug_set_level(cio_debug_trace_id, 2);
+	cio_debug_crw_id = debug_register("cio_crw", 16, 4, 16 * sizeof(long));
 	if (!cio_debug_crw_id)
 		goto out_unregister;
-	debug_register_view (cio_debug_crw_id, &debug_sprintf_view);
-	debug_set_level (cio_debug_crw_id, 2);
+	debug_register_view(cio_debug_crw_id, &debug_sprintf_view);
+	debug_set_level(cio_debug_crw_id, 4);
 	return 0;
 
 out_unregister:
 	if (cio_debug_msg_id)
-		debug_unregister (cio_debug_msg_id);
+		debug_unregister(cio_debug_msg_id);
 	if (cio_debug_trace_id)
-		debug_unregister (cio_debug_trace_id);
+		debug_unregister(cio_debug_trace_id);
 	if (cio_debug_crw_id)
-		debug_unregister (cio_debug_crw_id);
+		debug_unregister(cio_debug_crw_id);
 	printk(KERN_WARNING"cio: could not initialize debugging\n");
 	return -1;
 }
@@ -567,7 +565,7 @@ cio_validate_subchannel (struct subchann
 	 */
 	if (sch->st != 0) {
 		CIO_DEBUG(KERN_INFO, 0,
-			  "cio: Subchannel 0.%x.%04x reports "
+			  "Subchannel 0.%x.%04x reports "
 			  "non-I/O subchannel type %04X\n",
 			  sch->schid.ssid, sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
@@ -600,7 +598,7 @@ cio_validate_subchannel (struct subchann
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 
 	CIO_DEBUG(KERN_INFO, 0,
-		  "cio: Detected device %04x on subchannel 0.%x.%04X"
+		  "Detected device %04x on subchannel 0.%x.%04X"
 		  " - PIM = %02X, PAM = %02X, POM = %02X\n",
 		  sch->schib.pmcw.dev, sch->schid.ssid,
 		  sch->schid.sch_no, sch->schib.pmcw.pim,
Index: quilt-2.6/drivers/s390/cio/cio_debug.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio_debug.h
+++ quilt-2.6/drivers/s390/cio/cio_debug.h
@@ -8,20 +8,19 @@ extern debug_info_t *cio_debug_msg_id;
 extern debug_info_t *cio_debug_trace_id;
 extern debug_info_t *cio_debug_crw_id;
 
-#define CIO_TRACE_EVENT(imp, txt) do { \
+#define CIO_TRACE_EVENT(imp, txt) do {				\
 		debug_text_event(cio_debug_trace_id, imp, txt); \
 	} while (0)
 
-#define CIO_MSG_EVENT(imp, args...) do { \
-		debug_sprintf_event(cio_debug_msg_id, imp , ##args); \
+#define CIO_MSG_EVENT(imp, args...) do {				\
+		debug_sprintf_event(cio_debug_msg_id, imp , ##args);	\
 	} while (0)
 
-#define CIO_CRW_EVENT(imp, args...) do { \
-		debug_sprintf_event(cio_debug_crw_id, imp , ##args); \
+#define CIO_CRW_EVENT(imp, args...) do {				\
+		debug_sprintf_event(cio_debug_crw_id, imp , ##args);	\
 	} while (0)
 
-static inline void
-CIO_HEX_EVENT(int level, void *data, int length)
+static inline void CIO_HEX_EVENT(int level, void *data, int length)
 {
 	if (unlikely(!cio_debug_trace_id))
 		return;
@@ -32,9 +31,10 @@ CIO_HEX_EVENT(int level, void *data, int
 	}
 }
 
-#define CIO_DEBUG(printk_level,event_level,msg...) ({ \
-	if (cio_show_msg) printk(printk_level msg); \
-	CIO_MSG_EVENT (event_level, msg); \
-})
+#define CIO_DEBUG(printk_level, event_level, msg...) do {	\
+		if (cio_show_msg)				\
+			printk(printk_level "cio: " msg);	\
+		CIO_MSG_EVENT(event_level, msg);		\
+	} while (0)
 
 #endif
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -318,7 +318,7 @@ ccw_device_recog_done(struct ccw_device 
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "cio: SenseID : unknown device %04x on subchannel "
+			  "SenseID : unknown device %04x on subchannel "
 			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
@@ -344,7 +344,7 @@ ccw_device_recog_done(struct ccw_device 
 		}
 		/* Issue device info message. */
 		CIO_DEBUG(KERN_INFO, 2,
-			  "cio: SenseID : device 0.%x.%04x reports: "
+			  "SenseID : device 0.%x.%04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
 			  "%04X/%02X\n",
 			  cdev->private->dev_id.ssid,
@@ -354,7 +354,7 @@ ccw_device_recog_done(struct ccw_device 
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "cio: SenseID : boxed device %04x on subchannel "
+			  "SenseID : boxed device %04x on subchannel "
 			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
@@ -439,7 +439,7 @@ ccw_device_done(struct ccw_device *cdev,
 
 	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "cio: Boxed device %04x on subchannel %04x\n",
+			  "Boxed device %04x on subchannel %04x\n",
 			  cdev->private->dev_id.devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
