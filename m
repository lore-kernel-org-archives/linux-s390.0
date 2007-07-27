Return-Path: <linux-kernel-owner+w=401wt.eu-S936870AbXG0Ldy@vger.kernel.org>
Message-Id: <20070727113600.720445019@de.ibm.com>
References: <20070727113348.413110503@de.ibm.com>
Date: Fri, 27 Jul 2007 13:33:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] cio: Clean up messages.
Content-Disposition: inline; filename=012-cio-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

- Remove unneeded messages.
- Move some messages into the debug feature.
- Use dev_* where appropriate.
- Use "cio: " prefix consistently.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c  |   19 +++++--------
 drivers/s390/cio/ccwgroup.c   |    3 --
 drivers/s390/cio/chp.c        |   19 ++-----------
 drivers/s390/cio/chsc.c       |   16 +++++------
 drivers/s390/cio/cio.c        |   13 ++++-----
 drivers/s390/cio/cmf.c        |   16 +++++------
 drivers/s390/cio/css.c        |   11 +++----
 drivers/s390/cio/device.c     |   60 ++++++++++++++++++++++++++----------------
 drivers/s390/cio/device_fsm.c |   20 +++++++-------
 9 files changed, 87 insertions(+), 90 deletions(-)

Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -51,7 +51,7 @@ blacklist_range (range_action action, un
 		to = from;
 
 	if (from > to || to > __MAX_SUBCHANNEL || ssid > __MAX_SSID) {
-		printk (KERN_WARNING "Invalid blacklist range "
+		printk (KERN_WARNING "cio: Invalid blacklist range "
 			"0.%x.%04x to 0.%x.%04x, skipping\n",
 			ssid, from, ssid, to);
 		return;
@@ -119,7 +119,7 @@ blacklist_busid(char **str, int *id0, in
 	return 0;
 confused:
 	strsep(str, ",\n");
-	printk(KERN_WARNING "Invalid cio_ignore parameter '%s'\n", sav);
+	printk(KERN_WARNING "cio: Invalid cio_ignore parameter '%s'\n", sav);
 	return 1;
 }
 
@@ -166,22 +166,19 @@ blacklist_parse_parameters (char *str, r
 					continue;
 			}
 			if (*str == '-') {
-				printk(KERN_WARNING "invalid cio_ignore "
+				printk(KERN_WARNING "cio: invalid cio_ignore "
 					"parameter '%s'\n",
 					strsep(&str, ",\n"));
 				continue;
 			}
 			if ((from_id0 != to_id0) ||
 			    (from_ssid != to_ssid)) {
-				printk(KERN_WARNING "invalid cio_ignore range "
-					"%x.%x.%04x-%x.%x.%04x\n",
-					from_id0, from_ssid, from,
-					to_id0, to_ssid, to);
+				printk(KERN_WARNING "cio: invalid cio_ignore "
+				       "range %x.%x.%04x-%x.%x.%04x\n",
+				       from_id0, from_ssid, from,
+				       to_id0, to_ssid, to);
 				continue;
 			}
-			pr_debug("blacklist_setup: adding range "
-				 "from %x.%x.%04x to %x.%x.%04x\n",
-				 from_id0, from_ssid, from, to_id0, to_ssid, to);
 			blacklist_range (ra, from, to, to_ssid);
 		}
 	}
@@ -239,7 +236,7 @@ blacklist_parse_proc_parameters (char *b
 		 */
 		blacklist_parse_parameters (buf + 4, add);
 	} else {
-		printk (KERN_WARNING "cio_ignore: Parse error; \n"
+		printk (KERN_WARNING "cio: cio_ignore: Parse error; \n"
 			KERN_WARNING "try using 'free all|<devno-range>,"
 				     "<devno-range>,...'\n"
 			KERN_WARNING "or 'add <devno-range>,"
Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -359,7 +359,6 @@ ccwgroup_probe (struct device *dev)
 	if ((ret = device_create_file(dev, &dev_attr_online)))
 		return ret;
 
-	pr_debug("%s: device %s\n", __func__, gdev->dev.bus_id);
 	ret = gdrv->probe ? gdrv->probe(gdev) : -ENODEV;
 	if (ret)
 		device_remove_file(dev, &dev_attr_online);
@@ -376,8 +375,6 @@ ccwgroup_remove (struct device *dev)
 	gdev = to_ccwgroupdev(dev);
 	gdrv = to_ccwgroupdrv(dev->driver);
 
-	pr_debug("%s: device %s\n", __func__, gdev->dev.bus_id);
-
 	device_remove_file(dev, &dev_attr_online);
 
 	if (gdrv && gdrv->remove)
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -121,14 +121,8 @@ static int s390_vary_chpid(struct chp_id
 	CIO_TRACE_EVENT( 2, dbf_text);
 
 	status = chp_get_status(chpid);
-	if (status < 0) {
-		printk(KERN_ERR "Can't vary unknown chpid %x.%02x\n",
-		       chpid.cssid, chpid.id);
-		return -EINVAL;
-	}
-
 	if (!on && !status) {
-		printk(KERN_ERR "chpid %x.%02x is already offline\n",
+		printk(KERN_ERR "cio: chpid %x.%02x is already offline\n",
 		       chpid.cssid, chpid.id);
 		return -EINVAL;
 	}
@@ -421,21 +415,14 @@ int chp_new(struct chp_id chpid)
 		if (ret)
 			goto out_free;
 	} else {
-		static int msg_done;
-
-		if (!msg_done) {
-			printk(KERN_WARNING "cio: Channel measurements not "
-			       "available, continuing.\n");
-			msg_done = 1;
-		}
 		chp->cmg = -1;
 	}
 
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
 	if (ret) {
-		printk(KERN_WARNING "%s: could not register %x.%02x\n",
-		       __func__, chpid.cssid, chpid.id);
+		CIO_MSG_EVENT(0, "Could not register chp%x.%02x: %d\n",
+			      chpid.cssid, chpid.id, ret);
 		goto out_free;
 	}
 	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -995,8 +995,8 @@ chsc_alloc_sei_area(void)
 {
 	sei_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sei_page)
-		printk(KERN_WARNING"Can't allocate page for processing of " \
-		       "chsc machine checks!\n");
+		CIO_MSG_EVENT(0, "Can't allocate page for processing of "
+			      "chsc machine checks!\n");
 	return (sei_page ? 0 : -ENOMEM);
 }
 
@@ -1073,8 +1073,8 @@ chsc_determine_css_characteristics(void)
 
 	scsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scsc_area) {
-	        printk(KERN_WARNING"cio: Was not able to determine available" \
-		       "CHSCs due to no memory.\n");
+		CIO_MSG_EVENT(0, "Was not able to determine available"
+			      "CHSCs due to no memory.\n");
 		return -ENOMEM;
 	}
 
@@ -1083,15 +1083,15 @@ chsc_determine_css_characteristics(void)
 
 	result = chsc(scsc_area);
 	if (result) {
-		printk(KERN_WARNING"cio: Was not able to determine " \
-		       "available CHSCs, cc=%i.\n", result);
+		CIO_MSG_EVENT(0, "Was not able to determine available CHSCs, "
+			      "cc=%i.\n", result);
 		result = -EIO;
 		goto exit;
 	}
 
 	if (scsc_area->response.code != 1) {
-		printk(KERN_WARNING"cio: Was not able to determine " \
-		       "available CHSCs.\n");
+		CIO_MSG_EVENT(0, "Was not able to determine "
+			      "available CHSCs.\n");
 		result = -EIO;
 		goto exit;
 	}
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -47,8 +47,8 @@ cio_setup (char *parm)
 	else if (!strcmp (parm, "no"))
 		cio_show_msg = 0;
 	else
-		printk (KERN_ERR "cio_setup : invalid cio_msg parameter '%s'",
-			parm);
+		printk(KERN_ERR "cio: cio_setup: "
+		       "invalid cio_msg parameter '%s'", parm);
 	return 1;
 }
 
@@ -80,7 +80,6 @@ cio_debug_init (void)
 		goto out_unregister;
 	debug_register_view (cio_debug_crw_id, &debug_sprintf_view);
 	debug_set_level (cio_debug_crw_id, 2);
-	pr_debug("debugging initialized\n");
 	return 0;
 
 out_unregister:
@@ -90,7 +89,7 @@ out_unregister:
 		debug_unregister (cio_debug_trace_id);
 	if (cio_debug_crw_id)
 		debug_unregister (cio_debug_crw_id);
-	pr_debug("could not initialize debugging\n");
+	printk(KERN_WARNING"cio: could not initialize debugging\n");
 	return -1;
 }
 
@@ -568,7 +567,7 @@ cio_validate_subchannel (struct subchann
 	 */
 	if (sch->st != 0) {
 		CIO_DEBUG(KERN_INFO, 0,
-			  "Subchannel 0.%x.%04x reports "
+			  "cio: Subchannel 0.%x.%04x reports "
 			  "non-I/O subchannel type %04X\n",
 			  sch->schid.ssid, sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
@@ -601,7 +600,7 @@ cio_validate_subchannel (struct subchann
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 
 	CIO_DEBUG(KERN_INFO, 0,
-		  "Detected device %04x on subchannel 0.%x.%04X"
+		  "cio: Detected device %04x on subchannel 0.%x.%04X"
 		  " - PIM = %02X, PAM = %02X, POM = %02X\n",
 		  sch->schib.pmcw.dev, sch->schid.ssid,
 		  sch->schid.sch_no, sch->schib.pmcw.pim,
@@ -766,7 +765,7 @@ cio_get_console_sch_no(void)
 		/* unlike in 2.4, we cannot autoprobe here, since
 		 * the channel subsystem is not fully initialized.
 		 * With some luck, the HWC console can take over */
-		printk(KERN_WARNING "No ccw console found!\n");
+		printk(KERN_WARNING "cio: No ccw console found!\n");
 		return -1;
 	}
 	return console_irq;
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -1185,12 +1185,12 @@ static ssize_t cmb_enable_store(struct d
 	case '0':
 		ret = disable_cmf(cdev);
 		if (ret)
-			printk(KERN_INFO "disable_cmf failed (%d)\n", ret);
+			dev_info(&cdev->dev, "disable_cmf failed (%d)\n", ret);
 		break;
 	case '1':
 		ret = enable_cmf(cdev);
 		if (ret && ret != -EBUSY)
-			printk(KERN_INFO "enable_cmf failed (%d)\n", ret);
+			dev_info(&cdev->dev, "enable_cmf failed (%d)\n", ret);
 		break;
 	}
 
@@ -1280,10 +1280,10 @@ init_cmf(void)
 		format_string = "basic";
 		cmbops = &cmbops_basic;
 		if (cmb_area.num_channels > 4096 || cmb_area.num_channels < 1) {
-			printk(KERN_ERR "Basic channel measurement facility"
-					" can only use 1 to 4096 devices\n"
+			printk(KERN_ERR "cio: Basic channel measurement "
+			       "facility can only use 1 to 4096 devices\n"
 			       KERN_ERR "when the cmf driver is built"
-					" as a loadable module\n");
+			       " as a loadable module\n");
 			return 1;
 		}
 		break;
@@ -1292,13 +1292,13 @@ init_cmf(void)
 		cmbops = &cmbops_extended;
 		break;
 	default:
-		printk(KERN_ERR "Invalid format %d for channel "
+		printk(KERN_ERR "cio: Invalid format %d for channel "
 			"measurement facility\n", format);
 		return 1;
 	}
 
-	printk(KERN_INFO "Channel measurement facility using %s format (%s)\n",
-		format_string, detect_string);
+	printk(KERN_INFO "cio: Channel measurement facility using %s "
+	       "format (%s)\n", format_string, detect_string);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -184,8 +184,8 @@ static int css_register_subchannel(struc
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
 	if (ret) {
-		printk (KERN_WARNING "%s: could not register %s\n",
-			__func__, sch->dev.bus_id);
+		CIO_MSG_EVENT(0, "Could not register sch 0.%x.%04x: %d\n",
+			      sch->schid.ssid, sch->schid.sch_no, ret);
 		return ret;
 	}
 	return ret;
@@ -371,8 +371,7 @@ static int __init slow_subchannel_init(v
 	spin_lock_init(&slow_subchannel_lock);
 	slow_subchannel_set = idset_sch_new();
 	if (!slow_subchannel_set) {
-		printk(KERN_WARNING "cio: could not allocate slow subchannel "
-		       "set\n");
+		CIO_MSG_EVENT(0, "could not allocate slow subchannel set\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -425,8 +424,8 @@ static int reprobe_subchannel(struct sub
 	struct subchannel *sch;
 	int ret;
 
-	CIO_DEBUG(KERN_INFO, 6, "cio: reprobe 0.%x.%04x\n",
-		  schid.ssid, schid.sch_no);
+	CIO_MSG_EVENT(6, "cio: reprobe 0.%x.%04x\n",
+		      schid.ssid, schid.sch_no);
 	if (need_reprobe)
 		return -EAGAIN;
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -338,15 +338,20 @@ ccw_device_remove_disconnected(struct cc
 		rc = device_schedule_callback(&cdev->dev,
 					      ccw_device_remove_orphan_cb);
 		if (rc)
-			dev_info(&cdev->dev, "Couldn't unregister orphan\n");
+			CIO_MSG_EVENT(2, "Couldn't unregister orphan "
+				      "0.%x.%04x\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno);
 		return;
 	}
 	/* Deregister subchannel, which will kill the ccw device. */
 	rc = device_schedule_callback(cdev->dev.parent,
 				      ccw_device_remove_sch_cb);
 	if (rc)
-		dev_info(&cdev->dev,
-			 "Couldn't unregister disconnected device\n");
+		CIO_MSG_EVENT(2, "Couldn't unregister disconnected device "
+			      "0.%x.%04x\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 }
 
 int
@@ -379,8 +384,10 @@ ccw_device_set_offline(struct ccw_device
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else {
-		pr_debug("ccw_device_offline returned %d, device %s\n",
-			 ret, cdev->dev.bus_id);
+		CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+			      "device 0.%x.%04x\n",
+			      ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 		cdev->online = 1;
 	}
  	return ret;
@@ -402,8 +409,10 @@ ccw_device_set_online(struct ccw_device 
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else {
-		pr_debug("ccw_device_online returned %d, device %s\n",
-			 ret, cdev->dev.bus_id);
+		CIO_MSG_EVENT(2, "ccw_device_online returned %d, "
+			      "device 0.%x.%04x\n",
+			      ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 		return ret;
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE)
@@ -417,9 +426,11 @@ ccw_device_set_online(struct ccw_device 
 	spin_unlock_irq(cdev->ccwlock);
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-	else 
-		pr_debug("ccw_device_offline returned %d, device %s\n",
-			 ret, cdev->dev.bus_id);
+	else
+		CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+			      "device 0.%x.%04x\n",
+			      ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 	return (ret == 0) ? -ENODEV : ret;
 }
 
@@ -439,9 +450,10 @@ static int online_store_recog_and_online
 	if (cdev->id.cu_type == 0) {
 		ret = ccw_device_recognition(cdev);
 		if (ret) {
-			printk(KERN_WARNING"Couldn't start recognition "
-			       "for device %s (ret=%d)\n",
-			       cdev->dev.bus_id, ret);
+			CIO_MSG_EVENT(0, "Couldn't start recognition "
+				      "for device 0.%x.%04x (ret=%d)\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno, ret);
 			return ret;
 		}
 		wait_event(cdev->private->wait_q,
@@ -461,8 +473,8 @@ static void online_store_handle_online(s
 	if (force && cdev->private->state == DEV_STATE_BOXED) {
 		ret = ccw_device_stlck(cdev);
 		if (ret) {
-			printk(KERN_WARNING"ccw_device_stlck for device %s "
-			       "returned %d!\n", cdev->dev.bus_id, ret);
+			dev_warn(&cdev->dev,
+				 "ccw_device_stlck returned %d!\n", ret);
 			return;
 		}
 		if (cdev->id.cu_type == 0)
@@ -893,8 +905,10 @@ io_subchannel_register(struct work_struc
 			ret = device_reprobe(&cdev->dev);
 			if (ret)
 				/* We can't do much here. */
-				dev_info(&cdev->dev, "device_reprobe() returned"
-					 " %d\n", ret);
+				CIO_MSG_EVENT(2, "device_reprobe() returned"
+					      " %d for 0.%x.%04x\n", ret,
+					      cdev->private->dev_id.ssid,
+					      cdev->private->dev_id.devno);
 		}
 		goto out;
 	}
@@ -907,8 +921,9 @@ io_subchannel_register(struct work_struc
 	/* make it known to the system */
 	ret = ccw_device_register(cdev);
 	if (ret) {
-		printk (KERN_WARNING "%s: could not register %s\n",
-			__func__, cdev->dev.bus_id);
+		CIO_MSG_EVENT(0, "Could not register ccw dev 0.%x.%04x: %d\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno, ret);
 		put_device(&cdev->dev);
 		spin_lock_irqsave(sch->lock, flags);
 		sch->dev.driver_data = NULL;
@@ -1361,7 +1376,6 @@ ccw_device_remove (struct device *dev)
 	struct ccw_driver *cdrv = cdev->drv;
 	int ret;
 
-	pr_debug("removing device %s\n", cdev->dev.bus_id);
 	if (cdrv->remove)
 		cdrv->remove(cdev);
 	if (cdev->online) {
@@ -1374,8 +1388,10 @@ ccw_device_remove (struct device *dev)
 				   dev_fsm_final_state(cdev));
 		else
 			//FIXME: we can't fail!
-			pr_debug("ccw_device_offline returned %d, device %s\n",
-				 ret, cdev->dev.bus_id);
+			CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+				      "device 0.%x.%04x\n",
+				      ret, cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno);
 	}
 	ccw_device_set_timeout(cdev, 0);
 	cdev->drv = NULL;
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c
+++ quilt-2.6/drivers/s390/cio/device_fsm.c
@@ -268,7 +268,7 @@ ccw_device_recog_done(struct ccw_device 
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : unknown device %04x on subchannel "
+			  "cio: SenseID : unknown device %04x on subchannel "
 			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
@@ -293,7 +293,8 @@ ccw_device_recog_done(struct ccw_device 
 			return;
 		}
 		/* Issue device info message. */
-		CIO_DEBUG(KERN_INFO, 2, "SenseID : device 0.%x.%04x reports: "
+		CIO_DEBUG(KERN_INFO, 2,
+			  "cio: SenseID : device 0.%x.%04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
 			  "%04X/%02X\n",
 			  cdev->private->dev_id.ssid,
@@ -303,7 +304,7 @@ ccw_device_recog_done(struct ccw_device 
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : boxed device %04x on subchannel "
+			  "cio: SenseID : boxed device %04x on subchannel "
 			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
@@ -388,7 +389,7 @@ ccw_device_done(struct ccw_device *cdev,
 
 	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "Boxed device %04x on subchannel %04x\n",
+			  "cio: Boxed device %04x on subchannel %04x\n",
 			  cdev->private->dev_id.devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {
@@ -946,9 +947,10 @@ ccw_device_w4sense(struct ccw_device *cd
 			/* Basic sense hasn't started. Try again. */
 			ccw_device_do_sense(cdev, irb);
 		else {
-			printk(KERN_INFO "Huh? %s(%s): unsolicited "
-			       "interrupt...\n",
-			       __FUNCTION__, cdev->dev.bus_id);
+			CIO_MSG_EVENT(2, "Huh? 0.%x.%04x: unsolicited "
+				      "interrupt during w4sense...\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno);
 			if (cdev->handler)
 				cdev->handler (cdev, 0, irb);
 		}
@@ -1215,8 +1217,8 @@ ccw_device_nop(struct ccw_device *cdev, 
 static void
 ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	printk(KERN_EMERG "dev_jumptable[%i][%i] == NULL\n",
-	       cdev->private->state, dev_event);
+	CIO_MSG_EVENT(0, "dev_jumptable[%i][%i] == NULL\n",
+		      cdev->private->state, dev_event);
 	BUG();
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
