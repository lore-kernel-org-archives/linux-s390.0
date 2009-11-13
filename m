Return-Path: <linux-kernel-owner+w=401wt.eu-S1756598AbZKMPOc@vger.kernel.org>
Message-Id: <20091113150917.346507094@de.ibm.com>
Date: Fri, 13 Nov 2009 16:09:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 45/52] [PATCH] cio: add per device initialization status flag
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=144-cio-device-init-flag.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

The function ccw_device_unregister has to ensure to remove
all references obtained by device_add and device_initialize.
Unfortunately it gets called for devices which are
1) uninitialized, 2) initialized but unregistered, and
3) registered devices. To distinguish 1) and 2) this patch
introduces a new flag "initialized", which is 1 as long as we
hold the initial device reference.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |    6 ++++++
 drivers/s390/cio/io_sch.h |    1 +
 2 files changed, 7 insertions(+)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device.c	2009-11-13 16:08:22.000000000 +0100
@@ -304,7 +304,11 @@
 static void ccw_device_unregister(struct ccw_device *cdev)
 {
 	if (device_is_registered(&cdev->dev)) {
+		/* Undo device_add(). */
 		device_del(&cdev->dev);
+	}
+	if (cdev->private->flags.initialized) {
+		cdev->private->flags.initialized = 0;
 		/* Release reference from device_initialize(). */
 		put_device(&cdev->dev);
 	}
@@ -716,6 +720,7 @@
 		put_device(&cdev->dev);
 		return -ENODEV;
 	}
+	cdev->private->flags.initialized = 1;
 	return 0;
 }
 
@@ -998,6 +1003,7 @@
 		cdev = sch_get_cdev(sch);
 		cdev->dev.groups = ccwdev_attr_groups;
 		device_initialize(&cdev->dev);
+		cdev->private->flags.initialized = 1;
 		ccw_device_register(cdev);
 		/*
 		 * Check if the device is already online. If it is
Index: quilt-2.6/drivers/s390/cio/io_sch.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/io_sch.h	2009-11-13 16:08:21.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/io_sch.h	2009-11-13 16:08:22.000000000 +0100
@@ -167,6 +167,7 @@
 		unsigned int resuming:1;    /* recognition while resume */
 		unsigned int pgroup:1;	    /* pathgroup is set up */
 		unsigned int mpath:1;	    /* multipathing is set up */
+		unsigned int initialized:1; /* set if initial reference held */
 	} __attribute__((packed)) flags;
 	unsigned long intparm;	/* user interruption parameter */
 	struct qdio_irq *qdio_data;
