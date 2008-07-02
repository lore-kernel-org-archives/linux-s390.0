Return-Path: <linux-kernel-owner+w=401wt.eu-S1760508AbYGBP4i@vger.kernel.org>
Date: Wed, 2 Jul 2008 08:50:06 -0700
From: Greg KH <greg@kroah.com>
Subject: [PATCH 04/04] s390: Use s390_root_dev_* in kvm_virtio.
Message-ID: <20080702155006.GD31083@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com
Cc: Kay Sievers <kay.sievers@vrfy.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

No need to define a static device for the kvm_s390 root device,
just use s390_root_dev_register().

This is needed for the bus_id rework

Acked-by: Carsten Otte <cotte@de.ibm.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/s390/kvm/kvm_virtio.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -23,6 +23,7 @@
 #include <asm/kvm_virtio.h>
 #include <asm/setup.h>
 #include <asm/s390_ext.h>
+#include <asm/s390_rdev.h>
 
 #define VIRTIO_SUBCODE_64 0x0D00
 
@@ -236,10 +237,7 @@ static struct virtio_config_ops kvm_vq_c
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
@@ -256,7 +254,7 @@ static void add_kvm_device(struct kvm_de
 		return;
 	}
 
-	kdev->vdev.dev.parent = &kvm_root;
+	kdev->vdev.dev.parent = kvm_root;
 	kdev->vdev.id.device = d->type;
 	kdev->vdev.config = &kvm_vq_configspace_ops;
 	kdev->desc = d;
@@ -312,15 +310,16 @@ static int __init kvm_devices_init(void)
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
 
