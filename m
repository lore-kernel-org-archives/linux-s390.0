Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45603 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389535AbgEYS01 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 May 2020 14:26:27 -0400
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 8/8] net/iucv: Use the new device_to_pm() helper to access struct dev_pm_ops
Date: Mon, 25 May 2020 18:26:08 +0000
Message-Id: <20200525182608.1823735-9-kw@linux.com>
In-Reply-To: <20200525182608.1823735-1-kw@linux.com>
References: <20200525182608.1823735-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org

Use the new device_to_pm() helper to access Power Management callbacs
(struct dev_pm_ops) for a particular device (struct device_driver).

No functional change intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 net/iucv/iucv.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 9a2d023842fe..1a3029ab7c1f 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -1836,23 +1836,23 @@ static void iucv_external_interrupt(struct ext_code ext_code,
 
 static int iucv_pm_prepare(struct device *dev)
 {
-	int rc = 0;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 
 #ifdef CONFIG_PM_DEBUG
 	printk(KERN_INFO "iucv_pm_prepare\n");
 #endif
-	if (dev->driver && dev->driver->pm && dev->driver->pm->prepare)
-		rc = dev->driver->pm->prepare(dev);
-	return rc;
+	return pm && pm->prepare ? pm->prepare(dev) : 0;
 }
 
 static void iucv_pm_complete(struct device *dev)
 {
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
+
 #ifdef CONFIG_PM_DEBUG
 	printk(KERN_INFO "iucv_pm_complete\n");
 #endif
-	if (dev->driver && dev->driver->pm && dev->driver->pm->complete)
-		dev->driver->pm->complete(dev);
+	if (pm && pm->complete)
+		pm->complete(dev);
 }
 
 /**
@@ -1883,6 +1883,7 @@ static int iucv_path_table_empty(void)
 static int iucv_pm_freeze(struct device *dev)
 {
 	int cpu;
+	const struct dev_pm_ops *pm;
 	struct iucv_irq_list *p, *n;
 	int rc = 0;
 
@@ -1902,8 +1903,9 @@ static int iucv_pm_freeze(struct device *dev)
 		}
 	}
 	iucv_pm_state = IUCV_PM_FREEZING;
-	if (dev->driver && dev->driver->pm && dev->driver->pm->freeze)
-		rc = dev->driver->pm->freeze(dev);
+	pm = driver_to_pm(dev->driver);
+	if (pm && pm->freeze)
+		rc = pm->freeze(dev);
 	if (iucv_path_table_empty())
 		iucv_disable();
 	return rc;
@@ -1919,6 +1921,7 @@ static int iucv_pm_freeze(struct device *dev)
  */
 static int iucv_pm_thaw(struct device *dev)
 {
+	const struct dev_pm_ops *pm;
 	int rc = 0;
 
 #ifdef CONFIG_PM_DEBUG
@@ -1938,8 +1941,9 @@ static int iucv_pm_thaw(struct device *dev)
 			/* enable interrupts on all cpus */
 			iucv_setmask_mp();
 	}
-	if (dev->driver && dev->driver->pm && dev->driver->pm->thaw)
-		rc = dev->driver->pm->thaw(dev);
+	pm = driver_to_pm(dev->driver);
+	if (pm && pm->thaw)
+		rc = pm->thaw(dev);
 out:
 	return rc;
 }
@@ -1954,6 +1958,7 @@ static int iucv_pm_thaw(struct device *dev)
  */
 static int iucv_pm_restore(struct device *dev)
 {
+	const struct dev_pm_ops *pm;
 	int rc = 0;
 
 #ifdef CONFIG_PM_DEBUG
@@ -1968,8 +1973,9 @@ static int iucv_pm_restore(struct device *dev)
 		if (rc)
 			goto out;
 	}
-	if (dev->driver && dev->driver->pm && dev->driver->pm->restore)
-		rc = dev->driver->pm->restore(dev);
+	pm = driver_to_pm(dev->driver);
+	if (pm && pm->restore)
+		rc = pm->restore(dev);
 out:
 	return rc;
 }
-- 
2.26.2
