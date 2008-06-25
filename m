Return-Path: <linux-kernel-owner+w=401wt.eu-S1756311AbYFYOgr@vger.kernel.org>
Message-Id: <20080625143611.484081597@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/21] Cleanup cio printk messages.
Content-Disposition: inline; filename=800-printk-cio-rm.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

Unnecessary dev_info, dev_warn and printk messages are removed.

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c    |    7 ++-----
 drivers/s390/cio/cio.c    |    3 +--
 drivers/s390/cio/cmf.c    |    9 ---------
 drivers/s390/cio/device.c |   18 ++++++++----------
 4 files changed, 11 insertions(+), 26 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -123,11 +123,8 @@ static int s390_vary_chpid(struct chp_id
 	CIO_TRACE_EVENT(2, dbf_text);
 
 	status = chp_get_status(chpid);
-	if (!on && !status) {
-		printk(KERN_ERR "cio: chpid %x.%02x is already offline\n",
-		       chpid.cssid, chpid.id);
-		return -EINVAL;
-	}
+	if (!on && !status)
+		return 0;
 
 	set_chp_logically_online(chpid, on);
 	chsc_chp_vary(chpid, on);
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -74,7 +74,6 @@ out_unregister:
 		debug_unregister(cio_debug_trace_id);
 	if (cio_debug_crw_id)
 		debug_unregister(cio_debug_crw_id);
-	printk(KERN_WARNING"cio: could not initialize debugging\n");
 	return -1;
 }
 
@@ -755,7 +754,6 @@ cio_get_console_sch_no(void)
 		/* unlike in 2.4, we cannot autoprobe here, since
 		 * the channel subsystem is not fully initialized.
 		 * With some luck, the HWC console can take over */
-		printk(KERN_WARNING "cio: No ccw console found!\n");
 		return -1;
 	}
 	return console_irq;
@@ -772,6 +770,7 @@ cio_probe_console(void)
 	sch_no = cio_get_console_sch_no();
 	if (sch_no == -1) {
 		console_subchannel_in_use = 0;
+		printk(KERN_WARNING "cio: No ccw console found!\n");
 		return ERR_PTR(-ENODEV);
 	}
 	memset(&console_subchannel, 0, sizeof(struct subchannel));
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -612,9 +612,6 @@ static int alloc_cmb(struct ccw_device *
 			free_pages((unsigned long)mem, get_order(size));
 		} else if (!mem) {
 			/* no luck */
-			printk(KERN_WARNING "cio: failed to allocate area "
-			       "for measuring %d subchannels\n",
-			       cmb_area.num_channels);
 			ret = -ENOMEM;
 			goto out;
 		} else {
@@ -1230,13 +1227,9 @@ static ssize_t cmb_enable_store(struct d
 	switch (val) {
 	case 0:
 		ret = disable_cmf(cdev);
-		if (ret)
-			dev_info(&cdev->dev, "disable_cmf failed (%d)\n", ret);
 		break;
 	case 1:
 		ret = enable_cmf(cdev);
-		if (ret && ret != -EBUSY)
-			dev_info(&cdev->dev, "enable_cmf failed (%d)\n", ret);
 		break;
 	}
 
@@ -1364,8 +1357,6 @@ static int __init init_cmf(void)
 		cmbops = &cmbops_extended;
 		break;
 	default:
-		printk(KERN_ERR "cio: Invalid format %d for channel "
-			"measurement facility\n", format);
 		return 1;
 	}
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -493,25 +493,22 @@ static int online_store_recog_and_online
 		ccw_device_set_online(cdev);
 	return 0;
 }
-static void online_store_handle_online(struct ccw_device *cdev, int force)
+static int online_store_handle_online(struct ccw_device *cdev, int force)
 {
 	int ret;
 
 	ret = online_store_recog_and_online(cdev);
 	if (ret)
-		return;
+		return ret;
 	if (force && cdev->private->state == DEV_STATE_BOXED) {
 		ret = ccw_device_stlck(cdev);
-		if (ret) {
-			dev_warn(&cdev->dev,
-				 "ccw_device_stlck returned %d!\n", ret);
-			return;
-		}
+		if (ret)
+			return ret;
 		if (cdev->id.cu_type == 0)
 			cdev->private->state = DEV_STATE_NOT_OPER;
 		online_store_recog_and_online(cdev);
 	}
-
+	return 0;
 }
 
 static ssize_t online_store (struct device *dev, struct device_attribute *attr,
@@ -544,8 +541,9 @@ static ssize_t online_store (struct devi
 		ret = count;
 		break;
 	case 1:
-		online_store_handle_online(cdev, force);
-		ret = count;
+		ret = online_store_handle_online(cdev, force);
+		if (!ret)
+			ret = count;
 		break;
 	default:
 		ret = -EINVAL;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
