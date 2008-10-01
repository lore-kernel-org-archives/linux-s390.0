Return-Path: <linux-kernel-owner+w=401wt.eu-S1755246AbYJAJAE@vger.kernel.org>
Message-Id: <20081001084127.513956461@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/21] Use s390_root_dev_* in kvm_virtio.
Content-Disposition: inline; filename=108-cio-busid4.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Kay Sievers <kay.sievers@vrfy.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

No need to define a static device for the kvm_s390 root device,
just use s390_root_dev_register().

This is needed for the bus_id rework

Acked-by: Carsten Otte <cotte@de.ibm.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/kvm/kvm_virtio.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: quilt-2.6/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/kvm/kvm_virtio.c
+++ quilt-2.6/drivers/s390/kvm/kvm_virtio.c
@@ -24,6 +24,7 @@
 #include <asm/kvm_virtio.h>
 #include <asm/setup.h>
 #include <asm/s390_ext.h>
+#include <asm/s390_rdev.h>
 
 #define VIRTIO_SUBCODE_64 0x0D00
 
@@ -241,10 +242,7 @@ static struct virtio_config_ops kvm_vq_c
  * The root device for the kvm virtio devices.
  * This makes them appear as /sys/devices/kvm_s390/0,1,2 not /sys/devices/0,1,2.
  */
-static struct device kvm_root = {
-	.parent = NULL,
-	.bus_id = "kvm_s390",
-};
+static struct device *kvm_root;
 
 /*
  * adds a new device and register it with virtio
@@ -261,7 +259,7 @@ static void add_kvm_device(struct kvm_de
 		return;
 	}
 
-	kdev->vdev.dev.parent = &kvm_root;
+	kdev->vdev.dev.parent = kvm_root;
 	kdev->vdev.id.device = d->type;
 	kdev->vdev.config = &kvm_vq_configspace_ops;
 	kdev->desc = d;
@@ -317,15 +315,16 @@ static int __init kvm_devices_init(void)
 	if (!MACHINE_IS_KVM)
 		return -ENODEV;
 
-	rc = device_register(&kvm_root);
-	if (rc) {
+	kvm_root = s390_root_dev_register("kvm_s390");
+	if (IS_ERR(kvm_root)) {
+		rc = PTR_ERR(kvm_root);
 		printk(KERN_ERR "Could not register kvm_s390 root device");
 		return rc;
 	}
 
 	rc = vmem_add_mapping(PFN_PHYS(max_pfn), PAGE_SIZE);
 	if (rc) {
-		device_unregister(&kvm_root);
+		s390_root_dev_unregister(kvm_root);
 		return rc;
 	}
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
