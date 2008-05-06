Return-Path: <linux-kernel-owner+w=401wt.eu-S932147AbYEFQEA@vger.kernel.org>
Message-Id: <20080506155111.467007910@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/8] cio: Remove cio_msg kernel parameter.
Content-Disposition: inline; filename=003-cio-cio_msg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

The only sporadically used CIO_DEBUG messages are replaced by ordinary
CIO_MSG_EVENT messages. The CIO_MSG_EVENT messages debug levels are
consolidated. 

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/CommonIO    |   11 ----------
 drivers/s390/cio/blacklist.c   |    1 
 drivers/s390/cio/cio.c         |   39 +++++++++---------------------------
 drivers/s390/cio/cio.h         |    2 -
 drivers/s390/cio/cio_debug.h   |    6 -----
 drivers/s390/cio/css.c         |    4 +--
 drivers/s390/cio/device.c      |   25 +++++++++++------------
 drivers/s390/cio/device_fsm.c  |   44 ++++++++++++++++++++---------------------
 drivers/s390/cio/device_id.c   |    4 +--
 drivers/s390/cio/device_pgid.c |   12 +++++------
 10 files changed, 54 insertions(+), 94 deletions(-)

Index: quilt-2.6/Documentation/s390/CommonIO
===================================================================
--- quilt-2.6.orig/Documentation/s390/CommonIO
+++ quilt-2.6/Documentation/s390/CommonIO
@@ -8,17 +8,6 @@ Command line parameters
 
   Enable logging of debug information in case of ccw device timeouts.
 
