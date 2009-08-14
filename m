Return-Path: <linux-kernel-owner+w=401wt.eu-S1756170AbZHNLbj@vger.kernel.org>
Message-Id: <20090814112619.838652300@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 31/34] vmur: Invalid allocation sequence for vmur class
Content-Disposition: inline; filename=130-vmur-alloc-sequence.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

The vmur class is allocated after the CCW driver is registered
and it is destroyed before the CCW driver is unregistered.
This is not the correct sequence, because the vmur class can be used
via driver core callbacks that are triggered during the CCW driver
deregistration. For Example:

1. vmur device is online
2. vmur module is unloaded

This leads to the following function call stack:

    <4> [<0000000000387286>] device_destroy+0x36/0x5c
    <4> [<000003e000209714>] ur_set_offline_force+0x9c/0x10c [vmur]
    <4> [<000003e00020a928>] ur_remove+0x64/0xbc [vmur]
    <4> [<00000000003e4d2e>] ccw_device_remove+0x42/0x1ac
    <4> [<000000000038a1aa>] __device_release_driver+0x9a/0xe4
    <4> [<000000000038a2da>] driver_detach+0xe6/0xec
    <4> [<0000000000388ee4>] bus_remove_driver+0xc0/0x108
    <4> [<000003e00020ad5a>] ur_exit+0x52/0x84 [vmur]

In device_destroy() the vmur class is used. Since it is already freed,
this can lead to a kernel panic.

To fix the problem, the vmur class has to be allocated before the CCW
driver is registered and destroyed after the CCW driver has ben unregistered.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/vmur.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -1026,9 +1026,15 @@ static int __init ur_init(void)
 
 	debug_set_level(vmur_dbf, 6);
 
+	vmur_class = class_create(THIS_MODULE, "vmur");
+	if (IS_ERR(vmur_class)) {
+		rc = PTR_ERR(vmur_class);
+		goto fail_free_dbf;
+	}
+
 	rc = ccw_driver_register(&ur_driver);
 	if (rc)
-		goto fail_free_dbf;
+		goto fail_class_destroy;
 
 	rc = alloc_chrdev_region(&dev, 0, NUM_MINORS, "vmur");
 	if (rc) {
@@ -1038,18 +1044,13 @@ static int __init ur_init(void)
 	}
 	ur_first_dev_maj_min = MKDEV(MAJOR(dev), 0);
 
-	vmur_class = class_create(THIS_MODULE, "vmur");
-	if (IS_ERR(vmur_class)) {
-		rc = PTR_ERR(vmur_class);
-		goto fail_unregister_region;
-	}
 	pr_info("%s loaded.\n", ur_banner);
 	return 0;
 
-fail_unregister_region:
-	unregister_chrdev_region(ur_first_dev_maj_min, NUM_MINORS);
 fail_unregister_driver:
 	ccw_driver_unregister(&ur_driver);
+fail_class_destroy:
+	class_destroy(vmur_class);
 fail_free_dbf:
 	debug_unregister(vmur_dbf);
 	return rc;
@@ -1057,9 +1058,9 @@ fail_free_dbf:
 
 static void __exit ur_exit(void)
 {
-	class_destroy(vmur_class);
 	unregister_chrdev_region(ur_first_dev_maj_min, NUM_MINORS);
 	ccw_driver_unregister(&ur_driver);
+	class_destroy(vmur_class);
 	debug_unregister(vmur_dbf);
 	pr_info("%s unloaded.\n", ur_banner);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
