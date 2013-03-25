From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 09/11] KVM: s390: Change the virtual memory mapping location for virtio devices
Date: Mon, 25 Mar 2013 17:22:56 +0100
Message-ID: <1364228578-20528-10-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Nick Wang <jfwang@us.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Nick Wang <jfwang@us.ibm.com>

The current location for mapping virtio devices does not take
into consideration the standby memory. This causes the failure
of mapping standby memory since the location for the mapping is
already taken by the virtio devices. To fix the problem, we move
the location to beyond the end of standby memory.

Signed-off-by: Nick Wang <jfwang@us.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/kvm_virtio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 6711e65..2ea6165 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -443,29 +443,30 @@ static int __init test_devices_support(unsigned long addr)
 }
 /*
  * Init function for virtio
- * devices are in a single page above top of "normal" mem
+ * devices are in a single page above top of "normal" + standby mem
  */
 static int __init kvm_devices_init(void)
 {
 	int rc;
+	unsigned long total_memory_size = sclp_get_rzm() * sclp_get_rnmax();
 
 	if (!MACHINE_IS_KVM)
 		return -ENODEV;
 
-	if (test_devices_support(real_memory_size) < 0)
+	if (test_devices_support(total_memory_size) < 0)
 		return -ENODEV;
 
-	rc = vmem_add_mapping(real_memory_size, PAGE_SIZE);
+	rc = vmem_add_mapping(total_memory_size, PAGE_SIZE);
 	if (rc)
 		return rc;
 
-	kvm_devices = (void *) real_memory_size;
+	kvm_devices = (void *) total_memory_size;
 
 	kvm_root = root_device_register("kvm_s390");
 	if (IS_ERR(kvm_root)) {
 		rc = PTR_ERR(kvm_root);
 		printk(KERN_ERR "Could not register kvm_s390 root device");
-		vmem_remove_mapping(real_memory_size, PAGE_SIZE);
+		vmem_remove_mapping(total_memory_size, PAGE_SIZE);
 		return rc;
 	}
 
-- 
1.7.12.4
