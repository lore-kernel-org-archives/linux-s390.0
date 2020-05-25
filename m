Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36104 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389294AbgEYS0W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 May 2020 14:26:22 -0400
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 5/8] usb: phy: fsl: Use the new device_to_pm() helper to access struct dev_pm_ops
Date: Mon, 25 May 2020 18:26:05 +0000
Message-Id: <20200525182608.1823735-6-kw@linux.com>
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
 drivers/usb/phy/phy-fsl-usb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-fsl-usb.c b/drivers/usb/phy/phy-fsl-usb.c
index b451f4695f3f..3b9ad5db8380 100644
--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -460,6 +460,7 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
 	struct device *dev;
 	struct fsl_otg *otg_dev =
 		container_of(otg->usb_phy, struct fsl_otg, phy);
+	const struct dev_pm_ops *pm;
 	u32 retval = 0;
 
 	if (!otg->host)
@@ -479,8 +480,9 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
 		else {
 			otg_reset_controller();
 			VDBG("host on......\n");
-			if (dev->driver->pm && dev->driver->pm->resume) {
-				retval = dev->driver->pm->resume(dev);
+			pm = driver_to_pm(dev->driver);
+			if (pm && pm->resume) {
+				retval = pm->resume(dev);
 				if (fsm->id) {
 					/* default-b */
 					fsl_otg_drv_vbus(fsm, 1);
@@ -504,8 +506,9 @@ int fsl_otg_start_host(struct otg_fsm *fsm, int on)
 		else {
 			VDBG("host off......\n");
 			if (dev && dev->driver) {
-				if (dev->driver->pm && dev->driver->pm->suspend)
-					retval = dev->driver->pm->suspend(dev);
+				pm = driver_to_pm(dev->driver);
+				if (pm && pm->suspend)
+					retval = pm->suspend(dev);
 				if (fsm->id)
 					/* default-b */
 					fsl_otg_drv_vbus(fsm, 0);
-- 
2.26.2
