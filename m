Return-Path: <linux-kernel-owner+w=401wt.eu-S1754986AbYJAJAc@vger.kernel.org>
Message-Id: <20081001084126.029527114@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/21] cio: introduce purge function for /proc/cio_ignore
Content-Disposition: inline; filename=102-cio-purge.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Allow users to remove blacklisted ccw devices by using the
/proc/cio_ignore interface:

  echo purge > /proc/cio_ignore

will remove all devices which are offline and blacklisted.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c |   11 +++++++----
 drivers/s390/cio/device.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/device.h    |    1 +
 3 files changed, 48 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -24,6 +24,7 @@
 #include "cio.h"
 #include "cio_debug.h"
 #include "css.h"
+#include "device.h"
 
 /*
  * "Blacklisting" of certain devices:
@@ -191,9 +192,9 @@ static int blacklist_parse_parameters(ch
 			rc = blacklist_range(ra, from_ssid, to_ssid, from, to,
 					     msgtrigger);
 			if (rc)
-				totalrc = 1;
+				totalrc = -EINVAL;
 		} else
-			totalrc = 1;
+			totalrc = -EINVAL;
 	}
 
 	return totalrc;
@@ -240,8 +241,10 @@ static int blacklist_parse_proc_paramete
 		rc = blacklist_parse_parameters(buf, free, 0);
 	else if (strcmp("add", parm) == 0)
 		rc = blacklist_parse_parameters(buf, add, 0);
+	else if (strcmp("purge", parm) == 0)
+		return ccw_purge_blacklisted();
 	else
-		return 1;
+		return -EINVAL;
 
 	css_schedule_reprobe();
 
@@ -353,7 +356,7 @@ cio_ignore_write(struct file *file, cons
 	}
 	ret = blacklist_parse_proc_parameters(buf);
 	if (ret)
-		rc = -EINVAL;
+		rc = ret;
 	else
 		rc = user_len;
 
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -31,6 +31,7 @@
 #include "device.h"
 #include "ioasm.h"
 #include "io_sch.h"
+#include "blacklist.h"
 
 static struct timer_list recovery_timer;
 static DEFINE_SPINLOCK(recovery_lock);
@@ -1470,6 +1471,45 @@ static void ccw_device_schedule_recovery
 	spin_unlock_irqrestore(&recovery_lock, flags);
 }
 
+static int purge_fn(struct device *dev, void *data)
+{
+	struct ccw_device *cdev = to_ccwdev(dev);
+	struct ccw_device_private *priv = cdev->private;
+	int unreg;
+
+	spin_lock_irq(cdev->ccwlock);
+	unreg = is_blacklisted(priv->dev_id.ssid, priv->dev_id.devno) &&
+		(priv->state == DEV_STATE_OFFLINE);
+	spin_unlock_irq(cdev->ccwlock);
+	if (!unreg)
+		goto out;
+	if (!get_device(&cdev->dev))
+		goto out;
+	CIO_MSG_EVENT(3, "ccw: purging 0.%x.%04x\n", priv->dev_id.ssid,
+		      priv->dev_id.devno);
+	PREPARE_WORK(&cdev->private->kick_work, ccw_device_call_sch_unregister);
+	queue_work(slow_path_wq, &cdev->private->kick_work);
+
+out:
+	/* Abort loop in case of pending signal. */
+	if (signal_pending(current))
+		return -EINTR;
+
+	return 0;
+}
+
+/**
+ * ccw_purge_blacklisted - purge unused, blacklisted devices
+ *
+ * Unregister all ccw devices that are offline and on the blacklist.
+ */
+int ccw_purge_blacklisted(void)
+{
+	CIO_MSG_EVENT(2, "ccw: purging blacklisted devices\n");
+	bus_for_each_dev(&ccw_bus_type, NULL, NULL, purge_fn);
+	return 0;
+}
+
 static void device_set_disconnected(struct ccw_device *cdev)
 {
 	if (!cdev)
Index: quilt-2.6/drivers/s390/cio/device.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.h
+++ quilt-2.6/drivers/s390/cio/device.h
@@ -86,6 +86,7 @@ int ccw_device_is_orphan(struct ccw_devi
 int ccw_device_recognition(struct ccw_device *);
 int ccw_device_online(struct ccw_device *);
 int ccw_device_offline(struct ccw_device *);
+int ccw_purge_blacklisted(void);
 
 /* Function prototypes for device status and basic sense stuff. */
 void ccw_device_accumulate_irb(struct ccw_device *, struct irb *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
