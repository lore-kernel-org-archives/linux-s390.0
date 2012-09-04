From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 1/4] s390/kvm: Handle hosts not supporting s390-virtio.
Date: Tue,  4 Sep 2012 17:13:39 +0200
Message-ID: <1346771622-52763-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1346771622-52763-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771622-52763-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Running under a kvm host does not necessarily imply the presence of
a page mapped above the main memory with the virtio information;
however, the code includes a hard coded access to that page.

Instead, check for the presence of the page and exit gracefully
before we hit an addressing exception if it does not exist.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---

Changes v1->v2:

- check for the presence of the patch with lura
- reorder init sequence
- comments

---
 drivers/s390/kvm/kvm_virtio.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 47cccd5..76b95f3 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -419,6 +419,26 @@ static void kvm_extint_handler(struct ext_code ext_code,
 }
 
 /*
+ * For s390-virtio, we expect a page above main storage containing
+ * the virtio configuration. Try to actually load from this area
+ * in order to figure out if the host provides this page.
+ */
+static int __init test_devices_support(unsigned long addr)
+{
+	int ret = -EIO;
+
+	asm volatile(
+		"0:	lura	0,%1\n"
+		"1:	xgr	%0,%0\n"
+		"2:\n"
+		EX_TABLE(0b,2b)
+		EX_TABLE(1b,2b)
+		: "+d" (ret)
+		: "a" (addr)
+		: "0", "cc");
+	return ret;
+}
+/*
  * Init function for virtio
  * devices are in a single page above top of "normal" mem
  */
@@ -429,21 +449,24 @@ static int __init kvm_devices_init(void)
 	if (!MACHINE_IS_KVM)
 		return -ENODEV;
 
+	if (test_devices_support(real_memory_size) < 0)
+		/* No error. */
+		return 0;
+
+	rc = vmem_add_mapping(real_memory_size, PAGE_SIZE);
+	if (rc)
+		return rc;
+
+	kvm_devices = (void *) real_memory_size;
+
 	kvm_root = root_device_register("kvm_s390");
 	if (IS_ERR(kvm_root)) {
 		rc = PTR_ERR(kvm_root);
 		printk(KERN_ERR "Could not register kvm_s390 root device");
+		vmem_remove_mapping(real_memory_size, PAGE_SIZE);
 		return rc;
 	}
 
-	rc = vmem_add_mapping(real_memory_size, PAGE_SIZE);
-	if (rc) {
-		root_device_unregister(kvm_root);
-		return rc;
-	}
-
-	kvm_devices = (void *) real_memory_size;
-
 	INIT_WORK(&hotplug_work, hotplug_devices);
 
 	service_subclass_irq_register();
-- 
1.7.11.5
