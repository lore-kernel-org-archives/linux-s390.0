Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46901 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbgEYS0U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 May 2020 14:26:20 -0400
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 4/8] scsi: pm: Use the new device_to_pm() helper to access struct dev_pm_ops
Date: Mon, 25 May 2020 18:26:04 +0000
Message-Id: <20200525182608.1823735-5-kw@linux.com>
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
 drivers/scsi/scsi_pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 5f0ad8b32e3a..8f40b60d3383 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -53,7 +53,7 @@ static int do_scsi_restore(struct device *dev, const struct dev_pm_ops *pm)
 static int scsi_dev_type_suspend(struct device *dev,
 		int (*cb)(struct device *, const struct dev_pm_ops *))
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 	int err;
 
 	/* flush pending in-flight resume operations, suspend is synchronous */
@@ -72,7 +72,7 @@ static int scsi_dev_type_suspend(struct device *dev,
 static int scsi_dev_type_resume(struct device *dev,
 		int (*cb)(struct device *, const struct dev_pm_ops *))
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 	int err = 0;
 
 	err = cb(dev, pm);
@@ -232,7 +232,7 @@ static int scsi_bus_restore(struct device *dev)
 
 static int sdev_runtime_suspend(struct device *dev)
 {
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 	struct scsi_device *sdev = to_scsi_device(dev);
 	int err = 0;
 
@@ -262,7 +262,7 @@ static int scsi_runtime_suspend(struct device *dev)
 static int sdev_runtime_resume(struct device *dev)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
-	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
 	int err = 0;
 
 	blk_pre_runtime_resume(sdev->request_queue);
-- 
2.26.2
