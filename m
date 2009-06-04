Return-Path: <linux-kernel-owner+w=401wt.eu-S1759940AbZFDQ2k@vger.kernel.org>
Message-Id: <20090604161902.814661884@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/38] cio: force console function
Content-Disposition: inline; filename=pm_force_console.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

If something goes wrong in a suspend / resume cycle a ccw based console
if very likely in the suspended state and cannot print anything.
Introduce ccw_device_force_console to force the wake up of the console
device to be able to print the oops message. The console device drivers
should use this function only if the system paniced.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/ccwdev.h |    1 +
 drivers/s390/cio/device.c      |    8 ++++++++
 2 files changed, 9 insertions(+)

Index: linux-2.5/drivers/s390/cio/device.c
===================================================================
--- linux-2.5.orig/drivers/s390/cio/device.c
+++ linux-2.5/drivers/s390/cio/device.c
@@ -1785,6 +1785,15 @@ ccw_device_probe_console(void)
 	return &console_cdev;
 }
 
+static int ccw_device_pm_restore(struct device *dev);
+
+int ccw_device_force_console(void)
+{
+	if (!console_cdev_in_use)
+		return -ENODEV;
+	return ccw_device_pm_restore(&console_cdev.dev);
+}
+EXPORT_SYMBOL_GPL(ccw_device_force_console);
 
 const char *cio_get_console_cdev_name(struct subchannel *sch)
 {
Index: linux-2.5/arch/s390/include/asm/ccwdev.h
===================================================================
--- linux-2.5.orig/arch/s390/include/asm/ccwdev.h
+++ linux-2.5/arch/s390/include/asm/ccwdev.h
@@ -192,6 +192,7 @@ extern void ccw_device_get_id(struct ccw
 #define to_ccwdrv(n) container_of(n, struct ccw_driver, driver)
 
 extern struct ccw_device *ccw_device_probe_console(void);
+extern int ccw_device_force_console(void);
 
 // FIXME: these have to go
 extern int _ccw_device_get_subchannel_number(struct ccw_device *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