-
-* cio_msg = yes | no
-  
-  Determines whether information on found devices and sensed device 
-  characteristics should be shown during startup or when new devices are
-  found, i. e. messages of the types "Detected device 0.0.4711 on subchannel
-  0.0.0042" and "SenseID: Device 0.0.4711 reports: ...".
-
-  Default is off.
-
-
 * cio_ignore = {all} |
 	       {<device> | <range of devices>} |
 	       {!<device> | !<range of devices>}
Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -199,7 +199,6 @@ blacklist_parse_parameters (char *str, r
 static int __init
 blacklist_setup (char *str)
 {
-	CIO_MSG_EVENT(6, "Reading blacklist parameters\n");
 	return blacklist_parse_parameters (str, add);
 }
 
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -39,23 +39,6 @@ debug_info_t *cio_debug_msg_id;
 debug_info_t *cio_debug_trace_id;
 debug_info_t *cio_debug_crw_id;
 
-int cio_show_msg;
-
-static int __init
-cio_setup (char *parm)
-{
-	if (!strcmp (parm, "yes"))
-		cio_show_msg = 1;
-	else if (!strcmp (parm, "no"))
-		cio_show_msg = 0;
-	else
-		printk(KERN_ERR "cio: cio_setup: "
-		       "invalid cio_msg parameter '%s'", parm);
-	return 1;
-}
-
-__setup ("cio_msg=", cio_setup);
-
 /*
  * Function: cio_debug_init
  * Initializes three debug logs for common I/O:
@@ -166,7 +149,7 @@ cio_start_handle_notoper(struct subchann
 
 	stsch (sch->schid, &sch->schib);
 
-	CIO_MSG_EVENT(0, "cio_start: 'not oper' status for "
+	CIO_MSG_EVENT(2, "cio_start: 'not oper' status for "
 		      "subchannel 0.%x.%04x!\n", sch->schid.ssid,
 		      sch->schid.sch_no);
 	sprintf(dbf_text, "no%s", sch->dev.bus_id);
@@ -567,10 +550,9 @@ cio_validate_subchannel (struct subchann
 	 * ... just being curious we check for non I/O subchannels
 	 */
 	if (sch->st != 0) {
-		CIO_DEBUG(KERN_INFO, 0,
-			  "Subchannel 0.%x.%04x reports "
-			  "non-I/O subchannel type %04X\n",
-			  sch->schid.ssid, sch->schid.sch_no, sch->st);
+		CIO_MSG_EVENT(4, "Subchannel 0.%x.%04x reports "
+			      "non-I/O subchannel type %04X\n",
+			      sch->schid.ssid, sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
 		err = sch->st;
 		goto out;
@@ -588,7 +570,7 @@ cio_validate_subchannel (struct subchann
 		 * This device must not be known to Linux. So we simply
 		 * say that there is no device and return ENODEV.
 		 */
-		CIO_MSG_EVENT(4, "Blacklisted device detected "
+		CIO_MSG_EVENT(6, "Blacklisted device detected "
 			      "at devno %04X, subchannel set %x\n",
 			      sch->schib.pmcw.dev, sch->schid.ssid);
 		err = -ENODEV;
@@ -601,12 +583,11 @@ cio_validate_subchannel (struct subchann
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 	sch->isc = 3;
 
-	CIO_DEBUG(KERN_INFO, 0,
-		  "Detected device %04x on subchannel 0.%x.%04X"
-		  " - PIM = %02X, PAM = %02X, POM = %02X\n",
-		  sch->schib.pmcw.dev, sch->schid.ssid,
-		  sch->schid.sch_no, sch->schib.pmcw.pim,
-		  sch->schib.pmcw.pam, sch->schib.pmcw.pom);
+	CIO_MSG_EVENT(6, "Detected device %04x on subchannel 0.%x.%04X "
+		      "- PIM = %02X, PAM = %02X, POM = %02X\n",
+		      sch->schib.pmcw.dev, sch->schid.ssid,
+		      sch->schid.sch_no, sch->schib.pmcw.pim,
+		      sch->schib.pmcw.pam, sch->schib.pmcw.pom);
 
 	/*
 	 * We now have to initially ...
Index: quilt-2.6/drivers/s390/cio/cio_debug.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio_debug.h
+++ quilt-2.6/drivers/s390/cio/cio_debug.h
@@ -31,10 +31,4 @@ static inline void CIO_HEX_EVENT(int lev
 	}
 }
 
-#define CIO_DEBUG(printk_level, event_level, msg...) do {	\
-		if (cio_show_msg)				\
-			printk(printk_level "cio: " msg);	\
-		CIO_MSG_EVENT(event_level, msg);		\
-	} while (0)
-
 #endif
Index: quilt-2.6/drivers/s390/cio/cio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.h
+++ quilt-2.6/drivers/s390/cio/cio.h
@@ -118,6 +118,4 @@ extern void *cio_get_console_priv(void);
 #define cio_get_console_priv() NULL
 #endif
 
-extern int cio_show_msg;
-
 #endif
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -570,7 +570,7 @@ static void reprobe_all(struct work_stru
 {
 	int ret;
 
-	CIO_MSG_EVENT(2, "reprobe start\n");
+	CIO_MSG_EVENT(4, "reprobe start\n");
 
 	need_reprobe = 0;
 	/* Make sure initial subchannel scan is done. */
@@ -578,7 +578,7 @@ static void reprobe_all(struct work_stru
 		   atomic_read(&ccw_device_init_count) == 0);
 	ret = for_each_subchannel_staged(NULL, reprobe_subchannel, NULL);
 
-	CIO_MSG_EVENT(2, "reprobe done (rc=%d, need_reprobe=%d)\n", ret,
+	CIO_MSG_EVENT(4, "reprobe done (rc=%d, need_reprobe=%d)\n", ret,
 		      need_reprobe);
 }
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -341,7 +341,7 @@ ccw_device_remove_disconnected(struct cc
 		rc = device_schedule_callback(&cdev->dev,
 					      ccw_device_remove_orphan_cb);
 		if (rc)
-			CIO_MSG_EVENT(2, "Couldn't unregister orphan "
+			CIO_MSG_EVENT(0, "Couldn't unregister orphan "
 				      "0.%x.%04x\n",
 				      cdev->private->dev_id.ssid,
 				      cdev->private->dev_id.devno);
@@ -351,7 +351,7 @@ ccw_device_remove_disconnected(struct cc
 	rc = device_schedule_callback(cdev->dev.parent,
 				      ccw_device_remove_sch_cb);
 	if (rc)
-		CIO_MSG_EVENT(2, "Couldn't unregister disconnected device "
+		CIO_MSG_EVENT(0, "Couldn't unregister disconnected device "
 			      "0.%x.%04x\n",
 			      cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno);
@@ -397,7 +397,7 @@ int ccw_device_set_offline(struct ccw_de
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else {
-		CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+		CIO_MSG_EVENT(0, "ccw_device_offline returned %d, "
 			      "device 0.%x.%04x\n",
 			      ret, cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno);
@@ -433,7 +433,7 @@ int ccw_device_set_online(struct ccw_dev
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else {
-		CIO_MSG_EVENT(2, "ccw_device_online returned %d, "
+		CIO_MSG_EVENT(0, "ccw_device_online returned %d, "
 			      "device 0.%x.%04x\n",
 			      ret, cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno);
@@ -451,7 +451,7 @@ int ccw_device_set_online(struct ccw_dev
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else
-		CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+		CIO_MSG_EVENT(0, "ccw_device_offline returned %d, "
 			      "device 0.%x.%04x\n",
 			      ret, cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno);
@@ -803,7 +803,7 @@ static void sch_attach_disconnected_devi
 	other_sch = to_subchannel(get_device(cdev->dev.parent));
 	ret = device_move(&cdev->dev, &sch->dev);
 	if (ret) {
-		CIO_MSG_EVENT(2, "Moving disconnected device 0.%x.%04x failed "
+		CIO_MSG_EVENT(0, "Moving disconnected device 0.%x.%04x failed "
 			      "(ret=%d)!\n", cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno, ret);
 		put_device(&other_sch->dev);
@@ -933,7 +933,7 @@ io_subchannel_register(struct work_struc
 			ret = device_reprobe(&cdev->dev);
 			if (ret)
 				/* We can't do much here. */
-				CIO_MSG_EVENT(2, "device_reprobe() returned"
+				CIO_MSG_EVENT(0, "device_reprobe() returned"
 					      " %d for 0.%x.%04x\n", ret,
 					      cdev->private->dev_id.ssid,
 					      cdev->private->dev_id.devno);
@@ -1086,7 +1086,7 @@ static void ccw_device_move_to_sch(struc
 	rc = device_move(&cdev->dev, &sch->dev);
 	mutex_unlock(&sch->reg_mutex);
 	if (rc) {
-		CIO_MSG_EVENT(2, "Moving device 0.%x.%04x to subchannel "
+		CIO_MSG_EVENT(0, "Moving device 0.%x.%04x to subchannel "
 			      "0.%x.%04x failed (ret=%d)!\n",
 			      cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno, sch->schid.ssid,
@@ -1446,8 +1446,7 @@ ccw_device_remove (struct device *dev)
 			wait_event(cdev->private->wait_q,
 				   dev_fsm_final_state(cdev));
 		else
-			//FIXME: we can't fail!
-			CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+			CIO_MSG_EVENT(0, "ccw_device_offline returned %d, "
 				      "device 0.%x.%04x\n",
 				      ret, cdev->private->dev_id.ssid,
 				      cdev->private->dev_id.devno);
@@ -1524,7 +1523,7 @@ static int recovery_check(struct device 
 	spin_lock_irq(cdev->ccwlock);
 	switch (cdev->private->state) {
 	case DEV_STATE_DISCONNECTED:
-		CIO_MSG_EVENT(3, "recovery: trigger 0.%x.%04x\n",
+		CIO_MSG_EVENT(4, "recovery: trigger 0.%x.%04x\n",
 			      cdev->private->dev_id.ssid,
 			      cdev->private->dev_id.devno);
 		dev_fsm_event(cdev, DEV_EVENT_VERIFY);
@@ -1554,7 +1553,7 @@ static void recovery_work_func(struct wo
 		}
 		spin_unlock_irq(&recovery_lock);
 	} else
-		CIO_MSG_EVENT(2, "recovery: end\n");
+		CIO_MSG_EVENT(4, "recovery: end\n");
 }
 
 static DECLARE_WORK(recovery_work, recovery_work_func);
@@ -1572,7 +1571,7 @@ void ccw_device_schedule_recovery(void)
 {
 	unsigned long flags;
 
-	CIO_MSG_EVENT(2, "recovery: schedule\n");
+	CIO_MSG_EVENT(4, "recovery: schedule\n");
 	spin_lock_irqsave(&recovery_lock, flags);
 	if (!timer_pending(&recovery_timer) || (recovery_phase != 0)) {
 		recovery_phase = 0;
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -322,10 +322,10 @@ ccw_device_recog_done(struct ccw_device 
 	same_dev = 0; /* Keep the compiler quiet... */
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
-		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : unknown device %04x on subchannel "
-			  "0.%x.%04x\n", cdev->private->dev_id.devno,
-			  sch->schid.ssid, sch->schid.sch_no);
+		CIO_MSG_EVENT(2, "SenseID : unknown device %04x on "
+			      "subchannel 0.%x.%04x\n",
+			      cdev->private->dev_id.devno,
+			      sch->schid.ssid, sch->schid.sch_no);
 		break;
 	case DEV_STATE_OFFLINE:
 		if (cdev->private->state == DEV_STATE_DISCONNECTED_SENSE_ID) {
@@ -348,20 +348,19 @@ ccw_device_recog_done(struct ccw_device 
 			return;
 		}
 		/* Issue device info message. */
-		CIO_DEBUG(KERN_INFO, 2,
-			  "SenseID : device 0.%x.%04x reports: "
-			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
-			  "%04X/%02X\n",
-			  cdev->private->dev_id.ssid,
-			  cdev->private->dev_id.devno,
-			  cdev->id.cu_type, cdev->id.cu_model,
-			  cdev->id.dev_type, cdev->id.dev_model);
+		CIO_MSG_EVENT(4, "SenseID : device 0.%x.%04x reports: "
+			      "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
+			      "%04X/%02X\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno,
+			      cdev->id.cu_type, cdev->id.cu_model,
+			      cdev->id.dev_type, cdev->id.dev_model);
 		break;
 	case DEV_STATE_BOXED:
-		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : boxed device %04x on subchannel "
-			  "0.%x.%04x\n", cdev->private->dev_id.devno,
-			  sch->schid.ssid, sch->schid.sch_no);
+		CIO_MSG_EVENT(0, "SenseID : boxed device %04x on "
+			      " subchannel 0.%x.%04x\n",
+			      cdev->private->dev_id.devno,
+			      sch->schid.ssid, sch->schid.sch_no);
 		break;
 	}
 	cdev->private->state = state;
@@ -443,9 +442,8 @@ ccw_device_done(struct ccw_device *cdev,
 
 
 	if (state == DEV_STATE_BOXED)
-		CIO_DEBUG(KERN_WARNING, 2,
-			  "Boxed device %04x on subchannel %04x\n",
-			  cdev->private->dev_id.devno, sch->schid.sch_no);
+		CIO_MSG_EVENT(0, "Boxed device %04x on subchannel %04x\n",
+			      cdev->private->dev_id.devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {
 		cdev->private->flags.donotify = 0;
@@ -900,7 +898,7 @@ ccw_device_w4sense(struct ccw_device *cd
 			/* Basic sense hasn't started. Try again. */
 			ccw_device_do_sense(cdev, irb);
 		else {
-			CIO_MSG_EVENT(2, "Huh? 0.%x.%04x: unsolicited "
+			CIO_MSG_EVENT(0, "0.%x.%04x: unsolicited "
 				      "interrupt during w4sense...\n",
 				      cdev->private->dev_id.ssid,
 				      cdev->private->dev_id.devno);
@@ -1169,8 +1167,10 @@ ccw_device_nop(struct ccw_device *cdev, 
 static void
 ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	CIO_MSG_EVENT(0, "dev_jumptable[%i][%i] == NULL\n",
-		      cdev->private->state, dev_event);
+	CIO_MSG_EVENT(0, "Internal state [%i][%i] not handled for device "
+		      "0.%x.%04x\n", cdev->private->state, dev_event,
+		      cdev->private->dev_id.ssid,
+		      cdev->private->dev_id.devno);
 	BUG();
 }
 
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -214,7 +214,7 @@ ccw_device_check_sense_id(struct ccw_dev
 		 *     sense id information. So, for intervention required,
 		 *     we use the "whack it until it talks" strategy...
 		 */
-		CIO_MSG_EVENT(2, "SenseID : device %04x on Subchannel "
+		CIO_MSG_EVENT(0, "SenseID : device %04x on Subchannel "
 			      "0.%x.%04x reports cmd reject\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no);
@@ -239,7 +239,7 @@ ccw_device_check_sense_id(struct ccw_dev
 
 		lpm = to_io_private(sch)->orb.lpm;
 		if ((lpm & sch->schib.pmcw.pim & sch->schib.pmcw.pam) != 0)
-			CIO_MSG_EVENT(2, "SenseID : path %02X for device %04x "
+			CIO_MSG_EVENT(4, "SenseID : path %02X for device %04x "
 				      "on subchannel 0.%x.%04x is "
 				      "'not operational'\n", lpm,
 				      cdev->private->dev_id.devno,
Index: quilt-2.6/drivers/s390/cio/device_pgid.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_pgid.c
+++ quilt-2.6/drivers/s390/cio/device_pgid.c
@@ -79,7 +79,7 @@ __ccw_device_sense_pgid_start(struct ccw
 			/* ret is 0, -EBUSY, -EACCES or -ENODEV */
 			if (ret != -EACCES)
 				return ret;
-			CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel "
+			CIO_MSG_EVENT(3, "SNID - Device %04x on Subchannel "
 				      "0.%x.%04x, lpm %02X, became 'not "
 				      "operational'\n",
 				      cdev->private->dev_id.devno,
@@ -159,7 +159,7 @@ __ccw_device_check_sense_pgid(struct ccw
 		u8 lpm;
 
 		lpm = to_io_private(sch)->orb.lpm;
-		CIO_MSG_EVENT(2, "SNID - Device %04x on Subchannel 0.%x.%04x,"
+		CIO_MSG_EVENT(3, "SNID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, lpm);
@@ -275,7 +275,7 @@ __ccw_device_do_pgid(struct ccw_device *
 			return ret;
 	}
 	/* PGID command failed on this path. */
-	CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel "
+	CIO_MSG_EVENT(3, "SPID - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
 		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no, cdev->private->imask);
@@ -317,7 +317,7 @@ static int __ccw_device_do_nop(struct cc
 			return ret;
 	}
 	/* nop command failed on this path. */
-	CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel "
+	CIO_MSG_EVENT(3, "NOP - Device %04x on Subchannel "
 		      "0.%x.%04x, lpm %02X, became 'not operational'\n",
 		      cdev->private->dev_id.devno, sch->schid.ssid,
 		      sch->schid.sch_no, cdev->private->imask);
@@ -362,7 +362,7 @@ __ccw_device_check_pgid(struct ccw_devic
 		return -EAGAIN;
 	}
 	if (irb->scsw.cc == 3) {
-		CIO_MSG_EVENT(2, "SPID - Device %04x on Subchannel 0.%x.%04x,"
+		CIO_MSG_EVENT(3, "SPID - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, cdev->private->imask);
@@ -391,7 +391,7 @@ static int __ccw_device_check_nop(struct
 		return -ETIME;
 	}
 	if (irb->scsw.cc == 3) {
-		CIO_MSG_EVENT(2, "NOP - Device %04x on Subchannel 0.%x.%04x,"
+		CIO_MSG_EVENT(3, "NOP - Device %04x on Subchannel 0.%x.%04x,"
 			      " lpm %02X, became 'not operational'\n",
 			      cdev->private->dev_id.devno, sch->schid.ssid,
 			      sch->schid.sch_no, cdev->private->imask);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
