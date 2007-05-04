Return-Path: <linux-kernel-owner+w=401wt.eu-S1031410AbXEDQwz@vger.kernel.org>
Message-Id: <20070504165242.072091897@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/9] cio: Deprecate read_dev_chars() and read_conf_data{,_lpm}().
Content-Disposition: inline; filename=010-cio-deprecate1.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

These helper functions are a leftover from 2.4 sync I/O and are a
notorious source for bugs. They lead to device driver specific code
creeping into cio, and some issues can't really be fixed at all.

Device drivers can easily implement those functions themselves in a
more robust manner, so let's get rid of them.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/feature-removal-schedule.txt |   17 +++++++++++++++++
 include/asm-s390/ccwdev.h                  |    6 +++---
 2 files changed, 20 insertions(+), 3 deletions(-)

Index: quilt-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- quilt-2.6.orig/Documentation/feature-removal-schedule.txt	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/Documentation/feature-removal-schedule.txt	2007-05-04 18:50:15.000000000 +0200
@@ -314,3 +314,20 @@
 Who:	David S. Miller <davem@davemloft.net>
 
 ---------------------------
+
+What:	read_dev_chars(), read_conf_data{,_lpm}() (s390 common I/O layer)
+When:	December 2007
+Why:	These functions are a leftover from 2.4 times. They have several
+	problems:
+	- Duplication of checks that are done in the device driver's
+	  interrupt handler
+	- common I/O layer can't do device specific error recovery
+	- device driver can't be notified for conditions happening during
+	  execution of the function
+	Device drivers should issue the read device characteristics and read
+	configuration data ccws and do the appropriate error handling
+	themselves.
+Who:	Cornelia Huck <cornelia.huck@de.ibm.com>
+
+---------------------------
+
Index: quilt-2.6/include/asm-s390/ccwdev.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwdev.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/include/asm-s390/ccwdev.h	2007-05-04 18:50:15.000000000 +0200
@@ -164,9 +164,9 @@
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
 extern int ccw_device_clear(struct ccw_device *, unsigned long);
 
-extern int read_dev_chars(struct ccw_device *cdev, void **buffer, int length);
-extern int read_conf_data(struct ccw_device *cdev, void **buffer, int *length);
-extern int read_conf_data_lpm(struct ccw_device *cdev, void **buffer,
+extern int __deprecated read_dev_chars(struct ccw_device *cdev, void **buffer, int length);
+extern int __deprecated read_conf_data(struct ccw_device *cdev, void **buffer, int *length);
+extern int __deprecated read_conf_data_lpm(struct ccw_device *cdev, void **buffer,
 			      int *length, __u8 lpm);
 
 extern int ccw_device_set_online(struct ccw_device *cdev);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
